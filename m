Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A677FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHws3-00041a-LD; Wed, 29 Apr 2026 00:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHws2-0003q8-DL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHws0-00007c-Tm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b2503753efso125122475ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438195; x=1778042995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxLLYH9MzoUJ2vk/paiI+vtwF1wl9GSiiqD56bk7rlg=;
 b=YhuOmwpPEdGml56UBOnB6aAfsMKsfBj0wWYkBksJp/hezPNkfOWQQ3vObSArOLSiBU
 aAWcL6LMG73PYohLNtEt/8TqmB8CIP8VJ5QSftSiTxOELEGTPlc4IxkLBgosvdBJ1tv/
 J9VZsmAxYpGJaXbHZ7YcZBYqDU/95gOhiAabZ+q3bvXqqRJ7aI/l/9LcblYh33NqXq0Q
 5/6t5IJJMweAYNErKv5W2hk0hYQCApCQUUmgK/Tzp1+wiAn+lsR42j9lybTLifqViqEl
 tigAxl+WbXU3/x8UuBSsV0PLcNQQjABatEqfQd1wuRzSh9WBlI+wB6ZINf6F0hJRGpnj
 vt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438195; x=1778042995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hxLLYH9MzoUJ2vk/paiI+vtwF1wl9GSiiqD56bk7rlg=;
 b=eXCI14iqPbmiF13G5/LQHMtqwSgdZmmryIuMfV8eXptPCB/jgoQ73f9ytxILsaWisk
 u+bCBhqlLmL2RbifeTUVls+vZE+rD4xPZQKWv+B2IHRX+zNJtf9U5icmdbRD+MA78CSu
 XLz5sQqsnCPsZkgsAfsWnY1I2e8FVfmD3RisyGWChMC7ozse53eWQIqXYVsdOPZJZy6w
 iIWWWc25zros7i5rnvB4O2b/ZQFndRq48pfvk3gylGyxo6B1ZlpRHZcAx08lXWHIFLna
 PPoKndBv5OZj7kJbWcr9UV99g9sY50OQspm/vmAzNUrPFBnDcWTYjoXGe/CDtDwgnEMN
 QU7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ92FLc5c+heI5t7GoP4uOz/Ptfw+PnIUSR80trJTH/OVqICDLlyPiRxehn1TIgr+cvVsJ3quPvZuuih@nongnu.org
X-Gm-Message-State: AOJu0Yyv4s7NTCYFze+tk17ygqmr6nW9Mb6QE/toI3z2Pp/7ZoJKXSkD
 o/KTdqcQo0FSMypG/Pc3z+6vEx/pLMiklTA7g2fyWU8VIjxVukWAupAk
X-Gm-Gg: AeBDieukMD/9WykOqABW0HJ9CDZea6hH+7wP8WCu4CbjOJgDmWq50dwV34/RAvA9TjV
 0StkvwAW6bnd5JwPEX7iVDham66iFYwQexySpyjyzobSR2ZYwPmE3hsKo6+ZZPDhuStGMTfvGws
 8zmLYvSZKamjCNmkZsD6pYUkO5faAMXsywkmfhfQodY9vnvl6sFHtKUU708LQUMkkRXzVdY9ObJ
 je3b08Lj2uHmhE/uIe/T9lwnr5oTordDx+AO/yOaoDEgzbHWJ1jRafd8hb8lmQSP0benkIIvYt7
 cZkf12u22FvZSmIDGu0IHUpNSWvehb2EIQLIkim+pSxwbhiha8oCE6CEPZvTTZ2zrQSPWydvCEz
 F1xBvc8APeQ3y4k/2gtyMuAygE4GCitS7/1ofO6L0geM/TFhHinX5uU9eUNcN8+tPK4ZpNr6MNs
 Xkd/0AABfhclGXm5QHrWWCHjIR/bN8YqnyAUTUdllPJsCrGhS/SNevFww0odq9YRo=
X-Received: by 2002:a17:903:2c9:b0:2b2:42da:25cb with SMTP id
 d9443c01a7336-2b97c4aa15cmr56774395ad.19.1777438195628; 
 Tue, 28 Apr 2026 21:49:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/51] hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support
Date: Wed, 29 Apr 2026 14:47:22 +1000
Message-ID: <20260429044752.4176397-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Jay Chang <jay.chang@sifive.com>

Add proper RW1C (Read/Write 1 to Clear) support for the IPSR.PMIP
(Performance Monitor Interrupt Pending) bit, which was missing from
the IPSR register implementation.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260325050011.66722-3-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 47fe01bee5..a938fd3eb4 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -189,6 +189,7 @@ enum riscv_iommu_ddtp_modes {
 #define RISCV_IOMMU_REG_IPSR            0x0054
 #define RISCV_IOMMU_IPSR_CIP            BIT(0)
 #define RISCV_IOMMU_IPSR_FIP            BIT(1)
+#define RISCV_IOMMU_IPSR_PMIP           BIT(2)
 #define RISCV_IOMMU_IPSR_PIP            BIT(3)
 
 enum {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 8476405d0e..7ba3240552 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2150,6 +2150,10 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
         ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
     }
 
+    if (!(data & RISCV_IOMMU_IPSR_PMIP)) {
+        ipsr_clr |= RISCV_IOMMU_IPSR_PMIP;
+    }
+
     if (data & RISCV_IOMMU_IPSR_PIP) {
         pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
 
-- 
2.53.0


