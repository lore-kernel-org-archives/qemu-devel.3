Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3Vg-0008Pz-HG; Tue, 07 Jul 2026 06:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh3Vf-0008Pn-F4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:58:39 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh3Vd-0006f1-Q7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:58:39 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664d78637f8so5750999d50.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783421916; cv=none;
 d=google.com; s=arc-20260327;
 b=JFNPtwlEJ5xL2IdkLxROCOtCUtAUZMdITV8oh/q0G4Esj0GSUo2GfyF4xkn/3L9uAr
 n4UQLg/kGCpueJup78PunvM9TS6qe5Vpj336xnV+7DcfdjoseIgsJU1EY39L8f3pKDO0
 XloifV+iJXZwPWnn7mFJGJltxsxA0eCxoPzCR2is8td2uCavRw1ffyYh9xCP7FHcDw+m
 yxKDl2K0Akwy2DTMUfK8DS7R3oYfy72+5rYwqlAyGA18FwL+Uq/coHBTODqjw6e3AWPa
 tEQHcKzyD2OtrXclNf7bGqKF+pWC3WThpqSPDXY0Wst+6KKiZavGzx1zJ30q84OdmqW2
 S93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OeIpX3egqQCX5DLLb2ibyZt0vKmgeZ5uXbzSvuOkrDw=;
 fh=CU4uMkahKDKs962uJQThoxWtEWeD5rfJeicmfFn1qfs=;
 b=b7Lt53L9Fh2pMuSDDdIJpltXpEJz1Nr+6xRwNmZ70hiWfI6E098ftzfrE+r8//RLS+
 L+n9jJguCnZ7zEWjqcgz1byG906QjmE4HjLFlROJmCUcZugsG95Axb+QRS/Jc8seF7ZX
 TEmbtGuxw6z6uWr0TvURtMKUbI1t1qLUoN4pg3MXa8kwSq1kWJd5kRjb7QsNf87k5y9Y
 gTbKkGyheOL31Z/7w+ZxZhmG9xxsTWg7xjTySsc15fAscsXVtOtLNVVfN5fTpWYyXKA3
 UTyihSuqTolC/BKAscSX2Yu+Uvul7bQzvLXh2dUIqQRri7pmbtRxuRbCd5qrzCjdPmoP
 9cGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783421916; x=1784026716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OeIpX3egqQCX5DLLb2ibyZt0vKmgeZ5uXbzSvuOkrDw=;
 b=EHD8fHMChtpi6gnk99aIFJIJoMEqJDm6vL3f5klWCV219RfG+151aH89T8XB/FLD8U
 RTR6y0drjOiBTHH1HvkHjzyUW+q+rV2oJmaMItafH0+pbwsBJTBuX+UE7Xa/cxssynoZ
 nR665Jclx2ORWr+5naLv2YUKtFIbNkFQLhF/8BOwjUWcYM7hC0DnaNMnEo1nW/6xTK3e
 IhgAXrA1q4cFEQkCL+nan09rKnLDyvLUd+lD17wO7to2ChRbbkwag+POnhjBmmHXGtbh
 vZi5+gXdd4VHqSU5UyOMPi3JcxhAZGZudkA9zFfnN7H28T9NWBLodMH9tJCa+NR3b4lG
 6mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783421916; x=1784026716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeIpX3egqQCX5DLLb2ibyZt0vKmgeZ5uXbzSvuOkrDw=;
 b=qpybLG6DxkEhkZRD4gwnGQCTpOxwSUclrW3HC2TEPXMDYK5z9P2zvG/h5tYfN97xUZ
 RwAeojv36qGxVWegsOrHTQOfagCAlDpPXOZ73WyBmlUPwJD66uy2yV5aHywQu/ahrVg6
 n/+4Tp9Sy/ZaB55NzJy1Wg/lgNmJpxqBp8EgItAFEJW5TgJa5Q5pVDULoZ17ZYhIrgn0
 cIsYotFFOYQzDr707jFIE1xPhIh/zylZi6DFpnkwypxz8Cltm3QVq09bg2D/wVYxFqaV
 kFpr9D/0kvIGg40ANu1uA1kxbf36gHb21y+WzwSRvJVTycLuQ+9CTpc3Neccr8Xemgz7
 pZEQ==
