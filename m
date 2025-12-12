Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDA4D59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6Ua-0007QJ-6a; Fri, 12 Dec 2025 11:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6UX-0007On-H9
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:59:42 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6UV-0004fW-3D
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:59:41 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-656de56ce7aso495539eaf.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765558778; x=1766163578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1KxwO6GAW+A/9himVQDux5LbFDhDKLwgNkblIb4u33Y=;
 b=TAJEi7n3/UjnnVyoJ4RdpQXvRzF/xyfHnQnciKhb/FcOMJL2Mqjfhh9fUjlLozPBjb
 QGzpao7M+CnuGAl0LJBrNYgItv5jbWOjJKaUfayy6eiYgWDoGDUfOtbhsyEbjWv2oNje
 wBcHN+eYCOykd8spAFEveafXTUf5TNmSmWI2/0Rmch9CvcpyLiwKxTJCxz4TU8gFa7rO
 uq/NyiLPXry6PAIBXe6LVos4wDd+eEyII6d8XFHMcWvbGmW95zB6FdWtkNHbuJKc/Bzx
 FRYLZSXZy362XxrLAnjYYC/ulGUCUIDtYtNevOxV+0LYvRGSK63n8Z4COuNnP/q2x8OY
 kOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765558778; x=1766163578;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KxwO6GAW+A/9himVQDux5LbFDhDKLwgNkblIb4u33Y=;
 b=fDoKVDwS+AWSt7HVV0ZdgEp2WNUUiqVv4TbxeJNTMXk6OUCp6lqe6McOv0UMBoOCpW
 a+3SBdw3b5DVsRbY5jkManr0+Wjib15fAykG1tG/OHexqbWQYk/eV8Jhq9yze47oh7cL
 bTudWJ/jXyFBeOLhVd60qCYENStbKgd7PJu+equhoMDpLceEPL14VK9ssPmH5K47MDAf
 sJEUUKfxcVoT4qu8GqexmP2f8fUPGT05TKH/akNgoGQmB2nk5QcobK9iU5CSYMirCLXi
 9LPr4K77O/cKUkOX5sz3V7GuiJAsyv/oQhWHHtNt+JB78D/MAJnQkJ4Z0dwy8AKhEBxe
 0qzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwAPayY0A329ST/cZsNt7WuVH5p87b4H67TFIyB9E6cV7ZY27Z9j7TJtEXEgJh+34PbFztfVs71OSV@nongnu.org
X-Gm-Message-State: AOJu0Yymh73A5Ok6NTWye6ZHP1DppobJzdBFEt9iQcQpZ8bZExjIiECX
 sn3PQD8uuXCI+E2MSkg32s90/uJff1OYK8bdTRxwkc7+JdUeqcSUvLykVxVCh3BlpJs=
X-Gm-Gg: AY/fxX5O7nk8LUnmQq5PnKXahON0Edt8b4h79sGWlUU7Qf3SCFlWG4ZrIcJnIf+upxM
 JG0T1kAFU1eBqEx35pbBUfXGbpHhQScF8HudYJC3aNjIl31oFHgUn6qy+XYm+UvgPAwvfR/KhJq
 L1rJwFsDIJmCEgj5Yc8BDPmVhjhuw9CH7alzsVOMK+GAxk2+r1bRt+A5oBTvRCihbjdZZnGXJw1
 cZGdc2HwETYmOcOQ62/L0KSMdPuAlvowsG6cFMKUbwTK4kYIrxdRcGoPkYBkXLGxMNeaSzkxtQl
 BB3wBTk0b3yl8SFcDCBMU8sMtThF+bmx5UHDGPZ5TsRUJDV5/a+/7d75tvRw623mSR3CGNjPi36
 iI5B4qamOdqphyThuqAvjRVN7+3QCdKQLAim9MBpCU3j1l199JQN3FTIae35QY1hSOvDEmzcO4Z
 mF5PCii21RnWyqj8J88HLML/h3VJLsUOuy1yTtEkc=
X-Google-Smtp-Source: AGHT+IFhJRn4RZgO437ZcSR+VuDg2qg4ifjdtUckrwUVTzbBjbjXeIZFkU0ikH8oWJGYalV1tw3IdA==
X-Received: by 2002:a05:6820:1612:b0:659:9a49:8e0f with SMTP id
 006d021491bc7-65b4527356emr1014125eaf.81.1765558777687; 
 Fri, 12 Dec 2025 08:59:37 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe54d310sm1314039fac.18.2025.12.12.08.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:59:37 -0800 (PST)
Message-ID: <70362ba2-063f-487c-9926-4177a78acc42@linaro.org>
Date: Fri, 12 Dec 2025 10:59:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 19/22] target/ppc: Inline
 cpu_ld/st_mmuidx_ra() calls in memory helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> @@ -342,9 +357,10 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
>   void helper_icbiep(CPUPPCState *env, target_ulong addr)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> +    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
>       /* See comments above */
>       addr &= ~(env->dcache_line_size - 1);
> -    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
> +    cpu_ldl_mmu(env, addr, oi, GETPC());
>   #endif
>   }

Missing MO_[TBL]E.

r~

