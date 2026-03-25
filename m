Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA601093176
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DkU-0004gz-SD; Tue, 24 Mar 2026 22:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w5DkT-0004gl-9J
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:13:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w5DkR-0006Uh-M6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:13:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OMBoep2196018; Wed, 25 Mar 2026 02:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=LYrFKJz+q9bEfB6XK5DOHNwDk5Yff
 tXOt1uk0Wsg9SU=; b=IRBm6sJV6reDJxgcrz11gnIF5E2NgP9NvxO6w4CHP12mr
 nB4R6s6vCCd+Wu56dVFZCoZXOV88Eej+oTKDm8lzu27C2Uv9gBDILCubn6U0Qz0j
 bEC+J4wGHK+Jr2NJi38rxRDsDNNDJK+I+E/iobmYhubaE6cKzQk9vWAusP88YrZr
 oO8UUgGjvQxfLWOmwovf+W62K583StxI96uUpSkLbc/vhie4v5I8Jf4vom0wxidA
 AJBhbWc5YXK40j5Y9UfZdauVbnGPYVEZRWeAUu+hLFDdd6g7MxwTdmbBG4REB4mI
 PvwsoJhnvKG247+Dzexms9duo/pyDXrnpd9Lahovw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfnfp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 02:13:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62ON6BPm012401; Wed, 25 Mar 2026 02:13:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hsgt0uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 02:13:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62P2DNwA037166;
 Wed, 25 Mar 2026 02:13:23 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4d1hsgt0n9-1; Wed, 25 Mar 2026 02:13:23 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, mtosatti@redhat.com,
 dapeng1.mi@linux.intel.com, zhao1.liu@intel.com, sandipan.das@amd.com,
 zide.chen@intel.com, joe.jin@oracle.com
Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU
 getter
Date: Tue, 24 Mar 2026 19:12:36 -0700
Message-ID: <20260325021236.14574-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNCBTYWx0ZWRfX7kzJb5azxOc0
 6o0KQeqE5bzdytkBiWYa/SvUiZOYzRhr0d5hfVeh5IVyr+fJ/JlXt77xaW/rQQNp9hupPqfb7ZB
 Vp3z+zfsS3kuH3en260EaCNbXuF64p/RTLy++B5+/7seGd9PYz2+0ZR0qogBhQp19mU55wv/3IQ
 NRxasQj9TobOqMpTU1ZgfXZtNAELi5Jyjh3HN77N6bnmxqxv0tBhtoPZneM+5O00t7Ruv9EPIbT
 Tadc6xsJNP9Yh/M/GDgxENDRujdGGFvZFSLh29aZT/oCqBKb7TlqCmzlNdQ6jPcujhAgOWZ/rLz
 0sg9gjBAdvskLccjq01Jpme/ku+o6BPuZ9847K+smeNqwQEj+hG8EK87yiHd2hBF2XFs98tIeMR
 t60rUZW9aDmHCRVJlaJd20o9QDhptZ6FwSTAhitY8n/QAXNAywLfqy/ViYxAI8QYgi+KIxWaMLu
 +aLQI+NSFYKslRaiEzNHtif2K2AC7YdC1gvLi1pY=
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c344c4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=1y-OzW91WTj5pHlFRr8A:9 cc=ntf
 awl=host:12272
X-Proofpoint-ORIG-GUID: unwITvswENtPoXWq45Zl40YYPNS7rLKl
X-Proofpoint-GUID: unwITvswENtPoXWq45Zl40YYPNS7rLKl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
behaves the same way when PerfCore is unavailable.

However, once PerfCore is present, AMD PMU switches to an interleaved
layout in which selector and counter MSRs share a single alternating range.

MSR_F15H_PERF_CTL0 = 0xc0010200
MSR_F15H_PERF_CTR0 = 0xc0010201
... ...
... ...
MSR_F15H_PERF_CTL5 = 0xc001020a
MSR_F15H_PERF_CTR5 = 0xc001020b

The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
reset") added the getter/putter pair for AMD PMU MSRs to clear them on
reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
addresses for selectors and counters. env->msr_gp_counters[] holds the raw
counts and env->msr_gp_evtsel[] holds the selectors, so with the
interleaved layout we must translate the MSR address back to the logical
counter index instead of treating the interleaved slot as the array index.

The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
the end. And in the reset path QEMU simply zeroes everything, so that use
case still works.

However, the live migration is broken. The PMU state is stored at the
wrong indices, so the destination VM reloads mismatched selector/counter
pairs. Fix the getter to use the logical counter index rather than the raw
interleaved offset.

Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8..b4e549c62b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5239,9 +5239,9 @@ static int kvm_get_msrs(X86CPU *cpu)
              MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
             index = index - MSR_F15H_PERF_CTL0;
             if (index & 0x1) {
-                env->msr_gp_counters[index] = msrs[i].data;
+                env->msr_gp_counters[index >> 1] = msrs[i].data;
             } else {
-                env->msr_gp_evtsel[index] = msrs[i].data;
+                env->msr_gp_evtsel[index >> 1] = msrs[i].data;
             }
             break;
         case HV_X64_MSR_HYPERCALL:
-- 
2.39.3


