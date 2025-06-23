Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E5DC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjsR-0000is-9J; Mon, 23 Jun 2025 12:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjsP-0000iW-3J
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:18:33 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjsM-0002uk-TV
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:18:32 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so40858287b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750695508; x=1751300308; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jvaAp0VqsvIRd95DgtmRTIcpKwgBigICYEpFv7mxFHs=;
 b=w2roisMvdK17EQ9DvqTSQqi1FDVW1BQer0XqthwqnaYC+O3lBs3NUH/JQjcTx5e5vb
 /gscvGcWQiqW0Fh391fbb+T6LrJNAQn2dHUJLEvvOD9tH2AzSXqas6jtVNF5mkzZEbs1
 vRqxSpaTh5W5VzLrP2lDRI6grTEnt55voGRQuIncQgTtRoeFPx2g1bfeuBXThrpkAdIc
 hbjkPubZWy6WHpnisaxsNwcNfXoBkd91CYG8tLgadD86aVOjBp/kMGJrvTjzkpRhMwb/
 869MYobNQ3vI3DphQv5Z3q7TLgBerDdgU5d9lNZBxfE3Awv1NqAGIZDfiYVP47WW+DSS
 VMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750695508; x=1751300308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvaAp0VqsvIRd95DgtmRTIcpKwgBigICYEpFv7mxFHs=;
 b=vJtGYuT667pY1cJ3+B3Srz8jsAfymbw2IhyeDaBtaKH+Eb/QyqxglP33b+6EywJjQM
 4SXAJgk76jj3gW8bZtx3+QFESfRvMIvVH2GM0AIBVfl0e2/YH2EIJliPuGgzRQoO/5hE
 8N5r3RiQwpTMk9NhSmEfcg+tqkyEWy5cGMdytGJxf9CNeG2mIwLNDLoHGP5N/2xCzjnx
 hzUfD+77xaWMPFKFSjGzEfNlP8Z+NWK5tgLqtavzpa58H46I9dT4ydO99rz5ovapTuqN
 uiQ4Ezqfpl9igt0dHmfoRrzHiX5Cdfbb2GQl+nqGGGr4ZZ40Io42l+UwUnLlkxy+2Vk5
 8K4A==
X-Gm-Message-State: AOJu0YycyA9k5k3yDt0N4BISahq5e4qXcsJ7iDwAg9z1pUNaEdgQwXbI
 iL0rbkvOwvVt33U7N7UNaxbEWLpsmXtyXuPvyVsmVZ5jw2eA7BPsLk4SyZLG38uvBtZiZUlCKsM
 /V86Hf3sGoCwLNavyJjM9p9iCMuB/c3Kn3QiD9a056GLeqsbTLWr/
X-Gm-Gg: ASbGncsuCbyaucNFiOtcDV5BGxFlzkUG9HnE35lry2IsL3TIAzYFtGGXxecN/ylCdZG
 Haxi4oP9WH/vvKRCMRL5RX5X8ZC5o7fguqw77k+YdVHU1SfK/sCZzne887ghihHbtNZJJGV0pPb
 jhoVX9q1+qQRqhlcZMbmYH+evyWR2aEHyaWtIKFTBt5ssyIj4lYS1LfUY=
X-Google-Smtp-Source: AGHT+IHbV4McqlCsJZ+JluQCsoit8GIUUO3cSqoIw+2yJVuB8Xne3zRUo/3QUSslxphPWBZekVLbp+y/ymLurXoBu4E=
X-Received: by 2002:a05:690c:6d01:b0:70d:f237:6a6a with SMTP id
 00721157ae682-712c63edaeemr201986387b3.11.1750695508052; Mon, 23 Jun 2025
 09:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-33-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:18:15 +0100
X-Gm-Features: AX0GCFsDnySqDWbSZeLNrAH8uM5oHVOIZM2TJd3ALk7wy-l-H7rwQRJ60CdNRB4
Message-ID: <CAFEAcA8ZdARa9epX=rUipcvQtMhhA1vWHN8FK1QT-z_z3BN0MA@mail.gmail.com>
Subject: Re: [PATCH v2 032/101] target/arm: Implement SME2 ADD/SUB (array
 results, multiple vectors)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 22 Jun 2025 at 00:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 31 +++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 20 ++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index 09a4da1725..8aae70201c 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -692,6 +692,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
>  TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
>  TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
>
> +/* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
>  static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
>                        GVecGen3FnVar *fn)
>  {

This hunk belongs in the previous patch.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

