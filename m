Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0CC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 09:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYiXs-00054f-J2; Mon, 07 Jul 2025 05:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYiXr-00053L-3H
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:53:55 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYiXo-0001J0-Sk
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:53:54 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e8986a25cbfso2115159276.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751882030; x=1752486830; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NnvM2dIpOH02lrnDpPaCpdjsI5HScEB3WhvLdCaXmG0=;
 b=kHXD1TgVpW/LE0Jg/HKoDjyiTE7KaPbL71VX6xW8v2oHCuQh7ApAD4iLjZfKvYREdn
 aKnF8h0S2SitKeL3GhvxKsq+0otFLplkOwonwA6umfCWIyrcsP/dlj27/+hu2op4qp2J
 gJuHQ/S17o90CGBTL5LFA3kl5mGRF5CCl+jClWxZ6C4ldPjR0fGoOIndKeKZpueVIgPx
 Dxt9b7E52aaCjAT6FasKgvsHihU6q7Dn1yON/RH7Sd26AQF5Cr3K32Y+GDOf6zrJr1QL
 27nxuxsotDFoFZBbcPkiAWUwolfbdX+cBo1QkbLYGiYQb+UERJuEF7mC+VMmKjeLrdpe
 fdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882030; x=1752486830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnvM2dIpOH02lrnDpPaCpdjsI5HScEB3WhvLdCaXmG0=;
 b=cUt6YolwD8j7DkpRxtmcGbSTS7MR9U9SU9OEBdxEZPNRuwQtx1jB8YfLGSzOWoD4R8
 Gn02stJ0bLscSP7775mllht897Mv+qfRnmJFZ/ElDn6gYSgwaseLkCKs3jK7YbAXTtvS
 r53BstG6KyeDq3a3E2IeX15Rhxn7inY9qkRQdiOf03GKifVboVWGX8jE/78jEoqyO3gp
 Ezp1cf0XGHgTbLRVg/njUVDhdjch7SpWWU3Ddz4UvzFw3rsE/mYSY4y2wDgcPLaYj7WC
 0kkv6VEoFGesY1Vur6R3byamRhh3zG4hPfzJc8yqqe7OVt2lX9h5gTi6PiqdWqmycaCT
 8i1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMqJNhC0HDybjUCCmGbdFkydSRXJhD12W5mMRgISJbHp11aqqMdGHa5PtcRmsTZz4QkeHunzvFX9Ji@nongnu.org
X-Gm-Message-State: AOJu0YyYIw/zJiRrqymA3HsoPwCZ3z5Uf68rEc7ePi63q/9al8vkTXqB
 hOUgwf7gnw+P4sx15GQhQVx/2rFEGD1Vqh5T/mWXMjrXf0iqMRUF3laNQq8yvsD9gGkQA5aKxJ0
 KZDaeYZA6YOiJgrJoy0T0Ncr3idI2vHmx1AAfgFR2Dg==
X-Gm-Gg: ASbGncv55DoLnGPhVb1Zh5YkVEya4Reb6a1z7rpAvP87u8nUlzyiGQV79trw6DEOINV
 MiJLaAPzMquoxYY9cn3h0NPbYxRgrlPbHvT+odoLXKE87OrDmegcKfz2K1G3CWIMlAo0sPyr4iT
 OGJWK4zDg874SmC8EghxPRowyxZPa5k+Zg59nOaXrvJWni
X-Google-Smtp-Source: AGHT+IH9XiDE1QfMKs2RfZLgP/ehmandYsw3Sq+auxXw4ZvDPnwHnURgZ4dLVAROXySvKOYdIYuJidYCfm+zLdObGcc=
X-Received: by 2002:a05:690c:680c:b0:6f7:ae31:fdf with SMTP id
 00721157ae682-71668c503e1mr166105957b3.12.1751882030581; Mon, 07 Jul 2025
 02:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-5-eric.auger@redhat.com>
 <CAFEAcA9hhdwHNrBfEqO4GD6kSb3Efcw-Rztq=CqvcOGMG3+z6A@mail.gmail.com>
 <9c78f7c0-88ce-4c4d-b6c0-5b77b4d83367@redhat.com>
In-Reply-To: <9c78f7c0-88ce-4c4d-b6c0-5b77b4d83367@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 10:53:38 +0100
X-Gm-Features: Ac12FXxTdtPiPch3Ue0HkrUBbDR5O4vyx7eZpsdiJzkqQ5Be_UJpp0Yj0gb20UM
Message-ID: <CAFEAcA-qh5zPUY6q-TH3T8CCrD2KEfXNDrZbVzr2H-HX5n7sSw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] hw/arm/virt: Allow virt extensions with KVM
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Mon, 7 Jul 2025 at 10:30, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Peter, Marc,
>
> On 7/4/25 2:22 PM, Peter Maydell wrote:
> > I suppose the system registers probably generally Just Work
> > via the sysreg GET/SET_ONE_REG API, but won't the in-kernel
> > GICv3 have extra state that we need to migrate in
> > hw/intc/arm_gicv3_kvm.c ?
> Do you see some specific registers/resources that would need attention?

All the EL2-only-accessible GIC registers: ICH_AP*R<n>_EL2,
ICH_EISR_EL2, ICH_ELRSR_EL2, ICH_HCR_EL2, ICH_LR<n>_EL2,
etc etc.

These all need to be exposed via KVM_DEV_ARM_VGIC_GRP_CPU_SYSREG
and hw/intc/arm_gicv3_kvm.c needs code to be able to save and
restore them into the GIC data structures (and we need to make
sure the kernel isn't accidentally exposing them as CPU registers
via the GET/SET_ONE_REG API, I think, in whatever way we do
that for the existing EL1 GIC cpuif registers).

I don't see any of the EL2 sysregs listed in the kernel's
gic_v3_icc_reg_descs[], which looks like it's what drives
the handling of KVM_DEV_ARM_VGIC_GRP_CPU_SYSREG.

I'm ok with just putting in a migration blocker for the moment,
especially if this needs kernel-side changes.

thanks
-- PMM

