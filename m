Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD2AE87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnInk-0003KK-9w; Tue, 03 Feb 2026 10:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnInj-0003Jk-6d
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:58:51 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnInh-0006sT-9H
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:58:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F2F9E8084A;
 Tue, 03 Feb 2026 18:58:47 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iwqMTU0A5Cg0-I7gtx00y; Tue, 03 Feb 2026 18:58:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770134327;
 bh=rn2PK65cx04StmgHrZuRL9Mr6t+S0RBWXgmNjhxDO4s=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RNzwzKk7wTnupL4oUoGpIf2tcDUJNiyKEkJkQiu7CgmKIDVkaPtXYj9M3+BNWg6YC
 WN4zVsssxH7Y1pkwg4AJz3o6cD4QuR0KiuUr7EwNw2x2dqnSPBX8p1fhrDc88mtlQN
 RRBhvPpeW194+ZTZIoR7LK8J3kH53aMwkUK7jwE8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/3] tpm_emulator: drop direct use of errno variable
Date: Tue,  3 Feb 2026 18:58:42 +0300
Message-ID: <20260203155843.79043-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203155843.79043-1-vsementsov@yandex-team.ru>
References: <20260203155843.79043-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 backends/tpm/tpm_emulator.c | 41 +++++++++++++++----------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 6d8529da3b..dc84380b13 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -225,7 +225,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc.u.resp.tpm_result),
                              sizeof(loc)) < 0) {
-        error_setg_errno(errp, errno, "tpm-emulator: could not set locality");
+        error_setg(errp, "tpm-emulator: could not set locality");
         return -1;
     }
 
@@ -263,7 +263,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY, &cap_n, 0,
                              sizeof(cap_n.u.resp.tpm_result),
                              sizeof(cap_n)) < 0) {
-        error_report("tpm-emulator: probing failed : %s", strerror(errno));
+        error_report("tpm-emulator: probing failed");
         return -1;
     }
 
@@ -314,7 +314,7 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_setg_errno(errp, errno, "tpm-emulator: Could not stop TPM");
+        error_setg(errp, "tpm-emulator: Could not stop TPM");
         return -1;
     }
 
@@ -342,8 +342,7 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_LOCK_STORAGE, &pls, sizeof(pls.u.req),
                              sizeof(pls.u.resp.tpm_result),
                              sizeof(pls.u.resp)) < 0) {
-        error_report("tpm-emulator: Could not lock storage within 3 seconds: "
-                     "%s", strerror(errno));
+        error_report("tpm-emulator: Could not lock storage within 3 seconds");
         return -1;
     }
 
@@ -375,8 +374,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
                              sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
                              sizeof(psbs.u.resp)) < 0) {
-        error_setg_errno(errp, errno,
-                         "tpm-emulator: Could not set buffer size");
+        error_setg(errp, "tpm-emulator: Could not set buffer size");
         return -1;
     }
 
@@ -424,7 +422,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init.u.resp.tpm_result),
                              sizeof(init)) < 0) {
-        error_setg_errno(errp, errno, "tpm-emulator: could not send INIT");
+        error_setg(errp, "tpm-emulator: could not send INIT");
         goto err_exit;
     }
 
@@ -479,8 +477,7 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est, 0,
                              sizeof(est) /* always returns resp.bit */,
                              sizeof(est)) < 0) {
-        error_report("tpm-emulator: Could not get the TPM established flag: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not get the TPM established flag");
         return false;
     }
     trace_tpm_emulator_get_tpm_established_flag(est.u.resp.bit);
@@ -508,8 +505,7 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
                              &reset_est, sizeof(reset_est),
                              sizeof(reset_est.u.resp.tpm_result),
                              sizeof(reset_est)) < 0) {
-        error_report("tpm-emulator: Could not reset the establishment bit: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not reset the establishment bit");
         return -1;
     }
 
@@ -539,8 +535,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
     /* FIXME: make the function non-blocking, or it may block a VCPU */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not cancel command: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not cancel command");
     } else if (res != 0) {
         error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
                      be32_to_cpu(res));
@@ -601,8 +596,7 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_emu)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0 || res != 0) {
-        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD");
         goto err_exit;
     }
 
@@ -659,8 +653,8 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
      */
     if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_emu->data_ioc)->fd,
                              &tpm_emu->tpm_version)) {
-        error_report("'%s' is not emulating TPM device. Error: %s",
-                      tpm_emu->options->chardev, strerror(errno));
+        error_report("'%s' is not emulating TPM device.",
+                      tpm_emu->options->chardev);
         goto err;
     }
 
@@ -750,8 +744,7 @@ static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
                              /* always returns up to resp.data */
                              offsetof(ptm_getstate, u.resp.data),
                              offsetof(ptm_getstate, u.resp.data)) < 0) {
-        error_report("tpm-emulator: could not get state blob type %d : %s",
-                     type, strerror(errno));
+        error_report("tpm-emulator: could not get state blob type %d", type);
         return -1;
     }
 
@@ -853,9 +846,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
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
 
@@ -1037,8 +1029,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not cleanly shutdown the TPM");
     } else if (res != 0) {
         error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
                      be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu(res)));
-- 
2.52.0


