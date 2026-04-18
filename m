Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B86BF99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFF-0007PU-0Y; Sat, 18 Apr 2026 18:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF9-0006nq-6G
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:27 -0400
Received: from p-east2-cluster1-host8-snip4-10.eps.apple.com ([57.103.76.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF7-0005Cf-Iz
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:26 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 BB9DF18000DA; Sat, 18 Apr 2026 22:34:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551664; x=1779143664;
 bh=AZNfvHRegyH4f70Ia13TlEC2emrhVTeWmibfHx3edKk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ejmpLXt5qpvauUoKZ6uumWxTk0cpeURi9zK5/Gf4qk0Tg68cmKGRFGYE+8nk/8wilksVYZODvY1UerE9/T4IXDH5DMfjvfoojG1Brt9e+L5yFu06hdljjBdGsTGu8g3xx9tspeFtZVUKVxw27YtKYDu5eU26szeWq+gScbGqsywiESe8nXbiRN5L2/gr1D5ghJrLPlGKHwlosaA141z0ToA/wQbNwt1E72+OMpqH/AHa5FPUhffx90zS79MY/afujNq+8V9PbGdrGSM72BSEQ+t+zLW41zOIUsTYrGGDxAFugIFlQbr3A/yQVACF+PFr23j8v692I9h8Nc4Y2kf+0A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 D4CF118000B4; Sat, 18 Apr 2026 22:34:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 32/38] whpx: i386: set APIC ID only when APIC present
Date: Sun, 19 Apr 2026 00:33:14 +0200
Message-ID: <20260418223320.51330-33-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOSBTYWx0ZWRfX9BaruJKWq7+I
 2TW2AX42esNfValEfAnwoBPgME4lDp8mvwzr4ZEkhOITCSEdGoFHI5uFLE9Ggaal+XXJp/bcnj5
 4z44e6G3Ingj/9dvg+P7flqcjXHNWuAdfg+xNGMfJd7FGH1iJXlgYTVYXUvBFiLZBclDKegfRNg
 Y2um/N1mz/wm5wlajTdE5Tm9diV4mo8f0SNxrm14++6/Bi2Zsllo12HVWY4HDBQQ+yeL/OFtyYA
 P5XmyHEdDf/mJ/EHeL7+p27Rhia3nDCl33ACKIWRg7SfyolwnkG8CORu/ILOoRh6pOPD21mTvfO
 6W2rSaG0d/AnO0bOn56x+0EGcq5DwunjJmFuE4psIaS3okRY4BUSQnDXQNen4g=
X-Proofpoint-ORIG-GUID: 50gl7cHmAjd8bQ56s2IUstAy5Mzs8F9N
X-Authority-Info-Out: v=2.4 cv=ApPjHe9P c=1 sm=1 tr=0 ts=69e406f0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WHe3jrWR342bzmf78BwA:9
X-Proofpoint-GUID: 50gl7cHmAjd8bQ56s2IUstAy5Mzs8F9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=869 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180229
Received-SPF: pass client-ip=57.103.76.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

-M isapc doesn't have an APIC

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cd0bc3d54e..0f50cf098a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2589,7 +2589,7 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
-    if (!whpx_irqchip_in_kernel()) {
+    if (!whpx_irqchip_in_kernel() && x86_cpu->apic_state != NULL) {
         WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
         whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
     }
-- 
2.50.1 (Apple Git-155)


