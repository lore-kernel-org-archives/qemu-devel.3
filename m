Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6E5C7EE31
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 07:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTyPB-00008V-Uj; Tue, 24 Jun 2025 03:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyPA-00007d-3P
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyP6-0007SA-VC
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7ffV6010205;
 Tue, 24 Jun 2025 07:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=MJZis
 hDpgpaSxw5cNGh9XrMCLDkdsDpqJ1CRZm8YqzA=; b=dUXoohAq6P6y7EBWGBBG3
 4CEJ3lK/xMJA9Y47lngk0IB7U0JmmZ3Umjel6tlQpSLJVfb0Ow6buTjD60NLiLO9
 5OewKYr6itCiuU/ZPpI/b2ZLKJoumsasM8OkkK8oPKpI7XjmrugALm0ue/8YDchU
 K8ys8RYxyD5JOahoQqEccMNCQSHZvBNFb03V0dzB2EOLw9APP8oWKJQTyr66IrbS
 M09AvmKHDIpE/98HaRX/HeoThTRfjvs9g5Rpd890JRZDIVMTfpOjhVRCYUYCsHM/
 ZkpEzaGxCAfJKDVSyuaDOfgr7CtBNeqJTS1iwIaxAt3r6vbaPdbkGUvv20Kpui0A
 A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1bcbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55O7W8HV005631; Tue, 24 Jun 2025 07:49:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehq3ar2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55O7n5Xi006279;
 Tue, 24 Jun 2025 07:49:06 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47ehq3ar1g-2; Tue, 24 Jun 2025 07:49:06 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v6 1/9] target/i386: disable PerfMonV2 when PERFCORE
 unavailable
Date: Tue, 24 Jun 2025 00:43:20 -0700
Message-ID: <20250624074421.40429-2-dongli.zhang@oracle.com>
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
X-Proofpoint-GUID: 75eLXVljPSDzqjN09xUffxg-OOojDoL2
X-Proofpoint-ORIG-GUID: 75eLXVljPSDzqjN09xUffxg-OOojDoL2
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685a5875 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=He110phtp1333cD8tQQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA2NiBTYWx0ZWRfX2gi1eFZrK1p3
 +2oH2e8Pxi5i2xjX7ksZxz9/r42jjKpGqdQqkFDrMvnWTYFLhU4SnTAixfCNLYS00cV8sHdL3Ur
 Tu1fLNocGMCiejttUnf4sEDDMA/QXjGw8qauCHAT/AM4bSIFHDlO1jDNi35GwC9YOiFoxQDdQyq
 8nx1V6t5JW4h6haSWW3ClBAJBQoZROmPix+jVOIx9ZuHoa3Xmn+L3YPa7J8B2kpmJaUAD0rTIOu
 1MXzCCab8gBG+Kt7LSkf2mvFnUYm6vkjvMzJV0XUFdoVOpbb09pRWwYiiJDOcHIKpqH/kaXMpxn
 WSUfhfYdIZAZmlnicDfTFpt/u6J942eSrC9FWIW0KDmRfIyF61sOz6fy9OIhOuXfyYfhtj5bOb9
 jZZWsJR2Ow2SZMectjkvaHXbhmZ/Zh67f+jIu5zuC38qNwqG8Mvlc9OIJf+npc3EFT4UfiPO
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

When the PERFCORE is disabled with "-cpu host,-perfctr-core", it is
reflected in in guest dmesg.

[    0.285136] Performance Events: AMD PMU driver.

However, the guest CPUID indicates the PerfMonV2 is still available.

CPU:
   Extended Performance Monitoring and Debugging (0x80000022):
      AMD performance monitoring V2         = true
      AMD LBR V2                            = false
      AMD LBR stack & PMC freezing          = false
      number of core perf ctrs              = 0x6 (6)
      number of LBR stack entries           = 0x0 (0)
      number of avail Northbridge perf ctrs = 0x0 (0)
      number of available UMC PMCs          = 0x0 (0)
      active UMCs bitmask                   = 0x0

Disable PerfMonV2 in CPUID when PERFCORE is disabled.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Fixes: 209b0ac12074 ("target/i386: Add PerfMonV2 feature bit")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
Changed since v1:
  - Use feature_dependencies (suggested by Zhao Liu).
Changed since v2:
  - Nothing. Zhao and Xiaoyao may move it to x86_cpu_expand_features()
    later.

 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430..21494816d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1855,6 +1855,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
         .to = { FEAT_24_0_EBX,              ~0ull },
     },
+    {
+        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_PERFCORE },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_PERFMON_V2 },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
-- 
2.43.5


