Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30321C43602
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg86C-0007TE-It; Sat, 04 Jul 2026 17:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg869-0007S0-Vj; Sat, 04 Jul 2026 17:40:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg868-0007rw-ED; Sat, 04 Jul 2026 17:40:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmucL2447066; Sat, 4 Jul 2026 21:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vD/1H4gQ5LszeVnNg
 z6n6n6V5b2d1QIE7rx4i5ZK6n4=; b=Ulxwh93nOEf6GWY0wJBlYExKJS/8hcG1q
 0aZWLsFcBYpVx5cpSdiW37tjnKIZkTMksC+hsvn/1dprOEpxlHjtz5ugT+0tfLGQ
 1PaaxlUi7zalcMUAMP7jxow5OD5/dmYNIVirDcrHjF8lrtyprBrrzlKXEpE/WTYY
 /68wNdYkqoWdUAL4VNU7Pe941bGPyO28qlsIqLJORbweF4o9a5cW7n33TQX6Ys7D
 H+qetVNSeeWoxXcftbucdJ+Z3iJQNjXYJ+vCLelnKJKMCQz90JTmlU4ppRk+UuiU
 tMS3RCvMg8SEL9Z+1aLufZN/uzGvV9SCp+0sdnQTaLZuZ+nRTr/Zw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdbc4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYapH009719;
 Sat, 4 Jul 2026 21:40:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gxbss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664LeGkS24707680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25C8358045;
 Sat,  4 Jul 2026 21:40:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4212858056;
 Sat,  4 Jul 2026 21:40:14 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:14 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 10/33] hw/s390x: Define finite size for single entry
 VCEntry
Date: Sat,  4 Jul 2026 17:39:26 -0400
Message-ID: <20260704213950.2118823-11-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a497dc2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HeWPiYe96b1ufxwsDYQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX3/lRU3OuME2p
 GN/XrDigEZQNxFxHSpPQmVcaXh8bfOYV4yw/haLZ+NBSKSLJJqWL8bRWi1SLItucWgo3vzPEJC2
 EV67OAaBy2RUZ+zLoq2SfxxCLgW5H0iBUTpW1MA74zL4p9/pNYDPwnOy48eLC8N6rZSFU23AeFC
 jO5r/ozowgqzszOcNQRJLZZX4xBrJ3PsLErk2Oig+9kZfPp1bZIIJAI2RLA1hXEGrU7KrY0md72
 sTdvrFPTA4NjHOy2fXKu5JCDeOGCC8R0z1XxMFY9Y7FQWBqk20DpM9DtwJmBmmNGe54hgqqflB5
 iLNPXkFDwi1FVcPTKuscl1By4IyBRKi1CIRz4qXnVMd7B/NUOvfBWDEpTnpCPArKvsR0+nHmwyF
 5ML1CkeLbQbMUy7SWsleMRMPtVebWfeQDxtiNTNm4OBr+Ne4hpFkCR0h/IkFwX733QdkYqWdvST
 64U8MXbsU54JseKcn1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX+iZ+rA+aY+DE
 OwyxDuM2U0i3E7D259riq9AoU4zaad6GY362d7NiO3cJMCjPkBlFIWxZ2202yGw+O+J2jW4cqHO
 a6FoDw+w3JSe13w7icvZXo6/b1KQGMk=
X-Proofpoint-GUID: hj7ZFsOjvHW2r2V1nSVbGdD6Gu60kmZ1
X-Proofpoint-ORIG-GUID: hj7ZFsOjvHW2r2V1nSVbGdD6Gu60kmZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Define MAX_VCENTRY_SIZE(8KB) and CERT_BUF_MAX_LEN to establish a finite
size for a single entry VCEntry. Add validation in update_cert_store()
to ensure certificate data does not exceed this limit.

This finite size definition is needed for proper memory allocation and
will be used in a later commit to handle VCEntry structures with known
size constraints.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/cert-store.c          | 6 ++++++
 include/hw/s390x/ipl/diag320.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
index c679406c2c..e253777880 100644
--- a/hw/s390x/cert-store.c
+++ b/hw/s390x/cert-store.c
@@ -91,6 +91,12 @@ static int update_cert_store(S390IPLCertificateStore *cert_store,
     cert_buf_size = ROUND_UP(cert->der_size, 4);
     data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
 
+    if (data_buf_size > CERT_BUF_MAX_LEN) {
+        error_report("Certificate data size %zu exceeds maximum buffer size %ld",
+                     data_buf_size, CERT_BUF_MAX_LEN);
+        return -1;
+    }
+
     if (cert_store->largest_cert_size < data_buf_size) {
         cert_store->largest_cert_size = data_buf_size;
     }
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 7fda2d44fd..f3c23a3176 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -92,6 +92,9 @@ struct VCEntry {
 };
 typedef struct VCEntry VCEntry;
 
+#define MAX_VCENTRY_SIZE      (8 * 1024)
+#define CERT_BUF_MAX_LEN      (MAX_VCENTRY_SIZE - sizeof(VCEntryHeader))
+
 struct VCBlockHeader {
     uint32_t in_len;
     uint32_t reserved0;
-- 
2.54.0


