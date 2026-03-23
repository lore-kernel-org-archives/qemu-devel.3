Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88602F4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrK-0005x6-Nl; Mon, 23 Mar 2026 18:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrI-0005wu-V3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:52 -0400
Received: from qs-2006a-snip4-11.eps.apple.com ([57.103.85.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrH-0002vQ-Kd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:52 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 67516180012D; Mon, 23 Mar 2026 22:34:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305290; x=1776897290;
 bh=vnPfBYcDBT/4rVJAt76jW+6cbBD4K0JEvtoQvDJO0ok=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VWTOEJBAZWsT4bSFEJj3fGO/3aHn7nkpOomkHVLDhdx30n3dwOnBxZHQsggt0n3PVI1c2OTkX4NGIf6h70bgapzAa3nwiZfCvjUvAZu5lORSrnspP85wx/U/C+clpLpEO/UfDQObdN/OxESICnpt1pP+d0fQGVaNUbS5Kmiv5uFYtHMfOtfnPqHU4bFiR2I9k2ASlH45TNL3/VjZvuAnn7nXdOYRVKYa4kZ90nKLVGkf3i6Rsm9toJ7Pu6Hfqo/8KvXmn8UK1ACJ6luKOJVzfXHGhu7MxuVloZ0hd632YqxH2IdCY0jwkVf4Ykue6Zd67oYVjpmkshJxdfq7Sps78g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 81E58180021E; Mon, 23 Mar 2026 22:34:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 03/13] whpx: i386: skip TSC read for MMIO exits
Date: Mon, 23 Mar 2026 23:34:24 +0100
Message-ID: <20260323223434.81780-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NiBTYWx0ZWRfX5kp6IMH1RL8W
 cZNH2IYvcyS1x7n4lCnACqZ8ApXBPEt5wuoRZLnPYXhihF562gRjnqUQFOEQUqKxoPkEH42WfZU
 X157N7d4S6Cvj0MHakXfnmpoPp/NrYDWeYX3dvzPjBbZ0Qiv8qa8/f/+S6pPXhedTi8fckRmouk
 /dr0ji1t29kUj7NysASVr+QijU40cbTJGFfemdmb5iHbvGRcDhqjW9dXsh7Zj4wBex2uZ26B699
 R7eynaoRNCXGUPd+ljoaWA4XwxqR4YIm6NirgNQe7MCmbKqIxBR2q2mM75Dxx4hVpro39t1by/u
 P+xPiQrErrPVv6I9X2N13GbTu8r8Fu8v4DrWD6TfKbmsMrqcltRo9MWJ9wjoY4=
X-Authority-Info-Out: v=2.4 cv=CsOys34D c=1 sm=1 tr=0 ts=69c1c009
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NP4je1IWzm4tDGSucAQA:9
X-Proofpoint-GUID: EVHpVAjYRaf25WIObVqSuEXa92CHreeE
X-Proofpoint-ORIG-GUID: EVHpVAjYRaf25WIObVqSuEXa92CHreeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=676
 clxscore=1030 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230166
Received-SPF: pass client-ip=57.103.85.141;
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

The TSC value isn't needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8f1835ee95..ac03445d9d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -606,7 +606,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    if (!env->tsc_valid) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && !env->tsc_valid) {
         whpx_get_tsc(cpu);
         env->tsc_valid = !runstate_is_running();
     }
-- 
2.50.1 (Apple Git-155)


