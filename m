Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB2CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0N2-0004EG-Tj; Mon, 05 May 2025 14:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0Mx-00049j-Ou
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:16:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0Mw-0003qF-1E
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:16:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so4820052b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746469004; x=1747073804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BchCeEPL8wuRtLs78ZrLwBtVoYzaAUcUsNidwPxVufM=;
 b=lNZ70Ky0tUwwFM0yA6+1fth/fZTMwP4Ih4UVnIQCMTeVJhacaCBPfdfIVAz35TkZuh
 D/FdhQHt7vVazjma2yKXUjuAf6tX7DIoaujRlY447IGcHmWjzOoD/8VPe2P/qzSX7Un6
 K37n3D1r2iMmWSwQk+nOLBuy7PYsFk/f21boegUBMRWth3hlyDu/apA8Xsv6DWbpaDVB
 mWonDQd8XVf5ChHvqUMDS8PeEOf8Vt7kESOrOoiwLO+jAgcsfZ7OGzqXD6bVDSeVE89O
 81Qu8aOuDfVlc4kO3cSte1ZDK5w3dXPkwCJzFJ7QtcDDyih21e45BNnmCb+7luvRrgyq
 Z10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746469004; x=1747073804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BchCeEPL8wuRtLs78ZrLwBtVoYzaAUcUsNidwPxVufM=;
 b=p40bexGb3lHDK8hyeyA9/PMF1dBZi/zhyUvTGbDG6uSmJaswXZVClf1/OLjtOv3aId
 vicVkJit2PPpjqG6W6ejol+dXJwxjCIBJGPFfhHDaSLqjzOo2ohTm/Kuk9TVaIFHGlfr
 F9hzmEUk/rychnWYxD+dpKuZKF2DD5PopletMZL/UkjBGRHhAoOmtAYKIB9ow9PpsaJg
 jyuYebQndEw1WOLEKg0RUgP3EXuR3nyw0HmxZJF+/WMahSO1cpa4e8eL0xmZiQadDreK
 jIighSFPGIIAEvg75H/fMGvPxrhgPoVdLLSVzUQVJbqjsIalaJvBt0zMalM1RnpXE3wD
 rrFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhM/P7mrL89B3Fxtv2gxIYbaeKhrtLnKK3/f80BqMT+oJeiyFS7oYcFz03lHJtsALy6Dip8Q2Gg1tl@nongnu.org
X-Gm-Message-State: AOJu0Yy90rYDmKCzlSiRtMkN6Ta6vOuwie/EGbyiVlnS9LLy9XkIvnwj
 m+iGPKIIMw2/auid0EXlE3J/JI5KVkZZ17zPT+bqR7JKb0tsEaHs5TlkJt/s0Aw=
X-Gm-Gg: ASbGncufXxmoWGLlktzkyxYXP+CkSyXHRm4YCnDdyrT3zCH/Vzeo1UtaKlIABQ2up4h
 hRWq2pd+P0qQxQianyD3n9+M6V8UGBv+NLpJcqVNkTZ8fVSOxpMon5Qv2a/nbLiqPM/FDnuU0A8
 MpJnQhsQHYf0sqhk/o06EXvv8IVUTlvt/12+W5LdpdufBl+o+OZSGTI8DCwNgJswFOGWhbwyDMT
 swAFF8WhdA2rBtraaFlD9RIPzUQXz4Y6uehKgSN04xQuEHQDyXntj0eVWGOHlXRdv24XObElwDk
 LUqHMDWl1S/VVye6q4PvWP43rDeO3kacppqBaElg78vYDR1aQyKUCRiLDatQLW1MKZyNKM7MrhH
 WhQx8Ubg=
X-Google-Smtp-Source: AGHT+IHLaJqv/nTfqTpCIyc/1kl9cKYSzSNidERZv/lJL28Ems3xAyS3U4DNz3L90vSb0ZsaJ7JV0Q==
X-Received: by 2002:a05:6a00:ad8f:b0:736:5f75:4a3b with SMTP id
 d2e1a72fcca58-7406f0b12dcmr12173654b3a.7.1746469004375; 
 Mon, 05 May 2025 11:16:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbbe30sm7373448b3a.62.2025.05.05.11.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:16:43 -0700 (PDT)
Message-ID: <a4db0117-ad89-47b3-b027-9c4e8cdc45ac@linaro.org>
Date: Mon, 5 May 2025 11:16:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/48] target/arm/helper: use vaddr instead of
 target_ulong for probe_access
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-17-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/4/25 18:51, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h        | 2 +-
>   target/arm/tcg/op_helper.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 95b9211c6f4..0a4fc90fa8b 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
>   DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
>   DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
>   
> -DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
> +DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
>   
>   DEF_HELPER_1(vfp_get_fpscr, i32, env)
>   DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 38d49cbb9d8..33bc595c992 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
>       }
>   }
>   
> -void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
> +void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
>                             uint32_t access_type, uint32_t mmu_idx,
>                             uint32_t size)
>   {


