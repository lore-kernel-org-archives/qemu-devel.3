Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEDCC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zMh-0005Yq-VB; Sat, 05 Apr 2025 04:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zMe-0005YP-NM
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 04:58:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zMc-0006CM-R0
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 04:58:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224341bbc1dso25908605ad.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743843533; x=1744448333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=67DYcBHee7/3xYSIKdYB6rMYy5HUKFBkyEAH4ydb0pw=;
 b=X/ZdQwSLxrvF3Tofbzh/uMNzzx8kuf70v8ppF2g1kZ1yecHQt4d5Wc03zznHy4zmt7
 PXQ2n+wS8uJT6+bPsfmUe4ujuxLsuoVIO5r5dVEvRF8YVC0/q6NTUw1rbT30rVTwtTVn
 byQOMRGI8TXwJYOQMRYRaCc7pbq3LQU+xZqYFCCzC6RD9Igee6BuXXshI0JZ4oQRG5V6
 uKZVPevQkxF2VTD3VcB12l7o/US6JgYPaxspkicl5NsmLbSDoPuYVE2wdM9gg+8HPJZk
 OwLYHOthtsN3Ty2CdpxKExoWY073YamYHRipC+RbNykywyi/GLVW18nlu+cUBPLkHq5v
 sXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743843533; x=1744448333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67DYcBHee7/3xYSIKdYB6rMYy5HUKFBkyEAH4ydb0pw=;
 b=UmHvn8WwUoGbsCq9HDTuXI+/HzV0sIhmgH4OkcbJuPAJsIuYsTjveONrObATtimP4k
 yaN5vZaiO/IpRB3maFNikDMxSE7i8NTGCZsr3XmQeYdqdm7KhETSCSmtoHAVTIXDbuON
 2hv0edqswe+9u2b735NovN43R9Onk6xTuhXGnOy00IHz6I7LS71Iyhy8uqicdn8EOx0A
 AIJwDcsrDTKvbj6QGsylCQkN7GJh+pWuP3lC4++6ZAivYfyW5oRqdGAjCvG2OfwQdEEi
 7GwyYddRQNKfWqFpJYa6hlKbIaSW7phTD//bSsY6jqU+1J7McmjCvm8MJUlkhKet2Nt8
 xEqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4DeOSVnUXbyVuXCZ6Jxt5lkvhUtXRslb954+eXogLvPJFzTvcewEHRvoGS3KOp6mlM8RHZVEyqJNI@nongnu.org
X-Gm-Message-State: AOJu0YzW1CMN5/XAasmF+JxnupTkiFegZ/0OX395mNgzEfbqhOV3+I4Q
 rHRkqVLjk505A+FBJUXHrG5WtbP+ZUnTD5xfDMeD7V48Sx50v/7EmNRe7g7I0F//BQuhI1FeSr6
 n
X-Gm-Gg: ASbGnctduSMlGzXA4vEF/XCMZ/6mAZuNiEmw7+wjORbuX9OwSWImYThKEpFiZsn3Kw7
 P1S4lOip7MeT9Y5Gkm5ZZRx7CKPH+UEdxQRS1pVnv8Fnty45kf51mBBsIwsBBBKxkCLZVLRpmKl
 YCGACK6PF9MOVGpgREJ791DsZx12lxTQ7olFp7oIxzqQnLf1y2JEUOs/5XJuJmuCX0qZ+ScmrtX
 ZxizAT/m+GIiKWEyMmT6nmCJLynmtxGgh2ev9762nAjAdVmCDbQxxWffdFM/yiU2KY6oH3lD2Zm
 ZnkG3tHaoSTSsZ5fztdLZFLG568ksunvxr1qAxczRk0EBz1ijykJ1ReKDe1xAEMVf/QIc/c=
X-Google-Smtp-Source: AGHT+IFoJpA9jnJLiy3QR50f/Qumum5uQS3Hle2H/3aownlJyB1BkH+duztLEve18xY/KvcM2OyxTg==
X-Received: by 2002:a17:903:234f:b0:220:fe50:5b44 with SMTP id
 d9443c01a7336-22a9553c0d1mr30513815ad.31.1743843533183; 
 Sat, 05 Apr 2025 01:58:53 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866cf04sm45224625ad.161.2025.04.05.01.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 01:58:52 -0700 (PDT)
Message-ID: <ff0aea2c-82dc-4b56-beb5-59decd3f4e4a@ventanamicro.com>
Date: Sat, 5 Apr 2025 05:58:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] target/riscv: rvv: Add CHECK arg to
 GEN_OPFVF_WIDEN_TRANS
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-3-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 20b1cb127b4..e630f8661e1 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2403,10 +2403,10 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
>   }
>   
>   /* OPFVF with WIDEN */
> -#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
> +#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
>   static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>   {                                                                \
> -    if (opfvf_widen_check(s, a)) {                               \
> +    if (CHECK(s, a)) {                                           \
>           uint32_t data = 0;                                       \
>           static gen_helper_opfvf *const fns[2] = {                \
>               gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
> @@ -2422,8 +2422,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>       return false;                                                \
>   }
>   
> -GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
>   
>   static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
>   {
> @@ -2505,7 +2505,7 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
>   
>   /* Vector Widening Floating-Point Multiply */
>   GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
> -GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
>   
>   /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
>   GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
> @@ -2530,10 +2530,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
>   GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
>   GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
>   GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
> -GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
>   
>   /* Vector Floating-Point Square-Root Instruction */
>   


