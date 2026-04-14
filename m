Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D3F9D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPh-00069H-3s; Tue, 14 Apr 2026 14:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPR-00066X-CG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:50 -0400
Received: from pv-2005c-snip4-8.eps.apple.com ([57.103.66.159]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPP-0006UV-SF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:49 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 7A36618017A2; Tue, 14 Apr 2026 18:22:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190966; x=1778782966;
 bh=aHWbpBbWHa1pDSLj1H1tPnDt0duRVaN6KSal90efVe4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Qb6rj1lBiQ/fdp5uLcQDat9lsIv+cNCd87KS0lhUkjC+XKe1dnpYA5WjxmxhwhQBGCH5lwonCc0GcXx5z5Dhgm1mfBWExY8HeGo+BVSE6Fpf2eHoCuevcXQPChWeCtUDIpM7sHbdHh+mqUVKBaO0VIyOAUZq56zvsu01PGmJcZBmZ4PzFhupx923bkptehA8DngYBS71BV6jBITQZ7otrerF+GFhnruSkOIfaX+1uHYYFkOSbhb4fajCK2bBupxf8QGaSvOfDPxkMJMldI3tnjY+I07jt0LhLAucamWdFphtQarWgBkOXxabNF4QjT8D14xDPn1+PF4OxW0ovlqLsg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 8A90018001DB; Tue, 14 Apr 2026 18:22:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/7] whpx: i386: ignore vpassist when kernel-irqchip=off
Date: Tue, 14 Apr 2026 20:22:29 +0200
Message-ID: <20260414182231.18776-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414182231.18776-1-mohamed@unpredictable.fr>
References: <20260414182231.18776-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=c4GmgB9l c=1 sm=1 tr=0 ts=69de85f5
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HmN67jXOOwgiugJlUbgA:9
X-Proofpoint-GUID: QPG1F_s5cYYfRUAsDQuBJrokPb-16-MJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfX6kukinN5p/0H
 x3+9bBgOCuEvOQnUVQgu1MZ7OiS5dCwJUH7SjZ1hcjLctr8ihGMWa645Eok+zNDSAIga8uUKM6X
 U4MXogQDE2vm0qdJRtHndeAUGqQQ3ROyDmzJCqEvGm7o/8KvmP+QMuBJyOOvYb2YwNKnGALgSxA
 aoWN/wW+SRiAi22OgO54VBq6nQIznWXmdYCG3/zS894ARqPPi695uSNuxqsXydGRszo/vxI/Rpn
 Nv4pBdhLIXDPPyDOszszaj8unY91AylFxu0sHl/nv39pzcBJ+2tvKIO2McJBhc4MWOsOrsErTX+
 FvO4O6i7ABUPi7xtnALasZwh+0FNE9GDjImu8olFi9MGx97Oauf6l0mPYpC2VQ=
X-Proofpoint-ORIG-GUID: QPG1F_s5cYYfRUAsDQuBJrokPb-16-MJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1030
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.159;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

Linux tries to set vpassist even when none of the enlightenments
using it are available.

So ignore the page it sets.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6c39168b06..2e6679f40b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -51,6 +51,7 @@
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
+#define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
 
 static bool is_modern_os = true;
 
@@ -2033,6 +2034,18 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                 }
             }
+
+            /*
+             * Linux tries to use it anyway even when not exposed. 
+             * Ignore the write as the VP assist page is not used.
+             */
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_VP_ASSIST_PAGE
+                && vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()
+                && whpx->hyperv_enlightenments_enabled) {
+                is_known_msr = 1;
+            }
+
             /*
              * For all unsupported MSR access we:
              *     ignore writes
-- 
2.50.1 (Apple Git-155)


