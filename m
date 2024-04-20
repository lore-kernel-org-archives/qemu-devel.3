Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F2C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 15:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryCzf-0001vF-Uz; Sat, 20 Apr 2024 11:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryCzc-0001ut-7x
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 11:51:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryCzZ-0005Lu-Ol
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 11:51:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e8bbcbc2b7so18496685ad.0
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713628264; x=1714233064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKd8sOgszWApP4y9elT/2JgYJc5si2WA5Hny0tQAIUE=;
 b=jHssSh+43uKQTthYChUT1V+9V8ba6HIRMWbhAKEuejdOdnZFhYEXd9XjEhLj8NAnnk
 GvqW89IhUn2Em3E9oDoisY2sG80GTASLtBYaSAlwiTkoSAnorokyUi1Y9GA/FITugEg7
 zZUawvqTo24iiFSuQTWtmHGw1iX2Yqj2cpvmhHaOYy8nHBEzV/aoBJV8B1QrUwoyMJyA
 hZHma+wOCDM+OYtU7vKw52bVEPzIf2HYtgQwNNgHOS98DXiiMVc+NJk/sf7l31KEpbfN
 7uhRF4TcZ7egu7IgUZs5WRThxU5MCFXS9iBEUIf29yoJQV/SZJCoC175xX5rXJwwX04n
 2o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713628264; x=1714233064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKd8sOgszWApP4y9elT/2JgYJc5si2WA5Hny0tQAIUE=;
 b=lGaBjidd1pKEUiRlKPqUrVWzi6T/LGnnF7dPq0XnFklSkGGVPha9/uD930nPg3AHkA
 TTiSJJf2rXU5OJHdnImm6Mw4PQuhycSKUWu6V/zWQdOVm/j4T7lwRwqdLAkiz7SUKOTq
 hAkxygwnQ9fy1q7M/ytMXuMMm+NpqMegFhMo0cq5JGO1tWGhkC43rqb0kfqwmPA4ELb4
 gruF+6+iEGmjyca48/y83U3eQ+PJxidux8H4kzI7/XdL/k4vLklw0lqIsMw9+Rpb/Zqi
 +NfG4wORPQvVIc1UpdbeyBSsun3+fth338tFTdqyzarBXDPJsGAARjDob3gUiaXktfmh
 K1NQ==
X-Gm-Message-State: AOJu0YzteyEHad0Frc6yrkSrwoS3Ccb/0pb88ci+sobFtYDSKvRVQ5xH
 yTbC0zQGGwX/yuvCQnOd7sxRHZcVD+jxMC3TaME1bJJQZX7v8kIy8ghx9drTWjg=
X-Google-Smtp-Source: AGHT+IFN+NMVAYciBwJSdgyMBGoKoF55kC+KoZ1mpuVsbIzrn4fJ0nK+lVgd4EA5XcOqXhWAVGSCwg==
X-Received: by 2002:a17:902:d507:b0:1e4:ddcf:5095 with SMTP id
 b7-20020a170902d50700b001e4ddcf5095mr7431282plg.8.1713628263877; 
 Sat, 20 Apr 2024 08:51:03 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902b94a00b001e088a9e2bcsm5195277pls.292.2024.04.20.08.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 08:51:03 -0700 (PDT)
Message-ID: <60632882-1c19-4dd0-aeab-d53d7ffd86f0@linaro.org>
Date: Sat, 20 Apr 2024 08:51:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/ppc: Move multiply fixed-point insns (64-bit
 operands) to decodetree.
To: Chinmay Rath <rathc@linux.vnet.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-6-rathc@linux.ibm.com>
 <87bafba4-7a65-42e9-acf2-d05962ce7186@linaro.org>
 <fe7001b8-7e81-4634-8e45-3661b790c8b7@linux.vnet.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fe7001b8-7e81-4634-8e45-3661b790c8b7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/19/24 02:25, Chinmay Rath wrote:
> Hi Richard,
> 
> On 4/17/24 00:06, Richard Henderson wrote:
>> On 4/15/24 23:39, Chinmay Rath wrote:
>>> +static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
>> ...
>>> +    tcg_gen_movi_i64(t1, 0);
>>
>> Drop the movi.
>>
>>> +    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc], t1);
>>
>> Use tcg_constant_i64(0).
>>
> Looks like tcg_gen_add2_i64 internally modifies the passed arguments, hence constant is 
> not expected.
> However, I tried using tcg_constant_i64(0) as suggested but this leads to an assert failure :
> qemu-system-ppc64: ../tcg/tcg.c:5071: tcg_reg_alloc_op: Assertion `!temp_readonly(ts)' 
> failed.

You misunderstood my suggestion.

   TCGv_i64 t1 = tcg_temp_new_i64();
   tcg_gen_add2_i64(t1, cpu_gpr[vrt], lo, hi, cpu_gpr[a->rc], tcg_constantant_i64(0));


r~

