Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F4C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 04:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMKQl-0005YL-Bl; Wed, 26 Jun 2024 00:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sMKQj-0005Xt-41
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:38:49 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sMKQh-0005M5-O8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:38:48 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W88931BqQz8PbP;
 Wed, 26 Jun 2024 00:38:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=wK6Pxk8pG4r1u1isNdr3J+yz8PfXaXzqtycU3/ZQXqg=; b=l605xYytWfTe
 Bp3b1ORZAficohgQ4JfrcBPU7Bi6xLxDIMC5LiAJFcnWnEqfyOCTSMEDeatqeSW7
 vY+mw5rWdRNLHFshD7c6j1xbHM+95MWZ3HhkZ+4/Ykm1ysNN/oK4WkYL3zawcK+m
 6xdoE4y93mh4TI391Cqu0g8o72CLXeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=P/n
 EDlcS/LGY7ZQgXydoy1YnOXWlKtOcz+A3bl1bZAjFLw91N83BOsq3oNnLVFlCF+Z
 UFBp3jaIJmZsHK2RKAgRE2pcZpgFH3CppvzZeCTX4X4aZgAkJek4cWFVJn9GBHvB
 PUSkdqrnAqrZ9rfQW7TyTChc+LQL4xLYlH9WHxmg=
Received: from [192.168.6.81] (172-97-210-189.cpe.distributel.net
 [172.97.210.189])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W88930ZFjz8PbN;
 Wed, 26 Jun 2024 00:38:47 -0400 (EDT)
Message-ID: <a1491c86-3711-4cb4-a6f4-7f586daf5a72@comstyle.com>
Date: Wed, 26 Jun 2024 00:38:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix building on OpenBSD/powerpc
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneCVxqGDjKpa5Jp@humpty.home.comstyle.com>
 <c8841c2f-3903-42ee-9bf5-2c74185dc007@linaro.org>
 <86abae67-79ba-487a-925a-de6a55f2b525@linaro.org>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <86abae67-79ba-487a-925a-de6a55f2b525@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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

On 2024-06-23 6:03 p.m., Richard Henderson wrote:
> On 6/23/24 10:53, Richard Henderson wrote:
>> On 6/22/24 19:03, Brad Smith wrote:
>>> util: fix building on OpenBSD/powerpc
>>>
>>> Signed-off-by: Brad Smith<brad@comstyle.com>
>>> ---
>>> =C2=A0 util/cpuinfo-ppc.c | 20 ++++++++++++--------
>>> =C2=A0 1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> r~
>
> Queued to tcg-next.


There was one minor change I wanted to make to this. Do I send a v2?


