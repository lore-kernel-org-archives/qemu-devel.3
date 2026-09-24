Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B3CC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kd8-0003Yi-CV; Thu, 24 Sep 2026 10:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcp-0003Qe-Oh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcn-0004Xs-W8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC65HV2190525; Thu, 24 Sep 2026 14:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DxcENW
 3KcCsWxsl4uaYUZg4pvpzJWSU7O7BBPrbv1Ng=; b=GULzLUhKS2oxgRWggWTz6g
 kVfhGF05pHAnPun6uWqyWKp86JSxGGx5Es3e2Hi0UadsQ0a6NHwjiP5UkpGCyHIE
 bAJ9BIwR+UW6z5rw+sJUA61B+/ZAY5549yUtR/GLsppYm+L6zYaXlC6PynIfI3xP
 yNL/o09oVqt81YTFbfo1BmemBY9+c0934a8dL4grDr+730f7FJ7PQG8f5i+ACkpv
 Ujp8qC37g2pkKMUZMoMg19lp1Zgwq3gAdTD6tQqBXYC9IGk/gto0fMoT4u6n/J0B
 GhM0wxsw3PCu6c+BMvNPl7BtWwqDIfcWonmjyy52w/7O8J26uNQM3ep/pjOHSyDA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2sshq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENs592244447; Thu, 24 Sep 2026 14:40:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qp9u9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEeX0X25231996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D7E358059;
 Thu, 24 Sep 2026 14:40:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF1BF58058;
 Thu, 24 Sep 2026 14:40:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 03/10] tpm_emulator: Reject sending commands smaller than
 the request header
Date: Thu, 24 Sep 2026 10:40:19 -0400
Message-ID: <20260924144026.953360-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1WND5G0vL0rEfZZMwUqIZRWU4CUgcZT8
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab53663 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=-V7DfVYgi2RuJlZc1c0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX1mQuiIQ2XYwd
 9DFi/rIhUExYSF8xwY9La75pKLA948r2eMfIyiqNJ4Qhqe6dg0rxJoPgE8AO0Z+C68tVMMTT5ac
 pweegTIfUUrobwtD9Ln+zrhw4Ig5rNj3iIOln2RDJieT9S4A5LLXLv4qxsX225SfjQHNmunpX73
 4XhU+CH7LDvWLjKXzKtbA5gnJf5ONga8mKHWcIFmP/zNnSmJb/X9ULicmWWSnXrAIGnuhQG4Xm8
 ix968cTC7QZuvCnmIi1H7hsc+R/WjLGV1DYjMd9V8xP5kY2fqCTpUEcwo6B4B9uccDcgXFziJKq
 sAn0tiyGvgWZczv+RDuR6GkXmdIdW4IFgvWniX/AXWK3RSTemNJLuKMsq3BegT78HF6R/5jdBxv
 JN89cJb9vNZq3h+890Wu/ynmKvQBz9ol/EI6ATFFUrbUk/pSC37P2iUCRXhbkBXTqVkmVODNCJd
 T9mrnK5SzVNLx8QWd3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX4iBg+vmpO+ll
 IcybYKj/SLSERCMhjId8KToYXrXuJaF4B4BJT+iUEiEgEEDfskhCSJ9LM1MBx3jjK8y+sJ2emFX
 k1v2sVentUSj+DMMEmC4uVU3t8wkBss=
X-Proofpoint-GUID: -NF9kFCsbl8YqfAcFDyOGgEEMrS8bnvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

Reject any TPM request from being sent to the TPM emulator that is shorter
than the size of the request header.

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 9c95b4d878..0c9e32f36a 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -181,6 +181,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
     uint32_t to_read;
     ssize_t ret;
 
+    if (in_len < sizeof(struct tpm_req_hdr)) {
+        error_setg(errp, "tpm-emulator: invalid request size %u", in_len);
+        return -1;
+    }
+
     if (selftest_done) {
         *selftest_done = false;
         is_selftest = tpm_util_is_selftest(in, in_len);
-- 
2.55.0


