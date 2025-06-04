Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65207C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw87-0003VX-1u; Wed, 04 Jun 2025 17:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7M-0002q4-Rq; Wed, 04 Jun 2025 17:57:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7J-00071b-W4; Wed, 04 Jun 2025 17:57:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DUSud017169;
 Wed, 4 Jun 2025 21:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1+5cI6lEdCaHn9Lqg
 V5yspkSvcmQ1F9vmPI1tYE8XrM=; b=bo50PMQgctyXDfedTpz+bh6OcIO2BMuVk
 IPA21gdmW+P+reS6i+7TfC4mFi4CY71I+MAxDMaw9WkprWB3oHH9NUz6RyB97te7
 qUxSjamxIN7ZdShBXC3hafjEknbY/f45r9QSkc9M3l5HNhPmmp6jjU4iuns6JTDp
 yESMwxYX3olkk292DxTR3trEHBeDxaZ9T2VLFXFvRJNq6y4r2gz8MjsGQBkM8d9i
 EaS3/vtmbkj9lRudW7Ij3YjCn+eGJVvmIVxJJCeANWw+yG1PcYBJX8wXdaR22Pj2
 VxuT0D7+oDCHNkrD5MUKIkJAiTE0vqLKyYxL3lyG4CFA0D51jis8A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwums26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554J0g1X024904;
 Wed, 4 Jun 2025 21:57:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmhs5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvknJ24380026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086FB58050;
 Wed,  4 Jun 2025 21:57:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 026F958045;
 Wed,  4 Jun 2025 21:57:44 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:43 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 18/28] pc-bios/s390-ccw: Refactor zipl_run()
Date: Wed,  4 Jun 2025 17:56:46 -0400
Message-ID: <20250604215657.528142-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX2meLTDo+jKNH
 khXlD4JUcMzP5MjFSej0rM0kZb7xUTRKBzQDtUVBW58QdDS3yluDQVpj4Ap0S3ACEx+BdgXbw2E
 CGUf0xaxW/8KgYGZyu9yJf+aZz/vxnhSHGMeHZF+noWH3Tekb0nJ+m3Ar/bCyxSCB6ROEnLx4UO
 gcsKuBea7rLB5xwEC/gddPF6JjR8GljM9Z8FgAyneWbtfG79DeDmCTon6LvjQmcZUxN9GFCd31t
 NA5bhpOTBA3Q2e7wcqXaKeUxhayHZPqwyhfCNNNCH3oAhI9aEbICLk1r9GMmHlcBsrPWIa7+IGu
 9BLPXkOajTfkAR/DzibVGJ6lSPLpbFtGlk+U5LUQAi17+Usk48HYX+GjOAkB62gv8kZkQ4qPaN3
 9B4dl6k04wHK3qczC8HMU6uIufEMpVsTcDVGlELKwdGwBPBEZQhQqFR8HoSY8/ca7kQtHzk6
X-Proofpoint-GUID: aS8lykRfVA5dsciu71KJn7xoigeTkQtR
X-Proofpoint-ORIG-GUID: aS8lykRfVA5dsciu71KJn7xoigeTkQtR
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=6840c15c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Ew_Uh9inpcQo8UAwJ4EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


