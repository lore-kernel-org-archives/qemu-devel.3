Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF1C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok7C-0002ec-4b; Tue, 28 Jul 2026 11:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok7B-0002dI-Jy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok79-0005e4-Vi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsdEC238+EJ4wcu0RMnaKQsB+teECc3qnNE3oYsKC+s=;
 b=bBhxPKSNcAusyYSpRfJBb/eNrMCpNrcQT84+KammZWQ/UqW7fTWP8VSguOr29oFDITomZV
 QrlWytMNRaflhCOXewY6EhYkVczGN2U+KPju4ZCtX3MTy6MIQzdTCcRWp50iUfDMk2ha9O
 puOuRintK/mfd4cK/CKCqwRP7gn410w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Qz7NMP1WPPqozj3_En0psQ-1; Tue, 28 Jul 2026 11:53:05 -0400
X-MC-Unique: Qz7NMP1WPPqozj3_En0psQ-1
X-Mimecast-MFC-AGG-ID: Qz7NMP1WPPqozj3_En0psQ_1785253985
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso47665691cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253985; x=1785858785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qsdEC238+EJ4wcu0RMnaKQsB+teECc3qnNE3oYsKC+s=;
 b=FoGZOQXENEbqvECyBchhlK8qXaos0GQuN9wyqWOWOv019NftasP2ds348q1VkUh2Y6
 zXd0O3gZW1AeA7nrS2nSI97eDCnvir0v0Wt0KY61x3h11LbRC0oB0TPwEkGGFbDldUDi
 8YMFLpx50TMI9wZE31kDXG7D5K/pWqx+xtiC2sCkDlppMSA7R1OYyRtYIDOLmNCaPXUC
 7tjDfEKb6BkFf5rA9iy41f3TrDxOpfPWU0hSbhZFQ8nMInxUHueiCgKgU5nlii7ZkEIA
 wvO2rOPxQ9dUB6YaYa+BuNtYR/iEmHUXlsbTw7CP5nlWHCMpWRxZ6mI7As7vFScNHdaE
 +aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253985; x=1785858785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qsdEC238+EJ4wcu0RMnaKQsB+teECc3qnNE3oYsKC+s=;
 b=WG2jmJjWGmoiyadOBcrpF64WPtC3HuyE9O5nu7cMLCsSdFS6jQ2acgeqC/bGRPgXss
 69uGmAUCox6qbw/GAxm1pOzDfkOM/BiyXXmDroWWuu+nFOzld7TfjLyEPztqs0ZiMxS8
 tgzG0NxP6kSRvM2ELZclvwdro4/nAIxtskPjFwAC1VPm6EkHBoqlBwaAMTgEm7xghi7d
 YPesHbD3G+QLhIO9X2RY1vatWdNXfDoELrt4BU4w6oE++NTZtXN1nk0bToOyZkwJgLmi
 31TLKXQK21NwS1vLMSa9F+WJGFSamQkXV3GGZrij/a7IKmY9OuUp8S4YVM8D/i0QfdWx
 QZQw==
X-Gm-Message-State: AOJu0YwwNVdhQGHfY4uad36U5xi8SQq23g15NTK0lUs48XmZL3lqRkMl
 PqCEFY0UA7obO/ur9msbyEcAaOqhjpao4mBdKOby6KJjBTOks6FiWFy8R+6yYhzvevLabPaS6fd
 xbQI6hmishsJNUZT24PuJuQlvlYwhQGe4VE/3L7ZAuAiwxZ7UAt/nd4NQqZLYxB+AqW36+lW8W0
 PE8SNPMlb11LYzUDuUsTGqTGXaX//bSrrgW2R3fg==
X-Gm-Gg: AR+sD12PO6Pm+HvTwwdzKyGy/EeBLS3BxnP5iveaw3CNI7wf8SRxjOuYlNZUEvFKota
 h9AbwyPq3REZzSCmPaAfAnR+b8TqeC19TePqF9Ca5KMbtC60L/gD189P9/aaMjZsOoqkFDOGTEm
 BxIHz9EXsWu+8d16M1GWgUuoTjIQowdUvyDHMiuESY+Lw8h4f4zN83vJ9ZXq0gVsjIsolVwdAzR
 KDAOj2xeTnMq6HXtvqo/97I/I3ZFMdAybVxJ/xOj7kM5KwJp6rkhTsgxPawMtkrrHRwUCc/6eUE
 EV38rfcwIi73Z9keEDGz6U+vRfhKaEiNbVDKwpUGYn3oK8SOm4gRya90eLQh0gOFFw==
