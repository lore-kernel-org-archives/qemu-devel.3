Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF88C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx504-0008WM-2l; Tue, 25 Mar 2025 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx4zx-0008Vm-21
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:11:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx4zu-0008Im-JP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:11:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227d6b530d8so37967305ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742911877; x=1743516677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0q8ZHqHcodOf4u4kkY22ulJB8ppeZ/DHex6AS60GNm0=;
 b=NifAMpedZrSrSCSAJvF0DUlV+YixhRGsXSOmDG2PRN0VXf3HYegzua9Orq5q4xSowI
 HPbzJCB/BKMxtFUG8ucRMRWSmq8IL2rDbPayp6HDcQh+Bjey65IGElpeJ178a1ZGcWnI
 ZvarUYbo62QkXQPw2uuMrrqGbuTpOXjh/ryyH1PkkWOBSCk/YiXW+9cheYdYlfCT4vBm
 3iZBHDU63SxGxVWH558eUOhekBejEFHUvk94ytulbQBGS1hNtpxSmGSLBzirG9rSxVul
 FaChkZO6zdwIMK0qgYMiSpCA4P0hHI84uVp9jxoyNvOE5VoDGNzgZoAeDTw4q3ocXy5B
 Py1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742911877; x=1743516677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0q8ZHqHcodOf4u4kkY22ulJB8ppeZ/DHex6AS60GNm0=;
 b=dFAzECgE/mGwVtuJkW+4zOCc334YEC5NyPSR8i07rwNg+puIU0O1k+Qupc2vxMSYjf
 UvzbcpNzkQ6mRmfLS7vxnYMEXvldBk5mNhigdF69LFCLwVOYZqITIdyn5laBXrIBzUsf
 fMcp6m6ttG/XSxGG7kMmjCUIJu1pEPTedXa2PJ42zEe1R7MRx7kTDRCRaOEq2277Pka5
 lZYbF2s8lK7F6eSrvTTZhIa1u2hK2n8paMzxtrpr7+uYFTZ8cAp7EA6IAjNJUiVASssv
 Y5A/Q8DrhapP1/GSSYgZkxsQfx/9wsiNHIpgze1KY562DBeWBJwrACJhZAbrHJsFW5QV
 XFpA==
X-Gm-Message-State: AOJu0YyYNM50ZSYOmqP1p34j90O7OL28Lgv9nlTdN3PzecJTzrhZeZnP
 tsUQuEDqkKCvWfe9xBTJQtJR1LFKe/4fa5Uocuk+sw+rw9RIWdVtJYrGJ7D+4yuDMU32nyCBvQr
 p
X-Gm-Gg: ASbGncttrMGtX46ri3A23lDkGy6fLgSj6rQv2tGOKVDoqTdEl6bp80iQBcrey48O/QP
 7AJS/V8vbZfnd8R0jETr3L9SDMVvC7/ISA4diaPmyi1E9HyQ31T4PkakSvzJ6zKYsPQE13dCKer
 jf7NMhgSZ3gJ+ymVE6UWYgQkQdn6LZGTF2ltDwCtqfwZPHKj5yBizkrw2oAUw0tC2fSUrzgTXYg
 abhksVFEoa9FMrhVWstI7aGwA9cqBnxXLlH1cp0a9ZmoZPqKePMez2HFNfg1eoR7dCzNhT2oZgt
 STsk10ZzMxyQFFGZpxcBtDroJ7z6D17yQZd8KOm4fBH0grU3ZMWiunvKu/82Tl4yWKSJ6TpRCDr
 rW0RK5T82
X-Google-Smtp-Source: AGHT+IGBNn7/SC+jtB4DGtfAKqT4Q7IhofNc+B6tfYOiCVk8EbAG4hhRBPaSc3nBqaTxxGQXLjsAkQ==
X-Received: by 2002:a17:903:40cb:b0:224:1c41:a4cd with SMTP id
 d9443c01a7336-22780c50d38mr251174675ad.3.1742911876578; 
 Tue, 25 Mar 2025 07:11:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da2eesm90458725ad.172.2025.03.25.07.11.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:11:16 -0700 (PDT)
Message-ID: <2bfe3f4b-95d3-46a3-8236-75e7a8210a9f@linaro.org>
Date: Tue, 25 Mar 2025 07:11:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] target/sparc: Expose more CPU features
To: qemu-devel@nongnu.org
References: <20250325123927.74939-1-philmd@linaro.org>
 <20250325123927.74939-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325123927.74939-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/25/25 05:39, Philippe Mathieu-Daudé wrote:
> Various features were not displayed or settable from command line.
> 
> Diff of 'qemu-system-sparc -cpu help':
> 
>   ...
>     TI-SuperSparc-60     (IU 40000000 FPU 00000000 MMU 01000800 NWINS 8)
>     TI-SuperSparc-61     (IU 44000000 FPU 00000000 MMU 01000000 NWINS 8)
>     TI-SuperSparc-II     (IU 40000000 FPU 00000000 MMU 08000000 NWINS 8)
>   - LEON2                (IU f2000000 FPU 00080000 MMU f2000000 NWINS 8)
>   - LEON3                (IU f3000000 FPU 00080000 MMU f3000000 NWINS 8)
>   + LEON2                (IU f2000000 FPU 00080000 MMU f2000000 NWINS 8) +shutdown
>   + LEON3                (IU f3000000 FPU 00080000 MMU f3000000 NWINS 8) +shutdown +asr17 +cachectrl +powerdown +casa
>    Default CPU feature flags (use '-' to remove): mul div fsmuld
>   -Available CPU feature flags (use '+' to add): float128
>   +Available CPU feature flags (use '+' to add): shutdown asr17 cachectrl powerdown casa float128
>    Numerical features (use '=' to set): iu_version fpu_version mmu_version nwindows
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 57161201173..37406227cb7 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -548,6 +548,11 @@ static const sparc_def_t sparc_defs[] = {
>   /* This must match sparc_cpu_properties[]. */
>   static const char * const feature_name[] = {
>       [CPU_FEATURE_BIT_FLOAT128] = "float128",
> +    [CPU_FEATURE_BIT_TA0_SHUTDOWN] = "shutdown",
> +    [CPU_FEATURE_BIT_POWERDOWN] = "powerdown",
> +    [CPU_FEATURE_BIT_CACHE_CTRL] = "cachectrl",
> +    [CPU_FEATURE_BIT_ASR17] = "asr17",
> +    [CPU_FEATURE_BIT_CASA] = "casa",
>   #ifdef TARGET_SPARC64
>       [CPU_FEATURE_BIT_CMT] = "cmt",
>       [CPU_FEATURE_BIT_GL] = "gl",

I'm not convinced this is a good idea.

The only effect of disabling these is to break LEON kernels. These features are not 
exposed for kernel discovery, so you can't just turn them on and have them used on 
supersparc either.  They will certainly break anything sparc64.


r~

