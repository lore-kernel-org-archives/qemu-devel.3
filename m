Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D2CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHVk-0007aJ-6Y; Fri, 24 Oct 2025 09:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHVi-0007ZT-5U; Fri, 24 Oct 2025 09:07:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHVg-0002xK-5S; Fri, 24 Oct 2025 09:07:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OB5mEV007202;
 Fri, 24 Oct 2025 13:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TshWin
 lQgx6YbPeZVFr/XGgoqLlWgLsvZO6Zj12+51U=; b=I+8ugkZqSqnArivbPs1RSh
 yjcOGJxpFiTCk1JAQIxm/CojqK+NC4v9H6vpOVhzFc4GXfDm38rgyF0xOBEH5Qye
 1ebg1vIq1T+sLCHKAZ0JnLxAnR6uovyvGp4/AgGIICcSrppBGrF34HNyDhSFItBF
 DkDDOengiOiRT0k7wsk3RGF4sOY1b/zNWuS6X6ySlUlglDEhmd9NjmFRTYnn+j/+
 0J00EcWjg/uQwa0nu8JxNqphSLwF5sGQEM35yHsfKrVFujePgMqUTkQLjWqLR0XX
 gPdd+hUNAy8TpNT9nc8Ms0e8SgjDC9nppE1VZi8ZKVALzEHREZVAp+XveEDGz32Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w5tgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:07:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OD77qr020788;
 Fri, 24 Oct 2025 13:07:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w5tgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:07:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OD5P5W017067;
 Fri, 24 Oct 2025 13:07:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkyba5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:07:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OD73to45023654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 13:07:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22A9620043;
 Fri, 24 Oct 2025 13:07:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D5A820040;
 Fri, 24 Oct 2025 13:07:00 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 13:06:59 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Patch v10 4/6] core/loader: add check for zero size in
 load_image_targphys_as
Date: Fri, 24 Oct 2025 18:35:59 +0530
Message-ID: <20251024130556.1942835-10-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024130556.1942835-2-vishalc@linux.ibm.com>
References: <20251024130556.1942835-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SVx4_a73j7T_8KvMbt2C5JFhTWm1AAtP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4k+NJgafoHCo
 7yHPj8i6PYtnYTCyK2Vlewx7eoDPvXdaSp4R6qWCK7pD2dVy+oME1SO94bNtwj5vBLKVAgO9Psx
 9m2vcyVX9t3zev0kh0Tf1RVdZEz+A7uB4vLuZ4RI1hg+nGawORsCj6ttr5YXvwONe/BPyf4jy2k
 eRHzMKpqxn5F5brK8rbKuYYNQAS9+FaA5/T3SKrHe4PrtfvNPLp/xqOXhMQ2MOzEhF5tD8L+ATo
 KpGXNhP9oHV5nMW0eS0dbWl9kohEWJ+SlTKweqMeVGbTFdKaGRcVHBA7/5XHBAkUIoVtGM5V8zo
 Ebjc9IFRX/D1jDVrkt0MWmmZDzPjI3TvSGoL2GdMX59j2Sty3l93AvWqx+UKWB4dkvSd6T3kLlm
 eSWrn1BZi+ufCicIcTMFFjj9BGFH3g==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fb79fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=hY9edZusZr6h984EAK8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: P7KN0czt_JTfZVzl6HNk2CDJTeV8MPi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
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

Currently load_image_targphys_as() returns -1 on file open failure or
when max size is exceeded. Add an explicit check for zero-sized files
to catch this error early, since some callers check for size <= 0.

Also, remove the redundant size > 0 check later in the function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d7c11c18f1..590c5b02aa 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -140,18 +140,21 @@ ssize_t load_image_targphys_as(const char *filename,
         return -1;
     }
 
+    if (size == 0) {
+        error_setg(errp, "empty file: %s", filename);
+        return -1;
+    }
+
     if (size > max_sz) {
         error_setg(errp, "%s exceeds maximum image size (%s)",
                    filename, size_to_str(max_sz));
         return -1;
     }
 
-    if (size > 0) {
-        if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
-            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
-                       filename, addr);
-            return -1;
-        }
+    if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
+        error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
+                   filename, addr);
+        return -1;
     }
     return size;
 }
-- 
2.51.0


