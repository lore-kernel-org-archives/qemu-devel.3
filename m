Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE2EFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwsk-0006fY-Fl; Wed, 29 Apr 2026 00:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsi-0006WB-Fk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsg-0000kx-CQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ab232cc803so58614945ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438237; x=1778043037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIZU8Gh7QJtlybesDgHA1mbz+UBZEFTfXaC0E836a7M=;
 b=ewBP4u3eD7/7QnlIV6VroJIcbezjiMMwWjr5HT+XeFEGFQ7AmLWlTSc4EKdevHl0/3
 f8uCUuDDETGFEG9W4NToU4oEfKRqFBFF2pCjBXqrFmRNT/Rfk4dUk3iZD6wYolzTomlN
 q5zwxF4ruUO2QNLXZhUEEnar5A8tXPgi/fY1431vNS92QjsOiJNaW6GS71ueIiDt90DM
 6nMdNwy7NG2MQN3rUJh+yxIMUAMHBKxtVDPYGemt2yi/1byEPhpk/mw1eS4pvaznfL/P
 QSOhgDXbO/RFv6MWT2tlwzsapHfZB2XSsm8nUEQepaz+VTqWmhpKlyOeFco1J6vP6VMZ
 bfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438237; x=1778043037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fIZU8Gh7QJtlybesDgHA1mbz+UBZEFTfXaC0E836a7M=;
 b=LmWUMrQ89w9so1rkVj2YtkfF0Gg41nkbQlXqkyobgXAuzLNUukU2JwQflYprawXtdc
 U2gDk9tKEnw3DT3pYdVdtVs+tFVFf69vfR93xJihqLiM3GLsZf+lhXn7KqkjEJs59vvD
 9Ph+pzK9eDEulD8qfBFh2eixPjcGJV2ZxyorXjzdhCtRuaaPtgpiNplDLPbjso6zM84K
 23HCt7quPoo5vGLx0U6Mgl7v85vNcUbpPiZLy5V2+67qZtszk6SHo4RrpcdR9keoBkcY
 NLrUq2mkMYcut1XVRYKUvaVKDRcJpz7Tlo8N3tahNXT15Y7z++Ea+o1PJKQlUyEoUTRw
 jQZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ84PjIRzriRe79At58clIF4Ap9+DI2mGBc8vyGEfHQJByTJGZc73vPBopWHYlmhId8mszpmlW54hNIx@nongnu.org
X-Gm-Message-State: AOJu0YxX2h2zk3yOcEuKe2S/UDbdAbU+C5GHZ3TZQWpEkDqjLMB0Nyu6
 4pnF28O1pwHJU5qHiEDNJzBv8Z4owVnch8AUsWOOswUnhU6qZxceleZZ
X-Gm-Gg: AeBDietyXIce2MST4A6vZEpC5odiEvZR0uceeg9l0NoI7zBxm3HIbeIKwNLW19lYukC
 TgvUUpcO8s+hCPuCKeNrMRox5LQnrehUCADkq6r/iSR5qWL6Zny9SiebrRuLDdB78qi1Wb+XGwP
 dZDeAvSEyfQOiOvcdhYzsb8GjcS3JZep4yOWFOv6ndK9+sPzlmarTsJk1SAQqh2yt/SiczGvhON
 Btc1L3ENCIOMGO6xh9gHtkDBlzdUePUGGnAZ25+9LOw2p8T5YyvAzmFGKh8UYuurqgTevO6E6aj
 XfIh4Bho+wTIDW+/tkrUKEKkE72mKbln7ZdprhjWdzsYoxHEQsU5vEutfBfU4le1UBHRu8RAXdR
 XP1acSvNEn91KD2VqMxIJQ9i+hBxrU4ORnCVXEsxv3cAsb6QKrahj4kkZbGQqADdQWqt3uiuUbo
 /Pa6IfKACiJz/JYGGbtSLoOM5tG0nmz29YKatUysinxilLEq5Wqbs4
X-Received: by 2002:a17:903:3c2f:b0:2b9:6453:389a with SMTP id
 d9443c01a7336-2b97c3cc0b3mr59380525ad.8.1777438236961; 
 Tue, 28 Apr 2026 21:50:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/51] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Date: Wed, 29 Apr 2026 14:47:30 +1000
Message-ID: <20260429044752.4176397-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

According to the Zvfbfa ISA spec v0.1, the vtype CSR adds a new field:
altfmt for BF16 support.
This update changes the layout of the vtype CSR fields.

- Removed VEDIV field (bits 8-9) since EDIV extension is not planned to
  be part of the base V extension
- Added ALTFMT field at bit 8
- Changed RESERVED field to start from bit 9 instead of bit 10

When Zvfbfa is disabled, bits 8+ are treated as reserved (preserving
existing behavior for altfmt bit). When Zvfbfa is enabled, only bits 9+
are reserved.

Reference:
- https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  4 ++--
 target/riscv/vector_helper.c | 39 +++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..962cc45073 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -191,8 +191,8 @@ FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
-FIELD(VTYPE, VEDIV, 8, 2)
-FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
+FIELD(VTYPE, ALTFMT, 8, 1)
+FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83dd26314d..63ca6fe16b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -33,6 +33,22 @@
 #include "vector_internals.h"
 #include <math.h>
 
+static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
+{
+    int xlen = riscv_cpu_xlen(env);
+    target_ulong reserved = 0;
+
+    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
+                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    } else {
+        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
+                                           xlen - 1 - R_VTYPE_ALTFMT_SHIFT);
+    }
+
+    return reserved;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -41,12 +57,10 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
     uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
     uint16_t sew = 8 << vsew;
-    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
+    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
+    bool ill_altfmt = true;
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
-    target_ulong reserved = s2 &
-                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
-                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
@@ -63,7 +77,22 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         }
     }
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    switch (vsew) {
+    case MO_8:
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        break;
+    case MO_16:
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        break;
+    default:
+        break;
+    }
+
+    if (altfmt && ill_altfmt) {
+        vill = true;
+    }
+
+    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
         /* only set vill bit. */
         env->vill = 1;
         env->vtype = 0;
-- 
2.53.0


