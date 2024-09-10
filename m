Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0C2EDE9BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so82l-00083Y-BW; Tue, 10 Sep 2024 17:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so82k-000835-2W
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so82i-0008WF-EJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726002295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NPBJIwJb7g64351J5n3RwwM19LVACSzZTdUUP7Sxplg=;
 b=WA/E+oNzaeKf5iYWXr6jvCgDPYONQOQnIS6GFteBfo1J0kQSGTrm4erIQ+kd9WCr7ThT49
 rkSPwS06ZrMXQNoHIxuvbIIsbYiP/oWnnxVIoPYHZn+LBD1LVbkL+Ew6Lb578WbM8AP3TM
 eUxVmCnPa0WwLm9XEVOM7iFTF3iD25w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-loLItL1OP6KuAaoJi2nRJA-1; Tue, 10 Sep 2024 17:04:54 -0400
X-MC-Unique: loLItL1OP6KuAaoJi2nRJA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9a6251df5so804084185a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726002293; x=1726607093;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPBJIwJb7g64351J5n3RwwM19LVACSzZTdUUP7Sxplg=;
 b=JNi0v9HXN3qsWyGPDBdyxAHRhYmwZLlTFdHq1gmlStZHky69T2+a6LDINMHxxo0CtW
 ZzsDDFceJKsNQRTGimxyVybi/+yvWhXi7KbNl4FthS2PvLAOHFEVjXVMZrTuOBP7MmhZ
 F11mhZdf3xr3bagY1+E4wOxL/P9MI9DLKUegf37P454M7tZYfgEGDy9fZtReR4Cmcqe0
 yCtlMMNtYne1Jkbps2FNF0o34YUpRq49PBD/Zhvnc4n0+5UrkXwHioBS04VvmNAVTZJK
 JqZvcp/7Frp4YyxmjIM4GKyA4++VWcgxTVJKPRJPHjCUmdSVtUPJ+WIW5Nhka8y9V1Ye
 WlAQ==
X-Gm-Message-State: AOJu0YwIh1/ETxuwVY1gS4fgGTiYOslg3VMWKXNSqunRLrINcbn8JmH4
 WgI/N3xg8ULogLpVUzBDc3F76oCWB0mXBVPtqfL1LJw5eR5SOWWEe0GQVVSUCviOlVS9PGckOFN
 6xfZ0sDBvp91Cz3O7ltpsiaB+7YIGK+TbDF9SPoqSg8AuovYccvcVTNszfdwS2O/csgHQnOXCHJ
 8cVeH+7rF9EWojaoxGSzi4UYMtDKp1ArOphA==
X-Received: by 2002:a05:620a:29d6:b0:7a9:c964:b32d with SMTP id
 af79cd13be357-7a9c964b62cmr324461985a.54.1726002293488; 
 Tue, 10 Sep 2024 14:04:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf6p80q0FY5ibnCRE0PuvhAVl2gTDuimAqCKp8nZbC/vAU9aZnoVDEPh9yHP6JFdLS/vOLww==
X-Received: by 2002:a05:620a:29d6:b0:7a9:c964:b32d with SMTP id
 af79cd13be357-7a9c964b62cmr324457785a.54.1726002293081; 
 Tue, 10 Sep 2024 14:04:53 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a796adb3sm337731585a.51.2024.09.10.14.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:04:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>,
 Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Hao Xiang <hao.xiang@linux.dev>,
 Yuan Liu <yuan1.liu@intel.com>
Subject: [PATCH] migration/multifd: Fix build for qatzip
Date: Tue, 10 Sep 2024 17:04:50 -0400
Message-ID: <20240910210450.3835123-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qatzip series was based on an older commit, it applied cleanly even
though it has conflicts.  Neither CI nor myself found the build will break
as it's skipped by default when qatzip library was missing.

Fix the build issues.  No need to copy stable as it just landed 9.2.

Cc: Yichen Wang <yichen.wang@bytedance.com>
Cc: Bryan Zhang <bryan.zhang@bytedance.com>
Cc: Hao Xiang <hao.xiang@linux.dev>
Cc: Yuan Liu <yuan1.liu@intel.com>
Fixes: 80484f9459 ("migration: Introduce 'qatzip' compression method")
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Qatzip developers: would you help me to double check whether this is the
right fix?
---
 migration/multifd-qatzip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 3c787ed879..7b68397625 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -160,7 +160,8 @@ static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    uint32_t page_size = multifd_ram_page_size();
+    MultiFDPages_t *pages = &p->data->u.ram;
     QatzipData *q = p->compress_data;
     int ret;
     unsigned int in_len, out_len;
@@ -179,12 +180,12 @@ static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
      * implementation.
      */
     for (int i = 0; i < pages->normal_num; i++) {
-        memcpy(q->in_buf + (i * p->page_size),
+        memcpy(q->in_buf + (i * page_size),
                pages->block->host + pages->offset[i],
-               p->page_size);
+               page_size);
     }
 
-    in_len = pages->normal_num * p->page_size;
+    in_len = pages->normal_num * page_size;
     if (in_len > q->in_len) {
         error_setg(errp, "multifd %u: unexpectedly large input", p->id);
         return -1;
@@ -197,7 +198,7 @@ static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
                    p->id, ret);
         return -1;
     }
-    if (in_len != pages->normal_num * p->page_size) {
+    if (in_len != pages->normal_num * page_size) {
         error_setg(errp, "multifd %u: QATzip failed to compress all input",
                    p->id);
         return -1;
@@ -329,7 +330,8 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
     int ret;
     unsigned int in_len, out_len;
     uint32_t in_size = p->next_packet_size;
-    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t expected_size = p->normal_num * page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
     if (in_size > q->in_len) {
@@ -370,9 +372,7 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
 
     /* Copy each page to its appropriate location. */
     for (int i = 0; i < p->normal_num; i++) {
-        memcpy(p->host + p->normal[i],
-               q->out_buf + p->page_size * i,
-               p->page_size);
+        memcpy(p->host + p->normal[i], q->out_buf + page_size * i, page_size);
     }
     return 0;
 }
-- 
2.45.0


