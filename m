Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C71DC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzX23-0002R7-Ta; Thu, 27 Aug 2026 06:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzX1y-0002Qe-RI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:08:23 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzX1w-00027Q-Rv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:08:22 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-85aeb506b78so11709207b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787825299; cv=none;
 d=google.com; s=arc-20260327;
 b=OohaefhePKztCGy6anshrSUVj/E9aI7sqpkP5ej0eYRdYDJfVP6/y714n/fvZCrWg4
 AXe6Z4PQGtQh+7AuAnL7AoO3QMlNH1r3pufX4qHH/oSv4rjQfOufKzTpoV0EAzSRfeWZ
 yUvnlb+oV9n1+VStwvM3c7AwI5iFMjDohxQwzDz+dSXMV0+sadO81PkoDULq/47M4P4X
 wjIxoewkT0UWySnewNSVvgMmgm/nRSeWwxOrNs/Ss1OndDADchMQMQvCjWcU62umRmpF
 BXGy+g0UXvMJfvGcaCkwcWBGyR09dvpzcR1AFUu+wV3T4i9kWWkZRuSk023UrAo9WGLi
 nYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AIMrBgAvUo8qSUtrlbudNApMyVpTiBhuYqpxAOpEYE8=;
 fh=/HmZTtYTGRzUoXNodUpbgfFx3rTopm+VA3eCfRm/1og=;
 b=RGlBZ0odtEGKNIU+sl0jDTobNg/NS5WIlNqINMUM4S/ByrmUHndk7y/F9uTK+PIoZF
 6W4TIdWbqB9cd8W7r94Wyyf9HDjevLSMCqIZvzHSqXfiaA4Tp7L1pr5zxIFxHeDrc//y
 8cOpIqhc01Xyz1dZ8bKlFWGHjBXRGvCiIOZVVdK28fuVGhv3KgDF8oFWfxFL2mGf59tM
 f0jFlA0XGhXzZwMr1rbJraI6qfMROb9Pax0EjeS/19IAvCbJrcw50I6EApctjq9h6itb
 JdMabrUTDK3WnazcbU4us9oZwjqmYh9BZtMS4oL7LUf1JUAtbqi3y2fVd8AmUgQlzvL0
 8JvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787825299; x=1788430099; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AIMrBgAvUo8qSUtrlbudNApMyVpTiBhuYqpxAOpEYE8=;
 b=WLUSQbXiUKSImlJ6ayZOgz5U7JUojUyQzx8Su1mSvTVIBqvfYANhXjrGZnC7AQTITE
 CLaqajNrirqdrU/K9imj4tjRXH53/iIFs7oqDxOomkSDu2aGQ5jL5Xfwz16kAH89SDHg
 75Yk7BzkSoSVyM0x6UDw1PCa8z0a/gPmCa3AVtc2MUzSUt7/J2btbt+BgpAY3uiW9/xn
 j6OV+kEHCrasuC65TifmLcVhjabxKbHYuXQfvMUuh4dNRfKU9bVPZdtX8BMBcnAT1toO
 4ZO+B7nrqri5YGtXLnPbetvtXO4ossAPpdgrEvCa8Jd4gM14Dt4xUCD5hh/hdcfsx1ED
 1bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787825299; x=1788430099;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AIMrBgAvUo8qSUtrlbudNApMyVpTiBhuYqpxAOpEYE8=;
 b=X3avGRx/rEZxJdxTBoqTynI3xaNaH4/oYnBlUweMckpNiXi/V/djaE26qJVpdx0rtr
 VhXUNOzWokmDUiXErwBVFyXRWezZ31/hOkHOSYpQtskArCfoWXd9Wl0w3el5vVNFrcx+
 l2p8F1/A2/nd3V4voHY9rCVrXo6heWIV2WHRjr5B3W8ahEi+XQe+Pr6aolvQdvwOkjin
 s74yENquUy6u4q0DFzQNEwVIkgJ+CYX0xYX52cvLqorQW+GJvbCEzSa34KvSQklVGDF9
 E+ttFr1c9Ks55WHN6pDBuaYk0Rv+SV3ljHH1nP49pf8WerOnyDCLnJ6KC9bR8pp12SR2
 iq/A==
X-Gm-Message-State: AFuF++nR6aEB7Rb3cyW+vROTrgJ1WnOC+hS2mgJf9+2Yd7SDWXwVg0mW
 MvtS0R2daZbvtWi7NKTy3njOkWJRQK6TpaSkpcJMnaCt+n3lnX24yaoqePLuEb4CsJwmLGUkZXW
 SjOMojWWHVgqMxnadP7nb6Gov3yf0Pk+2lcz+yPvcKw==
