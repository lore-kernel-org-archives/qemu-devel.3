Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9212BC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTKE-0006Bq-LH; Thu, 20 Mar 2025 23:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvTKC-0006Am-U8; Thu, 20 Mar 2025 23:45:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1tvTK8-0002Nn-U6; Thu, 20 Mar 2025 23:45:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxbeLX4NxnQ52fAA--.34709S3;
 Fri, 21 Mar 2025 11:45:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfR4Nxn+j9XAA--.61233S3;
 Fri, 21 Mar 2025 11:45:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yao Zi <ziyao@disroot.org>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/3] host/include/loongarch64: Fix inline assembly
 compatibility with Clang
Date: Fri, 21 Mar 2025 11:45:19 +0800
Message-Id: <20250321034521.2425622-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250321034521.2425622-1-maobibo@loongson.cn>
References: <20250321034521.2425622-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfR4Nxn+j9XAA--.61233S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Yao Zi <ziyao@disroot.org>

Clang on LoongArch only accepts fp register names in the dollar-prefixed
form, while GCC allows omitting the dollar. Change registers in ASM
clobbers to the dollar-prefixed form to make user emulators buildable
with Clang on loongarch64. No functional change invovled.

Cc: qemu-stable@nongnu.org
Fixes: adc8467e697 ("host/include/loongarch64: Add atomic16 load and store")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 host/include/loongarch64/host/atomic128-ldst.h.inc        | 4 ++--
 host/include/loongarch64/host/bufferiszero.c.inc          | 6 ++++--
 host/include/loongarch64/host/load-extract-al16-al8.h.inc | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/host/include/loongarch64/host/atomic128-ldst.h.inc b/host/include/loongarch64/host/atomic128-ldst.h.inc
index 9a4a8f8b9e..754d2143f0 100644
--- a/host/include/loongarch64/host/atomic128-ldst.h.inc
+++ b/host/include/loongarch64/host/atomic128-ldst.h.inc
@@ -28,7 +28,7 @@ static inline Int128 atomic16_read_ro(const Int128 *ptr)
     asm("vld $vr0, %2, 0\n\t"
         "vpickve2gr.d %0, $vr0, 0\n\t"
         "vpickve2gr.d %1, $vr0, 1"
-	: "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "f0");
+        : "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "$f0");
 
     return int128_make128(l, h);
 }
@@ -46,7 +46,7 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
     asm("vinsgr2vr.d $vr0, %1, 0\n\t"
         "vinsgr2vr.d $vr0, %2, 1\n\t"
         "vst $vr0, %3, 0"
-	: "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "f0");
+        : "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "$f0");
 }
 
 #endif /* LOONGARCH_ATOMIC128_LDST_H */
diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
index 69891eac80..bb2598fdc3 100644
--- a/host/include/loongarch64/host/bufferiszero.c.inc
+++ b/host/include/loongarch64/host/bufferiszero.c.inc
@@ -61,7 +61,8 @@ static bool buffer_is_zero_lsx(const void *buf, size_t len)
     "2:"
         : "=&r"(ret), "+r"(p)
         : "r"(buf), "r"(e), "r"(l)
-        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
+        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
+          "$fcc0");
 
     return ret;
 }
@@ -119,7 +120,8 @@ static bool buffer_is_zero_lasx(const void *buf, size_t len)
     "3:"
         : "=&r"(ret), "+r"(p)
         : "r"(buf), "r"(e), "r"(l)
-        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
+        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
+          "$fcc0");
 
     return ret;
 }
diff --git a/host/include/loongarch64/host/load-extract-al16-al8.h.inc b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
index d1fb59d8af..9528521e7d 100644
--- a/host/include/loongarch64/host/load-extract-al16-al8.h.inc
+++ b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
@@ -31,7 +31,7 @@ static inline uint64_t load_atom_extract_al16_or_al8(void *pv, int s)
     asm("vld $vr0, %2, 0\n\t"
         "vpickve2gr.d %0, $vr0, 0\n\t"
         "vpickve2gr.d %1, $vr0, 1"
-	: "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "f0");
+        : "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "$f0");
 
     return (l >> shr) | (h << (-shr & 63));
 }
-- 
2.43.5


