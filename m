Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9845AD277C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLKU-0000v3-M9; Fri, 09 Jan 2026 17:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLKN-0000uY-1F
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:51:31 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLKL-0007pI-Hm
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:51:30 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a1388cdac3so33410395ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767999088; x=1768603888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cf+VCae0sT6DGfBgzHiFD7j7M+Xvk7A1YorFj6Oku5w=;
 b=JqQh9uXHHqz/Bd177LE5vPjRbCBcYOOCy5CbHwTz2sAXRwgaVO8M6J+kJzWGE0noGR
 XNF0BXFycsSL7jSl74AuPeprLtRKivOVZDU9Naooub/+ents79wPm9aJn+qVl7M9SnCo
 TsSgO9mcO5CbYkFQ6v8oioI+5TgXJ5kwTb8QaKkd6VOULh/o0nZ4rRUV5G4hbsTRPe8n
 dToezTG1otPRJqdWUOioFz8IInF3iaQAR75NDW0loRM2WQfyOirGrGhGNJZXD9cTXK1p
 DtPtshRVCSadCeeN/zlJeJEMTNMiUa9ps/dYTgPxu96M6FNVNhNhvMl6gYMovp+jrgpV
 nBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767999088; x=1768603888;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cf+VCae0sT6DGfBgzHiFD7j7M+Xvk7A1YorFj6Oku5w=;
 b=E5pDP2qqJaxytZbJ2SqnREWIU7xUWfeh0VAFY/zUVEDO3A5lNG+LmEIC6pgIdExFgi
 p+c0tVagY66GPcnAJflh/Vel6aB/dGwddfOcWliLTSB1FKrng9r0wnVpt4H9Q30ikDFD
 +sFuKInnuSth2OLRe3C4FIih0Y4aDH4MYqVGnfitcnAaYrO6BD4/3RkdOAzR4ODzWQuA
 rXF8nwgeLzZBUY8PyHNCIovm8R5obLWrMO3iWYh2HzWx0aZEL1s57gH9enZtwgHVAo4i
 cYHRjlKL8yUPs36bviZBxFXNxoSd4UXklnuym4HjCYwgT1KF7oKp9HL6RqAamMg5vjJX
 13xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxkkSIR3H3duW8QRE6og1yqcJGdeYrIa/Qe8Im+WrHq1BFsG3+4sV5VA26cfiC40Nabz15Izl3wQ2a@nongnu.org
X-Gm-Message-State: AOJu0YzH+Y5DRsaFukiov/TcTp7Z6R3siGI6Yui+BhXBlYUfb7a/BNB8
 BRo8q1JVxUOn6QT4GqVhXpWnMA4wE98ztwITvFMcsobBZytGiILQI9QjXfUdVUAKe6g=
X-Gm-Gg: AY/fxX4vlhLAk69kX35F7niGTyhvbd8ngLDahzb6Zb6WcNl4KM9yH4ocnh3BRzVbAtq
 UrMMN2H35t8JdPQcxM4fcyhiUPm8PQlU7fHAqxrD1naWFxD4IxF4Rpw7mAqH0QoKMhc2QNzh0O+
 68qPJVuv3FkljiYBX4lktMHxksXHLdFohmmTi+rViaBsD/tVBZWwFXMZ1uD2UnPofmZ0aZNiHqc
 YhyLLvpCCl/mlhbdrGivGFIWY+Otu2bdnqNd8hUO1IBxz+OLwjCtLfi6Tj+hwfSnpdsNRKA384f
 cpy69t0fpDDlZl9utO+LML7YSB/ofQzgPEf7dJaL/+rlVJDfVTLYsS+sI3wJln4Q+PBbOXxU84j
 bINER1UWJenF0dvScyL0WSt+2FarpfbF3F8UpbIUbHm+NhlGhAbTbwCMuyursJwR0UYImgRFZK9
 u8dKs8x57NBpmrbZsOMTigJTlb3w==
X-Google-Smtp-Source: AGHT+IGjhKNjU0EpBC3ETw6AzW4vxuLTsLtys2WQ6URcGK+IHB0G9rbsaY6qEBuwYIi9UkQ57S//Jg==
X-Received: by 2002:a17:903:354b:b0:2a2:acc7:f1ee with SMTP id
 d9443c01a7336-2a3ee42b15bmr113329435ad.21.1767999087767; 
 Fri, 09 Jan 2026 14:51:27 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd4654sm114827265ad.97.2026.01.09.14.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:51:27 -0800 (PST)
Message-ID: <7e437f4c-b994-4953-b5e0-b8da7f73a3af@linaro.org>
Date: Sat, 10 Jan 2026 09:51:20 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/29] target/arm/tcg/translate.c: replace target_ulong
 with uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-28-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-28-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 55b89817cb1..7128c633290 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6433,7 +6433,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>        * fields here.
>        */
>       uint32_t condexec_bits;
> -    target_ulong pc_arg = dc->base.pc_next;
> +    uint64_t pc_arg = dc->base.pc_next;
>   
>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
>           pc_arg &= ~TARGET_PAGE_MASK;
> @@ -6595,7 +6595,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       bool is_16bit;
>       /* TCG op to rewind to if this turns out to be an invalid ECI state */
>       TCGOp *insn_eci_rewind = NULL;
> -    target_ulong insn_eci_pc_save = -1;
> +    uint64_t insn_eci_pc_save = -1;
>   
>       /* Misaligned thumb PC is architecturally impossible. */
>       assert((dc->base.pc_next & 1) == 0);

With uint32_t,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

