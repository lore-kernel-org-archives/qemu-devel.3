Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09646C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7T-0007i3-63; Wed, 26 Aug 2026 08:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7R-0007fC-9m; Wed, 26 Aug 2026 08:52:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7O-0002YS-Qg; Wed, 26 Aug 2026 08:52:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCVvIo4002711; Wed, 26 Aug 2026 12:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mXzOIxGi5lfJ91FOS
 ro9OgeUzRisu61uPJFw+zSIanE=; b=qIY984GRa32HCRxnV9dCVRENFkPvzM1Hy
 CIPIgq99yk1ZgjKYhjX4ZbQ6xo3rapTA0HIOQ7xyCJE9ziEwcZoTznohhoVbF3/2
 1Nl1rl4HWzu2RWQ7nksyrUDkkEmuyS39kF6ryNLa4Q4oYJDDc3tKBMaDmAZcxUO1
 Avq+u/sL+M2wGdnRGwIQ3pyiEP24tnvSCCEi56Qu5J4k2NTWxlP45jfJ5m+obPpP
 nRL6vQIpQ0jYLmE1NOcFnQ/KeA8MIcIg0y5WioauxsQnr7HeoBVdZigI+qRPgIUw
 pgzr68hVPr+NMV6MueYIxhbgPuE1v/OGeNwhpxZHTDKXM9D1+4iVg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xpd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfJc1019158;
 Wed, 26 Aug 2026 12:52:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9px7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqYc16095490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A18765805D;
 Wed, 26 Aug 2026 12:52:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEDDB58059;
 Wed, 26 Aug 2026 12:52:33 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:33 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 15/37] s390x/diag: Generalize s390_ipl_read/write to accept
 void *
Date: Wed, 26 Aug 2026 08:51:50 -0400
Message-ID: <20260826125213.1901252-16-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WSOTDJ5yimfbEqFo3SusSJLYMOKzBvOA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX9D3AOeMbU9eO
 Ut9xEFR97exNV2KrB9cwodB5SP4Z9eKH325iqCfVEqghM6gbzisEHcG/POvJJog2wVuZ22CWFNO
 Zireh5wxwRmj5F9FZVYF98ORjIXkCpk=
X-Proofpoint-GUID: WSOTDJ5yimfbEqFo3SusSJLYMOKzBvOA
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ee195 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=CkZHjoNxVx3BTC6vW7wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX1DtpYnd4ofLa
 hf2F6uCZt3XPQAALzFkZkydviXDkfRHfbASAnH99LDlBXs35BmzaaT0twwF4cOMKtNHtf+E1W9y
 7GiwVwK9xy6QDHnTKX3ngO58x9dm5NAqJB0p0cJ/IZB6Y+LD0rfLQZ8CziNGgzZdB1sROeEwcqM
 zoFc+o+U4F6x/QAhKzdL46QMBy2ACC/kwbw6iQlOaPLu9Q110rXJAYeG+09nsYK+JMUzqt4z9BA
 9ZPcEoje70UgEez1cEoAVDRw94t4PD+xfLDVK/H2125o/yn5OCgyL/rpuHpkdob0bXre6raf1q8
 2fR+LOjA0NpbYLPnOtVrz0UF4YW6VAJT+C8kbB9JdUAtyQVNqA9NXSalGG6tn9xAsHs2CTfGK14
 aOpbGwpiGQc+cfyMTRVk7Koua/ubbq4cO3o2hSnOSOeS/oY0aANOrn+JfYDSJRpcrdBXy+xsP0S
 AWLr6vCsyfVd/uurfYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Change the data parameter of s390_ipl_read() and s390_ipl_write()
from IplParameterBlock * to void *, so the helpers can be reused
beyond DIAG 308.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-14-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/diag.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 3e5ddc8c9a..c71c1a7769 100644
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


