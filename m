Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F94DC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwV-0008Ns-4g; Mon, 07 Sep 2026 06:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwS-0008Ig-82
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwQ-00087u-MC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0jBAoZco2Pw7ebgEfbs0MFsImo3zclsxLCDcavDFZ0=;
 b=OTGqU75WLmGvrg8B4h5RQSNOos3AcPSMSG3lv+Mz3fKAHMKmih6/zThv7ADJABjdhP0mFn
 sVnHfV2GMOnDi8n3wow7S8Rjz+e1ojp7TxXM9qKyKu/lcDHv63jeXx++V0jiOD8ba2m4jI
 /sA2DnivR/yzmzYCSW/od9Pum8bKdG0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-Oh0y8IIjNd6EDBfChLoBCg-1; Mon,
 07 Sep 2026 06:51:08 -0400
X-MC-Unique: Oh0y8IIjNd6EDBfChLoBCg-1
X-Mimecast-MFC-AGG-ID: Oh0y8IIjNd6EDBfChLoBCg_1788778268
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF7C219541A5; Mon,  7 Sep 2026 10:51:07 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FA8E1956042; Mon,  7 Sep 2026 10:51:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:15 +0400
Subject: [PATCH 17/17] qga/vss-win32: log to file during COM+ registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-17-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zmGVWRNVdoiU4ZZZJbZEQc9IKxgrcgzEcalOujMBcmQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjSsP6qfmhknoDFgwsU1dAk6QBcwO7KAFmv
 5YsVxDADZCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5eHMD/0cFX7ixWJx+Wx8e20uxonfBCYLjkHWVMwQuhp5thvMrgxmC+QQxrbmxfqHIvuYYYul7eg
 iMDn+6iqYS+jMQcZr/uMmfTKTLuwyUBn4N9cZIZeGNvt3TlS8QEyDi4nJoeoFAKEOpAvmEpgKpQ
 Yy5Td2qFkrwKMRM3CYCEThD0IFQMoODoH2l+tKb5aO3hAA9dppBCH0KfV8Mo/2Aoj3TpDo+0c0R
 n0vZNDFFr0C/5myGalrsozz/KU7QI9tvJcyrsIGZd5c9u/4vdDtAmkRylqogtHozVXg2U7SX01n
 P8Tdn3iBOS1b/kR9O9dOn5CVEQrO/DpAw7yYj0vqv5fg8nT50DaztlXY3v72LWKRp2jpu+ZcbwZ
 ATsBb/G7dBxNDqY44dun9q4VpARAJqTervHoioB5dcmtIr9Ukv6kQSIUQCOpzXBnY5Sja4Zv+mq
 xnbt7EAr7T24mHSU7gsnPJHESMZWim/hi+QPDIFWfECARxgobPPwTpWHLOVU74QImhu/NZV9bFl
 bKzmgKuPAwn7Qur+LRr0xDpRcntdJyCrIUq1eC68qMoOXQdScBLWQ8R2zWj94QUu2jcOmagwDWa
 /mAQ+I9L2wPcLbNu1XypKLxevKyTTOWpFAVfXgFZt11KMW4SPJ7iR3TsqhzJ6qA0PpuXwuXG6li
 GGPYIwgIKW5Gc7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

COMRegister and COMUnregister are invoked both from the MSI installer
(via DLLCOMRegister/rundll32) and from qemu-ga -s vss-install, where
stderr is typically not visible. Redirect stderr to
%SystemRoot%\Temp\qga-vss-install.log so that qga_debug output is
captured for post-install troubleshooting.

Suggested-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/install.cpp | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 9e8db79c122c..09d94edd4f53 100644
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
2.55.0.543.g5ebe2ebe4ea8


