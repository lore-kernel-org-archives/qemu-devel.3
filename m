Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B857C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tK-0004uL-LL; Fri, 16 Feb 2024 17:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tJ-0004tq-Ca
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:09 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tH-0007HE-85
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:09 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4c76b0962a2so205914e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123265; x=1708728065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDa8kynJoLoRNVNC8BFkudqqHcHPgvw0b+BqMDcdRzY=;
 b=Cmu38GUqOZEqCrVu0VEfJLLSglQIq5c3qBwoPNs4hOW2VSnKbsWTPPUV5w79jml8Cy
 LB+MskrGQ/KDEw6gMTXjOjsrSz+5FTZEO37qgEJGi75/Eww01UU31HrQyLiRGFTOk4e6
 P0zFq1OMlc4jEvbUnjI/tVc28AHH3fWU60XwlUTBTiM1hRBtxVcA3Harso/eGMN3/KtU
 iAMSKB08JB7lrBQcJ9IzHze9Zmq2ZHmf5l2tqKyNXtWdvDuY6Du1UzraqAr+SqtonZIS
 g8xCvqbEP11dzg2WiBXFTzU1lkJt4M0cyNCPWUzrvB4/zfd/2Lorr/2D9jQK8E8zxk4A
 eovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123265; x=1708728065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDa8kynJoLoRNVNC8BFkudqqHcHPgvw0b+BqMDcdRzY=;
 b=T0ymr9hJnKeKNxW718tBd+S67dVPhqBDo23gOEdOY/1rUzEg2ahe4kbDCSyXn7LBqX
 Lgg2cRUSCj+WCKZLzBKilulxROu5XukfLYXQF8pHkJ527tksckPdkFhzXhhPhMAxKvrj
 /4MlSUU43j9PoDp/UffeUMYQLBP14Q2qEOjRmMr/ZagWU2IE27eixdcQpIVwv7vpNquA
 bxbOnMo9ZXfvtnsiCMK2XlY5uJRwqDJ6i4GVDZ6IqIb3V5Pw6ozlZalbcefqnB/uJeyT
 CreRBqcqA0MvhJFxYDo7e5ut2oQtsZMJYiOq9KFpr4oz1zYiR5sl7x01KS46pbLM2zwx
 c61g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLRozhinldbLEjZEAQtBritjAcSNdASor9ghrHGeVgdpheheUo0tr8xHyX/Lu8XWCnC+ePnesI8NtU//tRFnb5sT+3CQQ=
X-Gm-Message-State: AOJu0YxO+UJg0wyE8hVdQcMejyUe23mRqSNVoxJL2lAinHu9sG4vWc1X
 hYUrD/+d8fGSweVSiuq2HlKVkX3DSt9d/zgI71IBMu/CO38+uQKJn7R9ShyqrDA=
X-Google-Smtp-Source: AGHT+IFtaoCia9TfxFEajv1LzQ17cfr4KrBmC81CTioC1tDcZR+61LgqGCY1CvlHpMAAaatuwM26YA==
X-Received: by 2002:a1f:6dc3:0:b0:4bd:7a0f:960 with SMTP id
 i186-20020a1f6dc3000000b004bd7a0f0960mr5752799vkc.5.1708123265176; 
 Fri, 16 Feb 2024 14:41:05 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:41:04 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 2/7] migration/multifd: Support for zero pages transmission
 in multifd format.
Date: Fri, 16 Feb 2024 22:39:57 +0000
Message-Id: <20240216224002.1476890-3-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216224002.1476890-1-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This change adds zero page counters and updates multifd send/receive
tracing format to track the newly added counters.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/multifd.c    | 43 ++++++++++++++++++++++++++++++++++--------
 migration/multifd.h    | 21 ++++++++++++++++++++-
 migration/ram.c        |  1 -
 migration/trace-events |  8 ++++----
 4 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..a33dba40d9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -236,6 +236,8 @@ static void multifd_pages_reset(MultiFDPages_t *pages)
      * overwritten later when reused.
      */
     pages->num = 0;
+    pages->normal_num = 0;
+    pages->zero_num = 0;
     pages->block = NULL;
 }
 
@@ -309,6 +311,8 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
 
     pages->allocated = n;
     pages->offset = g_new0(ram_addr_t, n);
+    pages->normal = g_new0(ram_addr_t, n);
+    pages->zero = g_new0(ram_addr_t, n);
 
     return pages;
 }
@@ -319,6 +323,10 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     pages->allocated = 0;
     g_free(pages->offset);
     pages->offset = NULL;
