Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FADCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCx-0001LE-5e; Fri, 02 Oct 2026 10:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCl-0001DX-2L
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001nb-8j
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZTil673031; Fri, 2 Oct 2026 14:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ROOO5N
 KCSiNljmuUDbAB9x7mgWY9IsxGocVjRNhfZvs=; b=UURF7ZTnJ8qH+YMe3BnpEf
 bJ21lcRgVrpbxIATSGx1b8lXWHyM9FhxSRbLctQW63XLjGUCDSLldq6HLOq67uz0
 VjZVmiHNiqEFVP8RV3HOKDgs8kXrn2DuYqAo8+FjSDJxXtGHoQCbif+PJQlVnx13
 um6E4ZTpVIvLJ7qX0f0pEyNPJ0jreHKP/UZ5qezH7iWcEABiPSVi0aNQWxe2or7w
 Ajddx6rQ3UriJD5XbmOfdWnjRzRpjRQxER1btbOv/mXneBAIy49RBMwlYIif9qwo
 wCGuS6Mu7pJpNmeFjC3+zAEF1/5kf5vhuTQBqcwDk7TdqF6/JhHKppDQOH8uYzMw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5supn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHiK52576808; Fri, 2 Oct 2026 14:25:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk13617-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPVUZ33554946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC6FB5805D;
 Fri,  2 Oct 2026 14:25:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 693425805A;
 Fri,  2 Oct 2026 14:25:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 07/10] hw/tpm: crb: Avoid potential integer underflow
Date: Fri,  2 Oct 2026 10:25:13 -0400
Message-ID: <20261002142516.2063735-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfXyjVv14EEVBqB
 GlALleOBKqYCYqpil6+UCpg6ou4sO8KEeZubGSE4Va+J0Sz9MILjAldp0OHjtDVwz/v1Vb3khca
 alWl02vCbr5030z+VULK2soqDE3SeNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX63pH6NUszOx+
 gEN4xhbZUX6fN5y0YW0eeyS+38x9H5oeJVAI74SGZ8W2+Kn9LR4WibfJfDeeRyPw/taYCN3U6bo
 omcV4+QosYBGVKTqwwvTtOYv76G4C15ocM9PzURuaqtTQrYamUq7GVS1x+aknUCp0LBgVJ7jNCM
 jgrrRiPhsz7wim/7kQ+aUYKfiXUso77Z+scxmhg+mJVp7JkV249n1QfN+ovcmTAb7nDfqSv3v8v
 TiFAyLrRzeKRZ+LJNioTSv985Exp+C3/aoHNHvQuoTviqj5WVIHDBYzsJB0YNOpXB8spwJFxujS
 zua2cXQ5vOtA69X7PHEBj8PtOQxdkUhxZRR4NRhAAoWhzU4KQ9ENPGxPmD4pxQNbF3i3e5A7DUq
 ecQTs/G0+c4OqSl3oHeG0S3qiAn3H3WbyLHTJH8/Fs+QwTp51SJWbzw02pKq9FEWt2h29aa/7km
 CX6to5KxfyXlKV2Mlvw==
X-Proofpoint-GUID: tilbrhVEZursCGA1bZHyhZbndZ9hMjAM
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abfbedc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=c1_1-GllvHXUlFLDVV0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jvcQqFV0JHhNz7NR28C3YkcVfwcUV8WO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020056
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

Avoid a potential integer underflow in tpm_crb_fill_command_response
that could occur if s->response_offset > s->response_buffer->len and
the function's call sites were to change.

tpm_crb_fill_command_response currently has 3 callers that either test
that 's->response_offset < s->response_buffer->len' is true or ensure that
s->response_offset = 0 and s->response_buffer->len >= 0. Therefore, the
integer underflow cannot currently occur. In the worst case the subtraction
would lead to a '0'.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index daf451aa56..cd46b2e888 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -180,10 +180,17 @@ static void tpm_crb_fill_command_response(CRBState *s)
      * to the linux guest in chunks by writing it back to MMIO region.
      */
     void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-    uint32_t remaining = s->response_buffer->len - s->response_offset;
-    uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+    uint32_t remaining = 0;
+    uint32_t to_copy;
 
-    memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+    if (s->response_offset < s->response_buffer->len) {
+        remaining = s->response_buffer->len - s->response_offset;
+    }
+    to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+
+    if (to_copy) {
+        memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+    }
 
     if (to_copy < CRB_CTRL_CMD_SIZE) {
         memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
-- 
2.55.0


