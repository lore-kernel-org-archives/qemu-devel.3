Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D1AF34C62
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ8t-0005gK-TA; Mon, 13 Apr 2026 11:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8k-0005Z7-92
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:55 -0400
Received: from qs-2005b-snip4-7.eps.apple.com ([57.103.86.148]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8h-0000WH-5V
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:53 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 52D4E180009E; Mon, 13 Apr 2026 15:23:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776093830; x=1778685830;
 bh=zcmYD8sBYnUVL4imQw8BkyvhG03VGFAjf3wzcMF8rtM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Adyeh4NfyAgViKt453C0tTDclfCKyQM+GTM732ikFqb2WyDUon8HAcT0MoZrZE58bgGsz1GqJA7MdSrQVg/UoXkX6AKj1xF36tNgyGj1S5/LN4hjtZ2ceHgjG8jDOBcti8naAmVtDZ3fjUKPWeAhquQ+xZ9qW4VbBIl+auZnYxcnGIewn/RSEyhG2ubn09Oykv394R7JChdIYq9tda+kHtRPNNPdFHDOqtnY3k6p1oiglSVsn2uwRajiEQkTB+0MOqXYcDaZPBzI+dz+rmZEkWOvOtZ1SxGluvFulN/xzdpk48e3nbqYt1v3sKe1pSUIQhgjW/O64nlBBlYgrqo7rA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 C765B1800110; Mon, 13 Apr 2026 15:23:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v10 11/14] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Mon, 13 Apr 2026 17:23:23 +0200
Message-ID: <20260413152326.63738-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413152326.63738-1-mohamed@unpredictable.fr>
References: <20260413152326.63738-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IomtRxvvHBFy-ayAdQPaVgRnqam3McJY
X-Proofpoint-GUID: IomtRxvvHBFy-ayAdQPaVgRnqam3McJY
X-Authority-Info-Out: v=2.4 cv=QKdlhwLL c=1 sm=1 tr=0 ts=69dd0a84
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX3cjP3fTcvClk
 F7N84gVBTHTP/jBI38d3D3cZnPpBKcgdeWp2yc5X6s3qyJGrZpwlpcK3sOO0daBpZp2pk9SJMUb
 nEqCAi+Yk6wZ2JMLlU2michPgPQZ+jPFDPXVEbGdYRs9JIrqvQN4+GCSzA2Lq54ovgI/zkUQBqe
 bw1IHC81FBu7Qw/ehu4xQZWVyMvh4Maa7Aewd6jSFGaqThb2n6BEVBGP1iubVOb1tbfh8kW6BNf
 ys4CMR++e85GmgG+sLkNEE9UFGYRVlnIKiSGmQWbCPmlRsShs2NzCA/D/nXy6PR5EVC+V809dUd
 7HV1vYKgIGcPtH2uyH9iBrsYRKtNRz6twq/EtOCg6UC6OF+w5QHyw3zmkt2KAo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=783
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0
 bulkscore=0 clxscore=1030 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130151
Received-SPF: pass client-ip=57.103.86.148;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 61aec98e66..7a31dc6427 100644
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


