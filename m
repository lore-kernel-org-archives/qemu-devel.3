Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EE606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gJYThr4Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpH7-0005mC-F3; Tue, 24 Nov 2026 07:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1xVpH5-0005ln-Ut
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:05:27 -0500
Received: from out-19.mta0.migadu.com ([2001:41d0:1004:224b::13]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1xVpH3-0007CP-I9
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:05:27 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=z5j9k0hnTZIR3d9O+Ipc6mN7fCYQc1oCzf7jHc/FkLE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795521921; v=1; x=1796126721;
 b=gJYThr4Z4wQi/uNBHL8otDub9PM/kMh0+EjuCBjNWv8x6ASXqepydcRL55v0bzGNWHKBrHR4
 XXc3a9WoXnJE9rlbaoFPCSb+qWviXPZD3b8K//4MymU/m4fIRaLXFevuuroyLxKZLCfqpJ1nuS3
 dIt2yYmQht2VzbH75RfEO5dM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 252964f6d34bb0fc;
 Tue, 24 Nov 2026 12:05:21 +0000
X-Mizu-Trace-ID: 252964f6d34bb0fc
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register
Date: Tue, 24 Nov 2026 20:05:09 +0800
Message-ID: <20261124120509.19746-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::13;
 envelope-from=zenghui.yu@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GICv5 spec says bits [31:21] of IRS_DEVARCH are 0x23b. We wrongly
shifted it by 31 instead of 21, so guests read 0x80105a19 rather than
0x47705a19.

Fixes: 22232793ecb8 ("hw/intc/arm_gicv5: Implement CoreSight ID registers")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 hw/intc/arm_gicv5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 26dcbc82ed..59b8596bf0 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -318,7 +318,7 @@ FIELD(ICSR, HM, 5, 1)
 FIELD(ICSR, PRIORITY, 11, 5)
 FIELD(ICSR, IAFFID, 32, 16)
 
-#define IRS_DEVARCH_VALUE ((0x23b << 31) | (0x1 << 20) | 0x5a19)
+#define IRS_DEVARCH_VALUE ((0x23b << 21) | (0x1 << 20) | 0x5a19)
 
 static uint32_t gicv5_idreg(int regoffset)
 {
-- 
2.56.0


