Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0BDC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiRZ-00048n-7V; Tue, 18 Mar 2025 21:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuiRW-00044l-HH
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:42:02 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuiRU-0002OY-VO
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:42:02 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d5e3ddb66so2676433241.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348520; x=1742953320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSmwocHqgMjsBYzYb9/eIZQjGI55RdotARgt4/zoeDs=;
 b=hfnQy0NcSSWDWTLIMy0Zbqjk4cOZML8UIhLTVXSkg4L4FTUokZE/4hQ6wVSsVKBf3Q
 mIJ+bqEEWR8oqdzbT8NMR7Q/4xORMNnF6ZywQTJZdT7IMNKmoq3ajFcNHjtvjOc1dTJT
 UXqgfnHke4yAGlZ78qJFYCAFKn76QtYa0F8JsJBRu4clRSOEAS+Io9jGWyvEwVsZ4znb
 CJwfjFjGzfJIPx0TJdahXTC1Z6DuN3N2AAu8Wq+a5V+80KfJBrbjS3iK8O82UkpLISNj
 1DU+a/uNNuG+NfmmzuuVOIKjfJmlmqRmAnezVlV48I1mMzLKutQfFKCGOVJwllCgvf3s
 p42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348520; x=1742953320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSmwocHqgMjsBYzYb9/eIZQjGI55RdotARgt4/zoeDs=;
 b=fuHSsUTXQKwymASpzeT2XEsRJUpnf3qtSvSwVkX2KWlRv3FMgwWjR1GZ70q8+l6DHM
 xDz+roef156/ray4hDkkgy2kpSb2u2xi8XpUungV4vUCbv+IwrVgOpcH9xkT0morXuXl
 MdLjPsVaoDEiLqdmP9Tu8z0OhhNVkBU9m6LJ4N63Lm/gG++FfgLCUE+SnCT6nOV6tuAX
 5cQ6wgF9brLDH7MLSiUvsxuCSySwRSQK5wDMYrMIw64MMIiJP6slXCvA65y5V7Ei6NvQ
 JnEe8dI64UtSPY2e5CV/keHqb7pogg10yVFqUGdxSwuTAB1YdLRl8JrVvVeq4dQqjZOK
 +KnA==
X-Gm-Message-State: AOJu0YwFj7OIJKV+0PnUOCDK9HJAFSo6E8RKNnG0Way0WZ4V0hFYRiJv
 a1rbLoSn/MMqyL/50S331Jlw3zPGRZSjlVayuPXycTqx/3j66xWD1s8LJGgaz79QOaD6fW1+Eq5
 VN5z5aEZuMeWpfX6mtTQQFqApQw8=
X-Gm-Gg: ASbGnctLsmFYiuOV3dZkbcAUk1yPmRfLICahJJlPzB8u0bjduEkXGIqXJ9WTvU/VHqC
 5MMzxn1lqe99nfyqSgjVIAw4MhFdiIA25YZpOYThaESvtXlbjpYLsSvUEeijUoUKRh1tKoQrKH+
 65wVOSryExdI3cDQxs5Unj7EQ6mZk3OvbovEESXAECkUZxUfFG7D/tnh3AIEwwxB8AZw==
X-Google-Smtp-Source: AGHT+IH0UckKIORUjaGexLgh/6tSsJoTNOmMJSbrWephakAV0FseZHtUv2D+Utkh4FkGtpDnT8fUMFjS5RY6E0/xTsI=
X-Received: by 2002:a05:6102:2c02:b0:4c3:c9:c667 with SMTP id
 ada2fe7eead31-4c4ec83c0bemr812283137.24.1742348519781; Tue, 18 Mar 2025
 18:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-42-richard.henderson@linaro.org>
In-Reply-To: <20250318213209.2579218-42-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 11:41:33 +1000
X-Gm-Features: AQ5f1Jq-IsqI_hdW0V-JvFX-scbiyq4HENMftPsbPcZDmoFZf3OfJm-r4NkWfuQ
Message-ID: <CAKmqyKMALKE8AoFe3Q3v6yz3qrP=Ty9WcdAA-ksjniPFNi2=Tw@mail.gmail.com>
Subject: Re: [PATCH v2 41/42] target/riscv: Remove ifndef CONFIG_USER_ONLY
 from cpu_cfg.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 19, 2025 at 7:39=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While RISCVCPUConfig.satp_mode is unused for user-only,
> this header is used from disas/riscv.h, whose users are
> only built once.  The savings of 4 bytes isn't worth it.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8a843482cc..cfe371b829 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -196,9 +196,7 @@ struct RISCVCPUConfig {
>
>      bool short_isa_string;
>
> -#ifndef CONFIG_USER_ONLY
>      RISCVSATPMap satp_mode;
> -#endif
>  };
>
>  typedef struct RISCVCPUConfig RISCVCPUConfig;
> --
> 2.43.0
>
>

