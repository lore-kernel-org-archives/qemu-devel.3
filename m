Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2849ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC2-00055v-DY; Mon, 09 Sep 2024 13:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBu-0004bQ-47
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBs-00062j-BH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2059112f0a7so42400765ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902919; x=1726507719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAcKrDIxutgOniQxrMrD8IrQr2g9V6Cuwf+b/ddORiM=;
 b=xmHK5xxgqmCgrrbW31S4Fi8H4dA24c299ub4zKKMyXXBI2a6KiG23iWlIiWtJPi39e
 cGjkH11Hkn7n6P/euh5+y3ziSK5w9X6E2oK82B8pmyNeztUwEsQrqOWItw6ws1QFRupQ
 jLVLiXAq2UeOuVndsUuoZhF5JAG7wVAg/zVyQ/rhGPLX6OYB8v9nH2KWbiRFAEwYLLdS
 VDMXceBdWbXkCN3M4ujzGMpMmTQsZasCT+EDKDiDsIqLou29fZAN587FXihrVyOQrsLq
 oVQ7FaWABvCTY4xjBZlr80t5afUSG8XU09lzCSy/BUv+RjCMPEddoLIBTFfZ7Yg8Q4kN
 ULrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902919; x=1726507719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAcKrDIxutgOniQxrMrD8IrQr2g9V6Cuwf+b/ddORiM=;
 b=SgURsbjcOxM++vSfbpIKyUuf//ui+JMsd0GznL+PoQJiKXA8F+jmJsA6bw7n6xKYh9
 IVauIWrN3b+jXvpyChYeIsGlzRoEJ9bzWh4pLW7W3dkW2aG6Ix4StQLKj/ns36XDwkEj
 e+8GBTsZzzgIhLvUc7CqX52N4ge8ZsRu6VjO9qK9nq6VwXeFonmMKG+fXvHvaDSK8VXP
 xksE8zoJGlB7ESSWMd399eKcjuc3+Z1JhW7wNfat+x5fOm+0og31rd3l7qU0kPD3Bk8v
 XRu+IY+GSwcmH6dN7yvPivDdVPXI3kRGKXetSNQ+iUMuf7ggPWwk5HFOJCn6xrD5dkZX
 +99A==
X-Gm-Message-State: AOJu0Yz/g91pR0B/l3c6XZbzVTGTZQaKdCb+DzATKVwlnaXnN9R+NbeI
 OYtwOycIro6PcqQ0DmyebRocjNwa32DWFM5I+iKiABhZikfgHL1bUcH+9sw82HogAEhIEU/F5F7
 n
X-Google-Smtp-Source: AGHT+IHYcE0O1g82OalykUMAgDIKByE8sZxpG820ukstaFjPxa4vmp+1zSa4QB0AN6Ep6DdoyD2vRw==
X-Received: by 2002:a17:902:e543:b0:202:2f0:3bb2 with SMTP id
 d9443c01a7336-20707020f79mr78328825ad.60.1725902918945; 
 Mon, 09 Sep 2024 10:28:38 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 15/26] target/m68k: Remove env argument to gen_lea_mode
Date: Mon,  9 Sep 2024 10:28:12 -0700
Message-ID: <20240909172823.649837-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Use the env pointer in DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 78a9358416..938c650c78 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -693,8 +693,7 @@ static int addr_inc_size(DisasContext *s, int reg0, int opsize)
 /*
  * Generate code for an "effective address".
  */
-static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
-                         int mode, int reg0, int opsize)
+static TCGv gen_lea_mode(DisasContext *s, int mode, int reg0, int opsize)
 {
     TCGv reg, addr, tmp;
     uint16_t ext;
@@ -732,7 +731,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
         addr = tcg_temp_new();
-        ext = read_im16(env, s);
+        ext = read_im16(s->env, s);
         tcg_gen_addi_i32(addr, reg, (int16_t)ext);
         return addr;
     case 6: /* Indirect index + displacement.  */
@@ -741,14 +740,14 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
     case 7: /* Other */
         switch (reg0) {
         case 0: /* Absolute short.  */
-            offset = (int16_t)read_im16(env, s);
+            offset = (int16_t)read_im16(s->env, s);
             break;
         case 1: /* Absolute long.  */
-            offset = read_im32(env, s);
+            offset = read_im32(s->env, s);
             break;
         case 2: /* pc displacement  */
             offset = s->pc;
-            offset += (int16_t)read_im16(env, s);
+            offset += (int16_t)read_im16(s->env, s);
             break;
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(s, NULL_QREG);
@@ -768,7 +767,7 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_lea_mode(env, s, mode, reg0, opsize);
+    return gen_lea_mode(s, mode, reg0, opsize);
 }
 
 /*
@@ -826,7 +825,7 @@ static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
             ret = addr;
             addr = NULL;
@@ -869,7 +868,7 @@ static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
     case 6: /* Indirect index + displacement.  */
     case 7: /* Other */
         if (!addr) {
-            addr = gen_lea_mode(env, s, mode, reg0, opsize);
+            addr = gen_lea_mode(s, mode, reg0, opsize);
             if (IS_NULL_QREG(addr)) {
                 return false;
             }
@@ -1109,7 +1108,7 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
             return -1;
         }
@@ -1930,7 +1929,7 @@ DISAS_INSN(movem)
         break;
 
     default:
-        tmp = gen_lea_mode(env, s, mode, reg0, opsize);
+        tmp = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(tmp)) {
             goto do_addr_fault;
         }
@@ -2672,7 +2671,7 @@ DISAS_INSN(tas)
     } else {
         TCGv src1, addr;
 
-        addr = gen_lea_mode(env, s, mode, reg0, OS_BYTE);
+        addr = gen_lea_mode(s, mode, reg0, OS_BYTE);
         if (IS_NULL_QREG(addr)) {
             gen_addr_fault(s);
             return;
-- 
2.43.0


