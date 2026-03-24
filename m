Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19945F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53T8-0005vK-VF; Tue, 24 Mar 2026 11:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sq-0005t7-BS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:42 -0400
Received: from p-east2-cluster6-host8-snip4-10.eps.apple.com ([57.103.76.171]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Si-0005s8-1D
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:37 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 1A8A1181644C; Tue, 24 Mar 2026 15:14:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365267; x=1776957267;
 bh=p3kP/TgGy9+75EyKQX7zRo14kGVxvhzT6oqhUrcGhLI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KnsZ6ad6efIlUOFw4hcNW5Wsb0YWyXf1y2uh5qZMELDEtgX/ymE7YAzZODT7IWiddzwK2uIVYV/U+61a45kUv3uTE7wT5WHabU6ACj2izGIH63om9XaDL45SHMDuNdrKH/cAvbCz739LeY/Nl5yp+pQMurzYENN6j74xoc+WKK3Cva52cKRT3YuSkPl80onQc86+bFm/KnngEi8oRzwJAL0JuJAYfBZYcyuZEpg5HDLJ8EuHmzLxW1nEtT9UnsryI3wRiZRthH9Cvmqqs+0iNAm5wVVWm/cuX5oDcf6dUY37KA1Mj5cAN7iEhCNwikshVhVeLZpMriRih0Da5sX2Dw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 9D2E21801481; Tue, 24 Mar 2026 15:13:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 04/12] whpx: i386: skip XCRs read for MMIO exits
Date: Tue, 24 Mar 2026 16:13:15 +0100
Message-ID: <20260324151323.74473-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v5OyBA4sWwIGfWSBA6TBn0e8MsxX3PM1
X-Authority-Info-Out: v=2.4 cv=YdqwJgRf c=1 sm=1 tr=0 ts=69c2aa51
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ytqdvofJqIjuNepkJhYA:9
X-Proofpoint-ORIG-GUID: v5OyBA4sWwIGfWSBA6TBn0e8MsxX3PM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX3QMkW1yP0tFi
 k2sqLOghH4FzaX1Jc67s1oJF+2W9NO5x8IkCIKF0gKQWxex+EzD4IohZvVW4RzvvTzm1I62FUUc
 z2uq+w86a3YsGtEp52p4gwfxVUC/3LuLVpsB//LxQKnVCgp2T4nGnFw3bizate//lqXh+ZMSa+7
 aPe2hwhbw+21Nk7vXztkHfnQUJD91ac3HC7+A3E945yE9UVe2CIq0gR5D+7Tk2DrdkUTW46wZTQ
 O6wpsKZNcskgRcr32XqkUGKmqNOz61u9dAXa/QZOv4Bw9dj/0kGvpJjLT4mouHs+1GAanl3brkY
 7TWedq0qHqEns+izj+9DuCfYbz0nsfmqt/lXQtmXypU7p7IQKC5KbjqyrRqoJE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1030 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=792 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.76.171;
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

The XCR0 value isn't currently needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ac03445d9d..c0c7ba9177 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -689,7 +689,9 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      * Extended control registers needs to be handled separately depending
      * on whether xsave is supported/enabled or not.
      */
-    whpx_get_xcrs(cpu);
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        whpx_get_xcrs(cpu);
+    }
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-- 
2.50.1 (Apple Git-155)


