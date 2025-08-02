Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62499C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 05:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui4zx-0000IN-VM; Sat, 02 Aug 2025 01:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zo-0008O3-JI
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:28 -0400
Received: from p-east3-cluster4-host10-snip4-10.eps.apple.com ([57.103.84.103]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zn-00066S-5v
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:28 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 CFC17180088B; Sat,  2 Aug 2025 05:41:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=uAK2JGD17JBPBJY0OV3B6ARqLAA1c242C6w8DU8xlGk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=E+Yqp1GPIycEOa6jRozCQ+8iPFAq7Fu0hXK7f+Cs1x3cOJ1bEaNs8h73lMVMsuh+vN1IrPNGAxHxWpqlYj+tj0oQb97ir7zT+PE3xzwi27ZN8+39R0z1ZqMqxsct8dvBlTxWm41YW4r97Fpcv/GABzw7yq9xDCjU6Gfufn/xvtK6o+q5uEK5kdKysEvtKl5pjxuykLa40kjgN5BJhnBKUZcxtc+CHlgZ1a7kfZ/nGBx2EyQzXn86+nG/62tkxOA8MPy/MlZ360+IEJzIvwWADm9GLZrmPZDsosnnTEkRIlWG9XV4QCUhjq5BIaqgyRhApe6PdjytvntBiMYehLq2xQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 BDC281800A87; Sat,  2 Aug 2025 05:41:19 +0000 (UTC)
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
Subject: [PATCH v2 09/14] target/arm: cpu: mark WHPX as supporting PSCI 1.1
Date: Sat,  2 Aug 2025 07:40:50 +0200
Message-Id: <20250802054055.74013-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802054055.74013-1-mohamed@unpredictable.fr>
References: <20250802054055.74013-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA0NyBTYWx0ZWRfX+5dYb4LYU+bq
 B8de/claQLhn0WBJRSGKWUcZi9WczBIC3Re9eR0dePxg2Jhsx0TovW8cijLyMp8vIsWYxlDiOOE
 /i35NRlRAJ8P6HrZ0L9XgV8ItNy6eMa8jQcgIwL9gh5m5Y2ZLJmCGtlSB52qmvBJrxxPJ9iMzqt
 wmwEsVjM8lrtfPCKSheWv1o3mXgjfRELSeipunnWlDCv/hPYKyiQRdkvbGBMkzqlsHSP9n8c3+q
 E6gnQa7JxDnUuIWBz0FVhjG019tKRFpAuezcQzhdlro2pqhn07ckm6RGTCi+r3tbAQgDw/KMg=
X-Proofpoint-GUID: AOAfSSsGBkWbAbQ4WfmEVXSS5cjGThjt
X-Proofpoint-ORIG-GUID: AOAfSSsGBkWbAbQ4WfmEVXSS5cjGThjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1030 mlxlogscore=900 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508020047
Received-SPF: pass client-ip=57.103.84.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..3b69c9786a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1496,7 +1497,7 @@ static void arm_cpu_initfn(Object *obj)
     cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
-    if (tcg_enabled() || hvf_enabled()) {
+    if (tcg_enabled() || hvf_enabled() || whpx_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
     }
-- 
2.39.5 (Apple Git-154)


