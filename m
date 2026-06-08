Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B89CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWX1n-0000PK-7A; Mon, 08 Jun 2026 06:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWX1l-0000P9-EH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:16:17 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWX1j-0008Vi-PI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:16:17 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6603d8697d2so4107525d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 03:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780913774; cv=none;
 d=google.com; s=arc-20240605;
 b=geEIqX23sirBgFi7YymDptSQktIswsFfHnA53M0aBtz7U5haNTyV1MwozjEl5EvmgB
 rr9NPK9yvAhachIeiDZnwLwMToTf3hSyLjWLjVUHArvQ0SoI0x/l8qSQBe5u3eqLX64q
 8sr8fSYa1qJNZq0968plKyeEayvDlX2NquZLOd7i0BM44vcZdct7gsLDWi/pMyY6hlT8
 aFDodD7Rwm99Vx9QehZ3quzIjvk5NK/RLgBfeO+froNUUgpP+d8GlnvhhAsCrqGO8mOk
 6TduZQF3KWU/O1C+rZ/wehYIOu+Z7FCdW1Pi+4wjbi9AqlwlvDup2WlNsk5oyNp+WE5J
 5A5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QGuuAhxdhLDTl8Q62uqAMX4uEPp+7gCtP4LjYBJtM38=;
 fh=6yEZjd5NdVG+vzksKxBmvkCzdqZLbQNnGzOAhzrpQV0=;
 b=glKBIHccAUov124v7lJrYea+DgvEPZWEif/Mrn6MWRnmxbsbOIE7sLO5iZPvGei0c8
 l5/qZVWmszGkV4s+vFVepOu0ealrQV0uMFArOrKeb0The7DltMHgpuQNDy22X6n4K6Wt
 +cdau0zfusnr7rEcUjQmqywLPH5qncDRV9dDrGED+TKR+msjPV9GL/DP6V0vblGBeMyx
 J3Sb92Whfs8yoeygyv85eDEudiy1srPzayHFwF9pKamad4Y3+ZB0AysKmOwr2emQxrN1
 7a+U+44o87rogOL0KJnyN4cLeQS7D1bHnmeOEtJDrdPs5PeISrTAzlaEewKda/Xy40M8
 lHgw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780913774; x=1781518574; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QGuuAhxdhLDTl8Q62uqAMX4uEPp+7gCtP4LjYBJtM38=;
 b=zocNihb5FXIaj5pjYLi40MrOow9dkhmKJ5Oy2Yy40FYCgBdS6+2l72DhGp/+W3thIX
 umENZKgu8mobOMNpLautAlSZjWX4GAGE7bsYODyh/Z5MKYxC0QHMxYMcAemSgiVk33T1
 IBBiwENELprUQ96gq8mHz78BlKfvMFz54XrckwLDdVoCE886lPTOVaenPA8lOGdkQf7a
 nrH3HBeD+eeMktjM1wYif8CmTPbdiL9pJ6g/aABQ/YD2EwSitA//laHbc5MZAij1EoTy
 /+IcynLbX4WnYnOPq6fQ0CXgBXtMRme+xyKQBPRiVIWj3Ql1MgHyel1pYunxuWQLS0lW
 O1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780913774; x=1781518574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGuuAhxdhLDTl8Q62uqAMX4uEPp+7gCtP4LjYBJtM38=;
 b=NhShWVxe22QPQNHq/Lwtrl9XNVJvzCxSciHw/ZlCgH4RoUIg4Cmopol+JZvv21ap9T
 7UuOj6dHlUZjxiz6q4Rean7Rg28h8flKnoSLwPY0uca9rbQO6RzDw33kVMv0K5gYgXf9
 kgza1eqUpPuRLjp78PShYh5cb2d/NzOveeOm3hsbaOp7iF1g0/CwtkLr4FqYc4G1rSiQ
 G9ExeGZ59sOgt7PtqHkyf/GV7Vjo8MGLQbImHdN6BgqltkhibiLG9bTb42gUdOcOZL3X
 jumafg5cFt3v0Q6Du+WnWvEYUr4tEtU+RR9EdRb2OMQl983BGl6iuOMkuF0MeS322CYE
 ckMg==
X-Gm-Message-State: AOJu0YzjA2FzXHZRspwxL5T7Bq2N4dGArgZ9N6x8qbT/Qk7UJxg+whoS
 laR2fVkknYs8fz18AEy2WtPej0r6bXHqA2TTC5e0nzmg6XKlyHDYBsVQza/zWyU4rZtLRmutXG6
 Ixy4RtufDXButuNU01eBHAt1237fse+uNTitoSpbrfw==
X-Gm-Gg: Acq92OE+ku5R5NKSiRpv7aM32Vhu0mOn3XouYxTFIL6wkPUKuC1p3t/nq739B+tH+C0
 dtR6SEAIUspbaK0YPv71BrJHIp1TF+/YPR3/h8kjtsakPxNfdMeu17UWNCMxbOqh5wO0Fl8csv9
 T7hIgyxI9yaFTUYtT4Pd5+Xwmm+18BPqINrBKq3j6eYYBFD12YQj9cGAzA2R296FPsZeqCgwO65
 vKbvIYudnaXy7SqYOK2fwAqMuqOa8c6t5zkXXZSvyrNrWV+WOPWxmJb/mGhG3ULGQaqD8DbyFzm
 DxIP9fPfAOs4R/Nmp7Y9iCLrGLdqkDW1ZSvd5zTz4CnxZoQoJ7P+bjOQvAoovwPp7mIvILWVpLa
 Sfg==
X-Received: by 2002:a05:690e:418b:b0:660:5520:1b8d with SMTP id
 956f58d0204a3-66106ea5388mr11917786d50.11.1780913774035; Mon, 08 Jun 2026
 03:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260602155058.392042-1-audgirka@redhat.com>
In-Reply-To: <20260602155058.392042-1-audgirka@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 11:16:02 +0100
X-Gm-Features: AVVi8CcZt5STiFyx_WkeWKjhioUXYhD6Fnh6Ldrubw11HZN3hD9xAXFMmv-P59k
Message-ID: <CAFEAcA-eDESmT8FYaFfpmPGC_vRZJDAO6Sk0JzBiJZbnmcUBrw@mail.gmail.com>
Subject: Re: [PATCH] hw/xtensa: replace calloc with g_new0 in mx_pic
To: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>
Cc: qemu-devel@nongnu.org, Ajinkya Udgirkar <audgirka@redhat.com>,
 jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 2 Jun 2026 at 17:12, Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com> wrote:
>
> Replace libc calloc() with GLib g_new0() for consistency with the
> rest of the QEMU codebase. g_new0() aborts on allocation failure
> rather than returning NULL, which matches QEMU's allocation policy.
>
> Signed-off-by: Ajinkya Udgirkar <audgirka@redhat.com>
> ---
>  hw/xtensa/mx_pic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
> index 098c1aa..8ded3bc 100644
> --- a/hw/xtensa/mx_pic.c
> +++ b/hw/xtensa/mx_pic.c
> @@ -343,7 +343,7 @@ static void xtensa_mx_pic_set_irq(void *opaque, int irq, int active)
>
>  XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
>  {
> -    XtensaMxPic *mx = calloc(1, sizeof(XtensaMxPic));
> +    XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
>
>      mx->n_irq = n_irq + 1;
>      mx->irq_inputs = qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Ideally this device needs to be converted to qdev; then it would
not be allocating memory here at all.

thanks
-- PMM

