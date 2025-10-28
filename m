Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAB6CCF9EE
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjQp-0000N9-KC; Tue, 28 Oct 2025 09:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDjQb-0000JT-Q3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:07:58 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDjQT-0000v7-DL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:07:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 177F3C02A2;
 Tue, 28 Oct 2025 16:07:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id d7duxl1L2qM0-znihA1Fe; Tue, 28 Oct 2025 16:07:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761656862;
 bh=87rM9PFrFHIqtwWn9a7lbC9w3iiM+mfRmmZFaEhia+s=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ma+o84lMocB0H2QH8+L45fh8N/RqXLrCVlj+AfRrSrKhXt4rZxmI2xlTwxCPZiXbK
 /4UtuwEpVm7CFsZPiue4R84159sxoIJ5LnLkW6RHC10XA1J4gYcPVUheJzg7TiPWyY
 qP5H0ZfXycnYZvsziObMU3SKPETjlKhW3BPE5ONc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, vsementsov@yandex-team.ru,
 armenon@redhat.com
Subject: [PATCH v4 2/2] tmp_emulator: improve and fix use of errp
Date: Tue, 28 Oct 2025 16:07:38 +0300
Message-ID: <20251028130738.29037-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028130738.29037-1-vsementsov@yandex-team.ru>
References: <20251028130738.29037-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

tpm_emulator_post_load() and tpm_emulator_set_state_blobs() has
error paths, where they return negative value, but do not set
errp.

To fix that, we also have to convert several other functions to
set errp instead of error_reporting.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/tpm/tpm_emulator.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index dacfca5ab7..6abe9872e6 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -308,22 +308,22 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
     return 0;
 }
 
-static int tpm_emulator_stop_tpm(TPMBackend *tb)
+static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_res res;
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not stop TPM: %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: Could not stop TPM: %s",
+                   strerror(errno));
         return -1;
     }
 
     res = be32_to_cpu(res);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
-                     tpm_emulator_strerror(res));
+        error_setg(errp, "tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
+                   tpm_emulator_strerror(res));
         return -1;
     }
 
@@ -362,12 +362,13 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
 
 static int tpm_emulator_set_buffer_size(TPMBackend *tb,
                                         size_t wanted_size,
-                                        size_t *actual_size)
+                                        size_t *actual_size,
+                                        Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_setbuffersize psbs;
 
-    if (tpm_emulator_stop_tpm(tb) < 0) {
+    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         return -1;
     }
 
@@ -376,16 +377,17 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
                              sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
                              sizeof(psbs.u.resp)) < 0) {
-        error_report("tpm-emulator: Could not set buffer size: %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: Could not set buffer size: %s",
+                   strerror(errno));
         return -1;
     }
 
     psbs.u.resp.tpm_result = be32_to_cpu(psbs.u.resp.tpm_result);
     if (psbs.u.resp.tpm_result != 0) {
-        error_report("tpm-emulator: TPM result for set buffer size : 0x%x %s",
-                     psbs.u.resp.tpm_result,
-                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
+        error_setg(errp,
+                   "tpm-emulator: TPM result for set buffer size : 0x%x %s",
+                   psbs.u.resp.tpm_result,
+                   tpm_emulator_strerror(psbs.u.resp.tpm_result));
         return -1;
     }
 
@@ -402,7 +404,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
 }
 
 static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
-                                     bool is_resume)
+                                           bool is_resume, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_init init = {
@@ -413,7 +415,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     trace_tpm_emulator_startup_tpm_resume(is_resume, buffersize);
 
     if (buffersize != 0 &&
-        tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
+        tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp) < 0) {
         goto err_exit;
     }
 
@@ -424,15 +426,15 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init.u.resp.tpm_result),
                              sizeof(init)) < 0) {
-        error_report("tpm-emulator: could not send INIT: %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: could not send INIT: %s",
+                   strerror(errno));
         goto err_exit;
     }
 
     res = be32_to_cpu(init.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
-                     tpm_emulator_strerror(res));
+        error_setg(errp, "tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
+                   tpm_emulator_strerror(res));
         goto err_exit;
     }
     return 0;
@@ -441,18 +443,31 @@ err_exit:
     return -1;
 }
 
-static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+static int do_tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize,
+                                       Error **errp)
 {
     /* TPM startup will be done from post_load hook */
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         if (buffersize != 0) {
-            return tpm_emulator_set_buffer_size(tb, buffersize, NULL);
+            return tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp);
         }
 
         return 0;
     }
 
-    return tpm_emulator_startup_tpm_resume(tb, buffersize, false);
+    return tpm_emulator_startup_tpm_resume(tb, buffersize, false, errp);
+}
+
+static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+{
+    Error *local_err = NULL;
+    int ret = do_tpm_emulator_startup_tpm(tb, buffersize, &local_err);
+
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
+    return ret;
 }
 
 static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
@@ -546,7 +561,7 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 {
     size_t actual_size;
 
-    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size) < 0) {
+    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {
         return 4096;
     }
 
@@ -889,7 +904,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 
     trace_tpm_emulator_set_state_blobs();
 
-    if (tpm_emulator_stop_tpm(tb) < 0) {
+    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
         return -EIO;
     }
@@ -960,7 +975,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
         return ret;
     }
 
-    if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
+    if (tpm_emulator_startup_tpm_resume(tb, 0, true, errp) < 0) {
         return -EIO;
     }
 
-- 
2.48.1


