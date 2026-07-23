Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A4CC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsTr-0004G4-Fo; Thu, 23 Jul 2026 08:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wmsTn-0004Fk-Ox
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:24:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wmsTl-0005yZ-KT
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:24:47 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so132249b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784809484; x=1785414284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QMYq/dd95LqCEYo6ZRQD6uKoyaoGYN1na0WK9niILfQ=;
 b=lUvjK8wDJbuOW76xG5UK4UFgPj5WSxSS5ah+TT7GtFnkb7RbzXdku6oxjgwFZKXXeO
 /SgBJf0RHRjkIi1ysNIzDus4/GYEsRli2s9NsXUEJQeQiYHEAAb5EXnjvdPTyQliKrqG
 K43Mi832zYN0TQeVN3YtMn/V4z5rWDmY/oDYL6sXMGvQ0rUjp5BtICwKWPmc/2XXlGUH
 lVFhg+dDUI8aph++yqAIQyey0VO0HPEu05N88zXjAK3p7b0Mg0qwpWf3H8WsctTc/OTz
 2v7DpEnWRg93iW9fa4iY+KgsuFmSvh3N0MTyWrObpYp6kjJ6KZwvdlUT/96jjp7DexXu
 8x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784809484; x=1785414284;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QMYq/dd95LqCEYo6ZRQD6uKoyaoGYN1na0WK9niILfQ=;
 b=Oma8kDr0w9EeXq4pVqzQFruaNrk7m6kJy7yQw4eRR5jCp7J7nn61WICXWNyvMgIAeE
 X0gxa3NPd+5bMgpjZXs3koCL92yX6qQjt/a2tdwY80G7yL3XgkQw9i9hMvWKeCmT7UqO
 CC9/0GPDC6OnMkBrE5gQlFtR2zS5VD4EMSNr9zwiFgSNCAtiqekVWqnY/GfE0DxilKWl
 EEWPpYVLWjavy/55BQelPtsQqxzztwrujL1bDYB8r/FoY1kHqAfS2cJsGXHwDa8f5T8g
 XziRzgqkLQ3QQ18y5VQ55xZJZXamtgq/y2MdRukDNsg0cjv/pJr8OFfKPpXJDvDsrKI1
 qtvw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPGY7RyONmyekfaNA+xk60QHe8LfjSci7Sk+njhvM02ynDMKIZQNBocdquQ6agFoz/F+5ZZlR8sN9/@nongnu.org
X-Gm-Message-State: AOJu0Yw77A+GekWfSBPdVNLT4JbbOwCKifvlK6rGX5KueWK23cEgKwHs
 7rjb7AIx9b0lTWLqOwGApA3/IrbLstt4CIo2rE1BKhlAKsmAIo9sBKPt
X-Gm-Gg: AR+sD11WgEc35f6Gv6byUDoXcKGbOYq+xBcKtqjKMVibbZnMF3MzSe9KLkrRFHSL7rY
 QHPBlNvtFP+etteaQB0Oy5E6L0hO6kAAMHRjZ8kxrkYm1BNdBAxLyXM7qMmOqYbXZ0j9BOPiCL9
 MzrGDy51B/UpshbLjr+y8y2mPWpnM2EG1sacoiuttBKm5sKkoMMSoe/jGsulJO4T6/Ag+D2Co0b
 IS1qIefQqP1iRJt8BQoAwdu+a02LaW+jj8buFsvQ+bA8ukaI/9S9ZXVFNwNDiofsvlG+vWiidkA
 C9Nujwr3K7K9bGN59E3j5JQB/FlTP012mbGH0vWuDJzwAPPEsAYZWhma7/VlZqxNqllaRUbczty
 HwNvCzyYoAxQvqk2tdu/Z0LF1yJM7fjBl0wXTdo44smVgOnozS3q8gqnrirZTtEcJlvvE4YVmrz
 W2wg8RRPA6c/m0OXuBzRVhc8sHDchsA3OfuF/GYWY=
