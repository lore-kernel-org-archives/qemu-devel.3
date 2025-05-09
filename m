Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BBDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQil-0002AV-Ai; Fri, 09 May 2025 12:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiY-00024i-2K; Fri, 09 May 2025 12:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiU-0000Bm-KI; Fri, 09 May 2025 12:36:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549E70ZI031593;
 Fri, 9 May 2025 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WgAkIjhhyN080c6NO
 RSVhfyoP6B6VhHanQuGf6xvM8w=; b=FQLwmtnyY2kjIs30JbCZn99HCmh8gI1V2
 4aNG579OYphbxgwA5Ed7gXLJ6o183U0ys10aRfxqwcJ4y7kMAahJLDn5/xn5JCpH
 wtU1skZAP71DzZa2nro/lr18YJPJCZUBiEF9UDDB2Tthl29VnMohYWi61jBPraRt
 5JROwJZmLQ4bsAQxE6s8rA3eBlik5XHKHNJ7QSY6qrUGbFZga6aUSrScXdlxWKNR
 5IWG1vH8xLsa4Fy7+Y7rXl4kG+0dKnFRssgwBYMZNXUCjTKr+vxRJ/Af5ogi03//
 a+ksVuGMF+M+NfD2rEYYcSYd0MfKcM7sT6yN4pL3jVV1LwSx6+wJQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwd263-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549GSiiN014112;
 Fri, 9 May 2025 16:36:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm46y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 549GalbM31916740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 May 2025 16:36:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3335358043;
 Fri,  9 May 2025 16:36:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 619C15805D;
 Fri,  9 May 2025 16:36:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.92])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 May 2025 16:36:46 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v8 1/6] linux-header: update-linux-header script changes
Date: Fri,  9 May 2025 12:36:40 -0400
Message-ID: <20250509163645.33050-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509163645.33050-1-rreyes@linux.ibm.com>
References: <20250509163645.33050-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e2f20 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=W0EDWCW3zNCZun0cewcA:9
X-Proofpoint-GUID: uFzKwipTFsTKNDzTDWhKIIxYpym-t5Hy
X-Proofpoint-ORIG-GUID: uFzKwipTFsTKNDzTDWhKIIxYpym-t5Hy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE2NCBTYWx0ZWRfX1Zb4+wgiq6yq
 fEXrOpUJ5PXWAQHKjJax5nuDf8ACBvgHSNf7VxcXiTGfjztl9SyJk7aWB2QKuG8FDfaTi643CE5
 8tyNZ26+X6yRRUAxMUToscmzxdzSjYdvS8Dkv9o5nzLDPLtZzlTB4TSbZcZ6QMeMV1q3chXcXzt
 HEWykh2c1HRl7v87euGiVVdwdz8P/qvgJwGCAxzu0VXgKiyaHSxwHqkkQygV710gftnNDw7K/Cc
 Y1N5YzsZeI2qyBcXBiYE8zgzsUeTevBdQm/rlYmz2ss96mP7sXObpQLAQkJvnrAWBZ9m3vUnnjM
 s3VQReYXVUxxe0tXo74BpyI6kZdT52L4c3wBULgw+ptDjfv0SiAhXFxb+RG/645/WxxdTG4356X
 XPkliZbUsolBs0ZjfITIAfz2HEMkSpXrR0lnIzmlDBEn0kgOeucpgcIvH+FkKzF5Wwbm3dWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=782 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
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

Kernel commit 8a141be3233a changed from using
ASSEMBLY to ASSEMBLER
Updated the update-linux-header script to match

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8913e4fb99..b43b8ef75a 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -177,7 +177,7 @@ EOF
 
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
-        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
+        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
                "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
-- 
2.48.1


