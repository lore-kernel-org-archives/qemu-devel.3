Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3301CA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvgf-0000U1-Ql; Thu, 08 Oct 2026 17:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Mm-R2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002p0-85
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5c621222744; Thu, 8 Oct 2026 21:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fg5Vt9
 Fw32TXhwilLhBasjEAwkboi/dsanFi8ZITwdw=; b=EmFjVpWQleyn7PhImjsJu7
 DVJRLQGBEKLxNfl35VsJXWwF216VUfjjOVm8OkhMvJTlfH1FA8DwuodpWZDHCzLt
 02pzvmlqe5e/jGlM3lhjukAAxbWq8HSZkIABvFLfBOmO55nJyQ2hf2LrzoShfsiR
 5vIT6UYnx+nC5QNmLSJ43UO5f1NfFtWIDFApkEMQslgSdDW/LGDf9XTALjMgAMZs
 E+gjMPLOYjUOGLaIVVz1e6pzv+dBMgaBTNSbUMmALHN7FN1rlcvTH3VozmNa4rls
 YKBzvTRuuybjGu0xzR02O9tOGXBS8/ojNL4FRT5Bx6+p5EHxh2OUKMuwIZo6ZlcA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1e85k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698LHTkb4041231; Thu, 8 Oct 2026 21:27:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34x075-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRRxH23397018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 863625805A;
 Thu,  8 Oct 2026 21:27:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05AB05805C;
 Thu,  8 Oct 2026 21:27:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 03/10] tpm_emulator: Reject sending commands smaller than
 the request header
Date: Thu,  8 Oct 2026 17:27:16 -0400
Message-ID: <20261008212723.3679685-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac80ac0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=9BdlsPi07Qx-WeWrXMgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXzbsUonGONTii
 t7DcU7lrvWw1up+JSdHqJE2hPDlS2YJP4MtcgIZ06YrTOdw5bwTfz8nToRN8PF34Dh0PFUDY9/t
 fA7dx2GZOR6HMiEDXoDH5Qa/1JaD/XR+5a8g3ky7Sakd/AU1qSTp3ebxyyaE3wQ4qN8tR+g9WNm
 qzyYdTcgwTTjo/k1gKsgEKsDnoLJL0PtJi9hmLnfc3nC4g9kSWkOl9BoqvET/PYSrqp0YX3+YVA
 Gy+dUJQXJ9DMt2QOR9KeNJnUYrcjFP/FKZH5u2K1g4qGC93aBBodsByGyM7PUfUgPlNbtvYHRy0
 +uXNGIEFjqgbcmjfd7tHxi51kdJgvX6wq3/g6C8yxMGjOxG8uNefqV9y59H3qNnS22XjItMJwf3
 3ARbVs3KAxHelF/MjbqKmvzwXseussP0bmZbGLK4ljCHT1oWLrPWy4Y5aa/7DK1VBLvctnDPLq9
 Ht1Geal7xuX8Aea6FPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXyi415VhssJfc
 /efkO4bP1gk7WKKQpGpHCo8OUgnZi/4tdOczK8ZKkYT/ZW3SFs+ie3ed/ErpOn1jeczTOce0Jmp
 p44EyFimjNnriBejAI31lRifKAQRv1Q=
X-Proofpoint-GUID: UeVpNdHidxgJ62XA3ytGrByDgPSYxOV8
X-Proofpoint-ORIG-GUID: UeVpNdHidxgJ62XA3ytGrByDgPSYxOV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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

Reject any TPM request from being sent to the TPM emulator that is shorter
than the size of the request header.

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-4-stefanb@linux.ibm.com
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


