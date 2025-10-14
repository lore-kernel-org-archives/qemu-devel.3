Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0693ECCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8g1M-00017X-Ob; Tue, 14 Oct 2025 10:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8g1K-00017N-By
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:28:58 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8g1G-0007R1-TM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:28:57 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-73b4e3d0756so59474427b3.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760452131; x=1761056931; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+rBB/9U8imZ6On4mDqH5S940xr77tvzwwirjZTk+LWs=;
 b=HzeXXEq9g9qXeZvGf7Ezhmyzb9zw96cD1dL2PcDbJC11yhZHq8ZWdZFJctPExuKCJw
 YXdnSHkyWDVX/XvBDGlW9AoYHbMCGnO60BHPpxardHVVSuBCh1Id/GM2SbT7hIbQIJFd
 R7xtZ5Y0Is37JkKXL7+m7u+ewXFQvE8yWFMM8akVbyf95hjs80tHv5+8a8Ww5OkNEkLZ
 AL9cMmi+iJs00TV58sgKDk30Mr4D1jEAOq8TPVCUBp8LWzblJ6saQDa/djo4SKJzIotx
 IhdM5N5n8dZezHRs9ZoasFI9ltyOM0trSJIijIBnHo1vSPbkT1bK018aeV/N+ggf7j4l
 Df8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760452131; x=1761056931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+rBB/9U8imZ6On4mDqH5S940xr77tvzwwirjZTk+LWs=;
 b=o2nblqELOoVMOFvuN7QWcu+OWLBZ6nK5nqn2pPIIohoNE3GJD1MDHvFzw6mzXSD1zH
 LCiZvEbXWBBBWgXSs20SmR3DpmhCGrpnFBrxC5KQ7p1Bj2gfOuqxQpW3lgH4WqAMWTnb
 VmgVW2lisOuqlPgmVFQHt4d/3Ai4J301dlTUMhgtl7NiBPWZuGHczZ+wBDn8+Brg7+qg
 UiWSYuBvkqRh67x28a0+aGNpX4mF91xM95tvRtst1kkdRwOu9YAuJluJ5XhebV4Wn+cm
 tlpHVuILDX17YDUkggw4dRAby42P7CEDOxW+rczmqmGS90HMycOGc5TTnKVnIsajuv41
 fVgA==
X-Gm-Message-State: AOJu0Yzg8s+BLpAtbJ8RYzkQ1Yshk7tweSm5DjNpzDjPC7n5wfvEmFF9
 pRu5WIvhzpG5AdgU6/YGS+p+680imskgOcY30zGkumajFpZSW0w2wOIF27E2V96PHwdYwISzPVN
 yXe2KlkhHUkqi21Dyc9MnK0Fmnpd2lvG3XdXcjhKIyA==
X-Gm-Gg: ASbGncs64+oZvRwI856qpPN2rsG7s5kXs1FhRnTzDVbEVWNK0riRDyV636tD62njee3
 w0Sp3SsJ8/m1wUdyDoVUuC/YY5ap3+TAwoHu2RAl91HqdBkU2MIc5yc1SKgqEuvv359dKrEKomS
 vp9q/QhmbdHCHStrzgpx4lhfJN7vkPwe6BslxP1GY+DWmXbDKD0rvHAYlBTOBQHZpLcA9HhVEoI
 IF77HgGBdzKrDpTymhpCXARPG87Y9CnZjBFDFFKMEk1qwbJjlOt
X-Google-Smtp-Source: AGHT+IGmOdVhdl6mOPx9mAL5dIbvB6go02hRmjt/uabJYICNfa1khoktOLrfWZJCeLnqwl6YaV+mbWvWLOlvyXrVbss=
X-Received: by 2002:a05:690e:4250:b0:635:4ecf:bdd0 with SMTP id
 956f58d0204a3-63ccb967937mr19276008d50.50.1760452130723; Tue, 14 Oct 2025
 07:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
In-Reply-To: <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 15:28:39 +0100
X-Gm-Features: AS18NWCPtRNUDEPw-6mL5t8fZ90z6LrYHcEFB6WVCvCv7zkPlDA9wOBgP4E91yw
Message-ID: <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 14 Oct 2025 at 15:22, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: Tuesday, October 14, 2025 2:50 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> >
> > On Tue, 14 Oct 2025 at 14:41, Salil Mehta <salil.mehta@huawei.com> wrote:
> > > I thought you asked me to validate the fix by replacing below:
> > >
> > > https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil.meh
> > > ta@opnsrc.net/
> > >
> > >
> > > Yes, I'm using the recent RFC V6 vCPU Hotplug patches branch I've
> > > pushed to the community.
> > >
> > > https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.meht
> > > a@opnsrc.net/
> >
> > That's the one with the "lazy realize" hack, right? I imagine what's happening
> > is that we realize the GIC, and the code in this patch assumes that all the
> > CPUs are already realized at that point. When we try to get the register value
> > for a not-yet-realized CPU the kernel complains.
>
>
> Even if we realize all of the vCPUs the problem will not go away. This problem
> is happening because we have recently started to Exit Hypercalls to userspace.
> This means we are now accessing the system register in a non-atomic context.

The point of this patch is that it moves the read of ICC_CTLR_EL1
out of the reset path and into the GIC realize method, at which point
no vCPUs should have started running. But it does assume that you
don't have half-created VCPUs connected to the GIC.

> The observation you are seeing has got nothing to do with lazy realization.
> The problem happens even after threads are realized and then we try to access
> the ICC_CTLR_EL1 register during cpu_reset()

With this patch, we should not be accessing ICC_CTLR_EL1
during CPU reset. The backtrace you posted does
not have CPU reset in it, so whatever is going wrong
there must be something else.

thanks
-- PMM

