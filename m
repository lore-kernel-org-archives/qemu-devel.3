Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1835C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmdHX-0002iI-3M; Wed, 22 Jul 2026 16:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wmdHS-0002h4-Qm
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 16:11:02 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wmdHQ-0002W1-V8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 16:11:02 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81ef8255cccso49964527b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784751058; x=1785355858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOILP0Pnl+nB+lm+CUiKOOV4KZnWh2wtQlwbvvyjiNg=;
 b=Jrdcd5FMFeXfWs6wPU5Ew9zc6xugtMBfJYI3Mao+0Q57xhGKlHgZIUmc9X200SYMCW
 efyUdxSvfHZCVgIuDI3XGoSlvuW9EPFPsbf20psFcQ2tZbINU7/djRV861he5o4uPJRS
 wQXLlbr47cbUbPcPcxvkN6IpuPcxAoOr23H5t4fVIP4QjAN4m4GL2aVNd1S2OGz7DtU2
 hcZZPUhTgQJLFIURBZHbDPaVYRMHtvPVe5lt6D5CE832bW+K5Ir3PmX0e4xtvy6SQMzF
 DfDsUTeledvYwacGtnWEdr7tzzUquK7vXjD1Q1PhILqEXyUdgB2y2m1LIJtQ8kbDm9EU
 R37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784751058; x=1785355858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOILP0Pnl+nB+lm+CUiKOOV4KZnWh2wtQlwbvvyjiNg=;
 b=CondJtPFBSgXnfBls6a2oALLzbYuriM3mU/Lz70wSeVQIpO5pN+9wfOx8n+PtcVNfN
 5fp2Viery4UB5iJNupZdifrhfSh3MgnZRj5VNVxeTTYNjBiJWemymnCTRguyKoHgFqVm
 tU+mQJx8TSwNgYAqsqMZGvRiMjGDlTeuqvZy1jJEKyjoxdpO8Yfxyr4MtleO2nqFELaf
 0rLMYeCSFU9JzGP9Va77qMR8VgmD+CXzRS1Jdj3wTGnmi6pfI/wECpKPSHoABOTS4U0A
 jkprRtl9vROJl3WBeA49A9WP9tDr1oDI3+1HLfdkdPYHGf0carPgsQ1Uqw5yg7nL9pD4
 h0iw==
X-Gm-Message-State: AOJu0YxGclVvToAFKC1SGDITLMBt6XNqr7YtK7pDtcySl29449CPn0V6
 FwPi+E/CPnd83N66Iqv5w1itHtIoHPCKw5ZEIqIcIweuS4g0mzJChkh4oTVranjd
X-Gm-Gg: AR+sD129sTCBzt5mU0w+xveUJlNPYmVE9wsZcuekoiUGTDj42BYze3RDi3cmtlqdBvh
 9lSe5rhCdBw4JnxebGsokDb6CbbXkkoQ7p+yo04+4+EGMb76bkvwzwXbblKoJ+FQyIN7XWI2JKy
 rSk4axvwiPED8P8MF1jl3xh0+AD2mGq9W+KmxVjv5iMRaPxMkxHwdsJ8Ecq+To3EetuCAQyqI82
 6uXEGxvTCVV+BYcLumoUAyk6biLdSkk3mrcAUDipCp+kEGxanqq5opWZS+l2gGmoCsTsgUsqbDv
 Tbr1mbALe/ZzbG6tm9Mz+KkV4EIQKmYUCe36i57wN2hulIcnegdYuiCi6lHzCKRwU0QURM1K0i6
 JTEPpEEsaREDD4YV9JIv5ChNct9w+VijNsEvzS/0tAX2A+q7fc+5BFcl1l5VzeDa71NJp9d21AP
 T97TdHRYr2BnVnmn0n3A==
X-Received: by 2002:a05:690c:6712:b0:80c:8596:4653 with SMTP id
 00721157ae682-81f4c3b4eadmr198207b3.69.1784751057969; 
 Wed, 22 Jul 2026 13:10:57 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:eb7d:6ac0:a76f:2c5f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f40366af6sm10389407b3.43.2026.07.22.13.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:10:57 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, Connor Kite <connorkite@gmail.com>
