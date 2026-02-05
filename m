Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA6E9D414
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1FB-0005O5-KH; Thu, 05 Feb 2026 10:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1F9-0005Fg-Do
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:26:07 -0500
Received: from p-west2-cluster1-host5-snip4-8.eps.apple.com ([57.103.68.51]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1F7-00026h-NY
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:26:07 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 688181800771; Thu,  5 Feb 2026 15:25:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305164; x=1772897164;
 bh=s1GW0hnfqvPJUBalVotB8aEtoQcY7bM3WJxM9j7OEF4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CXDGluzRThUEXatZHjGUDvCqGmU/qsegOY+Piwdygfx6qUmfmsdl9EouHfRuVP1YJIf/xx1eF3R8lUrJgBXOXWJ7n8MIRvsEhT9kl6eMgm3KMbm0Y+rNCRtHCgW5o0/dOK5khJnTgH8Rl12AqBoyaUqnsK0FEeA67Rx6JCa1xBh3HFlFdqdlEEJYBk7McFYpES9ymHx85fnXqqKajL3Aws3E++I7MS/C9bHSdQfCM0GD4XGGIfPJHs9W6TXlDx8VTRE94zFk9ahmk3Hnuky3RXtqqnsU1WlMbFAwW3Cn5pH+3HuPQUT1uqIoiL6vbZDKzVQir3uF3ukonhMFDMICfw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 E93D718003C8; Thu,  5 Feb 2026 15:25:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 16/22] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu,  5 Feb 2026 16:24:19 +0100
Message-ID: <20260205152432.78208-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNyBTYWx0ZWRfX3ccB2OoW2RqD
 WfZ+sBE0NDv2pNdL8o6H8NMefFU4AgAsnD2H3NeHGelbCi2RigqCn+PFrvBh0eV6kOl4yeQ5Wv4
 pfwuYS1MAjrBCkF+U56mLfJA/tryhHyOuDM7RPm2vtyLeYSCOnJ2oKCywlLhbS/fhCe13lhRIxY
 O6gorBK212ttRzsgORdc2B4FLDsIAmSwdFj+6SqW0YgwonHZp/TMoEf/4xfQl1ajU/lt77+blh5
 BVjkoNM41p/vXdIfmqBFjKYUxHSiSfKygCJaL7UpBdT5BFWKc4DU7PoQ4yYRAy4mXn8EdY+hPqi
 DIEE/MnGJ2h7PeO/DA6yLVa9BwDU3NpzkxiD5NLUSqbx+WTfjIk2IUIZg2nIV0=
X-Proofpoint-GUID: Fjb-6dGmUSKw5YXyRm2qfjTITuOBcAdj
X-Authority-Info-Out: v=2.4 cv=HfwZjyE8 c=1 sm=1 tr=0 ts=6984b68b
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=emIkxkYSJqCgyAM8kcYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Fjb-6dGmUSKw5YXyRm2qfjTITuOBcAdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999
 lowpriorityscore=0 clxscore=1030 adultscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050117
X-JNJ: AAAAAAAB3OwwnI0YhWmvpnmiohhTgZ4bHIsbY/TCCD8hebkd+p9Tl3rgzfpCQ5u1J7Qf2XQ0SrOVScMA2LP7fenzRQKZ9TbmWyyEKuXWZACUee+1150fUuXR/kEKU1Q5X2eSMbzx+4m/k9GEKrSqMveMBomCxuIODnbIeFtJdwEPCDVAAPKZjz/JsHL3z5svE2CKSe0bDnB03MbNoMliJfMG/Vid3Mx5fZVkl8T9PnKz1GvAbximOF8E2QNzLzz4Id+G9mFGyOJ1n3hMXLGakaYpxry9vvqSySB0INTpTJ463NSUpiQRMk3NdYyJf2zrFNBOtpRg+sPXFof7C2dN26HKaQldDGD/vSjODqhttYpC6Gh+kRJUqcRb4mLFey3SGxaw1LSq/B6kw9TfAaRB4EPxpxDNHj674AogaqILc42v6V5S8Zh+DCR3OIuh8gqCRhljceKKCK7UQoetwUbYx4zTsDE0wUQiIxLyJSdzoOYuiELxEOxkd1QC8Vk29Ws+UpMEu+LFTvLAqbf+XRkwWFS1JjZtw/bPBb1KQUy4o1tOKuNBBQLGbBenKdvdIJ72zoDQ7tSoTETNBb4+pF5yk/A5sCQ43YgVUswu1GzRzJOinBp7tBtvN/0Riga4ecmqB7nZQrehNaQkPCIpdGS/PAjQS9pPGxbRB/NjTfoPLLp5Ifi5MOqKpfWVAArfEd1qQGgcgyVaDTSnEgPwcbTiDiIsGcLEh0twUPBKx4z9Ftxskax5oCZtJRrULmPY++7Pi3ABNApfQZotLt4/UgxurPBrGRym7/18KbYVprOjpp7q8cQNoFqqlYVdggbk08uiymIEBu5kXiZuXpzeq7v4OfuiYspTRASUbJxBW8OGVO4pDDQ+K6h0/A68o6NC/9R5pYa07cmMd6SJEh2V66yQXJizrCbGno3NOj5FMqqqE9zKDiXjmQeY/PmHxdgfnX0DUAq1gE5rSiArfSsOTYHUKJIRNpFjbgN
 f
Received-SPF: pass client-ip=57.103.68.51;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c535b292d9..077f1f9a74 100644
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
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


