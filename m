Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1384A108E1FD
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CFy-0000Ks-Eu; Thu, 19 Mar 2026 08:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w3CFt-0000KW-Ma
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:13:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w3CFj-00065T-7m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:13:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so6925925e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773922403; x=1774527203; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KjnCwkwmX5DQgIZq1s7z1N44xvEAKoOObeMXwU66cec=;
 b=tY/ZsSFQulzBqiYE0YCN8xBtDhy1EUEyrHODSKGvwfI82l5DyEAyBnOtVbAYMK+EYi
 A8t+sdDJEhvZiAwQkcdRHY78eGOYCyQ4ZQZZ7GiTYfe425ud8K8IU74KVwm/abe1enZI
 TwDjtqCavVI8NWHBMhPHEx5tqxFAWbTlkh2aH3WyD2wRfI9CMH/cwUT75czIzU0ChbYE
 WMS3yEzWLNbx+SCzOHts/7Ll3VbggZPAlogpz7Aq8SwQDQKnEIFwVoJ/TiHDpiYL4Lym
 xZedK5MN6evQVKy4+JjBjAQ2nnlf3R/mGhoKLeuaxd8wzqNVHZE+tlwdzragMThxiRm/
 pKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922403; x=1774527203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KjnCwkwmX5DQgIZq1s7z1N44xvEAKoOObeMXwU66cec=;
 b=P2XGgTM9gS61BAFU2T/xO/XC1TZVgeCuA/9fqcdcDwMzxiEOSZb59x8Nt8rkqQPyT/
 kONQLSTiHe3N2gFvAitGx1KjlpYPseyg1QIihUADi+r9tnGkUiFa5KCvpKmEnj80h/Jb
 56rtAH7FypsR/TugyIcg3EUmC4ICA8h5yiV+ljHft1oD8ebEhmo5cqCbnIC8YUpdPy5U
 FWrMeRfa4MejoZS5/9wRCxTp98I5dkOv2ceufTatWN5rfSCeoDFyqNWECt1Zw0HXSG/O
 KbP7HXSQwkSlC60WdMIkrSWnLmLsRngpnzphWCJD5xK3xfhEHzr1/8EOqkjbbU1QvUEy
 nt4A==
X-Gm-Message-State: AOJu0YyQ9Kh5v8FN3UbcOdD0R77afLDoF0Cv/ReBjhMPCvumkwSIL90S
 QaNrl2tq0gssJ+dD4c60f/BLJws8SbTWWNgZNm/9Z66DOS1a3/AoPEw6ONmp0iZphBLetbqvl5S
 I+5/z
X-Gm-Gg: ATEYQzx83e8rSLPURuIPvSdh+XspZx3tKC88zow4yl9jBdUruKPkCb9jyoNnnZO7Xrd
 vGmOggRswmm9lo2GJLyoCFeNAx1mV1jVvJUqovDF5N9HN26wE48FvmkbFPmWmgY4Ca6IkzaUduE
 RQD1hNXHFspKjYcWHKrXPnFKUG4lHreLKyo6xK9nou/gQZWCkdJCUBZFyaqRygOYCyb2B97pIY9
 pxynb3vF5ZS1E+EJE07fAd2bAW8Qtcb3Y0guRYT3ZEixvViE2+A94VLMTh9g0cD4O/CKlOd1t1K
 Db5vvWohiG7ESHP1nAYQLXBPabO4jQFGjuiWyht5vvUHi/AZZQE8Gg+1EsHWvqspBzvFqlHXQkr
 YNcNxlbmrHYb/yNsDL0xMInWw9kw8TsGjuvyueozK2Rgou32MFoYTZmVB1ZrhU7lG/9N4YL0wQg
 innPBo6IyMqVkNmixEtvbl8tc+CWU=
X-Received: by 2002:a05:600c:6097:b0:486:f634:ef3 with SMTP id
 5b1f17b1804b1-486f6340ff0mr85179385e9.32.1773922402943; 
 Thu, 19 Mar 2026 05:13:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5dd6:71c1:29c2:4a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fd9575ffsm2456215e9.7.2026.03.19.05.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:13:22 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 19 Mar 2026 12:12:41 +0000
Subject: [PATCH RFC 1/2] tcg/aarch64/tcg-target.c.inc: Replacement of I3XXX
 names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-aarch64-tcg-instruction-format-rename-v1-1-8a13bf98f8ff@linaro.org>
References: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
In-Reply-To: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

