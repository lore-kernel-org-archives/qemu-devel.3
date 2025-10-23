Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D920CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkb-0001PZ-GW; Thu, 23 Oct 2025 07:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkT-0001K2-SL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkR-0001bc-UV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6rB3V010978;
 Thu, 23 Oct 2025 11:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=F2zvCZZKnwkSIy2nK
 4nOujNUpszAHJy7OIMaxanqzYs=; b=mFllwbn10lGYIwPNjiQHgl2dXUx7lM8XA
 AP38+YoRggucssqFCK30j1vmFKOl925/azQRX73uIXwUjdW3A9V/eCValCwO4NzG
 Ox+r734i1nwwDdmoEXCiTNgPBvLDnE790K07gUEn/xymtbMPawxbq1RZAz7zBWJb
 OMaaVAJLroU0c7gaoSOB48xKvr4coxcsqBrdV5vlx0bbpJJ75ez24vfYbGiG2E+F
 nwg2J/ZdTzJE4rSsB4xZphxh9gkt3IaNHqZtfgJDJUTEdyVBYULPBIVI8ScBl1M9
 +oQ/0Fsdnl6J1dEdQSdrzd4qRPJXapoSH4ZD4Te+HmkF9r1i1R5pA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fhx5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBEt30002306;
 Thu, 23 Oct 2025 11:44:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejn9vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBijrg57606408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E8962004E;
 Thu, 23 Oct 2025 11:44:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A95C120040;
 Thu, 23 Oct 2025 11:44:44 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PULL 13/32] ppc/vof: Make nextprop behave more like Open Firmware
Date: Thu, 23 Oct 2025 17:14:00 +0530
Message-ID: <20251023114422.3675018-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa1530 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EGYj-OwPAAAA:8 a=VnNF1IyMAAAA:8 a=7LDE652QjO-iVNhJKY0A:9
 a=xQyHFheebwQZ3wMG2Lhb:22 a=oH34dK2VZjykjzsv8OSz:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=UDnyf2zBuKT2w-IlGP_r:22
X-Proofpoint-GUID: HmqfAXncq3HcjOyLXxcrHh6xEtL8fBa5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX01U1idoARlj0
 q5Wt/38NQTo0W6StQgZ5/QUrpTTi66FKBdsH9sbg5bu93WwqFQNfiEF/P0CvCHgJsZVMLONO17c
 MwdNUonwEh+fICW8HTUO3XI8POCon6XNeA8lggnmWncxR1U6hqNZrGa1ElG5RWzecNbWipOZLs+
 0y7/DW3y2TAi2zFjnXkRRz39o/qm2CgiIL+bNR5ghvLphnbo4eN5NKFTUA2Vtj4flq+x8ykc/LS
 2hR+IEDVoMJfBbl/uyrAOSKkFm5agethVW8v2rl7RQN61lT+u/VfD8JvhZcdSInbQqLUeGqfBzS
 HYVcAmKNBdZ+xCwi7/Vd/O/JdTPmsEH0zhGMWHC5mPCzD6hykKV+NmPbKnOc7rZkKXoiY6hLJjh
 tEVK08niZ1veeWdsoVA1wEGJIYmlRQ==
X-Proofpoint-ORIG-GUID: HmqfAXncq3HcjOyLXxcrHh6xEtL8fBa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The FDT does not normally store name properties but reconstructs it
from path but Open Firmware specification says each node should at
least have this property. This is correctly handled in getprop but
nextprop should also return it even if not present as a property.

Explicit name properties are still allowed because they are needed
e.g. on the root node that guests expect to have specific names as
seen on real machines instead of being empty so sometimes the node
name may need to be overriden. For example on pegasos MorphOS checks
the name of "/" and expects to find bplan,Pegasos2 which is how it
identifies the machine.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Link: https://lore.kernel.org/qemu-devel/366f14ce852415cc079727c54ac21a2aa6ff3917.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/vof.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index f14efa3a7c..5ecfc68910 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -353,34 +353,50 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
 {
     int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
     char prev[OF_PROPNAME_LEN_MAX + 1];
-    const char *tmp;
+    const char *tmp = NULL;
+    bool match = false;
 
     if (readstr(prevaddr, prev, sizeof(prev))) {
         return PROM_ERROR;
     }
-
-    fdt_for_each_property_offset(offset, fdt, nodeoff) {
-        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
-            return 0;
+    /*
+     * "name" may or may not be present in fdt but we should still return it.
+     * Do that first and then skip it if seen later.
+     */
+    if (prev[0] == '\0') {
+        tmp = "name";
+    } else {
+        if (strcmp(prev, "name") == 0) {
+            prev[0] = '\0';
         }
-        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
-            if (prev[0] != '\0') {
-                offset = fdt_next_property_offset(fdt, offset);
-                if (offset < 0) {
-                    return 0;
-                }
-            }
+        fdt_for_each_property_offset(offset, fdt, nodeoff) {
             if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
                 return 0;
             }
-
-            if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
-                return PROM_ERROR;
+            if (strcmp(tmp, "name") == 0) {
+                continue;
+            }
+            if (match) {
+                break;
             }
-            return 1;
+            if (strcmp(prev, tmp) == 0) {
+                match = true;
+                continue;
+            }
+            if (prev[0] == '\0') {
+                break;
+            }
+        }
+        if (offset < 0) {
+            return 0;
         }
     }
-
+    if (tmp) {
+        if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
+            return PROM_ERROR;
+        }
+        return 1;
+    }
     return 0;
 }
 
-- 
2.43.5


