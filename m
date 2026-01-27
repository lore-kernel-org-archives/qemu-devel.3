Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20226D2F038
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk2k-0006Md-Go; Tue, 27 Jan 2026 09:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2d-0006Gk-Ow
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2c-0003cJ-A8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769524057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DhhBwqoukfafQXKXugsUkx7V0pAdgeoaOurg4u5b+kk=;
 b=I0YPPAg9yE4dEHdtJ6krVBSWOAdTUdNtxbyy/jH8i0SPK03nO64JIWZwKM7G3WGELtBkPk
 k5u0ga/l7nkehnoqu+OhwKH4XBFSuZTgXfKWruGG0baZ7Xus+IJVirMInykseojVSCAmd5
 NM8vLT9jfVWpgaRtKjOUyvwWZjnwRmI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-LBkVpflsOZiWXJ13QiZVkA-1; Tue,
 27 Jan 2026 09:27:35 -0500
X-MC-Unique: LBkVpflsOZiWXJ13QiZVkA-1
X-Mimecast-MFC-AGG-ID: LBkVpflsOZiWXJ13QiZVkA_1769524054
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46200195608F; Tue, 27 Jan 2026 14:27:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.209])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32F4618001D5; Tue, 27 Jan 2026 14:27:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 8/9] tests/vm: Make the haiku VM usable again
Date: Tue, 27 Jan 2026 15:27:09 +0100
Message-ID: <20260127142710.131904-9-thuth@redhat.com>
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

The haiku VM bitrotted in the course of time. Make sure to use the
latest version of the repositories here and install missing pieces
like "pip" and "tomli" now.

Since we nowadays also install our own version of meson in our venv,
this also requires a change to our configure script: On Haiku, the
meson binary shows up as pyvenv/non-packaged/bin/meson here, and not
in the expected location pyvenv/bin/meson. Adjust the "meson" variable
to point to that Haiku-specific location to fix this issue. See also:
https://github.com/haiku/haiku/blob/r1beta5/docs/user/storage/storageintro.dox

And finally, with the new toolchain from the beta 5, we also have to
compile with "-pie", otherwise the linker complains about bad relocations
in the object files, so allow compiling with PIE in the configure script
now.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260123184429.5278-1-thuth@redhat.com>
---
 configure             | 8 +++++++-
 tests/vm/haiku.x86_64 | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 213880df890..4b61fd3bbf8 100755
--- a/configure
+++ b/configure
@@ -987,6 +987,12 @@ if [ -f "$meson$EXESUF" ]; then
   meson="$meson$EXESUF"
 fi
 
+# On Haiku, meson might show up in a "non-packaged" subfolder instead, see
+# https://github.com/haiku/haiku/blob/r1beta5/docs/user/storage/storageintro.dox
+if test "$host_os" = "haiku" && test ! -e "$meson" ; then
+    meson="$(cd pyvenv/non-packaged/bin; get_pwd)/meson"
+fi
+
 # Conditionally ensure Sphinx is installed.
 
 mkvenv_online_flag=""
@@ -1069,7 +1075,7 @@ static THREAD int tls_var;
 int main(void) { return tls_var; }
 EOF
 
-if test "$host_os" = windows || test "$host_os" = haiku; then
+if test "$host_os" = windows ; then
   if test "$pie" = "yes"; then
     error_exit "PIE not available due to missing OS support"
   fi
diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
index 71cf75a9a3e..529283c39f6 100755
--- a/tests/vm/haiku.x86_64
+++ b/tests/vm/haiku.x86_64
@@ -78,6 +78,8 @@ class HaikuVM(basevm.BaseVM):
         "devel:libusb_1.0",
         "devel:libz",
         "ninja",
+        "pip",
+        "tomli_python310",
     ]
 
     BUILD_SCRIPT = """
@@ -109,6 +111,8 @@ class HaikuVM(basevm.BaseVM):
         self.wait_ssh(wait_root=True, cmd="exit 0")
 
         # Install packages
+        self.ssh_root("echo yes | pkgman add-repo https://eu.hpkg.haiku-os.org/haiku/r1beta5/$(getarch)/current")
+        self.ssh_root("echo yes | pkgman add-repo https://eu.hpkg.haiku-os.org/haikuports/r1beta5/$(getarch)/current")
         self.ssh_root("pkgman install -y %s" % " ".join(self.requirements))
         self.graceful_shutdown()
 
-- 
2.52.0


