Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291AC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1sk-0003L5-4O; Wed, 01 Jul 2026 16:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1si-0003Kc-UT; Wed, 01 Jul 2026 16:50:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1sh-00042f-A7; Wed, 01 Jul 2026 16:50:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GnPwn1296338; Wed, 1 Jul 2026 20:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cDboDYYOBdrA20kFb
 oU7CGyqbQd4Dx5N0FyV5yQsLaY=; b=NCuJEG8J9dhq2oSV5n9AMzbdUZe3zlULb
 22FTPF1rGtQ7Ky3eQKAM+LzSUHKVnt6sNSq2qElHQClRJFnWgrfhk3UL9MxG0fCH
 bVg0sdvewMyqq2eIRSM2prlm7pWzR2+gGD6qyO8Wf4xJrg87Blty9gAZ5+Ko8B+P
 2AXIU4ZnXmTzG/PTaayhV1oIsoj9brU7ycIT2S513D5ewctMg8xbNAJEiMRsIQyP
 V2tH1HbrVRUToyBpXdICZpc2QOQ4uxsv012HcrdGUten30uLa0QmVcq6SsgA967u
 R0CahgqWFH6sV7jQnIVzLvSr4ZOPu3vB8KovhlolDJBjG37vZ2QiA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjxabg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:49:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KnfVU030844;
 Wed, 1 Jul 2026 20:49:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ggxrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:49:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KnOHt45416886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:49:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 346ED58056;
 Wed,  1 Jul 2026 20:49:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B2885804E;
 Wed,  1 Jul 2026 20:49:54 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:49:54 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 10/35] hw/s390x: Define finite size for single entry
 VCEntry
Date: Wed,  1 Jul 2026 16:48:56 -0400
Message-ID: <20260701204922.1320349-11-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX3AfY1LIPaeL+
 F4UakzQpUnOZbBs0Syxbe2kZvYHAZVjvv08xFf2S/C78fFOTE30I8l5ExVFkGlizeNkmjubCSDq
 RZUBVfETQaGVlqHoon03UplGdg5FbtJhBvVqmbcGkXJFCSV2fnW4GvTm4jy1mWqM1nQYx/orpWT
 gv7iScvYYpiDSwxZ+z+3szFQazZx/pDZ2hPRazLrzGSnrU+0MfuDgMsvpA8VjKux4x9A0vhPqQf
 t6sU2rRqG966EjWrrtI1xf+W3DBPyzp7sH3GqBoQFxQ7JE6GCboVkxjU0GQmf5Cuzb0PEcPYee8
 33pbbVRsXPd73CVmYAAenZ0JG5Uc6ueRwFo+ir48nZFlbsOFbd4VU0i8I0Oz996sxRkSo8NUI7K
 nlXjX9HKYLDIx4+O4haGnef23OLlaWlN3/hEAkd8PDgMSejvxTpHfst+rFUvoIP3JJbh0+7GIGO
 R093fk8qGYHopIaJAKg==
X-Proofpoint-GUID: X31luhQMCj8bI8k8M12NEVI7bkbffGtx
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a457d77 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HeWPiYe96b1ufxwsDYQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX0W12YORn2tuR
 lVxa48kG8NmZoE3HruJJuoxc2oJQKLcubvKJnzhDIfoHj7105Ka54uknM+c8/voqyda4yRqE4Qe
 GxwdYfSDHchyVcUbiG1LHB2AM83E+YY=
X-Proofpoint-ORIG-GUID: X31luhQMCj8bI8k8M12NEVI7bkbffGtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
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
---
 hw/s390x/cert-store.c          | 6 ++++++
 include/hw/s390x/ipl/diag320.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
index ab3abf414b..08c38d18df 100644
--- a/hw/s390x/cert-store.c
+++ b/hw/s390x/cert-store.c
@@ -86,6 +86,12 @@ static int update_cert_store(S390IPLCertificateStore *cert_store,
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


