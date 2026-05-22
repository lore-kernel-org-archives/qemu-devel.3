Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B3ACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 16:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQSeP-00030y-BC; Fri, 22 May 2026 12:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQSeL-00030a-V0
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:23:02 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQSeJ-0002at-Ny
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:23:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-834f1075805so5828890b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779466977; x=1780071777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2a3OLjUBA+2xGktt1SP7Os9MY6KgVnYiFjV3qCQD+CA=;
 b=i90+VuHToQPaAbY4ZBYCgq5GJP4b+jXnQrsbaZIr56r1IJHfHoY/1m0OtL0/gUs+k8
 zaphpnbrdMgfEeymjtYFZTTHxZY96KZw0xeW1ni4xnvVW9MkndMwucI+BZC3c7pZ4f42
 98/ztVm1pJEKqHzrBhJK4Gh/e+ipAW/niiB2UbPPKkMsirjRGg8GaQBjDZHIWPGxXoUE
 r/0BS5OLUVjAt11s69/B6jvoHNHYcIykO0s6qSvysoCLXptz9vc6KFbMBsBNWwn+dIjE
 zjBX0QIyNZlvD0TwZ4t9guGvhjfIF8BLv6H53dKeILKNV52IoJl2YeOL7j7JNhg6m12t
 kzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466977; x=1780071777;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2a3OLjUBA+2xGktt1SP7Os9MY6KgVnYiFjV3qCQD+CA=;
 b=D19minXxGeXjGvVPN5IKYuMR7rNpioDhMXHw1rZzFsgg4P3oQPyIRV22HuCD0BNvQD
 AvBAch0htqZzwHkTKfT5sWKyNOLCbloOZRDZ1SHB9qGgUGaa8FUMR7MqeQMhSUQUAEbW
 8GVae1VJigHk+0Woxxsuf5ghNBUCx3+KNe0bSDLGNSoIwOmxI+uF8Lm9bSrPJDVcy2so
 fUFI7Ns6IB1W2D8cys49W76AtqWVm4OJT3Qid75bDh9rp//cmcA/GXz+wUHv+HyetGto
 EA4OIe7CUeYSe5BViP0qyKfAnuTC7cxkazcwyjx9kLpROYqAijNmRWSJ05OkQqZmFfq6
 TPYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VyTdAzhXCBnMBz0iJUq69miQyzyqA16emDpOmWkZOv8kldIK9+Aq57gnuoqU7Xe/EKOdaByJitbKy@nongnu.org
X-Gm-Message-State: AOJu0YyTwLz3eglxGH97+cbV016jfGMm5DeAlhrsrqHS0G+aZEcwSevh
 HsEW54i+CDNwOG+g16N9XIxhgDxm9h7wDBVFGAgrM5thysof/acFkS8LqsEWCV+coQA=
X-Gm-Gg: Acq92OGAwpUIJXHvk8a/hmYrO8MvKlrzJE1aVzxUZ8nPkxYNc9SqsTUW8IIkkNIXXrw
 krasortPMMaMtGWqpNOI4EUdJYRIbalTUoTsqdNMyR/9dPD1mV9tN5QvIydQt8skul/sl7Y/OOT
 bqrPU5t4KHiFt6BKX0k/O9aD9Ax8OkoNe/j6ka9y/clFln+z5r7ytFp+7uWnt4yv8GBhBhXRM3d
 Cc53FnPd52MCqoMTumZQNcytOAu+2d46ZPBe50Vfwc9Afjb8tGnQrkXE6M1qR8zWpSXLPr0Mk4Q
 U/gSxhkmWFpKdROCzxvivfwJSQhaOcpNkaUDVTYOEV1zWFHHoiOXbr+Qxe+vq5nrXrlaxScdQR1
 FlXqhCWS7AH5sPcImhZ8cSGGRkf/GNaEpCiVRnMPezQKTbiHEFvM3fc+uLAxKA/5+uW9o2wxS33
 gMFtLFahb2HFjVscN34arwahfb0w05Aj4oo8t+rN/N9xYSaxLf3xI=
X-Received: by 2002:a05:6a00:1bcc:b0:82f:6e9:d1ba with SMTP id
 d2e1a72fcca58-8415f35ab63mr5072433b3a.37.1779466977331; 
 Fri, 22 May 2026 09:22:57 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9c77sm2687592b3a.2.2026.05.22.09.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 09:22:57 -0700 (PDT)
