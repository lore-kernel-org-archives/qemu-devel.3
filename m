Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443B3C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixYh-0004ak-Gp; Mon, 04 Aug 2025 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiw6t-0005db-Rs
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:22 -0400
Received: from p-east3-cluster4-host2-snip4-10.eps.apple.com ([57.103.84.23]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiw6f-0000R4-Mi
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:18 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 9C5BD180137B; Mon,  4 Aug 2025 14:24:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1h9D+mH0EmX7c+pXXwgyok5dgKu/Wx9gb8qi30gefOk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=JC4XttBWf3MMRxr7jf1SYCKE3W23WnWz90tWKpDIt+XEF5yrYTwjCrFVQO8Smd2u3GHnI81s9B44fkxCF5G4aSc4P0P/2Xj4Aqh9jFgB0P5n1ZdN41jQ+CPHMZ/kxEWDQjXKIlZf9IXI4e6SA88zjQXnGvPmiV8PNyN+wVjBszgFQmWc49Hx1acfL/qVq1P+Xx5UezRrgFhZhqrBT73R7o6i4uWPGKkRO3jgr4QGGfBVyQKohdJEeHQVbjVPIfQyc/3KfMXYMwcAVI2rkPsJVh98Yj6iKxkRSCZqEK0IeS6pKTVxf/ZEVIoJiZI8EmZi+pndh7t1QkJRM5hJq7sYQA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 8AA0D180137C; Mon,  4 Aug 2025 14:23:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 11/17] target/arm: cpu: mark WHPX as supporting PSCI 1.1
Date: Mon,  4 Aug 2025 16:23:20 +0200
Message-Id: <20250804142326.72947-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250804142326.72947-1-mohamed@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4MCBTYWx0ZWRfX0MLijd0o3/Vj
 DR+P6MFoncK6I+bC6viLGi8yThIVQrCp2JiPuPXtQ+gjnt3murNrvynnD8ThAjyRkc+nwJcGotI
 0YBLDUKLUKajMgcGwi+PO9nk78bEcJkr7iCPF36XvKMxtCSyhbxWnIIAzl87dirkdm2iKvag6AH
 wn1Al6J2Vh83+bICr92a01vgA5VHKpTeuWaljFG98xRX1DruCqSf6INhPbaoxYrXVP9ZGHwghcc
 dDaizWa6iN/FSXN7ZmmkVzQWLldNj5MxIY/x90cQ5OMCVfFWrWr/IhhxMrwZYWeLMwyDblKv4=
X-Proofpoint-GUID: o9yc4s8YcIIBtc-DBingKva_tlksTuD8
X-Proofpoint-ORIG-GUID: o9yc4s8YcIIBtc-DBingKva_tlksTuD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 clxscore=1030 adultscore=0 mlxscore=0 mlxlogscore=919
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040080
Received-SPF: pass client-ip=57.103.84.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


