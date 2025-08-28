Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA0ECA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBm-0002Yo-3Z; Thu, 28 Aug 2025 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdes-0005bK-Qc
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:31:22 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdeq-0007sC-PP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:31:22 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e96e987fc92so819337276.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391478; x=1756996278; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=odRn/LCpifxKdFvhKL5g6U/B6u9xEKUolCSxRT69Cxt3bFsAIJHxWy8rWjnulVEV3r
 hJvoA0hok4KflshKR+wEr3zrLzjpyWBb3I3qJx0KaHpHM7sdY3duUNKGHY8hEl1qpela
 5sojiwJKhQHSrYXVmPhbHV6iHtDnbfZAlEv4n+PNQP/LHwy/KfxeevG0ooVl5aqvbxVz
 OUIpsWh35YeuEZnv4z9tb3Hh3pVFXHCicGoByQJ7S4JjPBDi4IWdA1YHSk3TikdLHI83
 73OMr8OilnLfVB52fVuDh1UhxhKF92uZRmiL8hek2TBbY4dAGHl72+I/YXjGYnG4g00Y
 Us5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391478; x=1756996278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=vK8Xe/EaFyU4CuA/fUU06y/Kj0QRdPc3AaSyhX1C8qmErfW/7XdkNvzCrmKC/pO1/i
 /5YS96TTm/NxJbRGcmgd5kpApfRRIehBA1NmWx2iOIWVh4gS82VLN/rQyLXVxDvkke5V
 JeB2Rb4IgyKdGrE5id3F9/6rPdUbC60a+jbZFmFd5uV9tFPrTOIU/SOErjU35Bp2GpYv
 b/FrWMuy9D9MBvIHbw2Sy56lnBDyeK+iSX7DerQL4BCVfyq3dSyqQD6Skvp7gcDu9deA
 CfzwwV9J2BKTzbiZJjvWBTvRieyJ9+TureldeH6UbejDoi1wgnCmjLnKRRhTPAXoZzGo
 h7ww==
X-Gm-Message-State: AOJu0YzddgM/S+E+TCrcgGGx07XYszFB+fh7P8GDmXDx4vcEtvi2c2Xr
 r6eWkMzTS+rDVQxk/4yn+sky8C0LatEx+XTAJL73WPWT8tgfi5MmLski0uWuLzigKy1A4jTySe/
 D7PnBohIyMt0E6Cm1eB600ARUxZCYi9Ffp3mPqytLkAAQEozwgVe1
X-Gm-Gg: ASbGnct/8Wk8aAAPwn6hiEuMTn3Kb3aRjeGxHxCFdVQMzgEm9C8nz+avxdyjHhDd7DC
 sZP2y2TU67Gwt8873DDaYBMd7EEXjb650h449/AJzTd26N1iWJZQRwWa6SRDsA3AvuB/zhL7ina
 2Ly0VvOYuo/lEONIEjW1mGcAnvKod8UTt8j7C8iqg2G24P24jWSPEflyOJJNTurU40QdiNlRAl0
 L/HlH2M
X-Google-Smtp-Source: AGHT+IGU+H2WTH5Dy6RpPvW6/wllpupjNA4so2ggqFU4zGZJ0ajAGoBjxDZmG/Xu8ZcZof2QTSiOWHden/Cn0aC1pOw=
X-Received: by 2002:a05:690c:86:b0:71f:b944:103a with SMTP id
 00721157ae682-71fdc419696mr240979077b3.43.1756391478282; Thu, 28 Aug 2025
 07:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-22-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:31:05 +0100
X-Gm-Features: Ac12FXzJQmJaAJzm2qVWaZVy4N_AGdYD3xkGCWhFwV4JYvKcfXeBlonKt7rWq3k
Message-ID: <CAFEAcA87aWRMqDBCWfcZ-rmvYaxJHWtvwB1P5_cxU5k4poMDXg@mail.gmail.com>
Subject: Re: [PATCH v3 21/87] linux-user: Move elf_core_copy_regs to
 loongarch64/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

