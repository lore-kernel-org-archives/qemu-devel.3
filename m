Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B48FEA853A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHxK-0003my-8i; Sun, 08 Mar 2026 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHx4-0003gs-05
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:04 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwz-0003oP-SF
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:00 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E2AE9600AE;
 Sun,  8 Mar 2026 17:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83375C116C6;
 Sun,  8 Mar 2026 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772990995;
 bh=yQjfyq4uMUjaesM0EhyZ3X0IrXyyB6Sp6uAxR9zq4is=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MaltPUDf96x5QiTRn/Wxfn67H+Upu2aP92/UMbCDS0WPZGHQ94822XKRqATgkASCh
 PT9n3Qy/pDirYQHMobHz/uYdkdOEUMF1JRUkCR9LvPeGP87NN5UEyaif8dvIGEIV5J
 7cHOg6gOZ3En/2As3hgT9558yGj9+WKLsK5O8KdnDhuNzeV2ySSV+PUSK2oUH5B8Re
 lBsAJu0dOCXYxEbCB9lyZ15SRXDHPt0mGNb+1Iew8DKZrDIkeVv5RoTv3qNl1kj/5r
 zwzZloeZ/zEKt7R19lKs2vr9rhrBAfpimBx452O+d1Ow99Zr/yGJViilGYNODV2moj
 938t8ofvemzPQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/12] linux-user: fix matching ioctl numbers in print_ioctl
Date: Sun,  8 Mar 2026 18:29:30 +0100
Message-ID: <20260308172936.2835-7-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


