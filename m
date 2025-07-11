Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F84C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2L-0000yi-DZ; Fri, 11 Jul 2025 17:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL21-0000jH-Kp; Fri, 11 Jul 2025 17:11:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1z-0002xJ-SP; Fri, 11 Jul 2025 17:11:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BKppSF015626;
 Fri, 11 Jul 2025 21:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1+5cI6lEdCaHn9Lqg
 V5yspkSvcmQ1F9vmPI1tYE8XrM=; b=AG6Zl9Z4O4jIOBTw2CEV4OquTx61Vg53Q
 m+ZaUQPT9PNMoz2U0TpyO+HA/uWT7BU1PyaxZ27p6xZO3uFnbcREyVRmhRKm4aIw
 v7HHGUY1qAsmrEvBnGqv3WJ94pW2IJgX8kgk96djnsNorQ++LOTxjF51l0mGOlWs
 UVu8CVVo5zw+ZdNgM9DLLB/XKNc+ijmLU0iCtsyd3gvtwlI717t2GaEiDKw54S8b
 GcBxWwv94ZOUoB8r14Cy6b34Szo7un+ieBTLXczf0JKL0cXlIhcg76D2ZbHhO+pN
 CjcgBeQDMOfyy7xj7QtYaXmwksyCYiBPObgF73zShpbL7Yuc9fDIQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrm31v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BK5QPO002888;
 Fri, 11 Jul 2025 21:11:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmvecw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBeTh7078638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E240458059;
 Fri, 11 Jul 2025 21:11:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71C445805C;
 Fri, 11 Jul 2025 21:11:38 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:38 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 18/28] pc-bios/s390-ccw: Refactor zipl_run()
Date: Fri, 11 Jul 2025 17:10:54 -0400
Message-ID: <20250711211105.439554-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=68717e0e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Ew_Uh9inpcQo8UAwJ4EA:9
X-Proofpoint-ORIG-GUID: 7xKvU4oN1FWvG9vl9tQnY9qjQJi9AQlx
X-Proofpoint-GUID: 7xKvU4oN1FWvG9vl9tQnY9qjQJi9AQlx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MiBTYWx0ZWRfX8Kxbyk9dORhG
 F/U0W5rYXf+u1zvM4gQVSBKe+vpfq/7zE4GhqlJ8eiRinSWj0l+NHxKhM/FcX72sB3lEtjtNjH4
 OJ6pR996GclSqLFgTXgEJk4UCGfaCA8tkWPWMHVZV+d+2BERfhtmr4RlOUex7DJ+mtyCe5do/UV
 A0FmDsZfEm4J18LSXr8YhK/Eq9tTm6dCDZD8p3sFa33HoT+lSuDeLHQhiA3XnB0p3Mk6AwqAMLj
 EcdVEL0uIr+JwT0iCi2N4fFbtsmcvwTUwcK5gtF22bp1kCV/9XJWwEzBltRtKgzQ9G6h12a6xj4
 QbCuQuN56gs52U63DAt8dGGDMKc6yfMfqD67ErTN8mRnktdC/5K31SdT7dml9Mjb7+46+cntQDV
 7Cy73156x+GZflD7sWANWRJtDi51EsGPCdUtHu3PysZ9dbLDocHidsGCPvPcameT2Xz99Cul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Refactor to enhance readability before enabling secure IPL in later
patches.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 58 ++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 0f8baa0198..ced5190888 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -674,6 +674,38 @@ static int zipl_load_segment(ComponentEntry *entry)
     return 0;
 }
 
+static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
+{
+    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
+        entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
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
+    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
+        puts("No EXEC entry");
+        return -EINVAL;
+    }
+
+    write_reset_psw(entry->compdat.load_psw);
+    return 0;
+}
+
 /* Run a zipl program */
 static int zipl_run(ScsiBlockPtr *pte)
 {
@@ -700,34 +732,12 @@ static int zipl_run(ScsiBlockPtr *pte)
 
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
-    }
-
-    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
-        puts("No EXEC entry");
-        return -EINVAL;
+    if (zipl_run_normal(entry, tmp_sec)) {
+        return -1;
     }
 
     /* should not return */
-    write_reset_psw(entry->compdat.load_psw);
     jump_to_IPL_code(0);
     return -1;
 }
-- 
2.49.0


