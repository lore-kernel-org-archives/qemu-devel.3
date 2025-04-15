Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nYY-0002XY-9m; Tue, 15 Apr 2025 17:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nYI-0002NM-7X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:10:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nY7-0000m7-Vw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:10:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so4911572b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751430; x=1745356230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFVqFtJwfShOqdzeAKyai1DTdliPV7FFD0YCrVf7WKM=;
 b=ofbN0AIJXTDhSi0MI7Md0FpJBBWyOI/CULFqZ/gVB1OnqoACBALog/foaorokVaz50
 LF+a9dD+RRn/9kPveJnEnE11lxAiz5eP/rySnz8qum27fncJJ7lHF6kmSKOtk9qMfJ4C
 Iy+BFGGOA4nHWzgJle5MqwO0ZUV6duSMIyNaXEF3yWvnk18jzmHirFXYnl4VvvdcbcZx
 LVcI89GcDNH5o5TBdVRgcPpNjgvOaa+HuOf+5X2flHgwhsZD03NBa1qAubCg5HmRl1EN
 AubNlJJpmaunrRF6rSnQTODciuFZ5aFhlA92DMeCimup9raiOKUYdA29cpEN3K3e1Ed7
 4m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751430; x=1745356230;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFVqFtJwfShOqdzeAKyai1DTdliPV7FFD0YCrVf7WKM=;
 b=EqKCC4gsJWINXtvCdcfPtWOORN343Jg/wGM8Z8Fqu2nO8j+IYditQwos0J66bjbpEe
 cEbZtAQvxUn1onexFO8vmTTQju8bqyBhrhLj4Qk++gh0Q1VSgFUR5MDcSkhmy6A+Iql9
 dcPgCGrxHRP5x4PCAsz05YIcfhKI2uQa74VVQfnJC47w1DJ8nl40qwO/m5j2VLq1a2NW
 g0lF8UZwJGBP3ekL9YaFgTb8n0SsCixBMMrxw/45L7YozmUj1viN+BH2iIvk3X492YZ7
 DSOUhYmhsv3SyVCN3qySMiKYHd7eBEm9mjPy2Hl4Wq3Adwx4nx5dfQmklZFVzeqhcJpf
 ao5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURFDJtPgawEXMe9xODZWK3fSIdLskdoZpHfaBILW7CwR26lE0dz6i0N/Li1ZdobGCgUPcxDmiJpD6q@nongnu.org
X-Gm-Message-State: AOJu0YzT5W7TpQkKHcoEKXiktj1zWdrmpCoXVMnMQMMA7y/GBVlGDCh1
 SmLFshBR0wgcyAd1wgZ7oJM6O1ZC46GCtEJPzMArs4Kd7mUJUotEl5NNQRR0CFU=
X-Gm-Gg: ASbGncuqFRi/5qgZbJf5LWG0ie7hvsV3Dsc/DCHyq90a69JuPtIvL2nZZ38qIko93J2
 ZrVUheOAzZnajv5StuNfEperuoUrOw1RyMfnDXnpLApzwlRuOAeNw2A3yR4HDVuw3qHhga9zDep
 jaqk+TXy+GYVBq2uWc5fakH9hAmHyZk2rvVrdJOfdHemQ2qzca58tw34040n1Asf9r5ZF0JWTh/
 nyfUjwrRyXQmeiqnwNvL6GPj0UhPc5309Jl7YaZP43VAxaXtFhdxT3Zkhp5ajrR9qQ/n0MIJNuL
 Zvwbwj3w2qHvgnf1nnKDpITHLVb0F032RT5vGYh3ZbSK9L5kV+CTdJSEk0ET96m9
X-Google-Smtp-Source: AGHT+IF6XgM9MDoy40CLIG51+3NFoFZXZApRwHweyfz8NsNPgs2KKPkcuN9aAN0F6ct/BzUNUctpig==
X-Received: by 2002:a05:6a00:908a:b0:736:3fa8:cf7b with SMTP id
 d2e1a72fcca58-73c1f92fd10mr1458821b3a.13.1744751430217; 
 Tue, 15 Apr 2025 14:10:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230f2fcsm8958508b3a.151.2025.04.15.14.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:10:29 -0700 (PDT)
