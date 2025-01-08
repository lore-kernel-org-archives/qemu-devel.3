Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C4AE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVesz-0003P4-33; Wed, 08 Jan 2025 17:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVesx-0003OZ-QY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:50:47 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVesv-0002qI-WC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:50:47 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso3844945ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736376642; x=1736981442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WITG0hIsPqjRu3EA3aZz8/e5wgdK+NBnULESHsG1y9I=;
 b=e79uvv3nG8SxVbxrCyrZQX4KRO2lpv65nmm3BmLYLwv5yhnxi+AeQIiyR1EwYJ9cZE
 9MreiknP4ZlKodBlKyIjoxFG4c702VT0/dGkbL938zZCEwXux/r7HwUfXqM0sUMuSumH
 bTcdLRPbhQ/eza7dxGltLhbpWu10uMSpjBRJYqomPhTcz/LJyrrCvZZ6zP9JnAIxf/RI
 03ND0Rmci7zKINsMIHfylAdq5rzQi70CjUu7cSnJ91NlY9xr0GiYCEAtSfjPgMKrZbXU
 L1S3zhnc3B82nqK90raQRjTGz56gz4jAPtR5fV4BxONojTD23Q5UHaJC7JM70/aM9tnV
 BW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736376642; x=1736981442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WITG0hIsPqjRu3EA3aZz8/e5wgdK+NBnULESHsG1y9I=;
 b=KXnGhh4JZVYYQahX73WrTgjBLxXS+25y6fnzujgHRkaJhG53vHbwEM98hcB3+2iVhC
 Lt4tlj8dEiJxl1dB2TbjQXIWMpEAHuoLo7Sztz98F4NyJn1w9/tPZUqeNPPeho+m09Au
 kYk4qg8SC8WJJywGUQeb6q6WlLt0wtCCE+vnyEILjyzjFr/zZgv4vriPDAckQKz656pr
 n3HjsGVwRO3FB3vC1AzkklH3zFKGefKcKML467CDFbBDgr1/9ppl52YHnWn5gieQyAsN
 yLrDMZk52cwifJGDLKuzskhFrR2F+3FiJ7eXmQ0OztozWURxRxL3R1BaFwxsH24mv6Rb
 3y1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0mZbG4eLBPk+5othXJKpyDIp/XGnN1q2kNimEZ9Q3S7NC8M51d/NF1o/dpdeSt8U7iKWrCiePdGD3@nongnu.org
X-Gm-Message-State: AOJu0YzjVMU2xyIBXk01TEwW6/eN4gqYXaVuxP99ZW9fU6XPYjz+GJLO
 UWMjfVNVW8DuwgjOKXN2w138BxRFdBktnjSEA5ecFsuM1wqP0onQPW+rPXVIA0g=
X-Gm-Gg: ASbGncu9tgmUAPQKnGkpHTlKq52UwTjfW7G1akFZ/7fJ530NI1T0zLjx14zrZD+QHAr
 LmE82KVob7ahNUwkSg76JD7iDczEEUhJkI5nPCTRPpEoH6G6HaTRGQmi7zCvt7r6pUUFfnqfHIZ
 +AOMKt3vyNnAiYn6tC6aIUQBmUWg/VdJGfGFljMuqwZVEeR83DzIhDCWhDmjKR2PQd/uPb4KhGR
 +OfIKK3IbSFC8oWBAdY5yylMN/eWK86XQXd3t9Oiup7StdQ6EjsWldxv9QksDPNaBvW7aQIywEt
 zb2iEli5WNyl+2G6trA0MHc/137z6vc=
X-Google-Smtp-Source: AGHT+IG/6jlMH+H7wWejSIPkdM7c7QIbGlwc5Qf82/nFD9lfDc9uQpkV3/gZx6wMy945b/M+pcy9Lw==
X-Received: by 2002:a05:6a20:6a0c:b0:1e1:afa9:d38b with SMTP id
 adf61e73a8af0-1e88d0a1e37mr8744529637.8.1736376642649; 
 Wed, 08 Jan 2025 14:50:42 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84ee4csm35684572b3a.82.2025.01.08.14.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:50:42 -0800 (PST)
Message-ID: <5cb1ef20-acd0-48ed-854c-97f5adb5d58d@linaro.org>
Date: Wed, 8 Jan 2025 14:50:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] target/riscv: rvv: Use wider accesses for unit
 stride load/store
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
References: <20250108143523.153010-1-craig.blackmore@embecosm.com>
 <20250108143523.153010-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250108143523.153010-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/8/25 06:35, Craig Blackmore wrote:
> +GEN_VEXT_LDST_ATOMIC_HOST(2, uint16_t)
> +GEN_VEXT_LDST_ATOMIC_HOST(4, uint32_t)
> +#ifdef CONFIG_ATOMIC64
> +GEN_VEXT_LDST_ATOMIC_HOST(8, uint64_t)
> +#endif
...
> +    /*
> +     * If !HAVE_ATOMIC128_RO, then atomic16_set may be implemented with a
> +     * 16-byte compare and store loop, which is expensive, so prefer two 8-byte
> +     * stores in this case.
> +     */
> +    if (HAVE_ATOMIC128_RO && (is_load || HAVE_ATOMIC128_RW)
> +        && (test % 16 == 0)) {
> +        for (; reg_start < evl; reg_start += 16 >> log2_esz, host += 16) {
> +            vext_ldst_atom_16_host(vd, reg_start * esz, host, is_load);
> +        }
> +        return;
> +    }
> +    if (test % 8 == 0) {
> +        for (; reg_start < evl; reg_start += 8 >> log2_esz, host += 8) {
> +            vext_ldst_atom_8_host(vd, reg_start * esz, host, is_load);
> +        }
> +        return;
> +    }

You need ifdef CONFIG_ATOMIC64 around this block.


r~

> +    if (test % 4 == 0) {
> +        for (; reg_start < evl; reg_start += 4 >> log2_esz, host += 4) {
> +            vext_ldst_atom_4_host(vd, reg_start * esz, host, is_load);
>           }
> +        return;
> +    }
> +    if (test % 2 == 0) {
> +        for (; reg_start < evl; reg_start += 2 >> log2_esz, host += 2) {
> +            vext_ldst_atom_2_host(vd, reg_start * esz, host, is_load);
> +        }
> +        return;
>       }
> +    g_assert_not_reached();

