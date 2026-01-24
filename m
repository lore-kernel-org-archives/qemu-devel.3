Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA998D715D6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZOQ-0001pj-Sg; Sat, 24 Jan 2026 03:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZON-0001mG-O0
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:15 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOM-0002PP-F1
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FE2860053;
 Sat, 24 Jan 2026 08:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3754C19422;
 Sat, 24 Jan 2026 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769244792;
 bh=HqPNF33+yuQjENJAc4XJjvbKHOUTbEiw7SICOVHDfOc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d0RM2Y+GwFl4G6Qp0F4Atnf6YgjnQBLvUR2tOsA3vz824rQF40Lr3iEBY5Z//ZFwe
 MXhkll/k0iB6kSdEcJgyBqLER7mlKNn15BJCASXiebHdUsqogZSQVedbRB4WFhwB9k
 NQHXEwHNAhxJ+YSIhmtjtgPHgWczTmAnipjUtBi0/TA0+WTm9Db6PfjyBKTQLQgHGV
 brGmltrfa5zHf8wfcYtoiD4ci0+CRLXd2GQmF3VpgksmX87JeuhzRTeq3c3N2883s/
 1mVgaLZZcVPVpI6qjTNTR8BAClTSUK6AL3+NnsLxIPyu8MJA6FAvNkMqeBzNQG3D9J
 fN0tZfTlNAeRw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 01/11] linux-user: update statx emulation
Date: Sat, 24 Jan 2026 09:52:56 +0100
Message-ID: <20260124085306.3996-2-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124085306.3996-1-deller@kernel.org>
References: <20260124085306.3996-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Andreas Schwab <schwab@suse.de>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c      | 3 +++
 linux-user/syscall_defs.h | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3601715769..24046c7eeb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7882,6 +7882,9 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
     __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
     __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
     __put_user(host_stx->stx_dev_minor, &target_stx->stx_dev_minor);
+    __put_user(host_stx->stx_mnt_id, &target_stx->stx_mnt_id);
+    __put_user(host_stx->stx_dio_mem_align, &target_stx->stx_dio_mem_align);
+    __put_user(host_stx->stx_dio_offset_align, &target_stx->stx_dio_offset_align);
 
     unlock_user_struct(target_stx, target_addr, 1);
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cd9ff709b8..6ae6e1fa13 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2734,7 +2734,11 @@ struct target_statx {
     abi_uint stx_dev_major; /* ID of device containing file [uncond] */
     abi_uint stx_dev_minor;
     /* 0x90 */
-    abi_ullong __spare2[14]; /* Spare space for future expansion */
+    abi_ullong stx_mnt_id;
+    abi_uint stx_dio_mem_align;
+    abi_uint stx_dio_offset_align;
+    /* 0xa0 */
+    abi_ullong __spare2[12]; /* Spare space for future expansion */
     /* 0x100 */
 };
 
-- 
2.52.0


