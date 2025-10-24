Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82DBCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 05:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCAL6-00036k-Ok; Fri, 24 Oct 2025 01:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCAKt-00033w-QO; Fri, 24 Oct 2025 01:27:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCAKs-0003Mv-8C; Fri, 24 Oct 2025 01:27:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NJfiG8015962;
 Fri, 24 Oct 2025 05:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6MG5H2
 rdn6AOGLT3/QofZzQfvud8goyYPy2TUqKhe3w=; b=QXCRQbaXaUtXfAxjAWohcN
 XFYeeMpJKpXY8vMT2aDfIKCJ8OSa5g255eDvaKPnxRLqbwo/uyPws+TA0AjEY0dg
 iCJK0tXghhRkwSEYAjpxn5qj/kjQnA3bKtwRDxddvdtCImGGlgWK2II3IJ09FZqC
 aASm+WdotyMP7E+PeN+MzI30vCsIDnMvL/vGYMyfMbaKbROoLxNTN6WLBVRjhbK3
 /0U+R4MkhuKG5cDUHytNfgA5W0En5hOGbXLRpbQwJrsD8XTkmsYoPikeFyVLCSJg
 QY7mi88cVUWE+0OUo+lsPEpQVr0O+vobwTJUHt3jsOVEssOoT2KeC6q9uFT6EHsA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3275ra6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 05:27:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O5OBYM012187;
 Fri, 24 Oct 2025 05:27:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3275ra0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 05:27:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5IcJR024690;
 Fri, 24 Oct 2025 05:27:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk9fxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 05:27:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O5RNNs35914076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 05:27:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32DD52004B;
 Fri, 24 Oct 2025 05:27:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D749420040;
 Fri, 24 Oct 2025 05:27:20 +0000 (GMT)
Received: from vishalc-ibm (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 05:27:20 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v8 1/5] core/loader: Use qemu_open() instead of open() in
 get_image_size()
Date: Fri, 24 Oct 2025 10:57:03 +0530
Message-ID: <20251024052707.1852358-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024052707.1852358-1-vishalc@linux.ibm.com>
References: <20251024052707.1852358-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb0e41 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=-CUL7ttSjCJlytmGOe4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1UWDvW2od5so
 ZvaDbRop8/9dnmDm6DwzIYbZIi+OfmHiRWURhzpWxbRuvzgcbCiUROauLGFLvc/bmxHhk1wGgVi
 N2+14VXNrKsayb6JWxnwSeh1A50JBbDP3hEOYZeURjxoCSQGFFEGphtmb6gPcAEsrURUEjJPLuh
 vezvfiBgrleVl3UVxcU4LmUkxDGSUz7Ougtl6g/OpzazPsfP2IQKKo5rLX0DdSXirY+CIXz5PYN
 I+pXXqLGoBVmNdC+LsXxMvyaPUcOsDqk+onk7kjHgkwect31ESISaBAqhUuSfTgip95mE4GISBT
 EEZAKYfSkgGv/CNNjF4CMTHU/Fz5A4Ckp/p8JaBRVRESKyKZgFiU1q9+qjJ4xilSDILOuaEJszs
 +pZnKO+KtvO8lv3ldB+XtJTZItnTKw==
X-Proofpoint-GUID: 7Va58UIv2pW6Qd3oh3fNFSFabUpjbWck
X-Proofpoint-ORIG-GUID: yeWgtTAWWor4yu1MrpeuPX7ZNHUNJZar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

Replace open() with qemu_open() which provides better error handling
via the Error object, automatically sets O_CLOEXEC, and supports FD
passing with /dev/fdset.

Currently pass errp argument as NULL.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 477661a025..c9782d67e8 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,7 +74,7 @@ int64_t get_image_size(const char *filename)
 {
     int fd;
     int64_t size;
-    fd = open(filename, O_RDONLY | O_BINARY);
+    fd = qemu_open(filename, O_RDONLY | O_BINARY, NULL);
     if (fd < 0)
         return -1;
     size = lseek(fd, 0, SEEK_END);
-- 
2.51.0


