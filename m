Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672B8C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXR2-00082B-Sf; Sat, 29 Mar 2025 10:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQr-0007uv-0u
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:12 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQo-0004LW-5x
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:08 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so3961576a91.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259503; x=1743864303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yiRTyvv8HDyh7DkIPVVEzeV4GFr++tl7EjdhkATDMY=;
 b=bSnQdckHBZ5kAITd14vRQdKRs2MVVDE35j/eOsLba6/OHYM23m3YZDwGujwwMrVqr2
 R0S5qVEgCW0Z/8zkoCVkeMSSW+4Iq0n1Cn321alJBBZVmYH/pDxfa7hgxPawqWWXaYyZ
 SaLCgjpjvhTBLpoHam8dWisVr4cj9vhsV4f/1pxvr5OtfPdnan5Svki1VfBDffgTYjvU
 0ZoAyzRQ3zriGSM39hVzsBJ6oUwFMtneV1Ef3ahufOXj/GKxyCweFEkcPwkJTb9t+22Q
 my6GCJatB546qYk9qhs8J3JyFNa89jN72SBS5bYv82QqEh7hVR2mOUBfp5+Az62P7dxs
 +Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259503; x=1743864303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yiRTyvv8HDyh7DkIPVVEzeV4GFr++tl7EjdhkATDMY=;
 b=YDNP5wn8hDNoehEsBTdl0UuJyrKRaut3aLbwkDAKWad1yeRKkL4y7cNNNhRKv1ES9c
 ajjNmo1MJqBRnBxI7ENoLZW5HlZTsCHJvii8fEXQ6rxk+wXHs/wJhcwGIH3YLjx3iXba
 /TkV+2RIkNBaG3+5AVXFzUDnoN/2kusJInQcr0MjC56uCU8VylqEufjpDmd0UuTe7y08
 oI+9MYAcxvBOb/ZYkHxHHzTSrCeinUXCXOdeIL0Ww9NroMo/Jpp6BohI2uIGHXHrNP2p
 pFiktXXd2nDPxk5bqv6N5+/ieer/SFxKNZo7gLMXrIOc8FWFBL2U1K3Ry/XQb70NlmkA
 jMlw==
X-Gm-Message-State: AOJu0YzwNVFi3iinpS0U27ghZHDp9wFfj3akBPSkDcbdcjopyRKcnTqA
 zwt8i1hCxzCNPNNDw3WWcDUAxIHFUEHLEir0FiDd7t3iYngVdmJi4Bxes6ExXucrV4UcBFrZ26p
 GaT9fI8oroaE2bdPbuGzMve6NcR+KX9nCZTc3SjuwYInkg3BBczqZTQ2wiLgpz3Y8xSoTJ362JT
 6bzLs1JKy7rDx6d7Y7iNV6vdFXYUgtxckryEC4Dw==
X-Gm-Gg: ASbGnct10q29ro1jLVQ1fmp6GrEVRYhRsBm+qZkJQd1J+nA9fmywAdgR4EPNybiyLGz
 vPXlrOWsFIEyOmWnKIIaDE52dv9u7EDsX8NBa4yUUn9K3zAsPDmtOcVS5w7P6jkbYPfb11Gg/CC
 fQaKtT0KMmVN1xDhPLDF/dxO6ZR9AKrX2odSmI3UMhKtjJ1MuxwGllml5hNfIfmyFsrgY48s2VY
 VYnGFNQhsqE2h9aNBujVqwSf7JLvrlKUlpHwmONVpCfNmVROwg3vIeUR89xSzO8d/5k+sWCHuU+
 JGy2uv347ODsY1IOeSozElFv9pNAFnlwRrPxOYsY+6mOV5dzve9hvQzCiq4BRiPmKo8vl9mlDAi
 CRgNEtOgVsrQJCw==
X-Google-Smtp-Source: AGHT+IGw+c4PFPemW8vVY9tNVQnFmnXdaN4ec9dlSXyp4/t2qx3uZ+7KYOOODn1UXd3GMF9zkxbdxw==
X-Received: by 2002:a17:90b:2744:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-30532147029mr3653314a91.26.1743259503031; 
 Sat, 29 Mar 2025 07:45:03 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:02 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 03/12] target/riscv: Add vext_check_input_eew to check
 mismatched input EEWs encoding constraint
Date: Sat, 29 Mar 2025 22:44:37 +0800
Message-ID: <20250329144446.2619306-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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

According to the v spec, a vector register cannot be used to provide source
operands with more than one EEW for a single instruction.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e630f8661e1..70c19c49ae4 100644
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
-- 
2.43.0