X-Gm-Message-State: AOJu0Ywp8FZC0YiPMH35ouTSw9BZ2fByQJwds5PwD64fZoBBgvbg2IjJ
 OMcW8lpmRXW6bvXvs/df14YWzFJp2RCteqD9N7XzDd1dC/uYZC2T8O2Qmcg+J46uAW9TYevqyjC
 n8XCYfEUQG8zNAvF63/8+gVxsVAp/2B1JSPgDZvVIWmsKjfpchJRn
X-Gm-Gg: AfdE7cmHxJHM+TKk1sjAzAk+WaDRZdhfKaFKmKwvQF5xC9BVVogzhGIN061uvOHiswZ
 bVylN0fgjBLmxwDPc2Qj7/PFQsX0HETzbhPawxST2mzS0U9aBqc/m0RxWbq1IVfWls4klDXsa2d
 IklhnJbRDacp6iCAIhtb0K5CD0C/3eaQXYey1F8VIvIgUzdoqibKKL3aTeSvjSUD5zp8P7dGtjc
 G8eWWIsFXXElU8IbLhz8uMnEUu59HDDt0HvSR9X2AMVIfgjZEFxwemxquev3pt2rod2rdpumaE+
 vdZoHgnODWMtxAWRPvx+BvCYw1wTzG1/z2pyXGMp2u/MiiIrXYZTilgETyyBf+kqk5k=
X-Received: by 2002:a05:690e:4141:b0:664:d910:c72e with SMTP id
 956f58d0204a3-6677fcd9501mr3700339d50.70.1783421915768; Tue, 07 Jul 2026
 03:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-9-peter.maydell@linaro.org>
 <CAFEAcA-880g8FVk1SZ8eH7-cAkzh2oyH7OFV2LBG68=CcFE=JQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-880g8FVk1SZ8eH7-cAkzh2oyH7OFV2LBG68=CcFE=JQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2026 11:58:23 +0100
X-Gm-Features: AVVi8Ceu3x4AYRigvFnJov5CsSrg_iLOJttT7s_BC9ybu7h84ieSHh_dlMCL1Gg
Message-ID: <CAFEAcA_Lg3ebEiefKmf1K_RHY4NozezGese2rFf2w6af3oPccQ@mail.gmail.com>
Subject: Re: [PULL 08/21] hw/misc/zynq_slcr: Add logic for DCI configuration
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 YannickV <Y.Vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

Ping -- Corvin, Yannick, please could you suggest the right resolution
for this bug?

thanks
-- PMM


On Mon, 22 Jun 2026 at 15:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 29 May 2026 at 12:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: YannickV <Y.Vossen@beckhoff.com>
> >
> > The registers for the digitally controlled impedance (DCI) clock are
> > part of the system level control registers (SLCR). The DONE bit in
> > the status register indicates a successfull DCI calibration. An
> > description of the calibration process can be found here:
> > https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/DDR-IOB-Impedance-Calibration
> >
> > The DCI control register and status register have been added. As soon
> > as the ENABLE and RESET bit are set, the RESET bit has also been toggled
> > to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the status
> > register is set. If these bits change the DONE bit is reset. Note that the
> > option bits are not taken into consideration.
>
> Hi; we've just had a Coverity Scan run that went over this code,
> and it points out an issue:
>
> >  REG32(DDRIOB, 0xb40)
> > +REG32(DDRIOB_DCI_CTRL, 0xb70)
>
> These REG32() macros define R_DDRIOB as 0xb40 / 4 == 0x2d0,
> and R_DDRIOB_DCI_CTRL as 0xb70 / 4 == 0x2dc...
>
> > @@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
> >      s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
> >                            = 0x00000e00;
> >      s->regs[R_DDRIOB + 12] = 0x00000021;
> > +
> > +    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
>
> ...and here in the reset function we are now initializing
> both s->regs[R_DDRIOB + 12] and s->regs[R_DDRIOB_DCI_CTRL], but
> those are the same array element (since 0x2d0 + 12 == 0x2dc).
>
> What was the intention here? Which reset value is correct?
> Should we be resetting some other register where we currently
> are resetting s->regs[R_DDRIOB + 12] ?
>
> thanks
> -- PMM

