Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrtI-00036I-NI; Mon, 19 May 2025 00:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnX-0005fH-VG; Mon, 19 May 2025 00:08:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnW-0004Cg-0Y; Mon, 19 May 2025 00:08:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so2120614a12.0; 
 Sun, 18 May 2025 21:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627696; x=1748232496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bY2i6KRzdpjZN9qbe8ipe7V+hMzrNvP5r+ll4sE4mDw=;
 b=ZQvUHDMaC+bNBZ9Lq3TZ5JbcqaBtCdDKXv+0ywav+KZMDXrwsZUL6xkHAH8g5Xw1Xb
 E9NP+cniFfaiA2abAqWewB64zv3OWpdFnXkdp6RTh3/foxmh5iMW1ld1RZ97Y3BbrJiS
 l2MZWwCZ5zLKMg/0PWEmBS5xuigdpYB42djo9F69aKrcJK/c7STxKf5Y2NhCyZ3ivue9
 t+VwMr34VRb+QWoen38x12acv/1phEksdTD0k6PPe+uGup4sYWMiPpHvMB6A7R/FLwyA
 qV40nwc7pmiitJVFXe+I2+l402GzQeHoLZoB3Dg1ylxeYawLo0UGbcu6VYGb1xfWCFTJ
 +gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627696; x=1748232496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bY2i6KRzdpjZN9qbe8ipe7V+hMzrNvP5r+ll4sE4mDw=;
 b=SzmF12DYHpl6FjF6p4c8V93Px8MD/PxBCpz0vBFgPKbZfpTS+87ytKS+i+hC+Xx/k1
 BpkcoEghcv+fjMq2W8px2eFOGFThCr61oQkzRCekQt2TDY6oIDqWz8CX2HG1aqvhNWAA
 mMGHQIGuTPHirswWO+JKgaMQVtzNxS7JrUeoGIPlt1WghJti8JHojpX1oZ6VxlKZhNyL
 WL2lTkDvbm3YmzYnElIDp3CD6mz7yS0yMTSiOBR4RiO19pjxjA+zGUfsEGVGpPL0t8cu
 fUnnAMikxHvcGCy0XYBg/0ct2PF8ORnZQscYEISdAysEkoqokB40fqamEyEd+ZQPDjQX
 lExA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC168XOVk/uTBMYEzbuJ6QOsXV0Qr89NNZYeiSaK6DG2mFMuFLrwT2Un3QDPvbwcpmGejXugIR0biSfA==@nongnu.org
X-Gm-Message-State: AOJu0YzmZ1Ckmnc/3uvrRx7eqrZRMnEOdrtIAX5C91eItPNMuummLCEo
 oEU05zaPHqVyJE6b2QGvXnDdWh8f7nAtFCYTvBQGh8EMNOXbJVDVB/h/5UpaKw==
X-Gm-Gg: ASbGncuGlKSg1T70SIgsJg+fGqsX9Ll4IAoag+E8BZGAfilySigNTuLZ79tcHlnRe75
 JOR+mTVnuZyZnI7aCDlgjQ/8Gz0T6zJswiX36hAahtLfu5APjNt7YRXsLVKbPYXfJePy5DgZTde
 97BUSRK53ougXE6hJvVk87zQ1ziXYCr8nxG3Yto8BKtKPVLjiXHh15tWQnnZrqlcdLMgWE7qnRS
 w8CzcT4B8KtqzpuDwdI5Lk4JMQbHjQl4jpjSgKZxrRbwXNzlOndqFJrad8+RhBwAFZBNcXuX8zC
 7m2Kb0fcvN4L4u/eGkEAb/Pq92EAb652jX/jSqKAWH4Q1ih2anb+6euG9LFIfRhh1ABjy0c4rSz
 vqrUMUpk/V2FEXb0JIe0letM1fm8MJQVH1QjOjKad5qC11ZsDRRNvg2y7
X-Google-Smtp-Source: AGHT+IFOH20i8waqGh1NR+izCFnOsI5cXDriFNNJzPx7Bb5bA7yYnINmj6662HBItm9KMadvxyMbYg==
X-Received: by 2002:a17:903:2ed0:b0:22e:5e05:b89d with SMTP id
 d9443c01a7336-231de361a2dmr148490175ad.16.1747627696026; 
 Sun, 18 May 2025 21:08:16 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 22/56] target/riscv: rvv: Apply vext_check_input_eew to
 vrgather instructions to check mismatched input EEWs encoding constraint
Date: Mon, 19 May 2025 14:05:19 +1000
Message-ID: <20250519040555.3797167-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the v spec, a vector register cannot be used to provide source
operands with more than one EEW for a single instruction.
The vs1 EEW of vrgatherei16.vv is 16.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d8333d8311..04367e1bec 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -379,6 +379,35 @@ static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
     return ret;
 }
 
+/*
+ * Check whether a vector register is used to provide source operands with
+ * more than one EEW for the vector instruction.
+ * Returns true if the instruction has valid encoding
+ * Returns false if encoding violates the mismatched input EEWs constraint
+ */
+static bool vext_check_input_eew(DisasContext *s, int vs1, uint8_t eew_vs1,
+                                 int vs2, uint8_t eew_vs2, int vm)
+{
+    bool is_valid = true;
+    int8_t emul_vs1 = eew_vs1 - s->sew + s->lmul;
+    int8_t emul_vs2 = eew_vs2 - s->sew + s->lmul;
+
+    /* When vm is 0, vs1 & vs2(EEW!=1) group can't overlap v0 (EEW=1) */
+    if ((vs1 != -1 && !require_vm(vm, vs1)) ||
+        (vs2 != -1 && !require_vm(vm, vs2))) {
+        is_valid = false;
+    }
+
+    /* When eew_vs1 != eew_vs2, check whether vs1 and vs2 are overlapped */
+    if ((vs1 != -1 && vs2 != -1) && (eew_vs1 != eew_vs2) &&
+        is_overlapped(vs1, 1 << MAX(emul_vs1, 0),
+                      vs2, 1 << MAX(emul_vs2, 0))) {
+        is_valid = false;
+    }
+
+    return is_valid;
+}
+
 static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 {
     return require_vm(vm, vd) &&
@@ -3733,6 +3762,7 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs1, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
@@ -3745,6 +3775,7 @@ static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
     int8_t emul = MO_16 - s->sew + s->lmul;
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, MO_16, a->rs2, s->sew, a->vm) &&
            (emul >= -3 && emul <= 3) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs1, emul) &&
@@ -3764,6 +3795,7 @@ static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, -1, MO_64, a->rs2, s->sew, a->vm) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
            (a->rd != a->rs2) &&
-- 
2.49.0


