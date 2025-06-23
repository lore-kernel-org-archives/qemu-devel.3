Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED4C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnWr-0004gV-FK; Mon, 23 Jun 2025 16:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uTnWk-0004f0-Kz; Mon, 23 Jun 2025 16:12:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uTnWi-00043I-Fz; Mon, 23 Jun 2025 16:12:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NIf4FW017031;
 Mon, 23 Jun 2025 20:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+zJZD/hr9A+n3FyMS
 ANS+IA99++oP7vcgDMB42okmnw=; b=lrg80i4kgUh0gIabNTKYagxNv/ElelzcH
 dw5PMFoF2MgS8HF+Fu7/yDPJfyVZSAjRU58U+zeCUXROrgyXB/WMMSJ4teggNEgs
 dZC6JTe5VnIeOTtwC1mhfPwK+W1fNberiNvhc9MlNqJ9wDjjkbikN9KdiD1s3Gdl
 pkivwMHH1IwwErEJlubNE/vFQ35dQSHsDWoJ17UTc4LD5TAyVikoy/IHGmbjeY0b
 5biSlvJrLG1S2yzfVm6olWDHZv8kQVFqg02yWGhM4hecYsdXkpdkwXGZ4YitKYiJ
 xmm3sc2PsmL4L9shlNaeMUA32FpU4d0v4CrnDqckdkSD9hYRHXQvA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63mcew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 20:12:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NHre4a002502;
 Mon, 23 Jun 2025 20:12:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jm0e1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 20:12:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NKCKmv27918920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 20:12:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF1245805E;
 Mon, 23 Jun 2025 20:12:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38C375805C;
 Mon, 23 Jun 2025 20:12:20 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.75.155])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 20:12:20 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 philmd@linaro.org
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 1/1] hw/s390x: Use preferred API call for IPLB chain write
Date: Mon, 23 Jun 2025 16:12:16 -0400
Message-ID: <20250623201216.721130-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250623201216.721130-1-jrossi@linux.ibm.com>
References: <20250623201216.721130-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEyOSBTYWx0ZWRfX/PCAP02MvmJy
 0DD21w7zb60qddP1OgCFr1Jbu3mZB1CW3TQy9zc70d2NFhKkHfXp3ouFxnTm9ygcpUe/bUAmFQ1
 HHApgG1DZ7OwlFu/htGP5iE1K7Kh9Xgziq79IDzbuIHuR6r0FEvU/PEGwn6bM+CLKKlFMdSazwl
 +Z6pksCXaFctWd2yrR8YGRBPHDAMwxppxVpUT0ny4cHx1hHlYv+bQFvXEpqTuytJZ4QUVW9hrsC
 dKfw8ByuLhbDirm7il2N8A67nzjG8HoVHmToFTKQxcJuMyk3m3RTOHLSqxL1r+506CmKJKAQ5L/
 cOVQJsWHeIIHvhekQSo4BtQoD2kaZk3EqIwHlF9IcLd1Vn3sh6urxoVk5bY/I7deIHDozDqUEvR
 cLy2SOGX4pwhtFRXTnyFibWq2UiO0+4gbPuakZ1i9G7Cp53XA+ggpAEaYOMQFbSRtQ9/P7gG
X-Proofpoint-ORIG-GUID: jJjkH8h8rFL5lOacN_C93mubZEBow-Ni
X-Proofpoint-GUID: jJjkH8h8rFL5lOacN_C93mubZEBow-Ni
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=6859b526 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=8PqC00_19NVShXjvqaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=600 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Replace a recently introduced legacy API call with the preferred API call.

fixes: 0927875 (hw/s390x: Build an IPLB for each boot device)
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2f082396c7..f2606303e6 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -399,8 +399,16 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
     uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
     uint64_t len = sizeof(IplParameterBlock) * count;
     uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
+    MemTxResult ret;
+
+    ret = address_space_write(&address_space_memory, chain_addr,
+            MEMTXATTRS_UNSPECIFIED, iplb_chain, len);
+
+    if (ret != MEMTX_OK) {
+        error_report("Failed to map IPLB chain.");
+        exit(1);
+    }
 
-    cpu_physical_memory_write(chain_addr, iplb_chain, len);
     return chain_addr;
 }
 
-- 
2.49.0


