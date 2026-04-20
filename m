Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3ECF5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6n-0007z7-4E; Mon, 20 Apr 2026 06:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6l-0007pA-Oc
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:03 -0400
Received: from p-west3-cluster6-host4-snip4-1.eps.apple.com ([57.103.75.14]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6k-0000iB-0c
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:03 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 B77A71800474; Mon, 20 Apr 2026 10:43:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681840; x=1779273840;
 bh=3N10hCGUapdzhuKA3NU8ZhsH65avZvazfJzRL/H4ESk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NXyr/s44izelOMuWl8Ttey2HwhsAEhR/GVqgodBKvo0VsneXCrMpmnvvP1Sv9IRow8mg53WrgvFnj3AX+XEZ0501Gfnki37Wrz8rnbJZvB7jotrKxz0++GES1scq6COOT+2KeMFOeAHX+Vvuu5i17V2Pv4IguW8jgloe7Q0vYwkSFcNSKIAsIiDXypxkSED0w6kwjwTve64vC5SsJiaUnrSQa1Tzbl2BQfzbFpE69srjc5B6prAPyTu5PWpHCvNPWfoRZa1QZ5K19gWJkosC2QQARumH9Jc5Nds2DZP132n/xgoH8InjsMVHQ6C5KCN8x9ZfwBtiSgGW7sds6V/STg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 25AEE180045B; Mon, 20 Apr 2026 10:43:56 +0000 (UTC)
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
Subject: [PATCH v2 26/38] whpx: i386: Pause VM on fatal exception to be able
 to inspect state
Date: Mon, 20 Apr 2026 12:42:36 +0200
Message-ID: <20260420104248.86702-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX8TH5H5JbKpLw
 Avsi2elB4AoM8nz1+wWJPIXeBKD16Hh6JIxmJdVXA+hsF4FMycUSC0bGI5AN4raQUgn6xYoEq5Q
 GE/ziop0o3F2s5yKfZ3TltZDhGe1FBOzjvQ/2DV8iRjMi/k8Fvzje249g/Mv/tUFZvW3LTAC/TB
 +g5CvA/7gZwJCUpcnaq4ZsVdtLfEKeUvbxSP19PJqANqcPnEgzxi83rUQ7rA6GkVHkX79tC0DlY
 9q1QEy2NX9jUY0a9vCjuTIjVBGsld04Rv1hCJiExU/iTCDToR8mRrWAWTeh5kjz/FpgeVKtMlBH
 uQCuGtx4HxGBZr72KStwM0Q6epu7Cfgladjbu7nsL7Ellf8lccVy94biO5elvs=
X-Proofpoint-GUID: mgceeyAzTnvKd9DTkjYzRUEf5xShhGwS
X-Authority-Info-Out: v=2.4 cv=CeMFJbrl c=1 sm=1 tr=0 ts=69e6036f
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CGn8axfqn9I_s65QuTEA:9
X-Proofpoint-ORIG-GUID: mgceeyAzTnvKd9DTkjYzRUEf5xShhGwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=795
 clxscore=1030 bulkscore=0 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.14;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a7282eb96a..dee2a203b2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2310,7 +2310,7 @@ int whpx_vcpu_run(CPUState *cpu)
                          vcpu->exit_ctx.ExitReason);
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
-            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+            vm_stop(RUN_STATE_PAUSED);
             bql_unlock();
             break;
         }
-- 
2.50.1 (Apple Git-155)


