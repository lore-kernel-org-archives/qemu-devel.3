Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADDAD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSir0-0007Gj-U7; Mon, 08 Dec 2025 16:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiqr-0007CV-5q; Mon, 08 Dec 2025 16:33:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiqp-0000aH-Lb; Mon, 08 Dec 2025 16:33:00 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8AaZXn018892;
 Mon, 8 Dec 2025 21:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IAyXx+
 b8IBfOB/oSEacU4Q1xsFX1zk+VPH292IUJhEI=; b=lGqVDVht5tUJUYAw8T/Rre
 60IDVN9PLkVm7Uy/l/rAehK+6DOxwqBZAPR6gPMRRLFLPgrMhr8X9YlLFTKzy0BX
 Yd+QXNasup/qnD/h+nHre4vHUfJjpCSVCdXYMQnPoIWnHO6nlGDJHga2QYjZ+AyU
 xhOG22cCdAtb6ETyecIeJgk3Ik+oWdazWjhyrswMozF3+6l86Do4Iejk5pk0PyIk
 7gEe9hgk7LIZwZzlQpsP14gangAtBloPqLDdgR/dXfXh/YBJV0DztvE4SqTXdS8a
 T3dtecetV18Pjg69iPy2/uzZMfZqV7E7TRvDgGVTmYjckSq6fm05tqyHkjT2MwvQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jsumc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:32:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8LV82q028141;
 Mon, 8 Dec 2025 21:32:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xqvwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:32:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LWr0q63570416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:32:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D274A58058;
 Mon,  8 Dec 2025 21:32:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1840558059;
 Mon,  8 Dec 2025 21:32:52 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:32:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 02/29] crypto/x509-utils: Refactor with GNUTLS fallback
Date: Mon,  8 Dec 2025 16:32:19 -0500
Message-ID: <20251208213247.702569-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69374408 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=FUyA0-9y5A7gcD0mOlIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4fQ-5DQx9q5QeohXNgzvjbC78Y50ueBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX3B6n9LBfZ96X
 nvsTfLtE/3oqPPMZ3SCVIc6oZFXc8DMM5xDSDIz+uwJetAGsJR25hx1Oh2pw+RIF2dzOB7q40Er
 mcpqUOphRnE03UfqbTWKiy977n0RR+V4IBXkkNNH95VDTNF7Qm+ENV2TA47eDZwBz6Zs1usVFyM
 qIFwAvH3YBCAtN+EqFV1ycBffCDtwhJUi1GnDMvWVz/D3RODTuVY0ulUZiuaN+gS7O844E0+vfC
 LMaOjMryB7CqxMunaia8wd9NI0ZxiUnGiRfaLopCjnsGJiwxULQKo5o46PFArOqMIWSiC98+s0c
 yamCOE3ri8a/wlmSa+ebGWF894lXfafnltw31e6Hy0bA8TexhUd40/nI/bPUGHV2la+2amz6dtk
 LW4tlFNKn3e1lEj24sYbe/BEkzo+FA==
X-Proofpoint-GUID: 4fQ-5DQx9q5QeohXNgzvjbC78Y50ueBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Always compile x509-utils.c and add a fallback when GNUTLS is
unavailable.

These functions will be needed in the s390x code regardless of whether
GNUTLS is available.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
---
 crypto/meson.build  |  2 +-
 crypto/x509-utils.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/crypto/meson.build b/crypto/meson.build
index b51597a879..fda85543de 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -22,12 +22,12 @@ crypto_ss.add(files(
   'tlscredsx509.c',
   'tlssession.c',
   'rsakey.c',
+  'x509-utils.c',
 ))
 
 if gnutls.found()
   crypto_ss.add(files(
     'tlscredsbox.c',
-    'x509-utils.c',
   ))
 endif
 
diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 39bb6d4d8c..6176a88653 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -11,6 +11,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/x509-utils.h"
+
+#ifdef CONFIG_GNUTLS
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
@@ -78,3 +80,17 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     gnutls_x509_crt_deinit(crt);
     return ret;
 }
+
+#else /* ! CONFIG_GNUTLS */
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgo hash,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get fingerprint");
+    return -1;
+}
+
+#endif /* ! CONFIG_GNUTLS */
-- 
2.51.1


