Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B0CC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 00:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trnB1-0005bY-6T; Mon, 10 Mar 2025 20:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trnAq-0005aE-Ld
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 20:08:46 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trnAn-0005fL-GS
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 20:08:43 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2feb867849fso7371218a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741651719; x=1742256519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PTvxJUlPBJjWMPlx3bz6qPMSvpnDhRXJlpzPDdfISJA=;
 b=RCUxvX4iyZD32o7vBXOGGE24h06RD9FZ5pNvGEsY4zKTqROy7Fiyb4UKwq79g3tQ/i
 k72+jNrdMOyqh3wbBcu7KJOpkxjT9r9oEcJ9tofxJz7W4fDTbFISnzFrHAUXk5Pjdfs3
 XPijIWS5Em/yvvNbLHKuJ7SbYlYwQ+zDVuShhZc1LSAczL+EVvBWoBViNchz/enHTrs1
 4H2ADmkdDBoDRwP77DMQXLvDl/2uQ/ReaoJX/WJRGPHdT0Wf4vA0JAf0bOGarTZcj2pu
 ilTv8Qkxo+AEoYOG9TDVPyCc2OH/rXezrDmvDUrGvtRr/vMOPSRTJ3PneK9fL4SHgiWe
 Qw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741651719; x=1742256519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PTvxJUlPBJjWMPlx3bz6qPMSvpnDhRXJlpzPDdfISJA=;
 b=XEraA/sZgspHql+ecCZi/8HWW3hZzwHKkBR8T72A/zQ6J66/sf2aQFBgMqSbqvD+hw
 an+k8dagbGa8+7mPHeMl96+k6nYLQ6TAvdN8rKGRB1GnJtGxvv2T+JCFyty8yFmHVAHf
 fdr9BdZwtnJ0mvHN20ZuBFb6oIuHSiKVGmy4dNMShAXdA7wLjQRKtaxLA1mEhpQBg5PQ
 SG58SQSAoWOS/QNZosbo35Jpj6tWNUAgHf8aOvi2KHRfH2VSLqW3lZC85yOz98a5r23Q
 yVy0A1+QW8zaTC/Ec52Q9CpmELb7Bxetnt2r0SYg3T5EY0AObEViESfVXOwATrFLSET5
 F7Qw==
X-Gm-Message-State: AOJu0YxlhlHbXiOuXuXmgxxYK6t/C4ePQhhG6kd5iTiRTw0Vy4v/cftB
 hnwdlRC163EkSwYgCmq2BSIrY5Q/P74EZTp/y7NoXR8PVLGNwfqLZgkT8zIvAV0UiPSaxf5TSko
 6I+U=
X-Gm-Gg: ASbGncsU6mpm/AN6C3bXZmBJfveMYAR/IgA1u4n4sMJ9d8Ub73eiP47kF6yfA2P+I1W
 4yOdrIOKiIdKgpcAnMT+BumeioetHJAorT8W40tFiR4By13wZgNAdIp9J2275xxduUOv4dayBDf
 EqQEJ1abQn7m8i2jozuX4ELKVFrV4r57SWQNWceXLqRufM0YaZEwOxnVwHZtM2IzuqshsjRvrRf
 Phl2Qj9MudglhUXYj+AH6/14p9rUA511asGqZ5eLsSP1zk+3LROtXYz8XPUv548uIFFMHrounld
 ft5mQzJDrRlYOQT484biSgL89NUzqent9e2i8n2+XTNw3sOnrP3jzOtlOw==
X-Google-Smtp-Source: AGHT+IGi4aJraVBfVl/EoRE61kEiyTdmOlXjmvYO10+d4f3aT2ylBHqrXw1ypyhAFiauPBgYo5Y/4w==
X-Received: by 2002:a17:90b:3c49:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2ff7cd62f6dmr28557548a91.0.1741651719455; 
 Mon, 10 Mar 2025 17:08:39 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30103449c84sm109325a91.1.2025.03.10.17.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 17:08:39 -0700 (PDT)
