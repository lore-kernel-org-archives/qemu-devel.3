Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA37CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHVY-0007X5-WD; Fri, 24 Oct 2025 09:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHVX-0007Wa-LY; Fri, 24 Oct 2025 09:07:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHVU-0002w5-TF; Fri, 24 Oct 2025 09:07:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O4hwn7008513;
 Fri, 24 Oct 2025 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GjZUm3
 6zIlxuvlX5yniRl5OGta2DnXEjj3KtIROiwCc=; b=jr5SAuDz5hcjIG2xmzWZ0K
 CKnuYH+IIF5VSsOjn0Eo1MEbZJ4zjr1+mDZ/fMoPImNOpbJdu3ZrC/ehvdgAqMec
 IuI13XboA4R/6zBCN0tEhtETJogHn84yK6g1WAUiJc/4sVStyVPqlusZcMRqFWWr
 P2unnpQGP/ZXjsAfm7N8919vcpcbOGxVW7SUvGcuXaTSMxnWKXY8WOWYXE0zQukw
 8D/NTtmceC08Ov0UfHv1Kq7L6Dq+rfhOLN3zQITLz7JiTw9fnyGJRtLMHs4OrbfA
 QGNXdbuDDKHPUrKBZhn1j0QATgCitvwFtOHa16hoaZGO1ATAtNTRB00FfA1ZCPxA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hwrbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:06:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OCxBiT010114;
 Fri, 24 Oct 2025 13:06:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hwrbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:06:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA0uuL002320;
 Fri, 24 Oct 2025 13:06:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejtyum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:06:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OD6p9525624942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 13:06:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E577220043;
 Fri, 24 Oct 2025 13:06:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9096D20040;
 Fri, 24 Oct 2025 13:06:49 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 13:06:48 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Patch v10 3/6] core/loader: improve error handling in image loading
 functions
Date: Fri, 24 Oct 2025 18:35:57 +0530
Message-ID: <20251024130556.1942835-8-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024130556.1942835-2-vishalc@linux.ibm.com>
References: <20251024130556.1942835-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6WazJiSI1hOx
 L7dT0SUK6KBvFlLKJuDRuTwVGo5j3qSx8FcNYPmlJoy4xmXWjBo7vtj08LzVRbvPP1PZmXDMtiu
 T8VpfgYH4c8aNhePYAl3hwzWiHItBWjE3+as94Xn4RwdYIMfUPVMUbroNIs3aLMCIfh7sPXczK3
 088UpAEBJHJLgiS9//Yo5B817r4KcRuS4VKvqdSljjcuF8JyOkqWutuGwfquLgit6LevD8q9jII
 oL7BWGZeiKi90XO/4dd4FNWNjB2YHFY5d/OUjXfc6uEAnTivkC8y+cTHBwzV8hBO2c4e3yY4WRA
 fQqNaLhXG42r0TbnOiEaw1mhZHmMUt1Rx6N8EHn4dICWLIxOCit7FxGcifDKQda1PJmG9PMAPwA
 O9NQWVMzUEvghIN9HPUs064QRWwgXg==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb79f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=ENWgr_On3KMaAUHH0hcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EASlZlyhEEOer9tdjj_KMkaPhiyC9GaM
X-Proofpoint-ORIG-GUID: -1bNlaDQgg7N9fQnkA_2IW625_owmj_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add error checking for lseek() failure and provide better error
messages when image loading fails, including filenames and addresses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 7aca4989ef..d7c11c18f1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error **errp)
     if (fd < 0)
         return -1;
     size = lseek(fd, 0, SEEK_END);
+    if (size < 0) {
+        error_setg_errno(errp, errno, "lseek failure: %s", filename);
+        return -1;
+    }
     close(fd);
     return size;
 }
@@ -132,11 +136,20 @@ ssize_t load_image_targphys_as(const char *filename,
     ssize_t size;
 
     size = get_image_size(filename, errp);
-    if (size < 0 || size > max_sz) {
+    if (size < 0) {
+        return -1;
+    }
+
+    if (size > max_sz) {
+        error_setg(errp, "%s exceeds maximum image size (%s)",
+                   filename, size_to_str(max_sz));
         return -1;
     }
+
     if (size > 0) {
         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
+            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
+                       filename, addr);
             return -1;
         }
     }
-- 
2.51.0


