Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEBFC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 22:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcuNt-0002bK-T9; Tue, 28 Jan 2025 17:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcuNm-0002ZW-0w
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 17:48:36 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcuNk-000249-GI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 17:48:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 16E0CA41454;
 Tue, 28 Jan 2025 22:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD28EC4CED3;
 Tue, 28 Jan 2025 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738104509;
 bh=FNz0iSSnQ7yEUot6PeU17QUVLyWFRWyb6UYbabOD1Fw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OvcM1vmCbQR5yavVPO6eJHR7is0IHoghg75FnRfv3+x0Qw1hvf4fOMz08b0fl6PGP
 yzuDUeFCMaGLgrqQXHvixlarkgbdHe7dkrp2E3FrhKWOYTonOkO8JZRCrosTjWdQq0
 EgMLKXwZCU53hTQ0iktqdRUoAPi6x/utT9fPi3ck8gWDQaamlMYArhAyuGVe/o1L4G
 lKhFQmdAGjD6wgOOSjKf91x4bJ3QZ2xt0HA2BhIxf4COL8m8CBFRrP7GazHfEw55cu
 6A9oNZj4DNqyfWUffZEbcfSycXThVmfgCyZbyztH95ie5IMrksSuXuH9ipHdWJ3sKm
 MapLXvZKhlWvg==
From: deller@kernel.org
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 1/4] target/hppa: Add CPU diagnose registers
Date: Tue, 28 Jan 2025 23:45:41 +0100
Message-ID: <20250128224817.24715-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128224817.24715-1-deller@kernel.org>
References: <20250128224817.24715-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


