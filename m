Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C3AF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxi0-00085Y-JA; Sat, 07 Mar 2026 14:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxhy-000851-G3
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:06 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxhx-0008Um-0u
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B8297419DB;
 Sat,  7 Mar 2026 19:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70771C19423;
 Sat,  7 Mar 2026 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772913183;
 bh=yQjfyq4uMUjaesM0EhyZ3X0IrXyyB6Sp6uAxR9zq4is=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nLe/FlHBJfO649QuXOXXPGqzRwOH3LxaqrP34Q2ci2NK28v7JNq6zDkPxrWw7o95K
 6YKsJ+6K/HKTUBqKMkzomHrfUKUbk0jL7SMPnMcCzRakUl9ZSktUvyVI/ONGi4czKV
 4YHxEpXJ7P65CxITYlNa9xF1SZPHxKej2kBBmwhVd2gVdEY8LnGGdaa+X/r9ffTEzN
 GAqvYDiMODU4NK7PI7rU+LYNon8WgqRe9fvzkLFZrR6r71Jdyv7vph6Vk/aMYgDW25
 fmUlrrUszkJMfRyDYEAoqaCjmYCQ0Uhy8dyJ7mNgZEs8z7KW+Fsq4WG0/MihbNT5t1
 ejbr38DcVufAA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/12] linux-user: fix matching ioctl numbers in print_ioctl
Date: Sat,  7 Mar 2026 20:52:37 +0100
Message-ID: <20260307195243.8813-7-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307195243.8813-1-deller@kernel.org>
References: <20260307195243.8813-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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


