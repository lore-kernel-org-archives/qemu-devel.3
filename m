Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FDE77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfuE-0003mF-MF; Mon, 06 Jan 2025 00:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfuB-0003kG-BK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:43:59 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfu9-0004JV-Ot
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:43:59 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21636268e43so14402465ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736142236; x=1736747036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lo+Qbn3A7nMoxmaDM+Be00oVtg6NcANgPSVAsqKGf7E=;
 b=ftXFen5IkYPY1kBbq04QjW+HC2BfNKqMBXykkqs39vJZDsAMTg5vg/YwfwS4HgK6X/
 uq/Lz6xcvTJID1sdLGaP04+icXrhgmvB+TnO1cORZVw4MGQYNEBcJmPHP1QcEfILGacA
 oHUAdwJm7BcBJfW18okvWOcSmFMwzPjaeFEtP4nZH6G/3kjAMsQ1COWwhs4w8wPnb3+U
 fY5cWfEAI6hCOPUwUS7Kwo8SzsTr0siv5nH8aLSTp6DaW3eQMFoxbSqKmockvI3/Uhld
 1kG5CSjUEEkSvNmLGVkWYbP1QIm1kxrHvc+zuQ7GhjPzN/mUQRbiPvEYVb15jy52/TIt
 zLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142236; x=1736747036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lo+Qbn3A7nMoxmaDM+Be00oVtg6NcANgPSVAsqKGf7E=;
 b=GijqiXvF8Ve4YDuH1/zxffo4/P5FwDZej3UbkqB11Xi/Y3yCoHylKJX4h9bQOIpecs
 BfjXGfDjvwgI8AadsEGnldM9z1JY+jgPnaN0KUHmWuJgsO60jTAOh1QV4hxxuQwU+vnV
 WCGtnUy8jbacWz42qNqS3tPSsU1aR7qBqW6aYwXmGHHoz++SzU3bWRieQFu6t709z1Rs
 EMU8x/IyLCkhoMwPs9FaJiZzgJZH0/fwZedQoVDu/p1zXewMdBP5k34L5+wKjW96NWQ2
 8hqjEH2QNNNsHyY6oySU7QVQqi2DqabnrIufMEjmWjDYTdBQX4eud454/coa2NGvL+MP
 ME0w==
X-Gm-Message-State: AOJu0Yw0cMPdGXw0n4rBwq8D1PJGGngUsOuUBjZNMNKsdW1N/VNctrdV
 VRAUm38WqOxBVM/VWCsy28X/T8tJSwe4KAlEFjfaMA3zK7Zu9+qS7UOBrgBuht9468wo30VJWeM
 LRMTlyMrvCEnrA7R7p46ZBb0iZlbO5rXh11Mp+L4PP4jkvxv5gZcJuKtVyzxe+xers9Gz2/wyDz
 0B7Vk/tWSg8gqAPIxmz3BF1qd2kVO6mpQ0lqaSrVCulA==
X-Gm-Gg: ASbGncvBE3gfFW0F4mksmZ/Uh1Vh1wvXB4OvK7HLDKrfVo2Sy5phAFXnDkoKx2JLZmk
 JffK/HqjC2nDv1sNOfQgK5OIL0QsygL2BXmTQQeMulXvacMcIOF47fZSFKvcQHeGAGDON/BF/a8
 prQ8gKqUUHlYQKeSgqqLcQkidu3WyHzjyz7E1RHbGSPiicCExasxnCxgrzjFmZPHNzIjTIRy82j
 XMp4sdkCtHMMcVfQB089SxsorDr9bA4jkb2ev5e5YetAmWw4/0L1ijiy+MjvlHt5pga/zekQCr7
 QyG+JrLtKc8=
X-Google-Smtp-Source: AGHT+IHWU++NW0+tcazJZn6R+qRAOGkTkpbSd0uEs/QRr0TocMp7y+iFfioTubbETH7rRfffIXg79Q==
X-Received: by 2002:a17:902:c40e:b0:215:853d:38 with SMTP id
 d9443c01a7336-219e6ebb75bmr790968905ad.25.1736142235769; 
 Sun, 05 Jan 2025 21:43:55 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eac6sm285722215ad.80.2025.01.05.21.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2025 21:43:55 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v12 5/6] target/riscv: Add Smrnmi cpu extension
Date: Mon,  6 Jan 2025 13:43:35 +0800
Message-Id: <20250106054336.1878291-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106054336.1878291-1-frank.chang@sifive.com>
References: <20250106054336.1878291-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62d.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

This adds the properties for ISA extension Smrnmi.

Also, when Smrnmi is present, the firmware (e.g., OpenSBI) must set
mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all
interrupts will be disabled. Since our current OpenSBI does not
support Smrnmi yet, let's disable Smrnmi for the 'max' type CPU for
now. We can re-enable it once OpenSBI includes proper support for it.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 29d530ad85..d9bc0d124e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
@@ -1621,6 +1622,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e03b409248..9cfdd68fdc 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1431,6 +1431,15 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
+
+    /*
+     * ext_smrnmi requires OpenSBI changes that our current
+     * image does not have. Disable it for now.
+     */
+    if (cpu->cfg.ext_smrnmi) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
+        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
+    }
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.34.1


