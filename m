Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32EDC369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53RR-0005kx-57; Wed, 16 Apr 2025 10:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u53RH-0005b1-Ex
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:08:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u53RF-00020V-Ih
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:08:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2241053582dso94214905ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744812508; x=1745417308; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fbr14RX5wn8VWEYSnk1QHCfNTYUqbo0S2ELyIpKXyGA=;
 b=TJc5ew6jtVdD7iXFfiSarm9dnJAwcHOfyBfzQALfAIMax5yA0qakvZPcxKcmpk8Cox
 yWWwLq6TWKtJ+LE8x9/i9sf81bvHsNdsAt1Kj2IWXWrRLmOaigsYHlVekzGzUhfZUL9I
 tzvmIo3VXB3vc1VTEFtjlR/yUkxIWxX+zr7DpKcUMSyczoX2I3idLBvZTCB4R+JEX2qK
 Sy3zqP2ZVxbQrZbSXcJFsJq5qjJZxSP9Q38glpFJSkRLlHtPx2XewYPnNS1Z7OTqZmkk
 u24c2l5UIXUlekg5cNEsSekvhA9EPNz0U1T1lPAVUXTAhdtwOUQuQbAXEj2ZJgBIDUmn
 Xxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812508; x=1745417308;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fbr14RX5wn8VWEYSnk1QHCfNTYUqbo0S2ELyIpKXyGA=;
 b=hYLgWzIyUYXuNa+nw/AriQ/9YvHogvUN3saF4UAZBNxHNmhKg7j1friTEinoeZDy08
 aPeUfcQbFYXidGWyb1hrD5E+2Ku0+fkNMSUfM/S3r+7h3wcntm7EYx5jWs6j4TfrnPte
 UL2HoOJOFyeYLW6NUU9j0VKv/u0DF+KYjEelK7XiqmYcr/1omfpDyghtEK1zu2+25Apq
 gJ8BsYBfF5V3jmzQEvQb2hVhE5m0w24mn+MQlKdinard+gFt4DmUof/cYLcD+s7YFRtD
 eukRTiKzzXt7MCPTRD7LFPvFBXpBjyBejnkZ27lLKlmLOoWxK7VD6Y1K60MZYrSdaXSq
 5T6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvH9UHTTHZ02c35ueXD5bbxIn27oslCZVRY27ZAjaRdkoON003QEWFg7R+PgXzBhdVZKHRbrTmkr9z@nongnu.org
X-Gm-Message-State: AOJu0YzdB+RBA36+ZayI5LCzgpBUyDsIl3QWcvgoME8XDv63345HE+NE
 e0HA7dZVi768VZzkZqaGHdHYQyPW+YpbD2EJuu7uo2JldQThpH8h
X-Gm-Gg: ASbGnctblZidwPDAeSwGnFxbvwjjVDnGHNT3KFzvu03FnxIPzKQBF162KU5wg6HcPs0
 BTXQx3XbAfsgiE2GHkEz4qjMZ/+Ke07ZtbUMqx+j9ItFRWap3UBjaRfrpIwzIadF2d8mpFEBwNT
 jhwq1gWinXOqQ67FOTszEewreyBkvG0Wz1QfSGvW9xR7KQ/SFmKVzp+gU4KIZO2mP10ZGy4YVoK
 XgC24e3PKQd2QJy0f0d9ayfSpMMAS10mkA7Kv2SYwICnyfuJQWGMEoysxOjh2fr2idcwIsQOGxi
 kQTwPfAzYx7nwBtJWlpeiukVG6Jsu7FQ69s+FdX7nA==
X-Google-Smtp-Source: AGHT+IE/FZKFy7We9HOqFjjY+edOUJBN8sehUIlf3po83mJvI81m+Rm4u10E1eapPLCXZKtIYvxtFw==
X-Received: by 2002:a17:902:cecf:b0:223:fabd:4f76 with SMTP id
 d9443c01a7336-22c35917410mr27707175ad.30.1744812507550; 
 Wed, 16 Apr 2025 07:08:27 -0700 (PDT)
Received: from localhost ([1.145.55.85]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3870sm10309430b3a.48.2025.04.16.07.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 07:08:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Apr 2025 00:08:23 +1000
Message-Id: <D984EUHJXTAB.3H99WEJWWC8RV@gmail.com>
Subject: Re: [PATCH v4 128/163] target/ppc: Use tcg_gen_addcio_tl for ADD
 and SUBF
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-129-richard.henderson@linaro.org>
In-Reply-To: <20250415192515.232910-129-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Wed Apr 16, 2025 at 5:24 AM AEST, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Nice op, looks good to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/translate.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index a52cbc869a..e082d50977 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1745,11 +1745,10 @@ static inline void gen_op_arith_add(DisasContext =
*ctx, TCGv ret, TCGv arg1,
>                  tcg_gen_mov_tl(ca32, ca);
>              }
>          } else {
> -            TCGv zero =3D tcg_constant_tl(0);
>              if (add_ca) {
> -                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
> -                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
> +                tcg_gen_addcio_tl(t0, ca, arg1, arg2, ca);
>              } else {
> +                TCGv zero =3D tcg_constant_tl(0);
>                  tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
>              }
>              gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
> @@ -1948,11 +1947,9 @@ static inline void gen_op_arith_subf(DisasContext =
*ctx, TCGv ret, TCGv arg1,
>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>              }
>          } else if (add_ca) {
> -            TCGv zero, inv1 =3D tcg_temp_new();
> +            TCGv inv1 =3D tcg_temp_new();
>              tcg_gen_not_tl(inv1, arg1);
> -            zero =3D tcg_constant_tl(0);
> -            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
> -            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
> +            tcg_gen_addcio_tl(t0, cpu_ca, arg2, inv1, cpu_ca);
>              gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
>          } else {
>              tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);


