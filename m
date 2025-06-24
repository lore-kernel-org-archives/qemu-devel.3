Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F91BC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 07:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTyPA-00007f-8T; Tue, 24 Jun 2025 03:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyP8-00006y-OW
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyP7-0007SB-0J
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7fZtY017392;
 Tue, 24 Jun 2025 07:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=j87T5
 hbCtjwElKW/Ya/lVxUUs+MLBpntekxXbDCehEo=; b=eRSYXyfimcISFrs/OeLQQ
 yp3+2Q2Ln6PpKW4LSxPnGkgGI616s3girWjvsExpic1fzUc2yVCDSO0cyQlCYv5i
 R5xKFzfEO/61n4FyP3WLQYu3MxZXKUlQqppCWf+sfVZtM55y54DEoeDYu83mVheV
 jxHsTqPq7r64kXrgVwb9HvX2v5ytCjd8SXok9+4LmwfWbYNnrbDDo+hVTSI+34X6
 AcmN1xz2W+VwCr8UBBokIozlOIZ+/r6sKiGhYzl4a0KqM4U03W2PyAmMUicnHDPB
 zStpj30n6upcT3hVqZDVvWhlDp5JMEtaaKn3L8nuE1g/F/0E0RL+pInBH/6755nT
 A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7bcxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55O6TAM5008158; Tue, 24 Jun 2025 07:49:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehq3ar32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55O7n5Xk006279;
 Tue, 24 Jun 2025 07:49:07 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47ehq3ar1g-3; Tue, 24 Jun 2025 07:49:07 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v6 2/9] target/i386: disable PERFCORE when "-pmu" is configured
Date: Tue, 24 Jun 2025 00:43:21 -0700
Message-ID: <20250624074421.40429-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250624074421.40429-1-dongli.zhang@oracle.com>
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA2NiBTYWx0ZWRfX4aFXi6IFA4Sb
 kQXqKewL0CGHTrRQVvME4ETFnxjQsCGlAtsLnQ0BQOF1bcJdPC5AZoP4Xsdn4zM5cw0EbSm9h6t
 OnOiGrF9XQmK2RAGPFsvp/5bJCLwt3Zquxl35eshrKnYwBv6YjpOTQMsQuz21Tz3X753DJfSAO+
 depZr3IFTIQ8GmPsXw/Bdj+OmeV+QpxaV8TtPUfYfIslFgXFwjFvNmQfK0hyNfzFgJabYVJAhSA
 vi0hF7ffruAIWWzaqaDUfoSDBF0QwOFaSbvfM6b3U59bEvvetOPvhTYxexv9TnnG/JFym5xUety
 42kPylYTS2IJm8nzwD4mmu+I+sHiVLwzNGzcE+8AqnUMls4dOT4SJV5dSH3xmLaBbPQDuYBz/mQ
 18bGfSn7FShUpVa8jsI1qUtHSIUJn/QwOEYmyxLB6A9wTjDLmLRATp457E36oRQyBH4PvSRS
X-Proofpoint-GUID: gVeLL2SRRdkn0_2Un3ixBvR-49bv4uwy
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685a5875 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=0hacFnLdYK-0wtQaQsEA:9
X-Proofpoint-ORIG-GUID: gVeLL2SRRdkn0_2Un3ixBvR-49bv4uwy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, AMD PMU support isn't determined based on CPUID, that is, the
"-pmu" option does not fully disable KVM AMD PMU virtualization.

To minimize AMD PMU features, remove PERFCORE when "-pmu" is configured.

To completely disable AMD PMU virtualization will be implemented via
KVM_CAP_PMU_CAPABILITY in upcoming patches.

As a reminder, neither CPUID_EXT3_PERFCORE nor
CPUID_8000_0022_EAX_PERFMON_V2 is removed from env->features[] when "-pmu"
is configured. Developers should query whether they are supported via
cpu_x86_cpuid() rather than relying on env->features[] in future patches.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
Changed since v2:
  - No need to check "kvm_enabled() && IS_AMD_CPU(env)".
Changed since v4:
  - Add Reviewed-by from Sandipan.

 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 21494816d4..50757123eb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7768,6 +7768,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
         }
+
+        if (!cpu->enable_pmu) {
+            *ecx &= ~CPUID_EXT3_PERFCORE;
+        }
         break;
     case 0x80000002:
     case 0x80000003:
-- 
2.43.5


