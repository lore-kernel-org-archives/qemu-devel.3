Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66251CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 18:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPPUx-0007tT-Is; Tue, 19 May 2026 14:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPPUw-0007tL-2T
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:48:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPPUu-0002uq-AM
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:48:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso39906335e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779216532; x=1779821332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=COY/uUd6t1tsT2Jo4l1DnYZ0paWbKjoiKuFGB8qOegg=;
 b=CrNjAlMPfPqaVjfE3H5d1G59uBm/tKDon0cFZfSKJl6m7XxZfmcelTsZNtlBbZ3gLg
 z7emphvouNHjaUYRYeiINtaNQgBJr818us+dcfOPI49giMratYmPaW+w10PiwMLubOtc
 +E90B4BPARfEdgaHvNqG8NBCZvx53QdId4Tk+baJ2TfKl5vUAf0x613Ov2wLf1TD0oq/
 tCMiFbKrvlw4fRzo6F49+Eqgzb7VSTE28v6PHNBjvEe2SIeIWomtXb3nM894hSQotSqK
 m+KgLlwT1yrRlmVZhNz0KIORmKc8bX/T4AA31zkVpAMmVxX7DW1H+Kp3r3DPSGndg9U+
 CIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779216532; x=1779821332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COY/uUd6t1tsT2Jo4l1DnYZ0paWbKjoiKuFGB8qOegg=;
 b=r3ey711qx93IlkHYLfzMqzK9XVWrBavd/XjzbyD/3n0U4ytAblo7rxQ0G+y0gzH6m0
 FdVvlUjOLZH/fH1xmSJN0s8hPzJZGbgL4XouPBTWihgSxp3Xa2O7S5cwLobNWZ1PO/89
 kM+sDN090kn6qEcE2yQjwXooVnPqZZm8dO/OTtHm2lwi1zsWqVUyBqkKCV/HlTVE4oHQ
 N47SAUsIPVCz35uY0lIT2Pb8eH6NaYNgxhae3xw7F88QDKKPiXCCGQPmZ2rjoJqtDqeE
 lgH5vlM2TW4MhzqaTo9DBLNZRWAsx1JZJ76/JWoultS/ea5MTT96LxlxzrEjSHRtsyVb
 M2fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9siSKfp7ZjoPqhqSkfsBNRpWNYrWB+ZGaj1QFwaOcEpmFOwLJ0xFqk90M6UlfkenpdwM++C65Fh8HG@nongnu.org
X-Gm-Message-State: AOJu0YywKEaYjaXdH/J5gHPWMDKXvUKoi+Wk3CzGPvwvqe6HgyAIYRaT
 hKkvT76P0pPgV5zMaIXdH93Q+IljMayCPvzKipLXb5uOKYCSq/FgxwSlylbbNeJL/pw=
X-Gm-Gg: Acq92OFKeVg+PvLcXuyqCqntDdVN1NgRN/t2alsHG+1sIjXmOGQE7pyZQ0EZ3cBNNlx
 A0Bg8bchYgT+ivnaroizWf5EU7xxdVpfgyCdsx5S/ZNMdorCENCBeCOmXwi8Omsf7DQFx+5u9AA
 ethGQl7RYDnpGzxm12J3tu3t0WgHrLq2RoKPsBMVMMzPHXImEYtie1ujcajig0MIJQpfen0JetH
 FojxKZ6MoncGdbQfwXu6O0KW9y7YZAUY79E59mSwWZaU3P+Z4xrTjkNS8i+L22CjIKc9I2Aeu1n
 MtvUZMcjMkIx4WadhuxNXUS0DVr6Cu2c/UuQb6Le1yCDFigBCdwzaAjOE723fjnj/TJUSJq6BC/
 809krcjYCYHtGmhcT0uBYdwz20zRVm7WvKrv4oUlICDqtSn3rkiss0XJtWdi/ZTgJ0BT+2XNE4g
 8DmcHQ3ikqfoKKO5qKc5TwxMt/Zxc8T41UCcDF/CQec/xA7H3ehLIE42KVNpAKab5QKA==
X-Received: by 2002:a05:600c:a09:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48fe539198fmr296765705e9.13.1779216532204; 
 Tue, 19 May 2026 11:48:52 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6afe7sm108349435e9.24.2026.05.19.11.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 11:48:51 -0700 (PDT)
Message-ID: <6f0423ca-8c61-4f82-88fc-c826f9e06114@linaro.org>
Date: Tue, 19 May 2026 20:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/40] target/mips: add Octeon ZCB and ZCBT instructions
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-12-d7dd735ecddd@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-12-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 19/5/26 18:22, James Hilliard wrote:
> ZCB zeros the 128-byte cache block containing the base address. ZCBT has
> the same user-mode-visible memory effect for QEMU purposes.
> 
> Model both forms with a single decodetree wildcard entry, align the
> address down to a 128-byte line, and store eight zero 128-bit chunks to
> guest memory.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v8 -> v9:
>    - Use MO_ATOM_NONE for the 128-bit zero stores so TCG does not
>      require unavailable 128-bit atomic stores on hosts that lack them.
> 
> Changes v7 -> v8:
>    - Fold the ZCBT wildcard decode into the ZCB patch so the series does not
>      add a ZCB-only decode and rewrite it in the next patch.
> 
> Changes v6 -> v7:
>    - Use 128-bit zero stores with MO_128 instead of sixteen 64-bit stores.
>      (suggested by Philippe Mathieu-Daudé)
>    - Fold ZCB and ZCBT into a single decodetree wildcard entry instead of
>      using a duplicate entry with a selector comment.  (suggested by Philippe
>      Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Split ZCB/ZCBT out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  3 +++
>   target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index d77717cd50..01ed3b50be 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
>   SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
> +&zcb         base
> +ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
> +
>   &lx          base index rd
>   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
>   LWX          011111 ..... ..... ..... 00000 001010 @lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index d3dfef2e0c..721a9a8d9d 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -176,6 +176,33 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>   
>   TRANS(SAA,  trans_saa, MO_32);
>   TRANS(SAAD, trans_saa, MO_64);
> +
> +static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 line = tcg_temp_new_i64();
> +    TCGv_i64 zero64 = tcg_constant_i64(0);
> +    TCGv_i128 zero128 = tcg_temp_new_i128();

        const MemOp mop = mo_endian(ctx) | MO_128 | MO_ATOM_NONE;

Although $zero endianness is irrelevant :) but I prefer to keep
it explicit for coding style.

I can squash upon applying if you agree or keep your patch as it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    gen_base_offset_addr(ctx, addr, a->base, 0);
> +    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
> +
> +    /*
> +     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
> +     * in guest memory.
> +     */
> +    tcg_gen_andi_i64(line, addr, ~0x7fULL);
> +
> +    for (int i = 0; i < 8; i++) {
> +        TCGv_i64 slot = tcg_temp_new_i64();
> +
> +        tcg_gen_addi_i64(slot, line, i * 16);
> +        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx,
> +                             mo_endian(ctx) | MO_128 | MO_ATOM_NONE);
 > +    }> +
> +    return true;
> +}
>   TRANS(LBX,  trans_lx, MO_SB);
>   TRANS(LBUX, trans_lx, MO_UB);
>   TRANS(LHX,  trans_lx, MO_SW);
> 


