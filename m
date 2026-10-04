Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A23CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKcn-00041m-Nw; Sun, 04 Oct 2026 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcl-00040N-NJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:23 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKck-00023Z-3Z
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E23C260098;
 Sun,  4 Oct 2026 11:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A91E1F000FF;
 Sun,  4 Oct 2026 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791114200;
 bh=RE3Z4aq6YF7bGu14NJ70fL5TRX4Z2iUGzL00FPSZ9IY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fWaa5mzNUKgDvo5+RoII9AhPx4Dg+H95GdHUQGxconlhLcn6YNZlodju6bm84WuWq
 +e1OtZTv10eUDNnsw4YI227OZxYijkI4ViQFhQbZ+s7PRnGQyd5RxRijcM6g6f+LG1
 vQp/C7To+FsNDqocvJCTNV5CBU7bkG6JflArGYYxbrZQ3TRAPtG6lLvqdFNq5yC0Uj
 KfcWdjmx6PFDuo06x7JvLlhfljs53oxMRdjD87Go6bAGJWaj1ZQ9fEuDOPWRNmfb4O
 +I6o8XLyHnBOeTHhrAkg0Lnxk8tZpbho2Kg6XYdTb4Okhq8QxfNw7GY7HjaMxKEF4S
 Og65L0rtnt5Ng==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/5] linux-user/riscv: copy the executable's e_flags into core
 dumps
Date: Sun,  4 Oct 2026 13:43:08 +0200
Message-ID: <20261004114311.3874-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004114311.3874-1-deller@kernel.org>
References: <20261004114311.3874-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

Since commit 8c94db0ae97c ("binfmt_elf: preserve original ELF e_flags
for core dumps"), Linux writes the main executable's e_flags into RISC-V
core files, so debuggers can see the float ABI and RVC. QEMU wrote 0.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/riscv/target_elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 185b81a2db..e99a9d92ca 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -21,6 +21,9 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
+/* See linux kernel: ARCH_HAS_ELF_CORE_EFLAGS.  */
+#define elf_core_eflags(info)   ((info)->elf_flags)
+
 /* Mirrors struct user_regs_struct: pc followed by x1 (ra) .. x31 (t6). */
 typedef struct target_elf_gregset_t {
     abi_ulong pc;
-- 
2.54.0


