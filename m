Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FCBC28B28
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 03:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsvnD-000084-E7; Thu, 13 Mar 2025 23:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1tsvnC-00007o-K6
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 23:33:02 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1tsvnA-0007Tk-8I
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 23:33:02 -0400
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 580D920239;
 Fri, 14 Mar 2025 04:32:56 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gy546e8Uc-cG; Fri, 14 Mar 2025 04:32:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741923171; bh=fgjXF1H4xJqxgmwiFt6pcCq5GldNj7vvD9yTPgIb1m8=;
 h=From:To:Cc:Subject:Date;
 b=hp/7aDle9QmXq/QztOQKV57TJ+R5usMgkF906JRGKcW/FtLmww8F0qTZS6HoyOU3a
 2yCwaeLJsqJOaK8AyLX22qKE8MdTdi20YA5+iNa6kK2jUY+HU0sIYraUFW0ZsSV2X5
 nsDo0QuqrlzaqE9zptWf1iDmE5tLkEZcCwfGtJOgXhim5os6f4KY/Q3+K85h5aUCxp
 mzyLiG6dRdbogOTZ7Eur5lF8/CvoHWpC8Ew0X7u8CVFp65jhphMS4i9LVKfWvT8Ghg
 vDGIO9KSVGZJ+s+V7syTVrFC2KaaqMrC7jhjyJmJstfCu1Nm3uUa/51Oi5OmnfmkBl
 SS+tdWX0O2kJQ==
From: Yao Zi <ziyao@disroot.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH] host/include/loongarch64: Fix inline assembly compatibility
 with Clang
Date: Fri, 14 Mar 2025 03:31:51 +0000
Message-ID: <20250314033150.53268-3-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=ziyao@disroot.org;
 helo=layka.disroot.org
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

Clang on LoongArch only accepts fp register names in the dollar-prefixed
form, while GCC allows omitting the dollar. Change registers in ASM
clobbers to the dollar-prefixed form to make user emulators buildable
with Clang on loongarch64. No functional change invovled.

Signed-off-by: Yao Zi <ziyao@disroot.org>
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
2.48.1


