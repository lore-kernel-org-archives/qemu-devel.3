Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2046FA3758
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 06:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqoV8-0006zf-Ia; Wed, 18 Sep 2024 02:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sqoUz-0006yH-Lo
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sqoUt-0004st-Ug
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726642145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I2+Iq2NW1mAJWJH/AFlvZG7ScqDqeQUBPTWOpbwuzGQ=;
 b=T9a78nA/K+Wn2sYPiazcebbKQ0JBoNz8uUv+El4mcazrpf/N76qi6uRc5ErhNHyQTjCytj
 y8iG9Khd5FHGfaGlDekfFRSwaaxOCCIYWzRAAFT2NmG13POkCUqenHzVfEajt8xmANrVm7
 wFP7XxJbyEKm84j3TIgm7M/ZQJlxBPc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-zEpizykbOEWxdM0zhN9NWw-1; Wed, 18 Sep 2024 02:49:03 -0400
X-MC-Unique: zEpizykbOEWxdM0zhN9NWw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-717912c8f27so7969179b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 23:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726642142; x=1727246942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2+Iq2NW1mAJWJH/AFlvZG7ScqDqeQUBPTWOpbwuzGQ=;
 b=q0nsMjUDMhLMKh9pTJGxkc3tegYqzQ8ZrSnvU+LsVFstvIzio8XGEjmxN09MDd0Os/
 E2ddrffb+dvIN4oihoDwXqMW9AE8jTlWJhBJJ4LnPKXH6jEipYZohYUuMZvKwl3FzHag
 6OMqMMlEWY8uDSLkCZq1BFbkFUG/yKgm7ZS089gCT8hQsK4oT4quQ0e2ACchOkbD5cqG
 HZBvqT06+v8owAmCt7SLm2kKjp2kno71PqT11wq/GCDfVgH1vwxDZNHnFigEkUnqCAd7
 aSs4UMEytTiw0aP3DhUSRJJmmVzhhCp2NeheABHH5RHJAiIC8eMb7y2vLx5MmxZZCzwj
 R0Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUogzDF3kATAaIgk1FuLDVvffw6D2P+r6jKbTG8zFEw21Zu8Gl5rIxNLj/QpJMTz1MT7qUeDYgPZyC2@nongnu.org
X-Gm-Message-State: AOJu0YzEgOvlNZPkq4AnBy7GDl/hgWNieRIst+XkCIchCp1lRmCbulO5
 tt3q1ti5tCMNL+WbT2m5oFt/rl4nbbT00IWNAVQUen0KjW7qc+FVr3wBgjcMeG/C6ZrRZ7fSk85
 ZDEqhW28iQeEAPZ7NVkm3GoXtqcs093K4y5rRJwbJN5Bk8ZL2CyAL
X-Received: by 2002:a05:6a00:3d4c:b0:717:90cd:7943 with SMTP id
 d2e1a72fcca58-71926218480mr30676633b3a.28.1726642142508; 
 Tue, 17 Sep 2024 23:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysm0eNTRSPiC0f2N5l9SEg6j9aCH62mHEh3RjWGZoKymFQhjstZ8NujqAiS4vntN7BKgfXQ==
X-Received: by 2002:a05:6a00:3d4c:b0:717:90cd:7943 with SMTP id
 d2e1a72fcca58-71926218480mr30676619b3a.28.1726642142062; 
 Tue, 17 Sep 2024 23:49:02 -0700 (PDT)
Received: from localhost.localdomain ([27.6.219.91])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-71944a977aesm6098340b3a.25.2024.09.17.23.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 23:49:01 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] memory: notify hypervisor of all eventfds during listener
 (de)registration
Date: Wed, 18 Sep 2024 12:18:53 +0530
Message-ID: <20240918064853.30678-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When a new listener for an address space is registered, the hypervisor must be
informed of all existing eventfds for that address space by calling
eventfd_add() for that listener. Similarly, when a listener is de-registered
from an address space, the hypervisor must be informed of all existing eventfds
for that address space with a call to eventfd_del().

