Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C0BCED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvAs-0005UO-LM; Mon, 07 Oct 2024 17:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvAc-0005Ky-NL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:21:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvAa-0001iG-OP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:21:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71de9e1f374so2322412b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336091; x=1728940891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYna9qMjZZUIpL4hRT22EiNVizp9raO2/erNUnGgW24=;
 b=EJNadlA9ZN4Az1Owwg1NlPTT9Ov+uzRR3pUtm5AwUiedjNt5CuGxcEDaqJzwVc2bGP
 odHVrGi7RGdi/6MlvfURnTy0g5DITH5+j0qGDqhCWt0VN/3IJqyNyVROEGzFUeIvtTWq
 TOdxgsEj9swonfcceU0mJAfQws5l8T/uUj+PFxmjYgFdKXFYXAJT8TT0mIaiM5phUAaj
 aEyARv1C8jjvuM837rVs2n9BwxWQoI4aRA9o5nLklBqn2/knAnOyZY3poPnNQHxnoH9s
 kpbEwYexbXCAf53DZdxrDzBSSexGi4xgD63ZewcEzoKtGH2/NZQ+fyLHyvS1PBsX5tSP
 EWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336091; x=1728940891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mYna9qMjZZUIpL4hRT22EiNVizp9raO2/erNUnGgW24=;
 b=WUhW8m4+5gehxT6EbA28VXbW3CObPa5w1AjVseVIMsEUhPCBzyyqdSyQ7nED09CMBR
 Zp4+MaxOI/3aGex57gb707URld5rS2rNBYYqw6AJ5Y9JdntjO80VIZQ9GmuCw83dCmpf
 boM61v3R54EhwN/rrp4yYxo3EwcZoAkxnqlF+lESQiEhxqKaGyZb+q2qovSC1K9KADNK
 4kaKhDO/nDxtwzYH+yj8OK5mSRrrs2NVlB4d2Kjw+DuyEL0G5cu160iN8KbPWQv5YZ8O
 a+XTYO5t4zqA8H3xC0WqS+VQC2BaVgGtLAaBp3hyjqVO3yN+IrlsB/0EwhpJg8MzvcQE
 hgag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX12COXXYfYaFbUGdnwxTfDxOlxH6fUXfJJrC54xR6j6a2YV/UF/vxogxE/qnF2moObicUI4YfNuuKP@nongnu.org
X-Gm-Message-State: AOJu0YyKwa+pRBfuLpvhUHCQqu1+c3ZXa/uxQPAoaU2hr+LEzDdeMV3R
 u4mE35aFwWg8DyiCDopmfByN9l3YTxqUOEUfUco0GskN3nVxlzfvJAz5QleKp98=
X-Google-Smtp-Source: AGHT+IHMAZclbZR3J38FTf/f+yeMXq7jyHdBIXJCDBtV48SAw1zPZiqJHLdVs7a1K0FMvQPjzbTW8w==
X-Received: by 2002:a05:6a20:6f07:b0:1d0:45c2:8140 with SMTP id
 adf61e73a8af0-1d6dfa33c28mr18563895637.18.1728336091415; 
 Mon, 07 Oct 2024 14:21:31 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6520dsm5008257b3a.171.2024.10.07.14.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:21:30 -0700 (PDT)
Message-ID: <68536a4f-090b-44ab-b072-210a9282c1bc@linaro.org>
Date: Mon, 7 Oct 2024 18:21:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] target/arm: Pass MemOp to
 get_phys_addr_with_space_nogpc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Zero is the safe do-nothing value for callers to use.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 3 ++-
>   target/arm/helper.c    | 4 ++--
>   target/arm/ptw.c       | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


