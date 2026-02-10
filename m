Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E926AEA813D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq2u-0001aS-5d; Tue, 10 Feb 2026 10:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2n-0001X1-1t
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:52:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2a-0003hI-FY
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:52:51 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AAj9YQ476964; Tue, 10 Feb 2026 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BY89VvMxQ4VK28ZYC
 szVwiWkkxO7wGvDPb6VkTxUVRg=; b=s+QJkwPE2Mgxnm1rHRyZQRHOUWFVixC2O
 WuHrbQKCb4JtZqNd+vMhMbL2FJMA2ak4XwPW2N+U2XkciiHFVd1sRpNIpZIx0lGU
 6R6VTmS85gArJ6s409v35pu3SVLHboNHn9DTMk7M2qz8FAddIkaFenNDtqgjpBQ2
 kkcdBXMwAEk8kZKUrMYzWPg3isQhfmpvZrDY7/pb2xv5UumGAryCfOxwYNetBMta
 HseOlETjwxfF31ytLmDvMpfTnXZUL/W72rX5SrsiLgONDAi6gnUjr8Fm7nJK8/IT
 zH3xJ2iV5oibNwFU7pN+epNozb403gLN2/5s5L584BjbCsrSTIqEw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w503t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AEbFeB001499;
 Tue, 10 Feb 2026 15:48:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqn1x9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AFm4Ox55640476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 15:48:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 306885805C;
 Tue, 10 Feb 2026 15:48:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C00258054;
 Tue, 10 Feb 2026 15:48:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 15:48:03 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v1 1/3] tpm_emulator: print error on error-ignore path
Date: Tue, 10 Feb 2026 10:47:59 -0500
Message-ID: <20260210154801.1662032-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210154801.1662032-1-stefanb@linux.ibm.com>
References: <20260210154801.1662032-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698b5335 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=6RzkWEqVEtcfGaM_Tv4A:9 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: ds7kcotfcX5hkWNZL11w4S1J6vSZ7FX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEzMiBTYWx0ZWRfX5P7Xn8ro7DaU
 Vfht5RAzKrxzSol3nh2TIjMKKV42VpPOwF3c3kX9GxymKXm8vE8XNW8CD423HZp7XAZlnZ3iaGi
 /mi9DZN+onwF/oDPYZ2SWsVmxtjbKOgKvRIFfR4+oldgFTcQWTzN3G+m45BJ8enXQ5WsdTVAtaq
 OaY/gaGRpi6dMjlH/j64ELfVVGrz4RSOz/D3M2pEl1Ywnmb/j8KU8ouPAbRRzprA8WCD4jjk44p
 X0iQ1KM1kYV5mtfo8XXKeVgICkC3X6ztZYqsJdknYCge87+pAFKnDFKBmjBs4A4WyxLhk/7KLK4
 lJiYC4l2QV5aSsx7wJTWZ5VtShkV/iZkh/pM5DDv5tjYUwRpz35Tj6naduVIihsWivG1LfyuSSy
 99odYqTw0zSWVkAR5TSq969chavo1BsIFBT/D8OT+KIDbfWU1XTjf9hf8Wvbv6+OFmVgBelyYgc
 OBgqOEAYzTyfk2sXc/Q==
X-Proofpoint-ORIG-GUID: ds7kcotfcX5hkWNZL11w4S1J6vSZ7FX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Commit 3469a56fa3dc985 introduced errp passthrough for many
errors in the file. But in this specific case in
tpm_emulator_get_buffer_size(), it simply used errp=NULL, so we lose
printed error. Let's bring it back

Note also, that 3469a56fa3dc985 was fixing another commit,
42e556fa3f7a "backends/tpm: Propagate vTPM error on migration failure"
and didn't mention it.

Fixes: 3469a56fa3dc985 "tmp_emulator: improve and fix use of errp"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f52cb4d435..6d8529da3b 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -557,8 +557,10 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
 static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 {
     size_t actual_size;
+    Error *local_err = NULL;
 
-    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {
+    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, &local_err) < 0) {
+        error_report_err(local_err);
         return 4096;
     }
 
-- 
2.52.0


