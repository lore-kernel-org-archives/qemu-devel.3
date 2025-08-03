Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378CEC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNR2-0006FG-0R; Sat, 02 Aug 2025 21:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNQy-0006AU-Fa
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:22:44 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNQw-000277-PY
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:22:44 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-741a0ec1a05so339555a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754184161; x=1754788961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDfFSRcZMlFH0wjrH9pFxyEoEoZNMxMA3o5BRsLVLuc=;
 b=UfLaYF8+eSMYqTXKu+AT/5xJrR79C2zZhE2ZdL8fbLZcndBqOqNl0almeXvDobfJVx
 f5kb5rjw+Yakq9a5wj0+nJ884pFEBNBQ0IWeaPCqLGtCmeqpHSwozcxJPk7jhEFuPjmR
 y3jvSFtPesXIsXn+RTfOAFgYdZHIwd+ZCkWS/z8DndpBKII5gubN4s+H3+L0PI2Mmx5/
 tZzbuM3SYkMsItLWpTtsSBRgn3uTcqbknWe5wXxY2BxlJu/dIcoDGVXGkHEdNGNIUmJf
 /aZCvjqQjrS3KrlShKpfOtXMfSY9kZau5OPjI3LJkjWeJGzBxP3G783+zBCl9fvHpkWH
 UJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754184161; x=1754788961;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NDfFSRcZMlFH0wjrH9pFxyEoEoZNMxMA3o5BRsLVLuc=;
 b=HWB7JY66eAxoL6WGZzOoYmsrLh2lAqL80PI5Q+VBrG4BrwlhdWiB94/SeU0gY8Z5F0
 lG5WbRu/Ukex5hnhq1RwMhtTMWnvmsUR0sx6HjGYtWTjrPeLpP7ghIkCdI9E+kzOuFx0
 SfQGhEigNpZXThJqgNZOF8OpLwAZ1lTvP2uIbck0oFB3Zb6DuxK9mmhcWV5BIUWnYD/v
 EAlAXDq2JL6Idh3YjlpMqMzFoFwLHJtIx+c2ELwQ6IxUaqw7jfTDkBf2ysHtwYtQKiZ6
 rBmYnnBlIWYu40K0aZ1+c50NoE0RHzoosXE7JAZ3OyX8gTgkXr9GfYONAbZtN8kuR+hL
 YmWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKIH1R125835uBWrX9gXIfVFI6Y3psDJAYt+dWt0atnXoLtc0CDw4mR048WdXxeDlUZ/u8b2L0kSdb@nongnu.org
X-Gm-Message-State: AOJu0YypCD4NWu2dWGAaMQ3oE2jPtV7DlnWtfJwACfQpXtc2G7sKec8Y
 TgOljpue7fdHw+/iX2mYAUHQeEjgJGDoX/oECQkf7V6m3KH5AvCBWz1AQntExwBt8b8=
X-Gm-Gg: ASbGncsJ7h9Z0DetZRnLpQCFQ0yMgDNf1J8gFlQloQWA26qeHm0CyWCJr/HKzqSCLDO
 7k/t38w/YBN4YimVul49Og4VKQ6vLe1DuiE/wcApVuF55yQWrQrk2gCfk7XYonFEq4Hx7B81PQM
 H/07Yg1VXlfp7MafCh82iJHSNeH16GgzUrakHRlHw2RNm2mkR603uF0UAPxob0b8fXeG9dNRYIF
 gpOaD1ebEfE79K+H6Pp8V6j6rMmhsfdNd02mu8DeSAmR8vH7jHEqVj2ubp42keyuCwh9k3mB/7K
 xrBxsVJV2GNmta0IFoCGd7L+hmM3kBFi/Zd4IelQvgDoRHyOitI+6NgIUe5fx/gU0ghyN34dMm3
 ZMgXt2DjX+9Syopq5zV3b+BrCV0GsSt38LY68FYswwK2zMqEYSODzzX+vsR3RGLXZ
