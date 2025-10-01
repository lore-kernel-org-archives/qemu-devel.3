Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC868CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rTd-0002jh-Tc; Wed, 01 Oct 2025 03:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rTb-0002hu-1m
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:42:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rTU-00085f-BF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:42:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so1619901f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304524; x=1759909324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQsZV97Yqr+12QmKkeTixQF0XVzCcc8sdkR3KRVf3yw=;
 b=GKeueHcrP+/Xw5hQm3SAAGvteKs3tPIveBEhzj5avlr3WttR4WyGyaNJwkkZbcGV/6
 FXe55T5I/M8Hp3CWxOvYFtqg7V9oA5uY/iZFWGpdhkqEieHiqPrCkj9MgPY0oYDMkV30
 RUKW7T73s6/mPHcr7V+G186+A9n8HTotMl84Z2Yc2bOCArJnYq2UgAmIroHn9XiF6WGx
 krm70gb9u8uH2lsua50Xodggi+EOe/cIkvA2ssZVASpOXc06fF8IcV1XLPvcaEsll2Cd
 pywWedx4xp+rh9YXlC+4zFAim9cl2zYhqQZ4/Quz+BN+skprGGAWSQDYRCydxBzzQ/xH
 uggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304524; x=1759909324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQsZV97Yqr+12QmKkeTixQF0XVzCcc8sdkR3KRVf3yw=;
 b=RAvohMHEGm2M8VIAWJHz37o9QPjlaWfa53f3DHhtVE4lM2FDBiBTt3UpKHGDJI9AH6
 YQsjwtNv5H6FA1WFPlbqTMM8hRjfio1+sBDFctJq+z4sx4LL1t8TTVfthpRs21CMnXEk
 XB9XWVb07BJKvnQTwN3mbAg4/6sOiDx1FXdQUZOpxwRxiYNPupaQc7uCpmNDkaGLir4j
 vc2gwXsx2eugQdVY46HJAYR/s3WnaGjucvfHsoZZ6enVgLVZ3Ye0y6/WaOwBCLCdzorC
 +0/aClkp+veoPJRP7TX6H0DnYm7H0XTZ2a8v06aOiw1LvhaAftQZ+rQ2afJkGcjJ/7E6
 geXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrp25NNVau/o3G5cvyC+0YedWO3lPxeJp2pKb9WWxskjFqc16XhTRj98u5z6O+JNs7Mou4eR+C/rDR@nongnu.org
X-Gm-Message-State: AOJu0YxP2brSKYKe7Bk9xsA3dXWCeszU1FMtYexDzhcT2z+sv4d2jMWM
 ZcMt35PUBxmkYaHp4UYquXtam/SSz5pBZZGddJK3iqoaRyxsj0iwmRpApqxvPz43ZQ892EcjZ0x
 qdtsl82k/qA==
X-Gm-Gg: ASbGncvZeUghZuIB8Ttotfz2+T2whLvzk5phKtMzPg89Gfg+No54jI9m9BPVuh11O9o
 VFio4p2qxsuJZ/t/jfrN8/HzH6O2hfHcwaYC4WY4tA7u/qG6+z4hctZikZZ/X2vBGORz7ttLvtY
 kgPaS8bGe8ZkYPWVOJ2rCeFmST34Ia9cvr13idMaSm3Qi2i4vP98bZ3fiMqDsKk1UfGSSqu8BVI
 3pz/jXaRgDxLx8VPV64NUx0IAKliLjn/tHBNhT5yJ4iLrA3rSM4Xhxpng9w/dtw2Fo3KKg8t3n2
 9JlvpLj5cPDPsq8BeWlm1qR5jWJysaiiJSOfOLt413meiwLtXSoFGg1yEVYPB9n2v5v7xF1xYFu
 54MHWFf5Y8il3NXiwnWFQoYDVXMM0ITOk6h4dbdpz8Afm8jvfmeG1A9cny9dUqcw+XEkJtkFnaD
 5+aetW4sLTB+I8UA==
X-Google-Smtp-Source: AGHT+IFb/cJ8olbpNG9BNJ3lgyVcP5PtyrYC7lemURbomq1mB9/RsSrougkPG3vJ0b3qfprsPk+ItQ==
X-Received: by 2002:a5d:5d85:0:b0:3b9:148b:e78 with SMTP id
 ffacd0b85a97d-4255781c7b6mr2008782f8f.53.1759304523754; 
 Wed, 01 Oct 2025 00:42:03 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb19fsm26277548f8f.21.2025.10.01.00.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:42:03 -0700 (PDT)
Message-ID: <ce7616cd-54cb-4c8b-8c34-8ef795d34eef@linaro.org>
Date: Wed, 1 Oct 2025 09:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/33] target/riscv: Fix size of gpr and gprh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-10-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-10-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 1/10/25 09:32, Anton Johansson wrote:
> gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
> fixing their size to 64 bits makes sense.
> 
> gpr is also fixed to 64 bits since all direct uses of env->gpr
> correctly zero extend/truncate to/from target_ulong, meaning
> !TARGET_RISCV64 will behave as expected.
> 
> We do however need to be a bit careful when mapping 64-bit fields to
> 32-bit TCGv globals on big endian hosts.
> 
> Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h       |  4 ++--
>   target/riscv/cpu.c       |  2 +-
>   target/riscv/machine.c   |  8 ++++----
>   target/riscv/translate.c | 17 +++++++++++++++--
>   4 files changed, 22 insertions(+), 9 deletions(-)


> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..3c910e44cd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -584,7 +584,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   
>       for (i = 0; i < 32; i++) {
>           qemu_fprintf(f, " %-8s " TARGET_FMT_lx,
> -                     riscv_int_regnames[i], env->gpr[i]);
> +                     riscv_int_regnames[i], (target_ulong) env->gpr[i]);

Rebase mistake?

>           if ((i & 3) == 3) {
>               qemu_fprintf(f, "\n");
>           }

