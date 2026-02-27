Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5805103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5wz-0001kL-3q; Fri, 27 Feb 2026 17:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5wv-0001jz-8l
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:04:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ws-0005bc-Di
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:04:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so20633805e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772229876; x=1772834676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YEGj9SuenadA60PXYQoRbiJ+6xfeCHRsjhMyjqWqH7k=;
 b=a2+1tjBM6qw3wdVeqMORkrOWBtEqdRE4ssmMbTYe+QAfjQUEpQaRIhaOqysHfTswPT
 ejbIGoYO+G+zzg/ewal8/Bdauc93Q3e6l4ssCa9rYBfVU63X9sPwJw8323z7wk3H+GjM
 mq8pu29lJiXSluyTfxM8X2T+gst4z/I7cyT5QOwTgHFrP6hn2ReRgGcv1a7oZ13Zk/4j
 maoXvs2K8Pi0C5+YBM6GAqOpaqvVjM7Z3h2gtgsi4BlXoSqJO17IHxRXRCjFHvHGLkBK
 9Ei8YV7C5mpioSNbAzA8/FafTjV96s4LSJewRLPp7H598qKDYwVFmhOmcOcNrK83HIDJ
 DTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772229876; x=1772834676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YEGj9SuenadA60PXYQoRbiJ+6xfeCHRsjhMyjqWqH7k=;
 b=GbOKOs5qrxp49vqwWgfSSNUCoAjFq5/bhG4E5Py8eD/WM2h9i0LyTQqddGgM3AeKj3
 y57l6aC/C6zxJqP68rnQnwHeWGdVLmSEkBVAfhv9KQSz0rUCA/48R+CxfynsChT/YjHR
 R8CRfmH2IY7JJ/EaOuKh31U7geglxKzTmOP1Eg2WZ5ayiyeL6AlUB00KMd0Jb5rytz6c
 Z1WK6MDh1S5VhWgNiPKmtUtkr7zKamTjashipQkGbVq37ingDjCa0mIgzXT6x8L1iFw4
 kASB2fBeuLouXLZwsPzsCg36V4+Y+LfNxBPWJpqdRX8O/30L1aa7EJLIj9yZYT+SP0Xq
 BpSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2MWNKXvY1KI2oT2l5VOK8Z6gyGveqcO+Gf6btP5eyZfX35fJMva3fxgS58FbbdRcp+QmgmoDHaJL2@nongnu.org
X-Gm-Message-State: AOJu0YztR1CNqC4a6W2jI2aX7LL/l3gYViNUZmoNu4Akx0RNTv4o7Wcu
 fOZGoNDJ+o14riXToFOzbd2Nxi4xGKAn/iUAz0V3bHjdGcjLsduGPCf6G5/OVn7iozU=
X-Gm-Gg: ATEYQzxDl3+w5ka6VheSl/PHmjNuf280OT2D2dLc5bRZ3A9TaM8qaPlvRiVfBGd5PY7
 HxPLdwkdJVDZb1qD7R2RQeGkJUNOpKmrHK7sH4if0dVWivUzhft7bXy7ZpvLgFVVR8p42I5tuyb
 5wTtAP+TMI36RsuloxAHXYDLQPQvQig8/8BxSiuZFd3qnXYQnWkWV1qrAJ6Q355aYOEUdbEGIah
 oz9+FxqlWZpQso3LBEVHF1+eP4W+JvxnSKk3GekPFQ0/Ae6zfYYQRncyl6OT2V1WnUt5+aVRUsT
 8YldDFcvv3AUBu9UCOIQN5WgGWfcyCmRdZ4WoBJEikumSq63W6m7q7e7F2+oWFS9MFleuVMwMj5
 X7b7pwB4aXlR5wXb0/qyc1ESl/t/9dxzGRuBXuR947aeL5S04VzQDO0zMGlEfUsPng699Z0YOvo
 IgqFR5sZY9Ev1lArryh36c5wCFDneWeBwfM5i1ZvyOr1hO94bC93SBe0bSv3LfFTR6Kw==
X-Received: by 2002:a05:600c:3d90:b0:483:703e:4ad5 with SMTP id
 5b1f17b1804b1-483c9bde864mr71862065e9.22.1772229876331; 
 Fri, 27 Feb 2026 14:04:36 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm236159875e9.1.2026.02.27.14.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:04:35 -0800 (PST)
Message-ID: <9b85f900-8459-4d85-8b02-011dffbb9da7@linaro.org>
Date: Fri, 27 Feb 2026 23:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/37] target/hexagon: Add TCG values for sreg, greg
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-15-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-15-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h |  5 +++++
>   target/hexagon/translate.c | 16 ++++++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 2804e08ce57..f80830f5f16 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -281,6 +281,11 @@ extern TCGv_i64 hex_llsc_val_i64;
>   extern TCGv hex_vstore_addr[VSTORES_MAX];
>   extern TCGv hex_vstore_size[VSTORES_MAX];
>   extern TCGv hex_vstore_pending[VSTORES_MAX];
> +#ifndef CONFIG_USER_ONLY
> +extern TCGv hex_greg[NUM_GREGS];
> +extern TCGv hex_t_sreg[NUM_SREGS];

Hexagon has 32-bit registers, so please use TCGv_i32 ...

> +#endif
> +
>   
>   void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index f44080608b5..f3dc62cec1d 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -66,6 +66,8 @@ TCGv hex_vstore_size[VSTORES_MAX];
>   TCGv hex_vstore_pending[VSTORES_MAX];
>   
>   #ifndef CONFIG_USER_ONLY
> +TCGv hex_greg[NUM_GREGS];
> +TCGv hex_t_sreg[NUM_SREGS];
>   TCGv hex_cause_code;
>   #endif
>   
> @@ -1099,6 +1101,20 @@ void hexagon_translate_init(void)
>   
>       opcode_init();
>   
> +#ifndef CONFIG_USER_ONLY
> +    for (i = 0; i < NUM_GREGS; i++) {
> +            hex_greg[i] = tcg_global_mem_new(tcg_env,

... and tcg_global_mem_new_i32().

> +                offsetof(CPUHexagonState, greg[i]),
> +                hexagon_gregnames[i]);
> +    }
> +    for (i = 0; i < NUM_SREGS; i++) {
> +        if (i < HEX_SREG_GLB_START) {
> +            hex_t_sreg[i] = tcg_global_mem_new(tcg_env,
> +                offsetof(CPUHexagonState, t_sreg[i]),
> +                hexagon_sregnames[i]);
> +        }
> +    }
> +#endif
>       for (i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
>           hex_gpr[i] = tcg_global_mem_new(tcg_env,
>               offsetof(CPUHexagonState, gpr[i]),


