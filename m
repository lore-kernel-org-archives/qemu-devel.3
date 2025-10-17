Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73835CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ozs-0003qy-V0; Fri, 17 Oct 2025 14:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9ozo-0003je-Lz; Fri, 17 Oct 2025 14:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9ozm-0007KP-D8; Fri, 17 Oct 2025 14:16:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9qbCo021678;
 Fri, 17 Oct 2025 18:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gUGibRdBhyAuBPWdT
 w5s7JT+ZuWXDB/7HKJYm5vxDnA=; b=QCxFNOuT6iYugc1Z4QdV9ZIQ5jWHxUsDk
 7Rfpl0N/I4m4H9DHs+e49p9S7JN7L4O9evLcH+a0lOoSMiOLt6prdjUjnnI9QSho
 bOaBwEdMCTMLV7X0tTM+uzd3YZnR9fMGGSqyusBMOUpe9Q3x4HQxTHCZZx5J3th7
 IxEugt1snnBxjAkEzeNRfXQy14gLwN2q8+6XmQGCNrmim6wCdhSgI5fsMr6fdtku
 4YEs78lLb9aeb2rYhUnvUBcVblG+/Enw6wPuB4mqLcaERQHgVSQ2DcUihM4qN4wz
 5QJt8rXdFLPNCml0q/4ssnOdv64Sts55BWHhkqm30RQ6IEP5m8R0A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9cfvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HI4VD9017343;
 Fri, 17 Oct 2025 18:16:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9cfvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:15:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HFbjX3028104;
 Fri, 17 Oct 2025 18:15:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9ny7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:15:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HIFtGF21037460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 18:15:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6815C20043;
 Fri, 17 Oct 2025 18:15:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD40720040;
 Fri, 17 Oct 2025 18:15:52 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.22.45])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 18:15:52 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v4 2/5] hw/core/loader: Use qemu_open() instead of open() in
 get_image_size()
Date: Fri, 17 Oct 2025 23:42:49 +0530
Message-ID: <20251017181250.1421446-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017181250.1421446-2-vishalc@linux.ibm.com>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eKkT5foUCXF_9baURRMIMm2Gg6J3gv5E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX5SzsGqwU8G4u
 tzc9tPmLIAbSJsL9i2U020wsP4ftQfQXSvNuxjSL9K7PNbfH0yg8tUCHNm/VSj+oZDfPbMt2fg7
 g5Q5gzzo6T6uS4v4jkyASQ0N4Vj3uF5+3xYyWwmJU+T+yFsGlF7nEui3BNxU96J1pKuh/o19KwW
 T9yK/2K2l0weZC/MEWhvp2q6gPuKZ+5J10siO1WUvAkHPaseY8bA60IelMa2JNa3ssmVy0uubly
 7xPx7MutU+AaxOnGQMitQqnlFqiA8UZ8Lrqqx/gtEqaVi1aTlbKPUvXpW4XX74QgXRtsCVSnhke
 TPOcHtC08pETxXh2QyynZZ6syIYI4jP5Tts5BCFecIqclgHXIzic2km6HVIrpR8rwnJHJkzHgAW
 oCY1TEBCU+mTG2NxzleW/UKUrpL7Uw==
X-Proofpoint-GUID: AdkGUkH_jDm6dUI4__cgzzgFTLDt-tKb
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f287e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=FjqQsbWZ5CoJ3T9912IA:9 a=3ZKOabzyN94A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, PP_MIME_FAKE_ASCII_TEXT=0.338,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace open() with qemu_open() which provides better error handling
via the Error object, automatically sets O_CLOEXEC, and supports FD
passing with /dev/fdset.

Remove redundant error_setg_file_open() call since qemu_open() now
handles error reporting internally.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index e40cba1b9f..030f832e54 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -77,9 +77,8 @@ int64_t get_image_size(const char *filename, Error **errp)
 {
     int fd;
     int64_t size;
-    fd = open(filename, O_RDONLY | O_BINARY);
+    fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
     if (fd < 0) {
-        error_setg_file_open(errp, errno, filename);
         return -1;
     }
     size = lseek(fd, 0, SEEK_END);
-- 
2.51.0


