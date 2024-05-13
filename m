Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CC0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6U2g-0008JX-6w; Mon, 13 May 2024 07:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6U2e-0008JI-WB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6U2d-0002NG-6P
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715600426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uUNxuHwJiWqM0BhbdrZV0kxAAWI9ME5sT0VL8kotzX8=;
 b=JWdg84sxm+nq5nEyjC3+02EoJmOkCDhxpj+UuV/Xc0n+eI7EyrAMvWkK+RdwyWdtai1+Xa
 486GiOawMnKL0W7TK47vkH3eMyx3A+cFckcPZmszUS/jg53aFytHZCEV3tMBg2JDTv9hPx
 F1AQWQukMcSVfBGdy2v8vQGSog3LVfY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-01S7Up08PBqi-iC_PAtk7w-1; Mon,
 13 May 2024 07:40:12 -0400
X-MC-Unique: 01S7Up08PBqi-iC_PAtk7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 427AA1C0515F;
 Mon, 13 May 2024 11:40:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11B881C00A8F;
 Mon, 13 May 2024 11:40:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2] configure: Fix error message when C compiler is not working
Date: Mon, 13 May 2024 13:40:10 +0200
Message-ID: <20240513114010.51608-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some people already opened bug tickets because of this problem:

 https://gitlab.com/qemu-project/qemu/-/issues/2057
 https://gitlab.com/qemu-project/qemu/-/issues/2288

We should rather tell the user that we were not able to use the C
compiler instead, otherwise they will have a hard time to figure
out what was going wrong.

While we're at it, let's also suppress the "unrecognized host CPU"
message in this case since it is rather misleading than helpful.

Fixes: 264b803721 ("configure: remove compiler sanity check")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Reworked the patch according to Peter's suggestions:
     https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04643.html

 configure | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 1dca3d94c0..519f1bb6e2 100755
--- a/configure
+++ b/configure
@@ -411,7 +411,9 @@ else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
   cpu=$(uname -m)
-  echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
+  if test "$host_os" != "bogus"; then
+    echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
+  fi
 fi
 
 # Normalise host CPU name to the values used by Meson cross files and in source
@@ -894,6 +896,13 @@ EOF
 exit 0
 fi
 
+# Now that we are sure that the user did not only want to print the --help
+# information, we should double-check that the C compiler really works:
+write_c_skeleton
+if ! compile_object ; then
+    error_exit "C compiler \"$cc\" either does not exist or does not work."
+fi
+
 # Remove old dependency files to make sure that they get properly regenerated
 rm -f ./*/config-devices.mak.d
 
-- 
2.45.0


