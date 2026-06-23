Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0764FCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Yb-0004aB-Lx; Tue, 23 Jun 2026 08:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0Ya-0004ZA-7K
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YW-00071r-LH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnHOf95eEO5Hr/V1VRLg1UJ6geTMs4NXXavyS/3wyUs=;
 b=HztBtmJvMKO1Dne9HkV3DVwIeQ7Bf5u5N2kmqyMcl6HJVVyXKHmezsBjCcfq8Zheo06UYr
 u3P5grjpxddoLlShWn0DHFHO4rpRoiuDoPyylwkWML9/u+4R6EtwEMIO3nvpBOKkkK9WpI
 yBFUVUJj9kd3M9VeM4IkqzhOSX/67Cw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Cg5U7s2EN9mUZcQ0aOIU4g-1; Tue, 23 Jun 2026 08:48:39 -0400
X-MC-Unique: Cg5U7s2EN9mUZcQ0aOIU4g-1
X-Mimecast-MFC-AGG-ID: Cg5U7s2EN9mUZcQ0aOIU4g_1782218919
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517878a92c5so100458451cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218919; x=1782823719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnHOf95eEO5Hr/V1VRLg1UJ6geTMs4NXXavyS/3wyUs=;
 b=ikBNIMJ3lxYIbJrAbm42RkvI9Y0OYV0hOQYwbgH2qcrXyh5Z+JAU0/zXtrBC/S4TQn
 cuee0O5RCTd8dGRf9pLQK7hUuYrMVvQYkajQA4Jq3FolDEZwsbenKCVTKyUtYYYNADMS
 LYuCrDfdFLLUZfZzDiVApKn+kJykFJPAWdE7GcfJhe+D4FGsY3y4/cYnneh3iR8Yh6PX
 5oJXF/ZLnS1yugbAdWZvZ6tbjepJmXK/IvRd7ZORBaviOA57ZN9/nHqRMmlrq5myBZfe
 y40zjUQ82aEsehuOKyvZ76qeRR2xBqKrxyxFaZinZsHFQcwV8t0oEOQOINvKYdhfQBdk
 i2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218919; x=1782823719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XnHOf95eEO5Hr/V1VRLg1UJ6geTMs4NXXavyS/3wyUs=;
 b=oj7YVhhCEBuQVGt+bQLqY8iVqWpXGKGL47CEr0ZccD6BXVnbjnq7Xj5nZfHHuNYtYu
 zeOEYy+cp8RYyr02HVPZUECpeJRokjF3Pm0nXaPyeW7vyuxX2vhL/tjoieo21kxsnDsL
 KaQsXYjHANGZpHRsUWsFYaUh7PCPjCpbzPj4xEA6eS/blSVmhmwBDFTOCVU9e/3VBIYM
 pbDpHDqMFFvTRI9FgcP4VO86IpMPoVoBTTPKUt/VMlmHO31alSl/s91tz5WCLl3EX/vR
 BrBHCevnusNY15KghXMx+YVaqyBO4Js/A1Tm3ExfbsgLe/u2u2cGPWXJ7rvaVHI1HIZB
 XDQA==
X-Gm-Message-State: AOJu0YyTUv73oe9++PxVjA6Jxy1yNaVUSq/n27zU1YU+rYRU6Nt5m1zF
 oYaLFF5orkSUCvMp1Lfz6Qv5cEiv6bXcW4J7tboBlkPNGMuhb0LNehfGxWxr+ymL4xMQEKkaQnP
 dteijZVSU4AMpxUmBLfRBIQRbaFVu02nyNdfA2p+lwuJeMLOqTnEFlfJKReyB8r6Cz/zhdLut/b
 G2I472J7jJzsnY1dPatkvxMZejj6Ay+NB+CW9BpA==
X-Gm-Gg: AfdE7cm7NUmbo3yAgYQwwleMo9Ofwlgct546QqkeHI3qOxE5CK4v7xa1WUTIyxSkgu0
 1INKtjkwMvap7md99kyKj7+MhqD1zdCoPqxXFfacagYaOuiCowJdzwf4aBkBV/fZDMi2fyTTunG
 7DjtkNPsowARCGVEC5UY+WT73cFUngUZ6dJzPk4w9ku/CipIrUdVSWXLeK3wVjCPWQjVy9IfLwT
 mnukkdf97rT+siNOod16wbnlgz5GrzwOCN2voNzajtPJWBJeJ5WhKeROo0d8k5fAIuA/6/cDs0e
 zbhPYwspILZLmy4OyRWD53mFcLNjw+IB9kKkFKAuG7cvEPyYaLYmZtshnxYLYpWGPqgAIqoESPU
 sKQ==
X-Received: by 2002:a05:622a:7503:b0:519:f423:d3e0 with SMTP id
 d75a77b69052e-519f99f08f6mr193504571cf.35.1782218918878; 
 Tue, 23 Jun 2026 05:48:38 -0700 (PDT)
X-Received: by 2002:a05:622a:7503:b0:519:f423:d3e0 with SMTP id
 d75a77b69052e-519f99f08f6mr193504081cf.35.1782218918288; 
 Tue, 23 Jun 2026 05:48:38 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 13/18] system/ram-discard-manager: drop replay from source
 interface
Date: Tue, 23 Jun 2026 08:47:54 -0400
Message-ID: <20260623124759.125399-14-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Remove replay_populated and replay_discarded from RamDiscardSourceClass
now that the RamDiscardManager handles replay iteration internally via
is_populated.

Remove the now-dead replay methods, helpers, and
for_each_populated/discarded_section() from ram-block-attributes, which
was the last source still carrying this code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-6-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/ram-discard-manager.h |  52 +++--------
 system/ram-block-attributes.c        | 130 ---------------------------
 2 files changed, 10 insertions(+), 172 deletions(-)

diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
index b188e09a30..b5dbcb4a82 100644
--- a/include/system/ram-discard-manager.h
+++ b/include/system/ram-discard-manager.h
@@ -77,8 +77,8 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
 /**
  * typedef ReplayRamDiscardState:
  *
- * The callback handler for #RamDiscardSourceClass.replay_populated/
- * #RamDiscardSourceClass.replay_discarded to invoke on populated/discarded
+ * The callback handler used by ram_discard_manager_replay_populated() and
+ * ram_discard_manager_replay_discarded() to invoke on populated/discarded
  * parts.
  *
  * @section: the #MemoryRegionSection of populated/discarded part
@@ -134,42 +134,6 @@ struct RamDiscardSourceClass {
      */
     bool (*is_populated)(const RamDiscardSource *rds,
                          const MemoryRegionSection *section);
-
-    /**
-     * @replay_populated:
-     *
-     * Call the #ReplayRamDiscardState callback for all populated parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * In case any call fails, no further calls are made.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_populated)(const RamDiscardSource *rds,
-                            const MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
-
-    /**
-     * @replay_discarded:
-     *
-     * Call the #ReplayRamDiscardState callback for all discarded parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_discarded)(const RamDiscardSource *rds,
-                            const MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
 };
 
 /**
@@ -226,8 +190,10 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_populated:
  *
- * A wrapper to call the #RamDiscardSourceClass.replay_populated callback
- * of the #RamDiscardSource sources.
+ * Iterate the given #MemoryRegionSection at minimum granularity, calling
+ * #RamDiscardSourceClass.is_populated for each chunk, and invoke @replay_fn
+ * for each contiguous populated range. In case any call fails, no further
+ * calls are made.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
@@ -244,8 +210,10 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_discarded:
  *
- * A wrapper to call the #RamDiscardSourceClass.replay_discarded callback
- * of the #RamDiscardSource sources.
+ * Iterate the given #MemoryRegionSection at minimum granularity, calling
+ * #RamDiscardSourceClass.is_populated for each chunk, and invoke @replay_fn
+ * for each contiguous discarded range. In case any call fails, no further
+ * calls are made.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 79c7e97d9a..718c7075ce 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -32,106 +32,6 @@ ram_block_attributes_get_block_size(void)
     return qemu_real_host_page_size();
 }
 
-typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
-                                               void *arg);
-
-static int
-ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
-                                                const MemoryRegionSection *section,
-                                                void *arg,
-                                                ram_block_attributes_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size();
-    int ret = 0;
-
-    first_bit = section->offset_within_region / block_size;
-    first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                              first_bit);
-
-    while (first_bit < attr->bitmap_size) {
-        MemoryRegionSection tmp = *section;
-
-        offset = first_bit * block_size;
-        last_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
-                                      first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-
-        ret = cb(&tmp, arg);
-        if (ret) {
-            error_report("%s: Failed to notify RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            break;
-        }
-
-        first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                                  last_bit + 2);
-    }
-
-    return ret;
-}
-
-static int
-ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
-                                                const MemoryRegionSection *section,
-                                                void *arg,
-                                                ram_block_attributes_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size();
-    int ret = 0;
-
-    first_bit = section->offset_within_region / block_size;
-    first_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
-                                   first_bit);
-
-    while (first_bit < attr->bitmap_size) {
-        MemoryRegionSection tmp = *section;
-
-        offset = first_bit * block_size;
-        last_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                                 first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-
-        ret = cb(&tmp, arg);
-        if (ret) {
-            error_report("%s: Failed to notify RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            break;
-        }
-
-        first_bit = find_next_zero_bit(attr->bitmap,
-                                       attr->bitmap_size,
-                                       last_bit + 2);
-    }
-
-    return ret;
-}
-
-
-typedef struct RamBlockAttributesReplayData {
-    ReplayRamDiscardState fn;
-    void *opaque;
-} RamBlockAttributesReplayData;
-
-static int ram_block_attributes_rds_replay_cb(MemoryRegionSection *section,
-                                              void *arg)
-{
-    RamBlockAttributesReplayData *data = arg;
-
-    return data->fn(section, data->opaque);
-}
-
 /* RamDiscardSource interface implementation */
 static uint64_t
 ram_block_attributes_rds_get_min_granularity(const RamDiscardSource *rds,
@@ -159,34 +59,6 @@ ram_block_attributes_rds_is_populated(const RamDiscardSource *rds,
     return first_discarded_bit > last_bit;
 }
 
-static int
-ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
-                                          const MemoryRegionSection *section,
-                                          ReplayRamDiscardState replay_fn,
-                                          void *opaque)
-{
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
-    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
-
-    g_assert(section->mr == attr->ram_block->mr);
-    return ram_block_attributes_for_each_populated_section(attr, section, &data,
-        ram_block_attributes_rds_replay_cb);
-}
-
-static int
-ram_block_attributes_rds_replay_discarded(const RamDiscardSource *rds,
-                                          const MemoryRegionSection *section,
-                                          ReplayRamDiscardState replay_fn,
-                                          void *opaque)
-{
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
-    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
-
-    g_assert(section->mr == attr->ram_block->mr);
-    return ram_block_attributes_for_each_discarded_section(attr, section, &data,
-        ram_block_attributes_rds_replay_cb);
-}
-
 static bool
 ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
                                     uint64_t size)
@@ -346,6 +218,4 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
 
     rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
     rdsc->is_populated = ram_block_attributes_rds_is_populated;
-    rdsc->replay_populated = ram_block_attributes_rds_replay_populated;
-    rdsc->replay_discarded = ram_block_attributes_rds_replay_discarded;
 }
-- 
2.54.0


