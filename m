Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A693C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAoI-0002f5-7b; Mon, 28 Sep 2026 08:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAoE-0002dY-Hq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:50:18 -0400
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAoB-0002rL-Ne
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:50:18 -0400
Received: by mail-yx2-x0d.google.com with SMTP id
 956f58d0204a3-6737f0593faso2350196d50.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599814; cv=none;
 d=google.com; s=arc-20260327;
 b=O/pYSaF+B9mTRaFrDDUmEl0lCpmzxA6FBkHiKYW1osikV7S6TnaJfuSeXKQZ6EmoYP
 eOtcrRfzhnPC1DaZbqcFAkGlnFNI9WQodJcCsmQI2zhJvTZIzTrgdsMJ93U//lHEwUmA
 PbjStPrH/cw1r5oTiODXgaKXu2NNk4qO5PbD9x7i93xeaBbEiwa9YRK6r8Y5DVNrnONc
 J+kNxo1BwXNeWqLFuLfAQIOzDOfozTfzB7IyEYaFUtnB6eJ64xZoH2m2LzqGgBLdSw1a
 P3EQZWMXYBcDGiGYn18d5nWVgpFaXkUrC9bC2RViX0siTc+Nir5NoeHJMIuXaIPvDFjg
 ghhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UkSTtv1Xd+Sp+B8p7qJWcGVsmA2u6wCcg0cN2mnhEf4=;
 fh=yWloI4x5GUzoz1Q5XLZmz6iISAvASOoYSEEdao9lxU4=;
 b=fH5cyXU7NaTd33/sZUW5DLBp7LGEHzucn1oE9+nPL7jhzkk5MhbzLd7IMZRzXZ9syb
 cWDizmbC6YH/Ux1P+wr+1ylQNU2YHPf7/NSZ5tBCcetp8OgI8HkVx3FusMzyA90PXc4F
 sUWh1YqYNaWxoMxnirNWuctpYWaLeERfwTdez8jx+5oUq2jsIWMTHwnh5yIVDf5CGV+e
 24zuyF7qfbNGFd4BYNPrcGMfxaPKk35Pi4rQ8UGdHDTHDJ0x3YIqrnjHiKLrmMBOmPOz
 qOzFQePLBmOJITKkHdlaise+64XQSUccihlvrwhL6zISHhZQnCXtN8WGo7oFxUg3FmHX
 LohA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790599814; x=1791204614; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UkSTtv1Xd+Sp+B8p7qJWcGVsmA2u6wCcg0cN2mnhEf4=;
 b=tuUYhiPm1G3F5bo3SM/pm7EC3vXFctsffV5IFfzaE/aRaRjN+vsPyPO0dH2RJAO5s8
 1u2sHa97uydRwIaClN49rb0knqsCteLKhuOXxHi6sXPoNZN/2hnOavs3NLXkKAF2xnGt
 Tx7otxIykadSAHFywzHJ/6r3hgdnDAMxYKAjweuzrBx1F+4eTUpw33z3jmXzUvCdvblu
 m6ZzyABEjLjbcEXJx2wikw3jG/Pnksf7WZjg5ZnqTourKDVCYOmycynbml5CvFPO/AtU
 r5Mx0Hlpvphk5XXUNA4GwH5NWrBpD7iA1aFTO3Jzxi56G2sv9pomKU1wREBX/6sTS43a
 OsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790599814; x=1791204614;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UkSTtv1Xd+Sp+B8p7qJWcGVsmA2u6wCcg0cN2mnhEf4=;
 b=bO25mJjHNbJSpMGfV+RO5AV6sVwhpbtWRe41PDsD5n1nE5/3FkN7WDLO8g3o32YmBb
 CZoHXCjuBZQ2mlQsEIv1Yz+7a2kCg6a8nYZ71zChpDBWvVS/UCnfp9BEncareK3ndy0h
 nh0jT3auM5FSJqC6fyzrdDBvlNxrHSdB9AqbXrJm/KJ7Uhf8GpjJ1MhmT0js/w2gsVcA
 sVdapJ+a79hre43CRzPJCPKYe4w01MxSShwIR14Rcftt5cs7ucG50/hk1f48qbsKf3M3
 Yaf7I29kMLgC3TUTiDZG1zpP7ASmX+bZX6MChe1OBlyXsI/PCJespZhJ1t0tW1RCeyXx
 /vGQ==
