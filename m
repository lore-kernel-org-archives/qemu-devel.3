Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A996BC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9T5-00023S-5e; Tue, 21 Jul 2026 08:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wm9Sx-000208-Qj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:56 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wm9Sv-0003oS-NC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so5184886a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784636452; x=1785241252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EuakE1U1Gao9PtmplSW+xDQNGjmn37T0KeFRgNX+Gps=;
 b=gxvGoFo75hQqUsGfxFtMksSjXdCAm+jeQagTh9lIDV+88xAY+5BVSD8zAWoY8Q3Brm
 2XiEisuwGcx7nMFsPX9cgwmyapwe03Qcx1wiuYI5qqLbk7233eXZOoLPhw1qGPNnzVEU
 0vDDbHzr3rtvGT3hm/hbkfTZDlRtyLtnbNKfuB6tpP9RsHJ65m8pHVaKgWbZWUdF7eve
 39LJ+Lq/YGgFbVo+On7AFbwM3XXkiOvJuQSRv9b+/Zx0bjHKmgaI+dZ45kXhZbQ/T96J
 dy8O6XiLHiteGDCoXjC7Qdc/EggejcZtkw3vA9mxnbnNYTOjnASKCh46sjb/kX/H1a9K
 NWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636452; x=1785241252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EuakE1U1Gao9PtmplSW+xDQNGjmn37T0KeFRgNX+Gps=;
 b=CbgZbRG5cPQ1jaK7dSpLt3eiiRaeruJti9Oq/SpES6k+KhKWBTRIAA6cvNb2GTg+3O
 SmLsiDY96x8/BiwL+6Pn7+M0u7g3d0afg4WdzwgAVEaoP55C4eWzAeYYE7dhV3gp2n0F
 /KIhzMPr8chwhWiarpp9NsQC4h37YjXtTvFgZaSP7aW944gGE1Af/Z29ifD15OS/MMeX
 Rlf14ZHzemtfXDPXKIdgQtbVomrr6wsUI+zpF49hQzrRBBHQKaYChWc+cfRnWdBCwi1q
 WxOoEA2Cj9s2Kww3iChiE0fzi1E/R3TyTtiuvNfTexWn435ivVrRkcY1FgCqTmPlMNi7
 Ha/w==
X-Gm-Message-State: AOJu0YxIEDoqR34yH03sxSEnNZpctuU/1UUH+LFBWGZkJD7vY9McCFzs
 vWyR58VxuUp+Cv9+KV3OmCVHXBQK4+dY+CIC/uii+uttuwnI94JGl/5GTFMe5aFiAalaN2ZiENQ
 WSfxvMOwmKCJR8dyqarB6ra02ifNS/DM8lXl7gBUULITljO717uKisrRlfGK+g61UJEcbpuF0Ma
 Rw+r5aI3HZ7zU6ChTJLfzjbYiaKO714e6k4uHBwfQ=
X-Gm-Gg: AfdE7ckXWTlXqqIAs1jE5RsC/VYp0jb0cHbCtTk7o9hXWq+mJPptJoGxE5l6NUlh2K7
 WvBIOb1B/o/ZXCH96l+FOmNR6NknXQntasB6U7iONT2WmKwiuhEwvH2luYipaXKn7vsW1E3l+Yw
 wz/esZCMM12KxTtusotFd1Azo71uBEh8py6KqA7LOoHeNsiv+QE1A83pBYjt6MjpfW12mDWpPTe
 7LOBaWDWGwmh5xORQverdXiMN9H1qyAAfkquFz94Ko8Tqr36zmh5s2yXT2UE4M/8h3YgUPcYy2X
 OucZxeJEIz9o5gYK8siG151y9njIrsJa10rhv70ECni/bTd1Db16FKaTjIKX/43KnbPFHA1cbFy
 N7787JSmEDR+2hYdcKcOofRtKUl2qIMbS4paHJSVN7RCAbMb72PBygkMUIUE5T9BILD86kEuedX
 85MAiaVwOK54ehTnfw3soc+dUICHsgiEL18Z0FoJU8lY6cPf4xJP9Mesy/Mf+/BhEWt+jDb3+0D
 GE9A9Ph9faO4Gf4
X-Received: by 2002:a05:6a21:6816:b0:3bf:bde7:d66f with SMTP id
 adf61e73a8af0-3c3ad79feddmr18274911637.2.1784636451764; 
 Tue, 21 Jul 2026 05:20:51 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb517aad95dsm5904568a12.7.2026.07.21.05.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:20:51 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 4/5] disas/riscv: Add disassembler support for
 Xsfvqmaccdod/Xsfvqmaccqoq
Date: Tue, 21 Jul 2026 20:20:32 +0800
Message-ID: <20260721122034.1567146-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721122034.1567146-1-max.chou@sifive.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52f.google.com
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

From: Jason Chien <jason.chien@sifive.com>

Add disassembler support for all SiFive custom int8 matrix-multiply
instructions: sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2.

