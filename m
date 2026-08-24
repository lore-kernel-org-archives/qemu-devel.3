Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA502C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQ6Y-0002h9-Ll; Mon, 24 Aug 2026 04:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6P-0002Xk-QU; Mon, 24 Aug 2026 04:32:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6L-0005AG-S3; Mon, 24 Aug 2026 04:32:21 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5VQGg965714; Mon, 24 Aug 2026 08:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=P3R2CJTeV5wkQovcm
 RGTdM4GZu1zsPmlr0Vw58s86a4=; b=tuUk9iqiQVdzON1zB22Xu31f3FfW702l1
 w1fD4xxGAmmXm2QiIe5vr9htyP9m36Tf+fo/TANb+LFXa/6l7hys67NG/L5tfehB
 gbOaqUGesv0zl86FnFbiOhj6U5vhLs0xI3EjYT34RYiRvK1XbLH+5F/iOtQYavmZ
 1dehjAasB8aZTPnqDTH1h9C63mGt3gnRGJC/qwEgeE6q4imHzoLygskBMEA53mnX
 VWkjp2Fx2rkrHOoQMFqHY4kZGTfOO6MAz50o88iPZTW1Xq/9VnT0IiIj9X7yeX+q
 RCv7XBzrRN0zmlwEifbY6FvoKDEscUpic6u7CbxabRza5I5AgODGg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4g26q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QKQw029636;
 Mon, 24 Aug 2026 08:32:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag4mv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67O8W5R516908570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 08:32:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F31120043;
 Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53A972004D;
 Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 01/20] target/s390x: Fix missing privileged flag at PCKMO
 instruction
Date: Mon, 24 Aug 2026 10:31:45 +0200
Message-ID: <20260824083204.40877-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o9jDu_-tzF8WLYsh9p__a12evV4BD6ph
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX0qV+xqK9BHrt
 7FAB4tyrqKticRtfcSxfyPx67XEw9fse0MwBo7f4BVXfh045JsmvSN8Z36VvtC5Tl4K5qf/rtB4
 SPjItIbxqkXSBNgxLBKqJs7P+q+unXY=
X-Proofpoint-GUID: o9jDu_-tzF8WLYsh9p__a12evV4BD6ph
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c018a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=B7scKulbZj0pNRMJRCIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX0rBOgYstvaYJ
 9QcAWG05lr243NZgb81msFSosZfvIGGxbDLm9uFskGLyn1SLDpYNCKUJvsnr0u0fdUwswsueu95
 pyXxDHUAPFpugJXgc0a5y5HxpjdNnkxX3nxjYDmeDYMwFPz47XZKlN8m3c04e/URPHWkC2EMs9L
 /LpwVBrTXEcJ2mLWNx/VjF5A5sjPf6I9SzKhEUt7ZKj4jjPPOOcJIiq2o4LNzwEj+rKgz8nJiZP
 gAT18FbDQhDyJThvKnWBifisY6C0vOnCyzdWoF0q9z3vo3OKWvGtqUCLlT+A2UlF30/DrDuLkdI
 UP6ZOwPuPqL6MGKZSeUHLJ/S0RdoiCfjI+BC5VWjrgttxeMuowGp4ruqfVvtOf9fm8ElXwNgeB+
 HI9CdDq1q78Pp1P7ninOrlV1i4GGU+E32zTt5EnzSWPw+noJHDlgyyPYfJfjFpIdBme2ToUMuNf
 1Clsdyn7RvcVbYptCGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

The CPACF instruction PCKMO is a privileged instruction. So set the
IF_PRIV flag in insn-data.h.inc to reflect this.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 1ea72248a6..b2e402216b 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1007,7 +1007,7 @@
 
 /* MSA Instructions */
     D(0xb91e, KMAC,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMAC)
-    D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO)
+    E(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO, IF_PRIV)
     D(0xb92a, KMF,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMF)
     D(0xb92b, KMO,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMO)
     D(0xb92c, PCC,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCC)
-- 
2.43.0