Message-ID: <479ec42d-814e-4dc1-8c5e-ec677d2de08b@linaro.org>
Date: Tue, 15 Apr 2025 14:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 059/163] tcg: Do not require both rotr and rotl from
 the backend
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-60-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-60-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/15/25 12:23, Richard Henderson wrote:
> Many host architectures do not implement both rotate right
> and rotate left and require the compiler to negate the
> shift count to rotate the opposite direction.  We have been
> requiring the backend to perform this transformation.
> Do this during opcode expansion so that the next patch
> can drop support where possible in the backend.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 98 +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 54 insertions(+), 44 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 43848ebc4f..8c8b9d179b 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -829,15 +829,18 @@ void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
>   
>   void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
> -    if (TCG_TARGET_HAS_rot_i32) {
> +    if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
>           tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, arg2);
> +    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        tcg_gen_neg_i32(t0, arg2);
> +        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
> +        tcg_temp_free_i32(t0);
>       } else {
> -        TCGv_i32 t0, t1;
> -
> -        t0 = tcg_temp_ebb_new_i32();
> -        t1 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
>           tcg_gen_shl_i32(t0, arg1, arg2);
> -        tcg_gen_subfi_i32(t1, 32, arg2);
> +        tcg_gen_neg_i32(t1, arg2);
>           tcg_gen_shr_i32(t1, arg1, t1);
>           tcg_gen_or_i32(ret, t0, t1);
>           tcg_temp_free_i32(t0);
> @@ -851,12 +854,15 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>       /* some cases can be optimized here */
>       if (arg2 == 0) {
>           tcg_gen_mov_i32(ret, arg1);
> -    } else if (TCG_TARGET_HAS_rot_i32) {
> -        tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
> +    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_constant_i32(arg2);
> +        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
> +    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
> +        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
>       } else {
> -        TCGv_i32 t0, t1;
> -        t0 = tcg_temp_ebb_new_i32();
> -        t1 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
>           tcg_gen_shli_i32(t0, arg1, arg2);
>           tcg_gen_shri_i32(t1, arg1, 32 - arg2);
>           tcg_gen_or_i32(ret, t0, t1);
> @@ -867,15 +873,18 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>   
>   void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
> -    if (TCG_TARGET_HAS_rot_i32) {
> +    if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
>           tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, arg2);
> +    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        tcg_gen_neg_i32(t0, arg2);
> +        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
> +        tcg_temp_free_i32(t0);
>       } else {
> -        TCGv_i32 t0, t1;
> -
> -        t0 = tcg_temp_ebb_new_i32();
> -        t1 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
>           tcg_gen_shr_i32(t0, arg1, arg2);
> -        tcg_gen_subfi_i32(t1, 32, arg2);
> +        tcg_gen_neg_i32(t1, arg2);
>           tcg_gen_shl_i32(t1, arg1, t1);
>           tcg_gen_or_i32(ret, t0, t1);
>           tcg_temp_free_i32(t0);
> @@ -886,12 +895,7 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>   {
>       tcg_debug_assert(arg2 >= 0 && arg2 < 32);
> -    /* some cases can be optimized here */
> -    if (arg2 == 0) {
> -        tcg_gen_mov_i32(ret, arg1);
> -    } else {
> -        tcg_gen_rotli_i32(ret, arg1, 32 - arg2);
> -    }
> +    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
>   }
>   
>   void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
> @@ -2437,14 +2441,18 @@ void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
>   
>   void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_rot_i64) {
> +    if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
>           tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, arg2);
> +    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +        tcg_gen_neg_i64(t0, arg2);
> +        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
> +        tcg_temp_free_i64(t0);
>       } else {
> -        TCGv_i64 t0, t1;
> -        t0 = tcg_temp_ebb_new_i64();
> -        t1 = tcg_temp_ebb_new_i64();
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
>           tcg_gen_shl_i64(t0, arg1, arg2);
> -        tcg_gen_subfi_i64(t1, 64, arg2);
> +        tcg_gen_neg_i64(t1, arg2);
>           tcg_gen_shr_i64(t1, arg1, t1);
>           tcg_gen_or_i64(ret, t0, t1);
>           tcg_temp_free_i64(t0);
> @@ -2458,12 +2466,15 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>       /* some cases can be optimized here */
>       if (arg2 == 0) {
>           tcg_gen_mov_i64(ret, arg1);
> -    } else if (TCG_TARGET_HAS_rot_i64) {
> -        tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
> +    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
> +        TCGv_i64 t0 = tcg_constant_i64(arg2);
> +        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
> +    } else if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
> +        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
> +        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
>       } else {
> -        TCGv_i64 t0, t1;
> -        t0 = tcg_temp_ebb_new_i64();
> -        t1 = tcg_temp_ebb_new_i64();
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
>           tcg_gen_shli_i64(t0, arg1, arg2);
>           tcg_gen_shri_i64(t1, arg1, 64 - arg2);
>           tcg_gen_or_i64(ret, t0, t1);
> @@ -2474,14 +2485,18 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>   
>   void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_rot_i64) {
> +    if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
>           tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, arg2);
> +    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +        tcg_gen_neg_i64(t0, arg2);
> +        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
> +        tcg_temp_free_i64(t0);
>       } else {
> -        TCGv_i64 t0, t1;
> -        t0 = tcg_temp_ebb_new_i64();
> -        t1 = tcg_temp_ebb_new_i64();
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
>           tcg_gen_shr_i64(t0, arg1, arg2);
> -        tcg_gen_subfi_i64(t1, 64, arg2);
> +        tcg_gen_neg_i64(t1, arg2);
>           tcg_gen_shl_i64(t1, arg1, t1);
>           tcg_gen_or_i64(ret, t0, t1);
>           tcg_temp_free_i64(t0);
> @@ -2492,12 +2507,7 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>   {
>       tcg_debug_assert(arg2 >= 0 && arg2 < 64);
> -    /* some cases can be optimized here */
> -    if (arg2 == 0) {
> -        tcg_gen_mov_i64(ret, arg1);
> -    } else {
> -        tcg_gen_rotli_i64(ret, arg1, 64 - arg2);
> -    }
> +    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
>   }
>   
>   void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


