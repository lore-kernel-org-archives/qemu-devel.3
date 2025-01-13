Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B675C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQMJ-00041O-3k; Mon, 13 Jan 2025 14:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tXQMH-000415-Dx; Mon, 13 Jan 2025 14:44:21 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tXQMF-00067F-PK; Mon, 13 Jan 2025 14:44:21 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-304d760f12aso37888871fa.2; 
 Mon, 13 Jan 2025 11:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736797457; x=1737402257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ONUJOWTG5K9m4BMCbayoJ5whJsmuCoQNiYV/XCFpdck=;
 b=HscUpl3nYAVIxe/Kt1S0E5svALpRpwhtmptpONriyX6VvOV+V0OktzbVPwYk/Chnf0
 qLlYVrJVuu6656WjgDQJyoOxZ4xx6/n73JrNFvpyBLBvkCvqs4V7QmVKnzTZeIQPm+RZ
 q0gbWnKajqFpXTU+OOb3sMl5vz8EVFOoEAaqLWmZdCLEPYEpmQwNRjwuf8lc0dwjAei4
 WyYuCyfyC531h/OlgDE+G2DtNx2N976I0JBZ4llpHhUt45QjPfJxgsGOmxh/8I2iNVRa
 2vjEG2w3mFUXZkqFC3SAbrJPt0iM+d81ak7F/IGKjfUQvSVS1IUG6kMBthKV6zfRy3oW
 zHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736797457; x=1737402257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONUJOWTG5K9m4BMCbayoJ5whJsmuCoQNiYV/XCFpdck=;
 b=VTHO0sLxbmU4fFa6PwgJiQUvPGoNU5F/CvFQ4W5JfO4sDxbtPR16UEMX/BPd+QQpr+
 CgkKcAkuJ9FZdOa7B/8AeiGiey5bwH+wHDvgDvQFdgv7tF8346fcfqePodS3hl8vMX/H
 wUAtARKkXO+rAjSZB3f5I3LyMliuB9Z8Qcg53fg5h0xSIa3syEz0oOAaxJlDs8i9TZrw
 Zp2DA6f9aZKBspI0RNmfF7PuRsRJOrhoeCsmnFuOjSWObQ7w1I9KIU8BoBNTlKusw5R5
 IpESu/fpbsOCLSaWhp8W6sgwbuggrfJw3Um+Qh3jTWjuYMzZsTjvrjsz5i1HR9K6w/Mx
 4RyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZQuc+MLMExOYN6uMei7jvc5R3bt3b+dc1Z/DVpkt324weCjuRo8/yxbfwMWEOgMQKueMV/fxqphRQA==@nongnu.org,
 AJvYcCWjsMG41/pFCxf58t8nE9HAhxDfPXToVAFTn0HsD41DaRyt5xTPgtBnuOCJCnWchRTcxHg1sXgMYWDi@nongnu.org
X-Gm-Message-State: AOJu0Yz4e0v5gO5wrDW9Sx9IJUmwVd3q+B64df8K18kIfhqYCLtJd83z
 DhT7DDjJQmCk0Qm5LnNCH+oZuUlc080MA+bQxbPkL0SjUfwkY1Vk
X-Gm-Gg: ASbGnctONkrvAYz78bF4h90W+6dlpq26MeRizMpe4jbGwPoF6zzbMViyStXIIk2APPe
 QQxm52mg7dm8hiHmBQp7eZhMBkkVaocsXH0B+GDarR8Oh6kdQNrDlWZMp7Cq3PIjnyMxquS2bRB
 S/T4KYXiDR2zoq9OgeiOHY8lQoUv/QDsWZJdpsIu9aC/WPRp00QiNvUVAn9M6xxt4nbdsfrx+dS
 KSKvHZLRgi8nLpWVqxin0uGSIhr4bbd6Jk/teQj4hLj+b/QPxGR7Qxd6S6v
X-Google-Smtp-Source: AGHT+IG6ZrejOpLPU8JUO/TI/z2bFCuqXw5k/G/8D/GpfBknVfXKHOhd1yVewSrXjoMq7Kep9Z+FKQ==
X-Received: by 2002:a2e:a9a8:0:b0:300:324e:3506 with SMTP id
 38308e7fff4ca-305f4575d06mr73071931fa.13.1736797456849; 
 Mon, 13 Jan 2025 11:44:16 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-305ff0ad592sm15738381fa.20.2025.01.13.11.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 11:44:15 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, frank.chang@sifive.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2] target/riscv: Support Supm and Sspm as part of Zjpm v1.0
Date: Mon, 13 Jan 2025 22:44:09 +0300
Message-Id: <20250113194410.1307494-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Rebased against alistair/riscv-to-apply.next

[v1]:
The Zjpm v1.0 spec states there should be Supm and Sspm extensions that are used in profile specification.
Enabling Supm extension enables both Ssnpm and Smnpm, while Sspm enables only Smnpm.

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 23 +++++++++++++++++++++++
 target/riscv/cpu_cfg.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bddf1ba75e..3d4bd157d2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -208,10 +208,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1625,6 +1627,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
+    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
@@ -2781,6 +2785,24 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SUPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_supm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET(ext_smnpm),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule SSPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_sspm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smnpm),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2799,6 +2821,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
+    &SUPM_IMPLIED, &SSPM_IMPLIED,
     NULL
 };
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aef896ba00..b410b1e603 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,6 +139,8 @@ struct RISCVCPUConfig {
     bool ext_ssnpm;
     bool ext_smnpm;
     bool ext_smmpm;
+    bool ext_sspm;
+    bool ext_supm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.39.5


