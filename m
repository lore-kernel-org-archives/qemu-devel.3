Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95402D1A428
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 22:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szOF6-0003P3-Ow; Fri, 11 Oct 2024 18:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1szOF5-0003On-IR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:36:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1szOF3-0006CD-E5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:36:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BK32WS002078
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:mime-version; s=pp1; bh=gWpKGtkgB0sfc
 tupZy+hV2BgJ2Rq/JiwXRAKAoEZtt0=; b=QzK5r/JOxp67OufuE4MZ1hBKl7Pvt
 5rGhVr1ywf3G8rctgXLL978NrdsIa+tp73NIhoq5MzfY05lLYEcGa3JGN0tADy5z
 SR6+OSgnanwYppD7R8SBtieV9A3gCCuyb98zFdBJtY/XHkjiL3rvVKAUz2AxJWfP
 Zicy6uzp0J+vn619p/wIDqMzYlp9xnqAImHySHqWYfrDio0IdYDmTRP+viN3eevM
 d7xLEvrpng+xeTB2DMAcFBoDG2gMYL82Am4UL3XbmbOlJaXYhlZmHDXWLds1jdHJ
 lySjOssoPM0Cf96Z3OYyB6cy8guWq2ShK/aRph4HiUjkVW5A8fUj6e3Aw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 427aq28fdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BMaAA0001171
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 427aq28fdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 22:36:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BMTuoF010703;
 Fri, 11 Oct 2024 22:36:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jyr2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 22:36:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49BMa8qB49742272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Oct 2024 22:36:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF36C58053;
 Fri, 11 Oct 2024 22:36:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36E6A5805F;
 Fri, 11 Oct 2024 22:36:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Oct 2024 22:36:08 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/2] tpm_emulator: Read control channel response in 2 passes
Date: Fri, 11 Oct 2024 18:35:56 -0400
Message-ID: <20241011223556.2953808-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011223556.2953808-1-stefanb@linux.ibm.com>
References: <20241011223556.2953808-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JSQmtTMm_JaAE5ytuEkfTRO2Csonjds1
X-Proofpoint-ORIG-GUID: ByZzkeYiaNTCDKRXhgIEH-naaqG0JJv7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=739
 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Error responses from swtpm are always only 4 bytes long. Therefore, read
the entire response in 2 passes and stop if the first 4 bytes indicate an
error response with no subsequent bytes readable. Read the rest in a 2nd
pass, if needed. This avoids getting stuck while waiting for too many bytes
if only 4 bytes were sent due to an error message. The 'getting stuck'
condition has not been observed in practice so far, though.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2615
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index b0e2fb3fc7..1b2e890668 100644
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
@@ -140,11 +143,29 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
             return -1;
         }
 
-        if (msg_len_out != 0) {
-            n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
+        /*
+         * Any response will be at least 4 bytes long. Error responses are only
+         * 4 bytes (=sizeof(ptm_res)), though. Therefore, read response in 2
+         * passes, returning when an error response is encountered.
+         */
+        to_read = sizeof(res);
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
2.46.2


