Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2539EC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHH-0000Sb-TD; Fri, 03 Jul 2026 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGv-00082U-8G; Fri, 03 Jul 2026 13:01:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGt-0003LT-C2; Fri, 03 Jul 2026 13:01:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIZlE3302409; Fri, 3 Jul 2026 17:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YZsz+3
 Sw2LgxbyYlnLsi1LzrSQj0K5ETutA/Sq2xLrk=; b=bK5Dd/VYsSlNNwPvpcUwMt
 xoq3VVO08zQ7x5ndPs/0B7GVKK6tHoxuPDGo8w2P99PVcbFirIn9ABQ0SK4DF6Zq
 5zyO1kp4GaTFSiewkCCOuK2QYiodIxhRyRuOAHd8pItBoVQJ9jDZHMA9lfNlrA32
 3NflziVuzF1cYARGm+6SJBvKABvhYdjRVlnX9W9teoLADPsHOKK+2QjN3fO3UCfw
 TDYY0Pfu3efeWvIkTc7wgps+1wttYyReMHnzu97wlugpn2RyxKelVJN4rjELP/A8
 m3sWiU/S7PPDGPzEbwqNco0SwcKYs9WUoHP/rZbbyVnvPQB8641iT1IW457YJPjw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n688y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gnie5001524;
 Fri, 3 Jul 2026 17:01:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7whted-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1eQ534013760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5358658054;
 Fri,  3 Jul 2026 17:01:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83CAE5805D;
 Fri,  3 Jul 2026 17:01:37 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:37 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 20/33] pc-bios/s390-ccw: Refactor zipl_run()
Date: Fri,  3 Jul 2026 13:00:17 -0400
Message-ID: <20260703170032.1893204-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXz8KNlmI1indw
 xJ/Mm+NX++W++ev3gTUmxjLnPj+F0h57j9OMpZxeu7pN35rgXHeY+PT76gnJB/2SyeUqFI+qzEz
 1G7na9OJBoHRIrbVtl5YogqSo0GrR0XOwVI48wb3vx12NtWyamaiJ7Lpw+y5qmheskFE8XEu8iq
 4rK8whvbN1GiwUM/kG0sHvKI5FK2T4TtPMlN8/C6kaAkDWvsgI8lUh2ejvXF9ErHZBaJ9WDhxdc
 4xMtDBl4c9rnW8TK8NSYuthzDGT1mo7JYjz5JqfhNoY2wo5sG/FX2JeLRqERAgOgpCnQhgK9/Iv
 5t6c0WGabGsydWQpumRXMbavY6ykYFP/UzSEU49VNerXOBmdnd8v0/1V6vxxWcYn6qddALoMeB4
 C4GATxTi8tH7h4TgdUMg1zDF+3bjHm5Zgqzr025fbyUM9Obp9wbaZbLFzAmDKOSH4gjqrNB/aZT
 vtLByHBKuD/bOiRehOQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a47eaf6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aJVrDPNlQ3gWXBXSk9UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w89oWrqMYtWkwCwUbLOb5z955gKPIYs_
X-Proofpoint-GUID: w89oWrqMYtWkwCwUbLOb5z955gKPIYs_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXyxe82qP6BIvc
 nMOpv2uwYcPBVDl5B1EPbOCsifBjZzsPsgBkZQoTBtJ7zYQH5TxC+MygoqzySLjZbn4yvG8d6AJ
 OTfg05cUo2vmjjzHv7DT4aqYJS+DwUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
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

Refactor to enhance readability before enabling secure IPL in later
patches.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 pc-bios/s390-ccw/bootmap.c | 51 ++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 420ee32eff..03841672be 100644
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
-
-        if (zipl_load_segment(entry)) {
-            return -1;
-        }
 
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
-- 
2.54.0


