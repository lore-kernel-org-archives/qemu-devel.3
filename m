Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0215C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whExm-0006wh-Qf; Tue, 07 Jul 2026 19:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExl-0006vt-Da; Tue, 07 Jul 2026 19:12:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExj-0008Kn-T2; Tue, 07 Jul 2026 19:12:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Mn9n4164805; Tue, 7 Jul 2026 23:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=I4ogTnNqFQr4MluOw
 1S+3JvQRkoJMpPLktxoVdj/XTw=; b=XkwHeqFEkhKQpuQiFF1OJw7POW0XyZIt0
 3j/USKxtMRjo1EEzuCj/y09LKHb29mLXk+COMSJYBPKaDeYsgo3RAmvuGbGuGfuP
 qjMM1oychnrIKgNOGGeID58HEdY1Xojss8jwJvNmxCJ8jdsInHz+K1buIFpSnuje
 8gkhGsirFAcOWeKUx0nrOEDiyI0Gc1L0IRK8PLijKq4ZRwquOBEUak+6FFFZ3+as
 AKG3ZUWnhdGsDnE8OAboagdHxwLihGgtOaHPPsmHxIDBa2Aq8zxenGxDS4vEmaI7
 vdoI7UtCuPZaPP6gq37FKd7ZnhcGfIBlJJmQ35xlzr+0OGpdY1aOQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stst4q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:12:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667N4dOY017942;
 Tue, 7 Jul 2026 23:12:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk52s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:12:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NBj5Y30868164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:11:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1E4358054;
 Tue,  7 Jul 2026 23:12:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0828E58045;
 Tue,  7 Jul 2026 23:12:16 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.32.2])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:12:15 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 13/33] s390x/diag: Generalize s390_ipl_read/write to
 accept void *
Date: Tue,  7 Jul 2026 19:11:11 -0400
Message-ID: <20260707231132.2492104-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q-qFPe5CsGynilsmnP5Q_FNASXobB1jf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfXzUcvB7rZAxte
 T7YCjK3T7J7kca2JlSoQ4esfuaTB6MC0a0Cv6Zg4wAfh6KsyhYKFKlMLJ7YydAtt4I94U6jV+st
 5e+5m+eJT4LMU/dcLW7LEbDAAaTUvdk=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4d87d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CkZHjoNxVx3BTC6vW7wA:9
X-Proofpoint-GUID: q-qFPe5CsGynilsmnP5Q_FNASXobB1jf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX1tBzBw6XQfA0
 NCufj15GgM0kX7mFUAug8esathbW+a/kJP6D7OxVPujheioxEJFbA6SgfA0H5L1w04HrlJli26H
 9981gLKJ/txZpZZ0RziV7FkVkLey77iX/WZ0BgCugmXSdv2DL+/Ekf4/rzeGoXqIWulkmPzWiJn
 mN2bvvTNsfEpG+K6QO6AO9BJxAVteZ428IqYHmvw1FUxNrUpQV9Ly6SSFP88snDcxssDK9t6J+1
 tXzeUPY6k0ZwMW0UXeEPm4RZvLFVKicSswidF5qhdtRaD9FmVlHaBN1LOPyyep+5jbHMcWGGqdN
 v1yTy3W0KVaExcUtgSck/lWmNFYZHq5pSXn40liY4NmoPLyYewAFV0HYIod6KNRyqLn2mOHdITx
 xPeX0lq4fkpDtpffRV4SuzqQneA2UGi8pf/YUbN4lF77WuFbejsy7TOfFcJfSdBuGBBI/J0fiK9
 gHSd3O+pZMu6sq+Tskg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
2.54.0


