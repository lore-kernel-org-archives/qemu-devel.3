Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FC3FEFB7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3Ac-0003F4-Fq; Fri, 27 Feb 2026 14:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AY-0003EV-60
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:34 -0500
Received: from p-west2-cluster3-host10-snip4-6.eps.apple.com ([57.103.69.79]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AU-0006RO-Jb
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:33 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 B6ED91800287; Fri, 27 Feb 2026 19:06:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772219189; x=1774811189;
 bh=gWqREj2PmGRoTAKiY4qI6uX1E9aTXQTeVV/xFA3kCyI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Hkk3/OuhikoQAhN2gF+acMeRdh+9fhSjfYPtyzpdhfdfiGrA48y1MS7dQQMrMdtIB8LuWxPZAQXR9v/S1Nmt8WVOZSRjrzfvrimpJKODO9QmKCUlO7Ej6TwYTQ74mUQqV6/TPkBTdgnModGnZoksF5OaAc/DJkDGWLae6bh3T6PQfLeCdJSzGU7kfaQ92rUEKvcRbQPT8gsj1AWE9E1nNw86Z+uDIKUeUnEYdZId5Yct/PIWFDud0vbYXj7SNhKw6K/4kCEZEvVp7JUYFzE+ZMM9OgEdgAHfwHmDIO5dXnXo0XOM4O9pcv9bwq5QuRLoSyaoH6Mh3wfBXGEetAlE2g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 4E30518001BE; Fri, 27 Feb 2026 19:06:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 4/4] whpx: i386: warn on unsupported MSR access instead of
 failing silently
Date: Fri, 27 Feb 2026 20:06:19 +0100
Message-ID: <20260227190619.8867-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260227190619.8867-1-mohamed@unpredictable.fr>
References: <20260227190619.8867-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MKZtWcZl c=1 sm=1 tr=0 ts=69a1eb35
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=qc3z_Y1wnV_HfSY8uEAA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: RdlcglUIO8SveWwayZMzq63eZgIX7wFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2OCBTYWx0ZWRfXyDRU1yCodTG/
 JCKPrYR4e5RVrCmqTdURW+jKRkyZPyYDYj3p+pXtkmcEpzvvqKZO2GxkLCyXDxVxBUOh2QNH67d
 cQ9f413pShwBYjaMYj/QL2qGdE37GNTdLFx7hh9dlglb9WDuIT8gIFvdh1IMRKnDLWuofmWa/07
 6W05jNvsSQJQm57dNWs2Nqp3rI/KFfoHFc6Qu2ztpFDbwfFd9L3qCTZorKr4pcjnZ/HvszM8nfn
 XbpkGXf3vGZq7MifRQb4Ray6IRAycbWmea3SiQgjOYtVnlvCYQk1wQrNzDsu8F2uWXyNej0qpDg
 bLoLw1zuNaDySJi3Q6TOuKUuLf0DTlJQfsyooJamFC4DMQkyrkSFLycYLBlqGY=
X-Proofpoint-ORIG-GUID: RdlcglUIO8SveWwayZMzq63eZgIX7wFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=682
 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1030 bulkscore=0 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270168
X-JNJ: AAAAAAABA3esUpypvGfnFyn+lf/IlrK95zylnwbRm4hqtW0bPUcq1577HPh2IWdIJXViWeXl0q+ArPovC1DyfXXvspWFk8m4S3kOPMPhT78oV5JR7qQUU4zBMs0FsPMNywEhSwIUJrRh/Vf6O6D1V6ZuBduLa+p31I35C7sZh7ZAJMA9b8BpbkqHRAG7e8qWXZHGs5lesCw3L0JBHbTC9z0PF6FDXc3DDN8F1M9Wie4nVuSZC1xzCqhmyCz40dU5o7OUN071Hu4Guc1jMFJOtRtubpzBZFYq3VNfsO9RPfiiIhJTsJG54gqoIOqHAyTvQq72vjnalSK3bWG8nGsUsk7CZ5vNaXC4eFZ71/Tn15G7hXtNYISqiWcjWJq9dF4WIgdhNcxikTTkoFFR61qy1y99oerd324XtvGTpvV8j3KMg3ODmnkqisjiLiBa6xbldzQBxiTrSO8n6+RBSnZiAi9xO6eztQr3bLgAN99Y6fKHj8I6mnWdIYRuIWrXaJMpoppuq8tgaEk0Rg79VWA3QS5Toleszx716z79QEDYOa+gxDG5ffObJqnMN4fmOlxkkvBBMAV4f+McVEnaP8B00mkLcMAH0cQ7yX13VqtRWSAh9Z2SsD8RKNBz3BlcSOiIFOajR011VyAyBZI=
Received-SPF: pass client-ip=57.103.69.79;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e7e0a50da6..5aa8baa4a2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1804,6 +1804,9 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
+            warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
+                vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
-- 
2.50.1 (Apple Git-155)


