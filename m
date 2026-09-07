Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF4C79F9F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wvs-0007Sg-8j; Mon, 07 Sep 2026 06:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvl-0007Qw-MR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvk-0007yf-6R
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyDsh9SevbYPGzB/boZkuul1T2heGOdmaDahaKqiWZI=;
 b=QqZG6AjwvdxjZ5pr2f4sLAXhTy/kwwizs4E8TsyhsrelPguYDuxhC4TXoFEMySm3Aocewf
 ecjiefJYxe7j3fjXk3QLRFVaX82K3snGsiqUaswZrzRa1cE0NXPq3/GxpD3AgDFyonu78c
 uJP+mN43zbRy2tNWxoeWdiHY2NQyer8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-4NcIJlNBOQiDX6fOEVF6Uw-1; Mon,
 07 Sep 2026 06:50:23 -0400
X-MC-Unique: 4NcIJlNBOQiDX6fOEVF6Uw-1
X-Mimecast-MFC-AGG-ID: 4NcIJlNBOQiDX6fOEVF6Uw_1788778222
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 874F81801363; Mon,  7 Sep 2026 10:50:22 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CEFF1800598; Mon,  7 Sep 2026 10:50:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:02 +0400
Subject: [PATCH 04/17] qga/vss-win32: explicit NULL/zero initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-4-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ALhvlXO+1Llv2C3knfUSD228WJ0mqMnPVTvXeYx6N5U=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqeluPIzxVLpvUAiTl32uxnsRGjPOAOIA4jYc8AFooh6ueeU
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqnpbjAAoJENro4Ql1lpzlbJEQAJIH
 AEp6tOWfagyZ/BHeWolqTBPPJ7KDHNCrzXERwjLXooxtxpYcvQLbnyHIIgb00qYX5Bif5wvxjo9
 QI9XR36mfQn1m6D9YgNP7q13H+oS5IjwIxep5hshzv/icZe+FdDwow10IDlPacQb97UPhtHgm5O
 UaPBrocJ7gWS4sjAufuBnQADoLTwEqd6f2Xztcf7K7puxD1leZGveVLnHqstAcJU5BcKK9WTd7s
 6ZkIp8n4Un9krcnDnmecZQ4UBQtm1rXqcCgL5V5etcZJowOqfng4OLDTqAsuDdWqg5jxULcQJ9W
 q0NG9Zp4Pag06DFbmGkJpTGmvpK1KL087Jy2i1b89kEHuDTRD+nB6c2uTwygeIUv+69UTL7mPt7
 h43xJ8sIQxJeR98WGMB0tuFiYfcSxtzAMbP0cdV3RwPVh48t3IbUbPRwwMD549K9eC1NZptL+Di
 a0pAK6as1aAWc3gpfy0uyqyeayhBQImUid1kJwt6JFHMpxm2lMn2qrUCGDHvwl4cZfJKlxfv6lU
 9JCPLVS/gog86dahm1e/dej6o0wz4O9NRHb5GdZcEq0Y1gG5dhJtsKHDIuqNEIXycic+mKxL0vW
 3Tu4bkbrpjLPYkAA+MvXqRZj36/v+mWGU16QOkhmYZqLxyJRkcR75P28wqDNh2nV+ULNXzY1yVy
 8qHQI
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We use -ftrivial-auto-var-init=zero, but static analyzers don't..

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/install.cpp   | 2 +-
 qga/vss-win32/requester.cpp | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index f89658d277e9..12b045e2074f 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -61,7 +61,7 @@ static void errmsg(DWORD err, const char *text)
 
 static void errmsg_dialog(DWORD err, const char *text, const char *opt = "")
 {
-    char *msg, buf[512];
+    char *msg = NULL, buf[512] = "";
 
     FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
                   FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 493ecd57172a..52176d751274 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -170,7 +170,7 @@ static void AddComponents(ErrorSet *errset)
     unsigned int cComponents, c1, c2, j;
     COMPointer<IVssExamineWriterMetadata> pMetadata;
     COMPointer<IVssWMComponent> pComponent;
-    PVSSCOMPONENTINFO info;
+    PVSSCOMPONENTINFO info = NULL;
     HRESULT hr;
 
     hr = vss_ctx.pVssbc->GetWriterMetadataCount(&cWriters);

-- 
2.55.0.543.g5ebe2ebe4ea8


