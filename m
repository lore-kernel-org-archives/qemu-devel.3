Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA1ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyRkJ-0005fs-R8; Tue, 16 Sep 2025 05:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uyRkH-0005fa-PU
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uyRkC-0001j8-M9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758013975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x96D+ov82M7o3fxCjjP7YwNTlPhuYDJpE4mFO+Kdnt4=;
 b=IJCLHPruvo6bP/334S4T8qGkPI3i3qdRy/Haf8F9XHaoCDIxv9oZwxo4NqrOYtFag6eG/d
 a3hRjc/QUcB+7GHZl/SCc1NxuVKA9K6WtcjrSXBqX/yI7OqVoZ5aWeQOgV8XWF+eNDfW8X
 hTVp3KN+HCM1DITN2/iqSuLbvuyhy+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-c622nFNHOfSgvLRpgZ_ZJw-1; Tue, 16 Sep 2025 05:12:53 -0400
X-MC-Unique: c622nFNHOfSgvLRpgZ_ZJw-1
X-Mimecast-MFC-AGG-ID: c622nFNHOfSgvLRpgZ_ZJw_1758013972
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45f2a1660fcso20505715e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 02:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758013972; x=1758618772;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x96D+ov82M7o3fxCjjP7YwNTlPhuYDJpE4mFO+Kdnt4=;
 b=tsYa8UrDe0HkHANyVsOlwcQR+TXRXeyBK1lW3JrOIU0iPpA7fiyeNd6fLP2dZXA+vJ
 DF6cBEPkPW5DQtTRxwms3PObslOeOkRFRO4MRccJh3Lcsr07yuNoy49+BLmLeKzvmA45
 HmfqzxoFpDvpa1q2sZaphfxwtaKQjUKt0fASu1XQAhU4QBjtqUrbGIhtyoNji3vgBW9u
 6790QzPvn3VROxFbZmhQp0NttcYbeQ4mgYYQtSounqIm4b97rM9LcsVMjkP4vSArvfaJ
 rKf5kbJZOFBqQctTGlumZTPm0B19agVvTYb3EZHmkV2fk9BG0jg7IH+fthwXbbyJnnpx
 GytQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXDZx3dsOvHT9TFJy7n8G8rCGYSYZk7NNBa6CiEFUNapjJhR4nxRonQw/F7GpuLrwm5+TIylhqbkWk@nongnu.org
X-Gm-Message-State: AOJu0YxSr9uB0kriJa8e5AKXGq2v4FsuB//WGidK2PPU8J3STt4FfPmh
 XV4qc5EjDsJgBd6JQT0LSRvEfIZ6pHSTsfAqv/8Tx+XDljXBZ6DAIbtKyAj4qXoh/BTj4N5rqVe
 4JrmOBaD7qVR2AkK2A4zQ+SB1lW5EloBChRnlytWnpJBNw64j0HO8uuAW
X-Gm-Gg: ASbGncs+x+MxL9Fxu3tPrF+qfBGV/4Zyhl1evGF7g2nQhUunjzKOfzTd+uMXAABTJiN
 hSGjma7vDgSKymK+J1onznavWX21aKZKVTC37YECG0Rqfpz864VWW5nedIeDbdO/4RKRGVtaqo0
 2jLHHjUr1m5NdjCcQ0BQqOZI4voF+Cp6u53NCUJkaMnzsRS3QTLj+3N3P8R+Teh+soTTqNXXnAM
 9wvWOLg5zlw5w4G09z1bQTncKs6gjpN06h1h7FEM/rfDKgoyRI6fARR0c6BFcH5QhNQeWb9xxWG
 xFOmom01TvsC6F2hA2A1IvBPWmA/cgrvniRlJdFchtXkqd+cPdBzwvgf08MNJU9AjZSebzSL6My
 bcK4=
X-Received: by 2002:a05:600c:4ed1:b0:45f:280d:15ea with SMTP id
 5b1f17b1804b1-45f280d1cc8mr93895875e9.26.1758013971863; 
 Tue, 16 Sep 2025 02:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpGO1E0nnhQUBs1GApGuTJOvG3FBrpaRfcCRhAeHQzBThGSx8TnIeTw9mgEJGgjqNECFOUjA==