These instructions share opcode 0b1011011 and funct3 0b010, and are
distinguished by funct6: 60-63 for the 4x8x4 (Xsfvqmaccqoq) tile and
44-47 for the 2x8x2 (Xsfvqmaccdod) tile.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 MAINTAINERS       |  1 +
 disas/meson.build |  3 +-
 disas/riscv-xsf.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 disas/riscv-xsf.h | 18 +++++++++++
 disas/riscv.c     |  2 ++
 disas/riscv.h     |  1 +
 6 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 disas/riscv-xsf.c
 create mode 100644 disas/riscv-xsf.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 94cd63eeba..1a40d86685 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -395,6 +395,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: target/riscv/xsf.decode
 F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
+F: disas/riscv-xsf*
 
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
diff --git a/disas/meson.build b/disas/meson.build
index 42977a1f74..9135716268 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -8,7 +8,8 @@ common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
     'riscv.c',
     'riscv-xthead.c',
     'riscv-xventana.c',
-    'riscv-xlrbr.c'
+    'riscv-xlrbr.c',
+    'riscv-xsf.c'
 ))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
diff --git a/disas/riscv-xsf.c b/disas/riscv-xsf.c
new file mode 100644
index 0000000000..8f752657a7
--- /dev/null
+++ b/disas/riscv-xsf.c
@@ -0,0 +1,79 @@
+/*
+ * QEMU RISC-V Disassembler for xsf (SiFive vendor extensions).
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "disas/riscv.h"
+#include "disas/riscv-xsf.h"
+
+typedef enum {
+    /* 0 is reserved for rv_op_illegal. */
+    xsf_op_sf_vqmaccu_4x8x4 = 1,
+    xsf_op_sf_vqmacc_4x8x4 = 2,
+    xsf_op_sf_vqmaccus_4x8x4 = 3,
+    xsf_op_sf_vqmaccsu_4x8x4 = 4,
+    xsf_op_sf_vqmaccu_2x8x2 = 5,
+    xsf_op_sf_vqmacc_2x8x2 = 6,
+    xsf_op_sf_vqmaccus_2x8x2 = 7,
+    xsf_op_sf_vqmaccsu_2x8x2 = 8,
+} rv_xsf_op;
+
+const rv_opcode_data xsf_opcode_data[] = {
+    { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
+    { "sf.vqmaccu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmacc.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmaccus.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmaccsu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmaccu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmacc.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmaccus.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+    { "sf.vqmaccsu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0, 0, 0 },
+};
+
+void decode_xsf(rv_decode *dec, rv_isa isa)
+{
+    rv_inst inst = dec->inst;
+    rv_opcode op = rv_op_illegal;
+
+    switch ((inst >> 0) & 0b1111111) {
+    case 0b1011011:
+        switch ((inst >> 12) & 0b111) {
+        case 0b010:
+            switch ((inst >> 26) & 0b111111) {
+            case 60:
+                op = xsf_op_sf_vqmaccu_4x8x4;
+                break;
+            case 61:
+                op = xsf_op_sf_vqmacc_4x8x4;
+                break;
+            case 62:
+                op = xsf_op_sf_vqmaccus_4x8x4;
+                break;
+            case 63:
+                op = xsf_op_sf_vqmaccsu_4x8x4;
+                break;
+            case 44:
+                op = xsf_op_sf_vqmaccu_2x8x2;
+                break;
+            case 45:
+                op = xsf_op_sf_vqmacc_2x8x2;
+                break;
+            case 46:
+                op = xsf_op_sf_vqmaccus_2x8x2;
+                break;
+            case 47:
+                op = xsf_op_sf_vqmaccsu_2x8x2;
+                break;
+            }
+            break;
+        }
+        break;
+    }
+
+    dec->op = op;
+}
diff --git a/disas/riscv-xsf.h b/disas/riscv-xsf.h
new file mode 100644
index 0000000000..b8462c356e
--- /dev/null
+++ b/disas/riscv-xsf.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU disassembler -- RISC-V specific header (xsf*).
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_XSF_H
+#define DISAS_RISCV_XSF_H
+
+#include "disas/riscv.h"
+
+extern const rv_opcode_data xsf_opcode_data[];
+
+void decode_xsf(rv_decode *, rv_isa);
+
+#endif /* DISAS_RISCV_XSF_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..032cd31e35 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -27,6 +27,7 @@
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
 #include "disas/riscv-xlrbr.h"
+#include "disas/riscv-xsf.h"
 
 typedef enum {
     /* 0 is reserved for rv_op_illegal. */
@@ -5454,6 +5455,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
         { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
         { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
+        { has_xsf_p, xsf_opcode_data, decode_xsf },
     };
 
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
diff --git a/disas/riscv.h b/disas/riscv.h
index 379e642ec8..66683201b9 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -280,6 +280,7 @@ enum {
 #define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
 #define rv_fmt_vd_vs2_uimm            "O\tD,F,u"
 #define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
+#define rv_fmt_vd_vs1_vs2             "O\tD,E,F"
 #define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
 #define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
 #define rv_fmt_vd_fs1_vs2_vm          "O\tD,4,Fm"
-- 
2.55.0


