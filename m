Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6D0F9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrLL-0001x1-1T; Thu, 23 Apr 2026 06:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKs-00017L-Ke
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKn-00069Q-RA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4XmyksHBVIs3iLa2by4RHAdXjQPeU40gX9yVyb+E/Q=;
 b=PQpmXOC4nm5JZ/M2l9V+L8+sAMKycN028WXZA0XBkaLSVmCuUhdQaR7SODlJCpr42xwRAo
 HYHUSgxCfqzuiLcTGJzzVzXcHaFDVRRmpXYrBa7pMwslwWPMixiRlNiz1AbGTRrSUoHSqC
 uoHd7k80QUnc89GElmJ37T/3r0F6ejQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-liG5WVPDPNqDH3rKyJG6qg-1; Thu, 23 Apr 2026 06:31:00 -0400
X-MC-Unique: liG5WVPDPNqDH3rKyJG6qg-1
X-Mimecast-MFC-AGG-ID: liG5WVPDPNqDH3rKyJG6qg_1776940259
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d8deb75fso53070565e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940258; x=1777545058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4XmyksHBVIs3iLa2by4RHAdXjQPeU40gX9yVyb+E/Q=;
 b=LmUCWITuOFvlOSAZWC3MkUmn1LVqcNpeXHxAQkz3+d+/K70m1d/nOKz1Bkz60/YoNk
 BiyuzSiUj4k4bSVm6EhmmTyxiJc7Vix3e4QetglCvJWiAxMitlDmQGm6G9O0fPcVvpMQ
 LO3fwR18/nSTHIl+wjglCLM35kGysvAZPAsOK2nnD11qeaLDCYw+tX5HK45UoI+6J2co
 VO+GBOKCcTamqOe58VcFwN9FCQbTKnes8qqwhHJPMArci3msXvQ7jOfj/14DDXUw5FwK
 AlCOf5ViNVp5eNJNIRRxMaT4l7CCYEKJDCkh+/pnVzP4ZXotacQH5uIlDIyiGaapLpXQ
 2cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940258; x=1777545058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W4XmyksHBVIs3iLa2by4RHAdXjQPeU40gX9yVyb+E/Q=;
 b=d4OTzVpfeOhSpNNXbcuUdc2FQ9YVFI/zV9ZyQg0JBLRpSLHIjc4bYed5oNnAlyee8u
 MghV+mmWeDzwDIPQPjfXMTsHgxviOWr7oE2MafrOCFXJax86VBGTRTD6T/db8Dz3U6HQ
 ybnygpxM94bw05At/7OuyFmqk9wkdWAx1JSmJSR4JJ+xrtYeG1UCWiRsnIjTpV8l+W67
 PnRwvJEz8L0yi4fWU51C9ztYcIVPAhZkvxdMu145JicaPXOm6y9eY3RYNfHnRBXUR6xh
 nj5n5Mm7uGCh8xspjrsRK/SUuiwI5dS2DObRtzygVkxa83vyOj+MjT54u1nYJj9cgWZX
 gnag==
X-Gm-Message-State: AOJu0YwcyiqKTMjDDHau/yb6I288io+MhYwlMkuI5NQ3RDwpHQEK8twD
 PhRoLT3/rzqvNncXsuFTAJUfp1nrP6YCdPu1CgVgvuCxtGMPKmpsxBFns/rv3tvwgGliWUJr3s5
 hXyBvZLi3zY+5CeYby4d9T1sydhuwgguMpAm3hzFnHSrrgTXaooE/YA2F8tqKgW7qHmo8TFqR8q
 0nbko5jVWkfNruwBpj5QTW5fcGkpVSsNXiaGZnv5Ra
X-Gm-Gg: AeBDieveDdjbujD5ymQ+RaXzew6ZtYLjg6mxWLvB1mojmidS33W/YDiNEHrraKpm9Ov
 ucgXgCzYWz5w8M6goZY87wu3FUwy2ud9zpNDX8P5nZNdX1liJ2rt31M9CjaPtuXZ/DOd1aDwbl8
 tshgx2erTuZ/Uw9foq6M+DROnzeDKQZCttV4DsjmYw7aXJMWbMNc/QTcZOAgli5B0WhFtUF6Cs2
 GK2w9gfP/agI9FWKEeVqd/Fqdv1ZSub0OZFA5gqzLllwe6WI4GzQMKNz94NggshJxeOf1noZa9w
 LfxDQfcPba8bO260K5FgxJJ2dxcddQhdizO9wPzt8p2fNKk6fTEL9taEmQ5k5YXuGJdhZUxWK8T
 72hgVGzq2HVgZV5ayF5GY/2tlGfqPsnVmfgSufhEhsXMUSi92bwHvvK7wN2sYySg9UkRsbFwsl1
 OLRmeZC0+3+angPdbEagbmmqWrO1e79BGCG4s=
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr345342055e9.10.1776940258242; 
 Thu, 23 Apr 2026 03:30:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr345341595e9.10.1776940257727; 
 Thu, 23 Apr 2026 03:30:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm301552685e9.9.2026.04.23.03.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 24/25] memory: Optimize flatview_simplify() to eliminate
 redundant memmove calls
Date: Thu, 23 Apr 2026 12:29:21 +0200
Message-ID: <20260423102922.443639-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

The original flatview_simplify() implementation uses memmove() to shift
array elements after each merge operation, resulting in O(n²) time
complexity in the worst case. This is inefficient for VMs with large
memory topologies containing hundreds of MemoryRegions.

Replace the memmove-based approach with a two-pointer in-place compression
algorithm that achieves O(n) time complexity. The new algorithm uses a
write pointer i and a read pointer j, where i ≤ j is always maintained.
This invariant ensures we never overwrite unprocessed data, making memmove
unnecessary.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Link: https://lore.kernel.org/r/20260331060731.82641-1-guobin@linux.alibaba.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/memory.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 56f3225b21a..0ff066c3484 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -336,24 +336,25 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
 /* Attempt to simplify a view by merging adjacent ranges */
 static void flatview_simplify(FlatView *view)
 {
-    unsigned i, j, k;
+    unsigned i, j;
+
+    if (view->nr <= 1) {
+        return;
+    }
 
     i = 0;
-    while (i < view->nr) {
-        j = i + 1;
-        while (j < view->nr
-               && can_merge(&view->ranges[j-1], &view->ranges[j])) {
+    for (j = 1; j < view->nr; j++) {
+        if (can_merge(&view->ranges[i], &view->ranges[j])) {
             int128_addto(&view->ranges[i].addr.size, view->ranges[j].addr.size);
-            ++j;
+            memory_region_unref(view->ranges[j].mr);
+        } else {
+            i++;
+            if (i != j) {
+                view->ranges[i] = view->ranges[j];
+            }
         }
-        ++i;
-        for (k = i; k < j; k++) {
-            memory_region_unref(view->ranges[k].mr);
-        }
-        memmove(&view->ranges[i], &view->ranges[j],
-                (view->nr - j) * sizeof(view->ranges[j]));
-        view->nr -= j - i;
     }
+    view->nr = i + 1;
 }
 
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
-- 
2.53.0


