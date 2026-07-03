Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ED8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfS-0008OG-9w; Thu, 02 Jul 2026 22:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfQ-0008LK-Fh; Thu, 02 Jul 2026 22:30:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfO-0003CF-Hq; Thu, 02 Jul 2026 22:30:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631I9M21256805; Fri, 3 Jul 2026 02:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lu3QbY+g0p0+jeLci
 7FBbk6h1r1LS24kIcCOmb97Vo4=; b=Z2Lzsoi+GpnqqHbol0aZAXEX2Sl9DI485
 jwhgRxFrq68h3S7+wbS+61eNdKUo4C//98Qb3461mHruO7tr/Ow79uHPPTQ48U+k
 n3oxT2dEyLyXt/03QmjUtBYVx4IQj8qKAFe1r0vTNvCIXoE+u3TBBmgBJ919cSF/
 p7ex2k6Ljei3Oh1CMNC1a/OefVIU9XklsB0VqsI8/v9yq20RGrtjKhrqvyjUIvHt
 e0rNuN2UnoRwzdjFz2/XcT5XVl3hiTF/GK5UPo2aHDmrhhI0ySIDzgxdEdO0/tAX
 F/tnap0+xnyss/rns72DJvxjHU8CTWh5qEZFk70DRonkXxml1AL2A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n650ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632K3Q8013177;
 Fri, 3 Jul 2026 02:30:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqpyvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632U4so41943422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA4435805A;
 Fri,  3 Jul 2026 02:30:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E637758056;
 Fri,  3 Jul 2026 02:30:02 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:02 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 13/33] s390x/diag: Generalize s390_ipl_read/write to
 accept void *
Date: Thu,  2 Jul 2026 22:29:11 -0400
Message-ID: <20260703022933.1805010-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXxLxVfRlNIUhs
 8km/Cio3keeb5zFBFMR9/Wlyni5U/SPjMzqxiejb71xs40zi2jMtkZXsjRPRiktlanYshRVWWWn
 Hi1whZwY3cPddFlhMG4USrUIZyMBIeRuu2Gb4WNeAS3DFFHjttV1/Rgl5/84MlutUJaBSWCW4qO
 DpOgYy2XEImBN7iFwrUYMK9TIRXT2kK5XbLhs7NJEcPpJyDO4HuRlIFfJ5HcVJGU34/TAuL8y6m
 C30XWE6UVSiGgO9NN5yUGWkq8/KrO1IAUH6bXlFA/4x/Bnum0oJCXjnOrKl+wcUzctcobtTZMQC
 QtQAbztu1StAXj3L+jrLPIy1XHXWwI6J3e94SDVIYejjB2aytlcNTmJ+H0kAzJFk0DkVpxTDENh
 pC1k/YsEMGW2tM+1ayAX4eqeDMsX4MuLCBJ0EF6zHekiEAfDg6QVApsNCo4zamnaqSOI2ztH9pe
 CHm7NcSz5eS5Hxs25cg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a471eae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CkZHjoNxVx3BTC6vW7wA:9
X-Proofpoint-ORIG-GUID: rCVLEORd1h5-8VPoZLD_e8LquBS5K-pG
X-Proofpoint-GUID: rCVLEORd1h5-8VPoZLD_e8LquBS5K-pG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXz7O24yyC5Xgv
 oGIr/27m0m4oe+1AM98KJLA945dIVbYHVPlxSvZDkoRA/NZqyG2J3rTpgypC2EGk+k1RyJ3ODEi
 uuIcE14UiRRxEySlT2B2nvAP4k+JVUk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030020
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
---
 target/s390x/diag.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 88f419b09c..73701360da 100644
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


