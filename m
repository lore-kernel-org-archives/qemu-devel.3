Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7FDC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGdz-0002DL-MX; Wed, 26 Aug 2026 12:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wzGdv-0002Ch-Cx; Wed, 26 Aug 2026 12:38:27 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wzGdt-0006ph-DJ; Wed, 26 Aug 2026 12:38:27 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDHxq52Fo9qbsgXAQ--.25643S2; 
 Thu, 27 Aug 2026 00:38:14 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwSXR1Fo9qnoGOAA--.7246S3;
 Thu, 27 Aug 2026 00:38:13 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH] util/cpuinfo-aarch64: Fix build with older glibc headers
Date: Thu, 27 Aug 2026 00:37:53 +0800
Message-Id: <20260826163753.459661-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwSXR1Fo9qnoGOAA--.7246S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWqN7UkHJwAAs0
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZryxtFWxtFyrJF4DJFWDurg_yoWkWwc_Xa
 yxXFW8tr4Uur4FvwnF9r4rCrZ8Gr1rGF95Jw18Zw4DAFn7Kr4DG39I93y8ZFW3Wan3Jr47
 tw4vvrs8Ca4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Commit 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
started using HWCAP2_CSSC unconditionally. This macro was added to
glibc's AArch64 bits/hwcap.h during the glibc 2.38 development cycle,
so AArch64 hosts with older headers fail to build.

Follow the existing HWCAP2_BTI handling and define HWCAP2_CSSC to
zero when it is not provided by system headers. Such environments
simply do not use FEAT_CSSC host optimizations.

This has been tested on an Ubuntu 22.04 aarch64 host with glibc 2.35.

Fixes: 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 util/cpuinfo-aarch64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 4ce6deb7c82..e3446762149 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -16,6 +16,9 @@
 # ifndef HWCAP2_BTI
 #  define HWCAP2_BTI 0  /* added in glibc 2.32 */
 # endif
+# ifndef HWCAP2_CSSC
+#  define HWCAP2_CSSC 0  /* added in glibc 2.38 */
+# endif
 #endif
 #ifdef CONFIG_ELF_AUX_INFO
 #include <sys/auxv.h>
-- 
2.34.1


