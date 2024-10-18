Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3596D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nDN-00076l-S7; Fri, 18 Oct 2024 09:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1nDL-00075x-BJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:40:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1nDI-0001gJ-DC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:40:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5aDkL014877;
 Fri, 18 Oct 2024 13:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bujtD/
 UCx0Ihl1UBeFtpMvfa49mWfKwXf07SXPhgSEY=; b=nd40xcUGD0CRai5qbnC92b
 sqsnrffBONqer4bQXEuwTv32M47fk7MxRn/jUk9o2vH0WKn5WZNx20YsS46xRK8k
 prZotvJmWnki1YBTlVojLhwbMc4UogQNkgZFZXzgPJV+b+E8/gH7P63z0ddNPbMv
 hujZrnwZzuCOI6Il/5YXKUW1GbBAzH35joj3Yj1XFankYQjwJCfjwhVi2280r5wo
 Tl5BAOu4LvyJLCU7olPy6nOQhkhrMJnRKBG/uD3Ozau8COz31BOjrtbt7qhyF0op
 nM6IZhGm70U/0fb473OmVYBRvw3XUGAs3iriL9dAnXXIvm9Mb4X3EXvJ6sdpmIzg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfag89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:40:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBBbGn027432;
 Fri, 18 Oct 2024 13:40:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283ty4wwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:40:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49IDeFJT25952864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 13:40:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A879F58059;
 Fri, 18 Oct 2024 13:40:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB8D58053;
 Fri, 18 Oct 2024 13:40:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2024 13:40:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v1 2/3] tpm_emulator: Read control channel response in 2 passes
Date: Fri, 18 Oct 2024 09:40:03 -0400
Message-ID: <20241018134004.2110276-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018134004.2110276-1-stefanb@linux.ibm.com>
References: <20241018134004.2110276-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OdKajcROMlbOx3EhABrekxebuX1QeHvX
X-Proofpoint-ORIG-GUID: OdKajcROMlbOx3EhABrekxebuX1QeHvX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Error responses from swtpm are typically only 4 bytes long with the
exception of a few commands that return more bytes. Therefore, read the
entire response in 2 steps and stop if the first few bytes indicate an
error response with no subsequent bytes readable. Read the rest in a 2nd
step, if needed. This avoids getting stuck while waiting for too many
bytes in case of an error. The 'getting stuck' condition has not been
observed in practice so far, though.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2615
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 62 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index b0e2fb3fc7..aa05dab6ae 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -123,12 +123,14 @@ static const char *tpm_emulator_strerror(uint32_t tpm_result)
 }
 
 static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
-                                size_t msg_len_in, size_t msg_len_out)
+                                size_t msg_len_in, size_t msg_len_out_err,
+                                size_t msg_len_out_total)
 {
     CharBackend *dev = &tpm->ctrl_chr;
     uint32_t cmd_no = cpu_to_be32(cmd);
     ssize_t n = sizeof(uint32_t) + msg_len_in;
     uint8_t *buf = NULL;
+    ptm_res res;
 
     WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
         buf = g_alloca(n);
@@ -140,8 +142,25 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
             return -1;
         }
 
-        if (msg_len_out != 0) {
-            n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
+        if (msg_len_out_total > 0) {
+            assert(msg_len_out_total >= msg_len_out_err);
+
+            n = qemu_chr_fe_read_all(dev, (uint8_t *)msg, msg_len_out_err);
+            if (n <= 0) {
+                return -1;
+            }
+            if (msg_len_out_err == msg_len_out_total) {
+                return 0;
+            }
+            /* result error code is always in the first 4 bytes */
+            assert(sizeof(res) <= msg_len_out_err);
+            memcpy(&res, msg, sizeof(res));
+            if (res) {
+                return 0;
+            }
+
+            n = qemu_chr_fe_read_all(dev, (uint8_t *)msg + msg_len_out_err,
+                                     msg_len_out_total - msg_len_out_err);
             if (n <= 0) {
                 return -1;
             }
@@ -204,7 +223,8 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
     memset(&loc, 0, sizeof(loc));
     loc.u.req.loc = locty_number;
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
-                             sizeof(loc), sizeof(loc)) < 0) {
+                             sizeof(loc), sizeof(loc.u.resp.tpm_result),
+                             sizeof(loc)) < 0) {
         error_setg(errp, "tpm-emulator: could not set locality : %s",
                    strerror(errno));
         return -1;
@@ -241,8 +261,9 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 {
     ptm_cap_n cap_n;
 
-    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
-                             &cap_n, 0, sizeof(cap_n)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY, &cap_n, 0,
+                             sizeof(cap_n.u.resp.tpm_result),
+                             sizeof(cap_n)) < 0) {
         error_report("tpm-emulator: probing failed : %s", strerror(errno));
         return -1;
     }