X-Received: by 2002:a05:6a00:451b:b0:848:584f:7e41 with SMTP id
 d2e1a72fcca58-84e2bc2ff9bmr3008254b3a.78.1784809483480; 
 Thu, 23 Jul 2026 05:24:43 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175a29aesm2955277b3a.41.2026.07.23.05.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 05:24:43 -0700 (PDT)
Message-ID: <50783cef-7d88-40d3-8a20-2b294b4129b5@gmail.com>
Date: Thu, 23 Jul 2026 21:24:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: validate primary surface stride against
 width
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260720114513.2500370-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20260720114513.2500370-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2026/07/20 20:45, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The existing validation in qxl_create_guest_primary() checks that
> abs(stride) * height fits in vgamem_size and that stride is 4-byte
> aligned, but never checks that abs(stride) is large enough to hold one
> row of pixels for the declared width and format.
> 
> A malicious guest can create a primary surface with a stride much
> smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
> surface). The spice server rejects this via red_validate_surface(), but
> the return is void and QEMU unconditionally proceeds to set up the local
> rendering state. On the next display refresh, VNC or SDL reads width *
> byptes_pp per scanline from a region backed by only stride bytes per
> row, causing a host-side out-of-bounds read.
> 
> Add three checks before creating the surface:
>   - reject unknown surface formats
>   - reject zero width or height
>   - reject surfaces where abs(stride) < width * bytes_per_pixel
> 
> Fixes: CVE-2026-16271
> Fixes: 3761abb16784 ("hw/display/qxl: fix signed to unsigned comparison")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/qxl.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 4a56f07b157..36fc681cbfb 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1524,6 +1524,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>       QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
>       uint32_t requested_height = le32_to_cpu(sc->height);
>       int requested_stride = le32_to_cpu(sc->stride);
> +    uint32_t bytes_pp;
>   
>       if (requested_stride == INT32_MIN ||
>           abs(requested_stride) * (uint64_t)requested_height
> @@ -1560,6 +1561,34 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>           return;
>       }
>   
> +    switch (surface.format) {
> +    case SPICE_SURFACE_FMT_16_555:
> +    case SPICE_SURFACE_FMT_16_565:
> +        bytes_pp = 2;
> +        break;
> +    case SPICE_SURFACE_FMT_32_xRGB:
> +    case SPICE_SURFACE_FMT_32_ARGB:
> +        bytes_pp = 4;
> +        break;
> +    default:
> +        qxl_set_guest_bug(qxl, "%s: unhandled format %d",
> +                          __func__, surface.format);
> +        return;
> +    }
> +
> +    if (surface.width == 0 || surface.height == 0) {
> +        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
> +                          __func__, surface.width, surface.height);
> +        return;
> +    }
> +
> +    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
> +        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
> +                          " stride %d width %u bpp %u",
> +                          __func__, surface.stride, surface.width, bytes_pp);
> +        return;
> +    }
> +

It looks like this check doesn't fully align with how 
qxl_render_update_area_unlocked() uses these values to construct the 
DisplaySurface.

First, qxl_render_update_area_unlocked() ignores a negative stride and 
constructs a packed DisplaySurface for it. However, qxl_blit() still 
uses the absolute stride to advance pointers inside that DisplaySurface. 
As a result, qxl_blit() will perform an out-of-bounds write to the 
DisplaySurface if a padded negative stride is provided.

Second, when qxl->guest_head0_width is set, 
qxl_render_update_area_unlocked() uses it instead of 
qxl->guest_primary.surface.width. At the same time, it relies on 
qxl->guest_primary.abs_stride, effectively bypassing your new check. VNC 
or SDL then reads this incorrectly constructed DisplaySurface, which 
still results in the host-side out-of-bounds read.

Regards,
Akihiko Odaki

>       surface.mouse_mode = true;
>       surface.group_id   = MEMSLOT_GROUP_GUEST;
>       if (loadvm) {


