Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C1EDEBF6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhG-00067p-E2; Tue, 03 Mar 2026 15:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh8-00061B-Hc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:22 -0500
Received: from p-east2-cluster6-host10-snip4-10.eps.apple.com ([57.103.76.211]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh5-0000kJ-Go
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:16 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 35D5E1800431; Tue,  3 Mar 2026 20:50:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571014; x=1775163014;
 bh=gBxNQ3TjAYTeogiJbh69cd5jTUQ5SWnQGrtlwC8PRBY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a9j3ukYRxyq1LoIvQwub/33u8HmZvc/aepAp9FLWtokz2rUgAj0vR1xX+arJTNqVOSbOiDmvWe6C/dlEBuARMhU9FF/W2BV4ub4oLWFmtk2omNarf9pOzyOGf20R+a2H1j7R9Q7oebCvCZEqz/fR+jT3Q0vERd3k1sghlMBfvg4tRwhkZdWdVEziLVYYwHF0Us4Cgc7tJdo01HRpYsvXl+rrm/Pi8kTOZ9+TnC4njqff0/GACK2iHXI8x/CcFskxJwqobBOlMDy9S25sUyIO/hDqC/V/p28by4U7LNxYPoZ0ItnhvwA3VT1mrkGdDd4XjoJ8ybU9GIVXjA33cDqx+g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 20A271800435; Tue,  3 Mar 2026 20:50:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 5/9] target/i386: emulate: LA57 fix
Date: Tue,  3 Mar 2026 21:49:55 +0100
Message-ID: <20260303204959.31156-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXyfNcCUzIGEUt
 5BQ7Yx4FpJfXslj8a0R37C5KLqZpqAxnwSgPcDMrje7Z8SWp6SY/lLrge3rd7q+P07r9JVm2oCR
 Gn3JCG1RjLf0a03/C7IksqzrJnleiSRwYwhZ5A+CK/TNfvOkdP4ICVGki4sNeB8GovQhFpgR0f4
 5TwkzZMyXqc91Sek+KEUHZL/cBrNEPMN0YDvmIlypDZqwGeoq+BHfNz3Ok0Wkt5WZt/fcWzMusl
 ef+X06/fYztGDpmpyM/JAh8HK5lVdalBEfQjCILHYXBlrVr/RpH5VURc3rYtDl1Sd20139Ropq+
 csrIEBSb0zlnPlDUGI78yFq8WWXfx8m4l+t+5uSwl7LaLQtV9LAKXdLc2WDXHA=
X-Proofpoint-ORIG-GUID: ugsTfOLkNhtSZKCkWnpqe1Y8Mp_RV6lD
X-Proofpoint-GUID: ugsTfOLkNhtSZKCkWnpqe1Y8Mp_RV6lD
X-Authority-Info-Out: v=2.4 cv=CL4nnBrD c=1 sm=1 tr=0 ts=69a74986
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AJrqCOfVdMXzVqk_6-kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=896 phishscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABxAtLsZy0QjIxCrP/G7BuKm4PPrI94aywiUKp8GuLftNvGsBLj8uz835IC6Stp6sLci84dIe/qCkW+Z5uICvrvB4JC1rS30smCvtVdxF5mEYLz9gv+d3+z9XOOR6ya8zBnMx3nwfGCsTw44d+4EUtxoCT/0+aUPN61whdSjkliwTXLDLe8HAqewtyOYLPR0FAs6RYCS9FdTJwvHwGEsiUFE38IW5fK4yhor7rnUcJ4o1N7erjDjBVkWNfDm/K98be1r4UGx6PKZbTq4ZgUnUYe/YY0JzXD93iC2CoGVu14F7UvqmHIrBxCR6xxGxaS5fsxlKfy6RmaTSYv9O+S6wvRQffuIybSTP4YnyB17lDlYey/BqZ4jvxMg4y9+WND7r6rmXn6v+EKvIwoTGzHwfi+fRXeN910d1HHf3v5AKGnBXGTNIStzR1AGlkPLpR9vmnvh5jNIVo/b7hn+PQtRaC8I87eUbiFkxdZECejZaXi3lrw37nz51I4rlgzKmvYVJ9XBBivAZNsH7cNOWvmm3j/BBUNkEojbg37n0Lloj6oJvz9SGJQn6AWCGcKnc1xTtkFBzVpyvahumcc5CFhWgWmkdehA7lO+hqKtgkeFo4ycWLDDGQIo/CvKbTfFPaA9e10Ol0Qp4m+ZFygZeqqTlgBTlJVr/e+LBWpcvKgpUDMT5yW2IlPvD9ASlUii3FW91ebfp233T5wDTvFFhbKrI3cuORGJIFUBeAn7LO86ELq7vw+1M=
Received-SPF: pass client-ip=57.103.76.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Seen on a Sapphire Rapids box with LA57.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8261ca1635..4e39bae025 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.50.1 (Apple Git-155)


