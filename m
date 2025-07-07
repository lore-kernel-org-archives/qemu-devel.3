Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9A6C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnYk-0004j5-Kd; Mon, 07 Jul 2025 11:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYn6r-0000sN-3m
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:46:26 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYn6n-0006Sy-Jd
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:46:19 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70f862dbeaeso28989777b3.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751899576; x=1752504376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fQmrWV2MYcDp5wbY35Ux/eWai62PUagKVxBYl1QOfrQ=;
 b=rUZEISkmRp4zuLvPxhV+d1u8wvDleSdyJvt2NyuU6QHit9wAyv/T0spAymu13bSn7b
 IKxk0YL4KOPljvcNDACRgkStKewC96o5HV6BD2BPAzy5F2RXTKcSl5babmZxuVmkpZFk
 anJrmfNSy8p4hwWNxHlPHKwxYPRlm0X78vS2Wl2eACctEk3PzNjyMexWy/z8SjalvFPU
 N5vo3SEBGOWTM1MgTDSixgOPpjRusGAmH6kGPG3iXZw7/rhco1Qb+K3rxtJFWOE+lBW7
 IFZIHYoDuQtujUaoiPhmcEsxGkrYWs7KJNLi8z7NZby0VKa+BXCxbxd1R6vu8gevRNOS
 nQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751899576; x=1752504376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQmrWV2MYcDp5wbY35Ux/eWai62PUagKVxBYl1QOfrQ=;
 b=tsh0ujtIRAUHTVClH3E798KtLN/pYNi9j22gAQ36LnfnE5BAxoISL2KDdDHi/EFY7o
 Lk0QV7fOrjy5nU45HoLI+oIpEYhQAVTh9eS0n24ybppejPbSVBYxm1xa4c/MjhqDo8Er
 PsYPkJZjTDAzDEcq0O67QnaR8SsfERkONGbrP/PdaUiJwFuJdd292ccV3FQASmBuCnmo
 nShu+KEQn11MJLo6/GuE4uqtLX56b9lTjWPwDMP/3Ipvz0Rat14UkDDDD8h5mTHk26A/
 L0euGkhjPTkdsXd47zxbRZZFTM75ABs8Xmz8xpQrhLUnmGYzBnAtIyoW8184KvHAhHmF
 0RJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB2vMzpKubkY8C314iMIWZ+WQvxysLzRm3/zZNf/pWF99UOvUb5TzoInfn2eiMUHCEXuJrRGgmmJEE@nongnu.org
X-Gm-Message-State: AOJu0Yxl/Ayp48g5jpJaJBtJ6ODGH5hG0c8QOjmJvbsFaH1J0e9NuT1J
 JY67n0JpfGPgdTKMrlqrhQYaz/t5zDFCImny4SaOf5V7SBvIvCt4SdUFU1r/QSt5v+3uoyIWCTv
 +tRszzBVWxVBz2gc88bSOSjHL+IC6GUQK5q4IqKix0g==
X-Gm-Gg: ASbGncv2xE69rdZ4fZ3amZMSKeFUb+mGqFe87+/0uaVpX+3mq4HbPrlmvuRcFu4tgsG
 0jL9Oz3U0Zxck/L5wzctAouXcf+0QEnVO2Fb0AnbX6/MRh/6ISBOfbnQWNMzCGOUHOZ8BkVz+O6
 XKlGskJYe18th07Rwv52PQ8hFDzsvuWaTvZRUy/qBzv3VC
X-Google-Smtp-Source: AGHT+IEwc/F+Pq942lV+e/NvvZLHZpxO7gyCNoYmoEz1atM5h0nRl9pzS2C76xZiEVqPlR2dz93E1aRKNK2Iyj+lP0g=
X-Received: by 2002:a05:690c:4510:b0:70e:719e:75e with SMTP id
 00721157ae682-71668c4d4c8mr139607637b3.9.1751899575801; Mon, 07 Jul 2025
 07:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-5-eric.auger@redhat.com>
 <CAFEAcA9hhdwHNrBfEqO4GD6kSb3Efcw-Rztq=CqvcOGMG3+z6A@mail.gmail.com>
 <9c78f7c0-88ce-4c4d-b6c0-5b77b4d83367@redhat.com>
 <CAFEAcA-qh5zPUY6q-TH3T8CCrD2KEfXNDrZbVzr2H-HX5n7sSw@mail.gmail.com>
 <86y0t09im1.wl-maz@kernel.org>
In-Reply-To: <86y0t09im1.wl-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 15:46:04 +0100
X-Gm-Features: Ac12FXxfPBDN2rvY5ldJ5dDu_l-U31kPD9osgZzrnsgMFDWo8-kpV4FrRhc6nnY
Message-ID: <CAFEAcA_fNzm1w_vccMv8q6QhyPFu+qSSq23+EyP==LCV0xWWSQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] hw/arm/virt: Allow virt extensions with KVM
To: Marc Zyngier <maz@kernel.org>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, miguel.luis@oracle.com, richard.henderson@linaro.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 7 Jul 2025 at 15:32, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 07 Jul 2025 10:53:38 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Mon, 7 Jul 2025 at 10:30, Eric Auger <eric.auger@redhat.com> wrote:
> > >
> > > Hi Peter, Marc,
> > >
> > > On 7/4/25 2:22 PM, Peter Maydell wrote:
> > > > I suppose the system registers probably generally Just Work
> > > > via the sysreg GET/SET_ONE_REG API, but won't the in-kernel
> > > > GICv3 have extra state that we need to migrate in
> > > > hw/intc/arm_gicv3_kvm.c ?
> > > Do you see some specific registers/resources that would need attention?
> >
> > All the EL2-only-accessible GIC registers: ICH_AP*R<n>_EL2,
> > ICH_EISR_EL2, ICH_ELRSR_EL2, ICH_HCR_EL2, ICH_LR<n>_EL2,
> > etc etc.
>
> It isn't obvious to me why we'd expose any of the status registers to
> userspace. ICH_{EISR,ELRSR,MISR}_EL2 are entirely synthetic, and are
> directly generated by the emulation from the rest of the state.
>
> Save/restoring this state would make things pointlessly complicated,
> unless I'm missing something obvious.

Good point: we don't need to expose those, only the actual
state-holding registers. I was rather mindlessly going through
and listing all the ICH_ registers out of the spec...

So should the list be:
 ICH_AP*R<n>_EL2, ICH_HCR_EL2, ICH_HR<n>_EL2, ICH_VMCR_EL2
?
(Those are the ones the TCG GICv3 has state for in its data
structures.)

How about ICH_VTR_EL2 ? I guess we should handle it the same
way we do other existing ID registers (migrate it
and write value back to kernel so it can validate that
the destination hardware supports the same config) ?

Speaking of GIC ID registers, we never updated QEMU to
handle the GICv4.1 GICD_TYPER2 register, so we don't try
to send and sanity check that on migration at the moment.

thanks
-- PMM

