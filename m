Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C59C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqZyU-0001Dm-FP; Sat, 30 Mar 2024 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqZyF-0001BF-B9
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:46:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqZyB-0006Qu-38
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:46:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so6282356a12.1
 for <qemu-devel@nongnu.org>; Sat, 30 Mar 2024 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711809963; x=1712414763; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nNPc0eeoM57+4ZxGVd2Kl1v5HU4Qrp3mNQIggcCRaf0=;
 b=P9aVEoenuY7BivVUiR19nMXjyr2OZuFoEVFsyhZG/5i7LbEquEFdXM95ZzxHd/bgOC
 6+jVS44a0U/2FHIjDe7nUith3ubcesGWQqsxPH0ktUywGO6VZKHk1YJ1eI6jsf8EIc+D
 GUK0dVLt78N3hDnwiemblwyKVidi9/O+r4uKBPiRZdVe+wGeb0HK8w8kRf61r/PTjbZc
 aZEs8+G5u0YCEm1D6B7XtTcsKhJZKqOCwSeVkaIoVO4hVxSgd141xAlH2y0VN0wv7iLk
 r779TN8tspw8gKo9tGJRzOBKcfla6ovMrocTK4HDe5E14PR9XahNu3frDR+LZvCAAUK/
 4ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711809963; x=1712414763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNPc0eeoM57+4ZxGVd2Kl1v5HU4Qrp3mNQIggcCRaf0=;
 b=gtmLCh1HUZB1jiScCQpioLd9AcJyvsjuEVOi3ORCbvp3rdEpR8XvXpSQTIRhmufNPo
 KHdl3lMdXLNuSFlb9zP3G3lnlRsbE9by8G+zpWyGBmm1lYdbytiw0DrpKN/zPcCMjV1q
 5DMARTe+JlsNJur63feMvXuZoXG2ZfvNtKn8A6sIwGGyEL8xz2V4165q/Asghaiip3nr
 8bLrXHRngkPMHqa2yyYpvN7wPUZIMOln9fREZ7DHC56axVqrCWa6FLRnGWn2Sjb8Pwe1
 oGi+o6/LSBc45w4ReHx6R9IcFPIE5DKmPktpynXX08mcWxxgk7U/bvxkhey1gX/QFSVf
 obIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTDePoLDorirQ74MZi62qe+SypBBCLdHaMz3fScQmpIuRK4cdGjmRivIRNnHMPlvw3KXooILfXDhx89OgwhHr6DyS4/Dg=
X-Gm-Message-State: AOJu0Yzj+ERDz8vdIr+ZPTAjVMplQ4PyAtnlXxdWRPtvZQapCwzZEtp4
 uOjR6JNep3wSZgRHglJN7qCaLHCLZzHFa6GRdQOaaR0+2BCRceFDOoxM4hCzv2vw2lYOKCdvjSp
 8BsRXp7VQxtGzbJw3PRky9NkNtoTEcSxR+wvbyg==
X-Google-Smtp-Source: AGHT+IEj1ygP7bbOwwR4nuHueRT81m7XdQl5iZpsmbSm4+Do3DL45F2/XmufnAyz15IhF4j3e7z/F0J0bxG+9rDUURI=
X-Received: by 2002:a50:a401:0:b0:56b:aa17:813a with SMTP id
 u1-20020a50a401000000b0056baa17813amr3558727edb.21.1711809963061; Sat, 30 Mar
 2024 07:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-15-ruanjinjie@huawei.com>
 <CAFEAcA9go1xe+UOBjH64nsRx-n6Tz3sp71qjb0Je=9r8nHBbuA@mail.gmail.com>
 <88013343-6734-272b-c5c1-a12878b8a9b7@huawei.com>
In-Reply-To: <88013343-6734-272b-c5c1-a12878b8a9b7@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Mar 2024 14:45:51 +0000
Message-ID: <CAFEAcA--iRQiGby22gUg51X6udJ_7tRG6d-Bf125b5RTUJBN_A@mail.gmail.com>
Subject: Re: [PATCH v10 14/23] hw/intc/arm_gicv3: Add irq non-maskable property
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 30 Mar 2024 at 01:42, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/3/28 22:54, Peter Maydell wrote:
> > On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>
> >> A SPI, PPI or SGI interrupt can have non-maskable property. So maintain
> >> non-maskable property in PendingIrq and GICR/GICD. Since add new device
> >> state, it also needs to be migrated, so also save NMI info in
> >> vmstate_gicv3_cpu and vmstate_gicv3.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> v10:
> >> - superprio -> nmi, gicr_isuperprio -> gicr_inmir0.
> >> - Save NMI state in vmstate_gicv3_cpu and vmstate_gicv3.
> >> - Update the commit message.
> >> v3:
> >> - Place this ahead of implement GICR_INMIR.
> >> - Add Acked-by.
> >> ---
> >>  hw/intc/arm_gicv3_common.c         | 44 ++++++++++++++++++++++++++++++
> >>  include/hw/intc/arm_gicv3_common.h |  4 +++
> >>  2 files changed, 48 insertions(+)
> >>
> >> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> >> index 2d2cea6858..be76ae0be6 100644
> >> --- a/hw/intc/arm_gicv3_common.c
> >> +++ b/hw/intc/arm_gicv3_common.c
> >> @@ -164,6 +164,24 @@ const VMStateDescription vmstate_gicv3_gicv4 = {
> >>      }
> >>  };
> >>
> >> +static bool nmi_needed(void *opaque)
> >> +{
> >> +    GICv3CPUState *cs = opaque;
> >> +
> >> +    return cs->gic->nmi_support != 0;
> >
> > nmi_support is already a bool, so you can
> >        return cs->gic_nmi_support;
> >
> >
> >> +}

> >> @@ -238,6 +260,24 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
> >>      }
> >>  };
> >>
> >> +static bool needed_nmi(void *opaque)
> >> +{
> >> +    GICv3State *cs = opaque;
> >> +
> >> +    return cs->nmi_support != 0;
> >> +}
> >
> > You already have nmi_needed() above, so you can use it
> > as the .needed function for both vmstate struct definitions.
>
> The input opaque pointer seems not same, one is "GICv3CPUState *", but
> another is "GICv3State *"

Oops, you're right. In that case let's give these two
functions names that hopefully guide the reader towards
the difference, like gic_cpu_state_nmi_needed() and
gic_state_nmi_needed().

thanks
-- PMM

