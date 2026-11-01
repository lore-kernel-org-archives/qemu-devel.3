Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45D606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ItqdnjdD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLK-0006mV-6y; Sun, 01 Nov 2026 04:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSLH-0006lZ-9x
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSLF-0007uv-Kj
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TQAJvk6+NTjK7dz4vlYR5SpQs2yPDJMx5LLtVl4HUw=;
 b=ItqdnjdDb3hEnPXIxCIs25629CwcL7REk7kNzfMifZZ1E/hsta7N7/zRCmTcqXVSYVbJ1h
 ut0nsPB3u2+yyEy995sOuu+ntWQb4cA6B9SffHuU7GTKnP1/6+Ka1ff7+Eib0+TwIaIQaw
 U9Dg6mjciLdEY5/cgLSiVzcm/AYfuno=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-sgllAYBuPjCtm5a_USfVSw-1; Sun,
 01 Nov 2026 04:59:07 -0500
X-MC-Unique: sgllAYBuPjCtm5a_USfVSw-1
X-Mimecast-MFC-AGG-ID: sgllAYBuPjCtm5a_USfVSw_1793527146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1FB21955F13
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:59:06 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3015E1800446
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:59:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] meson: rewrite scripts/qemu-version.sh directly in
 meson.build
Date: Sun,  1 Nov 2026 10:58:51 +0100
Message-ID: <20261101095851.1557351-11-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Invoking git and creating a .h file does not need a shell script.
Embed the logic directly in meson.build.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 29 ++++++++++++++++++++---------
 include/qemu/version.h    |  8 ++++++++
 scripts/qemu-version.h.in |  1 +
 scripts/qemu-version.sh   | 25 -------------------------
 4 files changed, 29 insertions(+), 34 deletions(-)
 create mode 100644 scripts/qemu-version.h.in
 delete mode 100755 scripts/qemu-version.sh

diff --git a/meson.build b/meson.build
index 7ec3fb90233..d4c8bb2dbef 100644
--- a/meson.build
+++ b/meson.build
@@ -78,6 +78,7 @@ have_user = have_linux_user or have_bsd_user
 ############
 
 sh = find_program('sh')
+git = find_program('git', required: false)
 python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
@@ -3551,15 +3552,25 @@ tracetool_depends = files(
   'scripts/tracetool/__init__.py',
 )
 
-qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
-                    meson.current_source_dir(),
-                    get_option('pkgversion'), meson.project_version()]
-qemu_version = custom_target('qemu-version.h',
-                             output: 'qemu-version.h',
-                             command: qemu_version_cmd,
-                             capture: true,
-                             build_by_default: true,
-                             build_always_stale: true)
+qemu_pkgversion = get_option('pkgversion')
+git_describe_version = [git, 'describe', '--match', 'v*', '--dirty']
+if qemu_pkgversion == '' and git.found() and fs.exists('.git') and \
+    run_command(git_describe_version, check: false).returncode() == 0
+  # Refresh the version at build time, so that "make" after a commit updates it.
+  qemu_version = vcs_tag(input: 'scripts/qemu-version.h.in',
+                         output: 'qemu-version.h',
+                         command: git_describe_version,
+                         fallback: '')
+else
+  # Unlike vcs_tag(), which always defines QEMU_PKGVERSION, leave it out if
+  # empty.  include/qemu/version.h then omits the parentheses from
+  # QEMU_FULL_VERSION.
+  qemu_version_data = configuration_data()
+  if qemu_pkgversion != ''
+    qemu_version_data.set_quoted('QEMU_PKGVERSION', qemu_pkgversion)
+  endif
+  qemu_version = configure_file(output: 'qemu-version.h', configuration: qemu_version_data)
+endif
 genh += qemu_version
 
 hxdep = []
diff --git a/include/qemu/version.h b/include/qemu/version.h
index 38405495c0e..dd0f937f30c 100644
--- a/include/qemu/version.h
+++ b/include/qemu/version.h
@@ -7,6 +7,14 @@
 #ifndef QEMU_VERSION_H
 #define QEMU_VERSION_H
 
+/* qemu-version.h defines QEMU_PKGVERSION only if it is not empty.  */
 #include "qemu-version.h"
 
+#ifdef QEMU_PKGVERSION
+#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"
+#else
+#define QEMU_PKGVERSION ""
+#define QEMU_FULL_VERSION QEMU_VERSION
+#endif
+
 #endif
diff --git a/scripts/qemu-version.h.in b/scripts/qemu-version.h.in
new file mode 100644
index 00000000000..b62d4c22652
--- /dev/null
+++ b/scripts/qemu-version.h.in
@@ -0,0 +1 @@
+#define QEMU_PKGVERSION "@VCS_TAG@"
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
deleted file mode 100755
index 3f6e7e6d41d..00000000000
--- a/scripts/qemu-version.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/sh
-
-set -eu
-
-dir="$1"
-pkgversion="$2"
-version="$3"
-
-if [ -z "$pkgversion" ]; then
-    cd "$dir"
-    if [ -e .git ]; then
-        pkgversion=$(git describe --match 'v*' --dirty) || :
-    fi
-fi
-
-if [ -n "$pkgversion" ]; then
-    fullversion="$version ($pkgversion)"
-else
-    fullversion="$version"
-fi
-
-cat <<EOF
-#define QEMU_PKGVERSION "$pkgversion"
-#define QEMU_FULL_VERSION "$fullversion"
-EOF
-- 
2.56.0


