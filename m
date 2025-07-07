Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD11C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrLm-0007pk-PA; Mon, 07 Jul 2025 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYrLT-0007UN-0e
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:17:45 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYrLR-0003Wz-8l
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:17:42 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so3176203276.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751915859; x=1752520659; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V32HG+NOU0SLR+BExuSQ+r2jI2rpaMDsrGNz4QuaXfY=;
 b=VHAnSrZ4MDYlY/f1c7Kwovf9EbS06+VVoalbBc0RfI24Cl0CYn9keCqIOaASJNaPZc
 ev5jvrmfUYLk5iDUiPRGY2JXmdBMJW0598XLZJaWxrkHV+M0bl7gRrfERPuZXLm2Aphn
 6HxV38wj9N2bJu0P1B8//10kcHq5VfrBVgCYc0lh9dH+tiimMq3RVN+h0S1ulOqXASeO
 vWySp65Uzj3+w1Ng9VQVwrWhOx3CcUzKzB/nbkUFU3k857RN2TKzET1Eb2uiJf2Xd1qK
 zuMxMQQvMZk5zwYObpKiTvZhdWiz0id8PWQbRs0ZesqOYhcBFuRE2iQbSDGGCrd12JDK
 LPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751915859; x=1752520659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V32HG+NOU0SLR+BExuSQ+r2jI2rpaMDsrGNz4QuaXfY=;
 b=levbO3Za90c5juGbcJBBQajtbzjV4VeBZn7d6+Yw0c5AcQsSLhaIj6GQMLogszrEzb
 JnGSqIukda/POJaf8agOh0Jxj9kNYKruwtrVP9hBXZUBpRmu9jG6347eWd7b0G0hCRvy
 ZAymkAYR1nlKWcTdAbawF08/CAKVAhFt8ShaSyvUNAzGPB5BPslETuWTlGhml+ZDAb8a
 H/WvdNioGN0pW2H8hO4OGRp/KeP03yy3nlz0GtVycd2NuaRIMF8t5emu9j0rA0Hh0KMq
 EwnHDU5p65oMG5hU8zY35eKFux3KnKKCvRWjlG7JJUlXqcczXODsNwTZonAhU/cFoDpn
 wl6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXEJiX8Jbks4C/wdtPVnGUwGFzEnnVr80S5uMV9IsLc0KaCyYGqLCGBl8Kvd4TA4sLu2BRMIr39t57@nongnu.org
X-Gm-Message-State: AOJu0Yy+aZ990izpL864mC5gTlwJjs/IcB6o4upLoW0Zpul4oGhJWBwH
 6xxP7N27oTsFrJGNshB8m+7JFkef0kVerL5SOZj0lH+RGq2MvYB/DDthQgU6rX7m/bNzBJZujzn
 bKF6phrvbic3wkH3o/rETpE0A6IwCvMcJNhVEMeCPYA==
X-Gm-Gg: ASbGncsD1PjQ4LiXrFr6LVcy7/jh0xpX5HzJU4SqhW68v3JjzLBgzrhapLoiHuFrG/K
 WggXFMqGip85q6D2DcIk2a0WaTkcHN7EjSqPNBhq9Af4g+tBF8oVY5+6CGoUGxIjTaMGd6PQiuH
 zTuyiElSCLZ2jtworiBKJid2tuNo2eHdrV0jXT4wC/WO9b
X-Google-Smtp-Source: AGHT+IEpzePe/AWrf2+5Q3tB1RHOYpgoyu1r6os1OqepBiE6jQC7sKhFhQhqeWoM5eKdaDiCar6RWbyvuJ8BPpYc8lo=
X-Received: by 2002:a05:690c:6907:b0:716:4da5:a01c with SMTP id
 00721157ae682-71668c503ecmr205596477b3.11.1751915858796; Mon, 07 Jul 2025
 12:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250707161018.585469-1-peter.maydell@linaro.org>
 <20250707161018.585469-3-peter.maydell@linaro.org>
 <d87b733a-c8d3-4038-9159-60806d5a6186@redhat.com>
 <CAFEAcA_bmwstEo514jTunu6YsE78QikOCm+ZxJ0B6ZH=n_GbXg@mail.gmail.com>
In-Reply-To: <CAFEAcA_bmwstEo514jTunu6YsE78QikOCm+ZxJ0B6ZH=n_GbXg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 20:17:27 +0100
X-Gm-Features: Ac12FXyx0IKucwRas-2nkD-0xW4AqX5LrT5QIbaaADY0X9-iKB4wv16AN69LNz4
Message-ID: <CAFEAcA-V6DKpRkz9W=PPjes+jk8qzUQN2CovHBGwmwESUyCn-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2
To: eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 7 Jul 2025 at 18:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 7 Jul 2025 at 18:25, Eric Auger <eric.auger@redhat.com> wrote:
> >
> > Hi Peter,
> >
> > On 7/7/25 6:10 PM, Peter Maydell wrote:
> > > The GICD_TYPER2 register is new for GICv4.1.  As an ID register, we
> > > migrate it so that on the destination the kernel can check that the
> > > destination supports the same configuration that the source system
> > > had.  This avoids confusing behaviour if the user tries to migrate a
> > > VM from a GICv3 system to a GICv4.1 system or vice-versa.  (In
> > > practice the inability to migrate between different CPU types
> > > probably already prevented this.)
> > >
> > > Note that older kernels pre-dating GICv4.1 support in the KVM GIC
> > > will just ignore whatever userspace writes to GICD_TYPER2, so
> > > migration where the destination is one of those kernels won't have
> > > this safety-check.
> > >
> > > (The reporting of a mismatch will be a bit clunky, because this
> > > file currently uses error_abort for all failures to write the
> > > data to the kernel. Ideally we would fix this by making them
> > > propagate the failure information back up to the post_load hook
> > > return value, to cause a migration failure.)
>
>
> > > diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> > > index 3be3bf6c28d..0302beb0c07 100644
> > > --- a/hw/intc/arm_gicv3_kvm.c
> > > +++ b/hw/intc/arm_gicv3_kvm.c
> > > @@ -332,6 +332,9 @@ static void kvm_arm_gicv3_put(GICv3State *s)
> > >      kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
> > >      redist_typer = ((uint64_t)regh << 32) | regl;
> > >
> > > +    reg = s->gicd_typer2;
> > > +    kvm_gicd_access(s, GICD_TYPER2, &reg, true);
> > > +
> > I don't know if there is any rationale about the access order. I see
> > most of the dist reg accesses are done below in the function after rdist
> > ones, although the GICD_CTLR is also here. If there is a rationale a
> > comment may be useful to avoid another dev to do something wrong. I
> > remember that for the ITS for instance some speicifc ordering needed to
> > be enforced.
>
> I think in general we have tried to put in comments to note where
> the ordering matters. (Though I do suspect the GICD_CTLR
> write may be early because we need to write the enable bit
> before doing anything else -- if that's true, we failed
> to document it.)
>
> In this case I just put this one at the top because "bail out
> early if the config is wrong" seemed better than doing it late.
> But it doesn't matter and it's probably more sensible to do
> it with the other GICD registers. A comment that we only
> write this ID register to validate the config would also help.

Also I realised that this probably fails on a GICv4.1 host, because
I think I have the reset handling wrong. On reset the gicd_typer2
field in the struct will be zero, and then the reset_hold function
calls kvm_arm_gicv3_put(), which will try to write the 0 into the
kernel, which will fail.

-- PMM

