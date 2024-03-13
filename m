Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DBC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkXRy-0002JQ-D2; Wed, 13 Mar 2024 18:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkXRv-0002Iz-0s
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:51:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkXRt-0004Gm-FH
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:51:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dddad37712so3350155ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710370308; x=1710975108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TW18i/SxaVapdFzWXSi5siyjYPKSm3YSkEGDE7UVwk=;
 b=M24bjKkHyZrd1RLkbzifAvhGpSr41auZ7wNxaCwU9LE403vS5GJyKe+cXuQhSORLZ1
 VBXXc11DdDuCg+g21h9CQxeYx5CKtXx+v0ZfUElR2vcV4oXVR437IsM6jy6aTP3NU0jh
 Fj2N3eCaP0Uc5i+D0kotiPeohWTDHmPESVTL8FrwAb4We5DtAwsVAX33e9f9HuIlh1Hh
 2NnhxjATdpy7vaZkeu+STjrc4Aca1W6LF1NQxp7ws0XqB1nYE5GPvbqbUO8gLhnE32X4
 MVJmxcIpnyp6zVwqSsf8igutK6zHUkQoeF14x1wo9oYHAKPge0RM5sD0Lin34eoisGUg
 Ry3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710370308; x=1710975108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TW18i/SxaVapdFzWXSi5siyjYPKSm3YSkEGDE7UVwk=;
 b=KrwC6HVmDMw3bl0XO3JwQU6EuWMHL7UHKA/lNSJg8JAxQMFVe9guOQ/Kz5yCBwDzRG
 Dg9cjHPiHzBhy+BhexhdWHgM6W6M48j4uobXrHKWMFu5nasOJZc89Ttd6iGTV6XbGS0+
 a0DD/gghpDWmvWVnDBlweOY54Hachb0y3au4kZwkonVH7NXjo9b3GXwGX5GNpBzN8q3v
 COxZNNCdRgGkUxnYf1rsrJkOVuwUcVHFq/LrD5/kXxorPycKzREdZzf6bybzwpj/sMQB
 T7GBF/kcmoVjVNic/qbMdVsToV1/QDOjlofp+gip7lNsJckSYdqUgPynvSnZPKDoptOJ
 hKgA==
X-Gm-Message-State: AOJu0YyghYYe7OBUKFF7CnYRpUBMAKdiMGAFGWIFycubaIol+jr3pF2g
 6F2Z679y+4VzWHhPmbmcV/AMXG6S0P/YLrJ8WvAL80J6lKBccliB2DUSS0dZvgs2G3C00MatM1H
 B
X-Google-Smtp-Source: AGHT+IGBOm3By78ekpmbbm/lVnuQKo8YVa5TSOsAoKkgRP3KT0+PvcTGy5jWyRG0i3aG5f1IF+KVcw==
X-Received: by 2002:a17:903:11c6:b0:1db:8fd6:915e with SMTP id
 q6-20020a17090311c600b001db8fd6915emr175150plh.33.1710370308040; 
 Wed, 13 Mar 2024 15:51:48 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001dcfc68e7desm137269plx.75.2024.03.13.15.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:51:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 1/3] target/hppa: Fix assemble_16 insns for wide mode
Date: Wed, 13 Mar 2024 12:51:38 -1000
Message-Id: <20240313225140.812202-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313225140.812202-1-richard.henderson@linaro.org>
References: <20240313225140.812202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 15 +++++++++------
 target/hppa/translate.c  | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f5a3f02fd1..0d9f8159ec 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -27,13 +27,14 @@
 %assemble_11a   0:s1 4:10            !function=expand_shl3
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
 %assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
+%assemble_sp    14:2                 !function=sp0_if_wide
 
 %assemble_21    0:s1 1:11 14:2 16:5 12:2  !function=expand_shl11
 
 %lowsign_11     0:s1 1:10
-%lowsign_14     0:s1 1:13
 
 %sm_imm         16:10 !function=expand_sm_imm
 
@@ -221,7 +222,7 @@ sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
 addil           001010 r:5 .....................        i=%assemble_21
-ldo             001101 b:5 t:5 -- ..............        i=%lowsign_14
+ldo             001101 b:5 t:5  ................        i=%assemble_16
 
 addi            101101 ..... ..... .... 0 ...........   @rri_cf
 addi_tsv        101101 ..... ..... .... 1 ...........   @rri_cf
@@ -306,10 +307,12 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 
 @ldstim11       ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
-@ldstim14       ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%lowsign_14 x=0 scale=0 m=0
-@ldstim14m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%lowsign_14 x=0 scale=0 m=%neg_to_m
+@ldstim14       ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_16  \
+                x=0 scale=0 m=0
+@ldstim14m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_16  \
+                x=0 scale=0 m=%neg_to_m
 @ldstim12m      ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index eb2046c5ad..cbe44ef75a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -144,6 +144,28 @@ static int assemble_6(DisasContext *ctx, int val)
     return (val ^ 31) + 1;
 }
 
+/* Expander for assemble_16(s,im14). */
+static int expand_16(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bits [0:15], containing both im14 and s.
+     * Swizzle thing around depending on PSW.W.
+     */
+    int s = extract32(val, 14, 2);
+    int i = (-(val & 1) << 13) | extract32(val, 1, 13);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
+    }
+    return i;
+}
+
+/* The sp field is only present with !PSW_W. */
+static int sp0_if_wide(DisasContext *ctx, int sp)
+{
+    return ctx->tb_flags & PSW_W ? 0 : sp;
+}
+
 /* Translate CMPI doubleword conditions to standard. */
 static int cmpbid_c(DisasContext *ctx, int val)
 {
-- 
2.34.1


