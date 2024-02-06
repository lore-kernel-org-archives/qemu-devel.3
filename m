Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B790C4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFfA-0006rS-IJ; Tue, 06 Feb 2024 02:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFf5-0006po-8i
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFf3-0005ME-NB
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707203669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYQLNt3ySIw2/ay8d3vGJbaWL+4EsM3JD4ciODknu9Y=;
 b=igsxquNeh0CBKI594CDfpRT6EY0QfX6HHUPWYKii50/mdUv4moVT1Nzh/6yCt5DfLkOMek
 FTSEywiovoViDC0FIWf5V0zHaOJEC4wIp+HmOEko1ZcBzg/Au8d97otBBqArnFYGQZBuDG
 yGLidUGFPwo+QLy+NAfPyK56LlnbQLw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-jQpLU0OQPuWwnOkKDzyBmg-1; Tue,
 06 Feb 2024 02:14:26 -0500
X-MC-Unique: jQpLU0OQPuWwnOkKDzyBmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DE7328EC104;
 Tue,  6 Feb 2024 07:14:26 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 003C1400D6D2;
 Tue,  6 Feb 2024 07:14:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL v2 1/3] hv-balloon: use get_min_alignment() to express 32 GiB
 alignment
Date: Tue,  6 Feb 2024 08:14:20 +0100
Message-ID: <20240206071422.18658-2-david@redhat.com>
In-Reply-To: <20240206071422.18658-1-david@redhat.com>
References: <20240206071422.18658-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's implement the get_min_alignment() callback for memory devices, and
copy for the device memory region the alignment of the host memory
region. This mimics what virtio-mem does, and allows for re-introducing
proper alignment checks for the memory region size (where we don't care
about additional device requirements) in memory device core.

Message-ID: <20240117135554.787344-2-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/hyperv/hv-balloon.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 0238365712..ade283335a 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1477,22 +1477,7 @@ static void hv_balloon_ensure_mr(HvBalloon *balloon)
     balloon->mr = g_new0(MemoryRegion, 1);
     memory_region_init(balloon->mr, OBJECT(balloon), TYPE_HV_BALLOON,
                        memory_region_size(hostmem_mr));
-
-    /*
-     * The VM can indicate an alignment up to 32 GiB. Memory device core can
-     * usually only handle/guarantee 1 GiB alignment. The user will have to
-     * specify a larger maxmem eventually.
-     *
-     * The memory device core will warn the user in case maxmem might have to be
-     * increased and will fail plugging the device if there is not sufficient
-     * space after alignment.
-     *
-     * TODO: we could do the alignment ourselves in a slightly bigger region.
-     * But this feels better, although the warning might be annoying. Maybe
-     * we can optimize that in the future (e.g., with such a device on the
-     * cmdline place/size the device memory region differently.
-     */
-    balloon->mr->align = MAX(32 * GiB, memory_region_get_alignment(hostmem_mr));
+    balloon->mr->align = memory_region_get_alignment(hostmem_mr);
 }
 
 static void hv_balloon_free_mr(HvBalloon *balloon)
@@ -1654,6 +1639,25 @@ static MemoryRegion *hv_balloon_md_get_memory_region(MemoryDeviceState *md,
     return balloon->mr;
 }
 
+static uint64_t hv_balloon_md_get_min_alignment(const MemoryDeviceState *md)
+{
+    /*
+     * The VM can indicate an alignment up to 32 GiB. Memory device core can
+     * usually only handle/guarantee 1 GiB alignment. The user will have to
+     * specify a larger maxmem eventually.
+     *
+     * The memory device core will warn the user in case maxmem might have to be
+     * increased and will fail plugging the device if there is not sufficient
+     * space after alignment.
+     *
+     * TODO: we could do the alignment ourselves in a slightly bigger region.
+     * But this feels better, although the warning might be annoying. Maybe
+     * we can optimize that in the future (e.g., with such a device on the
+     * cmdline place/size the device memory region differently.
+     */
+    return 32 * GiB;
+}
+
 static void hv_balloon_md_fill_device_info(const MemoryDeviceState *md,
                                            MemoryDeviceInfo *info)
 {
@@ -1766,5 +1770,6 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
     mdc->get_memory_region = hv_balloon_md_get_memory_region;
     mdc->decide_memslots = hv_balloon_decide_memslots;
     mdc->get_memslots = hv_balloon_get_memslots;
+    mdc->get_min_alignment = hv_balloon_md_get_min_alignment;
     mdc->fill_device_info = hv_balloon_md_fill_device_info;
 }
-- 
2.43.0


