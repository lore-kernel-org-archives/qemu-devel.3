Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7472C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgP5-0004sC-3f; Wed, 05 Feb 2025 09:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgP3-0004ri-Sp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:29:21 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgP1-0003n5-A2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:29:21 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso12598133a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 06:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738765757; x=1739370557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABrG6OgvFBH4JAkPVWSztqDYVOfUGou0fbuuKRa/r0E=;
 b=hCj8wlr7f4tOWyO2MeKaeK4wo0e0ObylJCmaiJIvItEXLd935/UZjO307rBYH7wjeP
 m6cDNBpxgM3iFB06sTpAD+f0DT3F2dskICrE6/c2l7au0UXBOphmDmvUjcdCFlkHR5/a
 m4dODiWu/d+ngLMCcY44iKUngBvP50If+JCbm8mkTngMcJdJ2abpzrKJKknjTSxRj1+4
 r5QU2ASo0jAGDcjqdQ95CDC0nMXNwQAm2l1E7LSOCRNGqL1pqRRgrZpN5BBj6RYK2dkU
 79BIPXCTf4phlEeHLU42SsG0Ox38ab/c1oGAuxF/bzDwZKBAbXVaGn3UhF6kH666Shnj
 IAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738765757; x=1739370557;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ABrG6OgvFBH4JAkPVWSztqDYVOfUGou0fbuuKRa/r0E=;
 b=aOAJcw3u5AgelH2ofjVccGUSaqCHjzxkYLxn84+qcbaa6+cWIjWwJSlbX2rvWujsOD
 roHLkstp2JP93S6LXv+OI8qdno7//gtoCFI8jtby2cjiy1qObAHEADZZFLbRXkSw+Zfy
 4nRD1pFJxGjdRLe7A/zil75Xwh4+bV7ru684tZDhCaa5Zsm7mB6BHWUwzVCTnPh+1dQh
 meEJhTawEHetUb6mYzE8wIMevwVgeAEt7wH/rpGbFiA9yodmLVEwTdyHphGcaRIseFZB
 2yB4iRdirFvo6dPVhNGeXwhG4viK2mmVvKxnghZfoUNY+fGLQMEHFC9KTGEPHya+uysY
 RSXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjGYv7WRblPV9V6cBmzceJvQMFwqqFcqvhk34tRmJEs/FbZQTFhuE7nbb6Bpn3b1jm8ry8ibC5iar1@nongnu.org
X-Gm-Message-State: AOJu0YzCKVHnUEEMauMradoW6r2JtjBkRd4T7swv44jSgVpHf/SlSxf0
 xlQvni5w/Hl7D0+rOVuFyO3cEKYImNCtzI2qWvohfXTrQV+8w5nUVud1H7ZCTmc=
X-Gm-Gg: ASbGncugdEz4G85aJpq//ysBkj6wjmY06uFXPepsXsLq9bb7YbdrvnQ9Ns3L5Id3stz
 A20EAwokgqbpShP65Tbkb1J6JhzcDR/CgIU/3iKKpa/g5fRJcqisGgxpvE/wxvMyKdzoiZ0cbLI
 ceBPIGes34Og1s0udG68fp+hB0vtNCKO5Pafq0v7UThLLPbCBOJI2pybmG6EDosveMh3OMFPBb4
 R1Lu2Dgbpq/yJIDYipWCLJHwOz6fFjA9HCjTbxn19mqGG/MoN3ZUHPhkspXWtbwLadc6+SFBbhg
 HkzoxDqzQHvog0CqTg==
X-Google-Smtp-Source: AGHT+IHJy7ZtvZSMsn5y4p+F05wcAhrsSXEXamWGphKQFzwkvHEgWIyaOAIsAri2HVKloTJ4uqsjeA==
X-Received: by 2002:a17:907:7f8d:b0:ab6:f59f:5427 with SMTP id
 a640c23a62f3a-ab75e21dd2emr306199266b.11.1738765757135; 
 Wed, 05 Feb 2025 06:29:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab74fb5996esm268196266b.106.2025.02.05.06.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 06:29:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B950A5F90B;
 Wed,  5 Feb 2025 14:29:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 06/14] hw/intc/arm_gicv3_cpuif: Don't downgrade monitor
 traps for AArch32 EL3
In-Reply-To: <20250130182309.717346-7-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Jan 2025 18:23:01 +0000")
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-7-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 14:29:15 +0000
Message-ID: <87y0yk8nyc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In the gicv3_{irq,fiq,irqfiq}_access() functions, there is a check
> which downgrades a CP_ACCESS_TRAP_EL3 to CP_ACCESS_TRAP if EL3 is not
> AArch64.  This has been there since the GIC was first implemented,
> but it isn't right: if we are trapping because of SCR.IRQ or SCR.FIQ
> then we definitely want to be going to EL3 (doing
> AArch32.TakeMonitorTrapException() in pseudocode terms).  We might
> want to not take a trap at all, but we don't ever want to go to the
> default target EL, because that would mean, for instance, taking a
> trap to Hyp mode if the trapped access was made from Hyp mode.
>
> (This might have been an attempt to work around our failure to
> properly implement Monitor Traps.)
>
> Remove the bogus check.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 359fbe65e01e ("hw/intc/arm_gicv3: Implement GICv3 CPU interface re=
gisters")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