Message-ID: <34e75cc3-6ed8-4318-a327-d34d6a8da749@linaro.org>
Date: Fri, 22 May 2026 09:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/22] target/mips: add Octeon SHA3 COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-6-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-6-fbf08e164830@gmail.com>
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

On 5/21/26 22:19, James Hilliard wrote:
> +static uint64_t octeon_sha3_get_lane(MIPSOcteonCryptoState *crypto,
> +                                     unsigned int index)
> +{
> +    if (index < 16) {
> +        return octeon_sha3_reg_to_lane(crypto->hsh_dat[index]);
> +    }
> +    if (index < 24) {
> +        return octeon_sha3_reg_to_lane(crypto->hsh_iv[index - 16]);
> +    }
> +    return octeon_sha3_reg_to_lane(crypto->sha3_dat24);
> +}
> +
> +static void octeon_sha3_set_lane(MIPSOcteonCryptoState *crypto,
> +                                 unsigned int index, uint64_t value)
> +{
> +    value = octeon_sha3_lane_to_reg(value);
> +    if (index < 16) {
> +        crypto->hsh_dat[index] = value;
> +    } else if (index < 24) {
> +        crypto->hsh_iv[index - 16] = value;
> +    } else {
> +        crypto->sha3_dat24 = value;
> +    }
> +}

You could write

typedef struct MIPSOcteonCryptoState {
     union {
         struct {
             uint64_t hsh_dat[16];
             uint64_t hsh_iv[8];
         };
         uint64_t sha3_dat[25];
     };

to maintain the architectural mapping and keep indexing trivial.

> +static void octeon_sha3_xordat(MIPSOcteonCryptoState *crypto,
> +                               unsigned int index, uint64_t value)
> +{
> +    uint64_t lane = octeon_sha3_get_lane(crypto, index);
> +
> +    octeon_sha3_set_lane(crypto, index,
> +                         lane ^ octeon_sha3_reg_to_lane(value));
> +}
> +
> +#define OCTEON_SHA3_XORDAT_HELPER(N) \
> +void helper_octeon_cp2_mt_sha3_xordat ## N(CPUMIPSState *env, uint64_t value) \
> +{ \
> +    octeon_sha3_xordat(&env->octeon_crypto, N, value); \
> +}
> +OCTEON_SHA3_XORDAT_HELPER(0)
> +OCTEON_SHA3_XORDAT_HELPER(1)
> +OCTEON_SHA3_XORDAT_HELPER(2)
> +OCTEON_SHA3_XORDAT_HELPER(3)
> +OCTEON_SHA3_XORDAT_HELPER(4)
> +OCTEON_SHA3_XORDAT_HELPER(5)
> +OCTEON_SHA3_XORDAT_HELPER(6)
> +OCTEON_SHA3_XORDAT_HELPER(7)
> +OCTEON_SHA3_XORDAT_HELPER(8)
> +OCTEON_SHA3_XORDAT_HELPER(9)
> +OCTEON_SHA3_XORDAT_HELPER(10)
> +OCTEON_SHA3_XORDAT_HELPER(11)
> +OCTEON_SHA3_XORDAT_HELPER(12)
> +OCTEON_SHA3_XORDAT_HELPER(13)
> +OCTEON_SHA3_XORDAT_HELPER(14)
> +OCTEON_SHA3_XORDAT_HELPER(15)
> +OCTEON_SHA3_XORDAT_HELPER(16)
> +OCTEON_SHA3_XORDAT_HELPER(17)
> +#undef OCTEON_SHA3_XORDAT_HELPER

There are 3 bswaps here?  One too many or do they all cancel out?

get_lane has put the data in "cpu" form; value is put in "lane" form; then set_lane swaps 
one more time back into "lane" form.  Do you in fact need any swapping at all, or is this 
a straight xor into the SHA3DAT[] array, and the swapping is only needed before permute?

If it turns out no swapping needed, you could share an inline xor helper with gfm_xor0.

> +void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
> +{
> +    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
> +
> +    (void)value;
> +    octeon_sha3_permute(crypto);
> +}

Ideally you'd not pass in value at all if you don't need it.


r~

