Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC37CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn39-0003cA-77; Thu, 23 Oct 2025 00:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn37-0003bo-JU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn35-0001MK-Gm
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:41 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b6cf1a9527fso201117a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194137; x=1761798937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji4shPZHeVuFPFGbQIu+aRs3sBpvbjk/q+L3MTshawg=;
 b=Z2+7uoFRxyQFfvImIfJQpcxkpo1J3ns6VgOtHgQ5yiJ0rFAlwjUI8C+azyyuSDZlNE
 rYOl3kAT1GjoRDWFFzcnuT20MyKQQ8n4Hj/guZfj2hJUW/WTgNxty+uovDgpOpEvOgEF
 eXWOV2kMsfaIX2MOj9qhFhtVhudA+1+lZlGKAYBkvoRUlNbx4ntxaNcZRdseIiUC6zFU
 M11btGrYeAD6p1awZwOBigznXC0jdMyB4BbbH91Q2jlb8ob5eDCrNevHBAHAFSgrq4ST
 i9Zk37KmQ2xGDwxMR22uxisuRFuf3chAZ8zViMwyDZcgc2bx8PnqP2mc7mTZesAhr8yC
 YFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194137; x=1761798937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji4shPZHeVuFPFGbQIu+aRs3sBpvbjk/q+L3MTshawg=;
 b=jWBbOz8/iKQCmLw6Ajh5jFab7bAq8erw1fM3DGxoxZweFHigfYdfNMPNBfPa6EMzJy
 smhi4CzZJuJgVZtREYQTu6S4FpD1S5bIT6AXKDZeQblfE7qujr5oGAR+hZUj/SOQ7lPn
 RjYMi5JmafFUYB1HqQvHMyh2zuIPIe5XIUQSMIsCPH8RE2ld8Qz9WHiUSTsfM8PRHPaq
 0tKXpDkfZ8eF1Si7okIODgvsnPI0NdUOoZdHsRrnI+iscNV6NZtpAEJKXF8JdWLuRloN
 bod3V9cRdCO2tlhvzsXH+qKExt3j+GGILUrj+FQ6GIheR5WvIclj/6UEqJSnIS9jgcrl
 990Q==
X-Gm-Message-State: AOJu0YzbBpOln8T1lqgg6T/IcLRq1XZtPITyiF27tN2MjFBFukPF/HU1
 37RqpZuoa5x4UJASNHj3n6u55NlQF7joVneTaCuGguRxWnvz+BDYZHZXQZQT9A==
X-Gm-Gg: ASbGncs6oiAgbWJz5Y/4PoTtcSQ78qOXmqi/456DauPw5Il0YLpnst23yh1NOdiGtjV
 Xn/x8ptzgToifF/lNlvNpaGGFSwLOTGCp+m8tNvRNlR3giYy0URJh+71zGmQCZEs1hohY1oIxyZ
 LYHSSpZHxA+uHooEQC7e2sn8mfqWQ5Nxy8WGrXgEhXka6VJwFdGVbAP0DsAeTRdD0YZtAPHDXzs
 HvxmCwON+OdIXtudwQn3a0bPLDItZEp5N8Ei+2Kc4Ep/OvKMl8g8StfnjEefBeLDh8aQRTRUaF6
 TiU/AwAcAYrEmQP7mXSfIY8IGIM66EqdXhAIEYtqe7zp9X8PQNNW6Y6CRvzxBY67jWZ9lNSGPG/
 NDhdPrrJBzHwGJQggPE1i2eKlhUsyZQa4bcZguCRbCJXwYl8QMYCZA9yr55Cntu+fHNEyFjgrUo
 8blkfJQAY5Lcy/i3ibURpuCOHVK5AEyEuyh53qUPt1z9uQAzw4cBvtKYPK2hhEs+H61a3jDQmOt
 fBTglln
X-Google-Smtp-Source: AGHT+IFTnroIkajhsNDLSJWdlgUvIDpJjwryd9PqOweRkRmDRN2exsDTpnLrUudUZvuSMumJtiGjow==
X-Received: by 2002:a17:903:1b64:b0:293:639:6546 with SMTP id
 d9443c01a7336-2935e0f9701mr40381875ad.20.1761194137292; 
 Wed, 22 Oct 2025 21:35:37 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/37] target/riscv: Add mips.pref instruction
Date: Thu, 23 Oct 2025 14:35:07 +1000
Message-ID: <20251023043520.1777130-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-7-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/xmips.decode                 |  1 +
 target/riscv/cpu.c                        |  3 +++
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
 
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
 
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a290303ee7..dd3ee7ba2b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 
 BOOL_FIELD(mmu)
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
 
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b0a1de6a26..e259ff0286 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
 
     { },
@@ -3297,6 +3299,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
+        .cfg.ext_xmipscbop = true,
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
 
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
-- 
2.51.0


