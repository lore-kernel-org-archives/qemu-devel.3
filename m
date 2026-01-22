Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E4AD3EE8A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixAf-0005ct-5o; Thu, 22 Jan 2026 11:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vixA9-0005Th-H0
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:04:04 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vixA7-0001qJ-Fp
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:04:00 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78fba1a1b1eso21942057b3.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 08:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769097838; cv=none;
 d=google.com; s=arc-20240605;
 b=NwOFRK862xNG7KZ2jAE4ZP180koxuFQHSSbleY5BaIAfWKwSTWmhkJR5dy7wVkO1tI
 kWBiboQfKoSBUdDlsZ9cRKJIX7HRSEejnbM4slQkoAaT7vLp6JnXj0mAXc4ZRSoO9Frv
 z6EHBtho3tX8vjcrQRV4o5QufjEtH1M2jGlXj2hgcSgTTRjdJ3DyM0l4cFPDP/jWlb0W
 ep9wFT2gaTxUsTlWvpguitSJ43rlzwLc0yPw3Mhyw18ImHbk/eYpblC98T39ezeLQboH
 v8j9GwNit6RX20zXWZ359tu+7xPMxN7zPtDaNMXD1iOmVhgJgTpztsJbVrdosWKRpnun
 TE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V3h6BN0iHCZPqzNEsP8FQyIesF9/U03y4JkbzQWDoUQ=;
 fh=oB2JmoVxJ19DCbyA6gPU0e5PzqljNWcUlt7edikwwyY=;
 b=RqnsOYuOavjqGTnVAw07tJqvJAoELeYRbnhpctqUvy+ZPb3mZr+Y3Z0POqRVM8GU/E
 ocOkkm8ArqEK2KnH3c4hqJZTTkkXo7P86ekEXzVq52yrPQWITyBFbb4u2urqQx3oH85z
 KGkLSq5aSjoprH1p3biv3NBOqN6PXWio2J/A4bO9kNDchVVLgeFQRC4wU+HtlyPlLgGG
 B1ejA8KruWgulx6//RubpT62ZNg8axtBDjI/PNnqhnhcnN7KnvKdT4FA1659YIvDvgiL
 rKgw/v5QcrvWRLCYWhgovuMJXv/RutlLduFDQTKFqirbWBn+rEukj3htzWVq7z0Hj7Tx
 p94A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769097838; x=1769702638; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V3h6BN0iHCZPqzNEsP8FQyIesF9/U03y4JkbzQWDoUQ=;
 b=HUshFFzEPGDj/Izr58DM8s03w3QJJJEQEjGf2GrSkbbDqm1wLkt36WIWgRlnKJYFd2
 x+eGyKaawgpm03lrIKHYKmW6bwkaKqD2Cq92K38boukv9/DJda5Ixt/CdOdV8Pt2vUDG
 DtYByu11cmUrYU0IgunnZe6VG/VM8sVhIz94xvbXVug+otLs0Gt9/ZWk4r8/tu+qPZYH
 AAIeOav3rEinAYx/a2ywZwXq5GmN0FZFWerJrAZVbuxC4x1dsFAx6UI7KMaDXJlSRWwR
 zIPtSIwdyHlW2llf5AmBy+GQ5Uzt2X9+CZEa/hXG55mfJxdAC35HtmXAfQJiPWoD8jUo
 un/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769097838; x=1769702638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3h6BN0iHCZPqzNEsP8FQyIesF9/U03y4JkbzQWDoUQ=;
 b=r47PvmIvkw2vOEhy/+cV6S0ww9djcy8k9yXgD/O4MHrB2RLyRv5P03G8Vq3dS+67Hh
 dkn08NocNH6FSLn7bsLI6t3h0f/pzYNH7hwRmmo4Of4096vyvlBq1Zu287UtAjGRYnA/
 8tW7fG56TLcEaTQdqe37PrOq0os6dsDlqvanhC42vVHSmiLzu2eLAzbsKMThV3Yocabg
 e4+OFh/yN0ka+v9H5qbbVTGBdMObQj/TBUmKH0wRGGB2Azz6ijjUYHY7ZXCCnFvj8x1u
 3cMEk5oeaOLhCMrXYazrBN3hd8sQEgceYDreFCDyDZ9yueSJyKHJgpc2A75r53jz+wOy
 CKbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD2g9xmRYbS1oHYP/CqXayQIWMCZ6Hu7/rnxMpve6RslwBHE9AMVcA+VZx0M4XqueR3CFvUrM5RtjP@nongnu.org
X-Gm-Message-State: AOJu0YwwPAlo/GyD+aXAEee1+YQ2Mpy8Oe3typaGTiVu/PGgcoNpOmX3
 45ydVY0em5wu4C5RxAUoRMcDpVo5S25tJPCt0DF34aHUQExZ0TU3zW7vx497USuACKZU98ZnMdA
 lzCYrD4rUaWOP6ghiJb2FtfsDbVJtYOeG6KSygtxmeg==
X-Gm-Gg: AZuq6aKfxU6fN17OaquJwoO9WsGy5EQXudl2aIR8MkkGf958RfSjTI2o/JhZkt/jpt5
 UxPSKr8VbrYwOGE+X0b/yUQIi672FL9R/CNUtLasXMwAvJYeFqEwwUU0/T7U9tX259yscaar84M
 mfIn2IIW/YDQvuQ0ovMgFXonlf5ea/ugpaHO6hwcPGPOoX4YL5VOhozWc32GEJC0aWsGOHHABmU
 J2mmxgY5NSZpOJrUNYu1MUFP2CK88LLB6ibf7DPFopiKGJ8tbt+Hn0nLhAmToFmtBav6w==
X-Received: by 2002:a05:690c:f83:b0:793:ad45:8e8b with SMTP id
 00721157ae682-7942a7bbcafmr28334327b3.19.1769097837444; Thu, 22 Jan 2026
 08:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <c272a3dd-5f16-4821-bc38-5bd60369dfbf@linaro.org>
In-Reply-To: <c272a3dd-5f16-4821-bc38-5bd60369dfbf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 16:03:45 +0000
X-Gm-Features: AZwV_Qh4yk1EtsslVr_pCcfVXvOI6lH5QQPzWlqHkys3d92PVIAstcCZeDmkej4
Message-ID: <CAFEAcA-xPER9Hedw=pnqDy-RYq8gEjo1fMt6bVzJVTHwHfgk7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] hw/arm/virt: Deprecate 'its', introduce 'msi'
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 22 Jan 2026 at 15:51, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 1/20/26 10:03 AM, Peter Maydell wrote:
> > This patchset is an RFC sketch of cleaning up the logic that we
> > have for selecting the MSI controller, so we can add the handling
> > for "hvf and whpx give you a GICv3 without an ITS" in a
> > hopefully clear manner.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (4):
> >    hw/arm/virt: Clean up MSI controller selection logic
> >    hw/arm/virt: Don't use vms->tcg_its in create_gic()
> >    hw/arm/virt: Drop VirtMachineState::tcg_its
> >    hw/arm/virt: new "msi" property
> >
> >   docs/system/arm/virt.rst |  21 +++++++-
> >   hw/arm/virt.c            | 108 +++++++++++++++++++++++++++++++++------
> >   include/hw/arm/virt.h    |   2 +-
> >   3 files changed, 114 insertions(+), 17 deletions(-)
> >
>
> Maybe Mohamed could integrate this in his series, once you're happy with
> the result Peter.

Yes; I have the latest version of that on my to-review queue.

-- PMM