X-Received: by 2002:a05:622a:5a13:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-529d6ffc1f2mr27787671cf.24.1785253984766; 
 Tue, 28 Jul 2026 08:53:04 -0700 (PDT)
X-Received: by 2002:a05:622a:5a13:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-529d6ffc1f2mr27787031cf.24.1785253984083; 
 Tue, 28 Jul 2026 08:53:04 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2dd54dbsm492481cf.23.2026.07.28.08.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:53:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Yuan Liu <yuan1.liu@intel.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: [PATCH 3/5] migration/multifd: Replace assert() with error_setg() in
 recv paths
Date: Tue, 28 Jul 2026 11:52:45 -0400
Message-ID: <20260728155247.1894355-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728155247.1894355-1-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QPL and UADK multifd backends use assert() to validate wire-controlled
fields like per-page compressed lengths and packet size consistency.  These
asserts will stop working with released version of binaries, so may stop
working.

Replace all assert() calls in the receive path with proper error_setg() so
validation failures are reported gracefully rather than crashing or
silently ignored.

While at it, touch up an assert() in qatzip recv path too.

Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Yuan Liu <yuan1.liu@intel.com>
Cc: Yichen Wang <yichen.wang@bytedance.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-qatzip.c |  5 ++++-
 migration/multifd-qpl.c    | 24 ++++++++++++++++++++----
 migration/multifd-uadk.c   | 24 ++++++++++++++++++++----
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 7419e5dc0d..0262e81eac 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -348,7 +348,10 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
 
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 52902eb00c..3826e7f340 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -664,26 +664,42 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     }
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
     /* read compressed page lengths */
     len = p->normal_num * sizeof(uint32_t);
-    assert(len < in_size);
+    if (len >= in_size) {
+        error_setg(errp, "multifd %u: header len %"PRIu32
+                   " >= packet size %"PRIu32, p->id, len, in_size);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) qpl->zlen, len, errp);
     if (ret != 0) {
         return ret;
     }
     for (int i = 0; i < p->normal_num; i++) {
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
-        assert(qpl->zlen[i] <= multifd_ram_page_size());
+        if (qpl->zlen[i] > multifd_ram_page_size()) {
+            error_setg(errp, "multifd %u: page %d compressed len %"
+                       PRIu32" too large", p->id, i, qpl->zlen[i]);
+            return -1;
+        }
         zbuf_len += qpl->zlen[i];
         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
 
     /* read compressed pages */
-    assert(in_size == len + zbuf_len);
+    if (in_size != len + zbuf_len) {
+        error_setg(errp, "multifd %u: packet size %"PRIu32
+                   " != header %"PRIu32" + data %"PRIu32,
+                   p->id, in_size, len, zbuf_len);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, zbuf_len, errp);
     if (ret != 0) {
         return ret;
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index fd7cd9b5e8..d373615ba8 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -245,12 +245,19 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
     /* read compressed data lengths */
-    assert(hdr_len < in_size);
+    if (hdr_len >= in_size) {
+        error_setg(errp, "multifd %u: header len %"PRIu32
+                   " >= packet size %"PRIu32, p->id, hdr_len, in_size);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) uadk_data->buf_hdr,
                                hdr_len, errp);
     if (ret != 0) {
@@ -259,12 +266,21 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 
     for (int i = 0; i < p->normal_num; i++) {
         uadk_data->buf_hdr[i] = be32_to_cpu(uadk_data->buf_hdr[i]);
+        if (uadk_data->buf_hdr[i] > page_size) {
+            error_setg(errp, "multifd %u: page %d compressed len %"PRIu32
+                       " too large", p->id, i, uadk_data->buf_hdr[i]);
+            return -1;
+        }
         data_len += uadk_data->buf_hdr[i];
-        assert(uadk_data->buf_hdr[i] <= page_size);
     }
 
     /* read compressed data */
-    assert(in_size == hdr_len + data_len);
+    if (in_size != hdr_len + data_len) {
+        error_setg(errp, "multifd %u: packet size %"PRIu32
+                   " != header %"PRIu32" + data %"PRIu32,
+                   p->id, in_size, hdr_len, data_len);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *)buf, data_len, errp);
     if (ret != 0) {
         return ret;
-- 
2.54.0