X-Gm-Gg: AR+sD100u2qt4+BL+gTPODz7ZQ4ryRDmEngQMirzaOq/zMAtcMejvtlemPN+GyxhOGA
 gSIGs+lyyYNtUV4ktymO8wsKgnFuf4NUnGa7cPCkrGluPUbV9RAgDbMW+gEJbKTfO0/mOlrmZ5u
 7s2iM7Kl7p056zM5rfLRJvoQxI8A9Mw+vCOLp2m1XdFcrP5/LP6y9XLomfxFGh/EE6MFbprw90s
 dBc1o25GJD13gBr/UKicJ65yWoBfs7uWR/RqIBNuuY8+52s1ZoodPOoD47tLXrGIWrltoLpI19O
 yYn77Cfvs1U7CIFvW+QR6e/iAbsLrOw2jLFpO8ex2DYquixyNTOja5bePsz75qLdwYRvUdSVmPA
 y5KbZwXbTsKpO9SNxRDICLFpJkPX3
X-Received: by 2002:a05:690c:e209:10b0:7bd:cf35:e33b with SMTP id
 00721157ae682-8573fdc758cmr48264837b3.17.1787825299428; Thu, 27 Aug 2026
 03:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260822183900.110111-1-ombarkare123@gmail.com>
In-Reply-To: <20260822183900.110111-1-ombarkare123@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 11:08:07 +0100
X-Gm-Features: AcwNN1UyMbxLjzlWtpVtyG3Zp7fuzY8iafap0LupsXXIVqkjqBlUh1Js1jCdfSc
Message-ID: <CAFEAcA-f-=gP2GZEtTE7x=0mNvk0xL=TvHYDOvK=8GfVybuMQA@mail.gmail.com>
Subject: Re: [PATCH] hw/block: Add migration support for pflash_cfi02.c
To: Om Barkare <ombarkare123@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sat, 22 Aug 2026 at 19:39, Om Barkare <ombarkare123@gmail.com> wrote:
>
> From: OmBarkare <ombarkare123@gmail.com>
>
> Device did not have migration support, which would result in its
> internal state being lost during migration or saves.
>
> Add VMStateDescription to serialize state and set memory regions
> romd_mode to rom_mode field in post load hook
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157
>
> Signed-off-by: Om Barkare <ombarkare123@gmail.com>
> ---
>  hw/block/pflash_cfi02.c | 73 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)

Thanks for this patch; I have a few comments below, but mostly
this looks good.

We could mention in the commit message that the only boards
using pflash_cfi02 are the sh4 r2d and the arm canon-a1100,
musicpal and xilinx-zynq-a9.

> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 6f952fe7de..82965e6cdc 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -46,6 +46,7 @@
>  #include "qemu/module.h"
>  #include "hw/core/sysbus.h"
>  #include "migration/vmstate.h"
> +#include "system/runstate.h"
>  #include "trace.h"
>
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
> @@ -71,7 +72,7 @@ struct PFlashCFI02 {
>      BlockBackend *blk;
>      uint32_t uniform_nb_blocs;
>      uint32_t uniform_sector_len;
> -    uint32_t total_sectors;
> +    int32_t total_sectors;

I think it's worth mentioning in the commit message that we
have to change total_sectors from uint32_t to int32_t to
satisfy the VMSTATE_BITMAP macro, but that this is OK because
it's a value we calculate based on the size of the flash,
and it's never going to be large enough to overflow an int32_t.

>      uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
>      uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
>      uint32_t chip_len;
> @@ -107,6 +108,50 @@ struct PFlashCFI02 {
>      unsigned long *sector_erase_map;
>      char *name;
>      void *storage;
> +    VMChangeStateEntry *vmstate;
> +};
> +
> +static int pflash_post_load(void *opaque, int version_id);
> +
> +static bool pflash_sector_erase_needed(void *opaque)
> +{
> +    PFlashCFI02 *pfl = opaque;
> +
> +    return (pfl->sectors_to_erase > 0);
> +}
> +
> +static const VMStateDescription vmstate_pflash_sector_erase = {
> +    .name = "pflash_cfi02_erase_sector",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pflash_sector_erase_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
> +        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
> +        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
> +        VMSTATE_END_OF_LIST()
> +    }
> +
> +};

Why did you choose to put this in a subsection ?

> +
> +static const VMStateDescription vmstate_pflash = {
> +    .name = "pflash_cfi02",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = pflash_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_INT32(wcycle, PFlashCFI02),
> +        VMSTATE_UINT8(cmd, PFlashCFI02),
> +        VMSTATE_UINT8(status, PFlashCFI02),
> +        VMSTATE_INT32(read_counter, PFlashCFI02),
> +        VMSTATE_BOOL(rom_mode, PFlashCFI02),
> +        VMSTATE_TIMER(timer, PFlashCFI02),

You've missed out "bypass", which is also state that the guest
can cause the device to change at runtime.

> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_pflash_sector_erase,
> +        NULL
> +    }
>  };

thanks
-- PMM

