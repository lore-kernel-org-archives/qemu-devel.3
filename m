Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82DBC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 20:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXQgB-0001zs-My; Thu, 03 Jul 2025 16:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uXQg6-0001zB-GQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 16:37:06 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uXQg4-0003BF-5h
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 16:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=lgZ/qVbfVAF+QMDrPtbnt481WZXyKpazgQw1O0DkOP8=; b=lcBgawtYDHp6jAdF
 7TI50nFv7to0RSpxhhvod8AIfDEp2qNIK0DCgyPdK5+ObZd7wMtiL2ByfZm+AdwV3MAfiQqAPOh5B
 GJ+LCbw2sgE/y80h4OHvxesDRD2N9MShr8/T+MvHRukg4Lu6FjdSXaGlGOz5BP6tutDfNw39hzA65
 SAykcQrpcbgPIKMX0YFHErsyCy5t5ciwcvYkuVExljC2Dwp57gaZZLnnb5xWWa5Kn46waxsbtyDUC
 UA94XwLCkKLb2dzVl8dAU8y/UVtcE5KdFh1YhrVzumNvGDXoAqm5lhfYw2OY2u2IPxPRe4O7i5JQV
 gCYAaEyJpKaE8lx4OQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uXQfy-00Dyz2-16;
 Thu, 03 Jul 2025 20:36:58 +0000
Date: Thu, 3 Jul 2025 20:36:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Controlling time in QEMU
Message-ID: <aGbp6onOanCKHzl9@gallifrey>
References: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:30:27 up 67 days,  4:44,  2 users,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Pierrick Bouvier (pierrick.bouvier@linaro.org) wrote:
> Hi,
> 
> I recently needed to slow down time within a virtual machine, due to a
> timeout being hit because my QEMU binary which was not fast enough (gcov
> debug build if you're curious about the use case).
> 
> Currently, people tend to use -icount shift=X with low values for that, as
> it roughly maps time to how many instructions were ran.
> As well, I've been working on ips (Instructions per second) plugin [1],
> which allows to slow down QEMU execution by sleeping, as suggested by Alex.
> It's using a new clock update API [2], that is limited to move time faster
> (jump to future time), but not slower.
> 
> After looking at how all this implemented, I am wondering why we don't
> simply fake real time QEMU is using as a reference, which is based on
> gettimeofday [3].
> 
> Using faketime, which fakes gettimeofday I've been able to manipulate QEMU
> time:
> - faketime -f '+0 x10' qemu-system-aarch64: boot timestamp is 14s
> - faketime -f '+0 x0.1' qemu-system-aarch64: boot timestamp is 0.13s
> In both cases, the real boot time (QEMU execution) is around 3s.
> 
> It works as expected, speeding or slowing execution without impacting QEMU
> speed itself, which can run without needing to do any artificial sleep or
> clock manipulation. If a program in guest vm sleeps with an absolute time,
> it will be multiplied by the factor, which results in significant slowdown.
> But it can't be avoided, by design.
> By using a time factor big enough (x200), it can even trigger rcu_preempt
> stall detection in Linux guest kernel.
> 
> As it seems a bit too good to be true, time for questions:
> - Has it already been considered?

Not that I'm aware, but there are a couple of things you might find useful to look
at; there is the'driftifx' option with the suboption 'slew' and the LOST_TICK_POLICY
flags (and option?) - I've never looked into how they work, but they're intended
to correct qemu time slowly in some cases - maybe it's a hint to places to glue
such a hack in?

You talk of using 'sleep' to slow the CPU down, however there is some code
in migration to slow CPUs down (but not clocks) to limit the rate at which
they generate migration data.   I think it's more subtle than a simple sleep,
running something on each CPU thread to sleep.

Dave

> - Any obvious downside I might have skipped?
> - Would that be interesting to offer such a feature in QEMU itself
>   (-time-dilation 0.10)?
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/72db6d54a4a9203736261fc63f32f6cd3486b7e4
> [2] https://gitlab.com/qemu-project/qemu/-/commit/847a65dd76bf1868c7966a2b2608dcd00cb68dc7
> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/include/qemu/timer.h?ref_type=heads#L809
> [4] https://github.com/wolfcw/libfaketime
> 
> Regards,
> Pierrick
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

