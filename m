Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FDFCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNrP-0008VY-Va; Wed, 24 Jun 2026 09:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNr8-0008ET-QC; Wed, 24 Jun 2026 09:41:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNr4-0001p8-4H; Wed, 24 Jun 2026 09:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308001; bh=mYIBBPM2w05ZoQ5erEn848OzcrIcDR1XfzXNWI3y9ow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gnLjWM0EKu63647scxGZkGoYtl1HTb/XQCvnrcQdgFDpFX/eiQ8xqsygh57Bn3Mwv
 oM8wGU8zJfw2PMIdAfe8SP6rUGS/kdXt587KinOv4Ma3MjpsQnkHBBDPw1yH7ldLMO
 aq9k92/hz5xkxrLxDWGO39Rxvak6NTyxaZWiltun+HOAtqITI6XoWoaRfE6vADr91q
 t/gX1qdzeRZfv/nsWJ49Bi+UpbW5b+AsQkVRLpVGdwpVtm+2LV6Y7ol2gGx+NmGyOr
 MLn3Ztk8vq1+KHd8ucJ/MGqwTUtE+VRZz+GHwSW4qWd2TUOpSyw24hohjGs/5C84QO
 UafKnkqNJJsiA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 107331BAA05;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9F7A73DEA54;
 Wed, 24 Jun 2026 16:33:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 083/107] target/riscv/cpu_helper.c: allow
 LOAD_ADDR_MIS promotion to AMO fault
Date: Wed, 24 Jun 2026 16:31:28 +0300
Message-ID: <20260624133301.403266-83-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

promote_load_fault() is missing the promotion of misaligned AMO load
addresses, i.e. RISCV_EXCP_LOAD_ADDR_MIS should be promoted to
RISCV_EXCP_STORE_AMO_ADDR_MIS when RISCV_UW2_ALWAYS_STORE_AMO (i.e.
always_storeamo is true).

All other load AMO faults are already being covered.

Cc: qemu-stable@nongnu.org
Fixes: 98f21c30f5 ("target/riscv: AMO operations always raise store/AMO fault")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3503
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d85a4ec06a65ccdd5c7d0f00b3e6695fc14a547a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 22bab45e68..f631d008bd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2124,6 +2124,9 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
 
     case RISCV_EXCP_LOAD_PAGE_FAULT:
         return RISCV_EXCP_STORE_PAGE_FAULT;
+
+    case RISCV_EXCP_LOAD_ADDR_MIS:
+        return RISCV_EXCP_STORE_AMO_ADDR_MIS;
     }
 
     /* if no promotion, return original cause */
-- 
2.47.3


