Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F93F55808
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6k-0007l0-Hd; Mon, 20 Apr 2026 06:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6g-0007XF-8e
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:58 -0400
Received: from p-west3-cluster6-host4-snip4-10.eps.apple.com ([57.103.75.23]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6e-0000h2-O2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:58 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 B3E09180045A; Mon, 20 Apr 2026 10:43:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681835; x=1779273835;
 bh=9xbxyGGfjNH/HWQDHlAQCg/qgFyvlvlu7VNj5bZOFog=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZDboLL+djex1IduTIdz8d49gH5k5FKkgkCssuVNc/TArt80cS7v2HeYvPp2/RL/Eh8g0PNbjipId2Gdx83mfOIo6yWDY0Kwnogi+vSYhYtiEtzIRf/5+ELcYFW5ZtJn5KQx/n3BNrqbYBgAAaYqwy/LMmeVLlrQM35waEnG/T4qCEGDzZGYkNNuOWWTWQZYIJSrPaA2fUEvb47ZGdx+lUy33jo5QOgCrrQ/2UKtDGCVDcWHbJ2UEhD8kdZlSWBwcz4Qxrg6+/zq95RfnSApyEGVP1hxEp67p3j0jRXtI/x9Splj8miTrrLUqxXzPQXZ+WIf+fDF0/crN+rv3ImsioA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 250B318000A8; Mon, 20 Apr 2026 10:43:50 +0000 (UTC)
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
Subject: [PATCH v2 24/38] whpx: i386: some x2APIC awareness
Date: Mon, 20 Apr 2026 12:42:34 +0200
Message-ID: <20260420104248.86702-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=69e6036a
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IZZkQHPJHa8VUPCOrf4A:9
X-Proofpoint-GUID: 88Rl_vVb61SYe0h_4wUCxkPjSJ-cfK2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX63VY2be2Slrk
 ZwiUY3TRWbawwFxFY284uiz8mm+/D8CCQUsUk/n7StXUeuHkQ3Qdt3DNDWpK1JNqpO4CUuDex1o
 L6UXkBo4yqwyZEG0IzRBV2OTGYNpBjpYm6GsDOwM1SS6FK1YBEmcyrmu33Az33Q7u4eOEE5ZRzD
 Ls5ROHlMfzRCmvZ1EmejrgQi1qLn2J2Mb3lX4QP1jueLe41h2HbNg5/oQbTeK5jQAWJUFJ+WTMQ
 7LC6YDCUtjXgmKQRj46TN6Yp4OVyB53S4KgWSjiKqKdZSbd+Vm8PebHaldwwJDf9GdSdxbP0IIF
 8HciFJHm+MYuUJjchI/hpSzDftp2Pu8JMXAgu2hPzxycbHt/kjoYGPEG5tYBs4=
X-Proofpoint-ORIG-GUID: 88Rl_vVb61SYe0h_4wUCxkPjSJ-cfK2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


