Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D2EEA84B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdXm-0000aI-1C; Thu, 12 Feb 2026 15:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXj-0000ZL-K6; Thu, 12 Feb 2026 15:44:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXh-0007Hr-TT; Thu, 12 Feb 2026 15:44:07 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CE4iRZ3960062; Thu, 12 Feb 2026 20:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+ct+Bo
 gSyFgZWEg49LroT5KVQNSI3oELW0UUPQ1ioqE=; b=ZosxMVqRzDGluwNUEOD8vP
 QXPJlwzhMTAtIpR1uhNyA6eguOnY/vKsA6P+NLDUjCqtnI3GAXTdrQvc30zBBHjv
 UhP1eO7eR1G6j/99QUi9fP7c34QpIQst+1EUFsIJmPYa1Pb+gSFTLzR1fXH9iLbn
 Zxbmunv7VauNh9+SVfR3fcsAAA4yTmqqPVzax7F5lNpBkCrylDcyZyIMbfIUbe16
 jOnjGdcT3ZB/nPT2jDrQ9Wkhwpmu+SsRso4tvBnXFNHZNiA1znWaiQm8hLuBVLZS
 Ck6P/LJ3NqetGLz2Ym4gZ7ORj2lwW4Fn0Ou9jgkzwPK1kj5yQJV7PyTe8RIvwkEQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x5c0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CK7S6r002570;
 Thu, 12 Feb 2026 20:44:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsvbgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKhxbN33227454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:43:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15DA85804E;
 Thu, 12 Feb 2026 20:43:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D06258054;
 Thu, 12 Feb 2026 20:43:57 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:43:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 02/30] crypto/x509-utils: Refactor with GNUTLS fallback
Date: Thu, 12 Feb 2026 15:43:23 -0500
Message-ID: <20260212204352.1044699-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698e3b91 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=FUyA0-9y5A7gcD0mOlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KzS9zmfEmwMCsgKTITyZyulZa3QHk5P4
X-Proofpoint-ORIG-GUID: KzS9zmfEmwMCsgKTITyZyulZa3QHk5P4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfXwgDy7BaGpLlP
 tMLFdewzbtiViGoNa4UpoP1LaNLXSIpdss2n9zbr7b3TdeWALLcV6VHSOtDJVVNOno4NJirVuOB
 8HdQefJnU2gD/RSOdOe/j47qSBiUrJoFd4U0Bxp6iECd9comOiJ/gsWT9iA72q2nqbLKclwQ762
 WS4FzbCzPlLR8jPAtShhIxF6vWkKPJZigGanoy0BNNmmpdqhcKuzEmkTKMFG5mPjt1l7oiTctY+
 wFdJjuvTx9vIxV8cqir3M8KuX2F+SuhL3BZe3FRfiDbMxAkmjJjbqVXUXhJ8/E7eQc6Xa30yrXM
 3eEkkkU6jfpU+pa2pjgQibe7DLTHpt4uVpcZepeYvo7UmdBnCFoSYefI5Hz7iYzpIBHhOl+fZx6
 +e/YFIPFTXELb06vW8DCjRrrDuLge9CScPsyKkmdTDT1b3sJhOnv/0fg2eHOI+ZuGZxSUve/gae
 c/0rxEsvFF6O6JWcJlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
2.52.0


