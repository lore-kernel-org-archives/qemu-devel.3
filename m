Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7B1F34C62
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ8t-0005gI-PK; Mon, 13 Apr 2026 11:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8Y-0005Us-Ob
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:43 -0400
Received: from qs-2005b-snip4-11.eps.apple.com ([57.103.86.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8X-0000TH-EM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:42 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 0F6591800133; Mon, 13 Apr 2026 15:23:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776093820; x=1778685820;
 bh=dugTy6Mycl0V8PO55M7zjkrIKW6irE2gkRf+Eg5CDxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CEPPCoXh7OPVwFaIF/c9LtjeZe36QQoXMujjEr/CcFAkArhnUZWZoZNKg3CDf8mFkh2N62guUoLpbhSldUvUtYsLTf/rC+4+jEtAqWNQD0uYv8/B9YP582qgtAkWnW58ob3y3FzoINGM1ztXWXECkSGfB+AjeHiMktUsBHj9YeHDURuj9I1OwWBI3rWMMYvddGvW8Uyu9ORRigDQ4Ad1NGVLrnnhy0xyPcKgCpHu+z2LaJjWAStlo2RPat+Sw2omQqR5qWBu81ObsT5fIdIxRASrdRhEgVDcFQssiF+jvTJv8lJUEZ8uU0ADE9gUer+UUY+3uTApVf14Oh+W+x/fiw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 CAD171800111; Mon, 13 Apr 2026 15:23:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v10 04/14] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Mon, 13 Apr 2026 17:23:16 +0200
Message-ID: <20260413152326.63738-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413152326.63738-1-mohamed@unpredictable.fr>
References: <20260413152326.63738-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: e_sSOIKC437JNvMUbHuJ0TW8oJBH4SPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX9bgHxNapknnE
 KBv0/Hj+SSS2Xjuh4jh+cs4+hvvSkyBRqbJeEPGyRckHJaa1Xb6vQIaqlTsc0RJ0U5yGjXKOvnU
 Vr/RX6gMRH4VLC8i51wzyM1GwMU/XCCxcHQCU9Ire18jNyjO2hUmX6EumW3aB3SA1JMBTaLLL+h
 idmflseSSJyfJeibi94ED3bZ6WLfkz8plhZ5ipAxRlVbb15HcM2xVJGQ4hJzS/gwnZu6ZYJiyBG
 szk82D65XrEqWbiMIEu2JnikROklSd+wZdoguRKFhI4WrRWM0lV/mRH3SI4YPTIodLrC7YwiqZM
 2e0Nsm5acibJ3mK5PF5SH+T1BkCN6kUVFmOLIbXA1UOXHkGYJoDKHWm1l1RYSQ=
X-Proofpoint-ORIG-GUID: e_sSOIKC437JNvMUbHuJ0TW8oJBH4SPG
X-Authority-Info-Out: v=2.4 cv=HdsZjyE8 c=1 sm=1 tr=0 ts=69dd0a7a
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1030
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130151
Received-SPF: pass client-ip=57.103.86.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0908dfd134..66f263558f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2281,11 +2281,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.50.1 (Apple Git-155)