Message-ID: <106877af-deff-4919-adad-698b4c09b85e@linaro.org>
Date: Mon, 10 Mar 2025 17:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] exec/memory_ldst_phys: extract memory_ldst_phys
 declarations from cpu-all.h
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, manos.pitsidianakis@linaro.org,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-3-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250310045842.2650784-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> They are now accessible through exec/memory.h instead, and we make sure
> all variants are available for common or target dependent code.
> 
> To allow this, we need to implement address_space_st{*}_cached, simply
> forwarding the calls to _cached_slow variants.
> 

It's not needed, following inclusion will do it.

#define ENDIANNESS
+#include "exec/memory_ldst_cached.h.inc"

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h              | 15 ------------
>   include/exec/memory.h               | 36 +++++++++++++++++++++++++++++
>   include/exec/memory_ldst_phys.h.inc |  5 +---
>   3 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 17ea82518a0..1c2e18f492b 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -75,21 +75,6 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
>                                  MEMTXATTRS_UNSPECIFIED, NULL);
>   }
>   
> -#define SUFFIX
> -#define ARG1         as
> -#define ARG1_DECL    AddressSpace *as
> -#define TARGET_ENDIANNESS
> -#include "exec/memory_ldst_phys.h.inc"
> -
> -/* Inline fast path for direct RAM access.  */
> -#define ENDIANNESS
> -#include "exec/memory_ldst_cached.h.inc"
> -
> -#define SUFFIX       _cached
> -#define ARG1         cache
> -#define ARG1_DECL    MemoryRegionCache *cache
> -#define TARGET_ENDIANNESS
> -#include "exec/memory_ldst_phys.h.inc"
>   #endif
>   
>   /* page related stuff */
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 78c4e0aec8d..7c20f36a312 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2798,6 +2798,42 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
>       }
>   }
>   
> +static inline uint16_t address_space_lduw_cached(MemoryRegionCache *cache,
> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_lduw_cached_slow(cache, addr, attrs, result);
> +}
> +
> +static inline void address_space_stw_cached(MemoryRegionCache *cache,
> +    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    address_space_stw_cached_slow(cache, addr, val, attrs, result);
> +}
> +
> +static inline uint32_t address_space_ldl_cached(MemoryRegionCache *cache,
> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldl_cached_slow(cache, addr, attrs, result);
> +}
> +
> +static inline void address_space_stl_cached(MemoryRegionCache *cache,
> +    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    address_space_stl_cached_slow(cache, addr, val, attrs, result);
> +}
> +
> +static inline uint64_t address_space_ldq_cached(MemoryRegionCache *cache,
> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldq_cached_slow(cache, addr, attrs, result);
> +}
> +
> +static inline void address_space_stq_cached(MemoryRegionCache *cache,
> +    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    address_space_stq_cached_slow(cache, addr, val, attrs, result);
> +}
> +
>   #define ENDIANNESS   _le
>   #include "exec/memory_ldst_cached.h.inc"
>   
> diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
> index ecd678610d1..db67de75251 100644
> --- a/include/exec/memory_ldst_phys.h.inc
> +++ b/include/exec/memory_ldst_phys.h.inc
> @@ -19,7 +19,6 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#ifdef TARGET_ENDIANNESS
>   static inline uint16_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
>   {
>       return glue(address_space_lduw, SUFFIX)(ARG1, addr,
> @@ -55,7 +54,7 @@ static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
>       glue(address_space_stq, SUFFIX)(ARG1, addr, val,
>                                       MEMTXATTRS_UNSPECIFIED, NULL);
>   }
> -#else
> +
>   static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
>   {
>       return glue(address_space_ldub, SUFFIX)(ARG1, addr,
> @@ -139,9 +138,7 @@ static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t va
>       glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
>                                          MEMTXATTRS_UNSPECIFIED, NULL);
>   }
> -#endif
>   
>   #undef ARG1_DECL
>   #undef ARG1
>   #undef SUFFIX
> -#undef TARGET_ENDIANNESS


