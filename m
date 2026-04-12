Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BC2E937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 18:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBzgb-0002wE-4o; Sun, 12 Apr 2026 14:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzga-0002w3-FF
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:37:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzgY-0003ZR-MK
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:37:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so2680710f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776019048; x=1776623848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=56SQG11dMJm3A9G48HJNr7gP0HZ0Dd3SGoiYkyCWZlY=;
 b=J1DL45JcMfDybL3/v60Jtkp8cJWYsUMeuyJb6D2rD9A0omMJKyw5tQNNdjs5fVLJPX
 N1SMS5bETPlxgI6q3m5E9fh36HBDmtMMiqYepslL8tzwpefBXanQFMcHc0q7ZroqEtU4
 xd5zknlvTe2QlK1YCAY5rpe9NY35yX9lGo8OQufvEj2LXIzX6Wh2zbS1XDcSIOXBrGFB
 jiajld2h3eZBYbU14vB8c9oq7dxDpRZokL+1fmroFkl4lVIabFE3b5HXzCPD5o1eT9c0
 Rz+hZ78Nxov8q41JkM5e53EckYRHHyy1Fj5zqeojz4gFvz9fi3WeIxoDQhr9iNCL8Nzb
 lXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776019048; x=1776623848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=56SQG11dMJm3A9G48HJNr7gP0HZ0Dd3SGoiYkyCWZlY=;
 b=PqwMV7mee7NDQN+BC7KXXXvCLmzSPExR/RUrbOADXTZthTMYYMG9QELbrtdqPMv5KF
 SD6BBaTi7sjFw8igY1/49WAYvRnU4QYapDAO8bruDtkNChbKmPA7lXpm437H7P7Td9zX
 pCaA45JT8mWeVEiETlHGNcW5gwRjTNn6C7Tt5DdmnwlzFgYyOGqFT89fxDdhMFZMcOov
 0WcvNhLmMuYrhS4sZ5ONkB+UNrJk+jnGbMmpibwGFnZW1qLjbG4+y5fjOPlSYmC6D5h8
 j7fklPvDSBxJmol9SNU3VM0BckOwQSD1Gvam0m0P3Cbx7IfEIXelYaqBrBjx6pvoSmsw
 wXWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pcKz6aldZrHkNARh52N91U9Aggg3uu0roPxQr9JBKutobvdM3/A43w4n+TgdRnm3onqZ48o5BMmTV@nongnu.org
X-Gm-Message-State: AOJu0Yzm6Gdr2gdBd5dyp4Sp4/9ADHkszOAQ8Yjfl4lZ2xV+sq/ynMOb
 NklyZkmDy2VU57VX0i4t339P/HjOmNe8MbDfY5J7mCAFSeQvq68SuBmEoshgoIkhPgY=
X-Gm-Gg: AeBDiety4PqJvIMx5T53HLtUM9ZuGTGGhS/y3Fev20e4apTx5W8AdFUEThST9l1uWCh
 h7YiylYt4QJWG3CRwgF6MBy9jAuX4g1WIitoQ3ZukyY2d2f5PZMmPLMqfjj4XBlZCLeCK9FcQnh
 gkGFzNjf4cuqpZ+yy4peodNNhRgPZYa1RklFlRUJVxGneS0+7/GefxRogi92amgCRnukSCiPESG
 982hkjo15N9Hw7umSqMLBVu27+qn/izGUibxFgGqeXiNZeRoahuPy8pezhYpgEOtJwxCDiD3VZ+
 2Kc+b5YImRteqBiqaEfIbDE2onwN/c+AWnMvRNKdTRNoT2uKvE1ftTgfeBoyqxonl4xdM4p0qX+
 eMkbTHXk4ynVJdXo9J1xNApb4RHhbtBaBYn2rhPo4sA5RYT5flsS4zigJ/l9FoFXCAhDzyYtvk8
 QulUCGknrufzni8lte+vMOBKPrr961QkEFe+Vv8nfPN1hgSGWDPr6EEX66VLBFwJp+ug==
X-Received: by 2002:a05:6000:1847:b0:43b:45d1:f449 with SMTP id
 ffacd0b85a97d-43d642f18c7mr15907450f8f.51.1776019047634; 
 Sun, 12 Apr 2026 11:37:27 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5ccdasm28116444f8f.34.2026.04.12.11.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 11:37:27 -0700 (PDT)
