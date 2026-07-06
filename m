Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BD1C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgn8D-0005Vp-BJ; Mon, 06 Jul 2026 13:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgn8B-0005Qb-Mh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:29:19 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgn8A-0003AT-2w
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:29:19 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-80e4455ba39so529527b3.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783358957; cv=none;
 d=google.com; s=arc-20260327;
 b=rCrYvf0kpBEDoJfBHQl7poArVOamPJGPpnmGnXuyVPhZUdG6XKtqUJ0PMM8R92A5Vs
 j0ZCGdD0LfE/Tpfnm5gfai2cOQoPGkKbKnmB2bNhQPpdiZZD2Sm3gRHbEmXN2yM3wg8z
 a4Lum90HjnDzeJtxcVOgazXYpMsjqjFGMq3sWqq/ddGAx8OpG7Gey+hNTWHz28o4y487
 JgWx+3vCKq3fOuRqsv/GGnHGfXTlJ8cZ8+126iDUn0EP6lM8DS+1lDHZiwKUqDUbqxPw
 sofuwAj9a+QY83rw2nyMrVwzRNy38ZbXZLbOXbY148K+ISe5BWU2hWUqDz85PZE6OOIf
 P8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iClZscjiedIVC78pseYr2AnsDA+R5QCV3UOX/EOYR0Y=;
 fh=WEJ15tX9epTWjJ2VmR8iecZlI58qJeOauJBn5MjM3cU=;
 b=jV0DBfDsiFbhBjPo0nvKmmofnN5HRS6+PXLS2F4Dbw513rQX8/PuS7SybiMBqLMCYd
 HEHrp5YZnUH7wjanNLIPnm3prlN83DYydtIZ1xg5oMTzfisjpBxAtSkUDU17BjM/LYHJ
 z6Ug01a+rIO8wSPOtGmhSHnwsx3adpK8buU0xEWmY54HVkbXfAOrepv8SHB1gUD4OKij
 k9d2Ih/T0IVNKMBpl5Otmoo1FazxkW+jW67ujP+/tTO3mub/vxjP0y7CMoEiAr1AcxsV
 +uB2Ilpu8bb2apGoYuoa1ihG/wczxFhCt/WW98axFFlNy6lg3LJw+I4dhjtHfs+Xag5H
 3C1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783358957; x=1783963757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iClZscjiedIVC78pseYr2AnsDA+R5QCV3UOX/EOYR0Y=;
 b=eoAbHW+rWldDmc83LTA8zHpLS9vvXsMS6p8LeXWdSeQiqIC3omxGcX3wknwYVTAjKd
 QRTXSHvdF/4+1mCOZxu+8LWQTgzLMQjcAAgGn8cEcriUgyjWhFxvDkp6euvZ6xNgasOC
 ZucDuZS87G3tBw+OIftN+LulYqAB+I+nHutnWV2Bi312T46fxrS10VoEMlvN3zpWXfbJ
 OXUUQrB6z68898P1KH8+dB8hJ4B0XuUh6v9WZk1VbRaX9OUGM0NL1gW6SyDsOnfd/xYs
 ND3E2w/vYt8aXyK9cwM3Pw8Lg0x1nYYt1QfAHplNswURSuLyteUYJa95hiFUxzgchsEX
 nTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783358957; x=1783963757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iClZscjiedIVC78pseYr2AnsDA+R5QCV3UOX/EOYR0Y=;
 b=hlhFpgI41K002AujhxUntUEWUfa7FwDPln+MwIq52WVfJLFbFLuCd66MS67ieAWjGo
 Qap9AGKa2qwYSGv7Ml0jixMa3M3DmQaeOiHr98Pr8K2oeIVlwCe3+sK38KwfCp21Y9n0
 LgTFtzhB5eFGFpmtb+9au+YpFYhh94AyJn6VJXdLw6wkwph2P8nPc5wtpU1IegJCNAnY
 yF9Fpn2RIAw6Cjd4TbItHNqdVbUD6x5bH5HSlOwj07R8XoNsShFF89ddhGOY/+TPRHci
 q96M/ZyRDPgq2rlg3naLMasAUfe8vWqKFKpPoyIWDnrsWebhn6NQCXBo6x2Pzl3D0auS
 vM0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRYPh/AG1btsBDq5mmQ54FETr+lyE+E0nqJUd88bzMPjGEf39h0OhOUTomDtmDc2wiUK+6g9LEcpUD@nongnu.org
X-Gm-Message-State: AOJu0Ywujj2d8uiLaDW9Z5eL+74GWSwgiImkDefAGq9agQI4BbDrTZKn
 aKEvmwdHXwyvAaV8sTFxbSL/WshtsmZLkCDFOvjgUSICmW2ZAT1TedbWtkqJGyTlZJtSHtz5X1W
 ZHhUtnjDlAulEVvCJzHhgPS0z6cIwwXNkakRj3Em7UMqjYOCXJmGo
