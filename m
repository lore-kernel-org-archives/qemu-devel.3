Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19234CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 01:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPVuI-0006AG-Kq; Tue, 19 May 2026 21:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPVuH-00069w-4A
 for qemu-devel@nongnu.org; Tue, 19 May 2026 21:39:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPVuF-0006r1-D2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 21:39:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso28526925ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779241169; x=1779845969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNZybDa1C8D++o96VxOScMnNmZGPmYVntABV6bYZEas=;
 b=uJS9GnZfvMSOLC5Z9RqlnLe2WQHsc7QXLE3O1aKajuiVLPZCRz/QS0U/P4vgUhsHyu
 Fav9C+AncWt5r3Kd6ELFP2GXTxhd1NWNf7d3SN3wxzT/7RqkWu0iUs99CESoT2p0Kos6
 DfB//1ZAcel+l3rMmecolKmB2IOYTmTKvPgqyvoHjwVTGucc3pdT4ZoeafeEkcMrwHoJ
 Vb2oJBebAshB94DQgMCXqjoNnoCOWq8wBiqOmZemSBVheuo2ddSjA0BAio+7Af4gQMG8
 4LfT0/KyWWYmojgjaGxrfvZNn+9HM6iLT13Raet8E6MZWr/SwGWsOv5mHkSyK3RRtjaY
 AsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779241169; x=1779845969;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNZybDa1C8D++o96VxOScMnNmZGPmYVntABV6bYZEas=;
 b=EOPTYSt7yl6HuuV+L89SXWwXpCVdhWOqgHEjkuwEJtaC5stSIYBdNBBu1QqIR3COLT
 db0u2I96u/2K2pa4ULrmgoP+xTQ3aLKBRjqva1NPpFon17I7J+L1rh7zd1BKgMuoPgwp
 i6zBEm/dNb9k33NDhThwF0Rr6G0LNNQT+axTskhdoOXftnAEE4cPCwPst8v3cjA4xUr+
 fRVrkSKce6DF0QbrUOygOmq/P29N/GaMHx03CK5jiw6RZ/6QgWfDKNPS9vhpBuvb/I2Y
 LtGYr73iL77FgOZiLH2WoZ358fsdX+NA4FKHzmcbE2ShqhuDjWsTAt04S9ITu72IeSe9
 QASg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ha6sRHeL2y6Mb9fb5UCZwdHfDJl50fbIaMQOUKtEZDHI3YBEf87ojIsy1N5eZaJBh6Yv/Waqd8+rD@nongnu.org
X-Gm-Message-State: AOJu0YzA3sPXB2R8xdYBdc1NY+QjyYv7T+NM5+aAgRUFKTpsSU4HK8GQ
 x6r8ImGGZAfvzGf/aRdTPmSd2aahxko4sOBzfVf6hZVuFHuFL7TT7KbOrzPmE3HR1X0=
X-Gm-Gg: Acq92OHLdlo6StpSPezXk8AhMOVCcSJRVASQBP0tPa3EnXpJ1lAJuLu0t3Nvnt5kAqe
 pr7lMXZK8j1XHfrd0ehvBFt81IX/SziTBmcAm7VSsr7tBFT6+LzHTZJTgzThCmwtDybI4H1WGK7
 9uWRDKOL0bj7vjn7+t3/srZ0EC14SULfD4ZeSFzs8ZiYyN2Tu+xqlxncsqFOKJ74x1XvW5M1igs
 jSogEgYj5W2Fzi9KrPL5acUDK5K15oXjOYspnKD3/Zo6nmAGMXfbzU8lURJnwFQlHK7NQLAxavK
 hJDL7vaQ3JjLOVLghYUXovZd3eFJzd7/ZpUOiGgNzMw7/v8vDT4ThQmCSBnOheQFlM1C14GZkqB
 cpSVpbX2hc/IwnhUHOAF/gJY8zAlIMDHjT2oEIwd/reqqBqZ9Vpi+YVw9h5/sabJ085/DkZ4NnN
 omjfE3TH2PKcxvy89e/AGK83WBZ0g0e0DgWhVS
X-Received: by 2002:a17:903:1b4e:b0:2b0:c59f:3b58 with SMTP id
 d9443c01a7336-2bd7e7b58a8mr237056575ad.9.1779241169381; 
 Tue, 19 May 2026 18:39:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm191989145ad.32.2026.05.19.18.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 18:39:28 -0700 (PDT)
Message-ID: <dba6c897-af66-45aa-a2d2-efe7aa26683d@linaro.org>
Date: Tue, 19 May 2026 18:39:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 31/40] target/mips: add Octeon AES COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-31-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-31-d7dd735ecddd@gmail.com>
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

On 5/19/26 09:22, James Hilliard wrote:
> Add helper support for the Octeon AES operation selectors. The direct
> register-transfer selectors are handled later by the explicit decode
> patch; this patch adds the ECB/CBC encrypt and decrypt operations that
> consume the AES input, key, IV, and key-length state.
> 
> The AESRESINP direct write path keeps a separate input latch and readback
> view. Later translator comments document that split where the direct TCG
> stores are emitted.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v8 -> v9:
>    - Split AES operation selectors into their own COP2 helper patch.
>    - Replace generic selector dispatch with per-operation AES helpers.
>    - Add matching helper.h declarations with the helper implementation.
> ---
>   target/mips/cpu.h               |   5 ++
>   target/mips/helper.h            |   4 ++
>   target/mips/tcg/octeon_crypto.c | 141 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 150 insertions(+)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index b57a7a0584..801893b67f 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -556,6 +556,11 @@ typedef struct MIPSOcteonCryptoState {
>       uint64_t sha3_state[25];
>       uint64_t aes_iv[2];
>       uint64_t aes_key[4];
> +    /*
> +     * AESRESINP is one architectural selector bank.  Keep a separate input
> +     * latch so operation selectors can consume a pending block while DMFC2
> +     * reads expose the latest result/readback value.
> +     */
>       uint64_t aes_result[2];
>       uint64_t aes_input[2];

Specific example?  Because this seems wrong to me.

> @@ -763,6 +763,116 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
>       octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SNOW3G);
>       octeon_snow3g_queue_result(crypto);
>   }
> +static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)

Missing newline, multiple instances.

Otherwise the actual operations look fine.


r~

