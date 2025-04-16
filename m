Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F35C369C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59e8-0001tv-4y; Wed, 16 Apr 2025 16:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59e6-0001ta-Ib
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:46:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59e5-0000Kd-08
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:46:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376e311086so25756b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744836367; x=1745441167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T/sLc3gi3lmeY8bCWyI+1t1OYGjIGPhSzUQc0OR8xSs=;
 b=yF801pYZJxAhOpJY9D6aqsIc3Vj8xSqAvyZ+xwytBNHjtMnUWaNt3LU7wUH0+ZttnY
 UGD2OT0YiQ01cjMpszeOGJIMg1OCxYZ2hpChVXgcWCef4TGATQw/f3l3Xn91Yy9q7oKS
 /k8/s85AyWM/IbMZveRUJ4nhyTlZjJ6SDuU1MP/RS0CSRQKLRilbWULZlcy9ECA5sxpG
 FYqcA65hvvKkZOIUFXJxjGXsCBPLpr5Y8AZjc3NyAcJbfcg8n4iMMt3OK0qgOcEuEj9t
 V/bLD9CDsVFqpWr/7j3BSL2X8K4iY5GOucn+JASSeylOM2SNgL0eFpVHZDvHODXUbMSw
 0nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744836367; x=1745441167;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T/sLc3gi3lmeY8bCWyI+1t1OYGjIGPhSzUQc0OR8xSs=;
 b=uTnpK5uhCSUoHdfoK8KbcV9oC2lTdB9K2nr/Bfjyrr/rLinpyy9J+eDNtBSocGLCay
 vy388JqiB4T3e9MDyAOlQ3J7HbL1dU4+dXTXMpBnNBHqfyWhcjLfG/OJRszf0F9B7v29
 joc9tmhTgFp1n9jrdTp8OfjsxZ69+pBO+F9bER5OpCxIHuA72uz3FW/CVuzxBDTt2zXH
 D1fEhuktUIprA76VSG3LzVGHK11p0fAr53PjN+PAdmeOt0J5nS4ujR3UzrTQ7gMKhAP8
 biOAN09nItLcCd0eMxmTXIYwW+BqQ6+WQPQ2PoXSyI28AErnMjz//wmlhID96U+NOwW4
 wAWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPTObRK8CTMne0UIFLixoVoWMWzsFj2E8R9OP6/c2lcNgpBLwAke2OYDWm14QiFhWaHMBa+KNthzeR@nongnu.org
X-Gm-Message-State: AOJu0YwdwzjrZX7QMhaN2pLeZHydejNn8yscefw15rGDYvW//fMf0kug
 HD+soapv4qGTdGkMCqy9WC2Xtirj8SqYE2SR475KNxOjBy77jK6ekzNNq4mqKS393RqVZmGZrQG
 G
X-Gm-Gg: ASbGncsYBNN7KzhnmIs1wC0sfoYukLWqxiCVItYWbJcUaccqrSA2cO+RbyuH7wO6QMQ
 Vyjghtqf4XU/yHsYs04U1OQG3+6SSOP+RA6hopOKXo2k8EXaEJPtRV+37cDtgurI9X0T1ZukzNw
 pdOTED9rG7wDXLJopFP+HtJJAV99LheIHs9qLzVvR5Wa0ChqYCsjzdmIx1iFEpxOAT/1JkKLYFo
 7FL4I+MNoq+gTGs243JO9kouF9rosxZHdL0nkFrrdGpzhlOjkBfuqUkeN5FraaTtnRpBs323Wj3
 Aig+pozQXAfLY78gwLZkojoa9DLw63e1XzqxedSzxrZ4BnDEqxZ5gQ==
X-Google-Smtp-Source: AGHT+IFryRNizCO7TyZASKs6PtK5N6njuAKKuMpEUpG2g/EgsrBJap1y0Z4T9lPU6EHCXwliQjbZGw==
X-Received: by 2002:a05:6a00:3d53:b0:736:520a:58f9 with SMTP id
 d2e1a72fcca58-73c267d207amr4747211b3a.17.1744836367502; 
 Wed, 16 Apr 2025 13:46:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233785esm11290383b3a.178.2025.04.16.13.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 13:46:07 -0700 (PDT)
Message-ID: <226ba4b6-4284-401e-9f9e-1e7b69a526f5@linaro.org>
Date: Wed, 16 Apr 2025 13:46:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 153/163] tcg: Assign TCGOP_TYPE in liveness_pass_2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-154-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-154-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/15/25 12:25, Richard Henderson wrote:
> Here we cannot rely on the default copied from
> tcg_op_insert_{after,before}, because the relevant
> op could be typeless, such as INDEX_op_call.
> 
> Fixes: ...
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 05604d122a..3c80ad086c 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4408,6 +4408,7 @@ liveness_pass_2(TCGContext *s)
>                                     : INDEX_op_ld_i64);
>                   TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
>   
> +                TCGOP_TYPE(lop) = arg_ts->type;
>                   lop->args[0] = temp_arg(dir_ts);
>                   lop->args[1] = temp_arg(arg_ts->mem_base);
>                   lop->args[2] = arg_ts->mem_offset;
> @@ -4480,6 +4481,7 @@ liveness_pass_2(TCGContext *s)
>                           arg_ts->state = TS_MEM;
>                       }
>   
> +                    TCGOP_TYPE(sop) = arg_ts->type;
>                       sop->args[0] = temp_arg(out_ts);
>                       sop->args[1] = temp_arg(arg_ts->mem_base);
>                       sop->args[2] = arg_ts->mem_offset;
> @@ -4507,6 +4509,7 @@ liveness_pass_2(TCGContext *s)
>                                         : INDEX_op_st_i64);
>                       TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
>   
> +                    TCGOP_TYPE(sop) = arg_ts->type;
>                       sop->args[0] = temp_arg(dir_ts);
>                       sop->args[1] = temp_arg(arg_ts->mem_base);
>                       sop->args[2] = arg_ts->mem_offset;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


