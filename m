Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CA0C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRoV-0006dw-62; Fri, 07 Feb 2025 12:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRoJ-0006dO-Di
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:06:35 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRoH-0003fO-Iy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:06:35 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e46c6547266so1822022276.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738947992; x=1739552792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x2EcrH1tEE3g+8S1bArdiH3Vlk3ipieMtmlaoFSIU/k=;
 b=Q7fXDXNbJnKLfGZH4948+2z42p6C1r/sGsRLvOxYbQlnOULDdZ1ke16qhjGAlk+R1d
 C4DD3Zn0sVbMw90q+WzlAppCzgGLN4SqcR6HgNKQkMiP+SFZb8+E0w1QzSB/2OdRA782
 pVoQTBEoaaU9torQgk/BOAVUDhRi2fqCAnnifNUVWdPq9XCRL/5AcCES8h5gG+bgSBJT
 HombPZrS5BGQNjoM9Wn3bKbexs0HpoCrVZ/K0jg2xc6zbT4w6je7rn1c7Oa1z51Irm2g
 5tXDUfkEFF/KNvNBZWprPYSrKEooPIVwEHVF4skU7kKwZhjWpNa80a61PMQ2de0fTdfP
 ZNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738947992; x=1739552792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2EcrH1tEE3g+8S1bArdiH3Vlk3ipieMtmlaoFSIU/k=;
 b=XdnchtvRab23RnxHUFz9ylUZIMVewwiSzDxmuXDIkgV54ncyjGpJ5jel5tUQghXSSk
 epBOLJ8ewYqnfjbDbEquYPjbzfsFZE/1S6PKhaTDn6uDx4tAkILVlhhhgZGKS/Sxefyi
 mEGQ7I1jx0LYrCCX2Fb7+GfPqGqtvVkWAFeBaKGX2g8QY4VC1DTweBoZkMwOY1RjksIn
 nEdJTqHqqKG2K1aVc/qQhnLARFflMnYAUrjhCk5/Z6LY1pfhpnshTQf1g0m60vhyCvJE
 fbdjWFaQWP6Wv2YJi52/MnsZs8ivqj0x3P1Zu9AZpJeRuBdwll2z6+yGOYFCc0Dsjcp2
 cs+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtd7mVpiyzTyKChYNMYLA83I9hq0xqBfwmBot4aNzShB4QA9aj4TImr42+MA8xXvZBFxpl49hR2/Jt@nongnu.org
X-Gm-Message-State: AOJu0Yyl4+mqDdtbAN5+rmNBeYAbS5eZD/419f+9s9YZYyiiTSimCr1S
 L+LKPSM54E7WdjOmtryGrszIET2Nxppnu1Fah/N539QNZc8QwFsgauixGg3sNJfccD+RCWRPBL3
 stY/BDz0kQhTO6wxQY3TedMSYla0DG+XJGSreztssD/Yl6jwH
X-Gm-Gg: ASbGncunxuJppoKSDCNlROP2E7Gbi9Lz9n4OtGspVSdrBWDQTR8l+GqqFDmrhXIEkTM
 qvp9j6HnREO3cyv+AN7F8uQPtgqkrPwK5pPTLrTtbB3alonTKVYs0SwMLOFeglpu9kog9Ew9Xcg
 ==
X-Google-Smtp-Source: AGHT+IHXPwecfKg48up9y+Mh8UnPGN7p1Q5HozH8B0Os/fvtMTc9GcCWHdCZuvQe3A/aoO5bsTdGPgp1lWaZ9/1OfFE=
X-Received: by 2002:a05:6902:1101:b0:e57:3a77:99b9 with SMTP id
 3f1490d57ef6-e5b4629db09mr2525588276.41.1738947992033; Fri, 07 Feb 2025
 09:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <Z6Y6sf064FBWT5G1@x1.local>
In-Reply-To: <Z6Y6sf064FBWT5G1@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2025 17:06:20 +0000
X-Gm-Features: AWEUYZkGCgiYExZB1YkWnc2NpY21qlJjthqeofmkYckNTIsX-HskZnMDN8FOS5A
Message-ID: <CAFEAcA9ETg2+Xa+e3quJhGG3KsNuH+DW3puuWaJi-q1psUdw6A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, 
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org, 
 zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 7 Feb 2025 at 16:54, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
> > This is a follow-up of Peter's attempt to fix the fact that
> > vIOMMUs are likely to be reset before the device they protect:
> >
> > [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> > https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
> >
> > This is especially observed with virtio devices when a qmp system_reset
> > command is sent but also with VFIO devices.
> >
> > This series puts the vIOMMU reset in the 3-phase exit callback.
> >
> > This scheme was tested successful with virtio-devices and some
> > VFIO devices. Nevertheless not all the topologies have been
> > tested yet.
>
> Eric,
>
> It's great to know that we seem to be able to fix everything in such small
> changeset!
>
> I would like to double check two things with you here:
>
>   - For VFIO's reset hook, looks like we have landed more changes so that
>     vfio's reset function is now a TYPE_LEGACY_RESET, and it always do the
>     reset during "hold" phase only (via legacy_reset_hold()).  That part
>     will make sure vIOMMU (if switching to exit()-only reset) will order
>     properly with VFIO.  Is my understanding correct here?

Yes, we now do a reset of the whole system as a three-phase setup,
and the old pre-three-phase reset APIs like qemu_register_reset() and
device_class_set_legacy_reset() all happen during the "hold" phase.

>   - Is it possible if some PCIe devices that will provide its own
>     phase.exit(), would it matter on the order of PCIe device's
>     phase.exit() and vIOMMU's phase.exit() (if vIOMMUs switch to use
>     exit()-only approach like this one)?

It's certainly possible for a PCIe device to implement
a three-phase reset which does things in the exit phase. However
I think I would say that such a device which didn't cancel all
outstanding DMA operations during either 'enter' or 'hold'
phases would be broken. If it did some other things during
the 'exit' phase I don't think the ordering of those vs the
iommu 'exit' handling should matter.

(To some extent the splitting into three phases is trying
to set up a consistent model as outlined in docs/devel/reset.rst
and to some extent it's just a convenient way to get a basic
"this reset thing I need to do must happen after some other
device has done its reset things" which you can achieve
by ad-hoc putting them in different phases. Ideally we get
mostly the former and a little pragmatic dose of the latter,
but the consistent model is not very solidly nailed down
so I have a feeling the proportions may not be quite as
lopsided as we'd like :-) )

thanks
-- PMM

