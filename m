Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6274DD6B08A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUvJ-0003t5-Go; Thu, 29 Jan 2026 11:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUvB-0003q0-OA
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:31:11 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUv9-0002gm-CY
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:31:04 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7942b9663f8so11211887b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704262; cv=none;
 d=google.com; s=arc-20240605;
 b=gCkrdk7P7yu/+xHNoFXisBaPyPCPr2b5QBptgeTGZNcGPfo7a4VzrwUTJP8mlC3wA0
 VKWn9YCDTOmGy44NTSlE2fzZDCMM+4aeaoyti4rmUp+5QlRkifzQFDa0cU2uYIa+Jasv
 Lyz0zSZ4sD+jW+uCehj2ESNXyVIWwZj/yHItbKLCCS15/os1IgEnnztSJT9uB9MXf0xd
 YYE6dZN7pZMRCQPZ32XyUPP9m0sF+JLDtQx7NhfB/9cC+ta+lv+oDxixPMoQCQ4OPndO
 m9fER7tnAjyKP/whwXxIFhhj3HAc9tFfAktFPWECkBv9PXkMIfFyVhAVad7Sz+nACwQC
 pxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R/MHn5mAVDXwdLvHLjktXHICtC9EsrPYXgM+gYWevIE=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=hNsKm0378NMnr9TlfzhvDYvTEaM4LMRFCZFZvho3uiqzjyIvGaQD/PRnFONufhI4yg
 xX1cOeb6b8JL96ykr37G+DRS5V1NxG2VGEtwwOD71QRV115praWY825fTloYA3Tc+7mP
 uEKMzGCkHvfxXWAiN2uj6UT6fcLjDmNZMsalXqLKszp+v3gwIyZv3/TToR/kDywruY2b
 rTBSPO6X+nbje56xwhkJEUnIEGOawXciYYWlqM2oyJ3UKPHSlN76oVuzQmlIByJH6Bry
 d+M0pvbeEOmtLMdA16mnn1ydKmEzoeMelI7CpAzMGiPs9ZUBpJovGcXrDkmTwkkccI2z
 N/CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704262; x=1770309062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R/MHn5mAVDXwdLvHLjktXHICtC9EsrPYXgM+gYWevIE=;
 b=DabwZWD+F6mmkf0Mcpde3+7Lkf3TvFegVdAY9tDhi3qh74NGjBMKdhsMdymD6ZdTTM
 9iPemz3bs96zfHiWckC008neW66DefJPU6mmfFfFoWyAi2L8AX91Djb76YCfWFTcvN/9
 zdUOHL3CFu6nYdZlvfL5GuLOl2/vf901gPY0KxIy+VPikQNmuL1tdj0TLM59YnuXuZ0i
 8C4D4iDEl1Awstvc1y4pZJUVMgAedryu1EBGA0ozjauxy2o59zJQpzTHd285urP4xfsx
 SKIBV+Yuf6a8nuk557tWRGpf2Hj5ut4EcxoXxx13PoMfUMDN729VQL/3HsfCmBHkAZKh
 tz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704262; x=1770309062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/MHn5mAVDXwdLvHLjktXHICtC9EsrPYXgM+gYWevIE=;
 b=Dwal0JhdVApI/btaVMsXpzmWQTr65eunDcFhAV995Uy8dLHnzM+EK1E9UOZb88fPtg
 Gcol0TLJ+rER3XMpTZqtYRfMwBYfyUWcZVNUhRW0QCWuvpF4omz1/Z20xIoOau0FIPFm
 MR4gigrZueujLxyxqRVJY19u0vIhHZ5OQ2p5vqAXy4IPwJ8EZfmoMm8xRQdQCDsHQ6mW
 VO+8yFPmAr1VC4IeLWDsO1LiYRAvWM6eknHkK2YYlrJYjgPcJuio89pbtywtIldWICUz
 yXc87SnVEUQe0thutCddASg1JdDwwlr8n7GURkAbtMnYIC0lpwkOS43wVpgFe06I16Ww
 De0A==
X-Gm-Message-State: AOJu0YxPw3ppXzpNd7SX+VruP2Tq+B00gIb+eV9CqTEsV5yTPHKxrxcu
 iG/selQ04j3tnVf16h7w2uFLWuyTwRUzSS2Yut0jTJxLCfB+073PlOC16vdlJXDWqM6Bgpf6SV5
 Z13cE2HaedEuGbWtPFtROeprEAhuRtzr0dib5UJ9/Bg==
X-Gm-Gg: AZuq6aIH8etKvH4zbivv1+Kq3+wV1zBo10Rgcc0nVLSBfGL2ROO1rxwkcA9y2tJp+KA
 n+6JpXhO2k/DWCdVwBtyeHmfbS+biK5UqHw3SXl+3MeC+d19EWCL1kycqGl5msqrZ7L9lgtOIfR
 Lco7mtzdRLAiZ1ZaTYnC/n7Ipet8fOYH+8PQj2BQ6pn71J+HoZfWIXEdZ/GDloq6C10Mr2ghtJo
 a/9ruHeO4aeBFKWN0/PdDdw5gDVzQknF0WdTzDz+k6LUP3uA1OA4fScWyvEEfOlGQyoSA==
X-Received: by 2002:a05:690c:38b:b0:794:26a9:f9c3 with SMTP id
 00721157ae682-7949e051875mr1571577b3.63.1769704261898; Thu, 29 Jan 2026
 08:31:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
In-Reply-To: <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 16:30:49 +0000
X-Gm-Features: AZwV_QhtWGanmJ6ILzcPPEtrz5hTq41f74se6vXytg_CKwEKDuCtiUTCCW-O0gc
Message-ID: <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Nothing else does this, convert to regular memory_region_init_rom().

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/cg3.c | 5 ++---
>  hw/display/tcx.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index 568d6048a6..61bdb0552e 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -282,8 +282,8 @@ static void cg3_initfn(Object *obj)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      CG3State *s = CG3(obj);
>
> -    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
> -                                     FCODE_MAX_ROM_SIZE, &error_fatal);
> +    memory_region_init_rom(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
> +                           &error_fatal);
>      sysbus_init_mmio(sbd, &s->rom);
>
>      memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
> @@ -299,7 +299,6 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
>      char *fcode_filename;
>
>      /* FCode ROM */
> -    vmstate_register_ram_global(&s->rom);
>      fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
>      if (fcode_filename) {
>          ret = load_image_mr(fcode_filename, &s->rom);

This is a migration compatibility break, because the
memory_region_init_rom() function registers the MR
for migration via vmstate_register_ram(), which picks
an ID string for the memory that includes the path
of the device, whereas vmstate_register_ram_global()
picks an ID string for the memory that does not include
the path of any device. It is this difference that is the
reason why they're still using the _nomigrate functions.

I think it's reasonable to accept a compat break for the purposes
of cleaning up the codebase, because these are used on sparc machine
types and we don't version those, but the commit message needs to
note that this is a compat break.

thanks
-- PMM

