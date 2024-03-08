Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CBAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 06:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riTHh-0005ld-FI; Fri, 08 Mar 2024 01:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riTHg-0005lA-4J
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:00:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riTHe-0001wE-Nu
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709877641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AbQcPYdeg9iY48jnsb4SHHwJNyPOCT1u+L3dPhNxTHo=;
 b=PUYyPMTlhpli+hoh4Cmk1oLKhRcQrO0Qa2GWZHVB9822QOt/BzyGVUmUtYmlQeKSy6ryES
 ZEmGatjiNbcyeGndrDmL4pP9CmAglvTfyfUOGGlN/O9fe+isB+UB7qYKdB1Gs0a7mHaves
 uNr3WkJvZbxCWCnNN3aGWO1isAIMs2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-kOmYtLRlN1mudMyqYxRs9A-1; Fri, 08 Mar 2024 01:00:37 -0500
X-MC-Unique: kOmYtLRlN1mudMyqYxRs9A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60D21800265;
 Fri,  8 Mar 2024 06:00:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08665492BCB;
 Fri,  8 Mar 2024 06:00:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] configure: Fix error message when C compiler is not working
Date: Fri,  8 Mar 2024 07:00:34 +0100
Message-ID: <20240308060034.139670-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If you try to run the configure script on a system without a working
C compiler, you get a very misleading error message:

 ERROR: Unrecognized host OS (uname -s reports 'Linux')

We should rather tell the user that we were not able to use the C
compiler instead, otherwise they will have a hard time to figure
out what was going wrong.

Fixes: 264b803721 ("configure: remove compiler sanity check")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 3cd736b139..a036923dee 100755
--- a/configure
+++ b/configure
@@ -411,7 +411,7 @@ else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
   cpu=$(uname -m)
-  echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
+  echo "WARNING: could not determine host CPU, proceeding with 'uname -m' output '$cpu'"
 fi
 
 # Normalise host CPU name to the values used by Meson cross files and in source
@@ -1000,10 +1000,12 @@ if test -z "$ninja"; then
 fi
 
 if test "$host_os" = "bogus"; then
-    # Now that we know that we're not printing the help and that
-    # the compiler works (so the results of the check_defines we used
-    # to identify the OS are reliable), if we didn't recognize the
-    # host OS we should stop now.
+    # Now that we know that we're not printing the help, we should stop now
+    # if we didn't recognize the host OS (or the C compiler is not working).
+    write_c_skeleton;
+    if ! compile_object ; then
+        error_exit "C compiler \"$cc\" is not usable"
+    fi
     error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
 fi
 
-- 
2.44.0


