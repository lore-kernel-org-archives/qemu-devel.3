Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A95E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgJ-0003bN-0f; Thu, 05 Dec 2024 19:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgG-0003ah-9O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgE-0005lQ-Ow
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jq9ieJQ9//qq2auSKoavGM6aHp5t8bjDLhHqkdKpCKw=;
 b=CDjghp9fRAHrEKbPQdu37wARtijK88aRV1yFHpge5Aaf5XKhs1kGYijhrGMvy/aSEIXwJ7
 JMV9snlAmnzbXHihvLoEwI74Nf7Jm18MGja606flne5Gl6mmvRrFokExK2dgA7clCfK9to
 +3p69dnmC64nzso7KdTQj6+0s4VM8+w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-FLqV5ex0N4SCPKB4n1bYbA-1; Thu, 05 Dec 2024 19:58:47 -0500
X-MC-Unique: FLqV5ex0N4SCPKB4n1bYbA-1
X-Mimecast-MFC-AGG-ID: FLqV5ex0N4SCPKB4n1bYbA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8860ab00dso27077736d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446726; x=1734051526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jq9ieJQ9//qq2auSKoavGM6aHp5t8bjDLhHqkdKpCKw=;
 b=nnSqCxGXjmxtczW796EPrz6TPdZVV1OuQB9Z21tPjryj6XocYMU1vZAGKqG1vh7a3e
 hib+wnoHVbc7C1CCm3El5B8HB994smDSG9PVo4QpBylYpF1h1piQ9zH+pnpIAasmvtCt
 WDVCDb/rcsls+BcJeXvlDv2cpyo5SYmzK0GYaHGssMVT4MJFTtZ60pVWStsRL3T2uMPK
 3N/tQDLJWMn26T5144xxCtfGbprn/YbynFmcvAR8AQ+MQuZPjAGBe25gqgzTd1Zb/WrM
 2lFRkhD5P3ttMS6aEOgV7Blpz4m6tokiqqJq0zCuIF2joKzI5WYHnejS4WYkLxpxx0RR
 D1yg==
X-Gm-Message-State: AOJu0YwsatRlIYfq+T9xUhFEWK9EqDqQuZkPSl/VlHO0AynB+w094nmi
 dENtjL3X7hXXJQPz/i38Yqp71od6xu1cWEFYLZ7u4nKexhArOXeQVH7lo9jv4FI/kttwkW4zBjG
 axA/CrLJcAoAzCVfJGJipnsfpDQpCJ/I+l2veDBOThTeaAqIZ0MqvhryAitcXGQKl2ro9mnc4Ov
 e1RmSR/jlWvj8OBMxhEkhRh0cNCx7SeF7QMA==
X-Gm-Gg: ASbGncugPWdKy8yPulj/vxxC+AXzTyX21tojODe0xZqvMNHuJL28t5/Pg9qzf9rSsL6
 eljDAEgZ6MmvD8AK0YRiDaWpwgFbGjOi0+V+YapIILtCJ/dEh3rmf1TYusZwVqhKxJjiY2yQPaY
 cXR9iy6qZzvdneSUEEusTz5zJZ9MtWb+Ng1niUpYmm/d85kK9AUbWrHZE6ioL5yziaVBJIsZk3S
 wtOxu/6VqQ9V1OMW4qikezMQrsB1UbYHw/70c5LRIuPeHcRGS4iOyimskL3FCMfzRIyN/aCr1ij
 TOopT45r+aN3tkjGFq3K6sRYzA==
X-Received: by 2002:a05:6214:400b:b0:6d8:8b9d:1502 with SMTP id
 6a1803df08f44-6d8e71ebf0dmr17251036d6.30.1733446726556; 
 Thu, 05 Dec 2024 16:58:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXPWxDLHx/ej3m1LYVm/1cVuhXlhPgz4QiSfuXcagOoJw1NDxUyU37WNo3iFCTdLuErwJyhQ==
X-Received: by 2002:a05:6214:400b:b0:6d8:8b9d:1502 with SMTP id
 6a1803df08f44-6d8e71ebf0dmr17250716d6.30.1733446726181; 
 Thu, 05 Dec 2024 16:58:46 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:45 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 4/7] migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH
 messages
Date: Thu,  5 Dec 2024 19:58:31 -0500
Message-ID: <20241206005834.1050905-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206005834.1050905-1-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

RAM_SAVE_FLAG_MULTIFD_FLUSH message should always be correlated to a sync
request on src.  Unify such message into one place, and conditionally send
the message only if necessary.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h        |  2 +-
 migration/multifd-nocomp.c | 27 +++++++++++++++++++++++++--
 migration/ram.c            | 18 ++++--------------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index bd337631ec..c9ae57ea02 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -350,7 +350,7 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
-int multifd_ram_flush_and_sync(void);
+int multifd_ram_flush_and_sync(QEMUFile *f);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 219f9e58ef..58372db0f4 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -20,6 +20,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "qemu-file.h"
 
 static MultiFDSendData *multifd_ram_send;
 
@@ -343,9 +344,10 @@ retry:
     return true;
 }
 
-int multifd_ram_flush_and_sync(void)
+int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
+    int ret;
 
     if (!migrate_multifd()) {
         return 0;
@@ -361,7 +363,28 @@ int multifd_ram_flush_and_sync(void)
     /* File migrations only need to sync with threads */
     req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
 
-    return multifd_send_sync_main(req);
+    ret = multifd_send_sync_main(req);
+    if (ret) {
+        return ret;
+    }
+
+    /* If we don't need to sync with remote at all, nothing else to do */
+    if (req == MULTIFD_SYNC_LOCAL) {
+        return 0;
+    }
+
+    /*
+     * Old QEMUs don't understand RAM_SAVE_FLAG_MULTIFD_FLUSH, it relies
+     * on RAM_SAVE_FLAG_EOS instead.
+     */
+    if (migrate_multifd_flush_after_each_section()) {
+        return 0;
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+    qemu_fflush(f);
+
+    return 0;
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/ram.c b/migration/ram.c
index 44010ff325..90811aabd4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1306,15 +1306,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                 (!migrate_multifd_flush_after_each_section() ||
                  migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync();
+                int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
                     return ret;
                 }
-
-                if (!migrate_mapped_ram()) {
-                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                    qemu_fflush(f);
-                }
             }
 
             /* Hit the end of the list */
@@ -3044,18 +3039,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     bql_unlock();
-    ret = multifd_ram_flush_and_sync();
+    ret = multifd_ram_flush_and_sync(f);
     bql_lock();
     if (ret < 0) {
         error_setg(errp, "%s: multifd synchronization failed", __func__);
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
-        && !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
-
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ret = qemu_fflush(f);
     if (ret < 0) {
@@ -3190,7 +3180,7 @@ out:
     if (ret >= 0 && migration_is_running()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
-            ret = multifd_ram_flush_and_sync();
+            ret = multifd_ram_flush_and_sync(f);
             if (ret < 0) {
                 return ret;
             }
@@ -3268,7 +3258,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
          * Only the old dest QEMU will need this sync, because each EOS
          * will require one SYNC message on each channel.
          */
-        ret = multifd_ram_flush_and_sync();
+        ret = multifd_ram_flush_and_sync(f);
         if (ret < 0) {
             return ret;
         }
-- 
2.47.0


