Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB4AF54ACF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Sx-0005uH-MH; Tue, 24 Mar 2026 11:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sn-0005sO-Ix
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:38 -0400
Received: from p-east2-cluster6-host10-snip4-1.eps.apple.com ([57.103.76.202]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Si-0005ru-1C
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:36 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 2F5731814D07; Tue, 24 Mar 2026 15:14:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365265; x=1776957265;
 bh=vnPfBYcDBT/4rVJAt76jW+6cbBD4K0JEvtoQvDJO0ok=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W+4ZoD66UhJ+PhOmbK+wl2+6dqCZQ7v4ZsjvptzV9/j821KzV1b3y0Hr3I6t7eJ6iIdSp7Qg+r6qEvbD2Rdvhb1dFh3sIKrno6kuuCdK0ZCjQJXZ4GWHD+aVoqgOwuZyFdxf5GUXUpjn8puA0V5+X2NAtajtmjeZOGdwDPoUhhTPjsYQ8o5LwlQUPUrSdXOj10gee8BlN33It6NlNObJovNpLxF5bfk0ACIXXjxuLf9LC4M/L3vI16lTv6JPLRAnCNsEBxT5+a4khmBvxIVAkgahv1fVmVLdNqz+LSMg2qd2GuwmRTUJdpwWp956/WrrNAn/DoCOodozGtpB45SNVA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 D55A41803111; Tue, 24 Mar 2026 15:13:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 03/12] whpx: i386: skip TSC read for MMIO exits
Date: Tue, 24 Mar 2026 16:13:14 +0100
Message-ID: <20260324151323.74473-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX4+iwpE9tg1Af
 5EIE4cjH5JqGPMLTzinTw8mZszp1Sx7QkFwqNKuyKnzjSW7WRvJqvNdW+aekZ+V0G7P7l9sddxK
 wgdG72inl8vQjjcjLx96AsKcnrIqbbODIoAqw6eju+jCwG2aArqoWclYdC23VTyX2fThEnZ5X3r
 fNb2tSZzbkOUM3x6DutL907OMi89bljl9NBzBHYAuo3DTGDRKyODY5CSSugHgtdyeP0U5j5RgVW
 L8AayRWc4xRQbjhTUN7587MSs7VRn24h/tYfw3DQYM/3c3fmIP5Py8BV+hlR0S2kCo4n4ArRC2V
 A+n8UJfL/KHVwKFtBt5UqJSAo+0m+8EIFcl2o1B+Xe9MDfjqIzaW7kHO/yAUHA=
X-Proofpoint-ORIG-GUID: YLyBrrgwEbDDSfhbKv8daJD4HDjhdl4T
X-Authority-Info-Out: v=2.4 cv=Y4/1cxeN c=1 sm=1 tr=0 ts=69c2aa4f
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NP4je1IWzm4tDGSucAQA:9
X-Proofpoint-GUID: YLyBrrgwEbDDSfhbKv8daJD4HDjhdl4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=706 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.76.202;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


