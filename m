Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DBBCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5rX-0003m5-N7; Thu, 06 Nov 2025 14:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH5rU-0003kS-TR
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:41:36 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH5rR-0005bL-6j
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:41:36 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D2505C01A6;
 Thu, 06 Nov 2025 22:41:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RfspdL0FKeA0-qSZWJnck; Thu, 06 Nov 2025 22:41:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762458090;
 bh=WRSWwJjugz5gbC1LAoiahIUfa+K65oR/zZ3p/rr4nL4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=A3lP6SK7TQgyiB95kDepnCkg7DujRsEaorW2Bg3uDudRuy4XVQWS4lk9gEaZ47ilL
 kVRE5y300moLl8Ab3tVFddUEMXnLFpe5kYdmqXUtNnO4HpfPRHEN1TMYSYtZdfKXTA
 5fuT4LR+jYXlz6grLE2HtsAAC5VeExoakVYKwGcM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/3] tpm_emulator: tpm_emulator_set_state_blobs(): move to
 boolean return
Date: Thu,  6 Nov 2025 22:41:26 +0300
Message-ID: <20251106194126.569037-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106194126.569037-1-vsementsov@yandex-team.ru>
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
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

The returned error is only used to check for success, so no reason
to use specific errno values.

Also, this is the only function with -errno contract in the file,
so converting it simplifies the whole file from three types of
contract (0/-1, 0/-errno, true/false) to only two (0/-1, true/false).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/tpm/tpm_emulator.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 79f3e6b1f2..3c62bfa3ed 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -885,10 +885,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
 
 /*
  * Set all the TPM state blobs.
- *
- * Returns a negative errno code in case of error.
  */
-static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
+static bool tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
@@ -897,7 +895,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 
     if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
-        return -EIO;
+        return false;
     }
 
     if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
@@ -909,12 +907,12 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
         tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
                                     &state_blobs->savestate,
                                     state_blobs->savestate_flags, errp) < 0) {
-        return -EIO;
+        return false;
     }
 
     trace_tpm_emulator_set_state_blobs_done();
 
-    return 0;
+    return true;
 }
 
 static int tpm_emulator_pre_save(void *opaque)
@@ -959,8 +957,7 @@ static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
     TPMBackend *tb = opaque;
     int ret;
 
-    ret = tpm_emulator_set_state_blobs(tb, errp);
-    if (ret < 0) {
+    if (!tpm_emulator_set_state_blobs(tb, errp)) {
         return false;
     }
 
-- 
2.48.1


