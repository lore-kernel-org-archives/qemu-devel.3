Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B89F99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFA-0006tg-C7; Sat, 18 Apr 2026 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEz-0006Pw-Uh
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:21 -0400
Received: from p-east2-cluster1-host4-snip4-8.eps.apple.com ([57.103.76.21]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEt-000506-O7
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:14 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 5638D1800226; Sat, 18 Apr 2026 22:34:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551650; x=1779143650;
 bh=9xbxyGGfjNH/HWQDHlAQCg/qgFyvlvlu7VNj5bZOFog=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X4DbNyAvhnyc1TYKUBm79a/2cSJtgwwo55QDa7SgyILldWispOxAyn2qtPagGQB8FztkQd0JC9MN+zOfipDvgldkChV9e6pJQb67zHDIN0bTw/yf2+fO0dnTbB2V6kZvcEAKvJIDfwVYHzVOhwQuQpbxKqfc1uMTXYAwoiQauTaKohnSrr0JlQrGqF1Ww9FDEWuEJiDz4ikwh5oY0E7WJjrFz980GsFKURW2SSRWUvdW09cdPV81wcnAEM2ZpmAwejti/61cIbZW0MMXaAUstGNJ7hoNF5TuMS//pi5WUxbQOJXRGU4sh7NsacPSi8RbnDEwWwD2M4D+sB+T+P50fg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 308C61800208; Sat, 18 Apr 2026 22:34:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 24/38] whpx: i386: some x2APIC awareness
Date: Sun, 19 Apr 2026 00:33:06 +0200
Message-ID: <20260418223320.51330-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=N+sk1m9B c=1 sm=1 tr=0 ts=69e406e2
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IZZkQHPJHa8VUPCOrf4A:9
X-Proofpoint-ORIG-GUID: rhbC89PkxUdCKecS-P4BR2gsNUj_nxov
X-Proofpoint-GUID: rhbC89PkxUdCKecS-P4BR2gsNUj_nxov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX75BrXgECD2fO
 5eLJewz/WbMwPoo/uogEDtfwlJlI7tpv5jkV2pSX14GMFFnxGdi6nJw3pSyYSuxwHFnC0wp2QJD
 1bVEgogIQpt2ECYtjRGZN8zco7lrYHjUq/jEyCxydSp4w5zVXngogHVgIVwtPBlzd4BA2nMpGox
 uvZRQL0DqMrc3YHRjZBz1nu1m3IoN8WPtXbGoAsTzeTjnL9iKRz6Wq3CZqFa2GYO6eV7aN9Czgr
 IfRMoztQGAUrZKp0YoK9IbAfYy+4/jGiy5Ysr/kOjSMZUuGJ8FYr4vfJRmvJidjgaQLdjM3FJ3j
 yOUyes6jUW21r+sNZIS7ZGpTxX9kLETr3gAR0RoNJaId098inDMpaM1/MVE1sg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.21;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/i386/whpx/whpx-apic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 65629ca45f..cc272f82a5 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -33,7 +33,11 @@ static void whpx_put_apic_state(APICCommonState *s,
     int i;
 
     memset(kapic, 0, sizeof(*kapic));
-    kapic->fields[0x2].data = s->id << 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        kapic->fields[0x2].data = s->initial_apic_id;
+    } else {
+        kapic->fields[0x2].data = s->id << 24;
+    }
     kapic->fields[0x3].data = s->version | ((APIC_LVT_NB - 1) << 16);
     kapic->fields[0x8].data = s->tpr;
     kapic->fields[0xd].data = s->log_dest << 24;
@@ -61,7 +65,11 @@ static void whpx_get_apic_state(APICCommonState *s,
 {
     int i, v;
 
-    s->id = kapic->fields[0x2].data >> 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        assert(kapic->fields[0x2].data == s->initial_apic_id);
+    } else {
+        s->id = kapic->fields[0x2].data >> 24;
+    }
     s->tpr = kapic->fields[0x8].data;
     s->arb_id = kapic->fields[0x9].data;
     s->log_dest = kapic->fields[0xd].data >> 24;
-- 
2.50.1 (Apple Git-155)


