Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E07C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mpx-0008BF-Sd; Thu, 10 Sep 2026 18:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lPY-0004Iw-Fr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lOM-0001O2-Uj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tjmu0XflcFt7hcajhQyvOAGpQgP0KwuZU8Bcnz844UE=;
 b=UgJAiZ/DHXIpLsUfbyKG14gbhCkmphl7LX2tj2YZF6SLw3mvh5nR17G3OcZ/59/lihZ8Zp
 J2AJWp/U7wJiCi7/ipOn65YIbICcMNESt4EvRgQ3LTTnEo8K4kN5hxt2Jt2pVRD6f345cJ
 K4gtFAMRX9wt9s9kwj8uBwrjZnLMtNY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-9mIMbsP9O724rS8rkqbAvw-1; Thu, 10 Sep 2026 16:13:46 -0400
X-MC-Unique: 9mIMbsP9O724rS8rkqbAvw-1
X-Mimecast-MFC-AGG-ID: 9mIMbsP9O724rS8rkqbAvw_1789071226
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so1327625e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071226; x=1789676026; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tjmu0XflcFt7hcajhQyvOAGpQgP0KwuZU8Bcnz844UE=;
 b=q7hVCZU8PGcPQHvcXCHcf790XZVk34oIJ8ReYOVNeiCJQ6cJx0jadFVvC0jFcNP180
 iDB0KbEjs4dVzahUTIu4zpJp9xoSK/4m9gFxlUqVGtSWLtux4MgkByZBSD9m4qN4HYx/
 +VDelXs2ftkkxHYR1vcUj1Xb2XJ4bBfBTdGd0YYazuO/7jXnnPqms4R80lIt2SfRt0El
 lBQpVPTV6WaWEkXCjvs39e/1xs+tf0Y6r1HBtkrZxWTEZbmaqDpbhbdAmaltnRBUvQQC
 HHqZTbviiRDhTpwsVUgknyrJpSnBUTEBiukbrWNj95V6tJhSm/PBOyzb0LwqwhkoM8aQ
 6IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071226; x=1789676026;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjmu0XflcFt7hcajhQyvOAGpQgP0KwuZU8Bcnz844UE=;
 b=fX/UOHHoCbPDdWn39pboLqnG1NLcXo0KfPwKYDEiZkFxh/OBUPNKszTh8ygzT8mmtc
 ta1Mv54UnHDfxfA73bVrlmeSUwu+ceaje3fWHwHWbPGdqkpoXRjqDEag4b8YtfHDuOCF
 8+PJ850DywwXYwaBqbAitJqj3mmwb3ziw1F3ydoCsfE31v2w2uZAm1FaSNaVhy8Kwqfd
 N1C46YQGHbzSQCRRfUf6Y/VKn2ZIXLhl4YgaLQnMUTvsgqaM/TvULkt8WgQIPWF2fBh6
 unRQ7dtpUtXHVOHd2nvmoXNG34n193fIVBy05TPUmX3uLINeZ9ZOM4acK2Hb3TvR7ABT
 KZAw==
X-Gm-Message-State: AFuF++lUcw+dy/u2uZfHNIvYgVAKbZKlffT6TYoNRtLa6yv44sJWyLzf
 7z/3E3SbMXZ2qHiU4F+Oj3T3emrslyZnAMI4M4MB7QhlDitYfUScgXqGWX6VnXa44iliaAZJkD6
 Le6cCUkW1Kn5c6Rru4XWV7IyRQOwfnF3n7brr0yGSd01uOyYnCul+ZaRVc+xMHPCF80LKswRHbp
 EA8YWZUXobB2Uzkr1hAiC1C0solR2wvRrXHQ==
X-Gm-Gg: AYBFou10L621VqnuhRLiilMSQpde7K/eUF09vRESv0sTVhuH19rTm6eb5jKR2FxhbCM
 X1TwQOskwIzA3HMBY4rlrdiV8kW9JIJz4xfL88cPHXyuZCx4B5xtChnpbZdXcEYQ8E0qeP/Jkjn
 T5GznxX4WYCG4fG9cFXRdSQRL3k8x4uDVMpCDsW3lNH5F/UcC93OnKbJCnL0ODP02RdGqiitP9p
 quO9atqigHI0TuseF9t0xH09dn5S8tsAultb8Pqr55rxjFbXm89V5Xr13z7TRtIqxOfCQhK+T1j
 QS/Q1PHIVyk7E0xRf6aAey3g1za89jnP/EHRTPRri+7paCCcLrDtiLYOWOIye+PaDJNF8yE+k+2
 av1aDbrsnBQZhJahGZdag/Kw=
X-Received: by 2002:a05:600d:8646:20b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49e619c079cmr5547025e9.19.1789071225624; 
 Thu, 10 Sep 2026 13:13:45 -0700 (PDT)
X-Received: by 2002:a05:600d:8646:20b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49e619c079cmr5546615e9.19.1789071225070; 
 Thu, 10 Sep 2026 13:13:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adb075sm18503535e9.13.2026.09.10.13.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:43 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Jia <physicalmtea@gmail.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 54/90] hw/virtio: reject inverted virtio-iommu IOVA ranges
Message-ID: <60e4e1fb90c6af67c019b1485b50272dd41b57a5.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jia Jia <physicalmtea@gmail.com>

Guest MAP and UNMAP requests can set virt_end below virt_start. Since
virt_end is inclusive, this is not a valid interval. MAP nevertheless
stores it in domain->mappings, but interval_cmp() assumes low <= high.
For an inverted key, interval_cmp(key, key) returns -1. A covering UNMAP
can therefore find the key but fail to remove it and repeat forever while
holding s->mutex.

Reject inverted request ranges with VIRTIO_IOMMU_S_INVAL and make the
notifier range decomposition skip invalid ranges. Keep the existing
notifier-before-remove ordering, but return VIRTIO_IOMMU_S_DEVERR if
g_tree_remove() fails.

Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729131953.1720567-1-physicalmtea@gmail.com>
---
 hw/virtio/virtio-iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 533bd5073f..208815096f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -212,6 +212,10 @@ static void virtio_iommu_notify_map_unmap(IOMMUMemoryRegion *mr,
 {
     uint64_t delta = virt_end - virt_start;
 
+    if (virt_end < virt_start) {
+        return;
+    }
+
     event->entry.iova = virt_start;
     event->entry.addr_mask = delta;
 
@@ -807,6 +811,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -857,6 +865,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -879,7 +891,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
                 virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
                                           current_high);
             }
-            g_tree_remove(domain->mappings, iter_key);
+            if (!g_tree_remove(domain->mappings, iter_key)) {
+                ret = VIRTIO_IOMMU_S_DEVERR;
+                break;
+            }
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
             ret = VIRTIO_IOMMU_S_RANGE;
-- 
MST


