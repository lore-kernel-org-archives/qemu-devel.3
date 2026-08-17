Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F6C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtIM-0003W8-DF; Mon, 17 Aug 2026 05:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtI8-0003MB-36; Mon, 17 Aug 2026 05:06:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtI6-0001g6-CT; Mon, 17 Aug 2026 05:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=D055aqzMCyAXN7RcoDnjNE5LGNVG1ARs+Kv2IajeV4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vYybrujzXQllnWM711+nFa5ChHf3SN+n9/wdLGGS3kI0PnhKM3hbDd6mXRKvmFsT1
 KljrYt3bEaenM9QImcu1FiGCqx9AefuKRE372S81ISy5xwmp98RBde5OR44ltQgWq/
 OOILF8e5wCzrxmtSd0xyQp85Iyv+WNsV+WZKCi+2gtM/GyzWjaGoHt4AT4wPKd0h44
 3o9A4u6QaN9bYX5PPSWBxa2r4CfM+k4PZzt2K6KQ8xr+b0r33vOOlAw00QoUp6B4T2
 NPj7Nxcj8fdtbawJ628cJm+pNY0WHIWcfyL1Bga3XwlLc5BQS+pnrcEbJA1x272Xo7
 PEZATzECeT9ag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2DD971CBA3F;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0D86F40D021;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BE8E530CF6; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 11/42] host-utils: fix ssub32/64_saturate return type
 and clamp direction
Date: Mon, 17 Aug 2026 12:04:16 +0300
Message-ID: <20260817090453.2034156-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

ssub32_saturate() and ssub64_saturate() were declared to return bool
instead of int32_t/int64_t, and clamped to the wrong bound on overflow.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 16495533131 ("host-utils: Introduce signed saturation primitives")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260807152241.1576334-2-brian.cain@oss.qualcomm.com
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
(cherry picked from commit 9e96b5953e2fb619a5ad6274ebba3baee0b933c4)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4183
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 2e8da7fb3d0..1db9dbb138e 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -607,10 +607,10 @@ static inline bool umul64_overflow(uint64_t x, uint64_t y, uint64_t *ret)
 }
 
 /**
- * sadd32_saturate - addition with saturation
+ * sadd32_saturate - 32-bit signed addition with saturation
  * @x, @y: addends
  *
- * Computes @x + @y, and saturates rathern than truncating the result.
+ * Computes @x + @y, and saturates rather than truncating the result.
  */
 static inline int32_t sadd32_saturate(int32_t x, int32_t y)
 {
@@ -622,10 +622,10 @@ static inline int32_t sadd32_saturate(int32_t x, int32_t y)
 }
 
 /**
- * sadd64_saturate - addition with saturation
+ * sadd64_saturate - 64-bit signed addition with saturation
  * @x, @y: addends
  *
- * Computes @x + @y, and saturates rathern than truncating the result.
+ * Computes @x + @y, and saturates rather than truncating the result.
  */
 static inline int64_t sadd64_saturate(int64_t x, int64_t y)
 {
@@ -637,31 +637,31 @@ static inline int64_t sadd64_saturate(int64_t x, int64_t y)
 }
 
 /**
- * ssub32_saturate - subtraction with saturation
+ * ssub32_saturate - 32-bit signed subtraction with saturation
  * @x, @y: addends
  *
- * Computes @x + @y, and saturates rathern than truncating the result.
+ * Computes @x - @y, and saturates rather than truncating the result.
  */
-static inline bool ssub32_saturate(int32_t x, int32_t y)
+static inline int32_t ssub32_saturate(int32_t x, int32_t y)
 {
     int32_t ret;
     if (ssub32_overflow(x, y, &ret)) {
-        ret = x < 0 ? INT32_MAX : INT32_MIN;
+        ret = x < 0 ? INT32_MIN : INT32_MAX;
     }
     return ret;
 }
 
 /**
- * ssub64_saturate - subtraction with saturation
+ * ssub64_saturate - 64-bit signed subtraction with saturation
  * @x, @y: addends
  *
- * Computes @x + @y, and saturates rathern than truncating the result.
+ * Computes @x - @y, and saturates rather than truncating the result.
  */
-static inline bool ssub64_saturate(int64_t x, int64_t y)
+static inline int64_t ssub64_saturate(int64_t x, int64_t y)
 {
     int64_t ret;
     if (ssub64_overflow(x, y, &ret)) {
-        ret = x < 0 ? INT64_MAX : INT64_MIN;
+        ret = x < 0 ? INT64_MIN : INT64_MAX;
     }
     return ret;
 }
-- 
2.47.3


