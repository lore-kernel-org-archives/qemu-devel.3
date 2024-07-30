Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38958C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLR-00044e-RB; Tue, 30 Jul 2024 05:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLQ-0003y0-6Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLO-0000eC-G1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3684bea9728so2289809f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332433; x=1722937233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jfxWTbmPHfPItv3Jo669wf0TJh+oQpU/CHJm1l2IvZY=;
 b=f3x38ekkwj/oKWFcFQEGzkUITXRcmlvJWTMZTO+sBE7c4qAZrvww9P86Np+PexAy7G
 /DivMIrFh9p/u4q+oXZYEVQ3dVX3Ajb/4bNz+ZNyd7uOZ1qr3Gv0obvHiLyzaQTZFCUJ
 KhtbWluwB3WeCp0k4/G7fc3H4umMuTTiWo83xN4k+RDcmGETZjIFYS3/+k9CLAUBf3PM
 uUsjPC6D3ktEMspJfYGvVAzL3XJD8SMo/U014sVylh9ngOpY6LYWauvVFYwLHljMDh8A
 YbCNXAW7PDuJnNrT7QOYO3XFusDWYFKrbCNBgeBDDy8Md8+po0VmDWttLAGJA6N9Lkkz
 +dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332433; x=1722937233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfxWTbmPHfPItv3Jo669wf0TJh+oQpU/CHJm1l2IvZY=;
 b=vbaD8wANyuFgSwXKHw9eEjdy49PxqbB52Xh+dZPpxmdJf88RDJrUJTah+GvsmaBYvq
 Au55G1OPt+Voe9U+1bQr587iyRnDrJWgFhcmSoZfT7j1HkbR7Wm6J/iF6nCKubmIeYpt
 LnBPcjLT5Ga+cxADnyJcwUwAhNgjWcXjxtRP7JP5e7OxplHlM0UDcfcL/Y/022hJ279a
 u0+WY67X4tnZAOk2LGhlDxeih+pCTfGMToJeOyU5l/zMHmPR/kgX8WE+2FX20sgyDYaA
 Npj6CyDnauHl6s6k7SpyKyu2Peb4WUXZDh352Yc7ZxblVGx9RPOLDsenP4vUpRr1szZ8
 QRTg==
X-Gm-Message-State: AOJu0YxK3/6PH0e6FUqiQ4FuDOAmRAuUlEV70IzPDz6I3LccLLBSvOVs
 qg2ViJBVBdUThyPV+TPP1aQ6akCggz4XuuoFldINx/eC3/E388re0G+mTJFgbQZfC54H5k0ZK/P
 B
X-Google-Smtp-Source: AGHT+IHai7uLDlxDLkqZbV6e4fqlgoceBTG5yuftQG2j57yPVODDrFyNIbziHbuoXhhUwDCkFC8Cag==
X-Received: by 2002:a05:6000:1546:b0:368:420e:b790 with SMTP id
 ffacd0b85a97d-36b5cef8f76mr8545304f8f.14.1722332433088; 
 Tue, 30 Jul 2024 02:40:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] system/physmem: Where we assume we have a RAM MR,
 assert it
Date: Tue, 30 Jul 2024 10:40:20 +0100
Message-Id: <20240730094020.2758637-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the functions invalidate_and_set_dirty() and
cpu_physical_memory_snapshot_and_clear_dirty(), we assume that we
are dealing with RAM memory regions. In this case we know that
memory_region_get_ram_addr() will succeed. Assert this before we
use the returned ram_addr_t in arithmetic.

This makes Coverity happier about these functions: it otherwise
complains that we might have an arithmetic overflow that stems
from the possible -1 return from memory_region_get_ram_addr().

Resolves: Coverity CID 1547629, 1547715

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-id: 20240723170513.1676453-1-peter.maydell@linaro.org
---
 system/physmem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 0e19186e1b4..94600a33ec3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -923,13 +923,19 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
 {
     DirtyMemoryBlocks *blocks;
-    ram_addr_t start = memory_region_get_ram_addr(mr) + offset;
+    ram_addr_t start, first, last;
     unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
-    ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
-    ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
     DirtyBitmapSnapshot *snap;
     unsigned long page, end, dest;
 
+    start = memory_region_get_ram_addr(mr);
+    /* We know we're only called for RAM MemoryRegions */
+    assert(start != RAM_ADDR_INVALID);
+    start += offset;
+
+    first = QEMU_ALIGN_DOWN(start, align);
+    last  = QEMU_ALIGN_UP(start + length, align);
+
     snap = g_malloc0(sizeof(*snap) +
                      ((last - first) >> (TARGET_PAGE_BITS + 3)));
     snap->start = first;
@@ -2659,7 +2665,11 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
                                      hwaddr length)
 {
     uint8_t dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-    addr += memory_region_get_ram_addr(mr);
+    ram_addr_t ramaddr = memory_region_get_ram_addr(mr);
+
+    /* We know we're only called for RAM MemoryRegions */
+    assert(ramaddr != RAM_ADDR_INVALID);
+    addr += ramaddr;
 
     /* No early return if dirty_log_mask is or becomes 0, because
      * cpu_physical_memory_set_dirty_range will still call
-- 
2.34.1


