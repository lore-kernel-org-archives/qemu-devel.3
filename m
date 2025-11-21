Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30DCCFA76A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO0T-0005NG-O7; Fri, 21 Nov 2025 05:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzk-0004r3-UH
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:01 -0500
Received: from p-east3-cluster4-host4-snip4-3.eps.apple.com ([57.103.84.36]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzc-0007xX-IW
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:58 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 35E931801105; Fri, 21 Nov 2025 10:03:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=oLdsz5v4xa/tST8knhDRG0xyTMCDKgIhKnyueMWd+yk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=O6pKyDtG5tEotUjJ957+VSKL8nFarX43fq8e0CPLTVvq1A7bCIP1lOb2ByR0bpejgajHPW26bLlKB2Gsb9kSC3nkc07ETGAzY0Ih16k6DXRrrcBcufM8AG9MjZ0Zjve/y9g7bfMZTF0IUx9EfTAbT8d5ihQ/HrACh6X+5d2d0FfrK87phmJJjTMCaVyykcrLOVYtFarrlVVYKl/73hV65iTNApBassuSPk8xouIwQ9wT9yc/0Z6Bz9AdSCbRcAST8go/PwanRis/0VFBPL+WWvKrHtZWwqawsUIyRVhMr3/+mgOrgv3KORnFjQnorQ6Qcs1/FbktMFK0Va2F1dc3SA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 DB3EC18006F6; Fri, 21 Nov 2025 10:03:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 15/28] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Fri, 21 Nov 2025 11:02:27 +0100
Message-ID: <20251121100240.89117-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hfkkwSoQrIgRvQuYCUzo4s92_Yd8yRqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX0KDYxfLO6xNn
 rDGENULSazxlJCU+itB8hZrp6A/KcbFvDuWk6beEZrWJbwdZ59LBwW1M+AwTzNnEmzTvLkFekGw
 zGsGhdKtAeQ9CHooFShbkwc9cJ0c7L35SxiQLRGHpApvPBcfFCVQ20GyQx3CDq53iPpJvOuj5VP
 YTnXBM4aiTo+/4/N+5CfPU/AOkd2Gek3wZVe7J5qhOrmZ1Fqi/4YDsdOPQgzBqXGHn/pWfo1VZi
 jqz81mWGtCCl0/DIUv5I6ZVVyh978XnBLixUSJ6a8MkCHYyxKUg/dxQVZnhSer5dZkYNK8z6AOX
 AuNGEdHM4YKPFOvS1gA
X-Authority-Info: v=2.4 cv=YvUChoYX c=1 sm=1 tr=0 ts=692038e0 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=GfoCO2L6IEBdUbzNuv4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hfkkwSoQrIgRvQuYCUzo4s92_Yd8yRqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=827
 spamscore=0 clxscore=1030 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABEiYBw7KIpS3CifZYY6CjtJKKthbpKeXLNAdWm8/yRjFXth0m9qsGJR0GonjyBPKSFnaco8dtOqDCLdcidMf6u48ILKRwehOOFlq2UajTdMPBxmLQJd1F2FUOvebOtfADo5YW+B0DTLGwufOXiAgYoZWOPnmeu+QLVBPXuGFXL/IjtcHZNHVaTRB8UN6mDood3gnj+2/rqJDdp11GhN0SRWI0af/yCcyXJDSVOqVU0bT2FPMh4W9Ht6Q0zqeoJ4L9w/JxPEcUZOTCYQvp7sSoxwvjtJhOFxcPLigp0mxEUEyw/zy/RQaHWWslGuZcZPX+Q01grmIsaI22ff218WQqX+4oVyAAYXi1PtOWfaLie07lWkHksKKZQibErop3PPCqo3RXJRRpqbq8r51XtcWC0cLgzin1HVvJWkLyLF1vY/RpyaRcVBjoddpIcl3IaS3G9gIKiSor7Z7+rN+yJzh6YVwrybHelzayqo2SwYfjIAR/AHsDxxQoP785r8ICA/sR8I8SJEzOjFdAz4ilbxr36y2CEFpTbCjyerQ6reP1PMSK/RAjmQMQ0tigLViBbqyOl8ZrOwAUnMXaeya9crVWpIjPQ6AR4ntCkGXgNCSNn8AA6525vsi+mWVTB6d8+vVORjYleN2cy3MdT66pVx6O5+sBfwUiKLY5PCNUxhTpxIB4bH9g9NgeLPlKAWAJxhpHwl5cJ0u1xSpr/QdGOwzYsuV4kss+TIXBol4cjGwdeaxHRhSD79qmA54v3f2TZPCCOmjJL2/d5RtwNro5Gfd4Ctg1mUbh/o9Nv7dkxbJUqx8fqhZ4IVsl2uDrrzX3
Received-SPF: pass client-ip=57.103.84.36;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc..654f551898 100644
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


