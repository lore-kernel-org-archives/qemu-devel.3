Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF79CC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiflx-0006vJ-9t; Sat, 11 Jul 2026 18:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflu-0006rz-Ak; Sat, 11 Jul 2026 18:02:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflo-0008Ke-3Y; Sat, 11 Jul 2026 18:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=27p8mXYMM4XTshDOy58mBtIzoX97mUrxGvNlTsfj4oc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hciuUNa8NCqhZ1ObEeWmEwLTwPlEEvXczofFNWCTQAcY+xBfLTy56BoyYHikG5z0j
 zrb+AhXmhML18A8tFMuT37AVfk2f9tvrR9hkq3RiOfBGo+9Ee2RHH/szcp2OJiJuJ3
 hQZzER4pSlZBlkbNUaVTje5XXpxa1fLEH8DPfOtfg4wa6zTlq5EghLR38M6Vby6DXS
 hJazufsrrbLAvMpKCSdOjMoNR04La8cvGwgqMYzTwPBwbhpDnOkHTVZV1B4sK4caK5
 2t+9FXPF2jJoJoVbCMOMwFgMgLuVPaXOkOscSGRFQbVEom6OMdqUfhPcmuyYxGVJ6T
 deRJ6xwAFWnhw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B190D1C0AA6;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 68DC03EAF31;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 74B7F13319; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Inochi Amaoto <inochiama@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 27/81] target/riscv: Check PMP before updating PTE
Date: Sun, 12 Jul 2026 00:58:05 +0300
Message-ID: <20260711215904.3757-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Inochi Amaoto <inochiama@gmail.com>

According to the RISC-V spec, the PTE update is a supervisor write
operations, and it should also follow the CPU PMP configuration like
the PTE read.

Cc: qemu-stable@nongnu.org
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260622113402.563196-1-inochiama@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit fa2cf7488379d9b14041a7bcd76867c9bdad2b5e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 665d0f71818..c74b04f5b2f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1601,10 +1601,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
+        int pmp_prot, pmp_ret;
+
         if (!adue) {
             return TRANSLATE_FAIL;
         }
 
+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
+                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return TRANSLATE_PMP_FAIL;
+        }
+
         /*
          * - if accessed or dirty bits need updating, and the PTE is
          *   in RAM, then we do so atomically with a compare and swap.
-- 
2.47.3


