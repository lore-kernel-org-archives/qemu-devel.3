Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A0FCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 07:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA1Fm-00011T-Nm; Sat, 18 Oct 2025 03:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vA1Fk-00010X-61
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 03:21:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vA1Fi-0000MX-8b
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 03:21:23 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 697BB3F21F
 for <qemu-devel@nongnu.org>; Sat, 18 Oct 2025 07:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760772077;
 bh=aegHmhQdAdIn3GtLUD5DrBNVravsdQm5O98UpW03S3M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=TC1004tyYk67oKWgHfNqEvFWSh1lvpVnWAlsWMFMnfXvettlid7GPr981XKJQk/Vb
 OmAQpDyGxi+RveRsOgRmxbTKU27V1KLt1biu8e6f9UrMv7TrZeMXYng3lZuc+2KfKx
 R26Xyw1JFsbZICuT4gPlJ7fCT8oTr/JvW8U3WaEnmdnq9Rol0DS4kFG+FCrzuqNvIl
 /sanHl18jXEUotr5M0dVHhMbkjUpGzJVxaXGJwbxBySnftXwg15ObYTrXg7OxsKNU7
 3ccHuHXzKi18njPU3JAzT1fQfGdqamfh7RKoqRaTSNbbFEqXxGLFwOAKieyv4zrnAp
 mOHYCbySme51/h+hXkjoY/B5DIwG0CSkDoqNXRrBlkDrIk8V2TvJ52fWCTNLHwrdnI
 gkSs+Tzt9dq+suSR6fwZwCAVg0y9Nuq3YAuZBAxZYvedcqxxyrN243pJ7CTbSwsxoF
 KFozbmRn5qcbQZEL+VnwZcrvXk++m1jG0ibuCP2QPtZX+h8zH3r+f/Hteccr4y9XdQ
 6ImOQ8l/mxaTbbg/vmMiXuVWGn4NQGyJ4eCq3io+0xnuNHUzGnJe9czKRGeaJ4RPM9
 c2b0asFyTSaAzehu6ncxPGcLZzG0dPCIpml5cU16RExJCLhJ5g/kFWDfx3gN5EXEBP
 nBcskFSz0JfkxtHKsIy8CbKE=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so1808677f8f.0
 for <qemu-devel@nongnu.org>; Sat, 18 Oct 2025 00:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760772077; x=1761376877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aegHmhQdAdIn3GtLUD5DrBNVravsdQm5O98UpW03S3M=;
 b=tJA8d2ESuXpGNHJXFYEuwAPwaqYJ8LBjoANRCySPkze8vjgMUQ4BPgm+lxxNsg12Si
 UdD+D9rT+MiRjtWaB4CzoxtleCDbdqPF0pf+XMluoWnnjslcuDdF0JOPG9Xx3Z5uk/+V
 W6gK7jieeGDHSridIbMmyC84l40Tcew2oLqvHZyskj2Sli6Sp69V184A3xt3OxjHW8v/
 up786suUTTCiS6AGA4K5vgOXh+Q7qGckXlgsYDWViN7M94B0HEqeS3lAL+H5oUGoK59u
 FQswPWf7G4e96WMnT/chwOb7LYy9WAkv2Rzmahycp9yKBIizOWCgPkYahn93de9YsHBb
 RPCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuCsePoq7DsJPl8A79SgaB3HqUTnRKL75bfbiyMP+jdeuR+HWgtzy5pkf3i8sMAETxANBgHPjtieo4@nongnu.org
X-Gm-Message-State: AOJu0YxoinvpjbqO98+A8yOuEAghTQDXQZJW+8uePWRwvBs1azd4MBst
 bUXBQeUF0g1vahzJrlYXXA2/+sqcB/58E/GphLBmkuoyq7WukdFpzXhz4rT6cZXVbgrIJShadvn
 JRPvuFJTiLKzZyPJIQ791jqu+VJtO1L2rOPd2PStDek66wXWt7ajyp6G6oJ0s25f+RPEfN4DerB
 vPMV2c
