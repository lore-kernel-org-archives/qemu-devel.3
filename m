Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE03CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 21:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2GKc-00059U-KH; Fri, 26 Sep 2025 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1v2GBC-0003i7-S7
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 17:40:39 -0400
Received: from smtp-8faa.mail.infomaniak.ch ([83.166.143.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1v2GB8-0007Qz-Ay
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 17:40:38 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cYPBv3CLxzr51;
 Fri, 26 Sep 2025 23:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drigo.nl;
 s=20241108; t=1758922823;
 bh=7IV/AlQ6dG50VFCe013oWT0CSZOoc8or7+uh87mPlQE=;
 h=From:To:Cc:Subject:Date:From;
 b=VIFtNJUyH1ShI93RnThj+lpDf0F/1+MQRwUJnZ1FWrKpfiGku3GjI+HjZB5m4YY2k
 NbyeUVl+r12p34bAcMEnliTbheRFDZi1t23i90nUOKzbCKZunH/9Gy4nfEcHuM1+gI
 /0jIcjqfCMHMIiar2LvFWhPSGKV9NDEkYQZzGedXytD76xpc4yeV6izD2gSGGvXnmU
 m2rlZD+FiSuZctuGImqlDvxEHeGVPH7y90FIlcizOfZIodXJBWHK3fWQ0TNLcxPVzJ
 Tx0/hAHWp/aWAQs2ThLSZVty6Bh6mJD3HMxwzhJzd8Qw0kTbVMdk+EuRTNGAkcPf+Z
 A2MDM5CQUczig==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cYPBt5DqKzQbj; Fri, 26 Sep 2025 23:40:22 +0200 (CEST)
From: Rodrigo Dias Correa <r@drigo.nl>
To: michael.roth@amd.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH] qga: Support guest shutdown of BusyBox-based systems
Date: Fri, 26 Sep 2025 23:40:11 +0200
Message-ID: <20250926214015.120338-1-r@drigo.nl>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=83.166.143.170; envelope-from=r@drigo.nl;
 helo=smtp-8faa.mail.infomaniak.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Sep 2025 17:50:19 -0400
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

On POSIX systems, the QEMU Guest Agent uses /sbin/shutdown to implement
the command guest-shutdown. Systems based on BusyBox, such as Alpine
Linux, don't have /sbin/shutdown. They have instead three separate
commands: poweroff, reboot, and halt.

Change the QEMU Guest Agent to, depending on the mode argument, use
/sbin/{poweroff,halt,reboot} when they exist, falling back to
/sbin/shutdown when they don't.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2589

Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
---
 qga/commands-posix.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 5070f27..c705985 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -213,9 +213,20 @@ out:
     return retcode;
 }
 
+static bool file_exists(const char *path)
+{
+    struct stat st;
+    return stat(path, &st) == 0 && (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode));
+}
+
+#define POWEROFF_CMD_PATH "/sbin/poweroff"
+#define HALT_CMD_PATH "/sbin/halt"
+#define REBOOT_CMD_PATH "/sbin/reboot"
+
 void qmp_guest_shutdown(const char *mode, Error **errp)
 {
     const char *shutdown_flag;
+    const char *shutdown_cmd = NULL;
     Error *local_err = NULL;
 
 #ifdef CONFIG_SOLARIS
@@ -234,10 +245,19 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 
     slog("guest-shutdown called, mode: %s", mode);
     if (!mode || strcmp(mode, "powerdown") == 0) {
+        if (file_exists(POWEROFF_CMD_PATH)) {
+            shutdown_cmd = POWEROFF_CMD_PATH;
+        }
         shutdown_flag = powerdown_flag;
     } else if (strcmp(mode, "halt") == 0) {
+        if (file_exists(HALT_CMD_PATH)) {
+            shutdown_cmd = HALT_CMD_PATH;
+        }
         shutdown_flag = halt_flag;
     } else if (strcmp(mode, "reboot") == 0) {
+        if (file_exists(REBOOT_CMD_PATH)) {
+            shutdown_cmd = REBOOT_CMD_PATH;
+        }
         shutdown_flag = reboot_flag;
     } else {
         error_setg(errp,
@@ -255,6 +275,15 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 #endif
                           "hypervisor initiated shutdown", (char *) NULL};
 
+    /*
+     * If the specific command exists (poweroff, halt or reboot), use it instead
+     * of /sbin/shutdown.
+     */
+    if (shutdown_cmd != NULL) {
+        argv[0] = shutdown_cmd;
+        argv[1] = NULL;
+    }
+
     ga_run_command(argv, NULL, "shutdown", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.47.3


