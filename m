Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6F5CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yoX-0008IZ-9I; Tue, 23 Sep 2025 04:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yoO-0008Gk-C2
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:55:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yoH-00077u-82
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:55:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fae12so1846978f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758617735; x=1759222535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94ZY4lsRezsD6JpcPVX6PoxjsyVUQTAMf3zT7OOJyTs=;
 b=BEIbw2+atj13ahAgqTaiLWZDWtMnY4xuFd/Eb8kWA5Hr5slitoZZz+marQ0JiR36GA
 EqkTEZ754qWhlUr5mUcgvywMjAuwymaPbHRPKnxdoAgRZnxi8/TVnwwQEyk8AqLU/IFw
 QPyMr2g2WFqRgNSlKHO3SPumGapiVgDNZ+0HKhrcjPxapcREFk0akvh/HeFaSwoHVtXz
 Boxsw+4LDmX/FV/WHqdOrPUS4ttWzK5jpAawnLT3dXNyVdXRcN1dUD+Fee8urPxCAwCo
 pF5DxNcPRFB1M5o2UiE2tg3FC41zCqYT0oh23rr4D9Ep8H3kTNSF8FCViqux+fn5npDf
 Gn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758617735; x=1759222535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94ZY4lsRezsD6JpcPVX6PoxjsyVUQTAMf3zT7OOJyTs=;
 b=tH8dYReRknwJW15X+RV/yVeBPvzvI1C5Oe2AeZU2tzlEmqkk43jQu/q3r0SPj2SaVp
 L0Ls0qP1y6XoBWcMgPvNYw2iTfd918QRXbcc2YtCaYHNiVZeEz5WDGNG0GMdxTpFnNQS
 uOke6hgCagGRPmozo9p+/9+z7AJTmlwbmXfWMkK/vnVQV/9q4Nx55DESODtKXvOj9iNg
 dhFdeR8g6OcXHQgsX6pKPWP5eWDoRkcLUj7rLxGd/WXkOY/vueKEOiOCweqxDSuuVH/8
 OXCHUMmE1TpNA/lksvxnuERoeZFR3W5rzDsRnM0xj6qoRXZNYbt2jyeCRKe8S38/69qQ
 JhKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8oGyLSFKsMJqyWVCQSakDV3IfAaTSvYWn0ykKe/27Ak5nD1LvQoOScX3v1wAsBrB8R0wmda6kqjka@nongnu.org
X-Gm-Message-State: AOJu0Yw+Kka4HKXHFjEYHOfaFZgkQ2EgmG6vWQ3dQp6TjsttolCr10Dz
 gSUNxHLWoG/7N91m6+TgZUo7MhgRGVMeyqDyfh74i0b2YIbIUOXYyCNOyyjtVQwHnDA=
X-Gm-Gg: ASbGncvJsQ0k1QEOSHAkTRrOCjVP4bkJkBac8xz25vwZQcydkBg3GI9W8W5ruXtxy3A
 nI8tXGir+s24tdNHW+YM2qQ/8obJYZomGIsBk5Qeu290o/b6LkXqLMmMnu0qb2lsnhB9lhZUiK5
 hJyhZcPH9gMfTGGBz34RwpBFEmnD6OpmURW4BgeM82vuCUqot5A7i3o3Ql0ycPNM4NHr6AF6Kg/
 q5JZGWrPP1FPDoXCA1Fs7jH0LZx+8Wj1QtxMGpFj+Xr4ZyJTXKjLDwuNyWOg/P28hADMSiePv2L
 7xCbWkYCpWSWV9FV4g4ER31QHDSiS4+9LgyfcPp0EY+u9MhYJYP23FrnNjUxivXwtaEeBlw+jK9
 fvXLQHjfHvrw3WpEc47qtD2J6xOzQEPhJLGIje0WJTKLVfhygN2vb70WErjF7LEyRqA==
X-Google-Smtp-Source: AGHT+IHQ6WmvWhJNVmzJ03KMtS34Yp8QNSX7JBk+ih+Dutzw8z/ZHso3Gdz872E9Uxx/9ht+gtUWuQ==
X-Received: by 2002:a05:6000:178e:b0:3f1:2671:6d9e with SMTP id
 ffacd0b85a97d-405c33a35bamr1316964f8f.1.1758617734649; 
 Tue, 23 Sep 2025 01:55:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d33sm23276803f8f.18.2025.09.23.01.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 01:55:34 -0700 (PDT)
Message-ID: <5ed7c59b-5e61-4e79-b4e0-a8441ac5b784@linaro.org>
Date: Tue, 23 Sep 2025 10:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/9/25 04:39, Richard Henderson wrote:
> We only need invalidate tbs from a single page, not flush
> all translations.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> ---
>   hw/ppc/spapr_hcall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c594d4b916..feb31d5dd8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -8,7 +8,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
> -#include "exec/tb-flush.h"
> +#include "exec/translation-block.h"
>   #include "exec/target_page.h"
>   #include "helper_regs.h"
>   #include "hw/ppc/ppc.h"
> @@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
>           if (kvm_enabled()) {
>               kvmppc_icbi_range(cpu, pdst, len);
>           } else if (tcg_enabled()) {
> -            tb_flush(CPU(cpu));
> +            tb_invalidate_phys_range(CPU(cpu), dst, len);

Shouldn't this be:

                tb_invalidate_phys_range(CPU(cpu), dst, dst + len - 1);

?

>           } else {
>               g_assert_not_reached();
>           }


