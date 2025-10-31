Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7710FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmep-0000k6-VP; Fri, 31 Oct 2025 06:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEmel-0000gy-6Q
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:46:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEmee-0001kg-1A
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:46:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso18396335e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761907604; x=1762512404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t7RRK2AsLEw/BDg8tEo+jJn/R/r/v0KXYOZO5g4JKm0=;
 b=glpLyI/aasPnZ4UyAsNfoKsIDlRGsG29lc3e8ELJO4qoM+iUk+f8BYDGVoSmV3ymHW
 uxQeMErkl2UK+olTXDgkbYhBBN2vsKop0fsQerwnyuWkCO6cxuZwwzxO9t5VZolpzUYz
 xTsEr8CtfEmWovVBEMeR6xc4ajPu+3GCiXWjlzEERUrmixeWYlsrU4n/qYxGaw8NRwwS
 ECOqqkJ1T5isEWjRnLonRTeklUFOyWCySaiS8UB29sCdH2Mx1mmhB8FnM4au9pSmwxnu
 P3Ebs88NWhyoQno57DJiHmGcOBROhoHyygw4i7/ZolBCsv1Mp5LUK+illIKjYuN3jRb3
 oapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761907604; x=1762512404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7RRK2AsLEw/BDg8tEo+jJn/R/r/v0KXYOZO5g4JKm0=;
 b=RRi7gonj/Po/l4S1i9SCjf0+Ft3BQfnN2DtFsKJLFVs31f/TqF4hqs29Ym0C3iEt7v
 ucRyNCUttaFbfO7PnckXWEYc1rgro+BAEN9Nyj2cVAZEsrKD7kXjpw9bJP6B6J//SBOf
 maGXUm1VspOcO6nrv9jWwvjMEHf5Fa5w0kAgZhJ9nCytuJ0+s0EN2aa9cUGAMAa3dRpF
 pAU6y63/+yuZsVB8IitwGK3nv47cSDi8O7FDisOi5deouFEByX6eZOiJHszp6JG4m+G9
 CKpLrqCoPiicWV+a4BfvYq2UhMu6CmHOXLoEPqsJFnhOiGkeKzQ//Na3s3N9X0GsHU9k
 aM9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnpSk7P2cMObOMKvR87W6xwDaB+N3oy1CHsQ+K5+af8cSbg1bYqiG5rWxMZyfUGHe6+YriNsYqAIXf@nongnu.org
X-Gm-Message-State: AOJu0YxOzgu29huRnfWlj6B1DuS0UYjEtZYZNu+VafmBfLt/mB+4dlk3
 pQGe7aFrNba2nFFTCO034T7ELvIae2uiSz4hSlTjL2/Rj7jdZECAiJ0fx6oDhcSVxnA=
X-Gm-Gg: ASbGncvvATFMDvKJj39z2o5h6uN2BVdNJ56d/8jn7VHGK0c2qcFzAP2eSXdzKnhs7DJ
 tNP1uSeY8Sxd8qk4sLrTuorRRsx4/vQGPxF6QHM96Yq086UFWVbDxOBoVOULm7sGAR29yYQZb7i
 8yrp126F7XA+1SuvRVNWRKJFYusGBamgB2LcB0tRUwk/XOOaTJsxH/I5U/reEt9dWJrRz35R0FB
 U6BTNuFsaRukXztUunIOxT4RZ+2rbt47hVfSEWGNr4VlrXCIumk1DDT+HJbZG6glkUoQ5RuW6fJ
 Z9/v4tEwMoJ1QJFtsDMFJBuJOcHPfPY1wcUs13IzMfJAzBq7z15vgSRnAdwLXhseb44PL5zLUMi
 EC2QnPHe/XqFsBfpz6ppMCf5AMOu5r7bGYWdzlXCcwhd//SHrjZK9Dvd6/LAs7EJgVH8MgrvHKa
 1pyENT3f2mEHUE6mXvmDSkjo5+AcAexKAohDAjtF4okxIchctaZsy1P0uBUTBgq7ruHQ==
X-Google-Smtp-Source: AGHT+IHJleT3TOztLaX77DBhcishsUHgG1hf7GaUmavljt9rzDVdBi/vsFo50UxXHXkW3qqcqIcyZg==
X-Received: by 2002:a05:600d:4350:b0:477:3543:3a51 with SMTP id
 5b1f17b1804b1-47735433daamr10599815e9.6.1761907604595; 
 Fri, 31 Oct 2025 03:46:44 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114be36sm2969467f8f.18.2025.10.31.03.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:46:44 -0700 (PDT)
Message-ID: <ac37d23f-a0fe-48aa-8f17-3fee8534e71f@linaro.org>
Date: Fri, 31 Oct 2025 11:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor
 CSR hooks
Content-Language: en-US
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-2-michael@videogpu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027100938.11822-2-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 27/10/25 11:09, Michael Levit wrote:
> From: Michael <michael@videogpu.com>
> 
> Introduce NEORV32 RV32 CPU type under target/riscv, wire NEORV32 vendor ID,
> and add a vendor CSR (CSR_MXISA) guarded by mvendorid match, plus meson glue.
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>


> diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
> new file mode 100644
> index 0000000000..0cb8663436
> --- /dev/null
> +++ b/target/riscv/neorv32_csr.c
> @@ -0,0 +1,54 @@
> +/*
> + * Neorv32-specific CSR.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

FYI since commit 354925d4225 we mandate SPDX-License-Identifier tags.

