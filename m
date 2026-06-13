Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C699CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV6E-00029v-59; Sat, 13 Jun 2026 16:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV64-0001cl-5w; Sat, 13 Jun 2026 16:36:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV62-0003HH-DT; Sat, 13 Jun 2026 16:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=y4R+0lv/Ip/IJfxR+IGI+lwzpO9fm3pE+KIrDmMRibo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BrvpSCKXYxhf0H3OoggXlpMor/znEnXq8ajO+40CPzTc6dbt2O5i5O2iRoOQ3Jmfl
 mwjlL0ZEZXu7iY17hGLPso1ApZZadXhfpf/EbIHYfGb2YBHwMBAVuZvXGq6YsRFaQ+
 8XodHW5TnSp43Ftc/HJgSQhRcg3GZoaInvKEgS/VLqCmAdglFs6JeX5UKBpXf1Ggsw
 TprvS2xQWmKzFijehYbli0Uk7ZALDOqZsY25rxZNTcTTn4UQON4+ZgFLuiQA1zO8Sk
 TpnQChF1/6jCpP+ZnwiUWQBp/ZuO0Fl7GN1ChMHnK1QJLj2gACVRYJ/CtqsGtRBs74
 hDvotAAfazXsg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 132881B6EE5;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7C72B3CE937;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 11/72] target/riscv: Update the local interrupt mask
Date: Sat, 13 Jun 2026 23:34:37 +0300
Message-ID: <20260613203542.1809153-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec describes bits 0-15 as standard fixed interrupts. The
AIA spec on the other hand describes bits 0-12 as standard fixed
interrupts. This conflict causes issues for us as we don't dynamically
determine if AIA is enabled when setting the *delegable_ints consts.

This means currently we incorrectly treat the LCOFIP bit as delegable,
even if AIA is disabled, which is incorrect (see the issues mentioned
below).

The AIA spec indicates that implementations can determine which bits of
13-63 in mvien are writable, so let's just make it bits 15-63 to match
the main spec.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3134
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3135
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3138
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3140
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260513051841.1671987-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 27f9566dcd98bdde045ef5ae7b8199456c8a51c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 35e98df420..d65d176fe8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1764,13 +1764,13 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 #define VSTOPI_NUM_SRCS 5
 
 /*
- * All core local interrupts except the fixed ones 0:12. This macro is for
+ * All core local interrupts except the fixed ones 0:15. This macro is for
  * virtual interrupts logic so please don't change this to avoid messing up
  * the whole support, For reference see AIA spec: `5.3 Interrupt filtering and
  * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupts for
  * VS level`.
  */
-#define LOCAL_INTERRUPTS   (~0x1FFFULL)
+#define LOCAL_INTERRUPTS   (~0xFFFFULL)
 
 static const uint64_t delegable_ints =
     S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
-- 
2.47.3


