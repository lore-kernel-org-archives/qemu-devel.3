Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC48ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBr-0004RT-Pw; Mon, 09 Sep 2024 13:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBo-0004Fb-Py
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:37 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBn-00061S-5E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d50a42ce97so1789373a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902913; x=1726507713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NpWMRaUttZysT7ctorThVWZZbQJ9A1Lvzw3v01P5hI=;
 b=NPQYPQAbHyfEX8E1cOxOPAw8N5KvIE/VIO4w8PKFm6dSSg2uQI/A6pUudUcO/k23IW
 JJ3r5TE7xOWizYOpn2QV6HdNnOfPT9+0is9h1nxKJhMGBrVuqpc6gBITe9UwNaIvj+QD
 +2t6yLDFqljRhstvEMEd5AJJJrbWNtaeX1UGzWBPR/SaLUih8fCMMz5S0tVTsH5L38RO
 lMRvM/vXw49s+4hQknHpzyllwJmApMdkQd6Fz0fMSujS2ZiOO8lB9RSzmscmlPO0mNcC
 CXEaMFiSqBNs4AgEgoyXu5ii+aQmR+C6+8vKdj4SwCDp2npBbNrxNzmFwIDxhoitlrC5
 lYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902913; x=1726507713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NpWMRaUttZysT7ctorThVWZZbQJ9A1Lvzw3v01P5hI=;
 b=ZrTr2bW9xb7gYAoaZnPERq29yjn9AuWkC8kNS0mkMkSoALJgoO2NrXdbbJ9C+PFaKp
 FA9/inznZBnL+audvhjBy0C+lfRkUVKoJEtSZeZbqrMDEYNNa/0teHTx4vptc1b5vb13
 kSO6UWRbmBlhPa7fsN3oGHsbi9DOaK5/cC/fwCstNiTRwUFQISzyJdeUIx1DW5K/jRDZ
 W9tFw6LSffAoqHTOgiEDg+FXgS3UAMUK4ud3Qe4fEAWAyAgAByYi2sabO5xbRiwvyRTw
 vyI4s/fw5l67+6bOC685w/A+YdM3Oy26LiDlc9u6IfvDn2xDlYgSmaAlq6qkSCA2KCYt
 U9hg==
X-Gm-Message-State: AOJu0YwFftkGKLm/aeFJLclR3sNP3IDCUll9I+9UAlubrITps7tWLzM/
 TbaSAwIzxTt/RC6y9rS7lCtN6V8KXI9V7WiHhroPjMxmL1Exzkn0toVSlBMreOw0devbvrhh2gP
 Z
X-Google-Smtp-Source: AGHT+IFY/3YCYnxqPoaT+tVle9mLnuClRp/yR6BW8hxjFbIZfhZUGjUVLOP1JJIBFQt4cHmMW1lZFw==
X-Received: by 2002:a17:902:ce8d:b0:206:bec6:485f with SMTP id
 d9443c01a7336-2070a7e4179mr104023175ad.52.1725902913502; 
 Mon, 09 Sep 2024 10:28:33 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 09/26] target/m68k: Merge gen_ea into SRC_EA and DEST_EA
Date: Mon,  9 Sep 2024 10:28:06 -0700
Message-ID: <20240909172823.649837-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

This will enable further cleanups further down the call chain.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 003318163c..1ba1220b21 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -896,14 +896,6 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return NULL_QREG;
 }
 
-static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                   int opsize, TCGv val, TCGv *addrp, ea_what what, int index)
-{
-    int mode = extract32(insn, 3, 3);
-    int reg0 = REG(insn, 0);
-    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what, index);
-}
-
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1367,18 +1359,22 @@ static void gen_exit_tb(DisasContext *s)
     s->base.is_jmp = DISAS_EXIT;
 }
 
-#define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
-        result = gen_ea(env, s, insn, opsize, NULL_QREG, addrp,         \
-                        op_sign ? EA_LOADS : EA_LOADU, IS_USER(s));     \
+#define SRC_EA(env, result, opsize, op_sign, addrp)                     \
+    do {                                                                \
+        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
+                             REG(insn, 0), opsize, NULL_QREG, addrp,    \
+                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
     } while (0)
 
-#define DEST_EA(env, insn, opsize, val, addrp) do {                     \
-        TCGv ea_result = gen_ea(env, s, insn, opsize, val, addrp,       \
-                                EA_STORE, IS_USER(s));                  \
+#define DEST_EA(env, insn, opsize, val, addrp)                          \
+    do {                                                                \
+        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
+                                     REG(insn, 0), opsize, val, addrp,  \
+                                     EA_STORE, IS_USER(s));             \
         if (IS_NULL_QREG(ea_result)) {                                  \
             gen_addr_fault(s);                                          \
             return;                                                     \
-- 
2.43.0


