Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0ECC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWa4L-0007UN-2E; Tue, 01 Jul 2025 08:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uWa4D-0007RI-3N
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uWa43-0007IO-1O
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OLHN4+BZ2OHzqalRV2YRaGJ6fy4BS9UhG9Jq56005w=;
 b=dMnyPrXWf917h26uPdEkE6vymKL0z/G8Yr6MksOooQVEuc7S9DvJ0xwI32h8eIGKQmLf7D
 n29aFmtcVDa06cu9c5WV4nGt0OBqxfVBueIgRXHZCV/BxgBuqqXKyKmyd9IsdZDGhgpJs5
 tMYq6Ih5iLOosCPLpOxtb6bqn036ZmM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-IKj1N02hOsiZhTxtUlfm8g-1; Tue,
 01 Jul 2025 08:26:15 -0400
X-MC-Unique: IKj1N02hOsiZhTxtUlfm8g-1
X-Mimecast-MFC-AGG-ID: IKj1N02hOsiZhTxtUlfm8g_1751372774
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98AD19560A2; Tue,  1 Jul 2025 12:26:14 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2735619560A7; Tue,  1 Jul 2025 12:26:10 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Dehan Meng <demeng@redhat.com>,
 Elizabeth Ashurov <eashurov@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 3/3] qga/vss-win32: Add VSS provider unregistration retry
Date: Tue,  1 Jul 2025 15:25:58 +0300
Message-ID: <20250701122558.31556-4-kkostiuk@redhat.com>
In-Reply-To: <20250701122558.31556-1-kkostiuk@redhat.com>
References: <20250701122558.31556-1-kkostiuk@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Elizabeth Ashurov <eashurov@redhat.com>

This commit improves the QGA VSS provider installation flow by attempting to unregister the VSS provider if it's already
found during installation. This allows for a retry of installation even if a previous unregistration failed or was not performed.
This will prevent inconsistencies between QGA and QGA-VSS versions.
Before this commit, QGA can use QGA-VSS from the previous installation.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Message-ID: <20250618091806.170110-1-eashurov@redhat.com>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 6ee2f44a10..7b25d9098b 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -287,9 +287,13 @@ STDAPI COMRegister(void)
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
     if (count) {
-        errmsg(E_ABORT, "QGA VSS Provider is already installed");
-        qga_debug_end;
-        return E_ABORT;
+        qga_debug("QGA VSS Provider is already installed. Attempting to unregister first.");
+        hr = COMUnregister();
+        if (FAILED(hr)) {
+            errmsg(hr, "Failed to unregister existing QGA VSS Provider. Aborting installation.");
+            qga_debug_end;
+            return E_ABORT;
+        }
     }
 
     chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCTX_INPROC_SERVER,
-- 
2.48.1


