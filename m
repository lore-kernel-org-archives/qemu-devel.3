Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8B5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PCY-0003DH-Lt; Thu, 02 Oct 2025 15:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PCV-0003Cy-2i
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:42:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PCQ-0001y4-Rq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:42:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-27d69771e3eso9166005ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759434161; x=1760038961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NccY5uJlB2zBjIkOfiAF7xJm5TGvFkaSbdTd2GJvoJY=;
 b=ea26AjZjFqn6AANQ6N5f18fhwcYds3/P9GZQjNO2OCjQOSwH24Hz+s6G0O5vDHm3yX
 I2SiHtLLJbbQz9EaC/tHPPgEkoSOO0FWv9wXH0GQdvbJQxHZ06Jkn/JABoH+tbI6TVFh
 T5Dd4x4/C7zJQUm3TQqW5rKrcPPQYpEcNZ+FfNZmUn8RLUmMGLBM3Es0w6jaXo42Ukpx
 Dz866TaaVGB47+51NvZYd1bT3buBB/u1UejGeTi0z1OIFt4xkgRWSfcbRMxIHyDrWO0Q
 GtAvU8IAcRbvsOlt6G0dDBi7IzCq4CLVzQbbIEZ0MYDGK/wUkoQO8U/p4z/YHYhM3re7
 xIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759434161; x=1760038961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NccY5uJlB2zBjIkOfiAF7xJm5TGvFkaSbdTd2GJvoJY=;
 b=veOPbitPq5FQuFGsFHFOwNQ9DDWe+5mU5hN3YIfcEeQFXNvqu3yILazDQCCx+iK41G
 HBDbWZLQLQkNgbYF/IbGK8mrOegOUxlzdehsjj+vpHN2dTNKK0KLUbb3YbR8Yqe5FB9w
 B+z5edyZ2ei1DaigDsCMaw25sOc9UCx1r/CDWS/zCRPDGDfochLXMrt9EBWedpLY0zfu
 uwi3tD3d+zXeOE5M0cZX8dtq9vcWgPrv6Ud5Tz3Yve71nTqpi7htWU/lBmUSpCzipOPp
 1XwsOUf78dbSFaWp96GCsVdQyfkjauVlgqDxhlyV7KxG5q//ebQ7TtAZO0JGPGrOxgWo
 O0Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXoX1eptxr9hKQ4nMYQbGl5E55zub/ZkcR49tdFIarUVgi7EWGaCnGXJiAOIsxkW9rr4OE2UK9l4oj@nongnu.org
X-Gm-Message-State: AOJu0YxtiFN/x/JhOMI3Oq5ENzoi/oxyDOsX7xxfIa3zWrYb0EwRLirA
 4rmn0wtr5ddS6FGufEzKEXL08Lcs3XmpTzSpJ0FqBd3mmF/Tzklo7PmvygTnjGHeHfg=
X-Gm-Gg: ASbGnctYrGL9HLROxorY8HH7EGLVObuzJw+Q1fWsw+WbFzqAeRep/wbD7AzX/CTGbvC
 0Z7fgS0gnF2B4s4GZORzJ0hE+JTQZwPSUJG3/WPMPzW4gonFtKtevit9gbiw+t9snrrvT63nPNq
 MxctvzVIOgZxl5KtvI1VgdZcQrSEDt8a8mHmMgkqm6FCKiQePpt3LViu+H2jgkub34DQzUNDwo5
 k+mFKWnRE+1UiYLwHaIyBEXfkodk9Th+pEpLKCLlue/geVb5h4kp8Da5lheCDdha37BCbEx7D3n
 WO6grEBPFvq7NWYNgNayjiuPdZvqvehoXavssN0pwR+QTQoZOF8lN+L+38j6xPz4v568WtF5mwj
 qJeIYEinJHOA1ucGRPIZZD4thZpEr9WyTWKKSAF59ymIkGkmCm64lKgd/5rUjU4I=