X-Gm-Message-State: AFuF++mHpZ4slaLR/eVSVNqj/A9qXEgqP/P63Hgk5mil7Vs0xsXR3UfE
 sVngwK3EjDynq6JVhDWLf2LgUDwq3k4KATFTkzK6LaKAtasHmPsj0U+5SbizERjartQkHWH8PMT
 /aYl94eX0XBEja/axzRCeXaf09uk5xUDKeRCtLg/xBg==
X-Gm-Gg: AYBFou2g11eLLDttJ8YTtQ6EJVAVJ90xpWyF9Q7uHk5j5sBZUpf9HXL8lzUc1pOY11T
 iWfxZ3Io9ZnPla+2nWxphN97FQJ5nLZVg3mzrrQPEQczsVQfXr3XNG6px97Cnwak1I1G3cA3gzA
 gLGvqFda3xjHzcLQ80dX6IVq0zxxo67yYwkpPcpy2OKZzlEnwQOWyxSViahCK+D1ZHRqIaPRup/
 oARc6FPhGHfDVyoXTm+YdMzZJ4L+OJLprSd7AZd7IpFQqcEW+Mpgli3c3wFXuWmuvjjApOs0HUW
 OX/JvOicPn0mIzuQ1Xjusi+2ckci8B939aN9BGizjlejjPgqSdXfBGjMmG4wQjhCFYFI1MMKTnQ
 ZbFOVYXQfWRAi6bczol/QrbqhzQTZsSd/P/aObAykZ1X8/lGSBjpH5MCuIZp/
X-Received: by 2002:a53:4910:0:b0:671:1a43:7cbc with SMTP id
 956f58d0204a3-672ed2a29f7mr4266086d50.27.1790599814095; Mon, 28 Sep 2026
 05:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260914222554.708582-1-mochs@nvidia.com>
In-Reply-To: <20260914222554.708582-1-mochs@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 13:50:02 +0100
X-Gm-Features: AclHuK-ofzuPc0BVsA6kbRFuUKCb7XW7u-SjRbkD9wpQ9GH4DLbsclbX9-rBqkE
Message-ID: <CAFEAcA_yBV-F5fMhgxTcS5iwLzq+6qFR0fUmXibBUH6D5woGeQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0d.google.com
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

On Mon, 14 Sept 2026 at 23:26, Matthew R. Ochs <mochs@nvidia.com> wrote:
>
> With CMDQV enabled, resetting a guest after it enables VINTF invokes
> the VINTF page0 unmap path. The resulting crash is intermittent and
> has been observed on the RCU reclaim thread as:
>
>   reboot: Restarting system
>   double free or corruption (!prev)
>   ...
>   #5 address_space_dispatch_free
>   #6 flatview_destroy
>   #7 call_rcu_thread
>
> FlatViews retain raw MemoryRegion pointers and release their references
> asynchronously through RCU. The VINTF page0 unmap path removes the
> subregion and immediately unparents and frees it. An old FlatView can
> then access the freed region during teardown, resulting in a
> use-after-free and heap corruption.
>
> Embed the VINTF page0 MemoryRegion in Tegra241CMDQV and tie its lifetime
> to the VINTF page0 mmap. Initialize and add the region disabled after
> successful vIOMMU allocation, and remove and unparent it before releasing
> the mmap during allocation unwind. Guest VINTF enable and disable then
> only toggle the region with memory_region_set_enabled(). New FlatViews
> omit the disabled region, while old views continue to reference valid
> storage.
>
> Keeping the region initialized across VINTF disable and reset is safe
> because the vIOMMU association and its VINTF page0 mmap remain stable
> once the guest CMDQ has been initialized. QEMU blocks hot-unplug of the
> device that established the association, so later hot-adds reuse it
> instead of associating the initialized guest CMDQ with a different host
> SMMUv3. The CMDQV free_viommu path is therefore only invoked while
> unwinding initial allocation, when the region is still disabled and has
> never entered a FlatView.
>
> Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0")
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

