Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139AC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 22:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufQyT-0007VL-2K; Fri, 25 Jul 2025 18:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQx0-0006fv-3M
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:39 -0400
Received: from p-east3-cluster1-host9-snip4-1.eps.apple.com ([57.103.87.84]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwf-0003o8-UU
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:24 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 3BB6418000A6; Fri, 25 Jul 2025 22:30:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=S3ZBNHI1pU1dOel9dX+AYwGkdx57h3gION5nK4yFHyQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Dm1tmQqN7IS+Bux75/muUrxRY3bpIAP0IDw/JorHYw+sgfNLcgoYNPW7k9waO6K79BgBEYjQxzB8qjf1Dq77xGPnaWnBtra6CTd2t/I9ehO8c2ma40XIQmnJQopUwlnyDDh6/phHrTVcJVhAwStLrX0hUQ+lp/u8wBOnhD+fKzxVkXWlXXPeKN0p0TgDnwXSzlULMnIaFXyye/A7KRmNP5xedwdP97GYcVsmJkb1vrwsqt2bXoB7Vu72x/xQ5iajdDlB3RMiMfszu3ZDFyKWFqQgqHb/0n7LVcBo3PQecD1hdsUVf9dl6+e3I5c8lSUUZGOUEEO+L5RrsSngN5P3mg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 E87E61800144; Fri, 25 Jul 2025 22:30:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v3 9/9] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Sat, 26 Jul 2025 00:30:35 +0200
Message-Id: <20250725223035.52284-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725223035.52284-1-mohamed@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5NSBTYWx0ZWRfX7HJeQ4qkGxuY
 gwjZYYRLpBvzCMcXMyTif7tosSuDmLP95cg8ZXCNUzKFH453qZnM9aCT2ILwnr5deVxY4xrTZ3u
 BofyFbxrr6F3noMQkfN88OhLX86bl3C8WU8i44mwewIotghXNsVxuLsCOL0Fr99YGO4aY0n+QEr
 HP+bSsSzz7CKLpgI+x4FJMDsKNOWzOGs6kdHVwr0RmGYDNlpm35RY62xFdWM8EguBnx8X2/h+JA
 uw1jmMnsaIgcUeKjLlXMXz6OpzIGuRopaXN7AhAds59SdRHazhprUt/s9zmr4tre+Zbukd0W8=
X-Proofpoint-GUID: TcJVKwfuVzTN7IbhddLWEZwGa3JiXT5T
X-Proofpoint-ORIG-GUID: TcJVKwfuVzTN7IbhddLWEZwGa3JiXT5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=882
 suspectscore=0 clxscore=1030
 adultscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250195
Received-SPF: pass client-ip=57.103.87.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Apple's platform vGIC doesn't support ITS. Deal with this by reporting to the user and not creating the ITS device.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 91d8cd9363..005e923a22 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -740,6 +740,16 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (hvf_enabled() && hvf_irqchip_in_kernel() && vms->tcg_its) {
+        /*
+         * In the HVF case, inform the user that they can use the
+         * user-mode GIC if they want to have an ITS.
+         */
+        info_report("ITS not supported without kernel-irqchip=off on HVF");
+        info_report("Disabling ITS");
+        return;
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
-- 
2.39.5 (Apple Git-154)


