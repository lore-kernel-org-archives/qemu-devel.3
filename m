Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A04CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut30K-0000qa-5F; Mon, 01 Sep 2025 07:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30E-0000g9-71; Mon, 01 Sep 2025 07:47:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut301-0001XA-Cw; Mon, 01 Sep 2025 07:47:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2445806df50so33086855ad.1; 
 Mon, 01 Sep 2025 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727214; x=1757332014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQ+3MTiWQKCXF89rhsmMbp4GPDQ2G1un64hmb0oDF0M=;
 b=g6Rb1sxq1V4MoRCmaFDIF7jx1GEOUVQeveJhwiXLbo8HshLosq+kAWJaAnt+8Vxn+g
 G7tDswpSmoBqjuC9WW2aIZX3pWcM51Bja/31wr48iIf3A0lBwU5xJuqHmkw36svCHdgD
 w4ZJfqHN2L/ke53l+BRAS2RYQibv7PZqu5UpbiDUpzpDtZrqoBfyr4iF8LfgqeeRa8P2
 o3mEX/icx08t8QJMu0EIFDrsRVd4jZrz4CLhA5e2XQmHXirP3b5qV7zu310Mr/6iTknJ
 dNZ8y8uDJHSDffWclqe5J1otvOV0L86p99sK94bNqDECLmSB/Bb7r8D+DXn6ZYW+ftyx
 +xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727214; x=1757332014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQ+3MTiWQKCXF89rhsmMbp4GPDQ2G1un64hmb0oDF0M=;
 b=W91qv9hfW47frIi1hVU0ciSVnk+cFISmUqxoS0HCOfGbUqjEGgZgaUixGUdZnmVVwL
 gtnvgrDuAs4ZUsLx7jN8OGf22ZWk5nrdOhtr5njb+PtO57wJiV/YprSpbMc0W3Jkxk2c
 hRX7s0B1G09HeBKvL7l2/urfKc6fqEx/jsl7p7moLifP8RphcXQY9pA19gsVENh30OZA
 qFCu/DJ35a2IQXyahuTNogjxLd/GWjsquoouK1fRVnR1YG99KSm1B/GrCIvXPOeubOW9
 UuxxZ/8IWucyINn4vxhWIroTgay6pKRC93DG+JSDYkmyQCmLVlsp/UYjZaU6PkubaWDq
 EoZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYvpkpd+Oby/5GEFsBaECd1S0S/xp1Ai5KTM06nEDlq2L/kWAkdm0TD12Bt5SO0g3Pcl7IzusNcg==@nongnu.org,
 AJvYcCWGhQIvxFQHntHL3608Tii7kb51p9minn5i+L+XpkEkXscSQ2u4QzIX6iawS6uPiorE2kZG1xLUXUkivg==@nongnu.org
X-Gm-Message-State: AOJu0YyIX1CkSUPdkymrUbPHOYO5Yni28gNBx1SC7Iyjwsq/98NOU58N
 oiagxre43ysgWZ2isxwdyJVkEMtTcxYsbUAX67pUf/2Uax9kw2UJP1dEHJcaWQ==
X-Gm-Gg: ASbGncsQeqFuEMXNrrwLk9TAqy5anChHXjAYaM9dMji80nm+MVEsI2gneJ2JiRdMFHa
 uuWeFXdQk7HHaapZMHR01Fjo2NAuQd9Qlql0ltGuQMHELmIiuK3IEq5KldYCa5xh6AGLjZm5b7b
 tFIbtz+AVUNug7Kr44dXml6Brmj31BPgvec3Qe/MZSMSlv1Tw4xzCFnh/nEOpzpOCspYGn/0pfV
 N/vG458zEojecC99Ydoe6ubq0UJGSGKTifgkXz+0pvNpFm+5wsaqBKeDdw3OsDC9+gU6zY24eCI
 GPMs3W835ic1gFjJ1QlNYQlWj8bQ1Ht4526pGymvQFhLihen7LZIsgKHQmJxZiUYo/b9D5OrztP
 ER65nMP2nrln1F6+o2Z2nE3xK+6OR2YFcvD8MxbYjNkc=
X-Google-Smtp-Source: AGHT+IEgbT6j86xFecbnFKWuYckMBN8GSvt4ydp6+BQu7+N6HT0ZkBOlxAbGvGrW4OTtOS6TJGYi6Q==
X-Received: by 2002:a17:902:e745:b0:246:e1f3:77b2 with SMTP id
 d9443c01a7336-24944b65071mr91417215ad.53.1756727213890; 
 Mon, 01 Sep 2025 04:46:53 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:53 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 16/35] tcg/wasm: Add ext instructions
Date: Mon,  1 Sep 2025 20:44:18 +0900
Message-ID: <004734452e90077ea9f98ab7b093ce16fc1f5bae.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The ext operations are implemented using the corresponding instructions in
Wasm. TCI instructions are also generated in the same way as the original
TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target-has.h |  1 +
 tcg/wasm/tcg-target.c.inc | 79 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
index cfb85388de..a29ceb2ea5 100644
--- a/tcg/wasm/tcg-target-has.h
+++ b/tcg/wasm/tcg-target-has.h
@@ -3,6 +3,7 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_tst 0
+#define TCG_TARGET_HAS_extr_i64_i32 0
 
 #define TCG_TARGET_extract_valid(type, ofs, len) 0
 #define TCG_TARGET_sextract_valid(type, ofs, len) \
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index def1f5cd5e..e41b3a0c27 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -434,6 +434,22 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
 }
 
+static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                 int pos, int len)
+{
+    int64_t mask = ~0ULL >> (64 - len);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    if (pos > 0) {
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
+        tcg_wasm_out_op(s, OPC_I64_SHR_U);
+    }
+    if ((pos + len) < 64) {
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
+        tcg_wasm_out_op(s, OPC_I64_AND);
+    }
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
 /*
  * The size of the offset field of Wasm's load/store instruction defers
  * depending on the "-sMEMORY64" flag value: 64bit when "-sMEMORY64=1"
@@ -991,6 +1007,69 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, type, rd, rs, 0, 8);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 8);
+}
+
+static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, 0, 8);
+    tcg_wasm_out_extract(s, rd, rs, 0, 8);
+}
+
+static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, type, rd, rs, 0, 16);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 16);
+}
+
+static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, 0, 16);
+    tcg_wasm_out_extract(s, rd, rs, 0, 16);
+}
+
+static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 32);
+}
+
+static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, 0, 32);
+    tcg_wasm_out_extract(s, rd, rs, 0, 32);
+}
+
+static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32s(s, rd, rs);
+}
+
+static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rr(s, INDEX_op_mov, rd, rs);
+    tcg_wasm_out_extract(s, rd, rs, 0, 32);
+}
+
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, a0, a1, 32, 32);
+    tcg_wasm_out_extract(s, a0, a1, 32, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


