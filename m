Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FC1C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhGSb-000454-7h; Mon, 04 Mar 2024 17:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGSU-00041N-7c
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGSC-00018d-G9
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709589994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhPYHH+K9UR6QlfCyCR92++wYM5+NVRL3L1JhMc1CAE=;
 b=ij+jKi1Y5VphVsWvnfUMJP7oM2soIsqCOW7Mjl3Wu/KHUEaR7h016qvLgJDWX6fK0IUX3f
 GxfLB/9ndymxuQgEvvnkBZQKY6FqSvlGmoSfpZJdltsgQgpz52iiDWTAyrcmLbGLYFhxrD
 2LpgHuXimxcwqMH7SZnN/KYBop01sSA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-GKSHp9oOMpWxFZITscgySw-1; Mon,
 04 Mar 2024 17:06:33 -0500
X-MC-Unique: GKSHp9oOMpWxFZITscgySw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3EC31C068DC;
 Mon,  4 Mar 2024 22:06:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8757C492BCF;
 Mon,  4 Mar 2024 22:06:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	berrange@redhat.com
Subject: [RFC PATCH 1/2] run-coverity-scan: add --check-upload-only option
Date: Mon,  4 Mar 2024 17:06:30 -0500
Message-Id: <20240304220631.943130-2-pbonzini@redhat.com>
In-Reply-To: <20240304220631.943130-1-pbonzini@redhat.com>
References: <20240304220631.943130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add an option to check if upload is permitted without actually
attempting a build.  This can be useful to add a third outcome
beyond success and failure---namely, a CI job can self-cancel
if the uploading quota has been reached.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 51 ++++++++++++++++++-------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 871826b29e..c199d57a5f 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -28,6 +28,7 @@
 # project settings, if you have maintainer access there.
 
 # Command line options:
+#   --check-upload-only : return success if upload is possible
 #   --dry-run : run the tools, but don't actually do the upload
 #   --docker : create and work inside a container
 #   --docker-engine : specify the container engine to use (docker/podman/auto);
@@ -57,18 +58,18 @@
 # putting it in a file and using --tokenfile. Everything else has
 # a reasonable default if this is run from a git tree.
 
-check_upload_permissions() {
+upload_permitted() {
     # Check whether we can do an upload to the server; will exit the script
     # with status 1 if the check failed (usually a bad token);
     # will exit the script with status 0 if the check indicated that we
     # can't upload yet (ie we are at quota)
-    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
+    # Assumes that COVERITY_TOKEN and PROJNAME have been initialized.
 
     echo "Checking upload permissions..."
 
     if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -q -O -)"; then
         echo "Coverity Scan API access denied: bad token?"
-        exit 1
+        exit 99
     fi
 
     # Really up_perm is a JSON response with either
@@ -76,25 +77,40 @@ check_upload_permissions() {
     # We do some hacky string parsing instead of properly parsing it.
     case "$up_perm" in
         *upload_permitted*true*)
-            echo "Coverity Scan: upload permitted"
+            return 0
             ;;
         *next_upload_permitted_at*)
-            if [ "$DRYRUN" = yes ]; then
-                echo "Coverity Scan: upload quota reached, continuing dry run"
-            else
-                echo "Coverity Scan: upload quota reached; stopping here"
-                # Exit success as this isn't a build error.
-                exit 0
-            fi
+            return 1
             ;;
         *)
             echo "Coverity Scan upload check: unexpected result $up_perm"
-            exit 1
+            exit 99
             ;;
     esac
 }
 
 
+check_upload_permissions() {
+    # Check whether we can do an upload to the server; will exit the script
+    # with status 1 if the check failed (usually a bad token);
+    # will exit the script with status 0 if the check indicated that we
+    # can't upload yet (ie we are at quota)
+    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
+
+    if upload_permitted; then
+        echo "Coverity Scan: upload permitted"
+    else
+        if [ "$DRYRUN" = yes ]; then
+            echo "Coverity Scan: upload quota reached, continuing dry run"
+        else
+            echo "Coverity Scan: upload quota reached; stopping here"
+            # Exit success as this isn't a build error.
+            exit 0
+        fi
+    fi
+}
+
+
 build_docker_image() {
     # build docker container including the coverity-scan tools
     echo "Building docker container..."
@@ -152,9 +168,14 @@ update_coverity_tools () {
 DRYRUN=no
 UPDATE=yes
 DOCKER=no
+PROJNAME=QEMU
 
 while [ "$#" -ge 1 ]; do
     case "$1" in
+        --check-upload-only)
+            shift
+            DRYRUN=check
+            ;;
         --dry-run)
             shift
             DRYRUN=yes
@@ -251,6 +272,11 @@ if [ -z "$COVERITY_TOKEN" ]; then
     exit 1
 fi
 
+if [ "$DRYRUN" = check ]; then
+    upload_permitted
+    exit $?
+fi
+
 if [ -z "$COVERITY_BUILD_CMD" ]; then
     NPROC=$(nproc)
     COVERITY_BUILD_CMD="make -j$NPROC"
@@ -266,7 +292,6 @@ if [ -z "$SRCDIR" ]; then
     SRCDIR="$PWD"
 fi
 
-PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
 if [ "$UPDATE" = only ]; then
-- 
2.39.1



