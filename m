Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1309BC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYsJ-0003ZA-Vb; Sun, 04 Jan 2026 19:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYsI-0003Ys-39
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:55:10 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYsG-0002RB-Lr
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:55:09 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c868b197eso15111753a91.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767574507; x=1768179307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=COgsXRX7UW9skbW3k1XZZ3ocPGFgy1r9MAO8szv7rxc=;
 b=hiv1YfTOgCW5pishmFA/gT3Yjh/crFfaR4V3x/4AUAPG0rdGT+TQIueCAX4y35uC84
 D8/ptM2+mibgNqR3M/ZPVyxri5ftxUwnRXOS2PEuSzs0N2y/QXQ8kraY2IneEF97lCoW
 1LuGZHPVpQVYA/xcgT8RSjzEZjEfbmfaYbiVE9LDOsv3cr4gMONW5x8eLo58HQu19Y72
 IdXxSINjDsX+ngDZ8GGTv4Il47Ct7QOKqQXQRVkvJKJMK9fV4zt1fOITA3ArAXVhSmFK
 StJw/Sm2FmPOhzyfrmB98oDsYqyJ3RLTyHVbS3xO+gmLvuzoEUtVf/e6fdeqjipUbnnn
 J8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767574507; x=1768179307;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COgsXRX7UW9skbW3k1XZZ3ocPGFgy1r9MAO8szv7rxc=;
 b=rbXg1IB0VLAxKer8Sujg77XG+GX1T+47iAM22HJ0sxWpA9dC9VG/wOiDAkeQktJdTX
 60vB2994uHoSxKZzJfxSyR83/B4c9y20nxfWVI1aeTsANy7KtSgqBzrrEEJOIeyEBnfI
 dxSRSXHdiYlzSupraxQMH4uolomy1KBwXOMH6Sc3mAfCZI3Z4OGwqG/LeMQJcg5Q4XXa
 vKGtSrosRu4D2srmQt3GsHUyCJG5QShVyJmxtKCyriwJd8I6oW3cWqltU1yxmvk30dDP
 0tNZw78WJ6R6qIG12thQx5FuzElzxx0q+7i3kZPEtrmGyX6n2icKRyTt546T3Y2zqV6g
 zwcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW162nCVIQC6aaa5R4buSON8BcPYRKcDup9fcbJA/IByZ/Wgd01+byrGp+JvcUIk2DSuyrq3OkNLAUL@nongnu.org
X-Gm-Message-State: AOJu0Yx6oWtKOKjQI5nWxOdgIokdztBmbgBgTkD9LhVNXlYGEE8EAfQE
 10a2bRonHWRZ/aTaRvgKvq98H5ol6Ju3bFpreg02q0X5hg6UGhHOyS0KYBsMzpsDA2Q=
X-Gm-Gg: AY/fxX4Cgo7jlN5xx9ZFvOXFKGTj+/kloQn+K+N+WalxvMjeiLWw3u/KTLI0tIuYDA2
 n++Z6rUSXScmczua4JL36tt33miSJ6VyIwPqhoHW6wetDdqGvKUZXz9NEYkKbQzU6kVBeqWBmmr
 PJQHJfDYT8Vzlbe+/bDqAMkc1QQt59dUE/MGfLGx3fdeeDKb2r4wb3NaJPYX78OGocQNhUePqYq
 PVgahaLjtqzKrkHwSodtVivMMMztMzV2IRwl8VLdlm2DicABdw7fRb8BE2Uhwpw8lwkTeXnyU0f
 BBsc68F6GNDcd9VzdNroTp/iUtXn13vkyCQZ1NYUCPdSK7szV9QYyHTGpnoYUWO00m8kJzSniKP
 72IKn9EKaqhY98tvVCgo2C0gZ/Sf6u2ulAKgo/OJmmt1O2dY1Xix1Jyygg3aZifxHqx7PtuGVQt
 EwRo+b3Awg+fTUzPldYLMFy80tmCDvshsV8fvqMeQA
X-Google-Smtp-Source: AGHT+IGDIr69RktZs7WsBUtSY98SuEzCiRbmwO6IolbqobTBAubV+Ypv3wx4Tex8aGmqrI5U1cGvAQ==
X-Received: by 2002:a05:6a20:748e:b0:359:d00b:45f4 with SMTP id
 adf61e73a8af0-376a9ae284dmr41387767637.52.1767574507130; 
 Sun, 04 Jan 2026 16:55:07 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c65d71sm440826955ad.17.2026.01.04.16.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:55:06 -0800 (PST)
Message-ID: <b9163a87-0e06-4a6b-931c-1fb76e041775@linaro.org>
Date: Mon, 5 Jan 2026 11:55:00 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs/targets: Forbid TriCore to use legacy native
 endianness API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251224163005.91137-1-philmd@linaro.org>
 <20251224163005.91137-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224163005.91137-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 12/25/25 03:30, Philippe Mathieu-Daudé wrote:
> The qemu-system-tricore binary is buildable without a single
> use of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Preliminary commits allowing this final change:
> 
>   . cd08bcaa36b target/tricore: Expand TCGv type for 32-bit target
>   . 8a2235dd077 target/tricore: Un-inline various helpers
>   . e843ef2bbac target/tricore: Pass DisasContext as first argument
>   . 4f08815467e target/tricore: Expand TCG helpers for 32-bit target
>   . f30c8aa229d target/tricore: Inline tcg_gen_ld32u_tl()
>   . 6b2e4fcb836 target/tricore: Declare registers as TCGv_i32
>   . c558aa94211 target/tricore: Replace target_ulong -> uint32_t in op_helper.c
>   . 30257dcd2b0 target/tricore: Remove unnecessary cast to target_ulong
>   . 44e2b68d275 target/tricore: Remove target_ulong use in gen_addi_d()
>   . a15e8996268 target/tricore: Remove target_ulong use in translate_insn() handler
>   . 0d5f9542561 target/tricore: Replace target_ulong -> vaddr with tlb_fill() callees
>   . 809b460f305 target/tricore: Remove target_ulong use in gen_goto_tb()
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/tricore-softmmu.mak | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

