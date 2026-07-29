Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FCC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp4Cj-0006UU-9w; Wed, 29 Jul 2026 09:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wp4Ch-0006OK-3P
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 09:20:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wp4Cf-0007XV-Dr
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 09:20:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so12595715ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785331208; x=1785936008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2i4FVUdURzBTHya5KzGWkQXNJtC7zm0R1TEYIrC8ZM=;
 b=JdHcFd94W3ry9VzWzwGCfSXycVC9kVwDZGZQA+rssOpxUG4y9KflNj+TFep61SOY0N
 9kURQoYs9RFmdHr2GHyGN0Jl5lltOHKies9DxO76BE3at3nRm3OJTqrqLHXTuDJp8z5/
 3Wf4G+lEv0hLmUUCeYGc4xXdIn6Q93xRBAHrXiv6t1Uq1Lx1j6PmtJFqyP4nX79Yfymy
 BHWX2TnxCAZ4fTSOFg+w7f2odbrvnZdG4SWslUt+8jDbu8FK3tClEeAZnYkU9hEh/szt
 S8ZwcTq18huqMiD89G88M7FPogAijKxUYA6CEt2N8wPZK2u/Hb1uExSl36eoBtHTDG/C
 fCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785331208; x=1785936008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w2i4FVUdURzBTHya5KzGWkQXNJtC7zm0R1TEYIrC8ZM=;
 b=OrzgKJShdujGfEbe24Jg2mtNNGUErbE3EoMGJrliTPDNP60eyUyI2Nwr+YYP0FOaJ0
 WtvpuH8uUTvvF1ywziPlpQgDlREOjw7FYAJSyosaikVR3zNgeM69VwEF1FqzQpobB1Io
 mQV7ntGwcX4eVPTgHrYN1y4A6OH5LAMn2mUotjcB59BKjOrI8Wj6YHsEylkiMRICamfj
 hkffowq8SJLNrIkU/ECp/zRHshLexKRDl+1D6DtXrhCbYmuQLFhqgw7zb0YHZWmFYdmg
 rLHtXvZdqnzQpo0RCdOao1E4XHStW5QXbC1bzkZfdNLqHkw/83I1QOFQRltXVRIeQb7I
 URMg==
X-Gm-Message-State: AOJu0Yz1Evimq98Ro/HgQWOw+aIJ/rCSK9IqKj6w/5MJOw6QBSlUv4CQ
 2qv6a5FA1g8gRMG4WRnVF8L+Hr0wn7JqA/BlPL+VbokgGf5ruy+3xiLMmRFJM0sJsAc=
X-Gm-Gg: AR+sD12PkFEqwdb8XPxLpwlmZeHk4r+wfp9XRhTU4fB0px55TsZWPijaAVei4euIXZj
 kfO++4D7g/DQsIE7kLnSfsaQFS10weYjaDtqYFGXXNC7mJRl2K/wLDdaals/Hz3B3Gw6bAGEJAp
 IlLVRF+kIn+wM/EBTvtKh8BWFt/gValsB/cCS/4C0AKtXVDJ1wOWzBYk3TfynGZHzEKQ38WVqSe
 EmJ91/6QvSi79PEq2+uSHAYVF3BBZONYRr4qu5cUpNdotHKvep0M+uXLKYWTI2/vcdf16FxmliT
 NGXlfU/qRkPZATwDrrJ/cK6ial7rWLPpSU3/kuesAeAqKGsMFstNz6OUfLs2otIsGuB1/iCYB4T
 aMoV7H9hjxtTH9Ka8WC3VYB6LaMAysnr54RRrYE7qInVsqIyba1RFrgzCeaucWuyT/M65kbXXlY
 0Him+L4RHB7B3+/fLCNZKBXLI2UnReYRsNRQt27Jo6GsPHrU53mq2Bv9OyOcVOMUk=
X-Received: by 2002:a17:903:390d:b0:2c9:ff83:41fa with SMTP id
 d9443c01a7336-2d015ee24d7mr73753635ad.24.1785331207515; 
 Wed, 29 Jul 2026 06:20:07 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022c50f43sm11184995ad.83.2026.07.29.06.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 06:20:06 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	eric.auger@redhat.com
Subject: [PATCH v3] hw/virtio: reject inverted virtio-iommu IOVA ranges
Date: Wed, 29 Jul 2026 21:19:53 +0800
Message-Id: <20260729131953.1720567-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729074021-mutt-send-email-mst@kernel.org>
References: <20260729074021-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
v3:
- Keep delta initialization at the top

 hw/virtio/virtio-iommu.c | 17 +++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 533bd5073f..b7145c8277 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -210,7 +210,11 @@ static void virtio_iommu_notify_map_unmap(IOMMUMemoryRegion *mr,
                                           IOMMUTLBEvent *event,
                                           hwaddr virt_start, hwaddr virt_end)
 {
     uint64_t delta = virt_end - virt_start;
 
+    if (virt_end < virt_start) {
+        return;
+    }
+
     event->entry.iova = virt_start;
     event->entry.addr_mask = delta;
@@ -807,6 +812,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -857,6 +866,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -879,7 +892,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
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
2.34.1