X-Received: by 2002:a05:600c:4ed1:b0:45f:280d:15ea with SMTP id
 5b1f17b1804b1-45f280d1cc8mr93895385e9.26.1758013971180; 
 Tue, 16 Sep 2025 02:12:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e01baa70dsm221240585e9.15.2025.09.16.02.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 02:12:50 -0700 (PDT)
Message-ID: <1c736939-4132-427c-906f-c0c779043805@redhat.com>
Date: Tue, 16 Sep 2025 11:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250912164808.371944-7-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/25 18:47, Glenn Miles wrote:
> Adds the following instructions exclusively for
> IBM PPE42 processors:
> 
>    LSKU
>    LCXU
>    STSKU
>    STCXU
>    LVD
>    LVDU
>    LVDX
>    STVD
>    STVDU
>    STVDX
>    SLVD
>    SRVD
>    CMPWBC
>    CMPLWBC
>    CMPWIBC
>    BNBWI
>    BNBW
>    CLRBWIBC
>    CLRWBC
>    DCBQ
>    RLDICL
>    RLDICR
>    RLDIMI
> 
> A PPE42 GCC compiler is available here:
> https://github.com/open-power/ppe42-gcc
> 
> For more information on the PPE42 processors please visit:
> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
> Changes from v3:
>    - Removed copy of CHECK_VDR
>    - Refactored ld/st instructions
> 
>   target/ppc/insn32.decode            |  66 ++-
>   target/ppc/translate.c              |  29 +-
>   target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
>   3 files changed, 750 insertions(+), 10 deletions(-)
>   create mode 100644 target/ppc/translate/ppe-impl.c.inc
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index e53fd2840d..8beb588a2a 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -58,6 +58,10 @@
>   %ds_rtp         22:4   !function=times_2
>   @DS_rtp         ...... ....0 ra:5 .............. ..             &D rt=%ds_rtp si=%ds_si
>   
> +%dd_si          3:s13
> +&DD             rt ra si:int64_t
> +@DD             ...... rt:5 ra:5 ............. . ..             &DD si=%dd_si
> +
>   &DX_b           vrt b
>   %dx_b           6:10 16:5 0:1
>   @DX_b           ...... vrt:5  ..... .......... ..... .          &DX_b b=%dx_b
> @@ -66,6 +70,11 @@
>   %dx_d           6:s10 16:5 0:1
>   @DX             ...... rt:5  ..... .......... ..... .           &DX d=%dx_d
>   
> +%md_sh          1:1 11:5
> +%md_mb          5:1 6:5
> +&MD             rs ra sh mb rc
> +@MD             ...... rs:5 ra:5 ..... ...... ... . rc:1        &MD sh=%md_sh mb=%md_mb
> +
>   &VA             vrt vra vrb rc
>   @VA             ...... vrt:5 vra:5 vrb:5 rc:5 ......            &VA
>   
> @@ -322,6 +331,13 @@ LDUX            011111 ..... ..... ..... 0000110101 -   @X
>   
>   LQ              111000 ..... ..... ............ ----    @DQ_rtp
>   
> +LVD             000101 ..... ..... ................     @D
> +LVDU            001001 ..... ..... ................     @D
> +LVDX            011111 ..... ..... ..... 0000010001 -   @X
> +LSKU            111010 ..... ..... ............. 0 11   @DD
> +LCXU            111010 ..... ..... ............. 1 11   @DD
> +
> +
>   ### Fixed-Point Store Instructions
>   
>   STB             100110 ..... ..... ................     @D
> @@ -346,6 +362,11 @@ STDUX           011111 ..... ..... ..... 0010110101 -   @X
>   
>   STQ             111110 ..... ..... ..............10     @DS_rtp
>   
> +STVDU           010110 ..... ..... ................     @D
> +STVDX           011111 ..... ..... ..... 0010010001 -   @X
> +STSKU           111110 ..... ..... ............. 0 11   @DD
> +STCXU           111110 ..... ..... ............. 1 11   @DD
> +
>   ### Fixed-Point Compare Instructions
>   
>   CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
> @@ -461,8 +482,14 @@ PRTYD           011111 ..... ..... ----- 0010111010 -   @X_sa
>   
>   BPERMD          011111 ..... ..... ..... 0011111100 -   @X
>   CFUGED          011111 ..... ..... ..... 0011011100 -   @X
> -CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
> -CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
> +{
> +  SLVD            011111 ..... ..... ..... 0000111011 .   @X_rc
> +  CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
> +}
> +{
> +  SRVD            011111 ..... ..... ..... 1000111011 .   @X_rc
> +  CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
> +}
>   PDEPD           011111 ..... ..... ..... 0010011100 -   @X
>   PEXTD           011111 ..... ..... ..... 0010111100 -   @X
>   
> @@ -981,8 +1008,16 @@ LXSSP           111001 ..... ..... .............. 11    @DS
>   STXSSP          111101 ..... ..... .............. 11    @DS
>   LXV             111101 ..... ..... ............ . 001   @DQ_TSX
>   STXV            111101 ..... ..... ............ . 101   @DQ_TSX
> -LXVP            000110 ..... ..... ............ 0000    @DQ_TSXP
> -STXVP           000110 ..... ..... ............ 0001    @DQ_TSXP
> +
> +# STVD PPE instruction overlaps with the LXVP and STXVP instructions
> +{
> +  STVD          000110 ..... ..... ................     @D
> +  [
> +    LXVP        000110 ..... ..... ............ 0000    @DQ_TSXP
> +    STXVP       000110 ..... ..... ............ 0001    @DQ_TSXP
> +  ]
> +}
> +
>   LXVX            011111 ..... ..... ..... 0100 - 01100 . @X_TSX
>   STXVX           011111 ..... ..... ..... 0110001100 .   @X_TSX
>   LXVPX           011111 ..... ..... ..... 0101001101 -   @X_TSXP
> @@ -1300,3 +1335,26 @@ CLRBHRB         011111 ----- ----- ----- 0110101110 -
>   ## Misc POWER instructions
>   
>   ATTN            000000 00000 00000 00000 0100000000 0
> +
> +# Fused compare-branch instructions for PPE only
> +%fcb_bdx        1:s10  !function=times_4
> +&FCB            px:bool ra rb:uint64_t bdx lk:bool
> +@FCB            ...... .. px:1 .. ra:5 rb:5 .......... lk:1       &FCB bdx=%fcb_bdx
> +&FCB_bix        px:bool bix ra rb:uint64_t bdx lk:bool
> +@FCB_bix        ...... .. px:1 bix:2 ra:5 rb:5 .......... lk:1    &FCB_bix bdx=%fcb_bdx
> +
> +CMPWBC          000001 00 . .. ..... ..... .......... .     @FCB_bix
> +CMPLWBC         000001 01 . .. ..... ..... .......... .     @FCB_bix
> +CMPWIBC         000001 10 . .. ..... ..... .......... .     @FCB_bix
> +BNBWI           000001 11 . 00 ..... ..... .......... .     @FCB
> +BNBW            000001 11 . 01 ..... ..... .......... .     @FCB
> +CLRBWIBC        000001 11 . 10 ..... ..... .......... .     @FCB
> +CLRBWBC         000001 11 . 11 ..... ..... .......... .     @FCB
> +
> +# Data Cache Block Query for PPE only
> +DCBQ            011111 ..... ..... ..... 0110010110 -       @X
> +
> +# Rotate Doubleword Instructions for PPE only (if TARGET_PPC64 not defined)
> +RLDICL          011110 ..... ..... ..... ...... 000 . .     @MD
> +RLDICR          011110 ..... ..... ..... ...... 001 . .     @MD
> +RLDIMI          011110 ..... ..... ..... ...... 011 . .     @MD
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index fc817dab54..d422789a1d 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -209,6 +209,11 @@ struct DisasContext {
>   #define DISAS_CHAIN        DISAS_TARGET_2  /* lookup next tb, pc updated */
>   #define DISAS_CHAIN_UPDATE DISAS_TARGET_3  /* lookup next tb, pc stale */
>   
> +static inline bool is_ppe(const DisasContext *ctx)

is_ppe() needs to be conditionnaly compiled if !TARGET_PPC64

Thanks,

C.




> +{
> +    return !!(ctx->flags & POWERPC_FLAG_PPE42);
> +}
> +
>   /* Return true iff byteswap is needed in a scalar memop */
>   static inline bool need_byteswap(const DisasContext *ctx)
>   {
> @@ -556,11 +561,8 @@ void spr_access_nop(DisasContext *ctx, int sprn, int gprn)
>   
>   #endif
>   
> -/* SPR common to all PowerPC */
> -/* XER */
> -void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
> +static void gen_get_xer(DisasContext *ctx, TCGv dst)
>   {
> -    TCGv dst = cpu_gpr[gprn];
>       TCGv t0 = tcg_temp_new();
>       TCGv t1 = tcg_temp_new();
>       TCGv t2 = tcg_temp_new();
> @@ -579,9 +581,16 @@ void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
>       }
>   }
>   
> -void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
> +/* SPR common to all PowerPC */
> +/* XER */
> +void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
> +{
> +    TCGv dst = cpu_gpr[gprn];
> +    gen_get_xer(ctx, dst);
> +}
> +
> +static void gen_set_xer(DisasContext *ctx, TCGv src)
>   {
> -    TCGv src = cpu_gpr[gprn];
>       /* Write all flags, while reading back check for isa300 */
>       tcg_gen_andi_tl(cpu_xer, src,
>                       ~((1u << XER_SO) |
> @@ -594,6 +603,12 @@ void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
>       tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
>   }
>   
> +void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
> +{
> +    TCGv src = cpu_gpr[gprn];
> +    gen_set_xer(ctx, src);
> +}
> +
>   /* LR */
>   void spr_read_lr(DisasContext *ctx, int gprn, int sprn)
>   {
> @@ -5755,6 +5770,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
>   
>   #include "translate/bhrb-impl.c.inc"
>   
> +#include "translate/ppe-impl.c.inc"
> +
>   /* Handles lfdp */
>   static void gen_dform39(DisasContext *ctx)
>   {
> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
> new file mode 100644
> index 0000000000..792103d7c2
> --- /dev/null
> +++ b/target/ppc/translate/ppe-impl.c.inc
> @@ -0,0 +1,665 @@
> +/*
> + * IBM PPE Instructions
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +#if !defined(TARGET_PPC64)
> +static bool vdr_is_valid(uint32_t vdr)
> +{
> +    const uint32_t valid_bitmap = 0xf00003ff;
> +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
> +}
> +
> +static bool ppe_gpr_is_valid(uint32_t reg)
> +{
> +    const uint32_t valid_bitmap = 0xf00027ff;
> +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
> +}
> +#endif
> +
> +#define CHECK_VDR(CTX, VDR)                             \
> +    do {                                                \
> +        if (unlikely(!vdr_is_valid(VDR))) {             \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +#define CHECK_PPE_GPR(CTX, REG)                         \
> +    do {                                                \
> +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
> +
> +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
> +    do {                                                \
> +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int i;
> +    TCGv base, EA;
> +    TCGv lo, hi;
> +    TCGv_i64 t8;
> +    const uint8_t vd_list[] = {9, 7, 5, 3, 0};
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) || (a->si < 0xB))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    base = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(base, cpu_gpr[a->ra], a->si * 8);
> +    gen_store_spr(SPR_PPE42_EDR, base);
> +
> +    t8 = tcg_temp_new_i64();
> +
> +    tcg_gen_addi_tl(EA, base, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(cpu_gpr[31], cpu_gpr[30], t8);
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(cpu_gpr[29], cpu_gpr[28], t8);
> +
> +    lo = tcg_temp_new();
> +    hi = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(lo, hi, t8);
> +    gen_store_spr(SPR_SRR0, hi);
> +    gen_store_spr(SPR_SRR1, lo);
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(lo, hi, t8);
> +    gen_set_xer(ctx, hi);
> +    tcg_gen_mov_tl(cpu_ctr, lo);
> +
> +    for (i = 0; i < sizeof(vd_list); i++) {
> +        int vd = vd_list[i];
> +        tcg_gen_addi_tl(EA, EA, -8);
> +        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +        tcg_gen_extr_i64_tl(cpu_gpr[VDR_PAIR_REG(vd)], cpu_gpr[vd], t8);
> +    }
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(lo, hi, t8);
> +    tcg_gen_shri_tl(hi, hi, 28);
> +    tcg_gen_trunc_tl_i32(cpu_crf[0], hi);
> +    gen_store_spr(SPR_SPRG0, lo);
> +
> +    tcg_gen_addi_tl(EA, base, 4);
> +    tcg_gen_qemu_ld_tl(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], base);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_LSKU(DisasContext *ctx, arg_LSKU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int64_t n;
> +    TCGv base, EA;
> +    TCGv_i32 lo, hi;
> +    TCGv_i64 t8;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) ||
> +                 (a->si & PPC_BIT(0)) || (a->si == 0))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    base = tcg_temp_new();
> +    gen_addr_register(ctx, base);
> +
> +
> +    tcg_gen_addi_tl(base, base, a->si * 8);
> +    gen_store_spr(SPR_PPE42_EDR, base);
> +
> +    n = a->si - 1;
> +    t8 = tcg_temp_new_i64();
> +    if (n > 0) {
> +        tcg_gen_addi_tl(EA, base, -8);
> +        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +        hi = cpu_gpr[30];
> +        lo = cpu_gpr[31];
> +        tcg_gen_extr_i64_i32(lo, hi, t8);
> +    }
> +    if (n > 1) {
> +        tcg_gen_addi_tl(EA, base, -16);
> +        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +        hi = cpu_gpr[28];
> +        lo = cpu_gpr[29];
> +        tcg_gen_extr_i64_i32(lo, hi, t8);
> +    }
> +    tcg_gen_addi_tl(EA, base, 4);
> +    tcg_gen_qemu_ld_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], base);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_STCXU(DisasContext *ctx, arg_STCXU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv EA;
> +    TCGv lo, hi;
> +    TCGv_i64 t8;
> +    int i;
> +    const uint8_t vd_list[] = {9, 7, 5, 3, 0};
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) || !(a->si & PPC_BIT(0)))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], 4);
> +    tcg_gen_qemu_st_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +
> +    gen_store_spr(SPR_PPE42_EDR, cpu_gpr[a->ra]);
> +
> +    t8 = tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[31], cpu_gpr[30]);
> +    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[29], cpu_gpr[28]);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    lo = tcg_temp_new();
> +    hi = tcg_temp_new();
> +
> +    gen_load_spr(hi, SPR_SRR0);
> +    gen_load_spr(lo, SPR_SRR1);
> +    tcg_gen_concat_tl_i64(t8, lo, hi);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    gen_get_xer(ctx, hi);
> +    tcg_gen_mov_tl(lo, cpu_ctr);
> +    tcg_gen_concat_tl_i64(t8, lo, hi);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    for (i = 0; i < sizeof(vd_list); i++) {
> +        int vd = vd_list[i];
> +        tcg_gen_concat_tl_i64(t8, cpu_gpr[VDR_PAIR_REG(vd)], cpu_gpr[vd]);
> +        tcg_gen_addi_tl(EA, EA, -8);
> +        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    }
> +
> +    gen_load_spr(lo, SPR_SPRG0);
> +    tcg_gen_extu_i32_tl(hi, cpu_crf[0]);
> +    tcg_gen_shli_tl(hi, hi, 28);
> +    tcg_gen_concat_tl_i64(t8, lo, hi);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], a->si * 8);
> +    tcg_gen_qemu_st_i32(cpu_gpr[a->rt], EA, ctx->mem_idx, DEF_MEMOP(MO_32) |
> +                                                          MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], EA);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_STSKU(DisasContext *ctx, arg_STSKU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int64_t n;
> +    TCGv base, EA;
> +    TCGv_i32 lo, hi;
> +    TCGv_i64 t8;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) || !(a->si & PPC_BIT(0)))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    base = tcg_temp_new();
> +    gen_addr_register(ctx, base);
> +    tcg_gen_addi_tl(EA, base, 4);
> +    tcg_gen_qemu_st_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +
> +    gen_store_spr(SPR_PPE42_EDR, base);
> +
> +    n = ~(a->si);
> +
> +    t8 = tcg_temp_new_i64();
> +    if (n > 0) {
> +        hi = cpu_gpr[30];
> +        lo = cpu_gpr[31];
> +        tcg_gen_concat_i32_i64(t8, lo, hi);
> +        tcg_gen_addi_tl(EA, base, -8);
> +        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    }
> +    if (n > 1) {
> +        hi = cpu_gpr[28];
> +        lo = cpu_gpr[29];
> +        tcg_gen_concat_i32_i64(t8, lo, hi);
> +        tcg_gen_addi_tl(EA, base, -16);
> +        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    }
> +
> +    tcg_gen_addi_tl(EA, base, a->si * 8);
> +    tcg_gen_qemu_st_i32(cpu_gpr[a->rt], EA, ctx->mem_idx, DEF_MEMOP(MO_32) |
> +                                                          MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], EA);
> +    return true;
> +#endif
> +}
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_ppe_ldst(DisasContext *ctx, int rt, int ra, TCGv disp,
> +                        bool update, bool store)
> +{
> +    TCGv ea;
> +    int rt_lo;
> +    TCGv_i64 t8;
> +
> +    CHECK_VDR(ctx, rt);
> +    CHECK_PPE_GPR(ctx, ra);
> +    rt_lo = VDR_PAIR_REG(rt);
> +    if (update && (ra == 0 || (!store && ((ra == rt) || (ra == rt_lo))))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +
> +    ea = do_ea_calc(ctx, ra, disp);
> +    t8 = tcg_temp_new_i64();
> +    if (store) {
> +        tcg_gen_concat_i32_i64(t8, cpu_gpr[rt_lo], cpu_gpr[rt]);
> +        tcg_gen_qemu_st_i64(t8, ea, ctx->mem_idx, DEF_MEMOP(MO_64));
> +    } else {
> +        tcg_gen_qemu_ld_i64(t8, ea, ctx->mem_idx, DEF_MEMOP(MO_64));
> +        tcg_gen_extr_i64_i32(cpu_gpr[rt_lo], cpu_gpr[rt], t8);
> +    }
> +    if (update) {
> +        tcg_gen_mov_tl(cpu_gpr[ra], ea);
> +    }
> +    return true;
> +}
> +#endif
> +
> +static bool do_ppe_ldst_D(DisasContext *ctx, arg_D *a, bool update, bool store)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    /* Some PowerPC CPU's have a different meaning for the STVD instruction */
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_ppe_ldst(ctx, a->rt, a->ra, tcg_constant_tl(a->si), update,
> +                       store);
> +#endif
> +}
> +
> +static bool do_ppe_ldst_X(DisasContext *ctx, arg_X *a, bool store)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    return do_ppe_ldst(ctx, a->rt, a->ra, cpu_gpr[a->rb], false, store);
> +#endif
> +}
> +
> +TRANS(LVD,   do_ppe_ldst_D, false, false)
> +TRANS(LVDU,  do_ppe_ldst_D, true,  false)
> +TRANS(STVD,  do_ppe_ldst_D, false, true)
> +TRANS(STVDU, do_ppe_ldst_D, true,  true)
> +TRANS(LVDX,  do_ppe_ldst_X, false)
> +TRANS(STVDX, do_ppe_ldst_X, true)
> +
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_fcb(DisasContext *ctx, TCGv ra_val, TCGv rb_val, int bix,
> +                          int32_t bdx, bool s, bool px, bool lk)
> +{
> +    TCGCond cond;
> +    uint32_t mask;
> +    TCGLabel *no_branch;
> +    target_ulong dest;
> +
> +    /* Update CR0 */
> +    gen_op_cmp32(ra_val, rb_val, s, 0);
> +
> +    if (lk) {
> +        gen_setlr(ctx, ctx->base.pc_next);
> +    }
> +
> +
> +    mask = PPC_BIT32(28 + bix);
> +    cond = (px) ? TCG_COND_TSTEQ : TCG_COND_TSTNE;
> +    no_branch = gen_new_label();
> +    dest = ctx->cia + bdx;
> +
> +    /* Do the branch if CR0[bix] == PX */
> +    tcg_gen_brcondi_i32(cond, cpu_crf[0], mask, no_branch);
> +    gen_goto_tb(ctx, 0, dest);
> +    gen_set_label(no_branch);
> +    gen_goto_tb(ctx, 1, ctx->base.pc_next);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +}
> +#endif
> +
> +static bool do_cmp_branch(DisasContext *ctx, arg_FCB_bix *a, bool s,
> +                          bool rb_is_gpr)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv old_ra;
> +    TCGv rb_val;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->ra);
> +    if (rb_is_gpr) {
> +        CHECK_PPE_GPR(ctx, a->rb);
> +        rb_val = cpu_gpr[a->rb];
> +    } else {
> +        rb_val = tcg_constant_tl(a->rb);
> +    }
> +    if (a->bix == 3) {
> +        old_ra = tcg_temp_new();
> +        tcg_gen_mov_tl(old_ra, cpu_gpr[a->ra]);
> +        tcg_gen_sub_tl(cpu_gpr[a->ra], cpu_gpr[a->ra], rb_val);
> +        return do_fcb(ctx, old_ra, rb_val, 2,
> +                      a->bdx, s, a->px, a->lk);
> +    } else {
> +        return do_fcb(ctx, cpu_gpr[a->ra], rb_val, a->bix,
> +                      a->bdx, s, a->px, a->lk);
> +    }
> +#endif
> +}
> +
> +TRANS(CMPWBC, do_cmp_branch, true, true)
> +TRANS(CMPLWBC, do_cmp_branch, false, true)
> +TRANS(CMPWIBC, do_cmp_branch, true, false)
> +
> +static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
> +                           bool update, bool rb_is_gpr)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv r;
> +    TCGv mask, shift;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->ra);
> +    if (rb_is_gpr) {
> +        CHECK_PPE_GPR(ctx, a->rb);
> +        mask = tcg_temp_new();
> +        shift = tcg_temp_new();
> +        tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
> +        tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
> +    } else {
> +        mask = tcg_constant_tl(PPC_BIT32(a->rb));
> +    }
> +    if (invert) {
> +        tcg_gen_not_tl(mask, mask);
> +    }
> +
> +    /* apply mask to ra */
> +    r = tcg_temp_new();
> +    tcg_gen_and_tl(r, cpu_gpr[a->ra], mask);
> +    if (update) {
> +        tcg_gen_mov_tl(cpu_gpr[a->ra], r);
> +    }
> +    return do_fcb(ctx, r, tcg_constant_tl(0), 2,
> +                  a->bdx, false, a->px, a->lk);
> +#endif
> +}
> +
> +TRANS(BNBWI,    do_mask_branch, false, false, false)
> +TRANS(BNBW,     do_mask_branch, false, false, true)
> +TRANS(CLRBWIBC, do_mask_branch, true,  true,  false)
> +TRANS(CLRBWBC,  do_mask_branch, true,  true,  true)
> +
> +#if !defined(TARGET_PPC64)
> +static void gen_set_Rc0_i64(DisasContext *ctx, TCGv_i64 reg)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i32 t = tcg_temp_new_i32();
> +
> +    tcg_gen_movi_i64(t0, CRF_EQ);
> +    tcg_gen_movi_i64(t1, CRF_LT);
> +    tcg_gen_movcond_i64(TCG_COND_LT, t0, reg, tcg_constant_i64(0), t1, t0);
> +    tcg_gen_movi_i64(t1, CRF_GT);
> +    tcg_gen_movcond_i64(TCG_COND_GT, t0, reg, tcg_constant_i64(0), t1, t0);
> +    tcg_gen_extrl_i64_i32(t, t0);
> +    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
> +    tcg_gen_or_i32(cpu_crf[0], cpu_crf[0], t);
> +}
> +#endif
> +
> +static bool do_shift64(DisasContext *ctx, arg_X_rc *a, bool left)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int rt_lo, ra_lo;
> +    TCGv_i64 t0, t8;
> +
> +    /* Check for PPE since opcode overlaps with CNTTZDM instruction */
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_VDR(ctx, a->rt);
> +    CHECK_VDR(ctx, a->ra);
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    rt_lo = VDR_PAIR_REG(a->rt);
> +    ra_lo = VDR_PAIR_REG(a->ra);
> +    t8 = tcg_temp_new_i64();
> +
> +    /* AND rt with a mask that is 0 when rb >= 0x40 */
> +    t0 = tcg_temp_new_i64();
> +    tcg_gen_extu_tl_i64(t0, cpu_gpr[a->rb]);
> +    tcg_gen_shli_i64(t0, t0, 0x39);
> +    tcg_gen_sari_i64(t0, t0, 0x3f);
> +
> +    /* form 64bit value from two 32bit regs */
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[rt_lo], cpu_gpr[a->rt]);
> +
> +    /* apply mask */
> +    tcg_gen_andc_i64(t8, t8, t0);
> +
> +    /* do the shift */
> +    tcg_gen_extu_tl_i64(t0, cpu_gpr[a->rb]);
> +    tcg_gen_andi_i64(t0, t0, 0x3f);
> +    if (left) {
> +        tcg_gen_shl_i64(t8, t8, t0);
> +    } else {
> +        tcg_gen_shr_i64(t8, t8, t0);
> +    }
> +
> +    /* split the 64bit word back into two 32bit regs */
> +    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t8);
> +
> +    /* update CR0 if requested */
> +    if (unlikely(a->rc != 0)) {
> +        gen_set_Rc0_i64(ctx, t8);
> +    }
> +    return true;
> +#endif
> +}
> +
> +TRANS(SRVD, do_shift64, false)
> +TRANS(SLVD, do_shift64, true)
> +
> +static bool trans_DCBQ(DisasContext *ctx, arg_DCBQ * a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_GPR(ctx, a->rt);
> +    CHECK_PPE_GPR(ctx, a->ra);
> +    CHECK_PPE_GPR(ctx, a->rb);
> +
> +    /* No cache exists, so just set RT to 0 */
> +    tcg_gen_movi_tl(cpu_gpr[a->rt], 0);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_RLDIMI(DisasContext *ctx, arg_RLDIMI *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv_i64 t_rs, t_ra;
> +    int ra_lo, rs_lo;
> +    uint32_t sh = a->sh;
> +    uint32_t mb = a->mb;
> +    uint32_t me = 63 - sh;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_VDR(ctx, a->rs);
> +    CHECK_VDR(ctx, a->ra);
> +
> +    rs_lo = VDR_PAIR_REG(a->rs);
> +    ra_lo = VDR_PAIR_REG(a->ra);
> +
> +    t_rs = tcg_temp_new_i64();
> +    t_ra = tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(t_rs, cpu_gpr[rs_lo], cpu_gpr[a->rs]);
> +    tcg_gen_concat_tl_i64(t_ra, cpu_gpr[ra_lo], cpu_gpr[a->ra]);
> +
> +    if (mb <= me) {
> +        tcg_gen_deposit_i64(t_ra, t_ra, t_rs, sh, me - mb + 1);
> +    } else {
> +        uint64_t mask = mask_u64(mb, me);
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +
> +        tcg_gen_rotli_i64(t1, t_rs, sh);
> +        tcg_gen_andi_i64(t1, t1, mask);
> +        tcg_gen_andi_i64(t_ra, t_ra, ~mask);
> +        tcg_gen_or_i64(t_ra, t_ra, t1);
> +    }
> +
> +    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t_ra);
> +
> +    if (unlikely(a->rc != 0)) {
> +        gen_set_Rc0_i64(ctx, t_ra);
> +    }
> +    return true;
> +#endif
> +}
> +
> +
> +static bool gen_rldinm_i64(DisasContext *ctx, arg_MD *a, int mb, int me, int sh)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int len = me - mb + 1;
> +    int rsh = (64 - sh) & 63;
> +    int ra_lo, rs_lo;
> +    TCGv_i64 t8;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_VDR(ctx, a->rs);
> +    CHECK_VDR(ctx, a->ra);
> +
> +    rs_lo = VDR_PAIR_REG(a->rs);
> +    ra_lo = VDR_PAIR_REG(a->ra);
> +    t8 = tcg_temp_new_i64();
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[rs_lo], cpu_gpr[a->rs]);
> +    if (sh != 0 && len > 0 && me == (63 - sh)) {
> +        tcg_gen_deposit_z_i64(t8, t8, sh, len);
> +    } else if (me == 63 && rsh + len <= 64) {
> +        tcg_gen_extract_i64(t8, t8, rsh, len);
> +    } else {
> +        tcg_gen_rotli_i64(t8, t8, sh);
> +        tcg_gen_andi_i64(t8, t8, mask_u64(mb, me));
> +    }
> +    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t8);
> +    if (unlikely(a->rc != 0)) {
> +        gen_set_Rc0_i64(ctx, t8);
> +    }
> +    return true;
> +#endif
> +}
> +
> +TRANS(RLDICL, gen_rldinm_i64, a->mb, 63, a->sh)
> +TRANS(RLDICR, gen_rldinm_i64, 0, a->mb, a->sh)
> +


