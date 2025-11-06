Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DEDCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5rW-0003lZ-C1; Thu, 06 Nov 2025 14:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH5rV-0003kn-7g
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:41:37 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH5rR-0005bJ-6i
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:41:37 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5018680E79;
 Thu, 06 Nov 2025 22:41:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RfspdL0FKeA0-FNyxTx50; Thu, 06 Nov 2025 22:41:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762458089;
 bh=v6HP1T8GOduMM4bGIjnnBFiziHrer4bW5QVb1bfaNfc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Qz4uic5QLa5+yQ8hoDZzgT8Q3UtMfjtY8OD5Blv3TBCwn16kRWmuzHT1cl9Jzpzkn
 43orewy9aBaiOIxaAe15ApuF6Up2xMgJ2yaG8NtjBht2/9CrmyJ6RVU7ScYZUW1jDQ
 5b789q8rwyeMS7MRLI2Od0Hpd68h+8OF61VTcUzY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/3] tpm_emulator: drop direct use of errno variable
Date: Thu,  6 Nov 2025 22:41:25 +0300
Message-ID: <20251106194126.569037-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106194126.569037-1-vsementsov@yandex-team.ru>
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The code tends to include errno into error messages after
tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.

Both has error paths, where errno is not set, examples:

tpm_emulator_ctrlcmd()
  qemu_chr_fe_write_all()
    qemu_chr_write()
      replay_char_write_event_load()
        ...
        *res = replay_get_dword();
        ...

tpm_util_test_tpmdev()
  tpm_util_test()
    tpm_util_request()
      ...
      if (n != requestlen) {
          return -EFAULT;
      }
      ...

Both doesn't document that they set errno.

Let's drop these explicit usage of errno. If we need this information,
it should be added to errp deeper in the stack.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/tpm/tpm_emulator.c | 44 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 24aa18302e..79f3e6b1f2 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -225,8 +225,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc.u.resp.tpm_result),
                              sizeof(loc)) < 0) {
-        error_setg(errp, "tpm-emulator: could not set locality : %s",
-                   strerror(errno));
+        error_setg(errp, "tpm-emulator: could not set locality");
         return -1;
     }
 
@@ -264,7 +263,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY, &cap_n, 0,
                              sizeof(cap_n.u.resp.tpm_result),
                              sizeof(cap_n)) < 0) {
-        error_report("tpm-emulator: probing failed : %s", strerror(errno));
+        error_report("tpm-emulator: probing failed");
         return -1;
     }
 
@@ -315,8 +314,7 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_setg(errp, "tpm-emulator: Could not stop TPM: %s",
-                   strerror(errno));
+        error_setg(errp, "tpm-emulator: Could not stop TPM");
         return -1;
     }
 
@@ -344,8 +342,7 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_LOCK_STORAGE, &pls, sizeof(pls.u.req),
                              sizeof(pls.u.resp.tpm_result),
                              sizeof(pls.u.resp)) < 0) {
-        error_report("tpm-emulator: Could not lock storage within 3 seconds: "
-                     "%s", strerror(errno));
+        error_report("tpm-emulator: Could not lock storage within 3 seconds");
         return -1;
     }
 
@@ -377,8 +374,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
                              sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
                              sizeof(psbs.u.resp)) < 0) {
-        error_setg(errp, "tpm-emulator: Could not set buffer size: %s",
-                   strerror(errno));
+        error_setg(errp, "tpm-emulator: Could not set buffer size");
         return -1;
     }
 
@@ -426,8 +422,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init.u.resp.tpm_result),
                              sizeof(init)) < 0) {
-        error_setg(errp, "tpm-emulator: could not send INIT: %s",
-                   strerror(errno));
+        error_setg(errp, "tpm-emulator: could not send INIT");
         goto err_exit;
     }
 
@@ -482,8 +477,7 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est, 0,
                              sizeof(est) /* always returns resp.bit */,
                              sizeof(est)) < 0) {
-        error_report("tpm-emulator: Could not get the TPM established flag: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not get the TPM established flag");
         return false;
     }
     trace_tpm_emulator_get_tpm_established_flag(est.u.resp.bit);
@@ -511,8 +505,7 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
                              &reset_est, sizeof(reset_est),
                              sizeof(reset_est.u.resp.tpm_result),
                              sizeof(reset_est)) < 0) {
-        error_report("tpm-emulator: Could not reset the establishment bit: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not reset the establishment bit");
         return -1;
     }
 
@@ -542,8 +535,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
     /* FIXME: make the function non-blocking, or it may block a VCPU */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not cancel command: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not cancel command: %s");
     } else if (res != 0) {
         error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
                      be32_to_cpu(res));
@@ -604,8 +596,7 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_emu)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0 || res != 0) {
-        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD");
         goto err_exit;
     }
 
@@ -662,8 +653,8 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
      */
     if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_emu->data_ioc)->fd,
                              &tpm_emu->tpm_version)) {
-        error_report("'%s' is not emulating TPM device. Error: %s",
-                      tpm_emu->options->chardev, strerror(errno));
+        error_report("'%s' is not emulating TPM device.",
+                      tpm_emu->options->chardev);
         goto err;
     }
 
@@ -753,8 +744,7 @@ static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
                              /* always returns up to resp.data */
                              offsetof(ptm_getstate, u.resp.data),
                              offsetof(ptm_getstate, u.resp.data)) < 0) {
-        error_report("tpm-emulator: could not get state blob type %d : %s",
-                     type, strerror(errno));
+        error_report("tpm-emulator: could not get state blob type %d", type);
         return -1;
     }
 
@@ -856,9 +846,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     /* write the header only */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
                              offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
-        error_setg_errno(errp, errno,
-                         "tpm-emulator: could not set state blob type %d",
-                         type);
+        error_setg(errp, "tpm-emulator: could not set state blob type %d",
+                   type);
         return -1;
     }
 
@@ -1040,8 +1029,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not cleanly shutdown the TPM");
     } else if (res != 0) {
         error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
                      be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu(res)));
-- 
2.48.1


