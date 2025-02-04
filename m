Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1E5C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLAQ-0004xk-CF; Tue, 04 Feb 2025 10:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLAP-0004wk-26
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:48:49 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLAN-0008Aw-J8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:48:48 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e4419a47887so4989612276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684126; x=1739288926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=paLWb1IWEozX8sqBe9vdeY/DC9v4P6ORAyKEeUZsFtk=;
 b=dF15KTb1L5lwA4wkAvXn7h8E5dZ6o7WP/C2i275cfqUVlyxXOL8L1x0Xev3pevG5a6
 W5QyC5R3GLSNeSQgMJMolibV4l3VRrJ9BixwcM3ERMPlOXMM7KjsVFaEYhGdC59GMs5h
 gr55ZVz+3ABfuLhw18aLmIdSmXKvB17/MqgYZ4YKG4eab4wPZINpHYFvbHX1bM7Xv1n1
 cbJSj2jQI3aR2yT6Bi3vLX8130NRSK3I/QvUJB0GiaZFmj32aVYJQlLyGo2uuc634Sz0
 OJjpNbW4lzhLS1xMr2QOt19ta59GYNiXtzgijUvSAZp4QjejHkVrsHJ8vtzzuCJ/cuPQ
 QyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684126; x=1739288926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=paLWb1IWEozX8sqBe9vdeY/DC9v4P6ORAyKEeUZsFtk=;
 b=ggHA+LJYVZjm/OM4/lz5l4doRPXEr9DKDSHVtxiL5R5lE2dajs7x9+G3+R5OZKiA0L
 BQhPH9Mf4goPzPq2WdEY4arcQzfXt1IvtHDRqLyDllDqgKAthOZ5ThDLHDrmQ3AVulSY
 mvAyeQWCr/7c2ZMKfGCX9Cdjn9GokDLfcfGL0nMxwajtlTYOevw1f6EnaqekzOfbgHgJ
 +CWwm85EP8us7j46nh9OB5PFilgTzdEF8FB6OSWE16L4LFjU7rCdBfv9l3uHb1YU7Nox
 ujTGHOOx500YVnUfOjPi4XCRqAlMYHAVHYjEtDtZHxdVx/2MK6y1KAq72aRm7x/CggYi
 fm1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp5623P62LSGGu79/8rVwLNvZzO5dcOWPqU3DLIZyvQ3QtLRPmmlLGEYfUvyDhPazevvt/d0VF+my0@nongnu.org
X-Gm-Message-State: AOJu0YzSTuA1QWJ5+6bPb3oTNRC3J2CMqrcjuXtpxfGXtTvr4pO9+y5J
 cU089b3b00HL4N20Yz9yv2QLqWAqnJU26jXzC8CQsChB1wM/N1yJBn9Bf6zinsKDqXWHMPb1g+B
 RVDOk0M6jH0ffgZUFLpSB4Ku+moEn4cz9di6zHg==
X-Gm-Gg: ASbGncvEcx4c168NXcTgQ5P8fFCQfyjDTOSHb0nz+LCx3cRQyLTr3YJVmxsoVV/zYFv
 JNRfKKZgFkMS7UPt8pvbni3KaS30a6tmjEo9zubDHqclKwMmi4/RSwt+1gKhx59Hl2Ye6bI91+Q
 ==
X-Google-Smtp-Source: AGHT+IG0u9QZVqKNKzMEeViPr9gLR4waNIZHK06ruIFzO5QgeZ7T0rsinJcZkhjkWkIfPYTTMicYugUP9XauGvhDCEg=
X-Received: by 2002:a05:6902:102a:b0:e57:caaa:fe60 with SMTP id
 3f1490d57ef6-e58a4bcb243mr19270540276.30.1738684126247; Tue, 04 Feb 2025
 07:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-8-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-8-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:48:35 +0000
X-Gm-Features: AWEUYZkPWAGKft-HLXzTtHHdtAZVdCyvY_93435NkCAswGey_L4gLpW3OUfbTHs
Message-ID: <CAFEAcA82ZPPPBFxJ1QzmnVPs96U5uTYQrdkkw3db=R7gQD_FcQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] hw/misc: Add nr_regs and cold_reset_values to
 NPCM GCR
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> These 2 values are different between NPCM7XX and NPCM8XX
> GCRs. So we add them to the class and assign different values
> to them.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/misc/npcm_gcr.c         | 24 +++++++++++++++---------
>  include/hw/misc/npcm_gcr.h | 13 +++++++++++--
>  2 files changed, 26 insertions(+), 11 deletions(-)
>



> @@ -156,10 +158,10 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
>  static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
>  {
>      NPCMGCRState *s = NPCM_GCR(obj);
> +    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
>
> -    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> -
> -    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> +    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));

Previously we had a compile-time assert that we were copying
the right amount of data. Making this a class-specific
thing means we can't assert at compile time any more, but
I think it's still worth a runtime assert that we aren't
copying more data than will fit into s->regs.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

