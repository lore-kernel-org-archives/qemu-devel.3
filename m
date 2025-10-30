Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE74CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESSx-0002rU-Vq; Thu, 30 Oct 2025 09:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSv-0002qx-AU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSl-00042g-2C
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761829973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pqIhG9Aw6HT2bjo4OsCCjTQyamNWt9kCS/4hog+/9I=;
 b=KA72ipPwVMXPwUOd649HESjE6rkTOyRvT8aFvXK4MU4hh7ahZI5p1DJTpl/Cg/f7p74Ken
 D/ZIhhc4thcqq4wRlXWZy3TmHbKwjOno4H1W93kABFkFYxgmD/Y/Wlu8ynSyIN0rhpjZdd
 mjWCmOmM04NGEfkQpyB1ah9yu695swQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-ncG15Z-LO1-ONL3YQhbJew-1; Thu,
 30 Oct 2025 09:12:49 -0400
X-MC-Unique: ncG15Z-LO1-ONL3YQhbJew-1
X-Mimecast-MFC-AGG-ID: ncG15Z-LO1-ONL3YQhbJew_1761829968
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 800381956054; Thu, 30 Oct 2025 13:12:48 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.177])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AEE719560A2; Thu, 30 Oct 2025 13:12:46 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/3] qga: Support guest shutdown of BusyBox-based systems
Date: Thu, 30 Oct 2025 15:12:37 +0200
Message-ID: <20251030131237.181588-4-kkostiuk@redhat.com>
In-Reply-To: <20251030131237.181588-1-kkostiuk@redhat.com>
References: <20251030131237.181588-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rodrigo Dias Correa <r@drigo.nl>

On POSIX systems, the QEMU Guest Agent uses /sbin/shutdown to implement
the command guest-shutdown. Systems based on BusyBox, such as Alpine
Linux, don't have /sbin/shutdown. They have instead three separate
commands: poweroff, reboot, and halt.

Change the QEMU Guest Agent to, depending on the mode argument, use
/sbin/{poweroff,halt,reboot} when they exist, falling back to
/sbin/shutdown when they don't.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2589

Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250926214015.120338-1-r@drigo.nl
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 5070f27d75..c7059857e4 100644
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
2.51.1.dirty


