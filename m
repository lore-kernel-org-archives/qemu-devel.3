Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC5EC44500
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg86D-0007TO-2F; Sat, 04 Jul 2026 17:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86A-0007SQ-IU; Sat, 04 Jul 2026 17:40:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg869-0007s3-1h; Sat, 04 Jul 2026 17:40:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmLh92445985; Sat, 4 Jul 2026 21:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Htgs+fgBjHi/nLZzq
 V/aa/uUi1okSFBXk2/yQC+7jm4=; b=GWXr5U94wKqeQbUtjI5soHz2WOP7o5iAS
 yJ7WOPsnI/TIOVJbryo9M+++H3Hpz4+vj59Qs+oY35+MLM95CMyLvzMpydl8g98i
 ofdfmb/Vz37URH4iznngOrJ9sb8YSKUtKoXMsH1XZbCEIYTWb9E4jJE+1BjMBKvY
 UUQ3Uhn91A3g6bviUXuCw9PzU7SX9G6iQUB2SeZjBM13Ma1VdGQVZCIbnXKOaOcL
 1jfwVDfazX+Nf9TerwmBCVcMWBX0HjA4IOL59JRk12Gnrs0cGjtUrQO2jEJrIyga
 MG2j/46wn3HEnmpk/4zoQLteyMagLomb4ohgOr5I2eI0DiTfBMuZQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdbc58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYaVS013501;
 Sat, 4 Jul 2026 21:40:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqxq86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664LeMSo52167018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8765B58050;
 Sat,  4 Jul 2026 21:40:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9581058054;
 Sat,  4 Jul 2026 21:40:20 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:20 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 13/33] s390x/diag: Generalize s390_ipl_read/write to
 accept void *
Date: Sat,  4 Jul 2026 17:39:29 -0400
Message-ID: <20260704213950.2118823-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a497dc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=CkZHjoNxVx3BTC6vW7wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX52jv4Yfd3VXW
 VmZ/ZfnhPbFzDt4cSKQt1jIxJKmgB821waVHDBVod8FvtTUWaBiJLwdvonTveiBV8HW/XKt4PxH
 UTBO3fA40Bh1sCeA5mJBlSY3yW2xDLFz4Xou5lhb04X82TelEUFmwNGHumxlV8JTy8+0LcG//8S
 rYLlmcuwuEZIiOPmwDMeSeF2yX+dM/lcYqmp9H4eOzSEmWMkb+3+cFBo32UmOVSifw9fXzxxvlm
 nfWtKdO5um1yTdpgma1TYYwaa/TVhrL+B1r52YCVpYnrcFrCYKk5hGWD6wTiTsXKlBxQZ9MzyEt
 OErNKW90q9M6M1cpQ2zWVT9D5uip1QB4KCkmggkfJ8zowmIxc0hZUAVgJYHFlw2TVJN8yZBZDzH
 u/eodEjovHXR/XR/UuT8BwkkDP8QI5HT/p51aCdrgMl4CSgbbnRBXpU/GbkJS0JG0r4mu0k5USw
 6UeQNSGaeOq6hjvcwGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX3K0GpxUaafmB
 +PfcLh7LTM++daUs+zcZW6NlWgdR7INymJBFuX1RwHchIxWu1id0/Yw49VZbe/dD9vAspJpoIuF
 6T4wj5oOPV/5mL/NYEBFZGYgCqTF2LI=
X-Proofpoint-GUID: dkvvFkHZB1HuIdL43MMVo6rtxXPqkhIx
X-Proofpoint-ORIG-GUID: dkvvFkHZB1HuIdL43MMVo6rtxXPqkhIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
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
index 6e7f2d5cb3..8bcf204268 100644
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