X-Google-Smtp-Source: AGHT+IGXROeDgETYZqodtl5pf5XqlaNXTBJzxfFBKC+Jt45DLwoPdu8ycOacfLyrzDjXhLn6kx3gXQ==
X-Received: by 2002:a05:6830:90e:b0:73e:a0fd:ac79 with SMTP id
 46e09a7af769-7419d162025mr2680302a34.9.1754184161229; 
 Sat, 02 Aug 2025 18:22:41 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186daca3asm1525489a34.48.2025.08.02.18.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 18:22:40 -0700 (PDT)
Message-ID: <3ac1c53b-8563-43a5-9a27-58ea3997de62@linaro.org>
Date: Sun, 3 Aug 2025 11:22:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] whpx: arm64: implement -cpu host
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-13-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-13-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> @@ -522,7 +524,7 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
>       isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
>       isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
>   
> -    if (kvm_enabled() || hvf_enabled()) {
> +    if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {

Just a heads up, Phil has a patch which adds hwaccel_enabled().

https://lore.kernel.org/qemu-devel/20250703105540.67664-47-philmd@linaro.org/

and I believe cleans up both here...

>           /*
>            * Exit early if PAuth is enabled and fall through to disable it.
>            * The algorithm selection properties are not present.
> @@ -599,7 +601,7 @@ void aarch64_add_pauth_properties(Object *obj)
>   
>       /* Default to PAUTH on, with the architected algorithm on TCG. */
>       qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
> -    if (kvm_enabled() || hvf_enabled()) {
> +    if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {

here...

> @@ -780,7 +786,7 @@ static void aarch64_host_initfn(Object *obj)
>   
>   static void aarch64_max_initfn(Object *obj)
>   {
> -    if (kvm_enabled() || hvf_enabled()) {
> +    if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
>           /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */

and here.

> +static HKEY OpenProcessorKey(void)
> +{
> +  HKEY Out;
> +  const char *path = "Hardware\\Description\\System\\CentralProcessor\\0\\";
> +  if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, path, 0, KEY_READ, &Out)) {
> +    return NULL;
> +  }
> +  return Out;
> +}
> +
> +static uint64_t ReadRegU64(HKEY Key, const char *name)
> +{
> +  uint64_t Value = 0;
> +  DWORD Size = sizeof(Value);
> +  LONG res = RegGetValueA(Key, NULL, name, RRF_RT_REG_QWORD, NULL, &Value, &Size);
> +  if (res != ERROR_SUCCESS) {
> +    printf("Failed to get register value: error: 0x%x\n", res);
> +  }
> +  return Value;
> +}

4 space indentation.
assert, not printf.  :-)

> +
> +static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> +{
> +    ARMISARegisters host_isar = {};
> +    const struct isar_regs {
> +        WHV_REGISTER_NAME reg;
> +        uint64_t *val;
> +    } regs[] = {
> +        { WHvArm64RegisterIdAa64Pfr0El1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Pfr1El1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Dfr0El1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Dfr1El1 , &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Isar0El1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Isar1El1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Isar2El1, &host_isar.idregs[ID_AA64ISAR2_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Mmfr0El1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Mmfr1El1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Mmfr2El1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
> +        { WHvArm64RegisterIdAa64Mmfr3El1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] }
> +    };

I'm sure this arrangement was easiest before the id regs reorg, but now we can store the 
ID_* not the pointer in the table, and the table can be static const.

Why do we need the host_isar local variable?
We could be writing to ahcf->isar to begin.

> +    /*
> +     * Disable SME, which is not properly handled by QEMU hvf yet.

hvf.  :-)

> +    /*
> +     * A scratch vCPU returns SCTLR 0, so let's fill our default with the M1
> +     * boot SCTLR from https://github.com/AsahiLinux/m1n1/issues/97
> +     */
> +    ahcf->reset_sctlr = 0x30100180;
> +    /*
> +     * SPAN is disabled by default when SCTLR.SPAN=1. To improve compatibility,
> +     * let's disable it on boot and then allow guest software to turn it on by
> +     * setting it to 0.
> +     */
> +    ahcf->reset_sctlr |= 0x00800000;

Is this really required, or just copied from hvf?


r~

