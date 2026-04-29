Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EE8FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAc4-0003QX-F5; Wed, 29 Apr 2026 15:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIAbz-0003Q6-3O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:30:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIAbx-0000Hb-BX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:30:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T9JtrV3403831; Wed, 29 Apr 2026 19:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=CJmcDM5jgEjnPXBxj/7Ca1M+T8PXMWrF8WtKlxycV
 jc=; b=HW+ZYvjPpDlK63F34OmY4wQYONXF8kq6A04pIcnaR2rLsGOg/KYOlZvuG
 8d8LVMu6rzuFBSxVwvCF4bBnQkHq8H//us6rgbDWjKRp4DkAqE396kd/sKE15LfD
 u/sXRV9eIxQ0p/X1u583nE7kaM1ZsxhtwMpMHwMXkanLpqoPxzTTLN8kPvkbkH4r
 2BS4fdJVm9lQZvqL1OJ8NpK3PgnSpxNjGjvLLgK15XjmpeaIbvkYYQi9FjJISJVz
 6c9wg28yQK+/aeHpgG64Z0OEB1uGOKBY/3g7juBAX67Tu++rvYXoxF9vb58Enjxq
 OGdFlUjh58VIAeKM1OmBqaxBu8uQQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e2us7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 19:30:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TJOAHH011638;
 Wed, 29 Apr 2026 19:30:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyfkp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 19:30:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TJUEBB27918982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 19:30:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBEBF58056;
 Wed, 29 Apr 2026 19:30:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ED325803F;
 Wed, 29 Apr 2026 19:30:14 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 19:30:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] tpm_emulator: Limit number of bytes read from buffer to size
 of buffer
Date: Wed, 29 Apr 2026 19:30:07 +0000
Message-ID: <20260429193007.1670335-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5M9hyLQxeb7H9T8Y75BzgIU4u0kRvJan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MyBTYWx0ZWRfX9bHnoH5FtlDK
 ZCPJgCmON8rWAANfi7mp3Dxig4Weg9vCd61CLwSvaraxcwvLIzAYzZYvO0nDgAiRq9pBfu8A0cA
 thKgPjktdwbWQAWvTujWVs+AUiO+txsre/ClIC5dVi9rNresaZ0LL8LdTtd4IDPFyv8vcve0XGE
 AITMT4u99D7XEtoIcmH1Xlr48qa2gXDOPQyW0DyjpBmbU5EoNl1M4eMqZC/vHg8a0zGaAqU9Q+u
 eCOY/U9qHS4bbst7bjfvraYrmn1ekCCiKvBt3JYV45e5K2HkZGrJf5cEKTzawxAXCasADvxbVGX
 VmM9/LPn2XIfm92nX9AEP61/F0XFE/6qtSGUYWp0JtAEdioNvfm7cbpP5LBcJAfJVCnFsH1ckvx
 JMLEc0adNyKlFkdLm3nQHJzaEx6ptaDqSTOqXPCURUjWBFPxpyrGETIq3wR4PInSDsBfxSM+0qT
 U20Uwc4xyDaES4jDt2Q==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f25c48 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RUyTQ2W-OykcHckI:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=89LiysFeuzQG30zlTEIA:9
X-Proofpoint-GUID: 5M9hyLQxeb7H9T8Y75BzgIU4u0kRvJan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290193
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Limit the number of bytes read from the TPM response to the size of the
receiving buffer and drain the other bytes from the response by reading
them into a temporary buffer.

The size of the TPM's responses should fit into a buffer negotiated with
the tpm_emulator (swtpm). However, it is better to proactively limit the
number of bytes read into the buffer by using the buffer's size as an
upper limit.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 75c33d290e..5e8bad1632 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -176,8 +176,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
                                      bool *selftest_done,
                                      Error **errp)
 {
-    ssize_t ret;
     bool is_selftest = false;
+    uint8_t buffer[1024];
+    size_t to_drain = 0;
+    size_t to_read;
+    ssize_t ret;
 
     if (selftest_done) {
         *selftest_done = false;
@@ -195,13 +198,27 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
         return -1;
     }
 
+    to_read = tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr);
+    if (to_read > out_len) {
+        to_drain = to_read - out_len;
+        to_read = out_len;
+    }
+
     ret = qio_channel_read_all(tpm_emu->data_ioc,
-              (char *)out + sizeof(struct tpm_resp_hdr),
-              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
+              (char *)out + sizeof(struct tpm_resp_hdr), to_read, errp);
     if (ret != 0) {
         return -1;
     }
 
+    while (to_drain) {
+        to_read = MIN(to_drain, sizeof(buffer));
+        ret = qio_channel_read_all(tpm_emu->data_ioc, buffer, to_read, errp);
+        if (ret != 0) {
+            return -1;
+        }
+        to_drain -= to_read;
+    }
+
     if (is_selftest) {
         *selftest_done = tpm_cmd_get_errcode(out) == 0;
     }
-- 
2.43.0


