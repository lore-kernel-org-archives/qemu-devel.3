Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E76E8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnS2k-0004s8-4H; Tue, 03 Feb 2026 20:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS2X-0004rA-Ku
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:50:46 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS2S-00052W-ST
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:50:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a93210fcc2so4527125ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169839; x=1770774639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=578GFfVT38ERUL3RFeaL7/zeROh7w5nIRlvU9jxiTgs=;
 b=I8o/8NIWuIW2EA71YbAbndkKn1v8BA70ywcR48BKhVrb/SQbX+6lUbUtwdougNIvYt
 T6Sb+1GI9pw6EnvEyVSEkVf5gym/MeKowKxf0el3ji5Q22cHho0FqOVLO0VzP/FBCDq9
 QqvgZPJezXncpCtskD9matuu4WfIMIdY4MnOZB2WzcjejJ0kYKtsJV5GHrRQzkZuKBIU
 WcrEpSFSlptVH5N5tOC9+ZGORqsKhgQlQHPBcnwWENpQVmP0OHTUUPDyzH55j1KgS6AK
 37V5A0vA/hP7ZlyefKpuwGkQpjQ7/DKaCIFxafHqq5R5IX5SmsqO0CpJNQBbcUZFjMJT
 PIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169839; x=1770774639;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=578GFfVT38ERUL3RFeaL7/zeROh7w5nIRlvU9jxiTgs=;
 b=dnjhOOn1QgxDiTh8yDhhG3/64Ja51ZLKPhno7wM2b7O/QgcQmUuOwGAK+r30vFhU2t
 HDQwtI6NRrT7X4O/6zKHThrw50oU99tPP3Jlg91rzK9mcifO6IS+4YfZbFau+FdFmxMC
 mjfVLoXRN4jc+TMv86NA7l4AmMiMU0Qye5+0QcBIJLs2F9FAHYMsuvxYPCOpqGUXL2ry
 FLBc+pdbJaAYG7NWE+/ldaLXL9jHBf0QVxvmhEvfUmJKqXu+Nfibj43/VbeNlKzdyvXO
 3zELZgIvm+HuSYVGDCWvDD/m6h8ATfhlXx6HQ7gcsGIy025ekZG5E8nY3fOO0iAATeGk
 XP5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWri9ji9jrzG0jLD2vcOuHsK1MW312E36ggj6DTX0nAZ+AEIXHmzGb56cg5VZuMNHLVAgzZQZnnxy5R@nongnu.org
X-Gm-Message-State: AOJu0Yxg8avCwGdPsrvmpMED+uVNyY3m+E85jhN9/JeXQi5Wv5vESgwz
 jrd8FFNKNzAgnNGHYkPVEQt2z656ce/gNH+jFlZJMcEVUm7HX9R4/5pbMDbJqx2U5TQ=
X-Gm-Gg: AZuq6aJGa2dY94s/f1KbiElzQhz8xDhz6I2tNvajMUT2c/LP+h31sLY8Prrm9hvaE64
 O/jlrmrodadbeaQohDjMBJrWvqUMMqfGEFXRDKrKKkjPjpsR1WMynPtEqigpYB2bgZyQvPEaTKs
 3xCdToZIB/hd6NuK0mzW38CMEMcBWktbhBIgo82BYuFIeV1+6UyPEGpsEePqMWZeFWBMzm0tKJx
 hTFEmlOKKqOrcUD0807iCw+xqB/Hkb7Jl2OOpl7F6f0lWKUK6RkgCAIf1SuZt2Hgz0e/F3tD2Er
 htlQtQH8TWCqPH5WGZRmyjv6E/2YW066U3dKr3vu1jp9y/cV4+wYbV5z/xZI60cMi2QiamGpx/Z
 uIiZqmUVzXmmPJ0rN1Pg33VBrxGFkq51+kFtAGJT9Pxd5TvIPxh0mPFVgeFhj96a/2woQIjAUZk
 7apdSwEj6ir4ce2rnJLkoaixx+MaFSKg5HzLtEkEe+pIOapgKjXXXPZ9uQyoBhq6Jw1uQ=
X-Received: by 2002:a17:903:3e23:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-2a933fdd6e5mr9981255ad.45.1770169838614; 
 Tue, 03 Feb 2026 17:50:38 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 ([2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93396747esm6463745ad.80.2026.02.03.17.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:50:38 -0800 (PST)
Message-ID: <59f4d0f4-4d6e-4dc3-bde0-40f41f1550a0@linaro.org>
Date: Wed, 4 Feb 2026 11:50:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] target/sparc: Remove dubious swapping in LD_code()
 helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203230054.23667-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
> Since the endianness is contained in %oi, cpu_ld*_code_mmu() has
> already honored it. Swapping again makes no sense. Remove the
> bswap() calls.
> 
> Fixes: 2786a3f8d3a ("Use GET_ASI_CODE for ASI_KERNELTXT / ASI_USERTXT")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/ldst_helper.c | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index e1178e53d51..10746b3c0f1 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1166,21 +1166,12 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
>           break;
>       case MO_16:
>           ret = cpu_ldw_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) != MO_TE) {
> -            ret = bswap16(ret);
> -        }
>           break;
>       case MO_32:
>           ret = cpu_ldl_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) != MO_TE) {
> -            ret = bswap32(ret);
> -        }
>           break;
>       case MO_64:
>           ret = cpu_ldq_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) != MO_TE) {
> -            ret = bswap64(ret);
> -        }
>           break;
>       default:
>           g_assert_not_reached();


