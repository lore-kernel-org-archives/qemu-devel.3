Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEF2FC6189
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 02:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spIYT-0001R3-Pv; Fri, 13 Sep 2024 22:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1spIYR-0001OS-Aw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 22:30:31 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1spIYP-0006na-Ta
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 22:30:31 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4X5FWy4wptz8PbP;
 Fri, 13 Sep 2024 22:30:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=T+cI1NH3eE4pQQeIOW+KhfLzR1Rpv0noZccMMZsHU2w=; b=ecPvFuVWzVmR
 IGMrIVtcaiaY3R02WWs0h7xjOnMp2g6qkiENdCKmbeHSpN/01igG5KM0kfXc2XBb
 i1JwjcQfv+4PpJlLZUXOR0olXRtsOZZk05XQqd+QuHcKfjTzhcoSCfU5GFIKWfN0
 d7zGAav1kyNDwBqt2dNBkLcZCzjbWQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=QN+
 y6z7ZCV6Mjj2SWoYOy9DjheAFQ96S0+b4Fex6uC9994Cs1qvwKf5YgU57te/rONO
 5uJpZwDaGgfDfwtB5dqW8ekJBCXbFYkB/KEMFEHcUkidFSmJt5pWx6hLXwW6KI90
 vt0Ya4Lf5hn9jyNdbUJwIv1BmxwGzQ+B2gTHyi14=
Received: from [IPV6:2001:470:b050:6:f8d7:7028:459d:e17f] (unknown
 [IPv6:2001:470:b050:6:f8d7:7028:459d:e17f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4X5FWy22N3z8PbN;
 Fri, 13 Sep 2024 22:30:22 -0400 (EDT)
Message-ID: <81699a4a-1740-4b65-90d9-4f3ce8f48922@comstyle.com>
Date: Fri, 13 Sep 2024 22:30:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/qemu_test: Use Python hashlib instead of
 external programs
To: Brian Cain <quic_bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240910201742.239559-1-thuth@redhat.com>
 <1823ff97-b305-453b-b3a6-b24cc1987002@comstyle.com>
 <ce4daa98-0b3c-426d-95e0-59320eb29be8@quicinc.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <ce4daa98-0b3c-426d-95e0-59320eb29be8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024-09-10 10:06 p.m., Brian Cain wrote:
>
> On 9/10/2024 5:26 PM, Brad Smith wrote:
>> On 2024-09-10 4:17 p.m., Thomas Huth wrote:
>>> Some systems (like OpenBSD) do not have the sha256sum or sha512sum 
>>> programs
>>> installed by default. Use the Python hashlib instead so we don't 
>>> have to
>>> rely on the external programs.
>>
>> On OpenBSD they're named sha256 and sha512.
>>
> Rather than port the test to each OS's particular program names, we 
> should use the portable solution that's included w/Python.

I wasn't trying to imply that the patch wasn't the right direction, it 
is when it comes portability. Just commenting
on what it says in the commit message. This isn't the first time such 
differences have come up.


