Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E39EF99C9D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEEc-0006EC-2T; Sat, 18 Apr 2026 18:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEa-0006B7-DH
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:52 -0400
Received: from p-east2-cluster3-host2-snip4-8.eps.apple.com ([57.103.77.229]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEX-0004uH-FA
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:51 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 7719218000B2; Sat, 18 Apr 2026 22:33:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551628; x=1779143628;
 bh=oAkt/0X2iO3/a4xMYFMpgz9ibOxymnsHVlwLVxvLdU8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KVy+KVNEk6NliTfmwz8/cdjHI5v3F1WSwsofUYkrQx8HFfsehf5j7d1HoLxyS7rzag0X4Ag/MkVtrclkYLQ+pVRuOtXWeptOCv85HOCJAl/15b0u4BwDmkJmr3aCiEhO6WuOzZyutpu7UbJzlX2/y2bCB0r139sWikqQzTjkA5pFyyuVyMC2ZhsMr3wwAP1mk9ugEEp7MB90pS1r5X2droVNST+v7xEeCa/pzhq12g+pUthzuf8nA/7PtEXCWl38ZuTM472hPj+b/bwrTodAcU2kxDL5t6k8cqyO1ls4WhAqfsjLJAcA4EdVxcifWfO1Sl+z1LGmk644UmhgitRF4Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 5E0181800238; Sat, 18 Apr 2026 22:33:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 12/38] whpx: i386: disable enlightenments and LAPIC for isapc
Date: Sun, 19 Apr 2026 00:32:54 +0200
Message-ID: <20260418223320.51330-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfXwmVNFf7K1e+I
 NenzSUQQ4oWTwFBanZNmD4INnlZ65fvlvwh8ioW1fd7bK+DLzifkCP9LsA+OOJV8YALu3f/h0j7
 sbuCbDUrO3uFuZH6Qup3QmskMwq75sKoj0/gMT9RzTRSOYsvVeifTgq5cODiJZPG6oC6ipSDWUW
 q4qaEMeyBJHE36c+ksWLl3QnBrdPtrZyTS62/VCpRUfEWGLOb09Ox14mL6a4YjCv+0L5ib882Se
 NPavjrplfcQBvs+E88EpozpAYjD9krFSlUkIQyEfVi/AONLzs9KtMoiA49UaZQNQ9tMEHDoPma1
 rrXEQ5jA4j3IRe5qLYJxkXJ3a5Rsf+Htke7Yr5v2wnwgbs3SsiIC7MwTEQVlyk=
X-Proofpoint-ORIG-GUID: GP6nFPvUdfyTmlR7fKenDHqNKTmmGWVI
X-Authority-Info-Out: v=2.4 cv=KJ9XzVFo c=1 sm=1 tr=0 ts=69e406cc
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-GUID: GP6nFPvUdfyTmlR7fKenDHqNKTmmGWVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1030 mlxlogscore=890 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.229;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