X-Gm-Gg: AfdE7cm2DCCqDYLAq7EvVV0YUzJ6Ujxvv43u8b91GHzJh6weOOJoGVtng4eCquHVtlY
 Pz3NZ++FbhslZDp58uLStjhFlzTie0Txg+lR0i/kTHVJt7m29gRN+kir3ZWpr+kuUMcpRyMMzpj
 n25lhWo5/xYqn8v1ZEoX6Fq2T/5LwcsKhCMFMkQO2Tcs9+E4t7MCOKa8rxzS+n+QSt/rLlgFhQ2
 aFZLLrvXUOdUo0phSezxUmifKUlVulcSB9wQ6HL7QjuKvmbMQEzqh/fzYIOFkKt8XVafmG5sw49
 UeK+8oy+O51gF2p5GxHxDw8MHAv9vdTtmleRghXfBjvBvqkEFoVCjKoG
X-Received: by 2002:a05:690c:386:b0:7dc:1c56:2901 with SMTP id
 00721157ae682-815ba02f022mr153648007b3.1.1783358956663; Mon, 06 Jul 2026
 10:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
 <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
 <CAFEAcA9wOZhn41Twz9zzCBD4MAET2+gbF71kUKnr7r6TXfhjuw@mail.gmail.com>
 <20260706094241.1457bbc6@shazbot.org>
 <CAFEAcA-d9CJhfJQ2B1h+mZTPphc7SKk8yjCuGH4RWYT9J=EATw@mail.gmail.com>
 <20260706111632.64266244@shazbot.org>
In-Reply-To: <20260706111632.64266244@shazbot.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 18:29:04 +0100
X-Gm-Features: AVVi8CcJSeUECnvXAjs5-pAw_6n-fWNKrjVxx9Nfe5kiYTX4fIMTgiuUsCcIX2Q
Message-ID: <CAFEAcA-Xcw0FJAgFJ2U7YXxS2cXEsgddAPH_0cajp5rAdjCy+g@mail.gmail.com>
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
To: Alex Williamson <alex@shazbot.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 6 Jul 2026 at 18:16, Alex Williamson <alex@shazbot.org> wrote:
>
> On Mon, 6 Jul 2026 17:12:35 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Mon, 6 Jul 2026 at 16:42, Alex Williamson <alex@shazbot.org> wrote:
> > >
> > > On Mon, 6 Jul 2026 16:27:46 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > It seems very unlikely that anything not page-aligned is going
> > > > to be a sensible target for DMA ops from a device: the main
> > > > reason to have a non-page-aligned or non-page-sized region is that
> > > > it's the way we've chosen to implement a device, or it's some
> > > > "RAM but not general-purpose RAM" thing. If there's a path to
> > > > warn/error if it's actually used for a DMA op that would be worthwhile,
> > >
> > > But for a vfio-pci device there is no DMA op, it either gets mapped
> > > into the IOMMU for direct access to the device or not.  This is the
> > > point at which that decision is made.
> >
> > Why is small RAM different from MMIO register regions here?
> > Those also you're not going to be able to have a device do
> > direct memory access to.
>
> There's a precedent for bare metal, peer-to-peer DMA is less reliable
> and drivers don't typically have blind faith in it working.
> Peer-to-peer DMA also has specific use cases, drivers don't arbitrarily
> pick a peer device to DMA to, they have specific use cases and target
> regions are inherently sized and aligned appropriately.

Sure, but if a guest does try it then it's going to fall over.
This is exactly the same as if it tries to do DMA to a small
MemoryRegion that we happen to have implemented as backed by
RAM rather than MMIO functions. In both cases the QEMU implementation
of the device is fine, and the guest has done something silly.

> Here we have RAM and we're trying to determine whether it's RAM that
> could be allocated as a DMA buffer or expect a DMA access from a
> device.

I think that there are no examples of memory-backed MemoryRegions
that aren't page-aligned that are going to expect a DMA access.
So a reasonable proxy test for "is this RAM that could expect
a DMA access" is "is it page aligned and at least a page in size?".
All blocks of real for-the-guest RAM will satisfy that.

> Commit 851d6d1a0ff2 spelled out that we could have declared these sorts
> of regions as RAM device, solving the problem with a simple test, but
> that wasn't well received (for reasons I don't remember), so we were
> forced to create this mechanism and maintenance issue.

Isn't a RAM device for "this MemoryRegion is backed by memory from
some actual host hardware device"? In this case it is not, so
not a good fit. But either way, if the RAM-device MR is not page
aligned then the guest can't DMA to it either. So "is this a RAM
device or not" doesn't seem like the test you want for whether
you want to flag a problem.

thanks
-- PMM

