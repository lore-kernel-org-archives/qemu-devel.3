Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478A1C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vir1p-0006bb-Fx; Thu, 22 Jan 2026 04:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vir1e-0006SR-Kv
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vir1c-0003UF-He
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769074247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T+HrDQpWBb9saMP0oMhRTFdzP6FpR34iTVurd48EWrc=;
 b=NTioozbGqKnUGgKx82com3ZpyyOLVL6tyd35ZK/o1B6S+kYmFZfMxhTypywg3k3MOcp25q
 HZNoBMgvRJXIEj0vYoA1fff+6bAl/Lwv3m5jVoV78EH6gUl+jsrQvd5DvtZVLmVC5eF0bO
 1uQC3bEMQaTvSuwiD2lS0GHWMo7pW4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-uChk8bcEMNKHilS4Yea8bg-1; Thu,
 22 Jan 2026 04:30:41 -0500
X-MC-Unique: uChk8bcEMNKHilS4Yea8bg-1
X-Mimecast-MFC-AGG-ID: uChk8bcEMNKHilS4Yea8bg_1769074241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEE7B18005B0; Thu, 22 Jan 2026 09:30:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.255])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BD591800577; Thu, 22 Jan 2026 09:30:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kallisti5@unixzen.com
Subject: [PATCH] tests/vm: Make the haiku VM usable again
Date: Thu, 22 Jan 2026 10:30:36 +0100
Message-ID: <20260122093036.16085-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

We also have to add a little "hack" to our configure script: For some
weird reasons, the meson binary shows up as pyvenv/non-packaged/bin/meson
here, and not in the expected location pyvenv/bin/meson. Use a symlink
to fix it.

For this new version, we also have to compile with "-pie", otherwise
the linker complains about bad relocations in the object files, so
allow compiling with PIE in the configure script now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure             | 8 +++++++-
 tests/vm/haiku.x86_64 | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 9d7fd13a98b..587cd2a2fe6 100755
--- a/configure
+++ b/configure
@@ -967,6 +967,12 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
      ${source_path}/pythondeps.toml meson || exit 1
 
+# For some unknown reason, the meson binary shows up in the wrong
+# folder on Haiku. Use a symlink to fix it.
+if test "$host_os" = "haiku" && test ! -e pyvenv/bin/meson ; then
+    ln -s "$PWD"/pyvenv/non-packaged/bin/meson pyvenv/bin/meson
+fi
+
 # At this point, we expect Meson to be installed and available.
 # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
 # We ignore PATH completely here: we want to use the venv's Meson
@@ -1068,7 +1074,7 @@ static THREAD int tls_var;
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


