Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D386F483EB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5R-0005qq-RI; Mon, 23 Mar 2026 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5L-0005o2-Rh
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:11 -0400
Received: from p-west3-cluster3-host8-snip4-10.eps.apple.com ([57.103.72.211]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5B-0004XN-W7
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:05 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 3222D1800116; Mon, 23 Mar 2026 19:36:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294619; x=1776886619;
 bh=p3kP/TgGy9+75EyKQX7zRo14kGVxvhzT6oqhUrcGhLI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=db1wTPC9H7Y0oKzPbymY7+QNdfush/vy+w4d898uObF+mSmEsJxNuKwwlpOThP08dy96bKk8xJvU4faFq17HrsrQUGFGJ4uSTW54Eiowdv8c2OqHxC2vQdHFLXrDDUD6CIGCeAsS9K7EJov/sIVi2TiQGlO4DX1ik9lnVnL+Orw5EpYqnx+BIRqj7yYzS5nXeCdxTx60Akc8ZZ91LekuAWtVpVVPUsXnOX7rNewrij5w6wBS3cBfzRWYRNSrbjCo8BAQhq7Ph/jB/HVCAsyvu1u6j0eXfYsJutjtXTdkM9OXRKBZ32Mz+433s/k0oou3N4ths4phD8oHHfHQDyxw1g==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 5F102180010F; Mon, 23 Mar 2026 19:36:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 04/12] whpx: i386: skip XCRs read for MMIO exits
Date: Mon, 23 Mar 2026 20:36:37 +0100
Message-ID: <20260323193645.82602-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MsRfKmae c=1 sm=1 tr=0 ts=69c1965a
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ytqdvofJqIjuNepkJhYA:9
X-Proofpoint-GUID: bSc9j1QX27p-j5ToTgkUU-b8RWFLqVBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfXyj0vp3Fk7Bod
 jHAiC9zXwtrcOyr3ScCX+WmidrghK5qoOOHn24C9KL077qlZH/uNJV7MyznPLG/MJ6UnCmF8yKV
 H3FMEOdxOK1B7lotmM+92QrSr9JtFnu7soKn8R4NPCl+wD2NfDf8r19gmARFU32/7M94geOogln
 5MQ7dg00YyMQ8Zaiz5rL1Gk4rU00Hzy1+xv01BFSC9dxPbhJ7TV+BsexZ/YQvfz5tekg1gkXkmZ
 Ur6sTihrno3B9x9TWrjJndmWzO21pMXWPPxMlR0nFgCFmDCfnLxik9XlwW104fNAKOcwPrceCQs
 62YvmAs5VFE+HUWreJ+8dgynB0KKFp3xACCveVqrlh+MG3T1IPZZNVlBHZ/CNg=
X-Proofpoint-ORIG-GUID: bSc9j1QX27p-j5ToTgkUU-b8RWFLqVBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxlogscore=762 clxscore=1030
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


