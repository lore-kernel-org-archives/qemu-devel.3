Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0833C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 19:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRcBS-0004ty-Cl; Tue, 17 Jun 2025 15:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1uRaQY-0006ux-Di
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1uRaQU-0001Dv-JG
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750182528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EzYtFa1YUKp//aYusIzs3ctNZNvbTt0+bjSRID6VUpE=;
 b=Jx2jlWjMKURK2+70hhVhVa0e3Y5DVgnGdJw4LQhLUaRV6ZiQlnGYiciL45pyMt5iqsprDn
 2eCTAdWSgEJmRNmiKDNtOG4UyPgt7erEfIvbqInwrF/TqxZb31kvDyAFzOYfvoX1RkYs1F
 L/7KvQ6ZtCE+ZPVmiDe5awdjOwcWH3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-nOZGWet1PASGNQNUG-_GlQ-1; Tue,
 17 Jun 2025 13:47:40 -0400
X-MC-Unique: nOZGWet1PASGNQNUG-_GlQ-1
X-Mimecast-MFC-AGG-ID: nOZGWet1PASGNQNUG-_GlQ_1750182459
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30E801956094; Tue, 17 Jun 2025 17:47:39 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E766195608F; Tue, 17 Jun 2025 17:47:36 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH] qga/vss-win32: Add VSS provider unregistration retry
Date: Tue, 17 Jun 2025 20:47:33 +0300
Message-ID: <20250617174733.156349-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Jun 2025 15:41:22 -0400
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

This commit improves the QGA VSS provider installation flow
by attempting to unregister the VSS provider if it's already
found during installation. This allows for a retry of installation
even if a previous unregistration failed or was not performed.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/vss-win32/install.cpp | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5cea5bcf74..a136d46050 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -263,6 +263,7 @@ STDAPI COMRegister(void)
     qga_debug_begin;
 
     HRESULT hr;
+    HRESULT unregisterHr;
     COMInitializer initializer;
     COMPointer<IUnknown> pUnknown;
     COMPointer<ICOMAdminCatalog2> pCatalog;
@@ -287,9 +288,13 @@ STDAPI COMRegister(void)
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
     if (count) {
-        errmsg(E_ABORT, "QGA VSS Provider is already installed");
-        qga_debug_end;
-        return E_ABORT;
+        qga_debug("QGA VSS Provider is already installed. Attempting to unregister first.");
+        unregisterHr = COMUnregister();
+        if (FAILED(unregisterHr)) {
+            errmsg(unregisterHr, "Failed to unregister existing QGA VSS Provider. Aborting installation.");
+            qga_debug_end;
+            return E_ABORT; 
+        }
     }
 
     chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCTX_INPROC_SERVER,
-- 
2.49.0