Mechanical replacement of instruction format names of the form 'I3206'
etc with more useful names. Where possible, names from a64.decode are
used. Includes manual fixes to whitespace.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 962 ++++++++++++++++++++++---------------------
 1 file changed, 490 insertions(+), 472 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index caf79c742d..e9f86176d2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -399,256 +399,256 @@ typedef enum {
    instruction group is described.  */
 typedef enum {
     /* Compare and branch (immediate).  */
-    I3201_CBZ       = 0x34000000,
-    I3201_CBNZ      = 0x35000000,
+    Icbz_CBZ         = 0x34000000,
+    Icbz_CBNZ        = 0x35000000,
 
     /* Conditional branch (immediate).  */
-    I3202_B_C       = 0x54000000,
+    Ibcond_imm_B_C   = 0x54000000,
 
     /* Test and branch (immediate).  */
-    I3205_TBZ       = 0x36000000,
-    I3205_TBNZ      = 0x37000000,
+    Itbz_TBZ         = 0x36000000,
+    Itbz_TBNZ        = 0x37000000,
 
     /* Unconditional branch (immediate).  */
-    I3206_B         = 0x14000000,
-    I3206_BL        = 0x94000000,
+    Ibranch_B        = 0x14000000,
+    Ibranch_BL       = 0x94000000,
 
     /* Unconditional branch (register).  */
-    I3207_BR        = 0xd61f0000,
-    I3207_BLR       = 0xd63f0000,
-    I3207_RET       = 0xd65f0000,
+    Ibcond_reg_BR    = 0xd61f0000,
+    Ibcond_reg_BLR   = 0xd63f0000,
+    Ibcond_reg_RET   = 0xd65f0000,
 
     /* AdvSIMD load/store single structure.  */
-    I3303_LD1R      = 0x0d40c000,
+    Isimd_loadrep_LD1R = 0x0d40c000,
 
     /* Load literal for loading the address at pc-relative offset */
-    I3305_LDR       = 0x58000000,
-    I3305_LDR_v64   = 0x5c000000,
-    I3305_LDR_v128  = 0x9c000000,
+    Ildlit_LDR       = 0x58000000,
+    Ildlit_LDR_v64   = 0x5c000000,
+    Ildlit_LDR_v128  = 0x9c000000,
 
     /* Load/store exclusive. */
-    I3306_LDXP      = 0xc8600000,
-    I3306_STXP      = 0xc8200000,
+    Istxp_LDXP       = 0xc8600000,
+    Istxp_STXP       = 0xc8200000,
 
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
-    I3312_STRB      = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
-    I3312_STRH      = 0x38000000 | LDST_ST << 22 | MO_16 << 30,
-    I3312_STRW      = 0x38000000 | LDST_ST << 22 | MO_32 << 30,
-    I3312_STRX      = 0x38000000 | LDST_ST << 22 | MO_64 << 30,
+    Ildst_imm_STRB   = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
+    Ildst_imm_STRH   = 0x38000000 | LDST_ST << 22 | MO_16 << 30,
+    Ildst_imm_STRW   = 0x38000000 | LDST_ST << 22 | MO_32 << 30,
+    Ildst_imm_STRX   = 0x38000000 | LDST_ST << 22 | MO_64 << 30,
 
-    I3312_LDRB      = 0x38000000 | LDST_LD << 22 | MO_8 << 30,
-    I3312_LDRH      = 0x38000000 | LDST_LD << 22 | MO_16 << 30,
-    I3312_LDRW      = 0x38000000 | LDST_LD << 22 | MO_32 << 30,
-    I3312_LDRX      = 0x38000000 | LDST_LD << 22 | MO_64 << 30,
+    Ildst_imm_LDRB   = 0x38000000 | LDST_LD << 22 | MO_8 << 30,
+    Ildst_imm_LDRH   = 0x38000000 | LDST_LD << 22 | MO_16 << 30,
+    Ildst_imm_LDRW   = 0x38000000 | LDST_LD << 22 | MO_32 << 30,
+    Ildst_imm_LDRX   = 0x38000000 | LDST_LD << 22 | MO_64 << 30,
 
-    I3312_LDRSBW    = 0x38000000 | LDST_LD_S_W << 22 | MO_8 << 30,
-    I3312_LDRSHW    = 0x38000000 | LDST_LD_S_W << 22 | MO_16 << 30,
+    Ildst_imm_LDRSBW = 0x38000000 | LDST_LD_S_W << 22 | MO_8 << 30,
+    Ildst_imm_LDRSHW = 0x38000000 | LDST_LD_S_W << 22 | MO_16 << 30,
 
-    I3312_LDRSBX    = 0x38000000 | LDST_LD_S_X << 22 | MO_8 << 30,
-    I3312_LDRSHX    = 0x38000000 | LDST_LD_S_X << 22 | MO_16 << 30,
-    I3312_LDRSWX    = 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,
+    Ildst_imm_LDRSBX = 0x38000000 | LDST_LD_S_X << 22 | MO_8 << 30,
+    Ildst_imm_LDRSHX = 0x38000000 | LDST_LD_S_X << 22 | MO_16 << 30,
+    Ildst_imm_LDRSWX = 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,
 
-    I3312_LDRVS     = 0x3c000000 | LDST_LD << 22 | MO_32 << 30,
-    I3312_STRVS     = 0x3c000000 | LDST_ST << 22 | MO_32 << 30,
+    Ildst_imm_LDRVS  = 0x3c000000 | LDST_LD << 22 | MO_32 << 30,
+    Ildst_imm_STRVS  = 0x3c000000 | LDST_ST << 22 | MO_32 << 30,
 
-    I3312_LDRVD     = 0x3c000000 | LDST_LD << 22 | MO_64 << 30,
-    I3312_STRVD     = 0x3c000000 | LDST_ST << 22 | MO_64 << 30,
+    Ildst_imm_LDRVD  = 0x3c000000 | LDST_LD << 22 | MO_64 << 30,
+    Ildst_imm_STRVD  = 0x3c000000 | LDST_ST << 22 | MO_64 << 30,
 
-    I3312_LDRVQ     = 0x3c000000 | 3 << 22 | 0 << 30,
-    I3312_STRVQ     = 0x3c000000 | 2 << 22 | 0 << 30,
+    Ildst_imm_LDRVQ  = 0x3c000000 | 3 << 22 | 0 << 30,
+    Ildst_imm_STRVQ  = 0x3c000000 | 2 << 22 | 0 << 30,
 
-    I3312_TO_I3310  = 0x00200800,
-    I3312_TO_I3313  = 0x01000000,
+    Ildst_imm_TO_I3310 = 0x00200800,
+    Ildst_imm_TO_I3313 = 0x01000000,
 
     /* Load/store register pair instructions.  */
-    I3314_LDP       = 0x28400000,
-    I3314_STP       = 0x28000000,
+    Ildstpair_LDP    = 0x28400000,
+    Ildstpair_STP    = 0x28000000,
 
     /* Add/subtract immediate instructions.  */
-    I3401_ADDI      = 0x11000000,
-    I3401_ADDSI     = 0x31000000,
-    I3401_SUBI      = 0x51000000,
-    I3401_SUBSI     = 0x71000000,
+    Iaddsub_imm_ADDI  = 0x11000000,
+    Iaddsub_imm_ADDSI = 0x31000000,
+    Iaddsub_imm_SUBI  = 0x51000000,
+    Iaddsub_imm_SUBSI = 0x71000000,
 
     /* Bitfield instructions.  */
-    I3402_BFM       = 0x33000000,
-    I3402_SBFM      = 0x13000000,
-    I3402_UBFM      = 0x53000000,
+    Ibitfield_32_BFM  = 0x33000000,
+    Ibitfield_32_SBFM = 0x13000000,
+    Ibitfield_32_UBFM = 0x53000000,
 
     /* Extract instruction.  */
-    I3403_EXTR      = 0x13800000,
+    Iextract_EXTR     = 0x13800000,
 
     /* Logical immediate instructions.  */
-    I3404_ANDI      = 0x12000000,
-    I3404_ORRI      = 0x32000000,
-    I3404_EORI      = 0x52000000,
-    I3404_ANDSI     = 0x72000000,
+    Ilogic_imm_32_ANDI  = 0x12000000,
+    Ilogic_imm_32_ORRI  = 0x32000000,
+    Ilogic_imm_32_EORI  = 0x52000000,
+    Ilogic_imm_32_ANDSI = 0x72000000,
 
     /* Move wide immediate instructions.  */
-    I3405_MOVN      = 0x12800000,
-    I3405_MOVZ      = 0x52800000,
-    I3405_MOVK      = 0x72800000,
+    Imovw_32_MOVN      = 0x12800000,
+    Imovw_32_MOVZ      = 0x52800000,
+    Imovw_32_MOVK      = 0x72800000,
 
     /* PC relative addressing instructions.  */
-    I3406_ADR       = 0x10000000,
-    I3406_ADRP      = 0x90000000,
+    Ipcrel_ADR         = 0x10000000,
+    Ipcrel_ADRP        = 0x90000000,
 
     /* Add/subtract extended register instructions. */
-    I3501_ADD       = 0x0b200000,
+    Iaddsub_ext_ADD    = 0x0b200000,
 
     /* Add/subtract shifted register instructions (without a shift).  */
-    I3502_ADD       = 0x0b000000,
-    I3502_ADDS      = 0x2b000000,
-    I3502_SUB       = 0x4b000000,
-    I3502_SUBS      = 0x6b000000,
+    Iaddsub_shift_ADD  = 0x0b000000,
+    Iaddsub_shift_ADDS = 0x2b000000,
+    Iaddsub_shift_SUB  = 0x4b000000,
+    Iaddsub_shift_SUBS = 0x6b000000,
 
     /* Add/subtract shifted register instructions (with a shift).  */
-    I3502S_ADD_LSL  = I3502_ADD,
+    Iaddsub_realshift_ADD_LSL = Iaddsub_shift_ADD,
 
     /* Add/subtract with carry instructions.  */
-    I3503_ADC       = 0x1a000000,
-    I3503_ADCS      = 0x3a000000,
-    I3503_SBC       = 0x5a000000,
-    I3503_SBCS      = 0x7a000000,
+    Irrr_sf_ADC        = 0x1a000000,
+    Irrr_sf_ADCS       = 0x3a000000,
+    Irrr_sf_SBC        = 0x5a000000,
+    Irrr_sf_SBCS       = 0x7a000000,
 
     /* Conditional select instructions.  */
-    I3506_CSEL      = 0x1a800000,
-    I3506_CSINC     = 0x1a800400,
-    I3506_CSINV     = 0x5a800000,
-    I3506_CSNEG     = 0x5a800400,
+    Icsel_CSEL         = 0x1a800000,
+    Icsel_CSINC        = 0x1a800400,
+    Icsel_CSINV        = 0x5a800000,
+    Icsel_CSNEG        = 0x5a800400,
 
     /* Data-processing (1 source) instructions.  */
-    I3507_CLZ       = 0x5ac01000,
-    I3507_RBIT      = 0x5ac00000,
-    I3507_REV       = 0x5ac00000, /* + size << 10 */
+    Irr_sf_CLZ         = 0x5ac01000,
+    Irr_sf_RBIT        = 0x5ac00000,
+    Irr_sf_REV         = 0x5ac00000, /* + size << 10 */
 
     /* Data-processing (2 source) instructions.  */
-    I3508_LSLV      = 0x1ac02000,
-    I3508_LSRV      = 0x1ac02400,
-    I3508_ASRV      = 0x1ac02800,
-    I3508_RORV      = 0x1ac02c00,
-    I3508_SMULH     = 0x9b407c00,
-    I3508_UMULH     = 0x9bc07c00,
-    I3508_UDIV      = 0x1ac00800,
-    I3508_SDIV      = 0x1ac00c00,
+    Irrr_LSLV          = 0x1ac02000,
+    Irrr_LSRV          = 0x1ac02400,
+    Irrr_ASRV          = 0x1ac02800,
+    Irrr_RORV          = 0x1ac02c00,
+    Irrr_SMULH         = 0x9b407c00,
+    Irrr_UMULH         = 0x9bc07c00,
+    Irrr_UDIV          = 0x1ac00800,
+    Irrr_SDIV          = 0x1ac00c00,
 
     /* Data-processing (3 source) instructions.  */
-    I3509_MADD      = 0x1b000000,
-    I3509_MSUB      = 0x1b008000,
+    Irrrr_MADD         = 0x1b000000,
+    Irrrr_MSUB         = 0x1b008000,
 
     /* Logical shifted register instructions (without a shift).  */
-    I3510_AND       = 0x0a000000,
-    I3510_BIC       = 0x0a200000,
-    I3510_ORR       = 0x2a000000,
-    I3510_ORN       = 0x2a200000,
-    I3510_EOR       = 0x4a000000,
-    I3510_EON       = 0x4a200000,
-    I3510_ANDS      = 0x6a000000,
+    Ilogic_shift_AND   = 0x0a000000,
+    Ilogic_shift_BIC   = 0x0a200000,
+    Ilogic_shift_ORR   = 0x2a000000,
+    Ilogic_shift_ORN   = 0x2a200000,
+    Ilogic_shift_EOR   = 0x4a000000,
+    Ilogic_shift_EON   = 0x4a200000,
+    Ilogic_shift_ANDS  = 0x6a000000,
 
     /* Logical shifted register instructions (with a shift).  */
-    I3502S_AND_LSR  = I3510_AND | (1 << 22),
+    Iaddsub_realshift_AND_LSR  = Ilogic_shift_AND | (1 << 22),
 
     /* AdvSIMD copy */
-    I3605_DUP      = 0x0e000400,
-    I3605_INS      = 0x4e001c00,
-    I3605_UMOV     = 0x0e003c00,
+    Isimd_copy_DUP     = 0x0e000400,
+    Isimd_copy_INS     = 0x4e001c00,
+    Isimd_copy_UMOV    = 0x0e003c00,
 
     /* AdvSIMD modified immediate */
-    I3606_MOVI      = 0x0f000400,
-    I3606_MVNI      = 0x2f000400,
-    I3606_BIC       = 0x2f001400,
-    I3606_ORR       = 0x0f001400,
+    Isimd_imm_MOVI     = 0x0f000400,
+    Isimd_imm_MVNI     = 0x2f000400,
+    Isimd_imm_BIC      = 0x2f001400,
+    Isimd_imm_ORR      = 0x0f001400,
 
     /* AdvSIMD scalar shift by immediate */
-    I3609_SSHR      = 0x5f000400,
-    I3609_SSRA      = 0x5f001400,
-    I3609_SHL       = 0x5f005400,
-    I3609_USHR      = 0x7f000400,
-    I3609_USRA      = 0x7f001400,
-    I3609_SLI       = 0x7f005400,
+    Iq_shift_SSHR      = 0x5f000400,
+    Iq_shift_SSRA      = 0x5f001400,
+    Iq_shift_SHL       = 0x5f005400,
+    Iq_shift_USHR      = 0x7f000400,
+    Iq_shift_USRA      = 0x7f001400,
+    Iq_shift_SLI       = 0x7f005400,
 
     /* AdvSIMD scalar three same */
-    I3611_SQADD     = 0x5e200c00,
-    I3611_SQSUB     = 0x5e202c00,
-    I3611_CMGT      = 0x5e203400,
-    I3611_CMGE      = 0x5e203c00,
-    I3611_SSHL      = 0x5e204400,
-    I3611_ADD       = 0x5e208400,
-    I3611_CMTST     = 0x5e208c00,
-    I3611_UQADD     = 0x7e200c00,
-    I3611_UQSUB     = 0x7e202c00,
-    I3611_CMHI      = 0x7e203400,
-    I3611_CMHS      = 0x7e203c00,
-    I3611_USHL      = 0x7e204400,
-    I3611_SUB       = 0x7e208400,
-    I3611_CMEQ      = 0x7e208c00,
+    Irrr_e_SQADD      = 0x5e200c00,
+    Irrr_e_SQSUB      = 0x5e202c00,
+    Irrr_e_CMGT       = 0x5e203400,
+    Irrr_e_CMGE       = 0x5e203c00,
+    Irrr_e_SSHL       = 0x5e204400,
+    Irrr_e_ADD        = 0x5e208400,
+    Irrr_e_CMTST      = 0x5e208c00,
+    Irrr_e_UQADD      = 0x7e200c00,
+    Irrr_e_UQSUB      = 0x7e202c00,
+    Irrr_e_CMHI       = 0x7e203400,
+    Irrr_e_CMHS       = 0x7e203c00,
+    Irrr_e_USHL       = 0x7e204400,
+    Irrr_e_SUB        = 0x7e208400,
+    Irrr_e_CMEQ       = 0x7e208c00,
 
     /* AdvSIMD scalar two-reg misc */
-    I3612_CMGT0     = 0x5e208800,
-    I3612_CMEQ0     = 0x5e209800,
-    I3612_CMLT0     = 0x5e20a800,
-    I3612_ABS       = 0x5e20b800,
-    I3612_CMGE0     = 0x7e208800,
-    I3612_CMLE0     = 0x7e209800,
-    I3612_NEG       = 0x7e20b800,
+    Isimd_rr_CMGT0    = 0x5e208800,
+    Isimd_rr_CMEQ0    = 0x5e209800,
+    Isimd_rr_CMLT0    = 0x5e20a800,
+    Isimd_rr_ABS      = 0x5e20b800,
+    Isimd_rr_CMGE0    = 0x7e208800,
+    Isimd_rr_CMLE0    = 0x7e209800,
+    Isimd_rr_NEG      = 0x7e20b800,
 
     /* AdvSIMD shift by immediate */
-    I3614_SSHR      = 0x0f000400,
-    I3614_SSRA      = 0x0f001400,
-    I3614_SHL       = 0x0f005400,
-    I3614_SLI       = 0x2f005400,
-    I3614_USHR      = 0x2f000400,
-    I3614_USRA      = 0x2f001400,
+    Isimd_shift_imm_SSHR = 0x0f000400,
+    Isimd_shift_imm_SSRA = 0x0f001400,
+    Isimd_shift_imm_SHL  = 0x0f005400,
+    Isimd_shift_imm_SLI  = 0x2f005400,
+    Isimd_shift_imm_USHR = 0x2f000400,
+    Isimd_shift_imm_USRA = 0x2f001400,
 
     /* AdvSIMD three same.  */
-    I3616_ADD       = 0x0e208400,
-    I3616_AND       = 0x0e201c00,
-    I3616_BIC       = 0x0e601c00,
-    I3616_BIF       = 0x2ee01c00,
-    I3616_BIT       = 0x2ea01c00,
-    I3616_BSL       = 0x2e601c00,
-    I3616_EOR       = 0x2e201c00,
-    I3616_MUL       = 0x0e209c00,
-    I3616_ORR       = 0x0ea01c00,
-    I3616_ORN       = 0x0ee01c00,
-    I3616_SUB       = 0x2e208400,
-    I3616_CMGT      = 0x0e203400,
-    I3616_CMGE      = 0x0e203c00,
-    I3616_CMTST     = 0x0e208c00,
-    I3616_CMHI      = 0x2e203400,
-    I3616_CMHS      = 0x2e203c00,
-    I3616_CMEQ      = 0x2e208c00,
-    I3616_SMAX      = 0x0e206400,
-    I3616_SMIN      = 0x0e206c00,
-    I3616_SSHL      = 0x0e204400,
-    I3616_SQADD     = 0x0e200c00,
-    I3616_SQSUB     = 0x0e202c00,
-    I3616_UMAX      = 0x2e206400,
-    I3616_UMIN      = 0x2e206c00,
-    I3616_UQADD     = 0x2e200c00,
-    I3616_UQSUB     = 0x2e202c00,
-    I3616_USHL      = 0x2e204400,
+    Iqrrr_e_ADD       = 0x0e208400,
+    Iqrrr_e_AND       = 0x0e201c00,
+    Iqrrr_e_BIC       = 0x0e601c00,
+    Iqrrr_e_BIF       = 0x2ee01c00,
+    Iqrrr_e_BIT       = 0x2ea01c00,
+    Iqrrr_e_BSL       = 0x2e601c00,
+    Iqrrr_e_EOR       = 0x2e201c00,
+    Iqrrr_e_MUL       = 0x0e209c00,
+    Iqrrr_e_ORR       = 0x0ea01c00,
+    Iqrrr_e_ORN       = 0x0ee01c00,
+    Iqrrr_e_SUB       = 0x2e208400,
+    Iqrrr_e_CMGT      = 0x0e203400,
+    Iqrrr_e_CMGE      = 0x0e203c00,
+    Iqrrr_e_CMTST     = 0x0e208c00,
+    Iqrrr_e_CMHI      = 0x2e203400,
+    Iqrrr_e_CMHS      = 0x2e203c00,
+    Iqrrr_e_CMEQ      = 0x2e208c00,
+    Iqrrr_e_SMAX      = 0x0e206400,
+    Iqrrr_e_SMIN      = 0x0e206c00,
+    Iqrrr_e_SSHL      = 0x0e204400,
+    Iqrrr_e_SQADD     = 0x0e200c00,
+    Iqrrr_e_SQSUB     = 0x0e202c00,
+    Iqrrr_e_UMAX      = 0x2e206400,
+    Iqrrr_e_UMIN      = 0x2e206c00,
+    Iqrrr_e_UQADD     = 0x2e200c00,
+    Iqrrr_e_UQSUB     = 0x2e202c00,
+    Iqrrr_e_USHL      = 0x2e204400,
 
     /* AdvSIMD two-reg misc.  */
-    I3617_CMGT0     = 0x0e208800,
-    I3617_CMEQ0     = 0x0e209800,
-    I3617_CMLT0     = 0x0e20a800,
-    I3617_CMGE0     = 0x2e208800,
-    I3617_CMLE0     = 0x2e209800,
-    I3617_NOT       = 0x2e205800,
-    I3617_ABS       = 0x0e20b800,
-    I3617_NEG       = 0x2e20b800,
+    Iqrr_e_CMGT0      = 0x0e208800,
+    Iqrr_e_CMEQ0      = 0x0e209800,
+    Iqrr_e_CMLT0      = 0x0e20a800,
+    Iqrr_e_CMGE0      = 0x2e208800,
+    Iqrr_e_CMLE0      = 0x2e209800,
+    Iqrr_e_NOT        = 0x2e205800,
+    Iqrr_e_ABS        = 0x0e20b800,
+    Iqrr_e_NEG        = 0x2e20b800,
 
     /* System instructions.  */
-    NOP             = 0xd503201f,
-    DMB_ISH         = 0xd50338bf,
-    DMB_LD          = 0x00000100,
-    DMB_ST          = 0x00000200,
-
-    BTI_C           = 0xd503245f,
-    BTI_J           = 0xd503249f,
-    BTI_JC          = 0xd50324df,
+    NOP               = 0xd503201f,
+    DMB_ISH           = 0xd50338bf,
+    DMB_LD            = 0x00000100,
+    DMB_ST            = 0x00000200,
+
+    BTI_C             = 0xd503245f,
+    BTI_J             = 0xd503249f,
+    BTI_JC            = 0xd50324df,
 } AArch64Insn;
 
 static inline uint32_t tcg_in32(TCGContext *s)
@@ -661,37 +661,37 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
-static void tcg_out_insn_3303(TCGContext *s, AArch64Insn insn, bool q,
+static void tcg_out_insn_simd_loadrep(TCGContext *s, AArch64Insn insn, bool q,
                               TCGReg rt, TCGReg rn, unsigned size)
 {
     tcg_out32(s, insn | (rt & 0x1f) | (rn << 5) | (size << 10) | (q << 30));
 }
 
-static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_ldlit(TCGContext *s, AArch64Insn insn,
                               int imm19, TCGReg rt)
 {
     tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
 }
 
-static void tcg_out_insn_3306(TCGContext *s, AArch64Insn insn, TCGReg rs,
+static void tcg_out_insn_stxp(TCGContext *s, AArch64Insn insn, TCGReg rs,
                               TCGReg rt, TCGReg rt2, TCGReg rn)
 {
     tcg_out32(s, insn | rs << 16 | rt2 << 10 | rn << 5 | rt);
 }
 
-static void tcg_out_insn_3201(TCGContext *s, AArch64Insn insn, TCGType ext,
+static void tcg_out_insn_cbz(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rt, int imm19)
 {
     tcg_out32(s, insn | ext << 31 | (imm19 & 0x7ffff) << 5 | rt);
 }
 
-static void tcg_out_insn_3202(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_bcond_imm(TCGContext *s, AArch64Insn insn,
                               TCGCond c, int imm19)
 {
     tcg_out32(s, insn | tcg_cond_to_aarch64[c] | (imm19 & 0x7ffff) << 5);
 }
 
-static void tcg_out_insn_3205(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_tbz(TCGContext *s, AArch64Insn insn,
                               TCGReg rt, int imm6, int imm14)
 {
     insn |= (imm6 & 0x20) << (31 - 5);
@@ -699,17 +699,17 @@ static void tcg_out_insn_3205(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | (imm14 & 0x3fff) << 5 | rt);
 }
 
-static void tcg_out_insn_3206(TCGContext *s, AArch64Insn insn, int imm26)
+static void tcg_out_insn_branch(TCGContext *s, AArch64Insn insn, int imm26)
 {
     tcg_out32(s, insn | (imm26 & 0x03ffffff));
 }
 
-static void tcg_out_insn_3207(TCGContext *s, AArch64Insn insn, TCGReg rn)
+static void tcg_out_insn_bcond_reg(TCGContext *s, AArch64Insn insn, TCGReg rn)
 {
     tcg_out32(s, insn | rn << 5);
 }
 
-static void tcg_out_insn_3314(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_ldstpair(TCGContext *s, AArch64Insn insn,
                               TCGReg r1, TCGReg r2, TCGReg rn,
                               tcg_target_long ofs, bool pre, bool w)
 {
@@ -723,8 +723,9 @@ static void tcg_out_insn_3314(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | r2 << 10 | rn << 5 | r1);
 }
 
-static void tcg_out_insn_3401(TCGContext *s, AArch64Insn insn, TCGType ext,
-                              TCGReg rd, TCGReg rn, uint64_t aimm)
+static void tcg_out_insn_addsub_imm(TCGContext *s, AArch64Insn insn,
+                                    TCGType ext, TCGReg rd, TCGReg rn,
+                                    uint64_t aimm)
 {
     if (aimm > 0xfff) {
         tcg_debug_assert((aimm & 0xfff) == 0);
@@ -738,16 +739,17 @@ static void tcg_out_insn_3401(TCGContext *s, AArch64Insn insn, TCGType ext,
 /* This function can be used for both 3.4.2 (Bitfield) and 3.4.4
    (Logical immediate).  Both insn groups have N, IMMR and IMMS fields
    that feed the DecodeBitMasks pseudo function.  */
-static void tcg_out_insn_3402(TCGContext *s, AArch64Insn insn, TCGType ext,
-                              TCGReg rd, TCGReg rn, int n, int immr, int imms)
+static void tcg_out_insn_bitfield_32(TCGContext *s, AArch64Insn insn,
+                                     TCGType ext, TCGReg rd, TCGReg rn, int n,
+                                     int immr, int imms)
 {
     tcg_out32(s, insn | ext << 31 | n << 22 | immr << 16 | imms << 10
               | rn << 5 | rd);
 }
 
-#define tcg_out_insn_3404  tcg_out_insn_3402
+#define tcg_out_insn_logic_imm_32  tcg_out_insn_bitfield_32
 
-static void tcg_out_insn_3403(TCGContext *s, AArch64Insn insn, TCGType ext,
+static void tcg_out_insn_extract(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rd, TCGReg rn, TCGReg rm, int imms)
 {
     tcg_out32(s, insn | ext << 31 | ext << 22 | rm << 16 | imms << 10
@@ -756,20 +758,20 @@ static void tcg_out_insn_3403(TCGContext *s, AArch64Insn insn, TCGType ext,
 
 /* This function is used for the Move (wide immediate) instruction group.
    Note that SHIFT is a full shift count, not the 2 bit HW field. */
-static void tcg_out_insn_3405(TCGContext *s, AArch64Insn insn, TCGType ext,
+static void tcg_out_insn_movw_32(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rd, uint16_t half, unsigned shift)
 {
     tcg_debug_assert((shift & ~0x30) == 0);
     tcg_out32(s, insn | ext << 31 | shift << (21 - 4) | half << 5 | rd);
 }
 
-static void tcg_out_insn_3406(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_pcrel(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, int64_t disp)
 {
     tcg_out32(s, insn | (disp & 3) << 29 | (disp & 0x1ffffc) << (5 - 2) | rd);
 }
 
-static inline void tcg_out_insn_3501(TCGContext *s, AArch64Insn insn,
+static inline void tcg_out_insn_addsub_ext(TCGContext *s, AArch64Insn insn,
                                      TCGType sf, TCGReg rd, TCGReg rn,
                                      TCGReg rm, int opt, int imm3)
 {
@@ -779,9 +781,11 @@ static inline void tcg_out_insn_3501(TCGContext *s, AArch64Insn insn,
 
 /* This function is for both 3.5.2 (Add/Subtract shifted register), for
    the rare occasion when we actually want to supply a shift amount.  */
-static inline void tcg_out_insn_3502S(TCGContext *s, AArch64Insn insn,
-                                      TCGType ext, TCGReg rd, TCGReg rn,
-                                      TCGReg rm, int imm6)
+static inline void tcg_out_insn_addsub_realshift(TCGContext *s,
+                                                 AArch64Insn insn,
+                                                 TCGType ext, TCGReg rd,
+                                                 TCGReg rn, TCGReg rm,
+                                                 int imm6)
 {
     tcg_out32(s, insn | ext << 31 | rm << 16 | imm6 << 10 | rn << 5 | rd);
 }
@@ -790,36 +794,37 @@ static inline void tcg_out_insn_3502S(TCGContext *s, AArch64Insn insn,
    and 3.5.10 (Logical shifted register), for the vast majorty of cases
    when we don't want to apply a shift.  Thus it can also be used for
    3.5.3 (Add/subtract with carry) and 3.5.8 (Data processing 2 source).  */
-static void tcg_out_insn_3502(TCGContext *s, AArch64Insn insn, TCGType ext,
-                              TCGReg rd, TCGReg rn, TCGReg rm)
+static void tcg_out_insn_addsub_shift(TCGContext *s, AArch64Insn insn,
+                                      TCGType ext, TCGReg rd, TCGReg rn,
+                                      TCGReg rm)
 {
     tcg_out32(s, insn | ext << 31 | rm << 16 | rn << 5 | rd);
 }
 
-#define tcg_out_insn_3503  tcg_out_insn_3502
-#define tcg_out_insn_3508  tcg_out_insn_3502
-#define tcg_out_insn_3510  tcg_out_insn_3502
+#define tcg_out_insn_rrr_sf       tcg_out_insn_addsub_shift
+#define tcg_out_insn_rrr          tcg_out_insn_addsub_shift
+#define tcg_out_insn_logic_shift  tcg_out_insn_addsub_shift
 
-static void tcg_out_insn_3506(TCGContext *s, AArch64Insn insn, TCGType ext,
+static void tcg_out_insn_csel(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rd, TCGReg rn, TCGReg rm, TCGCond c)
 {
     tcg_out32(s, insn | ext << 31 | rm << 16 | rn << 5 | rd
               | tcg_cond_to_aarch64[c] << 12);
 }
 
-static void tcg_out_insn_3507(TCGContext *s, AArch64Insn insn, TCGType ext,
+static void tcg_out_insn_rr_sf(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rd, TCGReg rn)
 {
     tcg_out32(s, insn | ext << 31 | rn << 5 | rd);
 }
 
-static void tcg_out_insn_3509(TCGContext *s, AArch64Insn insn, TCGType ext,
+static void tcg_out_insn_rrrr(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rd, TCGReg rn, TCGReg rm, TCGReg ra)
 {
     tcg_out32(s, insn | ext << 31 | rm << 16 | ra << 10 | rn << 5 | rd);
 }
 
-static void tcg_out_insn_3605(TCGContext *s, AArch64Insn insn, bool q,
+static void tcg_out_insn_simd_copy(TCGContext *s, AArch64Insn insn, bool q,
                               TCGReg rd, TCGReg rn, int dst_idx, int src_idx)
 {
     /* Note that bit 11 set means general register input.  Therefore
@@ -828,47 +833,47 @@ static void tcg_out_insn_3605(TCGContext *s, AArch64Insn insn, bool q,
               | (rd & 0x1f) | (~rn & 0x20) << 6 | (rn & 0x1f) << 5);
 }
 
-static void tcg_out_insn_3606(TCGContext *s, AArch64Insn insn, bool q,
+static void tcg_out_insn_simd_imm(TCGContext *s, AArch64Insn insn, bool q,
                               TCGReg rd, bool op, int cmode, uint8_t imm8)
 {
     tcg_out32(s, insn | q << 30 | op << 29 | cmode << 12 | (rd & 0x1f)
               | (imm8 & 0xe0) << (16 - 5) | (imm8 & 0x1f) << 5);
 }
 
-static void tcg_out_insn_3609(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_q_shift(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, TCGReg rn, unsigned immhb)
 {
     tcg_out32(s, insn | immhb << 16 | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3611(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_rrr_e(TCGContext *s, AArch64Insn insn,
                               unsigned size, TCGReg rd, TCGReg rn, TCGReg rm)
 {
     tcg_out32(s, insn | (size << 22) | (rm & 0x1f) << 16
               | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3612(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_simd_rr(TCGContext *s, AArch64Insn insn,
                               unsigned size, TCGReg rd, TCGReg rn)
 {
     tcg_out32(s, insn | (size << 22) | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3614(TCGContext *s, AArch64Insn insn, bool q,
+static void tcg_out_insn_simd_shift_imm(TCGContext *s, AArch64Insn insn, bool q,
                               TCGReg rd, TCGReg rn, unsigned immhb)
 {
     tcg_out32(s, insn | q << 30 | immhb << 16
               | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3616(TCGContext *s, AArch64Insn insn, bool q,
+static void tcg_out_insn_qrrr_e(TCGContext *s, AArch64Insn insn, bool q,
                               unsigned size, TCGReg rd, TCGReg rn, TCGReg rm)
 {
     tcg_out32(s, insn | q << 30 | (size << 22) | (rm & 0x1f) << 16
               | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3617(TCGContext *s, AArch64Insn insn, bool q,
+static void tcg_out_insn_qrr_e(TCGContext *s, AArch64Insn insn, bool q,
                               unsigned size, TCGReg rd, TCGReg rn)
 {
     tcg_out32(s, insn | q << 30 | (size << 22)
@@ -880,11 +885,11 @@ static void tcg_out_insn_3310(TCGContext *s, AArch64Insn insn,
                               TCGReg regoff)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | I3312_TO_I3310 | regoff << 16 |
+    tcg_out32(s, insn | Ildst_imm_TO_I3310 | regoff << 16 |
               0x4000 | ext << 13 | base << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3312(TCGContext *s, AArch64Insn insn,
+static void tcg_out_insn_ldst_imm(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, TCGReg rn, intptr_t offset)
 {
     tcg_out32(s, insn | (offset & 0x1ff) << 12 | rn << 5 | (rd & 0x1f));
@@ -894,7 +899,7 @@ static void tcg_out_insn_3313(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, TCGReg rn, uintptr_t scaled_uimm)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | I3312_TO_I3313 | scaled_uimm << 10
+    tcg_out32(s, insn | Ildst_imm_TO_I3313 | scaled_uimm << 10
               | rn << 5 | (rd & 0x1f));
 }
 
@@ -912,13 +917,13 @@ static void tcg_out_bti(TCGContext *s, AArch64Insn insn)
 /* Register to register move using ORR (shifted register with no shift). */
 static void tcg_out_movr(TCGContext *s, TCGType ext, TCGReg rd, TCGReg rm)
 {
-    tcg_out_insn(s, 3510, ORR, ext, rd, TCG_REG_XZR, rm);
+    tcg_out_insn(s, logic_shift, ORR, ext, rd, TCG_REG_XZR, rm);
 }
 
 /* Register to register move using ADDI (move to/from SP).  */
 static void tcg_out_movr_sp(TCGContext *s, TCGType ext, TCGReg rd, TCGReg rn)
 {
-    tcg_out_insn(s, 3401, ADDI, ext, rd, rn, 0);
+    tcg_out_insn(s, addsub_imm, ADDI, ext, rd, rn, 0);
 }
 
 /* This function is used for the Logical (immediate) instruction group.
@@ -949,7 +954,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
         c &= 31;
     }
 
-    tcg_out_insn_3404(s, insn, ext, rd, rn, ext, r, c);
+    tcg_out_insn_logic_imm_32(s, insn, ext, rd, rn, ext, r, c);
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
@@ -961,7 +966,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     /* Test all bytes equal first.  */
     if (vece == MO_8) {
         imm8 = (uint8_t)v64;
-        tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0xe, imm8);
+        tcg_out_insn(s, simd_imm, MOVI, q, rd, 0, 0xe, imm8);
         return;
     }
 
@@ -977,7 +982,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
             goto fail_bytes;
         }
     }
-    tcg_out_insn(s, 3606, MOVI, q, rd, 1, 0xe, imm8);
+    tcg_out_insn(s, simd_imm, MOVI, q, rd, 1, 0xe, imm8);
     return;
  fail_bytes:
 
@@ -990,11 +995,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
         uint16_t v16 = v64;
 
         if (is_shimm16(v16, &cmode, &imm8)) {
-            tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MOVI, q, rd, 0, cmode, imm8);
             return;
         }
         if (is_shimm16(~v16, &cmode, &imm8)) {
-            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MVNI, q, rd, 0, cmode, imm8);
             return;
         }
 
@@ -1002,8 +1007,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
          * Otherwise, all remaining constants can be loaded in two insns:
          * rd = v16 & 0xff, rd |= v16 & 0xff00.
          */
-        tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0x8, v16 & 0xff);
-        tcg_out_insn(s, 3606, ORR, q, rd, 0, 0xa, v16 >> 8);
+        tcg_out_insn(s, simd_imm, MOVI, q, rd, 0, 0x8, v16 & 0xff);
+        tcg_out_insn(s, simd_imm, ORR, q, rd, 0, 0xa, v16 >> 8);
         return;
     } else if (vece == MO_32) {
         uint32_t v32 = v64;
@@ -1012,12 +1017,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
         if (is_shimm32(v32, &cmode, &imm8) ||
             is_soimm32(v32, &cmode, &imm8) ||
             is_fimm32(v32, &cmode, &imm8)) {
-            tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MOVI, q, rd, 0, cmode, imm8);
             return;
         }
         if (is_shimm32(n32, &cmode, &imm8) ||
             is_soimm32(n32, &cmode, &imm8)) {
-            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MVNI, q, rd, 0, cmode, imm8);
             return;
         }
 
@@ -1027,18 +1032,20 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
          */
         i = is_shimm32_pair(v32, &cmode, &imm8);
         if (i) {
-            tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
-            tcg_out_insn(s, 3606, ORR, q, rd, 0, i, extract32(v32, i * 4, 8));
+            tcg_out_insn(s, simd_imm, MOVI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, ORR, q, rd, 0, i,
+                         extract32(v32, i * 4, 8));
             return;
         }
         i = is_shimm32_pair(n32, &cmode, &imm8);
         if (i) {
-            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
-            tcg_out_insn(s, 3606, BIC, q, rd, 0, i, extract32(n32, i * 4, 8));
+            tcg_out_insn(s, simd_imm, MVNI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, BIC, q, rd, 0, i,
+                         extract32(n32, i * 4, 8));
             return;
         }
     } else if (is_fimm64(v64, &cmode, &imm8)) {
-        tcg_out_insn(s, 3606, MOVI, q, rd, 1, cmode, imm8);
+        tcg_out_insn(s, simd_imm, MOVI, q, rd, 1, cmode, imm8);
         return;
     }
 
@@ -1048,10 +1055,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
      */
     if (type == TCG_TYPE_V128) {
         new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);
-        tcg_out_insn(s, 3305, LDR_v128, 0, rd);
+        tcg_out_insn(s, ldlit, LDR_v128, 0, rd);
     } else {
         new_pool_label(s, v64, R_AARCH64_CONDBR19, s->code_ptr, 0);
-        tcg_out_insn(s, 3305, LDR_v64, 0, rd);
+        tcg_out_insn(s, ldlit, LDR_v64, 0, rd);
     }
 }
 
@@ -1059,7 +1066,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
     int is_q = type - TCG_TYPE_V64;
-    tcg_out_insn(s, 3605, DUP, is_q, rd, rs, 1 << vece, 0);
+    tcg_out_insn(s, simd_copy, DUP, is_q, rd, rs, 1 << vece, 0);
     return true;
 }
 
@@ -1070,25 +1077,26 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
 
     if (offset < -0xffffff || offset > 0xffffff) {
         tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
-        tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
+        tcg_out_insn(s, addsub_shift, ADD, 1, temp, temp, base);
         base = temp;
     } else {
-        AArch64Insn add_insn = I3401_ADDI;
+        AArch64Insn add_insn = Iaddsub_imm_ADDI;
 
         if (offset < 0) {
-            add_insn = I3401_SUBI;
+            add_insn = Iaddsub_imm_SUBI;
             offset = -offset;
         }
         if (offset & 0xfff000) {
-            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff000);
+            tcg_out_insn_addsub_imm(s, add_insn, 1, temp, base,
+                                    offset & 0xfff000);
             base = temp;
         }
         if (offset & 0xfff) {
-            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff);
+            tcg_out_insn_addsub_imm(s, add_insn, 1, temp, base, offset & 0xfff);
             base = temp;
         }
     }
-    tcg_out_insn(s, 3303, LD1R, type == TCG_TYPE_V128, r, base, vece);
+    tcg_out_insn(s, simd_loadrep, LD1R, type == TCG_TYPE_V128, r, base, vece);
     return true;
 }
 
@@ -1124,10 +1132,10 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     /* Speed things up by handling the common case of small positive
        and negative values specially.  */
     if ((value & ~0xffffull) == 0) {
-        tcg_out_insn(s, 3405, MOVZ, type, rd, value, 0);
+        tcg_out_insn(s, movw_32, MOVZ, type, rd, value, 0);
         return;
     } else if ((ivalue & ~0xffffull) == 0) {
-        tcg_out_insn(s, 3405, MOVN, type, rd, ivalue, 0);
+        tcg_out_insn(s, movw_32, MOVN, type, rd, ivalue, 0);
         return;
     }
 
@@ -1135,7 +1143,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
        use the sign-extended value.  That lets us match rotated values such
        as 0xff0000ff with the same 64-bit logic matching 0xffffffffff0000ff. */
     if (is_limm(svalue)) {
-        tcg_out_logicali(s, I3404_ORRI, type, rd, TCG_REG_XZR, svalue);
+        tcg_out_logicali(s, Ilogic_imm_32_ORRI, type, rd, TCG_REG_XZR, svalue);
         return;
     }
 
@@ -1145,14 +1153,14 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         intptr_t src_rx = (intptr_t)tcg_splitwx_to_rx(s->code_ptr);
         tcg_target_long disp = value - src_rx;
         if (disp == sextract64(disp, 0, 21)) {
-            tcg_out_insn(s, 3406, ADR, rd, disp);
+            tcg_out_insn(s, pcrel, ADR, rd, disp);
             return;
         }
         disp = (value >> 12) - (src_rx >> 12);
         if (disp == sextract64(disp, 0, 21)) {
-            tcg_out_insn(s, 3406, ADRP, rd, disp);
+            tcg_out_insn(s, pcrel, ADRP, rd, disp);
             if (value & 0xfff) {
-                tcg_out_insn(s, 3401, ADDI, type, rd, rd, value & 0xfff);
+                tcg_out_insn(s, addsub_imm, ADDI, type, rd, rd, value & 0xfff);
             }
             return;
         }
@@ -1161,26 +1169,26 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     /* Would it take fewer insns to begin with MOVN?  */
     if (ctpop64(value) >= 32) {
         t0 = ivalue;
-        opc = I3405_MOVN;
+        opc = Imovw_32_MOVN;
     } else {
         t0 = value;
-        opc = I3405_MOVZ;
+        opc = Imovw_32_MOVZ;
     }
     s0 = ctz64(t0) & (63 & -16);
     t1 = t0 & ~(0xffffull << s0);
     s1 = ctz64(t1) & (63 & -16);
     t2 = t1 & ~(0xffffull << s1);
     if (t2 == 0) {
-        tcg_out_insn_3405(s, opc, type, rd, t0 >> s0, s0);
+        tcg_out_insn_movw_32(s, opc, type, rd, t0 >> s0, s0);
         if (t1 != 0) {
-            tcg_out_insn(s, 3405, MOVK, type, rd, value >> s1, s1);
+            tcg_out_insn(s, movw_32, MOVK, type, rd, value >> s1, s1);
         }
         return;
     }
 
     /* For more than 2 insns, dump it into the constant pool.  */
     new_pool_label(s, value, R_AARCH64_CONDBR19, s->code_ptr, 0);
-    tcg_out_insn(s, 3305, LDR, 0, rd);
+    tcg_out_insn(s, ldlit, LDR, 0, rd);
 }
 
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
@@ -1213,7 +1221,7 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
 
     /* Small signed offsets can use the unscaled encoding.  */
     if (offset >= -256 && offset < 256) {
-        tcg_out_insn_3312(s, insn, rd, rn, offset);
+        tcg_out_insn_ldst_imm(s, insn, rd, rn, offset);
         return;
     }
 
@@ -1234,21 +1242,21 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
             tcg_out_movr(s, type, ret, arg);
             break;
         } else if (ret < 32) {
-            tcg_out_insn(s, 3605, UMOV, type, ret, arg, 0, 0);
+            tcg_out_insn(s, simd_copy, UMOV, type, ret, arg, 0, 0);
             break;
         } else if (arg < 32) {
-            tcg_out_insn(s, 3605, INS, 0, ret, arg, 4 << type, 0);
+            tcg_out_insn(s, simd_copy, INS, 0, ret, arg, 4 << type, 0);
             break;
         }
         /* FALLTHRU */
 
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= 32 && arg >= 32);
-        tcg_out_insn(s, 3616, ORR, 0, 0, ret, arg, arg);
+        tcg_out_insn(s, qrrr_e, ORR, 0, 0, ret, arg, arg);
         break;
     case TCG_TYPE_V128:
         tcg_debug_assert(ret >= 32 && arg >= 32);
-        tcg_out_insn(s, 3616, ORR, 1, 0, ret, arg, arg);
+        tcg_out_insn(s, qrrr_e, ORR, 1, 0, ret, arg, arg);
         break;
 
     default:
@@ -1265,19 +1273,19 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
 
     switch (type) {
     case TCG_TYPE_I32:
-        insn = (ret < 32 ? I3312_LDRW : I3312_LDRVS);
+        insn = (ret < 32 ? Ildst_imm_LDRW : Ildst_imm_LDRVS);
         lgsz = 2;
         break;
     case TCG_TYPE_I64:
-        insn = (ret < 32 ? I3312_LDRX : I3312_LDRVD);
+        insn = (ret < 32 ? Ildst_imm_LDRX : Ildst_imm_LDRVD);
         lgsz = 3;
         break;
     case TCG_TYPE_V64:
-        insn = I3312_LDRVD;
+        insn = Ildst_imm_LDRVD;
         lgsz = 3;
         break;
     case TCG_TYPE_V128:
-        insn = I3312_LDRVQ;
+        insn = Ildst_imm_LDRVQ;
         lgsz = 4;
         break;
     default:
@@ -1294,19 +1302,19 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
 
     switch (type) {
     case TCG_TYPE_I32:
-        insn = (src < 32 ? I3312_STRW : I3312_STRVS);
+        insn = (src < 32 ? Ildst_imm_STRW : Ildst_imm_STRVS);
         lgsz = 2;
         break;
     case TCG_TYPE_I64:
-        insn = (src < 32 ? I3312_STRX : I3312_STRVD);
+        insn = (src < 32 ? Ildst_imm_STRX : Ildst_imm_STRVD);
         lgsz = 3;
         break;
     case TCG_TYPE_V64:
-        insn = I3312_STRVD;
+        insn = Ildst_imm_STRVD;
         lgsz = 3;
         break;
     case TCG_TYPE_V128:
-        insn = I3312_STRVQ;
+        insn = Ildst_imm_STRVQ;
         lgsz = 4;
         break;
     default:
@@ -1328,34 +1336,34 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static inline void tcg_out_bfm(TCGContext *s, TCGType ext, TCGReg rd,
                                TCGReg rn, unsigned int a, unsigned int b)
 {
-    tcg_out_insn(s, 3402, BFM, ext, rd, rn, ext, a, b);
+    tcg_out_insn(s, bitfield_32, BFM, ext, rd, rn, ext, a, b);
 }
 
 static inline void tcg_out_ubfm(TCGContext *s, TCGType ext, TCGReg rd,
                                 TCGReg rn, unsigned int a, unsigned int b)
 {
-    tcg_out_insn(s, 3402, UBFM, ext, rd, rn, ext, a, b);
+    tcg_out_insn(s, bitfield_32, UBFM, ext, rd, rn, ext, a, b);
 }
 
 static inline void tcg_out_sbfm(TCGContext *s, TCGType ext, TCGReg rd,
                                 TCGReg rn, unsigned int a, unsigned int b)
 {
-    tcg_out_insn(s, 3402, SBFM, ext, rd, rn, ext, a, b);
+    tcg_out_insn(s, bitfield_32, SBFM, ext, rd, rn, ext, a, b);
 }
 
 static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
                                 TCGReg rn, TCGReg rm, unsigned int a)
 {
-    tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
+    tcg_out_insn(s, extract, EXTR, ext, rd, rn, rm, a);
 }
 
 static void tgen_cmp(TCGContext *s, TCGType ext, TCGCond cond,
                      TCGReg a, TCGReg b)
 {
     if (is_tst_cond(cond)) {
-        tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
+        tcg_out_insn(s, logic_shift, ANDS, ext, TCG_REG_XZR, a, b);
     } else {
-        tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+        tcg_out_insn(s, addsub_shift, SUBS, ext, TCG_REG_XZR, a, b);
     }
 }
 
@@ -1363,13 +1371,13 @@ static void tgen_cmpi(TCGContext *s, TCGType ext, TCGCond cond,
                       TCGReg a, tcg_target_long b)
 {
     if (is_tst_cond(cond)) {
-        tcg_out_logicali(s, I3404_ANDSI, ext, TCG_REG_XZR, a, b);
+        tcg_out_logicali(s, Ilogic_imm_32_ANDSI, ext, TCG_REG_XZR, a, b);
     } else if (b >= 0) {
         tcg_debug_assert(is_aimm(b));
-        tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+        tcg_out_insn(s, addsub_imm, SUBSI, ext, TCG_REG_XZR, a, b);
     } else {
         tcg_debug_assert(is_aimm(-b));
-        tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+        tcg_out_insn(s, addsub_imm, ADDSI, ext, TCG_REG_XZR, a, -b);
     }
 }
 
@@ -1387,17 +1395,17 @@ static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
     tcg_debug_assert(offset == sextract64(offset, 0, 26));
-    tcg_out_insn(s, 3206, B, offset);
+    tcg_out_insn(s, branch, B, offset);
 }
 
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
     if (offset == sextract64(offset, 0, 26)) {
-        tcg_out_insn(s, 3206, BL, offset);
+        tcg_out_insn(s, branch, BL, offset);
     } else {
         tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
-        tcg_out_insn(s, 3207, BLR, TCG_REG_TMP0);
+        tcg_out_insn(s, bcond_reg, BLR, TCG_REG_TMP0);
     }
 }
 
@@ -1411,7 +1419,7 @@ static void tcg_out_br(TCGContext *s, TCGLabel *l)
 {
     if (!l->has_value) {
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_JUMP26, l, 0);
-        tcg_out_insn(s, 3206, B, 0);
+        tcg_out_insn(s, branch, B, 0);
     } else {
         tcg_out_goto(s, l->u.value_ptr);
     }
@@ -1422,7 +1430,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
 {
     tgen_cmp(s, type, c, a, b);
     tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-    tcg_out_insn(s, 3202, B_C, c, 0);
+    tcg_out_insn(s, bcond_imm, B_C, c, 0);
 }
 
 static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
@@ -1470,7 +1478,7 @@ static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
     if (need_cmp) {
         tgen_cmpi(s, ext, c, a, b);
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-        tcg_out_insn(s, 3202, B_C, c, 0);
+        tcg_out_insn(s, bcond_imm, B_C, c, 0);
         return;
     }
 
@@ -1478,10 +1486,10 @@ static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_TSTBR14, l, 0);
         switch (c) {
         case TCG_COND_TSTEQ:
-            tcg_out_insn(s, 3205, TBZ, a, tbit, 0);
+            tcg_out_insn(s, tbz, TBZ, a, tbit, 0);
             break;
         case TCG_COND_TSTNE:
-            tcg_out_insn(s, 3205, TBNZ, a, tbit, 0);
+            tcg_out_insn(s, tbz, TBNZ, a, tbit, 0);
             break;
         default:
             g_assert_not_reached();
@@ -1490,10 +1498,10 @@ static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
         switch (c) {
         case TCG_COND_EQ:
-            tcg_out_insn(s, 3201, CBZ, ext, a, 0);
+            tcg_out_insn(s, cbz, CBZ, ext, a, 0);
             break;
         case TCG_COND_NE:
-            tcg_out_insn(s, 3201, CBNZ, ext, a, 0);
+            tcg_out_insn(s, cbz, CBNZ, ext, a, 0);
             break;
         default:
             g_assert_not_reached();
@@ -1511,7 +1519,7 @@ static inline void tcg_out_rev(TCGContext *s, int ext, MemOp s_bits,
                                TCGReg rd, TCGReg rn)
 {
     /* REV, REV16, REV32 */
-    tcg_out_insn_3507(s, I3507_REV | (s_bits << 10), ext, rd, rn);
+    tcg_out_insn_rr_sf(s, Irr_sf_REV | (s_bits << 10), ext, rd, rn);
 }
 
 static inline void tcg_out_sxt(TCGContext *s, TCGType ext, MemOp s_bits,
@@ -1671,16 +1679,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Load CPUTLBDescFast.{mask,table} into {tmp0,tmp1}. */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
-        tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
+        tcg_out_insn(s, ldstpair, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
                      tlb_mask_table_ofs(s, mem_index), 1, 0);
 
         /* Extract the TLB index from the address into X0.  */
-        tcg_out_insn(s, 3502S, AND_LSR, TCG_TYPE_I64,
+        tcg_out_insn(s, addsub_realshift, AND_LSR, TCG_TYPE_I64,
                      TCG_REG_TMP0, TCG_REG_TMP0, addr_reg,
                      TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
 
         /* Add the tlb_table pointer, forming the CPUTLBEntry address. */
-        tcg_out_insn(s, 3502, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP0);
+        tcg_out_insn(s, addsub_shift, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1,
+                     TCG_REG_TMP0);
 
         /* Load the tlb comparator into TMP0, and the fast path addend. */
         QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
@@ -1700,13 +1709,13 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             addr_adj = addr_reg;
         } else {
             addr_adj = TCG_REG_TMP2;
-            tcg_out_insn(s, 3401, ADDI, addr_type,
+            tcg_out_insn(s, addsub_imm, ADDI, addr_type,
                          addr_adj, addr_reg, s_mask - a_mask);
         }
         compare_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
 
         /* Store the page mask part of the address into TMP2.  */
-        tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_TMP2,
+        tcg_out_logicali(s, Ilogic_imm_32_ANDI, addr_type, TCG_REG_TMP2,
                          addr_adj, compare_mask);
 
         /* Perform the address comparison. */
@@ -1714,7 +1723,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* If not equal, we jump to the slow path. */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
+        tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
 
         h->base = TCG_REG_TMP1;
         h->index = addr_reg;
@@ -1728,11 +1737,12 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst->addr_reg = addr_reg;
 
             /* tst addr, #mask */
-            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, addr_reg, a_mask);
+            tcg_out_logicali(s, Ilogic_imm_32_ANDSI, 0, TCG_REG_XZR, addr_reg,
+                             a_mask);
 
             /* b.ne slow_path */
             ldst->label_ptr[0] = s->code_ptr;
-            tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
+            tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
         }
 
         if (guest_base || addr_type == TCG_TYPE_I32) {
@@ -1754,27 +1764,28 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp memop, TCGType ext,
 {
     switch (memop & MO_SSIZE) {
     case MO_UB:
-        tcg_out_ldst_r(s, I3312_LDRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_LDRB, data_r, h.base, h.index_ext, h.index);
         break;
     case MO_SB:
-        tcg_out_ldst_r(s, ext ? I3312_LDRSBX : I3312_LDRSBW,
+        tcg_out_ldst_r(s, ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
                        data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UW:
-        tcg_out_ldst_r(s, I3312_LDRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_LDRH, data_r, h.base, h.index_ext, h.index);
         break;
     case MO_SW:
-        tcg_out_ldst_r(s, (ext ? I3312_LDRSHX : I3312_LDRSHW),
+        tcg_out_ldst_r(s, (ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW),
                        data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UL:
-        tcg_out_ldst_r(s, I3312_LDRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_LDRW, data_r, h.base, h.index_ext, h.index);
         break;
     case MO_SL:
-        tcg_out_ldst_r(s, I3312_LDRSWX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_LDRSWX, data_r, h.base, h.index_ext,
+                       h.index);
         break;
     case MO_UQ:
-        tcg_out_ldst_r(s, I3312_LDRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_LDRX, data_r, h.base, h.index_ext, h.index);
         break;
     default:
         g_assert_not_reached();
@@ -1786,16 +1797,16 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
 {
     switch (memop & MO_SIZE) {
     case MO_8:
-        tcg_out_ldst_r(s, I3312_STRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_STRB, data_r, h.base, h.index_ext, h.index);
         break;
     case MO_16:
-        tcg_out_ldst_r(s, I3312_STRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_STRH, data_r, h.base, h.index_ext, h.index);
         break;
     case MO_32:
-        tcg_out_ldst_r(s, I3312_STRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_STRW, data_r, h.base, h.index_ext, h.index);
         break;
     case MO_64:
-        tcg_out_ldst_r(s, I3312_STRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_ldst_r(s, Ildst_imm_STRX, data_r, h.base, h.index_ext, h.index);
         break;
     default:
         g_assert_not_reached();
@@ -1861,11 +1872,11 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
         base = TCG_REG_TMP2;
         if (h.index_ext == TCG_TYPE_I32) {
             /* add base, base, index, uxtw */
-            tcg_out_insn(s, 3501, ADD, TCG_TYPE_I64, base,
+            tcg_out_insn(s, addsub_ext, ADD, TCG_TYPE_I64, base,
                          h.base, h.index, MO_32, 0);
         } else {
             /* add base, base, index */
-            tcg_out_insn(s, 3502, ADD, 1, base, h.base, h.index);
+            tcg_out_insn(s, addsub_shift, ADD, 1, base, h.base, h.index);
         }
     }
 
@@ -1885,9 +1896,10 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
              * TODO: align should be MO_64, so we only need test bit 3,
              * which means we could use TBNZ instead of ANDS+B_C.
              */
-            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, addr_reg, 15);
+            tcg_out_logicali(s, Ilogic_imm_32_ANDSI, 0, TCG_REG_XZR, addr_reg,
+                             15);
             branch = s->code_ptr;
-            tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
+            tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
             use_pair = true;
         }
 
@@ -1919,22 +1931,22 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
             sh = datahi;
         }
 
-        tcg_out_insn(s, 3306, LDXP, TCG_REG_XZR, ll, lh, base);
-        tcg_out_insn(s, 3306, STXP, TCG_REG_TMP0, sl, sh, base);
-        tcg_out_insn(s, 3201, CBNZ, 0, TCG_REG_TMP0, -2);
+        tcg_out_insn(s, stxp, LDXP, TCG_REG_XZR, ll, lh, base);
+        tcg_out_insn(s, stxp, STXP, TCG_REG_TMP0, sl, sh, base);
+        tcg_out_insn(s, cbz, CBNZ, 0, TCG_REG_TMP0, -2);
 
         if (use_pair) {
             /* "b .+8", branching across the one insn of use_pair. */
-            tcg_out_insn(s, 3206, B, 2);
+            tcg_out_insn(s, branch, B, 2);
             reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
         }
     }
 
     if (use_pair) {
         if (is_ld) {
-            tcg_out_insn(s, 3314, LDP, datalo, datahi, base, 0, 1, 0);
+            tcg_out_insn(s, ldstpair, LDP, datalo, datahi, base, 0, 1, 0);
         } else {
-            tcg_out_insn(s, 3314, STP, datalo, datahi, base, 0, 1, 0);
+            tcg_out_insn(s, ldstpair, STP, datalo, datahi, base, 0, 1, 0);
         }
     }
 
@@ -1985,7 +1997,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 
     offset = tcg_pcrel_diff(s, target) >> 2;
     if (offset == sextract64(offset, 0, 26)) {
-        tcg_out_insn(s, 3206, B, offset);
+        tcg_out_insn(s, branch, B, offset);
     } else {
         /*
          * Only x16/x17 generate BTI type Jump (2),
@@ -1993,7 +2005,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
          */
         QEMU_BUILD_BUG_ON(TCG_REG_TMP0 != TCG_REG_X16);
         tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
-        tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
+        tcg_out_insn(s, bcond_reg, BR, TCG_REG_TMP0);
     }
 }
 
@@ -2008,15 +2020,15 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     tcg_debug_assert(i_off == sextract64(i_off, 0, 21));
 
     set_jmp_insn_offset(s, which);
-    tcg_out32(s, I3206_B);
-    tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
+    tcg_out32(s, Ibranch_B);
+    tcg_out_insn(s, bcond_reg, BR, TCG_REG_TMP0);
     set_jmp_reset_offset(s, which);
     tcg_out_bti(s, BTI_J);
 }
 
 static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
 {
-    tcg_out_insn(s, 3207, BR, a0);
+    tcg_out_insn(s, bcond_reg, BR, a0);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -2028,13 +2040,13 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 
     /* Either directly branch, or indirect branch load. */
     if (d_offset == sextract64(d_offset, 0, 28)) {
-        insn = deposit32(I3206_B, 0, 26, d_offset >> 2);
+        insn = deposit32(Ibranch_B, 0, 26, d_offset >> 2);
     } else {
         uintptr_t i_addr = (uintptr_t)&tb->jmp_target_addr[n];
         ptrdiff_t i_offset = i_addr - jmp_rx;
 
         /* Note that we asserted this in range in tcg_out_goto_tb. */
-        insn = deposit32(I3305_LDR | TCG_REG_TMP0, 5, 19, i_offset >> 2);
+        insn = deposit32(Ildlit_LDR | TCG_REG_TMP0, 5, 19, i_offset >> 2);
     }
     qatomic_set((uint32_t *)jmp_rw, insn);
     flush_idcache_range(jmp_rx, jmp_rw, 4);
@@ -2044,16 +2056,16 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 static void tgen_add(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3502, ADD, type, a0, a1, a2);
+    tcg_out_insn(s, addsub_shift, ADD, type, a0, a1, a2);
 }
 
 static void tgen_addi(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
     if (a2 >= 0) {
-        tcg_out_insn(s, 3401, ADDI, type, a0, a1, a2);
+        tcg_out_insn(s, addsub_imm, ADDI, type, a0, a1, a2);
     } else {
-        tcg_out_insn(s, 3401, SUBI, type, a0, a1, -a2);
+        tcg_out_insn(s, addsub_imm, SUBI, type, a0, a1, -a2);
     }
 }
 
@@ -2066,16 +2078,16 @@ static const TCGOutOpBinary outop_add = {
 static void tgen_addco(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3502, ADDS, type, a0, a1, a2);
+    tcg_out_insn(s, addsub_shift, ADDS, type, a0, a1, a2);
 }
 
 static void tgen_addco_imm(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
     if (a2 >= 0) {
-        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, a2);
+        tcg_out_insn(s, addsub_imm, ADDSI, type, a0, a1, a2);
     } else {
-        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, -a2);
+        tcg_out_insn(s, addsub_imm, SUBSI, type, a0, a1, -a2);
     }
 }
 
@@ -2088,7 +2100,7 @@ static const TCGOutOpBinary outop_addco = {
 static void tgen_addci_rrr(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3503, ADC, type, a0, a1, a2);
+    tcg_out_insn(s, rrr_sf, ADC, type, a0, a1, a2);
 }
 
 static void tgen_addci_rri(TCGContext *s, TCGType type,
@@ -2099,9 +2111,9 @@ static void tgen_addci_rri(TCGContext *s, TCGType type,
      * that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.
      */
     if (a2) {
-        tcg_out_insn(s, 3503, SBC, type, a0, a1, TCG_REG_XZR);
+        tcg_out_insn(s, rrr_sf, SBC, type, a0, a1, TCG_REG_XZR);
     } else {
-        tcg_out_insn(s, 3503, ADC, type, a0, a1, TCG_REG_XZR);
+        tcg_out_insn(s, rrr_sf, ADC, type, a0, a1, TCG_REG_XZR);
     }
 }
 
@@ -2114,7 +2126,7 @@ static const TCGOutOpAddSubCarry outop_addci = {
 static void tgen_addcio(TCGContext *s, TCGType type,
                         TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3503, ADCS, type, a0, a1, a2);
+    tcg_out_insn(s, rrr_sf, ADCS, type, a0, a1, a2);
 }
 
 static void tgen_addcio_imm(TCGContext *s, TCGType type,
@@ -2122,9 +2134,9 @@ static void tgen_addcio_imm(TCGContext *s, TCGType type,
 {
     /* Use SBCS w/0 for ADCS w/-1 -- see above. */
     if (a2) {
-        tcg_out_insn(s, 3503, SBCS, type, a0, a1, TCG_REG_XZR);
+        tcg_out_insn(s, rrr_sf, SBCS, type, a0, a1, TCG_REG_XZR);
     } else {
-        tcg_out_insn(s, 3503, ADCS, type, a0, a1, TCG_REG_XZR);
+        tcg_out_insn(s, rrr_sf, ADCS, type, a0, a1, TCG_REG_XZR);
     }
 }
 
@@ -2136,20 +2148,20 @@ static const TCGOutOpBinary outop_addcio = {
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    tcg_out_insn(s, 3502, SUBS, TCG_TYPE_I32,
+    tcg_out_insn(s, addsub_shift, SUBS, TCG_TYPE_I32,
                  TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3510, AND, type, a0, a1, a2);
+    tcg_out_insn(s, logic_shift, AND, type, a0, a1, a2);
 }
 
 static void tgen_andi(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
-    tcg_out_logicali(s, I3404_ANDI, type, a0, a1, a2);
+    tcg_out_logicali(s, Ilogic_imm_32_ANDI, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_and = {
@@ -2161,7 +2173,7 @@ static const TCGOutOpBinary outop_and = {
 static void tgen_andc(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3510, BIC, type, a0, a1, a2);
+    tcg_out_insn(s, logic_shift, BIC, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_andc = {
@@ -2173,31 +2185,31 @@ static void tgen_clz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_cmp(s, type, TCG_COND_NE, a1, 0, true);
-    tcg_out_insn(s, 3507, CLZ, type, TCG_REG_TMP0, a1);
-    tcg_out_insn(s, 3506, CSEL, type, a0, TCG_REG_TMP0, a2, TCG_COND_NE);
+    tcg_out_insn(s, rr_sf, CLZ, type, TCG_REG_TMP0, a1);
+    tcg_out_insn(s, csel, CSEL, type, a0, TCG_REG_TMP0, a2, TCG_COND_NE);
 }
 
 static void tgen_clzi(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
     if (a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
-        tcg_out_insn(s, 3507, CLZ, type, a0, a1);
+        tcg_out_insn(s, rr_sf, CLZ, type, a0, a1);
         return;
     }
 
     tcg_out_cmp(s, type, TCG_COND_NE, a1, 0, true);
-    tcg_out_insn(s, 3507, CLZ, type, a0, a1);
+    tcg_out_insn(s, rr_sf, CLZ, type, a0, a1);
 
     switch (a2) {
     case -1:
-        tcg_out_insn(s, 3506, CSINV, type, a0, a0, TCG_REG_XZR, TCG_COND_NE);
+        tcg_out_insn(s, csel, CSINV, type, a0, a0, TCG_REG_XZR, TCG_COND_NE);
         break;
     case 0:
-        tcg_out_insn(s, 3506, CSEL, type, a0, a0, TCG_REG_XZR, TCG_COND_NE);
+        tcg_out_insn(s, csel, CSEL, type, a0, a0, TCG_REG_XZR, TCG_COND_NE);
         break;
     default:
         tcg_out_movi(s, type, TCG_REG_TMP0, a2);
-        tcg_out_insn(s, 3506, CSEL, type, a0, a0, TCG_REG_TMP0, TCG_COND_NE);
+        tcg_out_insn(s, csel, CSEL, type, a0, a0, TCG_REG_TMP0, TCG_COND_NE);
         break;
     }
 }
@@ -2215,14 +2227,14 @@ static const TCGOutOpUnary outop_ctpop = {
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3507, RBIT, type, TCG_REG_TMP0, a1);
+    tcg_out_insn(s, rr_sf, RBIT, type, TCG_REG_TMP0, a1);
     tgen_clz(s, type, a0, TCG_REG_TMP0, a2);
 }
 
 static void tgen_ctzi(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
-    tcg_out_insn(s, 3507, RBIT, type, TCG_REG_TMP0, a1);
+    tcg_out_insn(s, rr_sf, RBIT, type, TCG_REG_TMP0, a1);
     tgen_clzi(s, type, a0, TCG_REG_TMP0, a2);
 }
 
@@ -2235,7 +2247,7 @@ static const TCGOutOpBinary outop_ctz = {
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, SDIV, type, a0, a1, a2);
+    tcg_out_insn(s, rrr, SDIV, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_divs = {
@@ -2250,7 +2262,7 @@ static const TCGOutOpDivRem outop_divs2 = {
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, UDIV, type, a0, a1, a2);
+    tcg_out_insn(s, rrr, UDIV, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_divu = {
@@ -2265,7 +2277,7 @@ static const TCGOutOpDivRem outop_divu2 = {
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3510, EON, type, a0, a1, a2);
+    tcg_out_insn(s, logic_shift, EON, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_eqv = {
@@ -2286,7 +2298,7 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3509, MADD, type, a0, a1, a2, TCG_REG_XZR);
+    tcg_out_insn(s, rrrr, MADD, type, a0, a1, a2, TCG_REG_XZR);
 }
 
 static const TCGOutOpBinary outop_mul = {
@@ -2306,7 +2318,7 @@ static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
 static void tgen_mulsh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, SMULH, TCG_TYPE_I64, a0, a1, a2);
+    tcg_out_insn(s, rrr, SMULH, TCG_TYPE_I64, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_mulsh = {
@@ -2322,7 +2334,7 @@ static const TCGOutOpMul2 outop_mulu2 = {
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, UMULH, TCG_TYPE_I64, a0, a1, a2);
+    tcg_out_insn(s, rrr, UMULH, TCG_TYPE_I64, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_muluh = {
@@ -2342,13 +2354,13 @@ static const TCGOutOpBinary outop_nor = {
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3510, ORR, type, a0, a1, a2);
+    tcg_out_insn(s, logic_shift, ORR, type, a0, a1, a2);
 }
 
 static void tgen_ori(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
-    tcg_out_logicali(s, I3404_ORRI, type, a0, a1, a2);
+    tcg_out_logicali(s, Ilogic_imm_32_ORRI, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_or = {
@@ -2360,7 +2372,7 @@ static const TCGOutOpBinary outop_or = {
 static void tgen_orc(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3510, ORN, type, a0, a1, a2);
+    tcg_out_insn(s, logic_shift, ORN, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_orc = {
@@ -2371,8 +2383,8 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_rems(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, SDIV, type, TCG_REG_TMP0, a1, a2);
-    tcg_out_insn(s, 3509, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
+    tcg_out_insn(s, rrr, SDIV, type, TCG_REG_TMP0, a1, a2);
+    tcg_out_insn(s, rrrr, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
 }
 
 static const TCGOutOpBinary outop_rems = {
@@ -2383,8 +2395,8 @@ static const TCGOutOpBinary outop_rems = {
 static void tgen_remu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, UDIV, type, TCG_REG_TMP0, a1, a2);
-    tcg_out_insn(s, 3509, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
+    tcg_out_insn(s, rrr, UDIV, type, TCG_REG_TMP0, a1, a2);
+    tcg_out_insn(s, rrrr, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
 }
 
 static const TCGOutOpBinary outop_remu = {
@@ -2399,7 +2411,7 @@ static const TCGOutOpBinary outop_rotl = {
 static void tgen_rotr(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, RORV, type, a0, a1, a2);
+    tcg_out_insn(s, rrr, RORV, type, a0, a1, a2);
 }
 
 static void tgen_rotri(TCGContext *s, TCGType type,
@@ -2418,7 +2430,7 @@ static const TCGOutOpBinary outop_rotr = {
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, ASRV, type, a0, a1, a2);
+    tcg_out_insn(s, rrr, ASRV, type, a0, a1, a2);
 }
 
 static void tgen_sari(TCGContext *s, TCGType type,
@@ -2437,7 +2449,7 @@ static const TCGOutOpBinary outop_sar = {
 static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, LSLV, type, a0, a1, a2);
+    tcg_out_insn(s, rrr, LSLV, type, a0, a1, a2);
 }
 
 static void tgen_shli(TCGContext *s, TCGType type,
@@ -2456,7 +2468,7 @@ static const TCGOutOpBinary outop_shl = {
 static void tgen_shr(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3508, LSRV, type, a0, a1, a2);
+    tcg_out_insn(s, rrr, LSRV, type, a0, a1, a2);
 }
 
 static void tgen_shri(TCGContext *s, TCGType type,
@@ -2475,7 +2487,7 @@ static const TCGOutOpBinary outop_shr = {
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3502, SUB, type, a0, a1, a2);
+    tcg_out_insn(s, addsub_shift, SUB, type, a0, a1, a2);
 }
 
 static const TCGOutOpSubtract outop_sub = {
@@ -2486,16 +2498,16 @@ static const TCGOutOpSubtract outop_sub = {
 static void tgen_subbo_rrr(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3502, SUBS, type, a0, a1, a2);
+    tcg_out_insn(s, addsub_shift, SUBS, type, a0, a1, a2);
 }
 
 static void tgen_subbo_rri(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
     if (a2 >= 0) {
-        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, a2);
+        tcg_out_insn(s, addsub_imm, SUBSI, type, a0, a1, a2);
     } else {
-        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, -a2);
+        tcg_out_insn(s, addsub_imm, ADDSI, type, a0, a1, -a2);
     }
 }
 
@@ -2535,7 +2547,7 @@ static const TCGOutOpAddSubCarry outop_subbo = {
 static void tgen_subbi_rrr(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3503, SBC, type, a0, a1, a2);
+    tcg_out_insn(s, rrr_sf, SBC, type, a0, a1, a2);
 }
 
 static void tgen_subbi_rri(TCGContext *s, TCGType type,
@@ -2553,7 +2565,7 @@ static const TCGOutOpAddSubCarry outop_subbi = {
 static void tgen_subbio_rrr(TCGContext *s, TCGType type,
                             TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3503, SBCS, type, a0, a1, a2);
+    tcg_out_insn(s, rrr_sf, SBCS, type, a0, a1, a2);
 }
 
 static void tgen_subbio_rri(TCGContext *s, TCGType type,
@@ -2570,20 +2582,20 @@ static const TCGOutOpAddSubCarry outop_subbio = {
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    tcg_out_insn(s, 3502, ADDS, TCG_TYPE_I32,
+    tcg_out_insn(s, addsub_shift, ADDS, TCG_TYPE_I32,
                  TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, 3510, EOR, type, a0, a1, a2);
+    tcg_out_insn(s, logic_shift, EOR, type, a0, a1, a2);
 }
 
 static void tgen_xori(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
-    tcg_out_logicali(s, I3404_EORI, type, a0, a1, a2);
+    tcg_out_logicali(s, Ilogic_imm_32_EORI, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_xor = {
@@ -2657,7 +2669,7 @@ static const TCGOutOpUnary outop_not = {
 static void tgen_cset(TCGContext *s, TCGCond cond, TCGReg ret)
 {
     /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
-    tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, ret, TCG_REG_XZR,
+    tcg_out_insn(s, csel, CSINC, TCG_TYPE_I32, ret, TCG_REG_XZR,
                  TCG_REG_XZR, tcg_invert_cond(cond));
 }
 
@@ -2684,7 +2696,7 @@ static const TCGOutOpSetcond outop_setcond = {
 static void tgen_csetm(TCGContext *s, TCGType ext, TCGCond cond, TCGReg ret)
 {
     /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
-    tcg_out_insn(s, 3506, CSINV, ext, ret, TCG_REG_XZR,
+    tcg_out_insn(s, csel, CSINV, ext, ret, TCG_REG_XZR,
                  TCG_REG_XZR, tcg_invert_cond(cond));
 }
 
@@ -2713,7 +2725,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
                          TCGArg vt, bool const_vt, TCGArg vf, bool const_vf)
 {
     tcg_out_cmp(s, type, cond, c1, c2, const_c2);
-    tcg_out_insn(s, 3506, CSEL, type, ret, vt, vf, cond);
+    tcg_out_insn(s, csel, CSEL, type, ret, vt, vf, cond);
 }
 
 static const TCGOutOpMovcond outop_movcond = {
@@ -2765,7 +2777,7 @@ static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
 {
     if (ofs == 0) {
         uint64_t mask = MAKE_64BIT_MASK(0, len);
-        tcg_out_logicali(s, I3404_ANDI, type, a0, a1, mask);
+        tcg_out_logicali(s, Ilogic_imm_32_ANDI, type, a0, a1, mask);
     } else {
         tcg_out_ubfm(s, type, a0, a1, ofs, ofs + len - 1);
     }
@@ -2801,7 +2813,7 @@ static const TCGOutOpExtract2 outop_extract2 = {
 static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, I3312_LDRB, dest, base, offset, 0);
+    tcg_out_ldst(s, Ildst_imm_LDRB, dest, base, offset, 0);
 }
 
 static const TCGOutOpLoad outop_ld8u = {
@@ -2812,7 +2824,8 @@ static const TCGOutOpLoad outop_ld8u = {
 static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
-    AArch64Insn insn = type == TCG_TYPE_I32 ? I3312_LDRSBW : I3312_LDRSBX;
+    AArch64Insn insn = type == TCG_TYPE_I32 ? Ildst_imm_LDRSBW
+                                            : Ildst_imm_LDRSBX;
     tcg_out_ldst(s, insn, dest, base, offset, 0);
 }
 
@@ -2824,7 +2837,7 @@ static const TCGOutOpLoad outop_ld8s = {
 static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, I3312_LDRH, dest, base, offset, 1);
+    tcg_out_ldst(s, Ildst_imm_LDRH, dest, base, offset, 1);
 }
 
 static const TCGOutOpLoad outop_ld16u = {
@@ -2835,7 +2848,8 @@ static const TCGOutOpLoad outop_ld16u = {
 static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    AArch64Insn insn = type == TCG_TYPE_I32 ? I3312_LDRSHW : I3312_LDRSHX;
+    AArch64Insn insn = type == TCG_TYPE_I32 ? Ildst_imm_LDRSHW
+                                            : Ildst_imm_LDRSHX;
     tcg_out_ldst(s, insn, dest, base, offset, 1);
 }
 
@@ -2847,7 +2861,7 @@ static const TCGOutOpLoad outop_ld16s = {
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, I3312_LDRW, dest, base, offset, 2);
+    tcg_out_ldst(s, Ildst_imm_LDRW, dest, base, offset, 2);
 }
 
 static const TCGOutOpLoad outop_ld32u = {
@@ -2858,7 +2872,7 @@ static const TCGOutOpLoad outop_ld32u = {
 static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, I3312_LDRSWX, dest, base, offset, 2);
+    tcg_out_ldst(s, Ildst_imm_LDRSWX, dest, base, offset, 2);
 }
 
 static const TCGOutOpLoad outop_ld32s = {
@@ -2869,7 +2883,7 @@ static const TCGOutOpLoad outop_ld32s = {
 static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, I3312_STRB, data, base, offset, 0);
+    tcg_out_ldst(s, Ildst_imm_STRB, data, base, offset, 0);
 }
 
 static const TCGOutOpStore outop_st8 = {
@@ -2880,7 +2894,7 @@ static const TCGOutOpStore outop_st8 = {
 static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
                         TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, I3312_STRH, data, base, offset, 1);
+    tcg_out_ldst(s, Ildst_imm_STRH, data, base, offset, 1);
 }
 
 static const TCGOutOpStore outop_st16 = {
@@ -2899,32 +2913,32 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const int const_args[TCG_MAX_OP_ARGS])
 {
     static const AArch64Insn cmp_vec_insn[16] = {
-        [TCG_COND_EQ] = I3616_CMEQ,
-        [TCG_COND_GT] = I3616_CMGT,
-        [TCG_COND_GE] = I3616_CMGE,
-        [TCG_COND_GTU] = I3616_CMHI,
-        [TCG_COND_GEU] = I3616_CMHS,
+        [TCG_COND_EQ] = Iqrrr_e_CMEQ,
+        [TCG_COND_GT] = Iqrrr_e_CMGT,
+        [TCG_COND_GE] = Iqrrr_e_CMGE,
+        [TCG_COND_GTU] = Iqrrr_e_CMHI,
+        [TCG_COND_GEU] = Iqrrr_e_CMHS,
     };
     static const AArch64Insn cmp_scalar_insn[16] = {
-        [TCG_COND_EQ] = I3611_CMEQ,
-        [TCG_COND_GT] = I3611_CMGT,
-        [TCG_COND_GE] = I3611_CMGE,
-        [TCG_COND_GTU] = I3611_CMHI,
-        [TCG_COND_GEU] = I3611_CMHS,
+        [TCG_COND_EQ] = Irrr_e_CMEQ,
+        [TCG_COND_GT] = Irrr_e_CMGT,
+        [TCG_COND_GE] = Irrr_e_CMGE,
+        [TCG_COND_GTU] = Irrr_e_CMHI,
+        [TCG_COND_GEU] = Irrr_e_CMHS,
     };
     static const AArch64Insn cmp0_vec_insn[16] = {
-        [TCG_COND_EQ] = I3617_CMEQ0,
-        [TCG_COND_GT] = I3617_CMGT0,
-        [TCG_COND_GE] = I3617_CMGE0,
-        [TCG_COND_LT] = I3617_CMLT0,
-        [TCG_COND_LE] = I3617_CMLE0,
+        [TCG_COND_EQ] = Iqrr_e_CMEQ0,
+        [TCG_COND_GT] = Iqrr_e_CMGT0,
+        [TCG_COND_GE] = Iqrr_e_CMGE0,
+        [TCG_COND_LT] = Iqrr_e_CMLT0,
+        [TCG_COND_LE] = Iqrr_e_CMLE0,
     };
     static const AArch64Insn cmp0_scalar_insn[16] = {
-        [TCG_COND_EQ] = I3612_CMEQ0,
-        [TCG_COND_GT] = I3612_CMGT0,
-        [TCG_COND_GE] = I3612_CMGE0,
-        [TCG_COND_LT] = I3612_CMLT0,
-        [TCG_COND_LE] = I3612_CMLE0,
+        [TCG_COND_EQ] = Isimd_rr_CMEQ0,
+        [TCG_COND_GT] = Isimd_rr_CMGT0,
+        [TCG_COND_GE] = Isimd_rr_CMGE0,
+        [TCG_COND_LT] = Isimd_rr_CMLT0,
+        [TCG_COND_LE] = Isimd_rr_CMLE0,
     };
 
     TCGType type = vecl + TCG_TYPE_V64;
@@ -2949,169 +2963,173 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_add_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, ADD, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, ADD, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, ADD, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, ADD, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_sub_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, SUB, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, SUB, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, SUB, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, SUB, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_mul_vec:
-        tcg_out_insn(s, 3616, MUL, is_q, vece, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, MUL, is_q, vece, a0, a1, a2);
         break;
     case INDEX_op_neg_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3612, NEG, vece, a0, a1);
+            tcg_out_insn(s, simd_rr, NEG, vece, a0, a1);
         } else {
-            tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
+            tcg_out_insn(s, qrr_e, NEG, is_q, vece, a0, a1);
         }
         break;
     case INDEX_op_abs_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3612, ABS, vece, a0, a1);
+            tcg_out_insn(s, simd_rr, ABS, vece, a0, a1);
         } else {
-            tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
+            tcg_out_insn(s, qrr_e, ABS, is_q, vece, a0, a1);
         }
         break;
     case INDEX_op_and_vec:
         if (const_args[2]) {
             is_shimm1632(~a2, &cmode, &imm8);
             if (a0 == a1) {
-                tcg_out_insn(s, 3606, BIC, is_q, a0, 0, cmode, imm8);
+                tcg_out_insn(s, simd_imm, BIC, is_q, a0, 0, cmode, imm8);
                 return;
             }
-            tcg_out_insn(s, 3606, MVNI, is_q, a0, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MVNI, is_q, a0, 0, cmode, imm8);
             a2 = a0;
         }
-        tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, AND, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_or_vec:
         if (const_args[2]) {
             is_shimm1632(a2, &cmode, &imm8);
             if (a0 == a1) {
-                tcg_out_insn(s, 3606, ORR, is_q, a0, 0, cmode, imm8);
+                tcg_out_insn(s, simd_imm, ORR, is_q, a0, 0, cmode, imm8);
                 return;
             }
-            tcg_out_insn(s, 3606, MOVI, is_q, a0, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MOVI, is_q, a0, 0, cmode, imm8);
             a2 = a0;
         }
-        tcg_out_insn(s, 3616, ORR, is_q, 0, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, ORR, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_andc_vec:
         if (const_args[2]) {
             is_shimm1632(a2, &cmode, &imm8);
             if (a0 == a1) {
-                tcg_out_insn(s, 3606, BIC, is_q, a0, 0, cmode, imm8);
+                tcg_out_insn(s, simd_imm, BIC, is_q, a0, 0, cmode, imm8);
                 return;
             }
-            tcg_out_insn(s, 3606, MOVI, is_q, a0, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MOVI, is_q, a0, 0, cmode, imm8);
             a2 = a0;
         }
-        tcg_out_insn(s, 3616, BIC, is_q, 0, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, BIC, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_orc_vec:
         if (const_args[2]) {
             is_shimm1632(~a2, &cmode, &imm8);
             if (a0 == a1) {
-                tcg_out_insn(s, 3606, ORR, is_q, a0, 0, cmode, imm8);
+                tcg_out_insn(s, simd_imm, ORR, is_q, a0, 0, cmode, imm8);
                 return;
             }
-            tcg_out_insn(s, 3606, MVNI, is_q, a0, 0, cmode, imm8);
+            tcg_out_insn(s, simd_imm, MVNI, is_q, a0, 0, cmode, imm8);
             a2 = a0;
         }
-        tcg_out_insn(s, 3616, ORN, is_q, 0, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, ORN, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_xor_vec:
-        tcg_out_insn(s, 3616, EOR, is_q, 0, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, EOR, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_ssadd_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, SQADD, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, SQADD, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, SQADD, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, SQADD, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_sssub_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, SQSUB, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, SQSUB, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, SQSUB, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, SQSUB, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_usadd_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, UQADD, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, UQADD, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, UQADD, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, UQADD, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_ussub_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, UQSUB, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, UQSUB, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, UQSUB, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, UQSUB, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_smax_vec:
-        tcg_out_insn(s, 3616, SMAX, is_q, vece, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, SMAX, is_q, vece, a0, a1, a2);
         break;
     case INDEX_op_smin_vec:
-        tcg_out_insn(s, 3616, SMIN, is_q, vece, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, SMIN, is_q, vece, a0, a1, a2);
         break;
     case INDEX_op_umax_vec:
-        tcg_out_insn(s, 3616, UMAX, is_q, vece, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, UMAX, is_q, vece, a0, a1, a2);
         break;
     case INDEX_op_umin_vec:
-        tcg_out_insn(s, 3616, UMIN, is_q, vece, a0, a1, a2);
+        tcg_out_insn(s, qrrr_e, UMIN, is_q, vece, a0, a1, a2);
         break;
     case INDEX_op_not_vec:
-        tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
+        tcg_out_insn(s, qrr_e, NOT, is_q, 0, a0, a1);
         break;
     case INDEX_op_shli_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3609, SHL, a0, a1, a2 + (8 << vece));
+            tcg_out_insn(s, q_shift, SHL, a0, a1, a2 + (8 << vece));
         } else {
-            tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
+            tcg_out_insn(s, simd_shift_imm, SHL, is_q, a0, a1,
+                         a2 + (8 << vece));
         }
         break;
     case INDEX_op_shri_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3609, USHR, a0, a1, (16 << vece) - a2);
+            tcg_out_insn(s, q_shift, USHR, a0, a1, (16 << vece) - a2);
         } else {
-            tcg_out_insn(s, 3614, USHR, is_q, a0, a1, (16 << vece) - a2);
+            tcg_out_insn(s, simd_shift_imm, USHR, is_q, a0, a1,
+                         (16 << vece) - a2);
         }
         break;
     case INDEX_op_sari_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3609, SSHR, a0, a1, (16 << vece) - a2);
+            tcg_out_insn(s, q_shift, SSHR, a0, a1, (16 << vece) - a2);
         } else {
-            tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
+            tcg_out_insn(s, simd_shift_imm, SSHR, is_q, a0, a1,
+                         (16 << vece) - a2);
         }
         break;
     case INDEX_op_aa64_sli_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3609, SLI, a0, a2, args[3] + (8 << vece));
+            tcg_out_insn(s, q_shift, SLI, a0, a2, args[3] + (8 << vece));
         } else {
-            tcg_out_insn(s, 3614, SLI, is_q, a0, a2, args[3] + (8 << vece));
+            tcg_out_insn(s, simd_shift_imm, SLI, is_q, a0, a2,
+                         args[3] + (8 << vece));
         }
         break;
     case INDEX_op_shlv_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, USHL, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, USHL, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, USHL, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, USHL, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_aa64_sshl_vec:
         if (is_scalar) {
-            tcg_out_insn(s, 3611, SSHL, vece, a0, a1, a2);
+            tcg_out_insn(s, rrr_e, SSHL, vece, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3616, SSHL, is_q, vece, a0, a1, a2);
+            tcg_out_insn(s, qrrr_e, SSHL, is_q, vece, a0, a1, a2);
         }
         break;
     case INDEX_op_cmp_vec:
@@ -3123,17 +3141,17 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             case TCG_COND_NE:
                 if (const_args[2]) {
                     if (is_scalar) {
-                        tcg_out_insn(s, 3611, CMTST, vece, a0, a1, a1);
+                        tcg_out_insn(s, rrr_e, CMTST, vece, a0, a1, a1);
                     } else {
-                        tcg_out_insn(s, 3616, CMTST, is_q, vece, a0, a1, a1);
+                        tcg_out_insn(s, qrrr_e, CMTST, is_q, vece, a0, a1, a1);
                     }
                 } else {
                     if (is_scalar) {
-                        tcg_out_insn(s, 3611, CMEQ, vece, a0, a1, a2);
+                        tcg_out_insn(s, rrr_e, CMEQ, vece, a0, a1, a2);
                     } else {
-                        tcg_out_insn(s, 3616, CMEQ, is_q, vece, a0, a1, a2);
+                        tcg_out_insn(s, qrrr_e, CMEQ, is_q, vece, a0, a1, a2);
                     }
-                    tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
+                    tcg_out_insn(s, qrr_e, NOT, is_q, 0, a0, a0);
                 }
                 break;
 
@@ -3146,12 +3164,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     break;
                 }
                 if (is_scalar) {
-                    tcg_out_insn(s, 3611, CMTST, vece, a0, a1, a2);
+                    tcg_out_insn(s, rrr_e, CMTST, vece, a0, a1, a2);
                 } else {
-                    tcg_out_insn(s, 3616, CMTST, is_q, vece, a0, a1, a2);
+                    tcg_out_insn(s, qrrr_e, CMTST, is_q, vece, a0, a1, a2);
                 }
                 if (cond == TCG_COND_TSTEQ) {
-                    tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
+                    tcg_out_insn(s, qrr_e, NOT, is_q, 0, a0, a0);
                 }
                 break;
 
@@ -3160,13 +3178,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     if (is_scalar) {
                         insn = cmp0_scalar_insn[cond];
                         if (insn) {
-                            tcg_out_insn_3612(s, insn, vece, a0, a1);
+                            tcg_out_insn_simd_rr(s, insn, vece, a0, a1);
                             break;
                         }
                     } else {
                         insn = cmp0_vec_insn[cond];
                         if (insn) {
-                            tcg_out_insn_3617(s, insn, is_q, vece, a0, a1);
+                            tcg_out_insn_qrr_e(s, insn, is_q, vece, a0, a1);
                             break;
                         }
                     }
@@ -3182,7 +3200,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                         insn = cmp_scalar_insn[cond];
                         tcg_debug_assert(insn != 0);
                     }
-                    tcg_out_insn_3611(s, insn, vece, a0, a1, a2);
+                    tcg_out_insn_rrr_e(s, insn, vece, a0, a1, a2);
                 } else {
                     insn = cmp_vec_insn[cond];
                     if (insn == 0) {
@@ -3192,7 +3210,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                         insn = cmp_vec_insn[cond];
                         tcg_debug_assert(insn != 0);
                     }
-                    tcg_out_insn_3616(s, insn, is_q, vece, a0, a1, a2);
+                    tcg_out_insn_qrrr_e(s, insn, is_q, vece, a0, a1, a2);
                 }
                 break;
             }
@@ -3202,14 +3220,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_bitsel_vec:
         a3 = args[3];
         if (a0 == a3) {
-            tcg_out_insn(s, 3616, BIT, is_q, 0, a0, a2, a1);
+            tcg_out_insn(s, qrrr_e, BIT, is_q, 0, a0, a2, a1);
         } else if (a0 == a2) {
-            tcg_out_insn(s, 3616, BIF, is_q, 0, a0, a3, a1);
+            tcg_out_insn(s, qrrr_e, BIF, is_q, 0, a0, a3, a1);
         } else {
             if (a0 != a1) {
                 tcg_out_mov(s, type, a0, a1);
             }
-            tcg_out_insn(s, 3616, BSL, is_q, 0, a0, a2, a3);
+            tcg_out_insn(s, qrrr_e, BSL, is_q, 0, a0, a2, a3);
         }
         break;
 
@@ -3447,7 +3465,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_bti(s, BTI_C);
 
     /* Push (FP, LR) and allocate space for all saved registers.  */
-    tcg_out_insn(s, 3314, STP, TCG_REG_FP, TCG_REG_LR,
+    tcg_out_insn(s, ldstpair, STP, TCG_REG_FP, TCG_REG_LR,
                  TCG_REG_SP, -PUSH_SIZE, 1, 1);
 
     /* Set up frame pointer for canonical unwinding.  */
@@ -3456,11 +3474,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /* Store callee-preserved regs x19..x28.  */
     for (r = TCG_REG_X19; r <= TCG_REG_X27; r += 2) {
         int ofs = (r - TCG_REG_X19 + 2) * 8;
-        tcg_out_insn(s, 3314, STP, r, r + 1, TCG_REG_SP, ofs, 1, 0);
+        tcg_out_insn(s, ldstpair, STP, r, r + 1, TCG_REG_SP, ofs, 1, 0);
     }
 
     /* Make stack space for TCG locals.  */
-    tcg_out_insn(s, 3401, SUBI, TCG_TYPE_I64, TCG_REG_SP, TCG_REG_SP,
+    tcg_out_insn(s, addsub_imm, SUBI, TCG_TYPE_I64, TCG_REG_SP, TCG_REG_SP,
                  FRAME_SIZE - PUSH_SIZE);
 
     /* Inform TCG about how to find TCG locals with register, offset, size.  */
@@ -3479,7 +3497,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-    tcg_out_insn(s, 3207, BR, tcg_target_call_iarg_regs[1]);
+    tcg_out_insn(s, bcond_reg, BR, tcg_target_call_iarg_regs[1]);
 
     /*
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
@@ -3494,19 +3512,19 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_bti(s, BTI_J);
 
     /* Remove TCG locals stack space.  */
-    tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_SP, TCG_REG_SP,
+    tcg_out_insn(s, addsub_imm, ADDI, TCG_TYPE_I64, TCG_REG_SP, TCG_REG_SP,
                  FRAME_SIZE - PUSH_SIZE);
 
     /* Restore registers x19..x28.  */
     for (r = TCG_REG_X19; r <= TCG_REG_X27; r += 2) {
         int ofs = (r - TCG_REG_X19 + 2) * 8;
-        tcg_out_insn(s, 3314, LDP, r, r + 1, TCG_REG_SP, ofs, 1, 0);
+        tcg_out_insn(s, ldstpair, LDP, r, r + 1, TCG_REG_SP, ofs, 1, 0);
     }
 
     /* Pop (FP, LR), restore SP to previous frame.  */
-    tcg_out_insn(s, 3314, LDP, TCG_REG_FP, TCG_REG_LR,
+    tcg_out_insn(s, ldstpair, LDP, TCG_REG_FP, TCG_REG_LR,
                  TCG_REG_SP, PUSH_SIZE, 0, 1);
-    tcg_out_insn(s, 3207, RET, TCG_REG_LR);
+    tcg_out_insn(s, bcond_reg, RET, TCG_REG_LR);
 }
 
 static void tcg_out_tb_start(TCGContext *s)

-- 
2.43.0


