Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87587CDE018
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtfl-0006K1-FZ; Fri, 14 Nov 2025 08:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtfU-0005tM-Tp
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:16:55 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtfT-0002IS-9R
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:16:48 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7815092cd0bso18909837b3.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763126206; x=1763731006; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4IyIKZFBmHVETvf09ZtZ3Oav8iu5fHOkmm9MGs84064=;
 b=Ip9+PS2fvXysGjP1uAuVvr6zOzGaaNPhNzY/HLVrNWjfvOP1R7q3oQaLuD1pwOZC0j
 x3+46XQV9YT+BsnxXlenO88h43LjlVybKN/Ga+cSGpyCioykAYAO5MUSQHIVj2HFNWYQ
 jDsgfMahkp1LNwAMZfkt/a13+FAehsrmuX6nCc8bsPAU5J7B4DyGxtTxNsRD8+9xomht
 ry6sbNgVO75YAHgDGrc+x423JV768FFa4owHTL4CfhwaMvgPnDGAssiXGLIGvz+OPcKq
 Hvix76yJsqwBGoFTGlpF90/WxCQe0W3pW0Y0VVG4qildB6OYAehdgl+a991zAPQFeExD
 WBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763126206; x=1763731006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IyIKZFBmHVETvf09ZtZ3Oav8iu5fHOkmm9MGs84064=;
 b=rRUvZ3+MHrAyIo58NdMRvia2selQB5hwAwIFXuOSqw5HNa8ihQ2lO4wuoadBiu09uD
 ecVjpVQhXx2KGYt6fUkEst8VFq4/5iUUUiVyInESnXNzXHaCbcudwgmprD5VT4/HQqOB
 QQkfSEw+G+YwBu4BsLlF92fQPaAkSY91FUoQcbn45ZvOwQjuszjD9b4YmGtp6eWgWl33
 NGuc+KAg5dtXCMtVVGR+SGYRtt+Ngv+v1a20dkaHNuOfF2PkJ2QCdIFrYx4kVOgVxiB8
 38sT4gGWSJUvwBSWmUsJGDrq8hYsXCQIhLTpqrS97+bFWPjM0WgZxcsT0GLAcxCNY+ow
 dhgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJYLMftAz9MVvXSwBZ8oNTBt18h5jYVcmlttAw8CEu7pJYpEL/VkyybCgjTetzvchvVnVkquucw9q@nongnu.org
X-Gm-Message-State: AOJu0YyPEuupqHdTMEN7zl3zXjabjutrvdLwONK/krkHQoHAJ+CBDBr2
 rENNxj5B6wrUx/U53pX1hMK4CYlYlWN1CIVr3WjLr+GDB+F8pWUyAbK42CJRc71gl4RDhSKc1mg
 0duTu09NFgG1WUsn6okPzGy8pc84cN+GOS9WFHlP0toxg+dTRALPbGiM=
X-Gm-Gg: ASbGnctsh+F2eDclXi0JjpC46VVc/eyE+b+WoXKvf8pdSzCXrqkElu8J87dLkfJL87B
 WHDHHfeZN+A/wfEHb2qF+sHu8IE+F1DqzqoCcg1VZOaKpZJsKWY0jooELwhNwZj3GgDNQY9Usuy
 CFo0igsK3vyLNZHBQquoVz2zicqe/rcrjfu1j3zv+F8Ez1yvrXiJ9SLB5x5AYyKMiCSGaNcRabO
 m9ICxIqwyyv+093Vb84ned9dFx3O01A0Z8rr30I2rFbmTufe2ernGbnswAsVgd23ySasGzO
X-Google-Smtp-Source: AGHT+IFhRN+Azr3gUEK0bqvU3vlEQ3RfVgtnw7N5+2b8L9y4y+PKuDF7mUf3YbAdY7GwiqaKLerUAEG+gcIwCtKbWK8=
X-Received: by 2002:a05:690c:5086:b0:788:e1b:5ee6 with SMTP id
 00721157ae682-78929f4086emr40008227b3.70.1763126206095; Fri, 14 Nov 2025
 05:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20251107143913.1341358-1-peter.maydell@linaro.org>
In-Reply-To: <20251107143913.1341358-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:16:34 +0000
X-Gm-Features: AWmQ_bnB8ak65mO4-BDrYlIMr9FeSdCSz2rNziwD75WVUlq1J-S332_kcYFbtjw
Message-ID: <CAFEAcA_M6dO2L8GEFm_LafpK8sbGWTiTp1aD3sWxQxtsjnV5aA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/exynos4210_fimd: Account for zero length in
 fimd_update_memory_section()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

Ping for review?

thanks
-- PMM

On Fri, 7 Nov 2025 at 14:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In fimd_update_memory_section() we attempt ot find and map part of
> the RAM MR which backs the framebuffer, based on guest-configurable
> size and start address.
>
> If the guest configures framebuffer settings which result in a
> zero-sized framebuffer, we hit an assertion(), because
> memory_region_find() will return a NULL mem_section.mr.
>
> Explicitly check for the zero-size case and treat this as a
> guest error.
>
> Because we now have a code path which can reach error_return without
> calling memory_region_find to set w->mem_section, we must NULL out
> w->mem_section.mr after the unref of the old MR, so that error_return
> does not incorrectly double-unref the old MR.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1407
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/display/exynos4210_fimd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index c61e0280a7c..eec874d0b1d 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -1147,6 +1147,13 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
>      if (w->mem_section.mr) {
>          memory_region_set_log(w->mem_section.mr, false, DIRTY_MEMORY_VGA);
>          memory_region_unref(w->mem_section.mr);
> +        w->mem_section.mr = NULL;
> +    }
> +
> +    if (w->fb_len == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FIMD: Guest config means framebuffer is zero length\n");
> +        goto error_return;
>      }
>
>      w->mem_section = memory_region_find(s->fbmem, fb_start_addr, w->fb_len);
> --
> 2.43.0

