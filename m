Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17FBC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEn0M-0000vn-CZ; Wed, 05 Jun 2024 05:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sEn0J-0000uV-Ns
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:32:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sEn0G-0005Ce-Cn
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:32:23 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxi+qfMGBm3boDAA--.16139S3;
 Wed, 05 Jun 2024 17:32:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPMedMGBm03QVAA--.54130S4; 
 Wed, 05 Jun 2024 17:32:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] util/bufferiszero: Add simd acceleration for loongarch64
Date: Wed,  5 Jun 2024 17:32:13 +0800
Message-Id: <20240605093213.2191929-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240605093213.2191929-1-maobibo@loongson.cn>
References: <20240605093213.2191929-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPMedMGBm03QVAA--.54130S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Different gcc versions have different features, macro CONFIG_LSX_OPT
and CONFIG_LASX_OPT is added here to detect whether gcc supports
built-in lsx/lasx macro.

Function buffer_zero_lsx() is added for 128bit simd fpu optimization,
and function buffer_zero_lasx() is for 256bit simd fpu optimization.

Loongarch gcc built-in lsx/lasx macro can be used only when compiler
option -mlsx/-mlasx is added, and there is no separate compiler option
for function only. So it is only in effect when qemu is compiled with
parameter --extra-cflags="-mlasx"

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 meson.build         |  11 +++++
 util/bufferiszero.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/meson.build b/meson.build
index 6386607144..29bc362d7a 100644
--- a/meson.build
+++ b/meson.build
@@ -2855,6 +2855,17 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
   '''))
 
+# For Loongarch64, detect if LSX/LASX are available.
+ config_host_data.set('CONFIG_LSX_OPT', cc.compiles('''
+    #include "lsxintrin.h"
+    int foo(__m128i v) { return __lsx_bz_v(v); }
+  '''))
+
+config_host_data.set('CONFIG_LASX_OPT', cc.compiles('''
+    #include "lasxintrin.h"
+    int foo(__m256i v) { return __lasx_xbz_v(v); }
+  '''))
+
 if get_option('membarrier').disabled()
   have_membarrier = false
 elif host_os == 'windows'
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 74864f7b78..751e81dbb3 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -265,6 +265,109 @@ static biz_accel_fn const accel_table[] = {
     buffer_is_zero_int_ge256,
     buffer_is_zero_simd,
 };
+#elif defined(__loongarch__)
+#ifdef CONFIG_LSX_OPT
+#include "lsxintrin.h"
+static bool buffer_zero_lsx(const void *buf, size_t len)
+{
+    /* Unaligned loads at head/tail.  */
+    __m128i v = *(__m128i *)(buf);
+    __m128i w = *(__m128i *)(buf + len - 16);
+    /* Align head/tail to 16-byte boundaries.  */
+    const __m128i *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const __m128i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
+
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    v |= e[-3]; w |= e[-4];
+    v |= e[-5]; w |= e[-6];
+    v |= e[-7]; v |= w;
+
+    /*
+     * Loop over complete 128-byte blocks.
+     * With the head and tail removed, e - p >= 14, so the loop
+     * must iterate at least once.
+     */
+    do {
+        if (!__lsx_bz_v(v)) {
+            return false;
+        }
+        v = p[0];  w = p[1];
+        v |= p[2]; w |= p[3];
+        v |= p[4]; w |= p[5];
+        v |= p[6]; w |= p[7];
+        v |= w;
+        p += 8;
+    } while (p < e - 7);
+
+    return __lsx_bz_v(v);
+}
+#endif
+
+#ifdef CONFIG_LASX_OPT
+#include "lasxintrin.h"
+static bool buffer_zero_lasx(const void *buf, size_t len)
+{
+    /* Unaligned loads at head/tail.  */
+    __m256i v = *(__m256i *)(buf);
+    __m256i w = *(__m256i *)(buf + len - 32);
+    /* Align head/tail to 32-byte boundaries.  */
+    const __m256i *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
+    const __m256i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32);
+
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    v |= e[-3]; w |= e[-4];
+    v |= e[-5]; w |= e[-6];
+    v |= e[-7]; v |= w;
+
+    /* Loop over complete 256-byte blocks.  */
+    for (; p < e - 7; p += 8) {
+        /* PTEST is not profitable here.  */
+        if (!__lasx_xbz_v(v)) {
+            return false;
+        }
+
+        v = p[0];  w = p[1];
+        v |= p[2]; w |= p[3];
+        v |= p[4]; w |= p[5];
+        v |= p[6]; w |= p[7];
+        v |= w;
+    }
+
+    return __lasx_xbz_v(v);
+}
+#endif
+
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+#ifdef CONFIG_LSX_OPT
+    buffer_zero_lsx,
+#endif
+#ifdef CONFIG_LASX_OPT
+    buffer_zero_lasx,
+#endif
+};
+
+static unsigned best_accel(void)
+{
+    unsigned info = cpuinfo_init();
+
+    /* CONFIG_LSX_OPT must be enabled if CONFIG_LASX_OPT is enabled */
+#ifdef CONFIG_LASX_OPT
+    if (info & CPUINFO_LASX) {
+        return 2;
+    }
+#endif
+
+#ifdef CONFIG_LSX_OPT
+    if (info & CPUINFO_LSX) {
+        return 1;
+    }
+#endif
+
+    return 0;
+}
 #else
 #define best_accel() 0
 static biz_accel_fn const accel_table[1] = {
-- 
2.39.3


