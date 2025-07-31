Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6206AC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 05:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhLr7-00011q-4B; Thu, 31 Jul 2025 01:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpo-0007RM-NA
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:08 -0400
Received: from p-east3-cluster2-host8-snip4-1.eps.apple.com ([57.103.87.202]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpl-0005lB-Vd
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:08 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 DB934180013C; Thu, 31 Jul 2025 05:28:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=AGjseZ7zt0l8FHwCnnZpSePqyk5P3OktatL+TergPl8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=D00Xzk/hUA1M+pUNPazVo18rFFQQvBY2DRCBrXNzJYiNTlAftvh3hwCgjV+ngWrmOTysv3f2gNjD+1v9NQVjJmW5RZwtxm69WUMpt1lVv/ZhAifedaO8s6emmZnFm3xBvkJvDc0Rij3sSytxjhLji1QKx9aM/xqS/pgZYjmOocLNOKLrnrZCltb49AfWG+G1zn1fik05NhIn47JUxbGLLlZkX101ZqbyZFYYevYZCdp/TK7sU1fu9BbbQSHSG4yjG4QzPnzrVX3ElrJmeSQrJ6Jm687uvpW4a5vqqBd3X9d7Dn6SKqUb1lH6TUVxWQ9O0NGeRzGzx9HG2k7/YJnhnA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 C8E3A180012B; Thu, 31 Jul 2025 05:27:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 3/9] whpx: common: use whpx_cpu_instance_init on x86 only
Date: Thu, 31 Jul 2025 07:27:47 +0200
Message-Id: <20250731052753.93255-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250731052753.93255-1-mohamed@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cABgd0-QmIkgcGeS8oPHSkR8dxmLUlvg
X-Proofpoint-ORIG-GUID: cABgd0-QmIkgcGeS8oPHSkR8dxmLUlvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzNSBTYWx0ZWRfX9gZch5YZwLfq
 VSNhL9ppekpHLYXRSMt5zgniXqbwwUwPq3S4TmC8cYSPEZLcc/KciKvRPk9mV53GD5MBJ/oG43C
 S4T6bYqhO4vDrEOxdu5rVjn2/GJejqdEms95uV2+EQVP+BPu2Norvi6N+biFPOBJtau1Sg2i017
 cPiZxUfo7WOWFWbnvTupcQj/H3tkOycL02BnslRL3PwAg5e+zR1AOLVCUDlNeoV7l5bzkuIkdzx
 DcEbuXG3bMMdmUsfQ7c1nrtU3febRkYmBFWGOEmdeC0yPNulTNFwDzbd4a90wV5//1M5c1ge0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=885 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507310035
Received-SPF: pass client-ip=57.103.87.202;
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

We aren't using it on arm64.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 0b23deb7c4..43d0200afd 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -486,9 +486,10 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
 
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
+#ifdef __x86_64__
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
     acc->cpu_instance_init = whpx_cpu_instance_init;
+#endif
 }
 
 static const TypeInfo whpx_cpu_accel_type = {
-- 
2.39.5 (Apple Git-154)


