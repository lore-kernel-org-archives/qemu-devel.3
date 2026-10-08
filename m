Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE0CA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvnu-00030Q-Ty; Thu, 08 Oct 2026 17:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveT-0000MS-2F
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveP-0002pY-Tz
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5PRJ2501580; Thu, 8 Oct 2026 21:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BKdb0B
 FbELBhLuTQRgVyC/3G9YAF4URWbxTX9nz6VME=; b=cU0wW17ebnML+RJdBTvGnA
 BMtuNqhtoD7StlxgHdpEvresHHu9rjJY8O9wd3f2uIXK1n4cWLdm0etjRvcztiQq
 bVPXce62MfJtLNGwJZKT6n7CWhnSvBDopzYFWx61lHw9KdFpLAPXQ+NYn77VrEPr
 wjkBduVaZxq3TQHPCMpdxIW8qjnHMWgZvIW5VDf9tAIUwmm37TKqUjHgrHhsFmeO
 I3H1a2VrwdXrU32sGhhBjmi9cvE9Nr8xItyRXXSA26xJP/0iCdKGkCEBqOdKFQFD
 p0N48D2rHWuey+y0P2ySOAV9L7lTz/k0iebvPK0fNDGW6hwdR4HXj3Va+ooDeYgg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvxq0v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2Z0S4079111; Thu, 8 Oct 2026 21:27:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsng9m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRVnk32506610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 970305805C;
 Thu,  8 Oct 2026 21:27:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F1C758054;
 Thu,  8 Oct 2026 21:27:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 09/10] hw/tpm: crb: Consider response_buffer->len of
 received response
Date: Thu,  8 Oct 2026 17:27:22 -0400
Message-ID: <20261008212723.3679685-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q2UyC80urJgxwL1OsojaupFYvKS8zI62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX515MS3oD7LtK
 Bowwt6e28quOeIvesGWWxc3B3oNTzGarInaqNl8tWw9L7tLmq0fZ9TOdNnVCGst+x9EGnQhFxTp
 Lg+kIdbmTEAvx81hcaUrpnBezlINGYCrTmgq9u2KHo4446zC70ct3YWovkSHt8fNpMwmfgizf1k
 IQOToEEmgmgXL12WFmbIDk6D66+UTgiOcGKzWZPPct68Qd16NbuxR0B+hzsF72hv9zO8SU0IYDy
 rcE+OBpdL3gY2VLxiNuJged+c45DVrrm7r2e6b96N2rrwhCx8+h/AoXQCWAiAO4Sax8oXFalXGL
 XY+qeZp3DHLes/lPBljoyclY9nHpydT8UyxEYS4OrdGQ1gmXHx/iFCBPnKXcrg9OXPingnpTQ93
 /9m24dGR4xHnpdp6ASyuDtP+zmmSkU1KCBqtDVN73KCjskvuKcQkPBFCOLwnAoQCKjCQWJHJezL
 iYly3XpOB4/51Edkp5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX/pp+MYBvGl+J
 W5/Jv63r7NCdSZiq/xV+jKW4OOOkNs3l2dmWSdIQLci1hrUn/FcaQWWA/xGAeUlgAsTvggNt60R
 pZuwW0QWyMevoJakpFGnv2q3TgDngEE=
X-Proofpoint-GUID: q2UyC80urJgxwL1OsojaupFYvKS8zI62
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac80ac5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=rD1lyLEvv5Bxigb_1PMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

When the CRB receives a TPM reponse from the backend, then reject responses
that are shorter than the TPM_HEADER_SIZE. When determining the size of the
reponse, also consider the length of the response_buffer as being possibly
shorter than the negotiated backend buffer size or the size indicated in
the response itself.

Fixes: 2a660ad67d15 ("hw/tpm: Implement TPM CRB chunking logic")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-10-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 5c50a79936..78db220520 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -323,13 +323,15 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
     CRBState *s = CRB(ti);
 
     ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
-    if (ret != 0) {
+    if (ret != 0 || s->response_buffer->len < TPM_HEADER_SIZE) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
         tpm_crb_clear_internal_buffers(s);
     } else {
         uint32_t actual_resp_size = tpm_cmd_get_size(s->response_buffer->data);
         uint32_t total_resp_size = MIN(actual_resp_size, s->be_buffer_size);
+
+        total_resp_size = MIN(total_resp_size, s->response_buffer->len);
         g_byte_array_set_size(s->response_buffer, total_resp_size);
         s->response_offset = 0;
     }
-- 
2.55.0


