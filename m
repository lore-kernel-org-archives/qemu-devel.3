Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2683FCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPH-0004ju-6j; Mon, 09 Mar 2026 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004fd-Mh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007jw-Mv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKLe9iiWMkSZNOnyjvHZMWwPo4cDtCVEG53p9Vctsgk=;
 b=DnWcqIZ42PnUpCO1G1klbJ85eaq0JBVx1TtMIF+/nP2jBP+TwOhsPWPtYkMczzSV5jVCyQ
 XMJb/ydIOLoOhEjCdhlXADSISRnGj1laDYmPhyJegoCv25E36eLTt7JQiy8clVvC5Dg+Oq
 1qzshxpfRMzlkihaDbq0MzU11Re57I8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-L4sUBdSNMbut5Jt5xDe59g-1; Mon, 09 Mar 2026 16:40:33 -0400
X-MC-Unique: L4sUBdSNMbut5Jt5xDe59g-1
X-Mimecast-MFC-AGG-ID: L4sUBdSNMbut5Jt5xDe59g_1773088833
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb6291d95aso4096430285a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088833; x=1773693633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKLe9iiWMkSZNOnyjvHZMWwPo4cDtCVEG53p9Vctsgk=;
 b=Yfnoz97BVFxtLAHciHRMi3oc8JW3tjs/EYZI9FwoYl5cnTCZydPDo1+ODMwNH3p/L0
 ryfWpHSO5sPAu4IB6EyDrKn16kmyaEEr64yFp/GRKKYBqCYPzo3WsRbviBw2Dy+cuANO
 PhfmoFDBc0WyqfUS/UI5IxyPaCz6lhJyZiK7q1I1Yr6HVzpGQRLp+wbAkTl1Ibt+M8sm
 RQD6KHp2PS6BR+9RZepZs4C+1RRJJfdPi7OCe082T+eLK5/DYG/0f7WglK5ZAYu57zng
 p4q2MW1qke/0nqk3pjmvHOLxNdJEtbLkzp1fhpww99m4TL8Dhf4mwQpIGNQkYSdiDh9v
 JIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088833; x=1773693633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IKLe9iiWMkSZNOnyjvHZMWwPo4cDtCVEG53p9Vctsgk=;
 b=s3CboqOEfOvTJJsspsWxyScG+E0/ygDhzUardJ9wgBfNpK8T5RmjfljpSAvLqf5DoH
 8gL5QpMHALUBA7q6wN96wGxnh8PBolS1IhTBHjRkoIwNsARHFxbVdgbBStyBRheEqD3T
 1rngfYcqI33JOEWqsPyCV0YH35CPnYcEWMdpNZloJeUgghv1KaLchYmYfrB45g/0BVs4
 7pIlFlt3eKzd1Gg4UPYhX4gUKhSjYnuXCW+AHNOoKjcvQMgQ63tfd9VsqAo6WuiSUqml
 6aFSc4Ja+9sDTTHtucpT67EngjQqL7RUU+uMKALrnHUk3O4gqQWaYAZQV015N3KMzv1F
 Ldkg==
X-Gm-Message-State: AOJu0Yyz3azRNIIL6FMWNb8OnN9vJM5ce/7z3jSglwfm33HVxXVe7pbH
 ajXuuTKOkWkZQZgASB2zmYEJkVKYk0ZCWg5xsjr/o66Lps5sICMaMa4V9RBjWUet+0pOvTmTEbn
 nyzsRzFaqMHRKVi6IGsghi1xntExkorXQ+sVG0yfJJfF73UeHtdPKnpQD+PrwLAOQugIOwIdYn1
 p5n06dhqb3WCIXpZ2YY7ay3O89KP8UkmEYRy0IMg==
X-Gm-Gg: ATEYQzyzOXfuI83z1ZK+TrTUE9FM7HraefMPXKuiDPa6tHh1rnpEiMUSV8L9QaoGRWw
 C1B3vvhEOlB4PADQSLzlBWRzjZbD+MOGUU59wdi9OEpU2h3C9qqAPnwhVEcrEZMwWFK7KZ2IUKJ
 KkuEPyDitIsvyi3QMoLaEuWDY7Kl179hLG65Mmi/EXUHg6eFpzY99ZTZB3Vtl3sxxlmagL2ncKt
 iuI0j1qnKZqPuzQqEZLKwnonjVfdP+maoiE6yPkX1yWQQDLmxSQimKffbnb+2SW0alLRf8oikem
 cv97j08TqCMWPsi+2rCX/lZ1YCApXEe/izKVB7tlfujjlhN/EKjncLf9I1pIkb2VV5QWHnqzxVr
 i9t5Az9LmVNteuaLs//r+TrG8eGSqunumpnKSAOZLXDuomJe2wKQc/QjHDPQYtKObKyZ9hR8KJD
 6WrukaTA==
