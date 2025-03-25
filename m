Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE675C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyBP-0002op-Cd; Tue, 25 Mar 2025 02:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9v-0006xB-Hs; Tue, 25 Mar 2025 02:53:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9t-0001yT-Jl; Tue, 25 Mar 2025 02:53:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE2BF107D7F;
 Tue, 25 Mar 2025 09:49:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 90F2D1D5E8A;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 837115705C; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yao Zi <ziyao@disroot.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 61/69] host/include/loongarch64: Fix inline assembly
 compatibility with Clang
Date: Tue, 25 Mar 2025 09:50:34 +0300
Message-Id: <20250325065043.3263864-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
(cherry picked from commit ca2737d6eca7fcc62ecb7a27246837b7c18830fc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/host/include/loongarch64/host/atomic128-ldst.h b/host/include/loongarch64/host/atomic128-ldst.h
index 9a4a8f8b9e..754d2143f0 100644
--- a/host/include/loongarch64/host/atomic128-ldst.h
+++ b/host/include/loongarch64/host/atomic128-ldst.h
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
2.39.5


