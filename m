Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4340DD29FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8b49-0000DP-EQ; Wed, 06 Nov 2024 03:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1t8b46-0000DG-Hl
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:06:58 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1t8b44-0003i3-F1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:06:58 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1730880409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+BpYk0/f9xRXQ5ni3JK4b/TZPN7+UGhRZg9BcBe59dk=;
 b=sOTSnKU6poAUWwKwlAfNIIczagdsJK2hdYiDnUBcM7iKfuUWnwbVX9suxl3qCp30L2wsws
 6gJt1xWACtQ1dHM56gx+b/wawKpWfa9sF7t7Wuyw8VqY4qwgbEXzYa8rPah2ssfzoRgcOd
 +P13UzLbX50wtFehV0dCHbcNPO30nOY=
To: stefanha@redhat.com,
	den@openvz.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] block: fix possible int overflow
Date: Wed,  6 Nov 2024 11:04:36 +0300
Message-ID: <20241106080521.219255-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The sum "cluster_index + count" may overflow uint32_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 block/parallels.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..071b6dcaf8 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -184,11 +184,11 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
     unsigned long next_used;
-    if (cluster_index + count > bitmap_size) {
+    if ((uint64_t)cluster_index + count > bitmap_size) {
         return -E2BIG;
     }
     next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
-    if (next_used < cluster_index + count) {
+    if (next_used < (uint64_t)cluster_index + count) {
         return -EBUSY;
     }
     bitmap_set(bitmap, cluster_index, count);
-- 
2.43.0


