Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D5AF55808
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6M-00076F-Dq; Mon, 20 Apr 2026 06:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6D-0006xd-BZ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:31 -0400
Received: from p-west3-cluster5-host4-snip4-2.eps.apple.com ([57.103.72.35]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6B-0000aK-LB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:28 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 2E58F1800140; Mon, 20 Apr 2026 10:43:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681806; x=1779273806;
 bh=oAkt/0X2iO3/a4xMYFMpgz9ibOxymnsHVlwLVxvLdU8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gZFvQfOtTG728Aiqh3Pxs+7eq2aA57ZZU/Egy1Y+k7Ux9i+eKytga4f+WS6bmGIdbIRFog5+nqKeEw1gEKIvBpyAhQG7u4A7Kc6zrPjTxvk4B77aGecuXxijBV6MVANNnuZqst74pR57zqOywL0huNJEiUxAgiZnUOA1/dhm86wN6/vSOy+OlT0It6YfsKUIYA58grHWh9PbLsTdI1Ny7Y7YfKyIYteTG8IraDGWuQkWW+ePC/Ppr9w9KbIBIoEdSrwZcws0aj7DF7GH8SymAS7VJ4/WD9hj8IcvlvA5v+BXT7k5AfJVPes/C3zlpFxT9IuGrm/t1GTHXd+jWedu8g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 5E0FA1800442; Mon, 20 Apr 2026 10:43:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 12/38] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Mon, 20 Apr 2026 12:42:22 +0200
Message-ID: <20260420104248.86702-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfXxjvbCepagAjn
 ZdMVIr4oj3Snew99sTCdX+R4pAd8RUzhrxURYc3GAKlwjDb6npkQeOi4ux+CRQZrldl3UY45Bhj
 8M5ilmpJ8ayKheufeK8rEpR79gxizl7ZkahRX/gJt2euzblbYPP5hUr1IKZiUMbPu4AQmHUL7JS
 EtjY45v8xrSxYQTnjX2Aot/IBCPzTCSl4u5ilElkW6B05XmeAMocSq4Ptu1FtswIIKDOzj+4iAr
 bnHvSdQbxnJLH9G1Nw9xJO6Y6vDQuihnMT3sqO/tc5KzP3fy1N5Zf4yPbYctP2QIDz1kMaOZT0H
 T4VH0zE8Kh6qd5iuOSQlXba1jMsI7xTqE/Ao3DyDYjH34x/JmhmOcWz6hjRrGw=
X-Authority-Info-Out: v=2.4 cv=Z+zh3XRA c=1 sm=1 tr=0 ts=69e6034d
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-ORIG-GUID: dHfS9Sf_op2BC3kfYYMOpZIEm8yd27jN
X-Proofpoint-GUID: dHfS9Sf_op2BC3kfYYMOpZIEm8yd27jN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=891 spamscore=0 phishscore=0 clxscore=1030 adultscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.72.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4deeffbcfc..d38b83d274 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2470,6 +2470,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* for isapc, disable Hyper-V enlightenments and LAPIC */
+    if (!strcmp(MACHINE_GET_CLASS(ms)->name, "isapc")) {
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
-- 
2.50.1 (Apple Git-155)


