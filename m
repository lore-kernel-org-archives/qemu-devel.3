Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11C4C55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYb1-0002jA-Ry; Thu, 30 Jul 2026 17:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYb0-0002TN-5C; Thu, 30 Jul 2026 17:47:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYay-0002PD-CM; Thu, 30 Jul 2026 17:47:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJm5EZ3875683; Thu, 30 Jul 2026 21:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ojziyW
 1KPLXFCfsQn89odRxcCz3QbRTtTZNHbTeRatM=; b=Ytxev169S/JNLXq4nOIh+6
 ZVd/yOUVOq1K4zmz9Rce89F5sxOjaLRk9H5rW+HdwPvFR686vVL6xiDIW7Q2GS+y
 WANlBmozI04D1UPaZefGuFgpBQzSdqtmxdCB2KqdzqW1ioCb6lE/w8SleQwkNQU+
 9Q54te1rjrzH8t8O+3UBAkKOY5gwkExMrdsMpEDx5Emg9mERcjp4zo1iI7cMgTPa
 KPTn1vAG0JWI7/UW83U1ULcq4hK9EdSwUJwmSR5joNI7pXGSx/cR/prFv+riJ8P5
 GzvBpV287HSH2/kjJj0UTMwOAHrWZOCvBlPwuU2k0g4fgpblGGOGoEb7VoMQQnpA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjh4em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfLgr002182;
 Thu, 30 Jul 2026 21:47:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhn6tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULlANZ31326968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA0C58043;
 Thu, 30 Jul 2026 21:47:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 451C25805D;
 Thu, 30 Jul 2026 21:47:08 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:08 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 20/34] pc-bios/s390-ccw: Refactor zipl_run()
Date: Thu, 30 Jul 2026 17:46:09 -0400
Message-ID: <20260730214624.2328883-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX/rpLLo5vookX
 NbGmX7q30C5mQz92oeneyTkIsMwhmVXykRhh6yzwbqpivAeSOj67QSZaVoJgVC9u4LIRxVNISKK
 GpIew+pGzXUCQ8UjQ/lGYKyQkUlsA0A=
X-Proofpoint-GUID: JxbACqF-bW7GSV27A3gTrhMbU4gvGV64
X-Proofpoint-ORIG-GUID: JxbACqF-bW7GSV27A3gTrhMbU4gvGV64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX+7wHp90jXrUd
 gATkofZNRCdkrFAbzctcyhzOkiGeWlgx4tMOIEni6AQjue+p2WHaDyKVSB66r2s5kUMNFoVIHV/
 xr/bCUv9F7V4ZxHWA0TcXSeE+HEAcE8uyhTvgtuOd2iboXHqUAVmlQSmhFLkBeFLsSdCIP/XkEu
 ld5k7LHDYg9BBrhl7GhxlLu8oSe7s7X0RGnqpCX3VY4NNZjyv2fPZjenAJTEm/JwZxJjBIYi8pv
 XDd4kHeeNWqdWE05HCKM7QpAxvqe3ECcdrodtVWhGZHQdQRAFP2r8kyyURFpXK1VC53w8eXwpwq
 Z452pyxOKrboc9vEVUx+qebBdnrouosZElgSGHuEdYThFtuu9bwPAiRV5xsqeZPUWTI8wJaykJ+
 nUi2fblbNV87mq7SJDwmuy7xg9O/5LWYIaCOG1uB0PBL9nhpbnZgsVzqoGGKkncL9Qf1ph/ps6q
 6P+tiOVahJ2rAoluCNw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6bc660 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aJVrDPNlQ3gWXBXSk9UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300157
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

Refactor to enhance readability before enabling secure IPL in later
patches.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 pc-bios/s390-ccw/bootmap.c | 54 ++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 420ee32eff..2cf5c9eee3 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -674,12 +674,42 @@ static int zipl_load_segment(ComponentEntry *entry)
     return 0;
 }
 
+static int zipl_run_normal(ComponentEntry **entry_ptr, const uint8_t *tmp_sec)
+{
+    ComponentEntry *entry = *entry_ptr;
+
+    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
+           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
+
+        /* Secure boot is off, so we skip signature entries */
+        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
+            entry++;
+            continue;
+        }
+
+        if (zipl_load_segment(entry)) {
+            return -1;
+        }
+
+        entry++;
+
+        if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {
+            puts("Wrong entry value");
+            return -EINVAL;
+        }
+    }
+
+    *entry_ptr = entry;
+    return 0;
+}
+
 /* Run a zipl program */
 static int zipl_run(ScsiBlockPtr *pte)
 {
     ComponentHeader *header;
     ComponentEntry *entry;
     uint8_t tmp_sec[MAX_SECTOR_SIZE];
+    int rc;
 
     if (virtio_read(pte->blockno, tmp_sec)) {
         puts("Cannot read header");
@@ -700,25 +730,10 @@ static int zipl_run(ScsiBlockPtr *pte)
 
     /* Load image(s) into RAM */
     entry = (ComponentEntry *)(&header[1]);
-    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
-           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
-
-        /* We don't support secure boot yet, so we skip signature entries */
-        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
-            entry++;
-            continue;
-        }
 
-        if (zipl_load_segment(entry)) {
-            return -1;
-        }
-
-        entry++;
-
-        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
-            puts("Wrong entry value");
-            return -EINVAL;
-        }
+    rc = zipl_run_normal(&entry, tmp_sec);
+    if (rc) {
+        return rc;
     }
 
     if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
@@ -726,10 +741,9 @@ static int zipl_run(ScsiBlockPtr *pte)
         return -EINVAL;
     }
 
-    /* should not return */
     write_reset_psw(entry->compdat.load_psw);
     jump_to_IPL_code(0);
-    return -1;
+    return -1; /* should not return */
 }
 
 static int ipl_scsi(void)
-- 
2.55.0