Subject: [PATCH] util/iova-tree: gapless map
Date: Wed, 22 Jul 2026 13:07:05 -0700
Message-ID: <20260722200951.553764-2-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112a.google.com
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

iova-tree prevents mapping of overlapping ranges, but range checks
inflate the effective size of regions by 1 byte, resulting in gaps
between regions in the iova address space.  If there are alignment
requirements for regions in the iova space, this can throw them off.

Adjust range checks to allow adjacent regions with no gap between them.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 util/iova-tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/util/iova-tree.c b/util/iova-tree.c
index 5b0c95ff15..834ffab324 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -59,11 +59,11 @@ static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
 {
     const DMAMap *m1 = a, *m2 = b;
 
-    if (m1->iova > m2->iova + m2->size) {
+    if (m1->iova >= m2->iova + m2->size) {
         return 1;
     }
 
-    if (m1->iova + m1->size < m2->iova) {
+    if (m1->iova + m1->size <= m2->iova) {
         return -1;
     }
 
@@ -96,8 +96,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
     g_assert(key == value);
 
     needle = args->needle;
-    if (map->translated_addr + map->size < needle->translated_addr ||
-        needle->translated_addr + needle->size < map->translated_addr) {
+    if (map->translated_addr + map->size <= needle->translated_addr ||
+        needle->translated_addr + needle->size <= map->translated_addr) {
         return false;
     }
 
@@ -125,7 +125,7 @@ int iova_tree_insert(IOVATree *tree, const DMAMap *map)
 {
     DMAMap *new;
 
-    if (map->iova + map->size < map->iova || map->perm == IOMMU_NONE) {
+    if (map->iova + map->size <= map->iova || map->perm == IOMMU_NONE) {
         return IOVA_ERR_INVALID;
     }
 
@@ -174,14 +174,14 @@ static void iova_tree_alloc_map_in_hole(struct IOVATreeAllocArgs *args)
     const DMAMap *prev = args->prev, *this = args->this;
     uint64_t hole_start, hole_last;
 
-    if (this && this->iova + this->size < args->iova_begin) {
+    if (this && this->iova + this->size <= args->iova_begin) {
         return;
     }
 
-    hole_start = MAX(prev ? prev->iova + prev->size + 1 : 0, args->iova_begin);
-    hole_last = this ? this->iova : HWADDR_MAX;
+    hole_start = MAX(prev ? prev->iova + prev->size : 0, args->iova_begin);
+    hole_last = this ? this->iova - 1 : HWADDR_MAX;
 
-    if (hole_last - hole_start > args->new_size) {
+    if (hole_last - hole_start + 1 > args->new_size) {
         args->iova_result = hole_start;
         args->iova_found = true;
     }
@@ -244,7 +244,7 @@ int iova_tree_alloc_map(IOVATree *tree, DMAMap *map, hwaddr iova_begin,
         iova_tree_alloc_map_in_hole(&args);
     }
 
-    if (!args.iova_found || args.iova_result + map->size > iova_last) {
+    if (!args.iova_found || args.iova_result + map->size - 1 > iova_last) {
         return IOVA_ERR_NOMEM;
     }
 
@@ -262,11 +262,11 @@ static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
 {
     const DMAMap *m1 = a, *m2 = b;
 
-    if (m1->translated_addr > m2->translated_addr + m2->size) {
+    if (m1->translated_addr >= m2->translated_addr + m2->size) {
         return 1;
     }
 
-    if (m1->translated_addr + m1->size < m2->translated_addr) {
+    if (m1->translated_addr + m1->size <= m2->translated_addr) {
         return -1;
     }
 
@@ -287,7 +287,7 @@ int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
 {
     DMAMap *new;
 
-    if (map->translated_addr + map->size < map->translated_addr ||
+    if (map->translated_addr + map->size <= map->translated_addr ||
         map->perm == IOMMU_NONE) {
         return IOVA_ERR_INVALID;
     }
-- 
2.43.0


