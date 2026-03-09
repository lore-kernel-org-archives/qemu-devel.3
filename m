Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDAFF3C265
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxd-00043M-Dk; Mon, 09 Mar 2026 09:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxU-0003yO-1S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxO-00067M-4C
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 77768600B0
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E68C4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064038;
 bh=yQjfyq4uMUjaesM0EhyZ3X0IrXyyB6Sp6uAxR9zq4is=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=bkmoJPPwgaEfu5Yy0Ro028CV3C8SUZK4jaUF7jPcVYGKk+OAFozuXUd3D5o+Av3ds
 F4T0eTXbai6GhkTbViEE3QcQ+IcmaVRdN8Jxa8ZuRC6hqegJj+N4d6o8bfdKIwpwEH
 808SDn8JFqO77+WKjoI35eqFB/n6JrkY4m6W8GuN8Dz+Nf8YC/LD9m3qWzcnrFqHNM
 DbyIGdaM/96K2Wtxoetaxgz04nqk3yBGrueq47qOjeh2mZiH2UqexKYHEw9sGYWm93
 iS01AyQkvK3w+4lKoiEWXsdKjj4ThW84FwdDlTzh53PqFdfBUMC0N5ZsgpfyNak8bY
 GGQ8TPm1jgkuw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] linux-user: fix matching ioctl numbers in print_ioctl
Date: Mon,  9 Mar 2026 14:47:05 +0100
Message-ID: <20260309134711.5312-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

target_cmd in struct IOCTLEntry is a signed int.  Make sure the ioctl cmd
argument in the syscall is converted to int when matching, so that it
works correctly with an ioctl cmd that has bit 31 set.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 02d610a7f8..2cbaf94c89 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1021,12 +1021,12 @@ print_syscall_ret_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
         int target_size;
 
         for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
-            if (ie->target_cmd == arg1) {
+            if (ie->target_cmd == (int)arg1) {
                 break;
             }
         }
 
-        if (ie->target_cmd == arg1 &&
+        if (ie->target_cmd == (int)arg1 &&
            (ie->access == IOC_R || ie->access == IOC_RW)) {
             arg_type = ie->arg_type;
             qemu_log(" (");
@@ -4359,7 +4359,7 @@ print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
     int target_size;
 
     for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
-        if (ie->target_cmd == arg1) {
+        if (ie->target_cmd == (int)arg1) {
             break;
         }
     }
-- 
2.53.0