+    g_free(pages->normal);
+    pages->normal = NULL;
+    g_free(pages->zero);
+    pages->zero = NULL;
     g_free(pages);
 }
 
@@ -332,6 +340,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
     packet->normal_pages = cpu_to_be32(pages->num);
+    packet->zero_pages = cpu_to_be32(pages->zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
     packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
@@ -350,9 +359,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     p->packets_sent++;
     p->total_normal_pages += pages->num;
+    p->total_zero_pages += pages->zero_num;
 
-    trace_multifd_send(p->id, packet_num, pages->num, p->flags,
-                       p->next_packet_size);
+    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
+                       p->flags, p->next_packet_size);
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -393,20 +403,29 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->normal_num = be32_to_cpu(packet->normal_pages);
     if (p->normal_num > packet->pages_alloc) {
         error_setg(errp, "multifd: received packet "
-                   "with %u pages and expected maximum pages are %u",
+                   "with %u normal pages and expected maximum pages are %u",
                    p->normal_num, packet->pages_alloc) ;
         return -1;
     }
 
+    p->zero_num = be32_to_cpu(packet->zero_pages);
+    if (p->zero_num > packet->pages_alloc - p->normal_num) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u zero pages and expected maximum zero pages are %u",
+                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+        return -1;
+    }
+
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
     p->total_normal_pages += p->normal_num;
+    p->total_zero_pages += p->zero_num;
 
-    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->flags,
-                       p->next_packet_size);
+    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                       p->flags, p->next_packet_size);
 
-    if (p->normal_num == 0) {
+    if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
 
@@ -823,6 +842,8 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.normal_pages, pages->num);
+            stat64_add(&mig_stats.zero_pages, pages->zero_num);
 
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
@@ -866,7 +887,8 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1132,6 +1154,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->iov = NULL;
     g_free(p->normal);
     p->normal = NULL;
+    g_free(p->zero);
+    p->zero = NULL;
     multifd_recv_state->ops->recv_cleanup(p);
 }
 
@@ -1251,7 +1275,9 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->packets_recved,
+                                  p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1290,6 +1316,7 @@ int multifd_recv_setup(Error **errp)
         p->name = g_strdup_printf("multifdrecv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
+        p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
     }
diff --git a/migration/multifd.h b/migration/multifd.h
index 8a1cad0996..9822ff298a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -48,7 +48,10 @@ typedef struct {
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     uint64_t packet_num;
-    uint64_t unused[4];    /* Reserved for future use */
+    /* zero pages */
+    uint32_t zero_pages;
+    uint32_t unused32[1];    /* Reserved for future use */
+    uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
@@ -56,10 +59,18 @@ typedef struct {
 typedef struct {
     /* number of used pages */
     uint32_t num;
+    /* number of normal pages */
+    uint32_t normal_num;
+    /* number of zero pages */
+    uint32_t zero_num;
     /* number of allocated pages */
     uint32_t allocated;
     /* offset of each page */
     ram_addr_t *offset;
+    /* offset of normal page */
+    ram_addr_t *normal;
+    /* offset of zero page */
+    ram_addr_t *zero;
     RAMBlock *block;
 } MultiFDPages_t;
 
@@ -124,6 +135,8 @@ typedef struct {
     uint64_t packets_sent;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
+    /* zero pages sent through this channel */
+    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -178,12 +191,18 @@ typedef struct {
     uint8_t *host;
     /* non zero pages recv through this channel */
     uint64_t total_normal_pages;
+    /* zero pages recv through this channel */
+    uint64_t total_zero_pages;
     /* buffers to recv */
     struct iovec *iov;
     /* Pages that are not zero */
     ram_addr_t *normal;
     /* num of non zero pages */
     uint32_t normal_num;
+    /* Pages that are zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for de-compression methods */
     void *data;
 } MultiFDRecvParams;
diff --git a/migration/ram.c b/migration/ram.c
index 556725c30f..5ece9f042e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1259,7 +1259,6 @@ static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
     if (!multifd_queue_page(block, offset)) {
         return -1;
     }
-    stat64_add(&mig_stats.normal_pages, 1);
 
     return 1;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 298ad2b0dd..9f1d7ae71a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -128,21 +128,21 @@ postcopy_preempt_reset_channel(void) ""
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
 multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " pages %u flags 0x%x next packet size %u"
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
 multifd_recv_sync_main_wait(uint8_t id) "channel %u"
 multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %u packets %" PRIu64 " pages %" PRIu64
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" PRIu64 " zero pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u flags 0x%x next packet size %u"
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-- 
2.30.2


