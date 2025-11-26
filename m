Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DD6D11195
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOMC2-00007w-Kz; Wed, 26 Nov 2025 15:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOMBq-0008SI-Bq
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:32:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOMBn-00042t-Fa
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:32:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so691145e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764189153; x=1764793953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ygtGNrynoety6Nl6+Rn6/dKCisvm5xnZk2KyWUw3Tak=;
 b=g8vQALZwX0A3rUbEXORNrAU4Oso+ao4b+JyUcs7lkwxh2HKf7Lhei9wePFvn1bxeuI
 dFRrEv2jvk1ENqsoJBN1deaGGP5dxljfFqBHu6M3cSTo6I+QqAHUistDtwLnE+iBGIiE
 nDcmNTbO84q5Z2d/JWMM4ty8P1DBMKt6+HG/O+BVgZU7DKj04qvVoKcw1bUDs4yFuFih
 wljI2BhdQa2NCdMMnfjZfBBNfbptgEj4TZXNr/mkacroTvhWEJDQ7roB8+bAYCHGX8jx
 iphair5hk7t71fE70sOlzsRvZAnQQV8X4km1Jpl4+d1COjaAGFHsPb3v61EHEDJZp5/t
 zRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764189153; x=1764793953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ygtGNrynoety6Nl6+Rn6/dKCisvm5xnZk2KyWUw3Tak=;
 b=J8iDIz7kBQqV7kz8tljHJS8GmLpnzZFErs3FwyRxvoks0IJwB0HC0AEZuCEic1FsPw
 0TeN2w5qHIuyHitSZCR+10aC8Vn8FMxlPpqJgFSmiIt0tIFkvuFD3wBNx09vFrRJgpK6
 gTiMr7yS4svqWkRXHUB2KHsIb8f+DDt2EJPsOEzURI4ACBrMDuVP7EndOPXCOAXa4y8n
 cJ5HT+Z0faVHGrwO5N82KKnv/QzE4EagdRalTD+Z8Pu4apgOXnvmvUr9/cMLlrerUUhE
 /LDavlTIwJLWtfGVSFZoWwlgBn6/+qA84rgLKMB15kMn542Cz9H2YUG4WHNipxQCtEz6
 ceoA==
X-Gm-Message-State: AOJu0YxgstGVs7LQRvlvoIsMCZnmjp/0O3QoBxPHligcEDvuIgFhR2Qx
 rh4zxPyi1aOUYkJY0neoXY9TanAku0DTEGPC5xl+J4xzBirVgAXsCsKrfi1awG+QCFMeb6NB7iH
 yP8Z1XgLL1Bll
X-Gm-Gg: ASbGnctDWROv7st8s9OMbKTvHu6c+hKn2gSJCaphbHICGRhsvpfhN0FJOOFEQNz2urN
 fNEd8VO6mCLbWYpTv/bC99WBPirphzV6ZxJNWZDXS5hfyeN6lFZd6u12ENH5w9nwcLMr5OIpyd9
 M22v6gVi7mB+p9j2xIUDWzxnkRuTEq626R1td+xcZdKnGx4wB+/qozXcDrUSgTNe9Cz+3M19owD
 81VTVtk27yp8IXOM54nBCCKEXcgp9c2SsV4kii6ALv1YOddyAdiLinSPUQktL+vEH92y84XEP/G
 1wT2OlxoBKi7VZCrLmccu4KPJcgkzyjtmP1gy71S+RFf7rmjtmz+f8orbayd3L50zpS3hT8KYXr
 5UqdOksWnKYIvS6DovrcoXU/3S2LnzOLHPklViipK6BDVnvBrZ70SWwRwzAYTvgkInVQfy1G5pg
 zck56kAurvUdZPZn8Wd9X/NlgUd5Ejd/0KX3wlZXT5LMBwyUMiG+yU+A==