X-Received: by 2002:a05:620a:444d:b0:8cd:8a8b:8cf6 with SMTP id
 af79cd13be357-8cd8a8b9552mr537873285a.10.1773088832660; 
 Mon, 09 Mar 2026 13:40:32 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:8cd:8a8b:8cf6 with SMTP id
 af79cd13be357-8cd8a8b9552mr537868585a.10.1773088832024; 
 Mon, 09 Mar 2026 13:40:32 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PULL 11/18] memory: drop RamDiscardListener::double_discard_supported
Date: Mon,  9 Mar 2026 16:40:00 -0400
Message-ID: <20260309204007.1709441-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This was never turned off, effectively some dead code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://lore.kernel.org/r/20260226140001.3622334-3-marcandre.lureau@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h       | 12 +-----------
 hw/vfio/listener.c            |  2 +-
 hw/virtio/virtio-mem.c        | 22 ++--------------------
 system/ram-block-attributes.c | 23 +----------------------
 4 files changed, 5 insertions(+), 54 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index d4793a08a7..d6b5ca13c2 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -580,26 +580,16 @@ struct RamDiscardListener {
      */
     NotifyRamDiscard notify_discard;
 
-    /*
-     * @double_discard_supported:
-     *
-     * The listener suppors getting @notify_discard notifications that span
-     * already discarded parts.
-     */
-    bool double_discard_supported;
-
     MemoryRegionSection *section;
     QLIST_ENTRY(RamDiscardListener) next;
 };
 
 static inline void ram_discard_listener_init(RamDiscardListener *rdl,
                                              NotifyRamPopulate populate_fn,
-                                             NotifyRamDiscard discard_fn,
-                                             bool double_discard_supported)
+                                             NotifyRamDiscard discard_fn)
 {
     rdl->notify_populate = populate_fn;
     rdl->notify_discard = discard_fn;
-    rdl->double_discard_supported = double_discard_supported;
 }
 
 /**
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 1087fdc142..960da9e0a9 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -283,7 +283,7 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
 
     ram_discard_listener_init(&vrdl->listener,
                               vfio_ram_discard_notify_populate,
-                              vfio_ram_discard_notify_discard, true);
+                              vfio_ram_discard_notify_discard);
     ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
     QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c1e2defb68..251d1d50aa 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -331,14 +331,6 @@ static int virtio_mem_notify_populate_cb(MemoryRegionSection *s, void *arg)
     return rdl->notify_populate(rdl, s);
 }
 
-static int virtio_mem_notify_discard_cb(MemoryRegionSection *s, void *arg)
-{
-    RamDiscardListener *rdl = arg;
-
-    rdl->notify_discard(rdl, s);
-    return 0;
-}
-
 static void virtio_mem_notify_unplug(VirtIOMEM *vmem, uint64_t offset,
                                      uint64_t size)
 {
@@ -398,12 +390,7 @@ static void virtio_mem_notify_unplug_all(VirtIOMEM *vmem)
     }
 
     QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
-        if (rdl->double_discard_supported) {
-            rdl->notify_discard(rdl, rdl->section);
-        } else {
-            virtio_mem_for_each_plugged_section(vmem, rdl->section, rdl,
-                                                virtio_mem_notify_discard_cb);
-        }
+        rdl->notify_discard(rdl, rdl->section);
     }
 }
 
@@ -1824,12 +1811,7 @@ static void virtio_mem_rdm_unregister_listener(RamDiscardManager *rdm,
 
     g_assert(rdl->section->mr == &vmem->memdev->mr);
     if (vmem->size) {
-        if (rdl->double_discard_supported) {
-            rdl->notify_discard(rdl, rdl->section);
-        } else {
-            virtio_mem_for_each_plugged_section(vmem, rdl->section, rdl,
-                                                virtio_mem_notify_discard_cb);
-        }
+        rdl->notify_discard(rdl, rdl->section);
     }
 
     memory_region_section_free_copy(rdl->section);
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 9f72a6b354..630b0fda12 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -61,16 +61,6 @@ ram_block_attributes_notify_populate_cb(MemoryRegionSection *section,
     return rdl->notify_populate(rdl, section);
 }
 
-static int
-ram_block_attributes_notify_discard_cb(MemoryRegionSection *section,
-                                       void *arg)
-{
-    RamDiscardListener *rdl = arg;
-
-    rdl->notify_discard(rdl, section);
-    return 0;
-}
-
 static int
 ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
                                                 MemoryRegionSection *section,
@@ -191,22 +181,11 @@ ram_block_attributes_rdm_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl)
 {
     RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
-    int ret;
 
     g_assert(rdl->section);
     g_assert(rdl->section->mr == attr->ram_block->mr);
 
-    if (rdl->double_discard_supported) {
-        rdl->notify_discard(rdl, rdl->section);
-    } else {
-        ret = ram_block_attributes_for_each_populated_section(attr,
-                rdl->section, rdl, ram_block_attributes_notify_discard_cb);
-        if (ret) {
-            error_report("%s: Failed to unregister RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            exit(1);
-        }
-    }
+    rdl->notify_discard(rdl, rdl->section);
 
     memory_region_section_free_copy(rdl->section);
     rdl->section = NULL;
-- 
2.50.1


