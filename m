Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88929C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weglG-0003gZ-BF; Tue, 30 Jun 2026 18:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegl0-0003dX-Dz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vL-RU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7ECE343FA3;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 601D4C2BCC7;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=9HxzHKOVfC6LwhGTq7a0TLkV6OWHGgH78bnClOoowyk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BYOKHsNpRnZn0YhEBlKge3Z09D7MdDQtgbXCLY1AywcpLW2bNtT/vOb9uedkY42nf
 Rfo44bKaVkXi5ey7VfneOsOVLYJFoeNGac9rrj4sVvvJmyTOLAWnhZDF91JSPy8LH2
 CMY3gzgE4AN/sVMZmNQCGqKemJFPvkfrTDWCZaEQUauTjK6D0KdVqOxc0C1ORxUQsN
 f/Ir6lGMD/5QDxojHMXWy/pVxE8zoy8Yw2DuXGKGpg3gWhZ/KPPNR1ro8sUVTbj1lR
 O5mjGdMaKUAglEHSdFMDe2ZxWaHoaaOHQPm+0QycCkU6GTj6s9/r9LhEh6EliCZBJQ
 jwhwi/VBNj21g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF4EC44500;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 01 Jul 2026 06:15:56 +0800
Subject: [PATCH 2/6] target/loongarch: Fix offset calculation in vector
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-loong64-be-v1-2-9c7d65e00697@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
In-Reply-To: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=V/jhXbT74YZEsNz79vjrDNku8mR/iHXLwWV1UlDe90E=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAl+bcJ7f+U2U5uTFeHz7/5qdEHL64tWwFiz
 gRJsD+C6hmJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAJQAKCRCwMePKe/7Z
 bhwIEAC9fH/P9OwZ+Qs+vSKOX/GHsaNQez0LoUzXDQmkFoQWC7eDQ09qKg14ZzLIcYfPI9raqMV
 Nv7xycWLt45jJ1SPeOfxcvdR3Hg7l0sXPKY0htMiin0TOy9bAU4dqipm/0hDX6S1i728WqnrU3f
 RKEX0M5a96YiIcuJXZKLovNVx5gc8NlWM2+6YNxuavyyIdWjixbPQIYR1jUL2Wrdq4BuwUFf4O+
 J6FsUIUHajNBWwvIQ3mCgUHSrBhpPfGokQDcH2vJp+LcnjZRUrhO+vw/UvIhGD8+9e4fji/5FRa
 QsXL/tHyPcWMh9EbEdJOlfctSgkdx25GxBYD12UeXWsOkL8m7077GH1zR8YxNxQMpVRinMqaqiH
 MLWkpFejwqWZ2uZOGkyUyDEr8PDA98ZcG8jAZ//JGCUEyf2D21DQatLDYkS3okwfEypWMhwUiyB
 cuhRlcn6ZiCGRBJvlO9nCI1GhivBT14gxmEis2fsn0N0eiYJZWPmFVlq486LwAXK/X9/O0BMEfX
 BLiLt1h1AHsoZWPfW9ruPDIUSEgty0LoA7nTTzcM7WGUIJzin4xYVm3Sly0f51rs7BKmFXr8W7T
 x+OinzlmczsHaBfsrF6e2Ue+eMZcH4UrGj8wXnby889O53i7eWEDryONunwP8KjBEU3CUADTTzy
 ygcDqCrE90pKl+g==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

When vector registers are extended to 256 bits long, the expected layout
of the registers is storing two 128-bit integers in host endianness, as
indicated in vec.h. So when the registers are visited in the unit of
64-bit, the index should also be reversed.

Fixes: f5ce2c8f2c0a ("target/loongarch: Implement xvinsgr2vr xvpickve2gr")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce626954a85e5754de847ccba1796aebd8a6..ac4daadfdb5298a0850bdd0b1fce32407f1eeecc 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -41,11 +41,11 @@ static inline int vec_full_offset(int regno)
 
 static inline int vec_reg_offset(int regno, int index, MemOp mop)
 {
-    const uint8_t size = 1 << mop;
+    const unsigned int size = memop_size(mop);
     int offs = index * size;
 
-    if (HOST_BIG_ENDIAN && size < 8 ) {
-        offs ^= (8 - size);
+    if (HOST_BIG_ENDIAN && size < 16) {
+        offs ^= (16 - size);
     }
 
     return offs + vec_full_offset(regno);

-- 
2.49.0



