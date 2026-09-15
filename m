Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D0C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RHM-0008Ud-Kg; Tue, 15 Sep 2026 07:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RHJ-0008QV-Ey
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RHH-0001r2-Js
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDvZwmKlTunqeDY7rGJtKtMmu91abbeCHQ5f/F885LM=;
 b=bGDi+CWxADt8y/8yTl+nLXviwvk07SVJXnp0f9u3+u/1/eR8q04zKng13xl8vMiBVbuKyb
 Z1B9H4LgOmyEjPmejv5Nh1jUZKxD4MmXv8OaRKuQXRzTci85H6nnUlrCe4dSk/cz8t3yje
 kUn7h5VGCHBhgVmman4kxWm/VeEmNXo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-CwSKfApZNxeiW0Jjli7NzA-1; Tue,
 15 Sep 2026 07:24:41 -0400
X-MC-Unique: CwSKfApZNxeiW0Jjli7NzA-1
X-Mimecast-MFC-AGG-ID: CwSKfApZNxeiW0Jjli7NzA_1789471480
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BD2F19540ED; Tue, 15 Sep 2026 11:24:40 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC9621956045; Tue, 15 Sep 2026 11:24:38 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 19/19] qga/vss-win32: log to file during COM+ registration
Date: Tue, 15 Sep 2026 14:23:37 +0300
Message-ID: <20260915112337.43307-20-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

COMRegister and COMUnregister are invoked both from the MSI installer
(via DLLCOMRegister/rundll32) and from qemu-ga -s vss-install, where
stderr is typically not visible. Redirect stderr to
%SystemRoot%\Temp\qga-vss-install.log so that qga_debug output is
captured for post-install troubleshooting.

Suggested-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-17-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 9e8db79c12..09d94edd4f 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -241,10 +241,27 @@ out:
     return hr;
 }
 
+static void qga_vss_open_log(void)
+{
+    char path[MAX_PATH];
+    UINT n;
+
+    n = GetSystemWindowsDirectoryA(path, sizeof(path));
+    if (n == 0 || n >= sizeof(path)) {
+        return;
+    }
+    snprintf(path + n, sizeof(path) - n,
+             "\\Temp\\qga-vss-install.log");
+    if (freopen(path, "a", stderr)) {
+        setvbuf(stderr, NULL, _IONBF, 0);
+    }
+}
+
 /* Unregister this module from COM+ Applications Catalog */
 STDAPI COMUnregister(void);
 STDAPI COMUnregister(void)
 {
+    qga_vss_open_log();
     qga_debug_begin;
 
     HRESULT hr;
@@ -260,6 +277,7 @@ out:
 STDAPI COMRegister(void);
 STDAPI COMRegister(void)
 {
+    qga_vss_open_log();
     qga_debug_begin;
 
     HRESULT hr;
-- 
2.55.0


