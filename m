Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6328BC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhei7-0006bc-V3; Thu, 31 Jul 2025 21:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uheXG-0007U0-LO
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:26:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uheXD-0006Xd-Ke
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:26:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso556742b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754011570; x=1754616370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6BFiPDSf4hBynoE9qgUxBbYZ8W7q/tDfOUgFFdWrsKk=;
 b=kE64jfZcl9XqHPfYSQuDA9LJv+oBSDyFypQ7ZuDtMH37iw+N/UlY+22jp5V4KEbMQU
 Q/U0Pz6krBc1KQNuDXMQ+TsqTFx2LDiG7CdR4ymMkOxq0qt8NNOFwgT+bAEOwYlyz2xH
 M6reCNLdiGkcBVDQRO4sEvPY1r+HybiGuzkw46LQPhvmwOPv+ZgKbeElwDLlcjhEelPq
 bv7oMC6GUZngn/t8Ea02Cs688/EI53ug+JmAzScCxMZvlTONNLaOlMVrI8jivW4VX8UF
 Mup/o+PsDdgwdynBr51Q1beOfVCJs8t4LggnOpjKcRSvEHWyYJloh1nmRhg/XWETWxYD
 WL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754011570; x=1754616370;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6BFiPDSf4hBynoE9qgUxBbYZ8W7q/tDfOUgFFdWrsKk=;
 b=TBCE3DeaGJao2Aq17HcNFJ8Ucu/bfLJ50mdxejEkAbVZFZvPqSAXz4aY7cfqA7HGJp
 HpJhnpyffZScwszL/XSOZQpUwmIo3rH32t7vFASpto7dP00zx3a3eftOHbstQF4lHEu4
 FomQ/fhsSQakH/e0wR/30RrMafbZzaSouJOnfcbH3glkmU8useXt36URMX9ZnWujl/wy
 hWx6Qt9fc15nJ0J9O2NCsc7qAaFmu+bjfjlL0i7KsYt1Qsf/TuLbQQwdv3NDcVXk9w6e
 qGG5udXMTnkMsnjmmIHy4wcFXw0FW18upvIMG9XVhZVyAJofR7E9cwgTrhevwGqmupZM
 z/iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtQsZk3De5cgCGEPfZNZDRPXHZFozV78CLekCtHP7w89Uf1x4zOd9/s7+fYHUv/H448EpokTfV7V1i@nongnu.org
X-Gm-Message-State: AOJu0Ywit8UyZUoCv5APBnJ4ZbBdrVQ2ULKvCW4YQK13YtUoSI8wcq36
 ysYmtL3Ce9R57jk+ZV6kKY7nZ9u6utuaJmxBXL22WqokR/jayVG1WHxP3y0KwOgAhGY=
X-Gm-Gg: ASbGncsq3uetUFEIr6MLxl+BSOM0h3Zp9OMawZpea6g3kwjwAgvNUR7Cmv3qrK/uyQf
 UjbcF+8/l6jynBqM1TD+X5JVcvQyd8CnVVRx0TH5AwFoQpLxg6Eq7MsTDfkdDwZCMF1jtgnoy0C
 NsVMw/iYUCZAQukPZ2zmHHl5W+tmUPJrtu8DWio29c3xFU614WETRE1KW93BLC6HoFzYWVl5f5z
 myzxvgqmOPxayhbfBXvaJR3dwaELtcjOCCGnzegK376YfXbkgIBN4d33UmHs1ic5dEgl2j1wv+K
 b6xs3s9kozohvVQ+ro9JBPeP5b/gU4da5Rj138j9o+K7o9ssXH0EbKVJBOGq0gRljWO+hcpxZh4
 jcismvsUJFgZNO/23SuLn3vntZk7ladjAENHxkv8UyCAkTdmONs0=
X-Google-Smtp-Source: AGHT+IHw2qpnsue4dfCvT70oCxhb4720BBd/76CSIi9ykIix8MDC0HVuhVQ2vlCOCboonH2tUWAsYg==
X-Received: by 2002:a05:6a20:3d91:b0:22d:fd6:95a4 with SMTP id
 adf61e73a8af0-23de80e1a96mr1129364637.12.1754011570036; 
 Thu, 31 Jul 2025 18:26:10 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd733580fsm1571415b3a.7.2025.07.31.18.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:26:09 -0700 (PDT)
Message-ID: <f6ced38c-3498-4580-8653-7585d829fe97@linaro.org>
Date: Fri, 1 Aug 2025 11:26:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] semihosting/arm-compat-semi: remove dependency on
 cpu.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-10-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220621.1142496-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/31/25 08:06, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   semihosting/arm-compat-semi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index 715a22528ab..703db038a4e 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -34,7 +34,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/timer.h"
>   #include "exec/gdbstub.h"
> -#include "cpu.h"
>   #include "gdbstub/syscalls.h"
>   #include "semihosting/semihost.h"
>   #include "semihosting/console.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