Same is also true for coalesced io. Send coalesced io add/del listener
notifications if any flatrage for the address space registered with the
listener intersects with any coalesced io range.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/memory.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

changelog:
v2: tags added, indentation fixed, commit log fixed, code cleanup.
v3: Peter's suggestions included.

diff --git a/system/memory.c b/system/memory.c
index f6f6fee6d8..85f6834cb3 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -941,6 +941,38 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
     }
 }
 
+static void
+flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
+                                                MemoryRegionSection *mrs,
+                                                MemoryListener *listener,
+                                                AddressSpace *as, bool add)
+{
+    CoalescedMemoryRange *cmr;
+    MemoryRegion *mr = fr->mr;
+    AddrRange tmp;
+
+    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
+        tmp = addrrange_shift(cmr->addr,
+                              int128_sub(fr->addr.start,
+                                         int128_make64(fr->offset_in_region)));
+
+        if (!addrrange_intersects(tmp, fr->addr)) {
+            return;
+        }
+        tmp = addrrange_intersection(tmp, fr->addr);
+
+        if (add && listener->coalesced_io_add) {
+            listener->coalesced_io_add(listener, mrs,
+                                       int128_get64(tmp.start),
+                                       int128_get64(tmp.size));
+        } else if (!add && listener->coalesced_io_del) {
+            listener->coalesced_io_del(listener, mrs,
+                                       int128_get64(tmp.start),
+                                       int128_get64(tmp.size));
+        }
+    }
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -3015,8 +3047,10 @@ void memory_global_dirty_log_stop(unsigned int flags)
 static void listener_add_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3041,10 +3075,34 @@ static void listener_add_address_space(MemoryListener *listener,
         if (listener->region_add) {
             listener->region_add(listener, &section);
         }
+
+        /* send coalesced io add notifications */
+        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
+                                                        listener, as, true);
+
         if (fr->dirty_log_mask && listener->log_start) {
             listener->log_start(listener, &section, 0, fr->dirty_log_mask);
         }
     }
+
+    /*
+     * register all eventfds for this address space for the newly registered
+     * listener.
+     */
+    for (i = 0; i < as->ioeventfd_nb; i++) {
+        fd = &as->ioeventfds[i];
+        MemoryRegionSection section = (MemoryRegionSection) {
+            .fv = view,
+            .offset_within_address_space = int128_get64(fd->addr.start),
+            .size = fd->addr.size,
+        };
+
+        if (listener->eventfd_add) {
+            listener->eventfd_add(listener, &section,
+                                  fd->match_data, fd->data, fd->e);
+        }
+    }
+
     if (listener->commit) {
         listener->commit(listener);
     }
@@ -3054,8 +3112,10 @@ static void listener_add_address_space(MemoryListener *listener,
 static void listener_del_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3067,10 +3127,33 @@ static void listener_del_address_space(MemoryListener *listener,
         if (fr->dirty_log_mask && listener->log_stop) {
             listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
         }
+
+        /* send coalesced io del notifications */
+        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
+                                                        listener, as, false);
         if (listener->region_del) {
             listener->region_del(listener, &section);
         }
     }
+
+    /*
+     * de-register all eventfds for this address space for the current
+     * listener.
+     */
+    for (i = 0; i < as->ioeventfd_nb; i++) {
+        fd = &as->ioeventfds[i];
+        MemoryRegionSection section = (MemoryRegionSection) {
+            .fv = view,
+            .offset_within_address_space = int128_get64(fd->addr.start),
+            .size = fd->addr.size,
+        };
+
+        if (listener->eventfd_del) {
+            listener->eventfd_del(listener, &section,
+                                  fd->match_data, fd->data, fd->e);
+        }
+    }
+
     if (listener->commit) {
         listener->commit(listener);
     }
-- 
2.42.0


