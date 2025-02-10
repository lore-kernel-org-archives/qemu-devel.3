Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61A4C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc0x-00020S-35; Mon, 10 Feb 2025 17:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc0s-0001uD-Lj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:12:23 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc0r-0001H2-3a
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:12:22 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa0f222530so8987018a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225539; x=1739830339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOiFZFeY6nZRExwaSvE4UHNx9D5/MdTLbKqhY7OxuBY=;
 b=dTWBcvCSsSv4U5o4vgpzEyq2LUV1kxExoERdLKEZDpjk5x0LkNrm55VhCE2ymt0r8x
 3MeJ3lT2XPBzXxLxeqFHXrEmlgiiAzvpGxp0M0JugyAgKuUedkFc07BK4QHZJshuIDhi
 BlZKCupUWzBKlCFbWu53S8u/MpZFBmfgWMq+jiVk/nIS+M+m6hJ3j7Hfy2kx+/ZOU1Eo
 96GEYJCHjISrV6Kt42R1Hep+J2SAGykbWztpu12v+ZXZCm9ewhw9i/y/tu+BpGa+UcvR
 vON4uQQLBNRRgnGbRyAejPVF/1aMJctW8zq50K2gxBIfNDclKuaqYF5WgvOIN/qQHD0O
 NlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225539; x=1739830339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOiFZFeY6nZRExwaSvE4UHNx9D5/MdTLbKqhY7OxuBY=;
 b=GZ8LjN6aj1s6//zAOVWgEh/rTUBfdnJjBFGkVFzsj1KvMlVjaXOkbXe1I9TN+C0fiS
 YsfSlmnzVQEbb7NEFPv1CE3Bd1rSn9x8khf4hc9LfJNgpj+Q45hvQOy8YuZW4XxnBA5C
 asTqs0TSS0OS8jeWBuphFYsiqwuhXbyo/Elr3dw4U4wqA1f1FMBm6OeW0TYmeCJmWK2Y
 rVdlQYROBMlTaqvdBvUFiO4WlwPnxMi/e+M5cIf4/vgOarkEukXAcJD7H9FqZmAuyiN6
 f3Mb1zs3uJXEtAKhbmjFYJyyw+JufLyla7z4Lk1Ohf1JWHudskibeQHBm7f4kbSx3q3h
 rxTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ru8kM34lketpRiAipcTDMsIo5Iv5vJvRSvpGAbcjQblCJnTHiV7xGlmdwaA9DOzS2On2cfQSKRFP@nongnu.org
X-Gm-Message-State: AOJu0YyfEaH7UaseEZUXE8WI6EfpEuu2IhsPI3McVno43KCEH0UxDlwb
 fEyGicpe9RZ/7l5Y7iDLujKN8eRFeyPH/MQAEt8dcCPED/OKuQFRb+1N9j7ecGC/A2W6/7AwPWC
 6
X-Gm-Gg: ASbGncuutGCXyd6fEjjRURotSs97CHyZm6/plqHxe61fgbOXaoz93B4gl3/HbObpnJk
 SvLRYkKYFO/LKpJs6HyFujYJWUL28CVEBOWWZdp1CXIBLq0RgACHBD2fdHKNAhudtZFHOUCBnXa
 n7ziPITR6aOLVoDoY3yh9NRYdrLfWgJKTt0JXjwanLJHFWrpXikJ1jlk1AJxgsb33KVrnpfBVPA
 q3IF80K7V6YxFL1G+a3gB6ZbWe3xB3v9lYlbAth/eZ6sF8ODKixGbl14rRjxljFQyKjRA8cOT5u
 rS2KA/HFdxaReJPt9TmSkCj1YsIu8Quu8hG7pXSDWX2tu7HIT/2easo=
X-Google-Smtp-Source: AGHT+IF5NnnZ70mknNM1+vrEr/VE3wkbMiRWyhHgQL+OvEWdxBD+6aC9YL32H3kjEYbCa4GZjcwhJQ==
X-Received: by 2002:a17:90b:1806:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2fa2427064fmr21631778a91.21.1739225539556; 
 Mon, 10 Feb 2025 14:12:19 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa099f4fc7sm9236939a91.3.2025.02.10.14.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:12:19 -0800 (PST)
Message-ID: <5c97a343-16ac-4cae-a58b-052f59ad2c1c@linaro.org>
Date: Mon, 10 Feb 2025 14:12:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] target/ppc: Set disassemble_info::endian value
 in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have the CPUClass::disas_set_info() callback always set\
> the disassemble_info::endian field.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu_init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 25e835d65e7..e816d30114b 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7398,6 +7398,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
>   
>       if ((env->hflags >> MSR_LE) & 1) {
>           info->endian = BFD_ENDIAN_LITTLE;
> +    } else {
> +        info->endian = BFD_ENDIAN_BIG;
>       }
>       info->mach = env->bfd_mach;
>       if (!env->bfd_mach) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

