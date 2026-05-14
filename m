Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5201DCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNTFv-0003y7-9t; Thu, 14 May 2026 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTFf-0003xV-RB
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:25:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTFc-0001xs-3H
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:25:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so43505105e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778754305; x=1779359105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2xoIzxn4HbPg8QNtw/fojdTWGYSXjhQ7sb6oqC6TE8=;
 b=uacfkUOo1J9xydZhoYbg9WEmN4LVztzOJJmWs5r2Tn9/H4DcyI/Om/NxKTH5M9hWlV
 fzpct/jzy2Qef9Td1JPgR5+hipK49RiCWB3WfgGDF7x6miL41nQNXDCo+qMyqcSj8zzy
 nXkocfM0XYBWFwZClFl/KAvIGAxOQQ/GAU9McS5dODP20U/forDbyw2iDIOV9s/+wmBm
 orhXLcA6ZW6S+9yDukZaRdmvk8jXWcjrsWZ4M9GnrGM3AqEoU0347ZDT28CyhJXfM8ZU
 xFRvoUvYs36NzBWyg7XePDVDF4FJXs2N46U8PcFNL5FI+MQztvw74ZpGDfcGh15MgRJe
 Hn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754305; x=1779359105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2xoIzxn4HbPg8QNtw/fojdTWGYSXjhQ7sb6oqC6TE8=;
 b=QZgEfuUGFR6HoWs/jB7EG+lN/XES1+5VHl17lBX7Clo1I0n9X51JmyUP86A+sSV3LG
 pswQ9WcS0OOFXxKITBHcGRkZAstbT1tGOtEusC+OzPU8KxbNgGv6bmvBV7IIuOEuZmLl
 ibi2hlyUByMfFKgGbJg+QOD1kU2m28pP8e112iuw0kH2rR8JcI3yhw/Ujl+YjZP2Xsj0
 4zG2gsLlO7pAagOTHCTZW88VKSkRJ3DJnARItLOUtmAjByb77UwojTuYXTTaoMkrBRnP
 n4STTs+kfFKwFakCJ2wMeeI5QzcvkFOJroxnYFCkqa7gwVfLvC5BmfNBC5cWPzH27c44
 QfsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oMhLPiuekEHqgxZyPwXXbcQGBIddVW8zqpsATTl17l2Q1NDtu/L2GzwSqeD6tTcc48VMue7PXjil0@nongnu.org
X-Gm-Message-State: AOJu0YwL3Lr15YeylHkGONBifd83ASQfnEBJUyDQ1enxYJkJ3yG0Tqqv
 Mpl2jq5RvkiLiIrSKyX+p7tOyvbKpdIZtJqF+1sN53OXdvYCeaaZstuN1F0GIoaidok=
X-Gm-Gg: Acq92OHKyZaZ7s7HM/hMZqMVNVcKUmDcp+JF34cJvMDH4byg2VkdwCyu1iJ+SiGVae5
 Z891Scu0EdQgeUrauvOOoiINQ6FvIBFgdZyeufaMU9zCzrzF1hQU7msRIFpgefW8mHCtTiVPzZg
 fjhFfb1aLmYM2v1xjJ+cJU+s7t9l1To34KzHtZX5jhpjQt5oe1HCZzjWftWMt1DzksfoqIZSLoE
 4nm7YSDvGFIHNV6ndscY95N8gMKAnWTwFjkFjtVnObifkiLKM4xYAQTCMvhalAZ1bdza3grE3HQ
 wMzqElxMCzOe67FXJFBwe/soLUSLbUYK2OugQC+IPpMudHYbVmteiYEZG0dxs16wn/GCxGPhf/O
 fM3qJop4BxsMTTEAyrk+Qc/dxSB017aqS2AHNTCpdm9t3JtQYrqhR38XZi9z2zekJR3vsOnJXBB
 ZPB7aZGuoPhVbM9d3E7VNpE5IUF5Dbjowi6EK9/YiI4C6EpcDmdTVUMtMsRrCRHFFbww==
X-Received: by 2002:a05:600c:83c7:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-48fc9a31d69mr105138765e9.14.1778754304916; 
 Thu, 14 May 2026 03:25:04 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd62b4e78sm17074825e9.1.2026.05.14.03.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:25:02 -0700 (PDT)
Message-ID: <cc04ad5a-dc2b-4963-90ef-8b21ec264dba@linaro.org>
Date: Thu, 14 May 2026 12:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/35] target/mips: add Octeon ZCB instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-13-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-13-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 11/5/26 20:22, James Hilliard wrote:
> ZCB zeros the 128-byte cache block containing the base address.
> 
> Model the user-mode-visible effect by aligning the address down to a
> 128-byte line and storing sixteen zero doublewords to guest memory.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split ZCB out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  3 +++
>   target/mips/tcg/octeon_translate.c | 24 ++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index d77717cd50..d8a1bfce77 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
>   SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
> +&zcb         base
> +ZCB          011100 base:5 00000 00000 11100 011111 &zcb
> +
>   &lx          base index rd
>   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
>   LWX          011111 ..... ..... ..... 00000 001010 @lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index daeaf07072..75b28c4338 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -174,6 +174,30 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>       return true;
>   }
>   
> +static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 line = tcg_temp_new_i64();
> +    TCGv_i64 zero = tcg_constant_i64(0);

Could it be more effective to use TCGv_i128 zero?

> +
> +    gen_base_offset_addr(ctx, addr, a->base, 0);
> +
> +    /*
> +     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
> +     * in guest memory.
> +     */
> +    tcg_gen_andi_i64(line, addr, ~0x7fULL);
> +
> +    for (int i = 0; i < 16; i++) {
> +        TCGv_i64 slot = tcg_temp_new_i64();
> +
> +        tcg_gen_addi_i64(slot, line, i * 8);
> +        tcg_gen_qemu_st_i64(zero, slot, ctx->mem_idx, mo_endian(ctx) | MO_UQ);

s/MO_UQ/MO_$bits/

> +    }
> +
> +    return true;
> +}
> +
>   TRANS(SAA,  trans_saa, MO_UL);
>   TRANS(SAAD, trans_saa, MO_UQ);
>   TRANS(LBX,  trans_lx, MO_SB);
> 


