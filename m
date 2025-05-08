Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FBBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5y-0004m2-Hs; Thu, 08 May 2025 18:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5l-0004NA-M5; Thu, 08 May 2025 18:51:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5k-0006WM-1t; Thu, 08 May 2025 18:51:49 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Lgnl8032254;
 Thu, 8 May 2025 22:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tzajt4atNmLGsvtvU
 Yh3f45q2X92miJ9mnh4j6XyCpg=; b=ERqio/xG/Cl+mlFERgKLOAb9w1JPH2iOW
 EbD07xHM8BIEAttybHsHiP5/tk20GCKnFC+yNwHp524rPeYXMClM5HyDQDV19Tv+
 XSLVTYA8gXp6EVJW7X31FgEx20nTzbdXvpuJjrMQNAmLxRuJFS+MB831+uwTkZlM
 eYyH4jgaeBULFE1F6RSosGWGvNMT2oe9xWGQ8AYCDdJSE2pm58kDTVJuBvRRzJLo
 98v4MGtqbRNmyY1Uv7DhwF9y0H8afb2smK1DVQpoN1LcgEgxPNb1/ZMyDvVEmfcL
 adUWow3Zp0lIBgG9fIyQJ40Urs8xWebJFZX8WfRdeM50TSNE3n0VA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rw87yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548MExV3014167;
 Thu, 8 May 2025 22:51:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkyuy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mpivx27853544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC9E85805B;
 Thu,  8 May 2025 22:51:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CEFF58055;
 Thu,  8 May 2025 22:51:42 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:42 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 15/25] pc-bios/s390-ccw: Refactor zipl_run()
Date: Thu,  8 May 2025 18:50:31 -0400
Message-ID: <20250508225042.313672-16-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681d3582 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Ew_Uh9inpcQo8UAwJ4EA:9
X-Proofpoint-GUID: zPycdQqwE9sY_4L9-f_Leyjs0YbitlYR
X-Proofpoint-ORIG-GUID: zPycdQqwE9sY_4L9-f_Leyjs0YbitlYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX4lrbtw9KNU0+
 HDTOOKCIUYLM5+2kP8bLuNTVdhIq2g0ypxOyN/Z08tnovcjCEISrv/2rQnchnm6G4bJrmMy/xLh
 4qk2notzwjEBPqf01B7cCfKSYxnLgYdb3pryYHDuq5UuI7SRltpaWL+al0GWMZQYVF6AHnlFYNx
 gi0tUDsLxvDttyBPAjgXkL3GXClO9UJPgzBMwe4br4IlklaZZ0zKkX5dXk2CMaaSp7ZD07NVtBB
 j5qtQBETAl7uld8Mc9KZ9H1EXD7p0rjCBT1wJbU1xrxeOYQvydPKFS/w97VlSjlCuosTk2vW/6y
 4K4T3r/NRNYWVUqdqWEkpKLoSlAAsN3NkYxX17IiUn7bgZ4Jf7Sb6nwcMSKxaG9IdPKuTLtuZdt
 gS5IWPZisYTKxcXgsp9C3dDF2ocjnQrIqHggyxhlUA0ckCzahuf4W8KeRNY6derQ2D/Zs3gl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Refactor to enhance readability before enabling secure IPL in later
patches.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 58 ++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 0f8baa0198..485b55f1bf 100644
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
+        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
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


