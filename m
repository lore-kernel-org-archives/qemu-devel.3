Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F26C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 05:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhLrC-0001AY-Mz; Thu, 31 Jul 2025 01:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpr-0007Xw-QN
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:12 -0400
Received: from p-east3-cluster2-host1-snip4-4.eps.apple.com ([57.103.87.135]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpo-0005mT-Pd
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:11 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 8F80D1800185; Thu, 31 Jul 2025 05:28:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=2obuM0xhK8jlFobIsYOi4z9xd0ivaQTiI7sZyyK+v7E=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=WNp/NYnlSVKfMH3FsTk7bNfviwbiW8O2wM3Hfe7olfw5F8cdmjUBtV6OZYxxZwMr4jKcfwb4vLCRkjWSgwmrQsqxzV/UgNP0Q9EbtA1E/B7ljt8RtAGrkh3fyg14qUCXbiwDQjb/t6Qi78u5wfQD5x1C6JTRck+bSAvAdfSn/q7N5VJ9QIihR8AOFXNjNckD8VXNOa760R9bln94h076p2NqrGaYFHJzGtZkIFLgAJ1LulB2Mx5H1HVq/+ucdcR08m8TjNi3nLhpXFhfQRhe7LXMzdlwZjHF/pbzPSS5yooRGjCJruRxtsEkuv4KeNoFT87OdnAP3a9NrKw1henRcQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 C1D59180011E; Thu, 31 Jul 2025 05:28:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 6/9] hw: intc: arm_gicv3_common: add whpx
Date: Thu, 31 Jul 2025 07:27:50 +0200
Message-Id: <20250731052753.93255-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250731052753.93255-1-mohamed@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TQTveC6NcbGrMy_-_K7KDhpXCnQMCmMX
X-Proofpoint-ORIG-GUID: TQTveC6NcbGrMy_-_K7KDhpXCnQMCmMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzNSBTYWx0ZWRfX2hjvrK0YWted
 W2ngVtSsxSdP/sJ3WyCYvc8rEZvLoptV3cPk+YTJFb2GUTIOV+yQQ1XqVe5PEMDPCn30LsdUptG
 6CQJSWXjZS3nRrHLupvYygFirgKJWzU4smT65lDGByfYcabRebIwbTE96fY/LTKPYa0zPaDCXGt
 9V4bv1A1Ay+jR0dMjaV0NbZTWZbA0SjJbuRM4LsrQgvCCwQlFu05nxXh5yIwhJr4sOnN5EOpvV3
 Nbft3YESBRMNWL+Qt5djlRL2fB5jOibNs/+ZT3AsFTXC1b7iNFstA2RQvfdHHCV9SoUQVK3tc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=762
 clxscore=1030 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507310035
Received-SPF: pass client-ip=57.103.87.135;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Redirect to the platform-specific vGICv3.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e438d8c042..a83b075517 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -32,6 +32,7 @@
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
+#include "system/whpx.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -662,6 +663,8 @@ const char *gicv3_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
         return "kvm-arm-gicv3";
+    } else if (whpx_enabled()) {
+        return "whpx-arm-gicv3";
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
-- 
2.39.5 (Apple Git-154)


