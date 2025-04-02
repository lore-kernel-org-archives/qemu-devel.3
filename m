Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29EDC36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyWb-0000Ot-8r; Wed, 02 Apr 2025 09:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1tzyWQ-0000Fa-Nm
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:52:54 -0400
Received: from qs51p00im-qukt01072502.me.com ([17.57.155.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1tzyWL-0004dD-Ke
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=lkXiGighcJ8+bbnijQikkTSQRXMcE6kockK6lex7Is8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g+8/Bl2W3l7pJlrCmu1jZ0TXPnWGHNRw/xE2ZGeirc2TLbDor1s7ez96SNLOn0LdG
 lPys7hVOlv/V0p+8ZQISV549Ic273ySbjm5GVyq4JMm7FPWezdt8G9fnLrYyprTGQw
 Sk+XrSK7x+5UaqCEhTvRl8E76V8KL+5AApayNlbvKKWpy4ILzbxzjlYIVbN6ADJEI5
 eeR0Mdu0IvyXGD0h6ZcuUxpxVSXGq0kZfkQbY4/lHaH280x6ojgAarYBisGa2Hv3gj
 /N96CsaCY2eb+SANcigIqVVb1uNw9WlV9vty7ccW2ZPD9wlLsomTissF23c0ydqHXW
 H2nQCaPsoAbPQ==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01072502.me.com (Postfix) with ESMTPSA id ABBF96EC0164;
 Wed,  2 Apr 2025 13:52:40 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <m.ynddal@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 2/2] hvf: only update sysreg from owning thread
Date: Wed,  2 Apr 2025 15:52:29 +0200
Message-ID: <20250402135229.28143-3-mads@ynddal.dk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250402135229.28143-1-mads@ynddal.dk>
References: <20250402135229.28143-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _OkLlTlaorrSXTUR8_AbMX_3e-RPcZ-M
X-Proofpoint-ORIG-GUID: _OkLlTlaorrSXTUR8_AbMX_3e-RPcZ-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=712
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504020088
Received-SPF: pass client-ip=17.57.155.15; envelope-from=mads@ynddal.dk;
 helo=qs51p00im-qukt01072502.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mads Ynddal <m.ynddal@samsung.com>

hv_vcpu_set_sys_reg should only be called from the owning thread of the
vCPU, so to avoid crashes, the call to hvf_update_guest_debug is
dispatched to the individual threads.

Tested-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 accel/hvf/hvf-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index d404e01ade..3fc65d6b23 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -58,8 +58,13 @@ int hvf_sw_breakpoints_active(CPUState *cpu)
     return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
 }
 
-int hvf_update_guest_debug(CPUState *cpu)
+static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
 {
     hvf_arch_update_guest_debug(cpu);
+}
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
     return 0;
 }
-- 
2.48.1


