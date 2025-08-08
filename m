Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEAEC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH7M-0006B6-4L; Fri, 08 Aug 2025 03:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH74-00065w-GV
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:02 -0400
Received: from p-east3-cluster5-host5-snip4-1.eps.apple.com ([57.103.86.172]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH71-0005F9-UU
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:02 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 60E001800164; Fri,  8 Aug 2025 07:01:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=/ppM7p2dgG+rBZSRQlt4dgyhSPzj1LQ/TSd0lA8u5U4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=I5Ar1MIwl9m/TBe7fazSVx8guKgUdSjaa/7PVglgowifeOTu+D9XgNPYlCXBdrUmzGJ4vDknvBStkuRNPMtCgrqwbsQEDv2zR0uBhoY4y430HkGJaAKheSqOrgjzcFSSDB8XZCLEfQAFBJv1SbRkqD+fyA3zeYnzcBaQqHi4Mz33njds0l4nMHgZbljiY5jYNi4LRynIW8SuOZJrIIKEOpJSG9EccKd8vjcRrlcUeuNbRqYWziyppfzBZextjuqYAl8z95JOUIoeh24M+Z2m+qwM3Fq1Xwnod6D6a+NQt+vSmrDTD5meitkulZYE97aVrkZfjohVeJtcRk+Zv6ptPw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 4863F1800174; Fri,  8 Aug 2025 07:01:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 08/13] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Fri,  8 Aug 2025 09:01:32 +0200
Message-Id: <20250808070137.48716-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808070137.48716-1-mohamed@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n4LmibNZrAF5jqmam66FcKpX_MyG08e-
X-Proofpoint-GUID: n4LmibNZrAF5jqmam66FcKpX_MyG08e-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NyBTYWx0ZWRfX25qA4Z+TuPsQ
 tObdcTP/kn7i3GllVx8kN+1os4k4t2SgOf6FqyHIRLlqQstzm66fvwU4GuWH/03h5ZNzanklon2
 ZRvt1mszI9+35QXEBlVc7lIWih/NJmDj4iWMJQYcFzje3s1HpNoCWR9SXaCGUMXQSKgOqV3NBoi
 pMiTHNBRAvWgvySWnltXaPRycCqbU3YPOih5+LSbtOKPspm9/7e77TJWpfzQyoHjxTzypwIjiZ/
 DOibJqacbrRSmsstCO7uKL1bFjxo6806PIGqrCcZwbGOqMtO13bqukkqknCZ2qSmOMIuuMv0I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1030 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=899 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080057
Received-SPF: pass client-ip=57.103.86.172;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Apple's platform vGIC doesn't support ITS. Deal with this by reporting to the user and not creating the ITS device.

Regular configuration: GICv3 + ITS
Resulting configuration here: GICv3 with no MSIs
And its=off explicitly for the newest machine version: GICv3 + GICv2m

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


