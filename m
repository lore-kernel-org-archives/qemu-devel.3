Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264AEFCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzee6-0002eW-UE; Mon, 09 Mar 2026 13:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzedy-0002bu-SG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzedw-00025L-CD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=ZeX2JqJzI+otvpc4StZ3gN12ANBp51K/G8hLSryGNxfpSizaDbB5+H2H0wEiJuGh9IULGY
 5cJx+jEroCpjxvOvkfxseS1+1WiyZRFhQoyr8fjfmqAvwLhjPiMwjrBRugLaRLUtqJiCG2
 jS3fE3IOmKUqkpn4Nhc77kEMYB6YfKw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-CS31i4tGPLmhSsxCKvrFvQ-1; Mon, 09 Mar 2026 13:43:45 -0400
X-MC-Unique: CS31i4tGPLmhSsxCKvrFvQ-1
X-Mimecast-MFC-AGG-ID: CS31i4tGPLmhSsxCKvrFvQ_1773078224
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so13968865e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078223; x=1773683023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=S0uWz8KI65DEkU3DQSbLt0KgjRxDmQClSOq+YYlJC4sTtnHXDuot7hmJ+DHydVZZpy
 HMsOPeEDL1I+5i/48l9y/mcrmGrL4vrcwsIXLPhruw94Yd0fjLLCDkXiveffvyrCeLTU
 SIU9U8dvWYFDStwdLrr7bIW1JzJhhJGbF6UrOO2Rt7+xNajUF/JwlsfLoA0qJmoQVB7O
 GH6Ai+6kZ3r2Nfw+cliSH4619xkgjdWMFlqtHUO3tkJdsch0IWOnqp99zqUR9ISwklwv
 tt3I5SJhbsIA1CZhg7BwC86Z5GFkeilBWCaxD6tumlGWCXjMgTkvbTG0X17EQ7yt2+JJ
 JWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078223; x=1773683023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=k8OLpChLX5SuCyf/SJYXWHOdq+X4MDBQ39enfU/CWUOY8cfa6AswSGN8EC6jbGcDuU
 eRzlCpX1FP9WOkcMlkZks6nKyEXHkwVEq36VI+t+1wAMZm4FPya88EOdUQd6mT1lRAHU
 ueb1o3OtbvCch9z0dWodxhA988HNMmekh7Xz4hW2x8NldyLGpB7u9ftsQ14B+JlBr183
 CI3H8xgLdDl8+zs2+gfAYeXFfH+hQEZyfD1uvBy9bXEQwzd/1atS1g54+npu4jtraLsb
 QUVWERmKpCk9zOfV5V48xrlM+XvsgyhIi8ggQHIGlLbxxyYVU1zwdeOTiWPKuDpVpIcY
 03/Q==
X-Gm-Message-State: AOJu0YyZNSiI3dFl3cVWZnsuRFQ/QzvARly+sKt6oMCb6dlPoOCXvKpf
 giK9rTjdgYv0GCK0zw/DgwcGfNxFUuVeNwj4OXXXF2YxbAcsFOYlkr4kKaiJQPAYKNlngU385aZ
 J4DD4zT833CzVzk++/263TbvriGXOuE8d9QWJt5lwvRIw2f8795U9OcU3RvFieTBdohMlGWMFDE
 j6g68ABcwDvDXbM7pMyp+yRisCRAN416pPHDcgmsNK
X-Gm-Gg: ATEYQzzEK1jKfuTtS/Njtn+Z7JohlIcAZQ9UGVvMXage62WhN2t+rAXm/SWdaxaQpnE
 n6dglLJhhol8bUemsN2XH0Ogm+QnHHN7YZJKjhyG0lAwQiwwrmJnpLEosuSnTurcdTfd4kTvv0R
 KyeeubRq+dyzkxOo00Xce7h2S7Gd8w48T+eOIG9dm2kjd6m+jcsczPW722/ij90++Oa9XJt0Rs0
 wSBGeqfdluLjO6VSsrdOL8N89cWpBLACG9vYjbzyRfnZ3jB0dbib/JULbV3hafy2wqxZvog2AF2
 kQVuXXBB3gn/ByrwHahwk08EGc2pnFlurIjQGVxHMxzlx3LKDidFRxCLdzYvqxeJAmWRHJweuJQ
 B9XPS/u1sRfjB1pq4TC+5z/VjrA8XLd6oNUlntr1eYFHVdGXjklKa6+1u1xKsKgZ0/oLQ/FeyEm
 4/r573dza+FyvPmlsu2pEfzV0q8wg=
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-48535eefa3emr92752465e9.2.1773078223406; 
 Mon, 09 Mar 2026 10:43:43 -0700 (PDT)
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-48535eefa3emr92752095e9.2.1773078222919; 
 Mon, 09 Mar 2026 10:43:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852378e700sm159681725e9.0.2026.03.09.10.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Siteshwar Vashisht <svashisht@redhat.com>
Subject: [PULL 01/10] xen-block: remove NULL pointer dereference
Date: Mon,  9 Mar 2026 18:43:31 +0100
Message-ID: <20260309174340.52174-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


