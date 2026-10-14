Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438FDCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Lm-0003BW-43; Wed, 14 Oct 2026 16:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xH5LE-0002xA-TE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:12:49 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xH5LB-0004aX-MD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:12:47 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4j4j6r2HP8z8PbP;
 Wed, 14 Oct 2026 16:12:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=h5WT1tHiRXsCBaGtG0sSHcAtb/tRqDGMNZ3UL3OCMFo=; b=Gg/UmlLJod98
 c5p0bqD9CsMeac4BbCiznKd/dQIS0Ti/zMDlEuJgHkzg7NEsi8Pm9LRQAY6DYZBn
 jYFSvN5MK5EQM2sAwHVCDrYWZlgmh+gZjCl3eOzXaq4BrfeMq7cdw9dii4iyZo6u
 ZScd4i0QMekkib8aLuXvAFCGxAqUdto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=JwR
 pXqRaPAyDG2CLXMYfvLOILzYUvleoVqejaw9dnxsnxVozusdP7you+g/IMu81qhp
 DVdACy5h3+znJlZ6Zz4ViaVc766lBtCpIoaiMCzYcmQuPsJC9hYZwKbWhL5PvUGZ
 RBApIpyOspV6qJHspRxg+rLa9xByEcIXXbWzSbFs=
Received: from [IPV6:2001:470:b050:6:10b5:50c5:b737:d938] (unknown
 [IPv6:2001:470:b050:6:10b5:50c5:b737:d938])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4j4j6r1hmfz8PbN;
 Wed, 14 Oct 2026 16:12:36 -0400 (EDT)
Message-ID: <fbc18336-5e10-48b4-978e-8d6078790b24@comstyle.com>
Date: Wed, 14 Oct 2026 16:12:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: do not attempt running hwclock(8) on BSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20261014112040.70284-1-bogorodskiy@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <20261014112040.70284-1-bogorodskiy@gmail.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-10-14 7:20 a.m., Roman Bogorodskiy wrote:
> Currently, qmp_guest_set_time() sets system time using
> the settimeofday(2) system call and then runs the hwclock(8)
> util to set hardware time.
>
> BSDs do not ship hwclock(8), so current implementation
> always fails while trying to run it.
>
> Update the code not to run it on BSD. The settimeofday(2)
> call sets both system and hardware time on these systems.
> For example, on FreeBSD settimeofday() calls settime()
> which calls resettodr() [1] which updates RTC clock [2].
> It is similar on OpenBSD and NetBSD, though implementations
> differ a bit.
>
> Additional detail: on FreeBSD RTC clock setting can be
> disabled with the `machdep.disable_rtc_set` sysctl.
> As we cannot do anything about it, do not handle that
> case separately.
>
> BSD systems do not provide a common utility equivalent
> to hwclock -s, so report an unsupported operation when
> no time is supplied.
>
> 1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
> 2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>   qga/commands-posix.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 837e285b6d..f3d18e6dcd 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
>           }
>       }
>   
> +#if defined(CONFIG_BSD)
> +    /*
> +     * BSDs (FreeBSD, OpenBSD, NetBSD) do not have the hwclock(8) tool.
> +     * These systems update hardware clock when settimeofday() sets
> +     * system time, so no additional actions are needed.
> +     * Setting system time from RTC is not supported.
> +     */
> +    if (!has_time) {
> +        error_setg(errp, "Setting system time from RTC is not supported");
> +    }
> +
> +    return;
> +#endif
> +
>       /* Now, if user has passed a time to set and the system time is set, we
>        * just need to synchronize the hardware clock. However, if no time was
>        * passed, user is requesting the opposite: set the system time from the

The command is Linux specific so it shouldn't be checking CONFIG_BSD. It 
should be
using something like #ifndef CONFIG_LINUX.


