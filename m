Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B92CE9B37D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3Md-0005hQ-QN; Mon, 02 Mar 2026 08:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vx3Mb-0005dJ-Pa
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vx3MZ-0006zr-MA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772458266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=dHhEX0KZdVuDetzhJad5TFv12iIRTZLDZRcioPUH2WQDBHBKZz2YbXYmWu6xREDMM9Anyn
 Ayzfj9W7B4stZdOqe4O3kZJhb01yNL4vtmfSRezE+RbbL2yxmSl1HVASS03WacdhY3YMbb
 hxyTpKDYzavNJwYgxCt+bOHsY9yFve4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-DCix612tOvmFIFMCwC7mwg-1; Mon, 02 Mar 2026 08:31:05 -0500
X-MC-Unique: DCix612tOvmFIFMCwC7mwg-1
X-Mimecast-MFC-AGG-ID: DCix612tOvmFIFMCwC7mwg_1772458264
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so49190115e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772458263; x=1773063063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=DF7+S6CigzWut6A4+QaIFwmfzS5eJ7a50sxBsw8x0GB0X9L0I/fHQqopSI8z68c5NQ
 Z5FjjJZTZ3gkYXzGiG3yLt2k85zsMUl0680lx+OcuDNdyQmLbjPH29HZfZi22f4qBk5W
 uRxe4l/IsGoqdNm543+f4gNzaZTaY1/+cS7tjqQbHncjLSi8PMqNhXdtEZMtjlJavUOk
 5SRKs2hJsUIpd5zHsM0fELgusGK+ygvYVTlC3hX5LmUaBI/T4inpIUYEHNUPeVfyh504
 LQ3sU8rkgQfTOi4s0bGlQdfKd8FVky13i3tpLXM4AGTnhUXiVivLoEgsAWJTT3xMA5oS
 d1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772458263; x=1773063063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=MfsI0mKHE6wq4qdBwHgBvc+3vMaDyA7n/9NuLFB0nlkwxMiXvTFCbdYn5XNVZ2eW9t
 rlvM20nQWDw2gynz+RIBfXYxWcpEGESGl7pBvqQHwc7t0vN5eY1F3Rqxb4fTYltKsO9W
 6euFB/iM6O+reyZVBa94vReRFazr1RNYAKK19Ze+CnABk6SabBSBwG3JUNPv5fijluRI
 w9Ybu7jXtK2IQLij+V6J2CCvScWdJDSyLToJoKxznXEXZ6jkTGw6zsfQ5qXV2gcHd4mu
 uKI0Iex+qLhSZtEZ/HHIt0fNqZFtII3niNbtBpWKG80QdoNQ5P8q8AnbwgeOTkeOl8rd
 m+Zg==
X-Gm-Message-State: AOJu0YxwJkQOAswZc9iHBxgMMCpfoHMpj7qajGRYn88JCdcdC6z+242v
 6e50PeHYL3uOrhdWC6KoZhgBnKJD4MIRscMByC5NuAe381SsPwjttHFqnWdZezCghrImDQHlt4X
 2r2ahN0xQdJGpA8uqGGbEzRhdXfuO6jqEtKwU05VWH7B7FMnrZEEUprblYZ/3QkWMqP6g8QEnxm
 sVbFyI+yJDRcnEXXbYGyR+hA1PLyMFrDIaQIJqDhFW
X-Gm-Gg: ATEYQzzfX1h6TpiATW6Nf0KHkN+81RGB2UPg+68HhLQdQCKnQ2PiZEvuCcT2LKM45Ah
 It2MyadUXUM3Xzgc21I5cbjF3lEi2rzLA+nbTgaE0eth1ya6q07vm/EZcPpoEM9kxMsImCb+e9U
 ItMJ7FlzrOrxRB4Mkexkd81Jla4VkKoy7iXT6TX+YMMLAvKTPQvCKgJp/Me3mrH5gLGLYiFCZ6K
 FXmVvfTzzU487omBF08jJTOsfwAOHlDBQg3xBFmi1GtsYm6XCwDLtbHR9vHsP37d+rzIQcql8DG
 js/R3mKiPdf/CUZIzy9Q92E0v+h4W38wXPlzHpdfGcW7XyKZ+5YTyvNO7PKmUjvwyDkobuYOC9l
 uSj+FRdpWdfhPL02CHeh+hR5rdU3y5s4WVbGUFFxuQAhCdThrJE50nJNXkexR7HrGC65m+Ycwns
 AlPYSo58URdwhmnYDkSe8a1CH/+sY=
X-Received: by 2002:a05:600c:1f83:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-483c9c031e6mr248690815e9.19.1772458263323; 
 Mon, 02 Mar 2026 05:31:03 -0800 (PST)
X-Received: by 2002:a05:600c:1f83:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-483c9c031e6mr248690215e9.19.1772458262817; 
 Mon, 02 Mar 2026 05:31:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm300569115e9.7.2026.03.02.05.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 05:31:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Siteshwar Vashisht <svashisht@redhat.com>
Subject: [PATCH] xen-block: remove NULL pointer dereference
Date: Mon,  2 Mar 2026 14:31:00 +0100
Message-ID: <20260302133100.583783-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

If params is NULL, xen_block_drive_create calls xen_block_drive_destroy
with drive == NULL.

Reported-by: Siteshwar Vashisht <svashisht@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/xen-block.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 5dc4ba9d076..474c12fe4ac 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -883,32 +883,29 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     QDict *driver_layer;
     struct stat st;
     int rc;
+    char **v;
 
-    if (params) {
-        char **v = g_strsplit(params, ":", 2);
-
-        if (v[1] == NULL) {
-            filename = g_strdup(v[0]);
-            driver = g_strdup("raw");
-        } else {
-            if (strcmp(v[0], "aio") == 0) {
-                driver = g_strdup("raw");
-            } else if (strcmp(v[0], "vhd") == 0) {
-                driver = g_strdup("vpc");
-            } else {
-                driver = g_strdup(v[0]);
-            }
-            filename = g_strdup(v[1]);
-        }
-
-        g_strfreev(v);
-    } else {
+    if (!params) {
         error_setg(errp, "no params");
-        goto done;
+        return NULL;
     }
 
-    assert(filename);
-    assert(driver);
+    v = g_strsplit(params, ":", 2);
+    if (v[1] == NULL) {
+        filename = g_strdup(v[0]);
+        driver = g_strdup("raw");
+    } else {
+        if (strcmp(v[0], "aio") == 0) {
+            driver = g_strdup("raw");
+        } else if (strcmp(v[0], "vhd") == 0) {
+            driver = g_strdup("vpc");
+        } else {
+            driver = g_strdup(v[0]);
+        }
+        filename = g_strdup(v[1]);
+    }
+
+    g_strfreev(v);
 
     drive = g_new0(XenBlockDrive, 1);
     drive->id = g_strdup(id);
-- 
2.53.0