X-Google-Smtp-Source: AGHT+IH2CJrzQEquAQRUhnfKn7U4s0O2h5qH1+16p3f8jqzHrvM+12YfM6Pjohyceon3QiJDeLfWRg==
X-Received: by 2002:a05:600c:3baa:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-477c01ecc7cmr205301885e9.34.1764189152984; 
 Wed, 26 Nov 2025 12:32:32 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040b3092sm51610795e9.1.2025.11.26.12.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 12:32:32 -0800 (PST)
Message-ID: <d6d5cd40-ac5c-41f2-85f9-db038fa8b5a6@linaro.org>
Date: Wed, 26 Nov 2025 21:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 22/22] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-23-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126202200.23100-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/11/25 21:21, Philippe Mathieu-Daudé wrote:
> All uses were converted to the explicit cpu_ld/st*_{be,le}_data*()
> helpers, no need for the non-explicit versions anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h | 46 ------------------------------------
>   1 file changed, 46 deletions(-)
> 
> diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
> index 0de7f5eaa6b..12dd38599a6 100644
> --- a/include/accel/tcg/cpu-ldst.h
> +++ b/include/accel/tcg/cpu-ldst.h
> @@ -428,52 +428,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
>       cpu_stq_le_data_ra(env, addr, val, 0);
>   }
>   
> -#if TARGET_BIG_ENDIAN
> -# define cpu_lduw_data        cpu_lduw_be_data
> -# define cpu_ldsw_data        cpu_ldsw_be_data
> -# define cpu_ldl_data         cpu_ldl_be_data
> -# define cpu_ldq_data         cpu_ldq_be_data
> -# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
> -# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
> -# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
> -# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
> -# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
> -# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
> -# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
> -# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
> -# define cpu_stw_data         cpu_stw_be_data
> -# define cpu_stl_data         cpu_stl_be_data
> -# define cpu_stq_data         cpu_stq_be_data
> -# define cpu_stw_data_ra      cpu_stw_be_data_ra
> -# define cpu_stl_data_ra      cpu_stl_be_data_ra
> -# define cpu_stq_data_ra      cpu_stq_be_data_ra
> -# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
> -# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
> -# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
> -#else
> -# define cpu_lduw_data        cpu_lduw_le_data
> -# define cpu_ldsw_data        cpu_ldsw_le_data
> -# define cpu_ldl_data         cpu_ldl_le_data
> -# define cpu_ldq_data         cpu_ldq_le_data
> -# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
> -# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
> -# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
> -# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
> -# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
> -# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
> -# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
> -# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
> -# define cpu_stw_data         cpu_stw_le_data
> -# define cpu_stl_data         cpu_stl_le_data
> -# define cpu_stq_data         cpu_stq_le_data
> -# define cpu_stw_data_ra      cpu_stw_le_data_ra
> -# define cpu_stl_data_ra      cpu_stl_le_data_ra
> -# define cpu_stq_data_ra      cpu_stq_le_data_ra
> -# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
> -# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
> -# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
> -#endif
> -

Missing to squash:

-- >8 --
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c906c6509ee..e956aece673 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -152,3 +152,3 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, 
mmuidx, retaddr)``
  ``end``
- - (empty) : for target endian, or 8 bit sizes
+ - (empty) : for 8 bit sizes
   - ``_be`` : big endian
@@ -157,4 +157,4 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, 
mmuidx, retaddr)``
  Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
- - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
+ - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_mmuidx_ra\>``
+ - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_mmuidx_ra\>``

@@ -190,3 +190,3 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
  ``end``
- - (empty) : for target endian, or 8 bit sizes
+ - (empty) : for 8 bit sizes
   - ``_be`` : big endian
@@ -195,4 +195,4 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
  Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data_ra\>``
- - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data_ra\>``
+ - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_data_ra\>``
+ - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_data_ra\>``

@@ -229,3 +229,3 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
  ``end``
- - (empty) : for target endian, or 8 bit sizes
+ - (empty) : for 8 bit sizes
   - ``_be`` : big endian
@@ -234,4 +234,4 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
  Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
- - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
+ - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_data\>``
+ - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_data\+\>``
---