X-Gm-Gg: ASbGnctm2kDnNskRxD4o1LjRMQO9a3s4fxzwUQU6mHgJgNg+XLDdWhdf65c3s2fLPmc
 utVKaZst21k7P5EWBF74G96Bj+gjAZll3yPdNpbT4UR/PxGXqPQIHskIcWQt2kk9P2LtftCHe28
 AtNwy4AD9ByUq++LPb0C41BD4KMwE666aVAFNsUbZWuB3raK2frSYvPP47MIGeQ4cqxNAQ0e+Xr
 x73oVw1IqUOijVQL55KT2kLI9jZeyB3XJd9Q3DHFm+Awh91Ag2d3mkXdtI3mLJW0AiKBLbduABb
 BMD3uXnZzTnYGpFd2x7lHpWC7ZMRYu07q8kVl1a6LeTvC9QwaF+aDydbYw/iSyi6dmBAD0sNLZt
 aDIehFTYIKLSSzWvCkFMRIT5h0H/PVqZewPPGeC6dt/Bjk3T+62Bur89qy6kVYrJL3Mkfxj93
X-Received: by 2002:a05:6000:2287:b0:428:1475:6a0f with SMTP id
 ffacd0b85a97d-42814756c75mr1044426f8f.54.1760772076901; 
 Sat, 18 Oct 2025 00:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/UTUWQMTr9HCGB1KlhyvNzHLzUHRf94rreYwZz03gbOCDV5StIg52iJe1ZsMaZVFZje8LKg==
X-Received: by 2002:a05:6000:2287:b0:428:1475:6a0f with SMTP id
 ffacd0b85a97d-42814756c75mr1044407f8f.54.1760772076421; 
 Sat, 18 Oct 2025 00:21:16 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a781sm3552325f8f.30.2025.10.18.00.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Oct 2025 00:21:15 -0700 (PDT)
Message-ID: <4d1a679a-f1c2-487b-bddb-eaf7dd56fd0e@canonical.com>
Date: Sat, 18 Oct 2025 09:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] semihosting: Check for overflow in FLEN on 32-bit
 systems
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-4-sean.anderson@linux.dev>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251017213529.998267-4-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/17/25 23:35, Sean Anderson wrote:
> When semihosting 32-bit systems, the return value of FLEN will be stored
> in a 32-bit integer. To prevent wraparound, return -1 and set EOVERFLOW.
> This matches the behavior of stat(2). Static files don't need to be
> checked, since are always small.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   semihosting/arm-compat-semi.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index c5a07cb947..57453ca6be 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState *cs)
>       return sp - 64;
>   }
>   
> +static void common_semi_flen_cb(CPUState *cs, uint64_t ret, int err)
> +{
> +    CPUArchState *env = cpu_env(cs);
> +
> +    if (!err && !is_64bit_semihosting(env) && ret > INT32_MAX) {


The issue with the current implementation is that files with file sizes 
over 4 GiB will be reported as file size < 4 -GiB on 32bit systems. 
Thanks for addressing this.

But unfortunately with your change you are additionally dropping support 
for file sizes 2 GiB to 4 GiB on 32bit devices. This should be avoided.

The semihosting specification specifies that the value returned in r0 
should be -1 if an error occurs. So on 32 bit systems 0xffffffff should 
be returned.

As file sizes cannot be negative there is not reason to assume that the 
value in r0 has to be interpreted by semihosting clients as signed.

Please, change your commit to check against 0xffffffff.

It might make sense to contact ARM to make their specification clearer.

Best regards

Heinrich


> +            ret = -1, err = EOVERFLOW;
> +    }
> +    common_semi_cb(cs, ret, err);
> +}
> +
> +
>   static void
> -common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
> +common_semi_flen_gdb_cb(CPUState *cs, uint64_t ret, int err)
>   {
>       if (!err) {
>           /* The size is always stored in big-endian order, extract the value. */
> @@ -319,7 +330,7 @@ common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
>               ret = be64_to_cpu(size);
>           }
>       }
> -    common_semi_cb(cs, ret, err);
> +    common_semi_flen_cb(cs, ret, err);
>   }
>   
>   static void
> @@ -517,7 +528,7 @@ void do_common_semihosting(CPUState *cs)
>   
>       case TARGET_SYS_FLEN:
>           GET_ARG(0);
> -        semihost_sys_flen(cs, common_semi_flen_fstat_cb, common_semi_cb,
> +        semihost_sys_flen(cs, common_semi_flen_gdb_cb, common_semi_flen_cb,
>                             arg0, common_semi_flen_buf(cs));
>           break;
>   