@@ -292,7 +313,8 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb)
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_res res;
 
-    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0, sizeof(res)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
+                             sizeof(ptm_res), sizeof(res)) < 0) {
         error_report("tpm-emulator: Could not stop TPM: %s",
                      strerror(errno));
         return -1;
@@ -319,8 +341,9 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
 
     /* give failing side 300 * 10ms time to release lock */
     pls.u.req.retries = cpu_to_be32(300);
-    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_LOCK_STORAGE, &pls,
-                             sizeof(pls.u.req), sizeof(pls.u.resp)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_LOCK_STORAGE, &pls, sizeof(pls.u.req),
+                             sizeof(pls.u.resp.tpm_result),
+                             sizeof(pls.u.resp)) < 0) {
         error_report("tpm-emulator: Could not lock storage within 3 seconds: "
                      "%s", strerror(errno));
         return -1;
@@ -351,7 +374,8 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     psbs.u.req.buffersize = cpu_to_be32(wanted_size);
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
-                             sizeof(psbs.u.req), sizeof(psbs.u.resp)) < 0) {
+                             sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
+                             sizeof(psbs.u.resp)) < 0) {
         error_report("tpm-emulator: Could not set buffer size: %s",
                      strerror(errno));
         return -1;
@@ -398,6 +422,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     }
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
+                             sizeof(init.u.resp.tpm_result),
                              sizeof(init)) < 0) {
         error_report("tpm-emulator: could not send INIT: %s",
                      strerror(errno));
@@ -439,8 +464,9 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
         return tpm_emu->established_flag;
     }
 
-    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
-                             0, sizeof(est)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est, 0,
+                             sizeof(est) /* always returns resp.bit */,
+                             sizeof(est)) < 0) {
         error_report("tpm-emulator: Could not get the TPM established flag: %s",
                      strerror(errno));
         return false;
@@ -468,6 +494,7 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
     reset_est.u.req.loc = tpm_emu->cur_locty_number;
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_RESET_TPMESTABLISHED,
                              &reset_est, sizeof(reset_est),
+                             sizeof(reset_est.u.resp.tpm_result),
                              sizeof(reset_est)) < 0) {
         error_report("tpm-emulator: Could not reset the establishment bit: %s",
                      strerror(errno));
@@ -499,7 +526,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
 
     /* FIXME: make the function non-blocking, or it may block a VCPU */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
-                             sizeof(res)) < 0) {
+                             sizeof(ptm_res), sizeof(res)) < 0) {
         error_report("tpm-emulator: Could not cancel command: %s",
                      strerror(errno));
     } else if (res != 0) {
@@ -559,7 +586,7 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_emu)
     qemu_chr_fe_set_msgfds(&tpm_emu->ctrl_chr, fds + 1, 1);
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
-                             sizeof(res)) < 0 || res != 0) {
+                             sizeof(ptm_res), sizeof(res)) < 0 || res != 0) {
         error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
                      strerror(errno));
         goto err_exit;
@@ -706,6 +733,8 @@ static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_STATEBLOB,
                              &pgs, sizeof(pgs.u.req),
+                             /* always returns up to resp.data */
+                             offsetof(ptm_getstate, u.resp.data),
                              offsetof(ptm_getstate, u.resp.data)) < 0) {
         error_report("tpm-emulator: could not get state blob type %d : %s",
                      type, strerror(errno));
@@ -808,7 +837,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
 
     /* write the header only */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
-                             offsetof(ptm_setstate, u.req.data), 0) < 0) {
+                             offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
         error_report("tpm-emulator: could not set state blob type %d : %s",
                      type, strerror(errno));
         return -1;
@@ -992,7 +1021,8 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
         return;
     }
 
-    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(res)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0,
+                             sizeof(ptm_res), sizeof(res)) < 0) {
         error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
                      strerror(errno));
     } else if (res != 0) {
-- 
2.47.0


