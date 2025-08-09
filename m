Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C064DC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukizZ-0006KE-Sr; Sat, 09 Aug 2025 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukizV-0006IA-D7
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:48:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukizS-00070O-BM
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:48:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76bde897110so2483779b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754743681; x=1755348481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cp+kq1kiuPmCrBGqV90RbMSxs9Zx4z51RJP1zwoPQMY=;
 b=RArKu3oc6UkcXCUFoNUDfqVFrIzuWHBQ2Soc379oCOmhCtYhz60BfXQdB052zlrsvC
 cn0npzGZzRxGfc3VVoF6CWtsCR01ZRgfUHfxoh/q+XsK9Pclx9nWs9XkCRoBs1Zh4SKp
 oMuPoFkYdGZ5GY6Z+/R/ecYjL9LTqMKxYweeN5EWG18BanEdewuR0O+4w/1EO9MZZsBh
 pGOH6A+Nh4icnX8ZIcjYQ/BbLqvcoZP3F7HE5SmPPf6r7zcZwhUm21GYMhGZd0hz5bIw
 qf4Clersb/eieTXOmaofhgvkqq9VeWHXT05WEvtahrIDcLR+3AxmYANcgs7Dtmf+TPXH
 ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754743681; x=1755348481;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cp+kq1kiuPmCrBGqV90RbMSxs9Zx4z51RJP1zwoPQMY=;
 b=J7Z9ts80QJCTAE19kgfL8PwfLtCz5AXYP1iG5GOnJ1ErkCIhom6BESDY/9OU6TyJ7b
 nHHlx5VQFKjZyuX5UO60FAZuy84guSzlqtpUIQd5U6BanKdjhWjpCMF7uHUPSCn8IgWA
 cjnhEEuEm8bTcziQ55ty7WzDkjwk9eP8k2oG6z3Df/iAKF6dC+v38BbQPpaIOQTCHYqI
 4Y3PPRPpC5k1M5k5+T2Eeu4St/CCz9KIoA8WrL+CJNs00ddMqP9wIHLEP5H/BQ7DpZVE
 CHcMx7yEs+n7LYn9WONPLJRVxMOAlu9Q0O8fqrXK+371Xk48pvA8UJnaUgWrj4nXq9iI
 PAWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUThEDn87LT2f+CnC8xPxC4Kd04jh0gH/I2a/3C7+6rMm0INCzrPGo6pJX2kzjPqBrh4nhLX47D7owE@nongnu.org
X-Gm-Message-State: AOJu0Yyso36P95iWP6zNoIx2XaUDmZmmugj1wog5sFVFLCzNggjugRFS
 YZmNYnUo4SMJB9G2uQzrvTkFARcICC5IFyQ+l1oMaCOkWYu9lTx6ZN2syNV3aQs3D8A=
X-Gm-Gg: ASbGncuhNPoaJ+n9owZpoDi92wiI0qo+oTYG50+Ruemlm43za1tMeIQfDT30EINrSGn
 o3CEgIwhLYM8YRIrZY4yhdwYsMN8l9ikRQtkNLjPc3qDLnyopPI4iC5i4plMMdtWu/dkXXUApkj
 DPSvqTKCmKXC/atA2ZrXFQCpBnP+taxYnv+dz7UFhAU4ZR5H3CmqxB7f9YL5BOgOFnMhJZeeMed
 ATVOK5RAtK8hPngnnkhbHGE3UChzZFg8Kpc6fqRz1mGB3m8vtC74x71Uh/Ukv2qOD2MUS1bGWsB
 9Qj/81idD35OneNNueqQFhuIiwttFV+/ML0xQGeu9DpZh0BANokuMuQ/MoEQJjfayzkC2WLISkW
 HNg+Xl46O50tL7FcY5I0exROYUPiM78zVXBQqMg==
X-Google-Smtp-Source: AGHT+IGqLuOP1J4JneVuyyr0ajOhhZeRPPz10M0AYqTdkAOUM/fQE7BdF4zkQ4Gf3kiwbYoBxbgtmA==
X-Received: by 2002:a05:6a21:99a4:b0:220:4750:133a with SMTP id
 adf61e73a8af0-240551604abmr11072007637.25.1754743680710; 
 Sat, 09 Aug 2025 05:48:00 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd18c9sm22331240b3a.91.2025.08.09.05.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:48:00 -0700 (PDT)
Message-ID: <a28a8a53-013f-4b47-86ac-4053aab1cdde@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:47:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] target/riscv: Add CPU options of WorldGuard CPU
 extension
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-7-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-7-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> We define CPU options for WG CSR support in RISC-V CPUs which
> can be set by machine/device emulation. The RISC-V CSR emulation
> will also check this feature for emulating WG CSRs.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   target/riscv/cpu.c         |  3 +++
>   target/riscv/cpu_cfg.h     |  3 +++
>   target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 09ded6829a..a182e8c61f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
>       ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
>       ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
> +    ISA_EXT_DATA_ENTRY(smwg, PRIV_VERSION_1_12_0, ext_smwg),
> +    ISA_EXT_DATA_ENTRY(smwgd, PRIV_VERSION_1_12_0, ext_smwgd),
> +    ISA_EXT_DATA_ENTRY(sswg, PRIV_VERSION_1_12_0, ext_sswg),

We need to keep isa_edata_arr in order because we use it to create the riscv,isa DT:


$ git diff
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..714fff9c33 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -207,6 +207,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
+    ISA_EXT_DATA_ENTRY(smwg, PRIV_VERSION_1_12_0, ext_smwg),
+    ISA_EXT_DATA_ENTRY(smwgd, PRIV_VERSION_1_12_0, ext_smwgd),
      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
      ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
@@ -222,6 +224,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
      ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sswg, PRIV_VERSION_1_12_0, ext_sswg),
      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),



Thanks,

Daniel

>   
>       { },
>   };
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8a843482cc..a5b045aa2f 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -143,6 +143,9 @@ struct RISCVCPUConfig {
>       bool ext_smmpm;
>       bool ext_sspm;
>       bool ext_supm;
> +    bool ext_smwg;
> +    bool ext_smwgd;
> +    bool ext_sswg;
>       bool rvv_ta_all_1s;
>       bool rvv_ma_all_1s;
>       bool rvv_vl_half_avl;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5aef9eef36..343e46e698 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -694,6 +694,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           cpu->cfg.ext_ssctr = false;
>       }
>   
> +    /* RISC-V WorldGuard */
> +    if (cpu->cfg.ext_sswg && !cpu->cfg.ext_smwg) {
> +        error_setg(errp, "Sswg extension requires Smwg extension");
> +        return;
> +    }
> +
> +    if (cpu->cfg.ext_smwgd != cpu->cfg.ext_sswg) {
> +        error_setg(errp, "Smwgd/Sswg extensions should be enabled together");
> +        return;
> +    }
> +
>       /*
>        * Disable isa extensions based on priv spec after we
>        * validated and set everything we need.


