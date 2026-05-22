Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CFCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRxJ-0002vQ-GZ; Fri, 22 May 2026 11:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRxI-0002v9-3r
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:38:32 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRxF-0000R6-Oz
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:38:31 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-369576666d5so3557760a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464308; x=1780069108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQBV8AjR5yHxb9sNealDfHk87k4r2d4mixiJFvnDrrQ=;
 b=s1L+H8CcFVo8JPuTq3RXon5kqp0ZEdAxnguauDeXBhojIlYjHFYpMzHuErCMSdHcVi
 Nf1Lk6cjDRVa5tznyyq5QYR/1E/iJDNr5i/pWM9P2Mbgz6qr626Tvm+JE99A5/vRBRVD
 mXX3By6PoDp5MGg/D0TuzAAxn+9cf1iysn0QY9OtYZwb/X4VgNurGKar2F1dZoSbIVoz
 uBeZybhSdwQH5KHEIvBppZTIDJBWx3Onr/0DI+onjz4kB+1udTRl6CJVUQ56v8lUWnl2
 h//WIgS4mimNWvx4x3UCYefJ73pOv086U7aHqyOwwICOGMW/knj7y9tI8BaHUG6E2B75
 JppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464308; x=1780069108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQBV8AjR5yHxb9sNealDfHk87k4r2d4mixiJFvnDrrQ=;
 b=AP5VPvDMAV9AlNULdY607wiPDh8uZiG9//TiRXP4J0/2/DxRnLLGt7tO4jHsKVWyAk
 AWt2rOhW9tPww09/jqRq6FfgaiDnNuzTcplozCrXTqzaMZ0686RLXiTYxiObtEoGg3N0
 /cuYjJ7q71iKkPJqF1BWAcQDxu2uhKjvcamkU+KRs8TU2npsXNPndv/7lRilXUp8RKE7
 vwjShvuGVr8z91Gf4COy/ybU0rpi7lufshwOJPqkmfyRpbpaDzYNrfZC673Vhn/Iyqxr
 exQ+z94P5Davl7iGl7k1StGLnE43M4RCNUnLYsvL6kZ0hFZJLBsZfDjYvvffFC5YB1iR
 XD8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iZRjmtzRcqMt54+kw+qECsbHhO6iqn8xMs1tsOuu86eE9yOViOMdHlIRjwPfs5v7wvRtRJlbVH7Wg@nongnu.org
X-Gm-Message-State: AOJu0YzDqhUTokL5Nkq4lPPskZr8UjAOB2jbSR1M6vETqGrq4MbP8CY2
 5ufyYsusgYRE/xgiB/VtmtkbJe/H2JmOLUpJxilkNfg+7XNh5Vf5elgln+75JH0dvFk=
X-Gm-Gg: Acq92OF9VKO0hoONhpvrDNpg6jhBd66k2iHoS0Ly7d1MzwH1QRVRanlGmHbVG6Uz516
 dxPuAhS9ah40dVhewX44RMoxudmvuAuv8mF7pODCP1DtDelouHat+7sy4uuF9vZsYHttyIyGjHc
 tgOPRJTYcYGW9Fpp4tS7s2u7hwewJ9sbjYG0hGIyA1RjQ2vLhS+cJnpkXEpV7aBAlViHsxEs966
 XFOtrLfJckfS6gjU8eq2K+zIyKUHOYZwTHFjQSQwln22q5INr9xd/5OYPBHckNNzrLXhAv3USKN
 Y5XbQws/iP+NVeQPb1TJ7owrMVo5b/MYHcTdN1a+yyh+j19rTI7+6rFN9iT7BjiFOjrPOTK3JjW
 bP3svr2Gn+/ySzcBqjPsa8cYsVA9qTTGBtXN2mLHS96stzcevKquVzoszqAgX6Hq2d/IMb5Ccec
 yrAgDTqFTRvjCJ+WH7HDbnWgs5btxEvIoSBxOliXVfiqIri9xclGU=
