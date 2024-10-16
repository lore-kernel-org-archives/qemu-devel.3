Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16D4D1AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 13:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t14BT-00015H-UT; Wed, 16 Oct 2024 09:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t14B5-0000rg-Hh
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:35:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t14B3-00049i-MH
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:35:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDQCNl028115
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GN1Hq6j9I3FWk+035
 MqB8fKDHbeRygIDEpGYhCCG8Qk=; b=hxMl2x/zNMiUxufL6zIrq7ct0X+Dz2FII
 hoqHw35SFlDQea9x3uyfZOKR2Y0SOjJy3QJQ4FobMNW/m3toL7i6zIyyDNgI29wF
 W0D0Be2BCZX8Wc5Cfb8XgAcReAA/zj3odEi3K2vkjPnq5GooWcYqKnkisinGP1JY
 AERQZpYkb6VYMDE/hx0dsH47cfCZLNl7P1MraFFJ9qLZC51eFrWsyI7k8b0q5FKO
 r+dXrbXsVpCp1jpHdd4NFhopUn/t0mIVE5q6423sZmbXewTkgakZkELiRLUtWytK
 hmdB3rnNxq/w2vOhCtkIdxYN2MjF9ttEjuZkC4XvR49ZQy747BPZQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aebxg196-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:35:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GDZ0Cp016756
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:35:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aebxg193-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 13:35:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GCg5eH006690;
 Wed, 16 Oct 2024 13:34:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283es1umy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 13:34:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GDYwVS43123040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 13:34:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF8EA58052;
 Wed, 16 Oct 2024 13:34:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3685558050;
 Wed, 16 Oct 2024 13:34:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 13:34:58 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/2] tpm_emulator: Read control channel response in 2 passes
Date: Wed, 16 Oct 2024 09:34:50 -0400
Message-ID: <20241016133450.1071197-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016133450.1071197-1-stefanb@linux.ibm.com>
References: <20241016133450.1071197-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p_X998_q_CjIygA8mHS2Q0yc9jHLk-2b
X-Proofpoint-GUID: W-sZN8HUY6Ht_cT4it85qZOcjiYe1OyK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=754
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Error responses from swtpm are always only 4 bytes long with the exception
of CMD_GET_STATEBLOB that returns more bytes. Therefore, read the entire
response in 2 passes and stop if the first 4 bytes indicate an error
response with no subsequent bytes readable. Read the rest in a 2nd pass, if
needed. This avoids getting stuck while waiting for too many bytes if only
4 bytes were sent due to an error message. The 'getting stuck' condition
has not been observed in practice so far, though.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2615
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index b0e2fb3fc7..8f5d31be09 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -129,6 +129,9 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
     uint32_t cmd_no = cpu_to_be32(cmd);
     ssize_t n = sizeof(uint32_t) + msg_len_in;
     uint8_t *buf = NULL;
+    ptm_res res;
+    off_t o = 0;
+    int to_read;
 
     WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
         buf = g_alloca(n);
@@ -140,11 +143,35 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
             return -1;
         }
 
-        if (msg_len_out != 0) {
-            n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
+        /*
+         * Any response will be at least 4 bytes long. Error responses are only
+         * 4 bytes (=sizeof(ptm_res)), with exception by CMD_GET_STATEBLOB.
+         * Therefore, read response in 2 passes, returning when an error
+         * response is encountered.
+         */
+        if (cmd == CMD_GET_STATEBLOB) {
+            to_read = msg_len_out;
+        } else {
+            to_read = sizeof(res);
+        }
+
+        while (msg_len_out > 0) {
+            n = qemu_chr_fe_read_all(dev, (uint8_t *)msg + o, to_read);
             if (n <= 0) {
                 return -1;
             }
+            msg_len_out -= to_read;
+            if (msg_len_out == 0) {
+                return 0;
+            }
+
+            memcpy(&res, msg, sizeof(res));
+            if (res) {
+                return 0;
+            }
+
+            o = to_read;
+            to_read = msg_len_out;
         }
     }
 
-- 
2.47.0


