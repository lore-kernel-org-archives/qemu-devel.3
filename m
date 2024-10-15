Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF9BD18159
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0V7d-0006YN-MH; Mon, 14 Oct 2024 20:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0V7c-0006Wy-5d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:09:08 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0V7a-0003J6-Nr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:09:07 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso3006029a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728950945; x=1729555745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sqqSXYrsglzG3i5HHqJyZhjQTKt9dOpGq1GgFk0I7dE=;
 b=XHXcz7VTTKRZdAp0z+GQ4Fmx3G7H3oyxSM/SMgt7hFSBqxubuicx4Gm971gXM1I6bs
 TisrGD8hw681Wc2P09T3cSVILRHfoGM3U2+jodaWrTpA0zBUCz8/VBqH848VAVyFXNJf
 HnpGuAlgGD4I5JC6TBuCq/ZQahJg/sEQm8xCzQI7e14sr9K2GnRGVgDJJ2dV+pKjgrPU
 qfkEzyZMAVUwhY1/bESjBum+zwarWwOUIP894FcFyfXZDfdnv4PPhrdQ54l5YOEg3VeU
 HYiyAJ6NqMG0bEeXa+tBbKBwtKVyAIwseL3I1f2XrbNcLYw6+5+HIh4LN9nkbxLXmOaX
 k5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728950945; x=1729555745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sqqSXYrsglzG3i5HHqJyZhjQTKt9dOpGq1GgFk0I7dE=;
 b=cRcyCabGjy5dYcTGr5JU6Wi/3NDZ/ek32iMVLWUoPcH3OPiNMjPgm6zeaCEdFMJ67P
 cnR258xmAdKoDTeAwsrXbhaZBU/qOJasXpSNWteu4EmASxb61mbtjVog9OskMb41DbzY
 v7ZxWO1PPknzDprETNJbLn5ke0HC9Hm0rmZTmsCWn9i8cle3SKa2EDhjYqp0fSRyXuem
 zNbrFwhvHUNE0HKom8o0bObBIvtcMYeUdDEtT5eNk3dw00J5QMD6VWQbiCZ0lQcftZd6
 hLni/IfUC8S56GfIzuHX38I96lbO55MAh1AHQWT0oFAFRl0i5rIRRSXhSkqbFGJ98rg5
 esHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqI4AChwyw1epIxaGh9cD+WCZ6EZ6cheRCDiHEUVQH9VvH6ahknBwsyUx57M5cDmODeULS+zznQwW2@nongnu.org
X-Gm-Message-State: AOJu0Yy58mMY0EJzW+PXDTjVNsf0YonES8wjkWrw4fYnheOBvkkTWF8Q
 49dNFu1D+UJYkmfyRsj1oLKT1UWp4AwkHq1JjI70TYGAltawOV30nMmfgtkm4eM=
X-Google-Smtp-Source: AGHT+IGTFXJ1wBOUzL3xBnwtQt9WvBZFeaWmJaPsW2/htO70mNDs78pMuUeMzsrkVj5h5Ta+AgMjrA==
X-Received: by 2002:a05:6a21:32a5:b0:1cf:3736:49c9 with SMTP id
 adf61e73a8af0-1d8ae0ad673mr28045941637.8.1728950945493; 
 Mon, 14 Oct 2024 17:09:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6c403csm128642a12.35.2024.10.14.17.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 17:09:05 -0700 (PDT)
Message-ID: <1574ce74-3339-40f6-b484-47bdcd891eca@linaro.org>
Date: Mon, 14 Oct 2024 17:09:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unused MEMOP_IDX() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241014232235.51988-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014232235.51988-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 10/14/24 16:22, Philippe Mathieu-Daudé wrote:
> MEMOP_IDX() is unused since commit 948f88661c6 ("target/mips:
> Use cpu_*_data_ra for msa load/store"), remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/msa_helper.c | 8 --------
>   1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

