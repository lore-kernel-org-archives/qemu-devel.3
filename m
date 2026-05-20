Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD51ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkzl-0007X7-B7; Wed, 20 May 2026 13:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkzk-0007Wi-B0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:46:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkzi-0000hc-SA
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:46:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso54933875e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779299169; x=1779903969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MdWWD+sVqh4x7iejwXNvKAXdmKR8sE+0stC+pn0ozU=;
 b=HJ+B7Xxcw1678kNJfhUYwt1TmHzd4IKIFCObayT7Hg/DgiJ7P+uD5OxYMtrCwrAMma
 8lzTGvC3EEscNdJ90al7YYdFyDlSJ33/nAC+GXvSsh0o12Mqyd27nM4RBHOFPqeLQFL2
 t1CVQkpVndcqUt8GDu1SmP6JC7FiyzCJ8iaPodnT9ZXrIh2BckxhRWa39KZeFviUnBZI
 mOqjBKjRJFsZZmK3BXUUG9DvTvrkaQTdgbavNEzEC2+Obejwns6es2x9FImHeMhQZV1B
 Of3CjASfigexALYba+EnkTO62RtMJt0CyL2dT5ekL4MDU1YCYgSPFdeBwfZgvB1RDNqs
 fXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779299169; x=1779903969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/MdWWD+sVqh4x7iejwXNvKAXdmKR8sE+0stC+pn0ozU=;
 b=WAwdAdkyzLrbttnSMdnxdLlLdRUma9EBG1GFBqseG2dz3QNxA8tzmbqUKp8lldU3WR
 czlOmgcT5STDOtm/48xZnS7EDixjYNAAw6IM5jLMFiUWRTWfrv3x6K0DEaKKAeHj+fCs
 ISw9pjoxnDiUAygcIR8gIkloHCaaf4pZ5DBHbgERUVOVTE6ggYCR1w9CglhCacxfuyv6
 BDVLoaDpnRkG68fHbTjj74/Dg2X9ZSB0HUBCpoGafq3QFZFsvpjLprJ4yPOqiJ8xjQeM
 Uc+xK+Ij9cw8jjIVvVL4Es0cojssr/tnffWQbqMrrln4hdyrDncZTtaXS7JlqLw9Hkzu
 Hwbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WlWcNoRLeptsPfyQVgCAHjz3uFiTlwdceY+vNZL4L/wdRwgtWPvlRGlhxo5kVe/3XbIEOnCYU4e7p@nongnu.org
X-Gm-Message-State: AOJu0Yx1jbuMC14+3XqSUxW7BL/Y3ml/A66XhnZR/4N5Iq8NEv1Zrl6Q
 kRwQ6o5DCVk+BrlZymchYjOlEnZGoOFoFEEKti+B1De5QBeeEETbjAFTwEuRv/5hAyM=
X-Gm-Gg: Acq92OFIvB5Z/z6raqUdUli8bTyD8lqd+74OTRuIyp3AjD/iHeYtRgQZWMAkNykk0iF
 KcO2AqISTsKetqduU5r4Ol78c9jKCNXxjfzoEYHofQzGNUzF3er0oBxu+kv+GG2VLduzsKIEK4m
 sj3+j71hla8L66L9RKxl3yLT3GuquAQ3YOhFC7cv0iCNW3NY81Zfl2B84KPN97vOzTBAN3UMbYJ
 kmGEAnbcOl3FeAA0AUy9nz249DU8R6qtFkVHshENUelHa7nOdWI0ki+N/CInpJuca+Hx/GbmFzu
 1hQ734wvmodXW/h6W4coPMBc23mO9GeY0NjTHmUlqK9Ojy4poEgNTvFleOTlb/m/4shfCTfs23B
 B4U7+nG2ZY6qY/GULcMhW0Z/3aLzq5RyJ+5iY7oaZWMbkzT76uOlTScnmCoqfAQwV0L1n2vhhW9
 kGOIiLmw9tFfSoKIWC3UpPnfRlbIKivPLEpxGIyIKf/qmUDkh4muNt3gZu1IPlbMWxSg==
X-Received: by 2002:a05:600c:620d:b0:490:18cb:e820 with SMTP id
 5b1f17b1804b1-49018cbf419mr148205745e9.21.1779299169228; 
 Wed, 20 May 2026 10:46:09 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033cd756esm8035025e9.0.2026.05.20.10.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:46:08 -0700 (PDT)
Message-ID: <e2a8ab06-7021-4a36-87eb-8f428f359f12@linaro.org>
Date: Wed, 20 May 2026 19:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/30] fpu: Export floatN_minmax
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520171820.848839-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20/5/26 19:18, Richard Henderson wrote:
> Allow target access to routines using the minmax flags.
> Make the existing min/max wrappers inline.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h   | 93 ++++++++++++++++++++++-----------------
>   fpu/softfloat.c           | 50 +++------------------
>   fpu/softfloat-parts.c.inc |  8 ++--
>   3 files changed, 62 insertions(+), 89 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(as in previous version)

