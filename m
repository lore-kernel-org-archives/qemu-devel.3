Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA15C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXA7-00058D-DF; Fri, 20 Jun 2025 04:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uSXA5-00057y-8K
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uSXA2-0000op-1s
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750408303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RJbb1zvw+UtAzVfYjQe7/0rp0ycLXD81+4lzw1HoUPk=;
 b=iQnh6DALstC5FnJcXy3oVfJFsSCqj3PgtGTlAu9o2Vs3TO7q30qf2raglCoqLQcTcUVf2Y
 YpOgaeqfxuOayj4WOMhp9cs4V/Bd575pgdUK8WAN8nrmixGwqlD94oO+x3tsr5jpFy0fAx
 SOUCNXMOplSxof3hFDlvMiYFf3M/prs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-jMwAobooOWWAa_Lavg397w-1; Fri,
 20 Jun 2025 04:31:37 -0400
X-MC-Unique: jMwAobooOWWAa_Lavg397w-1
X-Mimecast-MFC-AGG-ID: jMwAobooOWWAa_Lavg397w_1750408296
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A757619560BC; Fri, 20 Jun 2025 08:31:36 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.33.241])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 602771956094; Fri, 20 Jun 2025 08:31:35 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] qga-vss: Exit with non-zero code when register fail
Date: Fri, 20 Jun 2025 11:31:32 +0300
Message-ID: <20250620083132.28347-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=ham autolearn_force=no
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

QGA installer uses rundll32 to run the DLLCOMRegister function
from qga-vss.dll and perform VSS provider registration.
rundll32 ignores the return value of the function and always
exits with a zero exit code. This causes a situation where
the installer does not know the status of VSS provider registration.

This commit forces to change exit code when the VSS provider
registration fails.

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/rundll32

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5cea5bcf74..6ee2f44a10 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -385,7 +385,10 @@ out:
 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
 {
-    COMRegister();
+    HRESULT hr = COMRegister();
+    if (FAILED(hr)) {
+        exit(hr);
+    }
 }
 
 STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
-- 
2.48.1


