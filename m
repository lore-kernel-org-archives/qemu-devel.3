Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD8C55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYam-0001hK-LQ; Thu, 30 Jul 2026 17:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYal-0001gj-35; Thu, 30 Jul 2026 17:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYaj-0002NK-He; Thu, 30 Jul 2026 17:47:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJln5p3942688; Thu, 30 Jul 2026 21:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3SLmC7NoFDCIrNKjP
 PQ8DOhecmlcnGUMEfM2/ANuRho=; b=l4ijHJ0D5J5BtaetmfO7wIWONhcTJ5QfR
 OlwII1bE8zwA+9RCIIInW5ST8unKsZ1suyZLaVFRaInj1aCJ21s0t4w21R1y+FV3
 e21xxR0DkR/fQ7TwN0xLP2MNLy3O6o9AFPrWcM8zPECImEnnqcVnvyZU0mU1HyON
 8X0h3y1je14N+FCPG9ToZWT3NtJKd5T70i6K7oRjVfGCNjZVPavkTX1w7wB4UV7y
 55X4jjZpkHkDHWcW6bv8TrzeTXOL6M97Auzt8Wg/2ebqEn5OKDZ9M/TY7dqZdBgR
 dxhGcnuBAGmn/PunSEPpD2y1OgHWgPH1tq3y7vHBtmRLnsXL10ttA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7t24k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:46:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfLDK025793;
 Thu, 30 Jul 2026 21:46:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkda2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:46:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULktHa22413952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:46:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9808558059;
 Thu, 30 Jul 2026 21:46:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A541A58053;
 Thu, 30 Jul 2026 21:46:53 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:46:53 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 13/34] s390x/diag: Generalize s390_ipl_read/write to
 accept void *
Date: Thu, 30 Jul 2026 17:46:02 -0400
Message-ID: <20260730214624.2328883-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JOhdaPquymfJT9CScg_P1c7fVT_QmET9
X-Proofpoint-ORIG-GUID: JOhdaPquymfJT9CScg_P1c7fVT_QmET9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfXwGstwZn5MPYO
 odyFKQ4PZqPNVmQxoXcJGWGMHrlM5/bl/qXSpSWv6RPkp9I7ASGuvS1c34bGFBmtPnhsstvXI+f
 c9I0fEuj+tNM8lGE8BGGwn+vaanXRr4efay7zoib8L/JVMTXyUOZlapDmLykfpeiDo0TODp099M
 /O3tpf2joUp8M94/uaB6h7eZKY9x9bOCuZBm99uQUF4uJPJ6+Qqzyuj7WtIRzyQqiPsubmaf+M8
 qzoJ7CNUmnBkxM7pk3wF6warJp2x+6PyYvLp8ziVspGA6ZDXqCQh6KuRvFMNNqjRkrBvfFu9vAy
 dZsj/bY9ZhIdJ5dUTeo52FhAq4eOzjxyvidZO2iVYo0YE3egMaIOyHFirr9WwwdsL0l4rXfm/GT
 mgiUG/kX1LfPNO2ehn6Ug1N2pseOFjtTx7KssSj1WfpMDrFqLZ4agGwXQON72KPcRuNuLx3w9uj
 YGyRCzHFMayr8gmPPeg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bc652 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CkZHjoNxVx3BTC6vW7wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX8sToVwnrwvE0
 NV9xcxbM645+oOshr43vm23Y61/b0uTCs6+R1dmgxjbLlDTwgZROjEzCUrB2l6ps7M3VK4UnHtw
 GuWH7kPeBmL3whpogUUkryhnKG6/cnU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Change the data parameter of s390_ipl_read() and s390_ipl_write()
from IplParameterBlock * to void *, so the helpers can be reused
beyond DIAG 308.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 target/s390x/diag.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 5b09eae1ea..fd86b3f225 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -83,24 +83,24 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
 }
 
 static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
-                          IplParameterBlock *iplb, size_t size)
+                          void *data, size_t size)
 {
     if (s390_is_pv()) {
-        s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
+        s390_cpu_pv_mem_read(env_archcpu(env), 0, data, size);
     } else {
         address_space_read(cpu_get_address_space(env_cpu(env), 0), addr,
-                           MEMTXATTRS_UNSPECIFIED, iplb, size);
+                           MEMTXATTRS_UNSPECIFIED, data, size);
     }
 }
 
 static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
-                           IplParameterBlock *iplb, size_t size)
+                           void *data, size_t size)
 {
     if (s390_is_pv()) {
-        s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
+        s390_cpu_pv_mem_write(env_archcpu(env), 0, data, size);
     } else {
         address_space_write(cpu_get_address_space(env_cpu(env), 0), addr,
-                            MEMTXATTRS_UNSPECIFIED, iplb, size);
+                            MEMTXATTRS_UNSPECIFIED, data, size);
     }
 }
 
-- 
2.55.0


