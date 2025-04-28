Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812A0C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WEI-00026B-AC; Mon, 28 Apr 2025 17:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WE8-00024Q-IH
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:41:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WE6-00050m-Tg
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:41:24 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso7392016a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876481; x=1746481281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azVtEloGM1/VCXIvAaprReljsnU3fyFTT48cdv1kH40=;
 b=k+h9AaU00hhzzr3gxowj6oHJ9y7brySX8c6ym/X1Pb/KvlXCIzSfBGITaN7OCigfVh
 8pBXhA7VrXM6gE3JGxavjofnQHFIR1kOAAW1sMYCDbj9ABtG/QEP2ch/YJfZVI1SnpOk
 jQF0YrOyXzhxyUTvYVoGfJYhYzeRC7wEMkmfrj1hQ4AwHp0x21fa/f5zoHWaVNVOek9z
 FpsygEQ62Fkap/19s3UBbhg5ooK6Rrjr+K9/Dvkg6HMagUqDffPInJDz7xqpHJ6G+AMv
 OwDkU51Hxe/izbMNVLFyMxzKFCZiOWe93uVMg9fRt6w/XtMmvRHxi6168BF6ek+aEIku
 f9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876481; x=1746481281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azVtEloGM1/VCXIvAaprReljsnU3fyFTT48cdv1kH40=;
 b=CCeO/hXbooluPOxbklFJ7HbWd5GlxoUn+zRCxwyRwknHOwvzLxDvyJx+mXcXU2FOlP
 uFxplNM788aHWm7qAxESN2VycajmZl60FGPbP+eS5RpJq2a5drjLba79exGwCa6R8g4Z
 1I/6HBk19fzpqR5wSD6rTpMAEnW9zr4SC0DvQrLFf2UzPeWbR1M0o6g2CC8pWSBLPhly
 9y5lK51hGHHxZ+rdJ0NtVlzluqaEQr4Hkj1EgLLAkSwo/kw4goLtEmkKz8KICvcDGtVm
 kZ8mCtl7j54PnEa3vvVftx97MYgh/DuSgSrw9+Ty9Hodhh48k4OR8iqJVP9pLi6ga7OK
 jh3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcx0snxbAjUasrNFwvDNRnLKVpDira2eCFCHF6ckfqt6ycLbM3KPjqBX8DxJ+dAeax2IGi2sx4hzQ5@nongnu.org
X-Gm-Message-State: AOJu0Yx35b54LVTWYL0j4JOO5PLXFHIJjD52oqPX0FzMtAyo5gzf6jhi
 9a5+t9Bku/KG38CNY+lcfSB3SKDhnrFgkzXQ7dCy6NsBOp+IdBWcQsFD7oB68Jo=
X-Gm-Gg: ASbGncu9f3NE0imvLytuckjpcJWXjkpK7ne0NZEI4jidd9FsW6Z0M/3cqtJzj2tSv2N
 YGgtQOCeQ6bs9U/7/eXAyyVqUi4MqPXt4Ln/9eDYw04jOXjQw10xDKSMj1goCMBoOdrE9SPZU0Z
 roHizUQQaY/jDzk/CNZtJW0VKetxuwNIekn6mMTfDktKD8mG9yByTguwOZWjbqq4CnmFLkMTaeh
 L/wiAztLdIhgm8LboQ8R2W0yEPYMqNn0cOav6/GC2068gxHu29fAsPyLYhc1D8tGVhiHM/zXNYD
 6+IqPvNVr1zIJ5bZfv8ooOTpSZN8eB2Ob3ELpgG3XKWCCJtQXmmwOyrcP/HY2JXT
X-Google-Smtp-Source: AGHT+IHZ8pznQXYc8GY3nEd3ncMRBKFvKYyYErDJiX7Rs/UMYDo7d1/S9tlD4AGkgpQq+2zancajyA==
X-Received: by 2002:a17:90b:5645:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-30a23dc4e87mr488907a91.4.1745876481164; 
 Mon, 28 Apr 2025 14:41:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f77371efsm8670594a91.9.2025.04.28.14.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:41:20 -0700 (PDT)
Message-ID: <c9e76482-6603-4774-9605-fc1384d2217b@linaro.org>
Date: Mon, 28 Apr 2025 14:41:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> This function is only relevant to tcg.
> Move it to a tcg-specific file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu_helper.c  | 97 -------------------------------------
>   target/riscv/tcg/tcg-cpu.c | 98 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+), 97 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