X-Received: by 2002:a17:90b:4fc2:b0:368:3854:3a2e with SMTP id
 98e67ed59e1d1-36a676d2e82mr4675472a91.26.1779464307651; 
 Fri, 22 May 2026 08:38:27 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4cd92sm2113257a91.10.2026.05.22.08.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:38:27 -0700 (PDT)
Message-ID: <460e760e-0cd6-4541-8490-195141bda424@linaro.org>
Date: Fri, 22 May 2026 08:38:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 17/22] target/mips: decode Octeon HSH and SHA3 COP2
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-17-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-17-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
> Add explicit decodetree entries and translator bindings for the Octeon
> HSH shared-window selectors and SHA3 operation selectors. These paths
> need helper calls because HSH/SHA3 selectors alias the architectural hash
> register window and operation selectors have visible side effects.
> 
> Keep HSH/SHA3 decode separate from direct register transfers because the
> shared hash-window aliases require helper-mediated state updates.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v10 -> v13:
>    - Keep this patch limited to HSH/SHA3 selector additions; CRC/GFM
>      selector finalization stays in the CRC/GFM selector patch.
>    - Name the 0x0057 SDK compatibility selector as STARTSHA1_COMPAT and
>      document why it is kept despite not appearing in the public manuals.
> 
> Changes v9 -> v10:
>    - Split HSH/SHA3 selector decode out of the monolithic Octeon COP2
>      selector decode patch.
>    - Reworked the shared HSH/SHA3 register-window transfers around the
>      architectural hash state instead of DATW/IVW shadow state.
> ---
>   target/mips/tcg/octeon.decode      | 77 ++++++++++++++++++++++++++++++++++++++
>   target/mips/tcg/octeon_translate.c | 77 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 154 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 70e02d0b0e..b1a63b743f 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -113,6 +113,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
>       CVM_MF_HSH_DAT4                      010010 00001 rt:5 0000 0000 0100 0100 &cp2
>       CVM_MF_HSH_DAT5                      010010 00001 rt:5 0000 0000 0100 0101 &cp2
>       CVM_MF_HSH_DAT6                      010010 00001 rt:5 0000 0000 0100 0110 &cp2
> +    CVM_MF_SHA3_DAT24                    010010 00001 rt:5 0000 0000 0101 0000 &cp2
>       CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
>       CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
>       CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
> @@ -137,6 +138,30 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
>       CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
>       CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
>       CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
> +    CVM_MF_HSH_DATW0                     010010 00001 rt:5 0000 0010 0100 0000 &cp2
> +    CVM_MF_HSH_DATW1                     010010 00001 rt:5 0000 0010 0100 0001 &cp2
> +    CVM_MF_HSH_DATW2                     010010 00001 rt:5 0000 0010 0100 0010 &cp2
> +    CVM_MF_HSH_DATW3                     010010 00001 rt:5 0000 0010 0100 0011 &cp2
> +    CVM_MF_HSH_DATW4                     010010 00001 rt:5 0000 0010 0100 0100 &cp2
> +    CVM_MF_HSH_DATW5                     010010 00001 rt:5 0000 0010 0100 0101 &cp2
> +    CVM_MF_HSH_DATW6                     010010 00001 rt:5 0000 0010 0100 0110 &cp2
> +    CVM_MF_HSH_DATW7                     010010 00001 rt:5 0000 0010 0100 0111 &cp2
> +    CVM_MF_HSH_DATW8                     010010 00001 rt:5 0000 0010 0100 1000 &cp2
> +    CVM_MF_HSH_DATW9                     010010 00001 rt:5 0000 0010 0100 1001 &cp2
> +    CVM_MF_HSH_DATW10                    010010 00001 rt:5 0000 0010 0100 1010 &cp2
> +    CVM_MF_HSH_DATW11                    010010 00001 rt:5 0000 0010 0100 1011 &cp2
> +    CVM_MF_HSH_DATW12                    010010 00001 rt:5 0000 0010 0100 1100 &cp2
> +    CVM_MF_HSH_DATW13                    010010 00001 rt:5 0000 0010 0100 1101 &cp2
> +    CVM_MF_HSH_DATW14                    010010 00001 rt:5 0000 0010 0100 1110 &cp2
> +    CVM_MF_HSH_DATW15                    010010 00001 rt:5 0000 0010 0100 1111 &cp2
> +    CVM_MF_HSH_IVW0                      010010 00001 rt:5 0000 0010 0101 0000 &cp2
> +    CVM_MF_HSH_IVW1                      010010 00001 rt:5 0000 0010 0101 0001 &cp2
> +    CVM_MF_HSH_IVW2                      010010 00001 rt:5 0000 0010 0101 0010 &cp2
> +    CVM_MF_HSH_IVW3                      010010 00001 rt:5 0000 0010 0101 0011 &cp2
> +    CVM_MF_HSH_IVW4                      010010 00001 rt:5 0000 0010 0101 0100 &cp2
> +    CVM_MF_HSH_IVW5                      010010 00001 rt:5 0000 0010 0101 0101 &cp2
> +    CVM_MF_HSH_IVW6                      010010 00001 rt:5 0000 0010 0101 0110 &cp2
> +    CVM_MF_HSH_IVW7                      010010 00001 rt:5 0000 0010 0101 0111 &cp2
>       CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
>       CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
>       CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
> @@ -153,6 +178,10 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
>       CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
>       CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
>       CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
> +    CVM_MT_SHA3_DAT24                    010010 00101 rt:5 0000 0000 0101 0000 &cp2
> +    CVM_MT_SHA3_DAT15                    010010 00101 rt:5 0000 0000 0101 0001 &cp2
> +    # Cavium SDK code uses 0x0057 as a STARTSHA1 compatibility alias.
> +    CVM_MT_HSH_STARTSHA1_COMPAT          010010 00101 rt:5 0000 0000 0101 0111 &cp2
>       CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
>       CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
>       CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
> @@ -182,19 +211,67 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
>       CVM_MT_CRC_BYTE_REFLECT              010010 00101 rt:5 0000 0010 0001 0100 &cp2
>       CVM_MT_CRC_HALF_REFLECT              010010 00101 rt:5 0000 0010 0001 0101 &cp2
>       CVM_MT_CRC_WORD_REFLECT              010010 00101 rt:5 0000 0010 0001 0110 &cp2
> +    CVM_MT_HSH_DATW0                     010010 00101 rt:5 0000 0010 0100 0000 &cp2
> +    CVM_MT_HSH_DATW1                     010010 00101 rt:5 0000 0010 0100 0001 &cp2
> +    CVM_MT_HSH_DATW2                     010010 00101 rt:5 0000 0010 0100 0010 &cp2
> +    CVM_MT_HSH_DATW3                     010010 00101 rt:5 0000 0010 0100 0011 &cp2
> +    CVM_MT_HSH_DATW4                     010010 00101 rt:5 0000 0010 0100 0100 &cp2
> +    CVM_MT_HSH_DATW5                     010010 00101 rt:5 0000 0010 0100 0101 &cp2
> +    CVM_MT_HSH_DATW6                     010010 00101 rt:5 0000 0010 0100 0110 &cp2
> +    CVM_MT_HSH_DATW7                     010010 00101 rt:5 0000 0010 0100 0111 &cp2
> +    CVM_MT_HSH_DATW8                     010010 00101 rt:5 0000 0010 0100 1000 &cp2
> +    CVM_MT_HSH_DATW9                     010010 00101 rt:5 0000 0010 0100 1001 &cp2
> +    CVM_MT_HSH_DATW10                    010010 00101 rt:5 0000 0010 0100 1010 &cp2
> +    CVM_MT_HSH_DATW11                    010010 00101 rt:5 0000 0010 0100 1011 &cp2
> +    CVM_MT_HSH_DATW12                    010010 00101 rt:5 0000 0010 0100 1100 &cp2
> +    CVM_MT_HSH_DATW13                    010010 00101 rt:5 0000 0010 0100 1101 &cp2
> +    CVM_MT_HSH_DATW14                    010010 00101 rt:5 0000 0010 0100 1110 &cp2
> +    CVM_MT_HSH_DATW15                    010010 00101 rt:5 0000 0010 0100 1111 &cp2
> +    CVM_MT_HSH_IVW0                      010010 00101 rt:5 0000 0010 0101 0000 &cp2
> +    CVM_MT_HSH_IVW1                      010010 00101 rt:5 0000 0010 0101 0001 &cp2
> +    CVM_MT_HSH_IVW2                      010010 00101 rt:5 0000 0010 0101 0010 &cp2
> +    CVM_MT_HSH_IVW3                      010010 00101 rt:5 0000 0010 0101 0011 &cp2
> +    CVM_MT_HSH_IVW4                      010010 00101 rt:5 0000 0010 0101 0100 &cp2
> +    CVM_MT_HSH_IVW5                      010010 00101 rt:5 0000 0010 0101 0101 &cp2
> +    CVM_MT_HSH_IVW6                      010010 00101 rt:5 0000 0010 0101 0110 &cp2
> +    CVM_MT_HSH_IVW7                      010010 00101 rt:5 0000 0010 0101 0111 &cp2
>       CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
>       CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
>       CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
>       CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
> +    CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
>       CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
> +    CVM_MT_SHA3_XORDAT0                  010010 00101 rt:5 0000 0010 1100 0000 &cp2
> +    CVM_MT_SHA3_XORDAT1                  010010 00101 rt:5 0000 0010 1100 0001 &cp2
> +    CVM_MT_SHA3_XORDAT2                  010010 00101 rt:5 0000 0010 1100 0010 &cp2
> +    CVM_MT_SHA3_XORDAT3                  010010 00101 rt:5 0000 0010 1100 0011 &cp2
> +    CVM_MT_SHA3_XORDAT4                  010010 00101 rt:5 0000 0010 1100 0100 &cp2
> +    CVM_MT_SHA3_XORDAT5                  010010 00101 rt:5 0000 0010 1100 0101 &cp2
> +    CVM_MT_SHA3_XORDAT6                  010010 00101 rt:5 0000 0010 1100 0110 &cp2
> +    CVM_MT_SHA3_XORDAT7                  010010 00101 rt:5 0000 0010 1100 0111 &cp2
> +    CVM_MT_SHA3_XORDAT8                  010010 00101 rt:5 0000 0010 1100 1000 &cp2
> +    CVM_MT_SHA3_XORDAT9                  010010 00101 rt:5 0000 0010 1100 1001 &cp2
> +    CVM_MT_SHA3_XORDAT10                 010010 00101 rt:5 0000 0010 1100 1010 &cp2
> +    CVM_MT_SHA3_XORDAT11                 010010 00101 rt:5 0000 0010 1100 1011 &cp2
> +    CVM_MT_SHA3_XORDAT12                 010010 00101 rt:5 0000 0010 1100 1100 &cp2
> +    CVM_MT_SHA3_XORDAT13                 010010 00101 rt:5 0000 0010 1100 1101 &cp2
> +    CVM_MT_SHA3_XORDAT14                 010010 00101 rt:5 0000 0010 1100 1110 &cp2
> +    CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
> +    CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
> +    CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
>       CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
>       CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
>       CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
>       CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
>       CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
> +    CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
> +    CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
> +    CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
> +    CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
>       CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
>       CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
>       CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
> +    CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
>       CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
>     ]
>     CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index ce4cfcb3f3..c8c797e57f 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -212,10 +212,35 @@ CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
>   CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
>   
>   CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
> +CP2_MF_HELPER(CVM_MF_SHA3_DAT24, sha3_dat24);

This is trivial data movement.  Should use CP2_MF_I64.

> @@ -272,6 +299,56 @@ CP2_MT_HELPER(CVM_MT_CRC_DWORD_REFLECT, crc_write_dword_reflect);
>   CP2_MT_HELPER(CVM_MT_CRC_VAR_REFLECT, crc_write_var_reflect);
>   CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
>   CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
> +CP2_MT_HELPER(CVM_MT_SHA3_DAT24, sha3_dat24);
> +CP2_MT_HELPER(CVM_MT_SHA3_DAT15, sha3_dat15);

Similarly.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

