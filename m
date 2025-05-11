Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBBAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDWf-0006sK-P9; Sun, 11 May 2025 16:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDWd-0006rk-8t
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:43:55 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDWb-0006z9-Bs
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:43:54 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso1131542b3a.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746996231; x=1747601031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HTb1uf5/tl6i0Zb0GJ0I4cJW/1QAIGXYsr4fhEEb/wY=;
 b=AOsuU2gpD1n/DAGFcFsW/eDOnq7r4sS8oXfSh+l+/yF4fcJqXq1NADU3M4O2KUTvXI
 I7Ye+YytDmcxll5fkYjItv+wNK2uv8Hy67ZUf/amrvmgoE55qP3ZzX0/yIAl7Qf0pMaO
 cOk3GHMrw0WI7J9rg9S8lgxzUQE+uCBGap4of+uAB11E1z6eTXdfjgPgpeo4cfVRyJq6
 lpwGn6CLsvdl7tjyTbkePmbHbPNIBldoS0iS6nc+ugyfwCtIwOivza/8ygrxyj2NZBKZ
 Kwd6eU//qGO0tFfHF+XHFEUfNxddrfmXKKK8kPSPZU1cgnFbw2xg0jE9x60q2vANrIB6
 V6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746996231; x=1747601031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTb1uf5/tl6i0Zb0GJ0I4cJW/1QAIGXYsr4fhEEb/wY=;
 b=uFEVUizjACz+mQzA3+knLqC9ERG2uEGF+IlWemi/9HpWyK9FSUiT6RNvzDn0y++7Gr
 aco9kOfFrVkzVku8usMpAhgK1UioevkCO9B/PvnwEQjcuqeK3mNCfCObbkLqKvfb88gI
 RF4zNQNLi/KG8CNOdBsA9ohtQ4ITT6VJ3eGs8a6W4AJYpzKBPK6rWjHW9Z5MbJbzVlqv
 eXAJuTPleAKF00ROFoa51x7S5DpbaVYx/cQCvb1b1jfGPFRQjDNCJE4CBerLoX2uPMG/
 fmUj745XlVa1UxTHLotNELC3ao61gVQRt1UR62jdoy8K73Oc+6ufCnctEDxqVk1Zxyjx
 5XqQ==
X-Gm-Message-State: AOJu0YyNHzw560kfEHt4BtTf2nE/RZ6YzQEVCUkkCnx6alk0TVl/HLiX
 neOpz/sgChxst2sTHK97Lh7N7gnz4tG5L4vyRrhRDeIoBYmsp1GJw28d6njZVf/F97aQXwXvgAC
 6
X-Gm-Gg: ASbGncuoRYpSpZE9hfiViFpshRSc6rTkb37Nz/c0sqyK+2QbcEcaQjYBphqvX9cm5jn
 MqNQrCiH6GNvqAhC6hz5fNxiJbWnv0pNqa1kCQlMGEf6/DZ/6Wr0MhToH60uHh8y9JbBW5SktpJ
 dVZfqOJ+ZScTWzi4d5zWOCtxDe1mu/UkAToJPLmbYaHvMhGpwmBs8fd+st6C8Q1UoAtdo9M7T7B
 AOnC5s8Nj9oNBNYBB2r1rT/BbeHlFMb/w0BkXMyVc/IzBjL8LcyZBR/BE38GbjaAE+RdCZlPFUe
 1bnxtAhUZqTrVVgPAQ+BRQmCK+iKAQrRmG1GkzjHWPnjjk3gbZ6lAxdOa8QfHCdK2mCDUHXyvkN
 C2v8rE4PrTMixxVQAAg==
X-Google-Smtp-Source: AGHT+IHw0tq9BA8Hi9JFJyhYX/i7jRNyQZURnqkvbGhEB79rGdxWt8LFUuVsFW/8G63vuCyF7/DH+w==
X-Received: by 2002:a05:6a00:3cd2:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-7423c00942bmr14887856b3a.20.1746996231450; 
 Sun, 11 May 2025 13:43:51 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a8efa2sm4791508b3a.165.2025.05.11.13.43.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 May 2025 13:43:50 -0700 (PDT)
Message-ID: <692eed39-4682-47f9-8d4e-dc0a7e8e60e2@linaro.org>
Date: Sun, 11 May 2025 13:43:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: don't set FSR_NVA when comparing unordered
 floats
To: qemu-devel@nongnu.org
References: <20250425093513.863289-1-chigot@adacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250425093513.863289-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/25/25 02:35, Clément Chigot wrote:
> FSR_NVA should be set when one of the operands is a signaling NaN or
> when using FCMPEx instructions. But those cases are already handled
> within check_ieee_exception or floatxx_compare functions.
> Otherwise, it should be left untouched.
> 
> FTR, this was detected by inf-compare-[5678] tests within gcc
> testsuites.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   target/sparc/fop_helper.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index c25097d07f..b57da7c9ea 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -446,7 +446,6 @@ static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
>       case float_relation_greater:
>           return 2;
>       case float_relation_unordered:
> -        env->fsr |= FSR_NVA;
>           return 3;
>       }
>       g_assert_not_reached();

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

