Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BF8C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdL-00051k-Fr; Tue, 21 Jan 2025 06:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1taCdI-00051P-JB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:24 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1taCd7-0003K7-Ft
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5a2a:0:640:6073:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 65AC460F4D;
 Tue, 21 Jan 2025 14:41:01 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b70b::1:2e] (unknown
 [2a02:6b8:b081:b70b::1:2e])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xeUHc51IbKo0-bnULOYTk; Tue, 21 Jan 2025 14:41:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1737459660;
 bh=NEjROP6mb/aATCYeNsKNDq/xgTCQPlIEJL65p08l7aA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FlNnFWZu+MnVAaqf4RjHiVPeQ47GZriyIu5OK15FiospoNY4OnBYOdsst1MwzXX27
 hbF4VEburUlnVFaJzd51i5D9aXXp2dcWaqjfyxFf7u3QyKpnvroQTBk4zxKn7EF8SJ
 yf6Nw1jJKzepUCwc3IS8oHLMYAGyPU0btAaK4DIg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1b86788b-d366-4c1c-bbca-246d0dfcc0c6@yandex-team.ru>
Date: Tue, 21 Jan 2025 14:40:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] overcommit: introduce mem-lock=on-fault
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
 <20241211230433.1371327-5-d-tatianin@yandex-team.ru> <Z1sNV-kHCJw9S9Di@x1n>
 <b5ec2f53-4a03-499b-be17-49729a6efca9@yandex-team.ru> <Z3_aoLOjzQ8M0h81@x1n>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z3_aoLOjzQ8M0h81@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/9/25 5:18 PM, Peter Xu wrote:

> On Thu, Jan 09, 2025 at 11:47:40AM +0300, Daniil Tatianin wrote:
>> On 12/12/24 7:20 PM, Peter Xu wrote:
>>
>>> On Thu, Dec 12, 2024 at 02:04:33AM +0300, Daniil Tatianin wrote:
>>>> Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
>>>> anonymous memory with a write-fault, which introduces a lot of extra
>>>> overhead in terms of memory usage when all you want to do is to prevent
>>>> kcompactd from migrating and compacting QEMU pages. Add an option to
>>>> only lock pages lazily as they're faulted by the process by using
>>>> MCL_ONFAULT if asked.
>>>>
>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Hi there! This series has 2 reviewed-bys, is there any way you could queue
>> it?
> I think this part belongs to mainloop/posix.. so maybe Paolo?
>
> Also copied Phil and Peter Maydell.
>
Ping :)



