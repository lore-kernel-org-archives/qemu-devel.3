Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419D4C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYCI-0001Wp-OC; Sun, 04 Jan 2026 19:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYCH-0001WZ-FD
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:11:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYCF-0006jY-T4
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:11:45 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so117923565ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571902; x=1768176702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uTH7qovrh7zc+TX3YT/kYbEiU5Omn1B/h5FHRMn7KMg=;
 b=K5nX6M4BwLpyQM7RGiTbMC8hvWcd2cKudSWvb1u3DU0Tor50bL51ZN2nhKPTSqSCr4
 nY9Klsa6m1zA9RSZT5xwGUKwgxKItZCnTdTunik16xgmP8K9LaE3iTnjrr+viW4zK+1j
 r85oO4eGzmS/nWfit36EI2Tfm0XQgJq+Q/weVHSR4TtlOTTF1tpqULstC17um74LCG41
 S2rYWo5Ls3tEKxHXnmwImW8llIevuZP5Q0vMLSM5TxTryfnrGwfUuvQsiKxYRtAsHcuF
 +O+rVlJCmoUiFQ/alP+G/fEftkLxL9pOveBxvfOgfx1NtQsoV7ajZAa9/d+F8C9wFgmE
 ZfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571902; x=1768176702;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTH7qovrh7zc+TX3YT/kYbEiU5Omn1B/h5FHRMn7KMg=;
 b=qfXMMQ/L/nvQ7y1WfNPobnsw/tyJMr0FAwLIZoyGmvIvxbu3He+/9p89J5zuPHO0rv
 PQo4nn+7QLlk8IBM9TeocSo98r9y0dNukCkp1IBmMOG/HDM93GtSI5+0OOhAQA335zZA
 teRCVTgm14XacmM3hiMovORHHwSAUajvkJQT3dwA+1E5pQw4zj+qRecQoJ5DelOmXIf8
 owGQrSY5xDx8EkhTstkPGY3BP4fLLBHzLk4ZVCub3elqKlIIWGwL7N+fSmHqaWKhYNzP
 rlPcFjjbykq59z81PCIL6qxwfijjj4Oo8nxjlGGVtDDfGEPOGpqVzaSrcHXHvlesA9aK
 qqgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFak2uDz/UiQEcNzyR6AJndT1EJN27RD6w70r8Bnsw3h5fbkjeBw1lYfbWxHunTRvj+zbZng79X71P@nongnu.org
X-Gm-Message-State: AOJu0Yy5qwTHhpZ0VdrmwqMA+LXaIkNT1frfpI/uEZ4RyqigGHeZNyJc
 FWtmship+jWAnvyy0QpC/E7atJxUYYHRj0BmJE5SnNTfmhIlCUZ0ch/McnBy1eWI7vE=
X-Gm-Gg: AY/fxX4Phx30+scCH4XJZjddP37+ORakZ5Utj+KvRx26uE4krjcdJ1pk1nt0WCgg9tu
 e4LM+kv/zfvL5DIN67ui22tV9RKr9cpxqSRfUncnB/JIczl63SOTm+d023ayCWEtudb0MGQzjf2
 N2q12DDYU+VxxOnWTAj6jlad7rE3N/YzpRIHCjdtwuVBK57rUc8TFRpwoh6iQPi0vlYVlSJoUDe
 8UDL9v1OyMTFVWW27kcvmce7y4dQuOBsTGAu5D0dj6GWM3mfnYhir2kZK+cZc+l+BNGGmICoMcP
 lzpItoQrWG6HSVDnIUNBgHKDMZch+revxJ2waIG2Kaf2/cDy9vCxOaMGPzyTMOqR0f9mfOHUFPo
 Rvs0QoHm7x3UGdyfzBuVcUvpHThj9WmMT0K3E1uQxHW/Hef8i20d3T7hi5xD+ec3gGjqjEXNDQ9
 PefQU2nC3yi9DtE3J/egTmrE793/Yr4Q==
X-Google-Smtp-Source: AGHT+IGnIZO7gMyajHiHwj2DgugRYEZr6fIlLfdHSdxPrEICLOBURGU1P/8mRelr3UMkkywtvLvC9w==
X-Received: by 2002:a17:902:f68b:b0:29f:2ec4:83e5 with SMTP id
 d9443c01a7336-2a2f2205201mr438398355ad.12.1767571902370; 
 Sun, 04 Jan 2026 16:11:42 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d6e4sm433197655ad.75.2026.01.04.16.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:11:42 -0800 (PST)
Message-ID: <80148851-26ed-4015-82ad-dc45728b37c5@linaro.org>
Date: Mon, 5 Jan 2026 11:11:34 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs/targets: Forbid OpenRISC to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224161804.90064-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/25/25 03:18, Philippe Mathieu-Daudé wrote:
> All OpenRISC-related binaries are buildable without a single
> use of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Preliminary commits allowing this final change:
> 
>   . 5b67dbf1dc3 target/openrisc: Replace target_ulong -> uint32_t
>   . 500708331e3 target/openrisc: Inline tcg_gen_trunc_i64_tl()
>   . 4f6c60683f2 target/openrisc: Replace MO_TE -> MO_BE
>   . 73cd283e58d target/openrisc: Introduce mo_endian() helper
>   . 2f737e19a4d target/openrisc: Conceal MO_TE within do_store()
>   . 22c36c0a20c target/openrisc: Conceal MO_TE within do_load()
>   . ef797ac0025 target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
>   . 81e2fb236b7 target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
>   . 9dc4862dc4a target/openrisc: Use vaddr type for $pc jumps
>   . 2367c94cbb1 target/openrisc: Remove target_ulong use in raise_mmu_exception()
>   . 1843e89bec5 target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
>   . a3c4facd395 target/openrisc: Do not use target_ulong for @mr in MTSPR helper
>   . 2795bc52af4 target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/or1k-linux-user.mak | 1 +
>   configs/targets/or1k-softmmu.mak    | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