X-Google-Smtp-Source: AGHT+IGJm+W2917XQT+pS8fVnCPDVHRJcVynBls7tg1kI8FAs/fLrcSxkKiDXBKGZpRgulX7J9VvIw==
X-Received: by 2002:a17:903:24e:b0:25b:f1f3:815f with SMTP id
 d9443c01a7336-28e9a664fe1mr4739235ad.58.1759434160840; 
 Thu, 02 Oct 2025 12:42:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110995sm28761925ad.3.2025.10.02.12.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:42:40 -0700 (PDT)
Message-ID: <49ca3285-1403-475e-a757-4e600ffeae18@linaro.org>
Date: Thu, 2 Oct 2025 12:42:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/33] target/riscv: Fix size of vector CSRs
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-11-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-11-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> According to version 20250508 of the unprivileged specification:
> - vtype: bits 0..7 used, bit XLEN-1 illegal, rest reserved
>    => fix to 64-bits.
> 
> - vxsat: bit 0 used, vxrm which would occupy bits 1..2 is stored
>    separately, and bits 3..31 are set to 0
>    => fix to 8-bits.
> 
> - vxrm: 2 lowest bits are used for rounding mode, rest set to 0
>    => fix to 8-bits.
> 
> - vstart: maximum value of VLMAX-1, where VLMAX is at most 2^16
>    => fix to 32-bits as vstart is mapped to a TCG global.
> 
> - vl: maximum value of VLEN which is at most 2^16
>    => fix to 32-bits as vl is mapped to a TCG global.
> 
> Fields are shuffled for reduced padding.
> 
> Note, the cpu/vector VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h                      | 12 ++++++------
>   target/riscv/machine.c                  | 14 +++++++-------
>   target/riscv/translate.c                | 12 ++++++++----
>   target/riscv/vector_helper.c            | 22 ++++++++++++++++++----
>   target/riscv/insn_trans/trans_rvv.c.inc | 22 +++++++++++-----------
>   5 files changed, 50 insertions(+), 32 deletions(-)
> 

...

>   typedef struct PMUCTRState {
>       /* Current value of a counter */
> @@ -217,11 +217,11 @@ struct CPUArchState {
>   
>       /* vector coprocessor state. */
>       uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
> -    target_ulong vxrm;
> -    target_ulong vxsat;
> -    target_ulong vl;
> -    target_ulong vstart;
> -    target_ulong vtype;
> +    uint64_t vtype;
> +    uint32_t vl;
> +    uint32_t vstart;
> +    uint8_t vxrm;
> +    uint8_t vxsat;
>       bool vill;
>   
>       target_ulong pc;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 6bc79cceaf..dcf18624bf 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -136,16 +136,16 @@ static bool vector_needed(void *opaque)
>   
>   static const VMStateDescription vmstate_vector = {
>       .name = "cpu/vector",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .needed = vector_needed,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
> -        VMSTATE_UINTTL(env.vxrm, RISCVCPU),
> -        VMSTATE_UINTTL(env.vxsat, RISCVCPU),
> -        VMSTATE_UINTTL(env.vl, RISCVCPU),
> -        VMSTATE_UINTTL(env.vstart, RISCVCPU),
> -        VMSTATE_UINTTL(env.vtype, RISCVCPU),
> +        VMSTATE_UINT8(env.vxrm, RISCVCPU),
> +        VMSTATE_UINT8(env.vxsat, RISCVCPU),
> +        VMSTATE_UINT32(env.vl, RISCVCPU),
> +        VMSTATE_UINT32(env.vstart, RISCVCPU),
> +        VMSTATE_UINT64(env.vtype, RISCVCPU),


Just a nit, but might be more maintainable to keep in sync with fields
declaration order, given you changed that to optimize struct Cpu size.

>           VMSTATE_BOOL(env.vill, RISCVCPU),
>           VMSTATE_END_OF_LIST()
>       }

...

The rest is pretty straightforward,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

