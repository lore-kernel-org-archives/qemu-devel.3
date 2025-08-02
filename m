Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79D9C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 05:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui501-0000PG-0s; Sat, 02 Aug 2025 01:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zp-0008Qh-To
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:30 -0400
Received: from p-east3-cluster1-host11-snip4-10.eps.apple.com ([57.103.87.113]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zo-00066s-C1
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:29 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 09ACB18008A5; Sat,  2 Aug 2025 05:41:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=dSbSkPQq8ziwuUrDfcT+wVetv0JbuPGQpZU1ZgNV4oY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=WGVhwri2dfvQmCu6xkXf/8iOUcvKKGUwACbibqtSEasKNfZADpj45khx1NEf9X5fex24C2c8aL2OOk9SdHmuQc4MJcuOsrSR9RcN+akoNWQIgMZuvQlcWPIK+eaMcxl7KF+HsPMVZmqhyIfpGBJqOXYjXL3hmpcjo32cCj7HTUHOADDYnuM2lcyO16dTH7H1m4dDZgZJZGRPJ4NMGppcnEU42mRjjbTcy33K13zFOGPF4kuOZtk7PRzY71pJhtlRzNxhjEy+klNReO+ytB4/sD4TWTEj6maDCS6o/deSECEF0vwbxj+vPMZJ7Sw0mcMAW7fjyjibNr9/bH8fdnH9Wg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 1B0211800A81; Sat,  2 Aug 2025 05:41:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 10/14] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Sat,  2 Aug 2025 07:40:51 +0200
Message-Id: <20250802054055.74013-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802054055.74013-1-mohamed@unpredictable.fr>
References: <20250802054055.74013-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mHWMdjffxOPs7MJtKQmoidDQkoCBdu3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA0NyBTYWx0ZWRfX9ARlYGW5C2bW
 1TR7iuo3icR6J/Bacsak/MfTlhovXSy410XERsquJOlOGommFXHsqLxHut49kMGbxVwBOv1Wq1D
 R0uINRO3UIldxt0s6mmONCGzaGVjoG43mcuhAFwZ27vJUK7P1y/IyZ5iNEl6tEuuferPAKGdP6v
 4LEXwJltO/FpJwvlMSZJPkNtPbF/vVMvhnOu+8UnVe4Uhp7EI2xr0z6Os6IUmP6DdIJ0gWoD7uS
 1GGof7dsdsndFqRxi+BVQDdUlRSAdUX9XbylHiUOlCTrSjC/aqeUu95mzQ0AkTlr0DoXnLWvY=
X-Proofpoint-GUID: mHWMdjffxOPs7MJtKQmoidDQkoCBdu3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=880 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020047
Received-SPF: pass client-ip=57.103.87.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and not creating the ITS device.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 98a1c74c42..1c695c0642 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (whpx_enabled() && vms->tcg_its) {
+        /*
+         * In the HVF case, inform the user that they can use the
+         * user-mode GIC if they want to have an ITS.
+         */
+        info_report("ITS not supported without kernel-irqchip=off on WHPX");
+        info_report("Disabling ITS");
+        return;
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
-- 
2.39.5 (Apple Git-154)


