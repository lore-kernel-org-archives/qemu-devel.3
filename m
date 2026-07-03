Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F233C44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhG2-0007b1-HB; Fri, 03 Jul 2026 13:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhG0-0007Zk-5S; Fri, 03 Jul 2026 13:00:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhFy-0002yT-L0; Fri, 03 Jul 2026 13:00:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIXUc3382732; Fri, 3 Jul 2026 17:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SRItF3
 Rpj3r/qWUSqrHn8Lr/8FzyN807OwVIui3tyWE=; b=FTDP0vP0PPrBLmhjmre/mC
 xbXBoLyCnCMgrU2KfmAZ+Y1p2jRF19v27a45TeU10fLdNcNEzDe7sDV/F1usMzpL
 ksmHxGGyCTu2jvdcQ4calRUUdDLZ1EMdpaUAfjempK648+qDTv4vTC0VTCve43cr
 kGENwMSwjF7Cobpn/h3HOUyeuNwr5pxPjPr1cLNs8XdIxgMAslnDBrYPxMgplI6m
 0bDwSuL+Qb6oBHP0KbpC6+wrKi3ryQN+SRg2kqJwOSo7YdZHzLxyqdmcnBwbsyq2
 FkvDsut5tMNbKrEhOBT2NaR76xBaBA/x5e1NXDjancrH75TXW6TPw9vZE/5xt/NA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pegaam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:00:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gnd00031495;
 Fri, 3 Jul 2026 17:00:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhysg6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:00:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H0hBN31982148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:00:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86B9558054;
 Fri,  3 Jul 2026 17:00:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 187515805A;
 Fri,  3 Jul 2026 17:00:40 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:00:39 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 02/33] crypto/x509-utils: Refactor with GNUTLS fallback
Date: Fri,  3 Jul 2026 12:59:59 -0400
Message-ID: <20260703170032.1893204-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DP40EYMLtQRe6735M_AGeG3tzbB_-UNj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX+x0/7glYlkr+
 H5oGxsoWyVPLNMKarooqSjjxbPG6s53N3/vUDBwT4xpPujrRr3RzjgzkHC6q8dlvFdy7rWkrtU5
 TIspBncs5Bh1/zwBi/HbBJWBo+cxZIA=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a47eabd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=FUyA0-9y5A7gcD0mOlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX6k0pOgh29y0j
 KtGWoAUuVti2qMrqILkEVKHBIidUsciRtYGCN5kA+X5xfcRJTb1uqq5bQhMDBaY2gGrkLld9Xw6
 EZTSCoslzLygWRVY+dOhcXR9qD9KS3Fz/AdBvOthVMCh1IbNH13hTk7aicSTAAym9TPpu7haOfS
 yUTcgUrkGBlZ1amIRfqDsUOKTyNIYcG3ximxL7nERbrSeecQxTo6a3CC0clQC4BJYUYKzHjRHgZ
 WC6a4lWMQIanvxBR9sdU+0Q5eOp6Zsy9AX5XNbbJt4l05CC3owxi9XNm4xLSYJYVQRM8dgtuFEU
 bp1bKufZcdQ/HJprgLOp2n5Qtt/1cGkl4Be+G2GdTn1yxGoDhj2h0V1nwY0mfE3v7HfeAQ+khvj
 7m9k8G7kGuk6mvqcqNDY/xnSLISZfv9kxTZK/rzhuqlkPl5ubumxNEFOYxxipZWlAhwAqcHaLuS
 NSYrwxevpYQXqOzI/2Q==
X-Proofpoint-ORIG-GUID: DP40EYMLtQRe6735M_AGeG3tzbB_-UNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.54.0


