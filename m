Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39188F557FE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6Y-0007JP-K5; Mon, 20 Apr 2026 06:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6W-0007FF-9W
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:48 -0400
Received: from p-west3-cluster6-host9-snip4-6.eps.apple.com ([57.103.75.89]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6U-0000et-Tk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:48 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 D057F1800451; Mon, 20 Apr 2026 10:43:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681826; x=1779273826;
 bh=shO+Mw/9k0xyNmUmIAPxgO00PEUmcfuq7ZIwrGpWZBo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NCBBg+/i1VrdTr2Wl/nRuZP8CDUUhwgqxRh1QMxiYtbCjJajg9tVZeepbXlooul4Jd314+60OfXf0QqWnPDDJXL/vTOcdysPv7l6w8dQUl/UJphkJBx+Rl5I20lldlkCK2N8dtHuucN8fbzm1jNpyIrc413/LVh0lSDTTnN9/ry9krn2HIzdT0LXV0tW/2B6nrPP6rSwFbMSuXzxVWxuxpaY77h4q4nkc0rnfUnYih0M9CKEsMI5cued/C71YHS2YSH+qs9IF2SQrFUaNX1Mr0iP3gwBNWecmscsjpsEiqh86YMJyWQTsI2HmSvNU7kWCcMqbg1ia/JbjDK39fXwzg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 3A08B18000BC; Mon, 20 Apr 2026 10:43:41 +0000 (UTC)
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
Subject: [PATCH v2 20/38] whpx: i386: ignore vpassist when kernel-irqchip=off
Date: Mon, 20 Apr 2026 12:42:30 +0200
Message-ID: <20260420104248.86702-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfXxXZDVTjV9PDw
 AzFXFt01KBczUo966IMt8gD8NgpnZ+r9XEkh4+iyCA4fz4Z0QlIbjbXViXMbMgznwJyYeLvZ5i1
 /3Yh8xal579oDkg0phx1AvDGw3Yq2/JAQR4m2hoHyICkCJ8JHpM6TKu0ohGH2l3XgTgJXb+rTot
 bHT87LalwIwkg/vMwNmirBtpgyWliP3F/o29eauYwLhDJdNC8uxW/QSaeUNRhKWhd3f8LsAvs2o
 8GzRQ3ZXa5hAnD1gxpqbljDF7Inbltx/V/NIrRR8mlCuG7uJqwl0yLPOtuW0MIEIWFo2nxxdd/g
 5O16qEzTkFQN3Dx0NnLNq5BBrGG0SxxJU1l1vHKbvHmR7GIUakj6WbDTDs2eYw=
X-Proofpoint-GUID: L0hv3xy8QT-c52lr9bVOXfFmy1Idvtek
X-Authority-Info-Out: v=2.4 cv=CeMFJbrl c=1 sm=1 tr=0 ts=69e60360
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HmN67jXOOwgiugJlUbgA:9
X-Proofpoint-ORIG-GUID: L0hv3xy8QT-c52lr9bVOXfFmy1Idvtek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 clxscore=1030 bulkscore=0 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.89;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index f31eabce37..3af5f936d4 100644
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


