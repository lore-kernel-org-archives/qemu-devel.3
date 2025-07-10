Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1285C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpH2-0002li-Jk; Thu, 10 Jul 2025 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZpGS-0000zc-GT
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:16:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZpGO-0007kB-Cq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:16:31 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso155994366b.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752146185; x=1752750985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlH7qROmhjyGgV24G5kCHWH60mLAH6jayTl6wCtZZvE=;
 b=uPMffTUFWdA71Rk37nWik0IyEInFVU4xeKPfUtSD5RTunLTynwftgZ0+rkKtvJ4T6h
 /ArRQzGccwpqK4LyVlyJGLwLCcrvcDrT9DP7pxvVDRHJsxo5X2Pr11T7Oy4sOIMomZ6O
 ElYTR/y4QKnoIRM9PP9pTopLDKFjkEeliHgWsLf4OmvVr8HnqlJyYc+FXo8aLcSndFlP
 9PqPk3lsQEyoQ0f2JnKq5xMTZ4ynHrbfGGrp/skTHyOtMkTu/hPwULGugOcdvw5cJd53
 0kfcuirHlWvhkmPXESGgNRhKqaspxi5B4WofQmlNqK8ZBSoB5g2BkPSM+gjjSx3yfmpu
 gsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752146185; x=1752750985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlH7qROmhjyGgV24G5kCHWH60mLAH6jayTl6wCtZZvE=;
 b=IcL36uU/hkUKhw4yxP2pGsoR7ptjWK6un+RBwygTG0z/nHGnlcRE1psYvIsmCHEwzA
 WTkzUAUthaIdPphUD9b1UZ10K/ntQOo/97gpC0/sqKbq19rK/d1vu7wupXxhSaqg6W/q
 gA6EKafEHKjWZK/qSoMqElv9pDATa2CNEOOVSMhLI2uK+eoghTvrQmxHVyj79ervW8xm
 dec3fsvUZrWJQXDCVQkqHGw+bawmN6BtGh1Mvwt/MbsuqfuREhD6PdAZlCJT8RT+CJes
 l01RiM7jZLUVoLRTcPNabEMIOXLyi8XO/93tR33kO6fHX6dOmr5tIwx3EufFhJL8gLVS
 OhZg==
X-Gm-Message-State: AOJu0Yx8/HRct47BhCRBkoJKJI+2E1fpLk9j+Ka3tWV0LS7CYRkpijrK
 NN07OOPVwp3ebpTi/edTvPeQ1YXdzBJM4KyB+RG9NJ28pKnuxvfGsdCw5nY7ClNwgdWt9N+ClG9
 womT7LkHZLfVTTIkaM7MM16wlBzdfxUGHSB8iuVHDtw==
X-Gm-Gg: ASbGncvDaN/uEpQn5LsfoKYKu9+Enlhi3VsHWn21qIniBibZefxC/IEYqIV2yYYkH6v
 7ou/uhXM76oIljWp+fdZR/tYAmbTaXDb8xql/G+Tg4JPGLdZv024H+v70eZxhUE3SFpPccTnBQe
 lv71i7SbfJLibFLd3rsd5MwZ4RgT1aoYiI+9YNYhGP4uA=
X-Google-Smtp-Source: AGHT+IGJUXFkzC/3md9vPfU8BUgytO2b3bpCfjB45dhDChZ92LvAOP1O25iJvzDaEwwHvEWfp0tL5pn6CUO7MWuVnaI=
X-Received: by 2002:a17:907:3f98:b0:ae3:53ac:2999 with SMTP id
 a640c23a62f3a-ae6e70f4887mr262990566b.53.1752146185333; Thu, 10 Jul 2025
 04:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250710111303.8917-1-philmd@linaro.org>
In-Reply-To: <20250710111303.8917-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 14:15:58 +0300
X-Gm-Features: Ac12FXyZvqu3S6-zse-U5fwyQA8rrK5rvY0BbZS3hqKQFLkwkcbJpoo2s3eXiRs
Message-ID: <CAAjaMXbb-G0qS+cLGUQOoXr+HNR_zZzprT8iz0vhcQ6269hD6A@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Do not dump NaN statistics
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
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

On Thu, Jul 10, 2025 at 2:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  accel/tcg/monitor.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index e7ed7281a4b..778b12613f4 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -19,7 +19,7 @@
>  #include "tcg/tcg.h"
>  #include "internal-common.h"
>  #include "tb-context.h"
> -
> +#include <math.h>
>
>  static void dump_drift_info(GString *buf)
>  {
> @@ -57,6 +57,7 @@ static void print_qht_statistics(struct qht_stats hst, =
GString *buf)
>      uint32_t hgram_opts;
>      size_t hgram_bins;
>      char *hgram;
> +    double avg;
>
>      if (!hst.head_buckets) {
>          return;
> @@ -73,9 +74,13 @@ static void print_qht_statistics(struct qht_stats hst,=
 GString *buf)
>          hgram_opts |=3D QDIST_PR_NODECIMAL;
>      }
>      hgram =3D qdist_pr(&hst.occupancy, 10, hgram_opts);
> -    g_string_append_printf(buf, "TB hash occupancy   %0.2f%% avg chain o=
cc. "
> -                           "Histogram: %s\n",
> -                           qdist_avg(&hst.occupancy) * 100, hgram);
> +    avg =3D qdist_avg(&hst.occupancy);
> +    if (!isnan(avg)) {
> +        g_string_append_printf(buf, "TB hash occupancy   "
> +                                    "%0.2f%% avg chain occ. "
> +                                    "Histogram: %s\n",
> +                               avg * 100, hgram);
> +    }
>      g_free(hgram);
>
>      hgram_opts =3D QDIST_PR_BORDER | QDIST_PR_LABELS;
> @@ -87,9 +92,12 @@ static void print_qht_statistics(struct qht_stats hst,=
 GString *buf)
>          hgram_opts |=3D QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
>      }
>      hgram =3D qdist_pr(&hst.chain, hgram_bins, hgram_opts);
> -    g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
> -                           "Histogram: %s\n",
> -                           qdist_avg(&hst.chain), hgram);
> +    avg =3D qdist_avg(&hst.chain);
> +    if (!isnan(avg)) {
> +        g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. =
"
> +                                    "Histogram: %s\n",
> +                               avg, hgram);
> +    }
>      g_free(hgram);
>  }
>
> --
> 2.49.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

