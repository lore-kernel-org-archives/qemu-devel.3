Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC8BE937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 18:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBze7-0001sj-Bv; Sun, 12 Apr 2026 14:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBze5-0001sT-Ki
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:34:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBze4-0002oA-5f
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:34:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cfe71e5d3so2620430f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776018894; x=1776623694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/nkn2EuheRh+RrQCq6mwDj18bK3dXhRRdqFxgobBZg=;
 b=dTNV6ZfXdn/K7qHoPaZmzIDzfxNkZP6N4vT+BkHuieLg3mHkiwTGfCpueOPVcMUfZ5
 1T7Z4lHdN9FaEZC/nEdHLopcJQvGW3dx7b/wYFUbd/aHZLyO3jpR+XjhNzRk5vo9P6ea
 DTslt2sgTRBE662FBXryBTc0gv9BbzL7rtJ7TGR2gJS2LomMXLL7TTziQJ1dEF6HeCai
 bw+WBWYVkgh93yB9m2B+eD6+FgNUWdoGlwIHkAKH8/Gju5+/k5xjfkTMLyo3P5ajic9T
 dHpgqoX16yhF/XFHqf5RrxZPAUPcJOMQftVz47V6Ir3LdBFUOnboiwFa0KquLOj5k9Im
 Kxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776018894; x=1776623694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/nkn2EuheRh+RrQCq6mwDj18bK3dXhRRdqFxgobBZg=;
 b=d93ES6wGEX1TuYoJd2hpN5NVwe22yZeFnkXr9k9CVuJUh49qJusfGB5zrjLXCocD6p
 YWwZYJEODzjNPsWG91r22qX7ekpFnfEmBh9oINyZZrRIja/vUdZ8yx/jYmKK1A7G8c20
 e3Yp8n7+qYJ5QuUhu1QUR/0dAvg28J2JX5KQ3UOhBh3a6IQ3rLRY6vc8EjUxQiILsMBL
 zjLRVGDJy6Use9ktTH40ZvgM4zNGq+xCKyluPfG/bCjOxETtO5GjR+jn7ZKGZy+3SnBt
 H4IpCTIDBZGO5AMQPNNP2SVTFZt7+gc4TbYGAqEgbgPV0096LjnO39t8VqxeLDKI9IQ7
 Gpyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i1e//7dmDFiJEKeVyNX3Cs3q6MCaIbm2/fZBwnsJQSw4tQ4PUswIUS0j54G1gKXxlWXOwN2OuEp8S@nongnu.org
X-Gm-Message-State: AOJu0Yy/EmzNiiYZhISyCjm4p0IzyrTPwQCtwFvfFH6VfJHaFwQD6XIJ
 8gu2WDgaLCY8gEAT1iavPFxKkUVTAf37JD0E36ehKkQWK0E8fPEQRdbaE+iMx/+VaFE=
X-Gm-Gg: AeBDieuloqtNYAtDIdXw5ndgIHpe81e85ClRc2mMuKOKB44HnneruvGujvjUNlPlLWP
 HXcjY8NhbDRh+rGfJ7iVSRkJukXBNbSgYWT/Mbf4LUwbF8U7652HrL3JXk5CV/7EdKdWqM2L66q
 /q1F/U4r3CzpbyGx53GYPvIbVO/TTYiLDyvr/7hfB6V2vqV9sH6q6WZKtIhEa7woirSMZlYI2au
 EwD8Dk3zsHHe3Sb8mppqRUJq8i79WTYPjCr6olZMb9RVhkTN7yG8MdlZPclhTyPBQdfHCOKEaXQ
 XOhLrXHgtytGX3whcVBfvSrHj1hRB66rGLNV7NmaI4CRGfTOTw91zLHzRiT0PkKcctzEHb6bFzJ
 bb5mlCqbT3q+FIrq4vJLDRmJeczVnf6HEifQUkxy9J+Xi5aBmShpwqUVDWcLdcTpGNwWvEdcYUS
 YlmhDh4jkWominhGPcGS3ahkPFCvmPjofbrL3wMGM7xkAPQAOvFIGWbdSEQvqfp8pESw==
X-Received: by 2002:a05:6000:240f:b0:43d:77f4:714e with SMTP id
 ffacd0b85a97d-43d77f4749fmr1955689f8f.48.1776018893979; 
 Sun, 12 Apr 2026 11:34:53 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec295sm26182583f8f.14.2026.04.12.11.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 11:34:53 -0700 (PDT)
Message-ID: <1853d555-808b-4816-aff3-216008359fd1@linaro.org>
Date: Sun, 12 Apr 2026 20:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/mips: add Octeon SHA3 crypto support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-6-james.hilliard1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260411070637.72421-6-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 11/4/26 09:06, James Hilliard wrote:
> Add the Octeon SHA3 register window and STARTOP selector.
> 
> Model the dedicated 25-lane Keccak state and the Keccak-f[1600]
> permutation so the COP2 SHA3 interface follows the hardware behaviour.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.h               |  22 +++++
>   target/mips/tcg/octeon_crypto.c | 155 ++++++++++++++++++++++++++++++++
>   target/mips/tcg/translate.c     |  30 +++++++
>   3 files changed, 207 insertions(+)


> +static int octeon_sha3_dat_pos_from_sel(uint32_t sel)
> +{
> +    if (sel >= OCTEON_COP2_SEL_HSH_DATW0 &&
> +        sel <= OCTEON_COP2_SEL_HSH_DATW14) {
> +        return sel - OCTEON_COP2_SEL_HSH_DATW0;
> +    }
> +    if (sel >= OCTEON_COP2_SEL_HSH_IVW0 &&
> +        sel <= OCTEON_COP2_SEL_HSH_IVW7) {
> +        return 16 + (sel - OCTEON_COP2_SEL_HSH_IVW0);
> +    }
> +
> +    switch (sel) {

        case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW14:
            return sel - OCTEON_COP2_SEL_HSH_DATW0;
        case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW7:
            return 16 + (sel - OCTEON_COP2_SEL_HSH_IVW0);

> +    /*
> +     * SHA3_DAT15_READ aliases HSH_DATW15 at 0x024f, so a single case covers
> +     * both selector names.
> +     */
> +    case OCTEON_COP2_SEL_HSH_DATW15:
> +    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
> +        return 15;
> +    case OCTEON_COP2_SEL_SHA3_DAT24:
> +        return 24;
> +    default:
> +        return -1;

            g_assert_not_reached();

> +    }
> +}
Otherwise patch LGTM.

