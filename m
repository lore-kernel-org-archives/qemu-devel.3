Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC42ECA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCv-0001Ko-UT; Fri, 02 Oct 2026 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCl-0001DS-2B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001nj-9R
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZYH2468470; Fri, 2 Oct 2026 14:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sZKogF
 Ja6AUDwgSE484CT5caV1Jkx5tu2rgE4muZP5Q=; b=oJQiWJgaAHyz6xczMJ926Y
 r7vXs3fD/MqYTHDN6F+g4LV4jXvnZOTvdUd8/JFULpi94CBwJdbrtXaZJ/3bwFnN
 beI40nxyKUfLoxeGVE3gmYcfXG23OHKYYYvrFX5320ElONqpSY+tIHANBPg52/bb
 UVPjGhCE/eBWEPOOXm6wHefkDk6ILVqLr+2Q35j0Us8+fjdZWLuI1ppOiJpoHZXS
 J87q0ysmAOJCCOSxcb4AW3mUBSDoahVwcOMeW6u1LcN1rDmWCbeDRM1HG5TkEDRX
 IE/EDzTD6MkGI00zyPVyoC5o2YOU2wN8p8JbXpK16WDI8X5nHz7ly/qF526GkUpg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkrpjh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DWVR42562920; Fri, 2 Oct 2026 14:25:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsk4fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPWSW27787800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4014C5805A;
 Fri,  2 Oct 2026 14:25:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1A085805C;
 Fri,  2 Oct 2026 14:25:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 09/10] hw/tpm: crb: Consider response_buffer->len of
 received response
Date: Fri,  2 Oct 2026 10:25:15 -0400
Message-ID: <20261002142516.2063735-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: o-Gl0B9pMQTDnVda9Szf6ORUUE19UfJR
X-Proofpoint-GUID: IFlCjQkwL_Vw5dP7O9x1Y25zm8scnFj0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX08oDQPa1NSYd
 jbhuPp4v19rsy07ICa1rVXj5FgJzcSA04DYO7Jjyc0MipUS3Cm7quHHU7ntQGC+oWZgGcBjgDHb
 0xpgmfcY77QV+CuK8gla58pZoc5c3BA=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abfbede cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=rD1lyLEvv5Bxigb_1PMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX+7sVKoPLTUxD
 ZvAYjdk4nkyEHtVdJEM4o7IsUBYWwhOeLksFvYW5IrU9yWBOJR//60y9UugSunhVkueeyoEUHdj
 gUaBefGkgTIEZyHj9bo6tyL5S+FPjH0VV0tZbmkd41Hy/1AnZl8TezGPzWeSowU1szxSEu6CLFM
 9EEcjEBeK6hr85zhM7amZdWojMn8JVVlL+4JpMMxe3PL5qcQ5J1eblDLWF2ijO8D2dq4yKUnZJ3
 euLgewkCnBI5t1Tu/BcKAsu5/tV52rMiYxhnFp7QDQAn+lWfGNPRVLQLx98ojfS5oc7T+ZyN/gj
 uLBujlTrOe70fAXMN+C0j1Epfs8byuN6GlLYmA9wQxPFxeUF1sixH+8KxgYJ6OIobSwLMfNLe6a
 0ORWYWv0C40rnZGbl8aIlnc6XmpOyhYDvl/+e5FFVPQKoAbU822Kpnm54DNxgmKg6RRfgqtewtl
 LG7CTu9Ue0DkXYnT3Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020056
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

When the CRB receives a TPM reponse from the backend, then reject responses
that are shorter than the TPM_HEADER_SIZE. When determining the size of the
reponse, also consider the length of the response_buffer as being possibly
shorter than the negotiated backend buffer size or the size indicated in
the response itself.

Fixes: 2a660ad67d15 ("hw/tpm: Implement TPM CRB chunking logic")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


