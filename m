Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4141C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukimd-0003sq-33; Sat, 09 Aug 2025 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukimY-0003qg-Jj
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:34:43 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukimU-0004zU-JL
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:34:41 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b427094abdeso2790931a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754742877; x=1755347677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UtBXg7in+rRruFjNX5zjGJHXAkoRHe5CXX4sVmOwwoM=;
 b=Wjfr5SBFzWfpX3aC/ljKkH5aeqtKnrK6bnNvUNGAUcNfdLIwd1ewtLu7madtzHOJeM
 /6UeOshuiikJAw6s7XMq9PkRtxW8xbSOKRTHftsXPEiS5l1pEAvytwEc5L7cyOtGOF2g
 xG+2xiLVjeydqULaYdLX6Hm0kaXduRcQB+XPfQIs0K9/m6rDYhh28D6HZHkeObruJBxO
 POlZcGPQ7l3Ha69Zzcp5C/5b+yq1FTAOn0+R3Rn0JanmtnvYTWAw2OnnIAnGXoldcNoa
 HbYPbZoG28hF4i2+coqyarw4c+PKiniItW9PEtxFc0SeBXRSov6VxylIVYEHFqdEtGgq
 q6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754742877; x=1755347677;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UtBXg7in+rRruFjNX5zjGJHXAkoRHe5CXX4sVmOwwoM=;
 b=TT+q47u3j+Sw1GVtFo1OuIgbRSo7ICw+LuHCBE06qvdPJM4PxCXQcUu1J4olbbhYDS
 DdlVmCkbU6irb21FvFf2/86Ki8qUbv/U6WPoYsAoBC8upkfnyyFM3AP8vZkK86F5YVp8
 zoRBCJwa5cS8eHxtnC6UEXl+9fH8jMzwmROqbANr9qqDLhGGD8CtivSQQsnn2PbORpcN
 Fwd/PYrlU7J8IWBh4oceK/QgghpKZAFbxFIfo/14IKTFHGgweUTaWcYsUORfdqnc8TNS
 qN+PpeA74KxLkq74RJPO0zkwig+eA2e0hLbCgHh+tY2moyslihCtmHTqWrc3STgjpa7z
 BXMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMkq8KVtkl33ONYyihLP3MRYHTSTbdowfXcebkysqVuBLtFE7CRXKbS2f9/wyGTqRsrJ3VFB3foi13@nongnu.org
X-Gm-Message-State: AOJu0YyCmPHldCae3FStf4SsVfwot/9tnvdCs0x6r6JVVqFy0PDAlW30
 sAFtzb2x44K0bIusGJgllEAOuFJ5ukhyk/Uc/D8IyuveA1Lrpu/PBZEEBPwy3/4JIQE=
X-Gm-Gg: ASbGnctGFQMJ3DJKSzYwHAdRySVWzGeASxDbYgetF5R/4V+teglx/hSmbrk/35V88zJ
 ZVzxIvs6hCaVH+pBm3JOheNH5wfdc0AVavrz1tF9UvmN+FHkqGN/Po70b7aDc7PyJioSYy73OIF
 KTvdyXPae3Xw54I1ecPodqEwyb5qUhfoV6U6iBrZOWsdvqbGOQhlIdOu3wpOAkS4HAHku9e/YXg
 GUipVa8e+JvHi5UXFDA1w+thsoMuA5/43cbjBCMJCOd2rgwDMeCb90bf+Amb4+hjc1pisPSZjYX
 7UpP844CsSJKkBm8JkN1skG6+7cTCdcnxdDhE3JbaEQ14yIGyXnGIIHcZVomOhvS+BY68BgCMZc
 hiUdPgz0MwVy0+gl6NvHd28JD9p13fpUeojEmkQ==
X-Google-Smtp-Source: AGHT+IHk+fVSxvOEnacP0CPLjZvQ96Ocu16CsnxDYvmWeAAat4b3VYDMlhMAlmwPjwSFIq6pBJ/xJQ==
X-Received: by 2002:a17:902:d4cb:b0:240:6d9b:59ff with SMTP id
 d9443c01a7336-242c21de2d9mr90526185ad.33.1754742876710; 
 Sat, 09 Aug 2025 05:34:36 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89771e2sm230324595ad.88.2025.08.09.05.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:34:36 -0700 (PDT)
Message-ID: <e7616702-8a7b-4617-8433-236a1086bdf9@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:34:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] exec: Add RISC-V WorldGuard WID to MemTxAttrs
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-5-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-5-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> RISC-V WorldGuard will add 5-bit world_id (WID) to the each memory
> transaction on the bus. The wgChecker in front of RAM or peripherals
> MMIO could do the access control based on the WID. It is similar to ARM
> TrustZone NS bit, but the WID is 5-bit.
> 
> The common implementation of WID is AXI4 AxUSER signal.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   include/exec/memattrs.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 8db1d30464..7a6866fa41 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -54,6 +54,11 @@ typedef struct MemTxAttrs {
>        */
>       unsigned int pid:8;
>   
> +    /*
> +     * RISC-V WorldGuard: the 5-bit WID field of memory access.
> +     */
> +    unsigned int world_id:5;
> +
>       /*
>        * Bus masters which don't specify any attributes will get this
>        * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
> @@ -63,8 +68,7 @@ typedef struct MemTxAttrs {
>        */
>       bool unspecified;
>   
> -    uint8_t _reserved1;
> -    uint16_t _reserved2;
> +    uint16_t _reserved1;

Is 'reserved2' unused? Not sure why you ended up removing it in this patch.

If it's really unused it's ok to remove it but this should be done in separate.


Thanks,

Daniel


>   } MemTxAttrs;
>   
>   QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);


