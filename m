Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BA7C61DE5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 12:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtmEL-00012I-CA; Sat, 21 Feb 2026 07:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtmEJ-00011f-Bq
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:37:03 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtmEH-0007im-Ul
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:37:03 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-505a1789a27so17708711cf.3
 for <qemu-devel@nongnu.org>; Sat, 21 Feb 2026 04:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1771677421; x=1772282221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ddPjIr6y4oW/+RZ/VINxalNTnJZCHL/uTs/uaprpgjE=;
 b=hXTsDR9yiAgL9G4hPKRCGS3/+ugR9B94CwuEGO5S3qXpr83M6OCB0FjYNbNm/F8nDy
 eeMOWZEjOFRM+3OhXhHEnmomqdMw+m+NrCGG+pMJWxu1VKNa9j5MAYN1VM+UDVYHuRmi
 h1dLKEyOT8X8HAuMUruM9NHUWwI4zC8nClaZeVPSKtjWWPRtLzZ9QEKxcmp515AkOCd1
 xpnMfkIt7/t0u7fNT1iqJvT6FCppXFA5BgfAmOo5okZPOEx6Y+WXsSq3W0QAGYUBovZN
 cFYwkjJF0OuxB5zkL8UjS6AWYF7nKAvhns6a7WxnfVSO2rITO/9x/x7RWkLBrvmOU0sk
 DlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771677421; x=1772282221;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ddPjIr6y4oW/+RZ/VINxalNTnJZCHL/uTs/uaprpgjE=;
 b=YrAdxwyF3glv0JZMkzWPLEbQ9GVyfmArO9GCp3xO8xamJPI9lOtBVj4qT8U3TsQKFq
 AY6kVMx/vAfHYX8X1qlPUqwn9BTuSWNHt7qCCoDrXaC4YRO9rA5KM9h5eqSyU9bHxf51
 Kix16cvDDS1X+x8VoJzU29Uwly/DP7+q1l9ZifBdLnE4r+yg8rffUuKstyP1nGi+7ukk
 MUifoZKp3/k1RpldF5gxA2tyz0Lunr7QoYntmuuB1RPjWKWXa1GsYSOy03+1sdDflfO+
 u2Qs5tHyK2G4aOq4arQwNnlQ7982D+5Q6ROLWSX358vadgJtHoqJvbmW6URUkt1YdDsx
 btqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMOE1XkrpA1tKKKScoc7rEv0CGkU5TMdcZ0eZFiadD4OQcVOrMXPqISfXWhZB8MoJ+t7dJK8uKOUx@nongnu.org
X-Gm-Message-State: AOJu0YybvKwkViF6S+AqYZkiJOUZqMlCY2EE9UTYGNlR6nDa29mzdH+G
 EnWaQbLaPgUwytlF6ZlClOtkOQnA7lY+6v4AF1qwKqrlZy9Iam1huOgB//K1DfdOM6g=
X-Gm-Gg: AZuq6aLmNkd1b8TL/R7QdGeb6djMM8ESSqGf6VKtAC2TcV7ipYYYK866tuwYP/FHjdy
 gl6qw5sb0KIK01g1WdFosN9iBhE42oOW6eaUPZeFGJf2gPnGkSoygrviFMVXUNu6RBkEApxPpxO
 XOtGUHMxqg6HFPKU0TVMCFHTuQXqrwt32LhyiEHRvM99dcju0G9UoXvXwph1aU+OeEU2EdUYzsr
 gU/gjoNsRpYE5sY52IHB2NTXsAGGBZLrV6Wbc8jGBM3lxdbOSBWdQH5D/+0jatgRWjPjvoVt2BF
 hJSc3UEHnOekEym5gBQ4qvm/YD2xf4qAtMxeixYWO4Al3akPFqJufQQDxBO5pbN1cdOQn28XIPS
 EpejQfO92fRpkCGONnOf1q0p3q/6+WdL9d9UHDU54po2RyBtmvp4B2TWZv4O8VcovgMfX9w9CdS
 LtcTbNYqcFrAbUg/p8hvt3odb2//ZnN0Mu/GRqgCHm0NkskQ0gqQ==
X-Received: by 2002:a05:622a:30f:b0:502:a063:c436 with SMTP id
 d75a77b69052e-5070bce53efmr34925591cf.70.1771677420729; 
 Sat, 21 Feb 2026 04:37:00 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e2481c9sm17187346d6.32.2026.02.21.04.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Feb 2026 04:37:00 -0800 (PST)
Message-ID: <19634665-a951-46b8-b351-4987977ea0b3@ventanamicro.com>
Date: Sat, 21 Feb 2026 09:36:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/50] target/riscv: Remove unnecessary target_ulong
 type uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-29-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260219191955.83815-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x830.google.com
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



On 2/19/2026 4:19 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/gdbstub.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index f89b20ea84a..a053009ccd3 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -52,7 +52,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
> -    target_ulong tmp;
> +    uint64_t tmp;
>   
>       if (n < 32) {
>           tmp = env->gpr[n];
> @@ -80,7 +80,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>       int length = 0;
> -    target_ulong tmp;
> +    uint64_t tmp;
>   
>       switch (mcc->def->misa_mxl_max) {
>       case MXL_RV32:
> @@ -194,7 +194,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
>       const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
>   
>       if (n < CSR_TABLE_SIZE) {
> -        target_ulong val = ldn_p(mem_buf, regsz);
> +        uint64_t val = ldn_p(mem_buf, regsz);
>           int result;
>   
>           result = riscv_csrrw_debug(env, n, NULL, val, -1);
> @@ -215,7 +215,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>           CPURISCVState *env = &cpu->env;
>   
>           /* Per RiscV debug spec v1.0.0 rc4 */
> -        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
> +        uint32_t vbit = (env->virt_enabled) ? BIT(2) : 0;
>   
>           return gdb_get_regl(buf, env->priv | vbit);
>   #endif


