Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF3ED59D78
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU60i-00005L-Us; Fri, 12 Dec 2025 11:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU60O-0008RH-Pr
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:28:33 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU60N-0004Md-8D
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:28:32 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d13986f8so1221724a34.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765556910; x=1766161710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zqsXbUH3qSBH0UWzh4RIdcGvwzpd/UQuDJyQMj0wUNI=;
 b=PyerH37DfVLuShiBIHMBQTVikxfyo2OpKuknpFXCBfiPR11m2hMooQ5q+ixY2fPXSY
 SGBxvllVkSo1iqk1l+blU5/ja+mdhN9ARUBHzVcqRM0pfOisQi+M8S8WPqqNuafk8uJz
 tnUYHqexROCvC+5BcqmSuRHwB1O+w/oZ32sN9Iy0ifGDMd/+qmeBfTM+jgzmRJRHCuuM
 dVHq5+wTXvAUqYyJK/ke79lVy0ACa8KSe0BSswKgsekJl4PJKRREuzqWppF7wS4C4xvt
 0SetvFoY+rVtC1JdKoy3lssGoA0UV08H5xl9V+kzJ6Sj9G/fQ4Yj18hQ1wxrDZdOpo/N
 rvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765556910; x=1766161710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zqsXbUH3qSBH0UWzh4RIdcGvwzpd/UQuDJyQMj0wUNI=;
 b=ccdavDKbPpqHAzYPfm2XHagK0aHLpAziwkq8R3bT1u+6ja+mLjN4Nre9PmLHDAHpH0
 Jv39H9B6ZYmd3feY+F4RGo0Lvfwh6kWSxJLtfzeNXkVUihtn5A7IRSq38acT529o5+Lu
 8Wnyui7+1aS9JYxhVQDczbQVTpPFDqBLIfmWy3D5ZGq0J9Y9IKONFtcJldFH/AaH+0Dm
 iytHr03EsrgVGCXt8GANCuMfeK6YxeKyR0qAe8pmYzpBJvlxpMP4VU7duGWNgivPln7F
 c8VY8SwB1t/tKKWJhE96MffmrKshS19xTZVP6fxJ/omZyjlMRxzdZNRxDWGyv/AbYcNO
 nWGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsthgwXF/s+gHx6iW55g6fvfwJGBUpdw2gGqAZpxZ0oYhvbMxwuoXyVOrWK95taVOf8ek1Y6bJHknF@nongnu.org
X-Gm-Message-State: AOJu0YySmkyk2g4kvUCCU2weyI3+cKwX3h8mu5XGZTLxQmfVsXMhk0OR
 Tu3WYnkVIlE6yk4fCFj8JC8f+xmSrRYdQpExi69vY/QIqW/uZb1OGTW9rx9MCnkoYpc=
X-Gm-Gg: AY/fxX6T9vxExGQNJsa7IPmWeMJps3k5n/bSZ/Gr50NJDWM9x2LOFiAT5ylbMf9pMhQ
 8cNaHqnWm0PIytFcn7hJ+9DNuFt7U/i31EsE3JpOjeKxLTBvyX2VRLZw8Jnb8dviLxPNW3Yot5s
 7pgiamyNhvkhEJeghRSLZosJiHVvQTVMDYdSsIOozI03tiThssetojngi0XEbSv05rLBSBYOFRp
 Z/F/su2/A92fLdKT02x8f4oIth6IV/CqP0WirZnDCx1Y7RnzRE4jyc+NdN4tQNV5iye53u2/vZZ
 hZA/VtCRNuHL2AyuaOSEh1Z4sg3/fgXw+TCPoTzSVuGsW2jc8BfwrU1HpvGq4pgM+1494gN2Q5W
 CXDx/csua8bZTyKjrQnSHk6eDaeIghaATUfuBDSwGVFmozRCGbvnUdTD7NhD+W2KMJDar2fUqLL
 f7MvL9eQaXa5044n4X+9L350xueL15
X-Google-Smtp-Source: AGHT+IEwBry1c03hgIYf6MzogI1thbkO0bqBRKkArLs/2J53jOAfdaJm9IU+63HwSOxjrN2fFgdXGQ==
X-Received: by 2002:a9d:7849:0:b0:7c7:5958:baad with SMTP id
 46e09a7af769-7cadca95097mr2432499a34.0.1765556909811; 
 Fri, 12 Dec 2025 08:28:29 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1d0facsm3753989a34.3.2025.12.12.08.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:28:29 -0800 (PST)
Message-ID: <2680c481-088b-4366-abc3-7d48d90db0b5@linaro.org>
Date: Fri, 12 Dec 2025 10:28:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 11/22] target/mips: Use big-endian variant of
 cpu_ld/st_data*() for MSA opcode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> MSA vectors are accessed in big endianness.
> 
> Per the "MIPS® SIMD Architecture" (MD00926 rev 1.03):
> 
>    3.1 Registers Layout
> 
>    MSA vectors are stored in memory starting from the 0th element at
>    the lowest byte address. The byte order of each element follows the
>    big- or little-endian convention of the system configuration.

This says "follow the system configuration" ...

> 
> Use the explicit big-endian variants of cpu_ld/st_data*().

... so how do you get "big-endian" from that?

> diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
> index f554b3d10ee..d6ce17abf9a 100644
> --- a/target/mips/tcg/msa_helper.c
> +++ b/target/mips/tcg/msa_helper.c
> @@ -8231,8 +8231,8 @@ void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
>       uint64_t d0, d1;
>   
>       /* Load 8 bytes at a time.  Vector element ordering makes this LE.  */
> -    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
> -    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
> +    d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
> +    d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
>       pwd->d[0] = d0;
>       pwd->d[1] = d1;

This really seems to be exchanging one bug for another.
And the comment no longer matches.

Also, this would be much better accomplished inline as

     tcg_gen_ld_i128(..., mo_endian(s) | MO_128 | MO_ATOM_<something>);

where <something> will be MO_ATOM_NONE for vector of 1-byte elements, MO_ATOM_IFALIGN_PAIR 
for 8-byte elements, and MO_ATOM_SUBALIGN for the others (which is slightly stronger than 
required, but we don't have MO_ATOM_IFALIGN_<N> for all N).

Doing that for the stores as well will allow removal of ...

>       ensure_writable_pages(env, addr, mmu_idx, GETPC());

... this hack.


r~

