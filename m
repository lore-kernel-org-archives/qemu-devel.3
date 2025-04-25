Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CFC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RQP-00013H-FW; Fri, 25 Apr 2025 18:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8RPu-0000oD-EL
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:21:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8RPp-00046o-La
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:21:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2269205b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745619659; x=1746224459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REmHL3IBfeUVuBzDz1JQ0TroHp/u8nZ9vTFox/13qN8=;
 b=Rla5Gs1HLTUNgtJ/SahZ2MclK5PXo7OVmwbFhWMf/mxgnEwJiPGOeBvZ608LzAWQpi
 lrpRjjyMEsaDnnhhSaSuZbR9AbaYHAy7ukCe9KMIsDKCQ1PJKemHTyjTBPDAFFWKCABe
 Udza/e7tIJoRuwrLAIWBl2rDK0cDIVIYtAhJeAbIPq1vpx0Mw1lx7IexDxDZWLfkR5YE
 21CuPLi2DxXr8OmHSRUCtGcc6m2TJe1g8j1ByibFeZm7JFDKzNhV50VLtphQoZkPwt+q
 zGO/g8vBdeBzUk7fZeflkKk5GMuYB0ADbBoWtBniNHg18wy1MSclzlosZKQF0hJCRtM9
 S9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745619659; x=1746224459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REmHL3IBfeUVuBzDz1JQ0TroHp/u8nZ9vTFox/13qN8=;
 b=g4dbHI3iI+KLNM0FmSaKoMz1VbuO/VsDWHIDdIAJ3XXJwpNumgJVDQwQyDHLwm8ftX
 fDFaEAi5ygKN6TtizwJ669obgOXtaUBJv1PFhtw9xiQ3PlWaQWiq73Tg53oka3hjZs89
 32Zzfxl0t3EaGIfo1GL3vEr8iMj97uRaNnzT8HOxpTYd2+cdV6Cfp5beBkbL+SoygI4W
 W+iU9hWk14GCOibfZd5CTcfQuWFk3XFW5wvHwXKdL1nfW+qm0mfnDS60AOlw7A8J3xKP
 i/BtjMgdXSl2rMCLOj1vuc4ur5Xfwf1CmlNQhnMRYzmPFwrqOWU7wrOu6avdWVzdQSk1
 Q4CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW56111dC7XUEDyrXaM89Y1KVRWmYpk8SnkMWUQIOwfp5iXZ+iJ8uYX056oBh4GhB/CMbdrA2GnCcKI@nongnu.org
X-Gm-Message-State: AOJu0Yy+hFVg3t8LIlgRpLzkftVhmPNPFl6LCxD2m+t34ZXyIDepR0fz
 B7EE16s+3w+31ZuIwyy7a0j8zQqolnePvh8qgbEsW9r3cc+5hu292SbodZuK10A=
X-Gm-Gg: ASbGncv4+VmHufTe2FwwdzalP6fm3ZyDiL67AhU4b50bunDv7WMYrANxXWxnqmwsGSz
 QfNvH7LqGTuZjm9zMNS38KfZpfI5gjQHNNWKESxq+vbSz87WCYnQirmXRTHwBFLxrsrrR8WSFa4
 xCpTgSsc8kilGAPOdouhwfl/iMfMlAOoY4uOFugGWHnbUZLf25TtRdRbI8Um7mqf9WyBhOmFSRw
 6YloArCndHKD2OHa4UVC3NTS9kJc+E9w/AianILOT4z55e3w6lvnh4CPP+BIsfCRjKvk0ashrGM
 67cLGYMVM8RcIOD3LX6+5MhA+SismLchpKT8R4qFUHPEwV1w4gpRUbk/jOFLwrpDkA==
X-Google-Smtp-Source: AGHT+IFalmBuARgmVTcgamMChbHLfD6UDUHtkpe/2PNzI30AnFJ6KIJ5+TNTw95YKhtrqxvQpSK5TQ==
X-Received: by 2002:a05:6a21:788f:b0:1f5:8f34:bf82 with SMTP id
 adf61e73a8af0-2045b9d8223mr6431065637.36.1745619659394; 
 Fri, 25 Apr 2025 15:20:59 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259135a9sm3703063b3a.26.2025.04.25.15.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:20:58 -0700 (PDT)
Message-ID: <1521e92e-699d-443b-8542-439854e6764a@ventanamicro.com>
Date: Fri, 25 Apr 2025 19:20:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH alternate 2/2] target/riscv: Fix write_misa vs aligned
 next_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20250425165055.807801-1-richard.henderson@linaro.org>
 <20250425165055.807801-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250425165055.807801-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 4/25/25 1:50 PM, Richard Henderson wrote:
> Do not examine a random host return address, but examine the
> guest pc via env->pc.
> 
> Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/csr.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c52c87faae..992ec8ebff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2111,10 +2111,13 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>       val &= env->misa_ext_mask;
>   
>       /*
> -     * Suppress 'C' if next instruction is not aligned
> -     * TODO: this should check next_pc
> +     * Suppress 'C' if next instruction is not aligned.
> +     * Outside of the context of a running cpu, env->pc contains next_pc.
> +     * Within the context of a running cpu, env->pc contains the pc of
> +     * the csrw/csrrw instruction.  But since all such instructions are
> +     * exactly 4 bytes, next_pc has the same alignment mod 4.


By "outside of the context of a running CPU" you mean a halted CPU, correct?

And now, for a running CPU, env->pc has the pc of csrw/csrrw because of patch 1.
Otherwise it would contain a pc that was synchronized via the last
synchronize_from_tb, or any other insn that happened to sync env->pc in
the same TB via gen_update_pc(). We're not keeping env->pc up to date all
the time because it would be extra work that wouldn't be needed most of the
time. Am I too off the mark?

The reason I'm asking is because I see at least one place (get_physical_address())
where it's stated that "the env->pc at this point is incorrect". And I see env->pc
being either the current PC or the next insn PC depending on the situation.
Reading these 2 patches clarified it a bit (assuming I'm not completely incorrect,
of course).




For the patch:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>        */
> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> +    if ((val & RVC) && (env->pc & ~3) != 0) {
>           val &= ~RVC;
>       }
>   


