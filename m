Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3819CE99064
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB8H5-0008Eh-Ph; Fri, 10 Apr 2026 05:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wB8H4-0008Cv-7x
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 05:35:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wB8H2-0001n6-Ob
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 05:35:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so1090969f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775813734; x=1776418534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7C9hC6oP3HzpI0ngIK4XeOqugtTl46bkPiAd+X+8QzE=;
 b=nB6G94NDdNRuKgTn/tpMz447RkIRrfYFSAhRkwywhOJk5hmD+4x+/1spo0M05rBMcD
 D2luNtDQXc8wMR95U3n6zy/D4LdKWD0wdJpVq6qjR59fGclCTTFmgoXa8vQA7fTxKg+A
 JPXr1EwjGkRQaeC306a2zE6zjebl0pQjUjVED2Th4GRNOHGs9SQKbhPFsD2X0kPKAvtU
 MkP06ldVYC4DJpCLFAKFdNoemR96A2LJqbydrD+eeo/JBcXZbKd7/Q9zmJ2yb7J2ljPz
 yoM2SuwbQExFz95zNjr0WdenmOd4at7coBmy/NW1erI4E7+Jj1iKttILpY++4do3vd2b
 qQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813734; x=1776418534;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7C9hC6oP3HzpI0ngIK4XeOqugtTl46bkPiAd+X+8QzE=;
 b=WqzVB2v+t57cW1S223a7ToayRPySogNtKXTzaYAPr3B2VtUsSL9lrE2qkeo9B4u7vn
 zkK+QVVE7ViWCT/NRqrGTSgncot826w3PiFteFNGaj1nUrkdnIuffM6bViykV3vX15A5
 IfBcS7/JWgyGNPfJVN7gd+AYzMzXnf5idzKHUe3ZhM38nN5fIqbIO/qE8J993M4ngL7a
 ZXg087g6IM277+pzsqpnfcLzl70kQCVxEGnAZj7W6hWWAtHU7eeMpY53ZZY0TC0eddQa
 38dGItWbXe+1iK3LdWL81kekXhJwubQWmAq9DEZfy6DjIUe9lzP2SHASLE7RzTt1rXRU
 g2AA==
X-Gm-Message-State: AOJu0YxA76ckvf11LQCfLWl4+8j70hugwFhuW+iz4J6k3xJs+b5Y1mqt
 d2iOis5MepnrxRzOXhWCfsAeaMMOfgkDG4FxX9LWPUNx4JBwLpnLe+d15lSFvRc1zn8=
X-Gm-Gg: AeBDiev2FLzbsMdfq6dcmoaNW/iJjbkDAuPu52jMmTF7aS5M6VeL5GJsTOU1L3XAid8
 m+89RVHool3Uf0rAr+0/prya69PnIUOAiGRn39BbMY30lUOpk65ZH3EZ15akXCWaJcDyECSAidN
 1cHY19trzVSp2bASIXYQbRDQ5zRR3M6YPTKg5NkP3vfnIu34bbEENrLYXp2qB+R2/FavSTnaIV0
 LfXvy6XUWBofxNsi389eoWlg/9OKzQ4ylw446fr7Hb+DumUJIXoW8p7/inOtbfYFpXEbXnQMY4P
 WxMJT8oiNTcoiLykJ+pX+1TG8xO7fBsQ/qE8GN3akB5+eaYt+cSWwqVNb0J/DAXKtMi3ihwsGVP
 BN7j9wHuWL6Bu4QejOIhd5As4fwKoPJ6hsHsIannv3mwL2EeCyHU1ewsu1S6rin9M8roiawNylU
 q6lee/r0GSNsLw3CqcX9jgC+U=
X-Received: by 2002:a05:6000:2408:b0:43d:1c75:db70 with SMTP id
 ffacd0b85a97d-43d642537a8mr3499576f8f.15.1775813734403; 
 Fri, 10 Apr 2026 02:35:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63ab84cdsm6186656f8f.0.2026.04.10.02.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 020CC5F830;
 Fri, 10 Apr 2026 10:35:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org,  Pedro Barbuda <pbarbuda@microsoft.com>,  Mohamed
 Mediouni <mohamed@unpredictable.fr>
Subject: Re: [RFC PATCH 24/35] target/arm: remove event_register check from
 arm_cpu_has_work
In-Reply-To: <CAFEAcA83X2v6iTQO-r-xp-sRku+KNQb56QhLtvgiCMpOxqFCyw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 10 Apr 2026 09:47:36 +0100")
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-25-alex.bennee@linaro.org>
 <CAFEAcA83X2v6iTQO-r-xp-sRku+KNQb56QhLtvgiCMpOxqFCyw@mail.gmail.com>
User-Agent: mu4e 1.14.1-pre1; emacs 30.1
Date: Fri, 10 Apr 2026 10:35:32 +0100
Message-ID: <87h5pjjgyj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 20 Mar 2026 at 13:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The generation of events are not indications of work to be done and
>> importantly for the case of WFI instructions not a reason to wake up.
>> Remove the check.
>
> But an event *is* a reason for WFE to wake up, which is why this
> check is here. In particular, the thing that tells accel/tcg
> that the CPU should come out of halt (via cpu_handle_halt())
> is whether cpu_exec_halt / cpu_has_work returns true. If we
> don't check the event register here then another CPU setting
> the event register won't cause this one to come out of WFE.

So for the same-CPU case we do because we signal cpu_interrupt(cs,
CPU_INTERRUPT_EXITTB) which is enough for has_work to return true but I
can see the failure mode for cross-cpu SEV's when we kick all vCPUs in
the helper would get stuck.

> If we want to have WFE and WFI wakeup events to be separated
> such that only WFE wakeup events resume a WFE and only
> WFI wakeup events resume a WFI then we need to do something
> more clever here, so that we track whether we're halted for
> WFI, WFE, PSCI-power-off or whatever and our has_work function
> can check the right condition.

I guess we can add a cpu->halt_reason? I've already had to add a
cpu->waiting_for_event for arm_wfxt_timer_cb and I guess it would be
better to generalise that.

> (Side question: are the only
> cases where our arm CPUs halt WFE, WFI, power-off, or are
> there any others I forgot about?)

The only others I can find are debug events which all have their own
logic (and we don't have "external" debug events modelled). YIELD is
still a NOP and not really a sleep.

> Incidentally, looking at the code above it will need fixing
> for A-profile anyway, because a CPU in PSCI-power-off should
> not be woken up by a WFE event. We get away with doing the
> WFE event register check first because M-profile doesn't use
> the PSCI powerdown stuff.

Ok, that seals it.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

