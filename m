Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72455C25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgg-0000nP-1Y; Tue, 30 Apr 2024 03:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgd-0000lG-M6
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgc-0008LY-3i
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wpR3AXJttXwbHCvcOqHlANvlGK7uXtvOfZt+lhMwT8=;
 b=LETQHyyuHKJrk2yI1EFsj4MyXEAkYe353tEKuIDowVyHtQ7PXGkpRRUBW9Tp5YeBK0NhVA
 PTzKm9Wxffm85ciiePp5QTdOQw4xm1/WqfDLlYDXYtu0hKcQQJBKNCIsuY8SVZp3WD89LR
 QPQrKQ1yl9racdswwjo+Z3uLsEEEM00=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-zEi2Zs13MuOYGNVpuLK_RA-1; Tue,
 30 Apr 2024 03:13:55 -0400
X-MC-Unique: zEi2Zs13MuOYGNVpuLK_RA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26EF329AB425;
 Tue, 30 Apr 2024 07:13:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B003F40C140B;
 Tue, 30 Apr 2024 07:13:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Chris Friedt <chrisfriedt@gmail.com>,
	Chris Friedt <cfriedt@meta.com>
Subject: [PULL 07/19] hw: misc: edu: fix 2 off-by-one errors
Date: Tue, 30 Apr 2024 09:13:28 +0200
Message-ID: <20240430071340.413305-8-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chris Friedt <chrisfriedt@gmail.com>

In the case that size1 was zero, because of the explicit
'end1 > addr' check, the range check would fail and the error
message would read as shown below. The correct comparison
is 'end1 >= addr'.

EDU: DMA range 0x40000-0x3ffff out of bounds (0x40000-0x40fff)!

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1254
Signed-off-by: Chris Friedt <cfriedt@meta.com>
[thuth: Adjust patch with regards to the "end1 <= end2" check]
Message-ID: <20221018122551.94567-1-cfriedt@meta.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/edu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 2a976ca2b1..14250e0ac3 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -103,19 +103,18 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static bool within(uint64_t addr, uint64_t start, uint64_t end)
-{
-    return start <= addr && addr < end;
-}
-
-static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
-                uint64_t size2)
+static void edu_check_range(uint64_t addr, uint64_t size1,
+                uint64_t start, uint64_t size2)
 {
     uint64_t end1 = addr + size1;
     uint64_t end2 = start + size2;
 
-    if (within(addr, start, end2) &&
-            end1 > addr && end1 <= end2) {
+    /*
+     * 1. ensure we aren't overflowing
+     * 2. ensure that [addr, end1) is within [start, size2)
+     */
+    if (end2 >= start && end1 >= addr &&
+        addr >= start && end1 <= end2) {
         return;
     }
 
-- 
2.44.0


