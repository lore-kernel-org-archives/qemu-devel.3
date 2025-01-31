Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4B2C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdnEZ-0008H1-Je; Fri, 31 Jan 2025 04:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnEX-0008GY-R5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnEW-0004Di-ES
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5BBA15C5CD4;
 Fri, 31 Jan 2025 09:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE64C4CED1;
 Fri, 31 Jan 2025 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738315359;
 bh=wtPYEkp/rYjrO4/L11LpwqkfMFGmuvFU+26iDChJ36Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eQBn0m2RQDo8qX+waoiybpG1odLY5VB/hgtsJLb0J8b70ZRh6zee6WyYb4cuF7HEF
 +brNDB2XeBnzoG7egd22D77a+PdPMGCR3vP7rmnPNFkj8/GlP0KsQ9Ywn3+94ovadZ
 1OyfrCr8KEIKbBB1+PzTTGzm957kvg3NbaVc12A2qx7kXms9nhjXgD9csNRiT9KMY7
 Xb66h3z18IUUoHjdBDsqx6IMtf4ZyUS5v0E6crFW5sO4yVCW4gH0t+WC/bbg0m1RYA
 EQBQqZZHo9ADMgHmbP310FLi2So/QxyiS/4te+nfweJDmHidvb87enJ3FOJVJrV/J8
 DlYdKtNvCXUoQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL v2 4/9] target/hppa: Add CPU diagnose registers
Date: Fri, 31 Jan 2025 10:22:24 +0100
Message-ID: <20250131092229.38232-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250131092229.38232-1-deller@kernel.org>
References: <20250131092229.38232-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Add the diagnose registers (%dr) to the CPUArchState. Those are mostly
undocumented and control cache behaviour, memory behaviour, reset button
management and many other related internal CPU things.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h     | 1 +
 target/hppa/machine.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index beea42d105..b858986c41 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -232,6 +232,7 @@ typedef struct CPUArchState {
     target_ulong cr[32];     /* control registers */
     target_ulong cr_back[2]; /* back of cr17/cr18 */
     target_ulong shadow[7];  /* shadow registers */
+    target_ulong dr[32];     /* diagnose registers */
 
     /*
      * During unwind of a memory insn, the base register of the address.
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 211bfcf640..bb47a2e689 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -198,6 +198,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT64(iasq_b, CPUHPPAState),
 
     VMSTATE_UINT32(fr0_shadow, CPUHPPAState),
+    VMSTATE_UINT64_ARRAY(dr, CPUHPPAState, 32),
     VMSTATE_END_OF_LIST()
 };
 
@@ -208,8 +209,8 @@ static const VMStateDescription * const vmstate_env_subsections[] = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = vmstate_env_fields,
     .subsections = vmstate_env_subsections,
 };
-- 
2.47.0


