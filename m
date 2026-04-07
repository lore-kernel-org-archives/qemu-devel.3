Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D815FFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWg-0008C5-SV; Tue, 07 Apr 2026 14:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABT6-0002eY-8o
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:15 -0400
Received: from qs-2004e-snip4-5.eps.apple.com ([57.103.84.48]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA7GC-0005Ae-Dd
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:18:33 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 C2AE41800188; Tue, 07 Apr 2026 14:18:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775571511; x=1778163511;
 bh=zcmYD8sBYnUVL4imQw8BkyvhG03VGFAjf3wzcMF8rtM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CN57hilbY1GJPkzfag4TT6/NuPL27CUhHWsSCAzmD3asj7YndgdZK3/lrCMpxA8iGx5ejO5RQ9SkQKnu6JD7dLCx4UxfVA1goK/4ByQfQ/McFmM8PJ4nyOMtfZG9S+PPXk691dl7AWVO/YTUd0pn+vwsOoRNf/H3RWHpDyJ6ICoEauH1MEMTDlHoeUkIDiaAlJu7Zw7nhNqgi7GoVUAkXmu4o07ifpLmZSTw0HxqF176Ber3qnhvcpO6hGfSRFGLm0KUo8G64TUwwsQO3AtrrL9en1XZnOMK49IXGEQZvib9N8cw3nYF6abgU49gE9ejHlrYg08eWWrJyZBAbJPElg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 BBEA918000A2; Tue, 07 Apr 2026 14:18:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 12/13] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Tue,  7 Apr 2026 16:18:08 +0200
Message-ID: <20260407141809.16862-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407141809.16862-1-mohamed@unpredictable.fr>
References: <20260407141809.16862-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=F55at6hN c=1 sm=1 tr=0 ts=69d51236
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzMSBTYWx0ZWRfX+vyQVNrQ3fPe
 AnZfqq+5XhHGqhMDX6N2ytkSDo3f0NaM3nJGgeOZjW7Ay6XqFegINgbh9YeJ5zkW6DHWYgwlfNS
 oyhwAp+HC7RIBR5dd+9QkxVQp5/un/u7Dmeo1t0/ng//xP3jxQruPlJ4Kr8WEm4A6FVmFrmY9f6
 O0CLoCKa98vrs0XKvjqffbtxmLQQErLJXisASFXyrsZxn7Wbk9gQT8M8u6TKjBnQf20sf02PiON
 D2vNP58haNFmeSZtEkTJTPUGuouIxd+0CA1liMJeLF9BUPdwjnK1HYHCdhe2FtPOHPPfnpPjDS9
 vDKpuSq33ziiJ00OELNr6c9Lc4FPTavFYrsw2Qy+nwsY4oy19kPh+C9zuKdYcY=
X-Proofpoint-GUID: V5fibUAqVqortwuEGVvmGpmf9QU3LAIi
X-Proofpoint-ORIG-GUID: V5fibUAqVqortwuEGVvmGpmf9QU3LAIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=815 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070131
Received-SPF: pass client-ip=57.103.84.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


