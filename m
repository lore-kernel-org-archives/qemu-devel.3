Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C18D2F03D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk2k-0006M0-6u; Tue, 27 Jan 2026 09:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2h-0006I6-3y
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2f-0003co-Ft
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769524060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbaVrpV0w2eImAM6HYGffjaVPrHBHt/9Q9TT+OCQsHU=;
 b=HVuzoRiEXU1pxh8JS4bOPfhlyXfV4XmPbliJVeeh0xdGiiPfYnI9jFvhKaBWDMaRHTOEo0
 PA+r6m0GHe//b6MuhVUDJ0ODh7FXDKtOLCMm24On58unlekyENuVmZ4DwNhHTAdF4xSZAC
 1dprgHnbZDxSstj7FoJarSSYUrQgwuM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-WUYspevHMD6a0mnwY60VFA-1; Tue,
 27 Jan 2026 09:27:32 -0500
X-MC-Unique: WUYspevHMD6a0mnwY60VFA-1
X-Mimecast-MFC-AGG-ID: WUYspevHMD6a0mnwY60VFA_1769524051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71AFB18002E8; Tue, 27 Jan 2026 14:27:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.209])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2979A18001D5; Tue, 27 Jan 2026 14:27:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 7/9] tests/vm: Update netbsd VM to version 10.1
Date: Tue, 27 Jan 2026 15:27:08 +0100
Message-ID: <20260127142710.131904-8-thuth@redhat.com>
In-Reply-To: <20260127142710.131904-1-thuth@redhat.com>
References: <20260127142710.131904-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

NetBSD 10.1 has been released since more than a year, so it's time to
update our VM to that version.
Apart from the usual changes in the installation process, we also have
to disable the installation of the "jpeg" package now, otherwise the
package installation fails with an error message like this:

 pkg_add: jpeg-9fnb1: conflicts with `libjpeg-turbo-[0-9]*', and
 `libjpeg-turbo-3.1.3' is installed.

We also have to drop the executable bits from scripts/qemu-plugin-symbols.py
to force meson to use the detected Python interpreter instead of executing
the file directly (which tries to use the Python interpreter from the file's
shebang line).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260113193554.123082-1-thuth@redhat.com>
---
 scripts/qemu-plugin-symbols.py |  0
 tests/vm/netbsd                | 16 ++++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)
 mode change 100755 => 100644 scripts/qemu-plugin-symbols.py

diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
old mode 100755
new mode 100644
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index a3f6dd6b3c8..77d17a0dedf 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -22,15 +22,15 @@ class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     arch = "x86_64"
 
-    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.3/images/NetBSD-9.3-amd64.iso"
-    csum = "2bfce544f762a579f61478e7106c436fc48731ff25cf6f79b392ba5752e6f5ec130364286f7471716290a5f033637cf56aacee7fedb91095face59adf36300c3"
+    link = "https://cdn.netbsd.org/pub/NetBSD/images/10.1/NetBSD-10.1-amd64.iso"
+    csum = "7a5e5071307e1795885ffc6e1b8aac465082c21c8b79f4c9b4103ef44e4f2da45477299d213ae0093f6534dc99dc2bbf78f41e9dd556c72a02516068bf43fe49"
     size = "20G"
     pkgs = [
         # tools
         "git-base",
         "pkgconf",
         "xz",
-        "python311",
+        "python313",
         "ninja-build",
 
         # gnu tools
@@ -46,7 +46,6 @@ class NetBSDVM(basevm.BaseVM):
         "gnutls",
 
         # libs: images
-        "jpeg",
         "png",
 
         # libs: ui
@@ -126,8 +125,6 @@ class NetBSDVM(basevm.BaseVM):
         self.print_step("Installation started now, this will take a while")
         self.console_wait_send("Hit enter to continue",    "\n")
 
-        self.console_wait_send("d: Change root password",  "d\n")
-        self.console_wait_send("a: Yes",                   "a\n")
         self.console_wait("New password:")
         self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("New password:")
@@ -153,6 +150,7 @@ class NetBSDVM(basevm.BaseVM):
         self.console_wait_send("Network media type",       "\n")
         self.console_wait("autoconfiguration")
         self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("Finished",                 "netbsd-guest\n")
         self.console_wait_send("DNS domain",               "localnet\n")
         self.console_wait("Are they OK?")
         self.console_wait_send("a: Yes",                   "a\n")
@@ -160,6 +158,8 @@ class NetBSDVM(basevm.BaseVM):
         self.console_wait_send("a: Yes",                   "a\n")
 
         self.console_wait_send("e: Enable install",        "e\n")
+        self.console_wait("installed in /etc")
+        self.console_wait_send("a: Yes",                   "a\n")
         proxy = os.environ.get("http_proxy")
         if not proxy is None:
             self.console_wait_send("f: Proxy",             "f\n")
@@ -178,13 +178,13 @@ class NetBSDVM(basevm.BaseVM):
         self.console_wait_send("d: Reboot the computer",   "d\n")
 
         # setup qemu user
-        prompt = "localhost$"
+        prompt = "netbsd-guest$"
         self.console_ssh_init(prompt, self._config["guest_user"],
                                       self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
-        prompt = "localhost#"
+        prompt = "netbsd-guest#"
         self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
-- 
2.52.0


