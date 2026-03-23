Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C322F4613F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrf-00061U-2p; Mon, 23 Mar 2026 18:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrd-00060g-G0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:13 -0400
Received: from qs-2007j-snip4-8.eps.apple.com ([57.103.84.229]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nra-00038Y-QS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:13 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 C02DD18001D8; Mon, 23 Mar 2026 22:35:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305310; x=1776897310;
 bh=Dxuu705L/6pIYAaHnm1Gp8R0fMhxU14YZ8WzsFxht3k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JiWgmap7pzk7yU5djNGeXVKeUUBtPhd87q/ZHVrDZ5QUHehwYzF2iYSmgwuRd5mzwOnmnwt+d5l28MdD7dq1tuA+TsCb1fyfMe3CWbNcuMbHapoaLcEYa219cQwiIB+ESlFTIoRJ5zYQu0Ur1HcD8hPJKxqmfdt9RyVzHEj4jdbOW4DAY4u2BgIJUfbubZUGN0Ts+jXyqjYJnbFLgdBgGJgFccB0nnV5oMWqquVJ+V8wIj8vzAN3kNOjUz43Ih8CTO4c8tPy1FameFgpLkgO+E5YEDP4BmaTM7SZHR+P5EQdQ4t52xxxOV3rb9RrHRqBtf5wky9kzap4QdodwhauWg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 8BA8A1800120; Mon, 23 Mar 2026 22:35:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 12/13] whpx: i386: workaround for segment granularity
 reading as 0
Date: Mon, 23 Mar 2026 23:34:33 +0100
Message-ID: <20260323223434.81780-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfXxCIi+MigNaQ5
 zCu3NBXeFot4hhaF4WWaS9He9K4CwbaDJz2Ymg0X6F1LMD8/3kQMajoFDjcaZvhhjtd8e1F525C
 UzRpABjttNesR3l4WtpaEdQ8DoU7daVyf0DMjzRLUHjo24KjS5SoYWYhfq3QrcjxUxKAgY4mhZs
 CPITW1KypaTLbFvIPWwJfsDpp1DX04Hx5dc9JklBkitR4lieSRxdvTBSqzQtMoNG8aW2p2grWn8
 28n19A7USjagS4O9e9aKy8T1kDjLSKOrrr7ULuurSO+UQwB/WdRI73RYXdRIm6nKqxe6eP1Wneg
 2T4BcZzBHmRk9hQm2Ig9iGUuwPOQH/i1NDO0CXIc+SEv3+VXUskdAAkpJ5ZBHw=
X-Proofpoint-ORIG-GUID: pH32kNvUkBVEkF42WMxL9YDeq3QXANh-
X-Proofpoint-GUID: pH32kNvUkBVEkF42WMxL9YDeq3QXANh-
X-Authority-Info-Out: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69c1c01d
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=_6j6WPEMpVvK3myFejsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=819
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1030
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.84.229;
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

OS boot triggers a Cs segment limit assertion, while
Hyper-V reports that Granularity = 0 despite the
limit being 0xffffffff.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f278a52451..d87afceb08 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -916,6 +916,25 @@ static void read_segment_descriptor(CPUState *cpu,
     WHV_X64_SEGMENT_REGISTER reg;
     whpx_read_segment_descriptor(cpu, &reg, seg_idx);
     whpx_segment_to_x86_descriptor(cpu, &reg, desc);
+
+    /*
+     * Workaround: vcpu->exit_ctx.VpContext.Cs.Granularity is 0...
+     *
+     * OS boot triggers a Cs segment limit assertion, while
+     * Hyper-V reports that Granularity = 0 despite the
+     * limit being 0xffffffff.
+     *
+     * This particular issue is much easier to trigger with
+     * the instruction_stream logic disabled. With that enabled,
+     * plenty of guests boot just fine as they don't trigger the
+     * immediate in CS read from a trapped instruction case.
+     *
+     * However, 32-bit Linux on AMD triggers specifically in
+     * https://lore.kernel.org/20250422234830.2840784-6-superm1@kernel.org
+     */
+    if (seg_idx == R_CS) {
+        desc->g = 1;
+    }
 }
 
 static bool is_protected_mode(CPUState *cpu)
-- 
2.50.1 (Apple Git-155)


