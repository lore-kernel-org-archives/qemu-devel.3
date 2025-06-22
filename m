Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D4C7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 17:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTOOv-0008Be-9L; Sun, 22 Jun 2025 13:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTOOt-0008BI-Q6
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 13:22:40 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTOOs-0006P4-5t
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 13:22:39 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3121aed2435so3756110a91.2
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750612956; x=1751217756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tk2y+eRL72jxEfGvHyO3coZjC3KAD35eQ7XJqT7KKDs=;
 b=A1sMFxovPBUDy+cWHkz+iZW4EwoSit1TRGHZXVVxERyBOgOYdl1+/oCmRaMDFcp1e3
 HGVZI9fjVbO33RsO5CFm9fSg1o/xmTCziX5AMU0HHcplJInO5Z9tspgvuxlrUGrrMouJ
 t1J/K67+lGyHuWBKyrnpC+J+xe8Xg8sVDdzcgoyjp+JBkiPoMHYZyvlDQanC7JaNG1zH
 upQV/D7JhOfLJvPiVsIz+kd7+2H8NSsoLCiJwr93jpYjN6jTshxKOgAKS0Zi7JQQ/z25
 CKSH15dpqE6NH5XtE2SHXidpLOcPdFIDn7n3yf9URwlpst4AvRBQSBh5gSbwMNu568iV
 PgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750612956; x=1751217756;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tk2y+eRL72jxEfGvHyO3coZjC3KAD35eQ7XJqT7KKDs=;
 b=D8yvdh1nTrbsO7oMQNaoEIEbFcvDIvbo4q46hwtvlqDZBPrq7o+vzmYMzvP228zxNA
 IMkRFHeJaXd1mW7vyDsEBTEa++ay1zYXJMG3KVVGt6ZFS624TmB43LeBajivkmaTChjG
 CiXSikcS1zQVgxt8dXETn09cLXVFO1yIMNyBqQ3xk4OObeBhc+WnIQIdIzIdjPV+yRCy
 a8hVzlE2fVVp8Ccca2gbOfFQFx8CvUpbQg+uCs72ucnPjNcIaFPfvnEwYLFwkn99fOvz
 Z0Gjk4BnJ2hxzJ+7z0JGeO5EpbVoOeMZaiozfz8iu7he31+JwgdCfgrQIEtiAxz4zV/s
 jQnw==
X-Gm-Message-State: AOJu0Yx2sEUegJ8/PD2lBB2qmzoDFYfgyJXPApfLYCj7kQuTPX6Xnqpj
 cv8/jCUSsTs5YgYZ0YUuersw9Q8pn+65meoSJ8uw0NBDCfU2EbkEnPstYDyc/P+BneKQ9AJpvor
 DNz99WzQ=
X-Gm-Gg: ASbGncv4esWQKOUmLJc3BKcmz1hXuOKIWLptanZwqfSOXd2Gp0b5DLU77mtJhHinTh0
 19R3hdg6XJWiY6eQATUkb3F759LrcSRiD+ATc9fobo3k85AmvjdHpvSaalzM6IJcbGY42IImPrK
 L184KiQidypVkiFUt88ZisT6QQVmVETc6Tq+IqrHE/ONGedD/oeVtKV8o8YnemMrEBFBsQ9uo4p
 oKh3GR05/odXhdGTlIbHmEkY43ZgK9FF0k9VHGSThY9yt7SkU8w5LSRYtl+u+uaPs+ueZVFmsw8
 mMFxPgYgZDYdr/nyCU34UpTsNnqTDwDw8MpgE319GwfPEGqGSHdI9fodcHbL5o3nFd6Z4CF0bfN
 00f28EKxCB1DGgQ6pku17ckN+CxC5BYvpRLQ7hVY=
X-Google-Smtp-Source: AGHT+IH35z2LJuHQhEs5iAYVTulvh9ag6Z6Iz4vXm+3lqhx0NnEh0f52CdNYaGXiPKD29ElHLgnpqw==
X-Received: by 2002:a17:90b:2dd0:b0:311:fde5:e224 with SMTP id
 98e67ed59e1d1-3159d61a571mr13836889a91.6.1750612955615; 
 Sun, 22 Jun 2025 10:22:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df84850sm6803227a91.13.2025.06.22.10.22.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Jun 2025 10:22:35 -0700 (PDT)
Message-ID: <3269e3a4-1117-4e0f-b28a-e23d2cc4596d@linaro.org>
Date: Sun, 22 Jun 2025 10:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 067/101] target/arm: Implement FCLAMP for SME2, SVE2p1
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-68-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-68-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 6/21/25 16:50, Richard Henderson wrote:
> This is the single vector version within SVE decode space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
>   target/arm/tcg/sve.decode      |  2 ++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index abdcafd952..235022110f 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7381,6 +7381,28 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
>   
>   TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
>   
> +static bool trans_FCLAMP(DisasContext *s, arg_FCLAMP *a)
> +{
> +    static gen_helper_gvec_3_ptr * const fn[] = {
> +        gen_helper_sme2_bfclamp,
> +        gen_helper_sme2_fclamp_h,
> +        gen_helper_sme2_fclamp_s,
> +        gen_helper_sme2_fclamp_d,
> +    };
> +
> +    /* This insn uses MO_8 to encode BFloat16. */
> +    if (a->esz == MO_8
> +        ? dc_isar_feature(aa64_sve_b16b16, s)
> +        : dc_isar_feature(aa64_sme2_or_sve2p1, s)) {

Missing !'s.  Fixed.


r~

