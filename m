Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637D2C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBJ-0007ZD-KC; Wed, 04 Jun 2025 09:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoB2-0007Km-D0
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAx-0004mM-DX
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MF3nqIIquCrTW0JVJjHlVVDeW3RnH4+JqzPQaLGzH8=;
 b=bfiOzAoNqLRBJus9QPFXAdz16U2eUokgfQrcD3guBhggWTHQWB2NXzqx6QByOGF8KJ/9qy
 2DHZdZ6LknkJERAFSsaFs7LwctDyct1xE3W2xSLIubjgWgDlGe4tyxpeiHvKV0vLGSA3Wc
 Ri/4RQxgA0zKvv3bmkzuM2y5+cJtARk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-rN9FB6WdOEy4sGK46wLNBg-1; Wed, 04 Jun 2025 09:29:01 -0400
X-MC-Unique: rN9FB6WdOEy4sGK46wLNBg-1
X-Mimecast-MFC-AGG-ID: rN9FB6WdOEy4sGK46wLNBg_1749043740
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso37760155e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043740; x=1749648540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MF3nqIIquCrTW0JVJjHlVVDeW3RnH4+JqzPQaLGzH8=;
 b=c+tfAt37VduHzAvtQRVTqjac2gHZ8qiJRZyHP60gy1C6/mmI4R9V8mcF3S50v329gJ
 LjETnWGmE/a2CmRqCxYH9Bm137i4dWguFXZRUeKtju5bLOru0fA6Q6awWdRcXA1z22La
 5mQ9ETrOs5aszBA1F+GXCR4sv1VcF4Qer/xp0s6E+oo05Cts/PPX/TdviWrMVPohho4X
 1Fi9qPAER9oFl+QXr66nqwWngjdbjwKQTBenaLIbLBXKxiaeiaf1HSDkg/wsO4CRti4l
 1qbNvdud3lnd6m6PBRfk/DPavND/6xQIm/IkZiWftpu9Hyhlt0gs1jxQOPJaC+2DF+rZ
 KVPg==
X-Gm-Message-State: AOJu0YxMESr36h9Vl4sndCuHZ9XocunMprfHUUWVScCxfnEFJh0xs1fB
 w/0+pPR/XpSJyGVrStwyFQqYclcYh5dL4wn3l5yZFKeOeW3h4HXdd5pd9GTYN4lA5JsqrPaQcEZ
 y9lEnAATpBXL7pxx9KQlUsYO9mUCFWFmJiKSBzwD2lQpfnXbLW3FpSepE
X-Gm-Gg: ASbGncsfkEPFePmnFbVkgVIYcIO6wU6JAbQdXgUt7pa9A66ef26oN8rTLXvOO6/1UFl
 T49Cli8nYLHAERmkjrm8+qxIFznc41s1WZpJm3LXgglBwexMo32X2cIl2zxHTifIXp6HdeU+A5k
 oSZtrovdWSoDungm0wcTU8+RmXkVzEjQPEpT9+sqgnLIkooGQxgtCmwbB5GanuSbNhvC6VpG42a
 kyKArXVUg/8vILKOqoxPkZvkFtuI3vXiwCz+S/TSFEaAAg25R44okr9qiKXFW7qalVV2uT66iI2
 Swa3aHwW7pvSaEVvlq+6soHZbFor7zZ+0hiuVaV8dAIhDc5uM+j23xJYArf9vNr4HQq4/g==
X-Received: by 2002:a05:600c:3e07:b0:442:cd13:f15d with SMTP id
 5b1f17b1804b1-451f0b2c13fmr24690635e9.29.1749043739767; 
 Wed, 04 Jun 2025 06:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNt05yWD6NpqGgyC22Y+8oXm4pFAsB/g/6b8026IPISfo5d34AZxtD6p561Kc7YKnhWCii8g==
X-Received: by 2002:a05:600c:3e07:b0:442:cd13:f15d with SMTP id
 5b1f17b1804b1-451f0b2c13fmr24690405e9.29.1749043739352; 
 Wed, 04 Jun 2025 06:28:59 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006c21sm196094225e9.33.2025.06.04.06.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:57 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 11/21] fuse: Rename length to blk_len in fuse_write()
Date: Wed,  4 Jun 2025 15:28:03 +0200
Message-ID: <20250604132813.359438-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The term "length" is ambiguous, use "blk_len" instead to be clear.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 044fbbf1fe..fd7887889c 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -679,7 +679,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
 {
     FuseExport *exp = fuse_req_userdata(req);
     void *copied;
-    int64_t length;
+    int64_t blk_len;
     int ret;
 
     /* Limited by max_write, should not happen */
@@ -705,13 +705,13 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         goto free_buffer;
     }
 
-    if (offset + size > length) {
+    if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
@@ -719,7 +719,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                 goto free_buffer;
             }
         } else {
-            size = length - offset;
+            size = blk_len - offset;
         }
     }
 
-- 
2.49.0