Message-ID: <8cac2df2-7718-412a-8a58-2f49eac78dba@linaro.org>
Date: Sun, 12 Apr 2026 20:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/mips: add Octeon ZUC crypto support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-7-james.hilliard1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260411070637.72421-7-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
> Add the Octeon ZUC START and MORE selectors and model the shared state
> window used by the hardware interface.
> 
> This covers the keystream and MAC engine state, including the
> save-and-restore view that overlaps the HSH/SHA3 bank.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.h               |   7 +
>   target/mips/tcg/octeon_crypto.c | 323 ++++++++++++++++++++++++++++++++
>   target/mips/tcg/translate.c     |   2 +
>   3 files changed, 332 insertions(+)


> @@ -1487,6 +1732,38 @@ target_ulong helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
>       MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
>       int sha3_pos;
>   
> +    if (crypto->shared_mode == OCTEON_SHARED_MODE_ZUC) {
> +        if (sel >= OCTEON_COP2_SEL_HSH_DATW0 &&
> +            sel <= OCTEON_COP2_SEL_HSH_DATW7) {
> +            unsigned int idx = sel - OCTEON_COP2_SEL_HSH_DATW0;
> +
> +            return octeon_zuc_pack_pair(crypto->zuc_lfsr[idx * 2],
> +                                        crypto->zuc_lfsr[idx * 2 + 1]);
> +        }
> +        switch (sel) {
> +        case OCTEON_COP2_SEL_HSH_DATW8:
> +            return octeon_zuc_pack_pair(crypto->zuc_fsm[0], crypto->zuc_fsm[1]);
> +        case OCTEON_COP2_SEL_HSH_DATW9:
> +        case OCTEON_COP2_SEL_HSH_IVW0:
> +            return octeon_zuc_pack_pair(crypto->zuc_window[0],
> +                                        crypto->zuc_window[1]);
> +        case OCTEON_COP2_SEL_HSH_DATW10:
> +            return crypto->zuc_window[2];
> +        case OCTEON_COP2_SEL_HSH_DATW11:
> +        case OCTEON_COP2_SEL_HSH_IVW3:
> +            return crypto->zuc_tresult;
> +        case OCTEON_COP2_SEL_SHA3_DAT15_READ:
> +        case OCTEON_COP2_SEL_SHA3_DAT24:
> +            return 0;
> +        case OCTEON_COP2_SEL_HSH_IVW1:
> +            return crypto->zuc_fsm[0];
> +        case OCTEON_COP2_SEL_HSH_IVW2:
> +            return crypto->zuc_fsm[1];
> +        default:
> +            break;

                g_assert_not_reached();

> +        }
> +    }
> +
>       if (crypto->shared_mode == OCTEON_SHARED_MODE_SNOW3G) {
>           if (sel >= OCTEON_COP2_SEL_SNOW3G_LFSR0 &&
>               sel <= OCTEON_COP2_SEL_SNOW3G_LFSR7) {
> @@ -1606,6 +1883,46 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
>       uint64_t q = (uint64_t)value;
>       int sha3_pos;
>   
> +    if (crypto->shared_mode == OCTEON_SHARED_MODE_ZUC) {
> +        if (sel >= OCTEON_COP2_SEL_HSH_DATW0 &&
> +            sel <= OCTEON_COP2_SEL_HSH_DATW7) {
> +            unsigned int idx = sel - OCTEON_COP2_SEL_HSH_DATW0;
> +
> +            crypto->zuc_lfsr[idx * 2] = (q >> 32) & 0x7fffffffU;
> +            crypto->zuc_lfsr[idx * 2 + 1] = q & 0x7fffffffU;
> +            return;
> +        }
> +        switch (sel) {
> +        case OCTEON_COP2_SEL_HSH_DATW8:
> +            crypto->zuc_fsm[0] = q >> 32;
> +            crypto->zuc_fsm[1] = q;
> +            return;
> +        case OCTEON_COP2_SEL_HSH_DATW9:
> +        case OCTEON_COP2_SEL_HSH_IVW0:
> +            crypto->zuc_window[0] = q >> 32;
> +            crypto->zuc_window[1] = q;
> +            return;
> +        case OCTEON_COP2_SEL_HSH_DATW10:
> +            crypto->zuc_window[2] = q;
> +            return;
> +        case OCTEON_COP2_SEL_HSH_DATW11:
> +        case OCTEON_COP2_SEL_HSH_IVW3:
> +            crypto->zuc_tresult = q;
> +            return;
> +        case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
> +        case OCTEON_COP2_SEL_SHA3_DAT24:
> +            return;
> +        case OCTEON_COP2_SEL_HSH_IVW1:
> +            crypto->zuc_fsm[0] = q;
> +            return;
> +        case OCTEON_COP2_SEL_HSH_IVW2:
> +            crypto->zuc_fsm[1] = q;
> +            return;
> +        default:
> +            break;

                g_assert_not_reached();

Otherwise patch LGTM.

> +        }
> +    }

