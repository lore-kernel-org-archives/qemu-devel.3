Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FFAE65296
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 17:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmbF3-0006FN-6k; Sun, 01 Feb 2026 12:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmbEs-0006DE-8K
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 12:27:59 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmbEo-0001Io-Jh
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 12:27:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 45816C015B;
 Sun, 01 Feb 2026 20:27:51 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:765::1:3b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lRqPDK1ApmI0-NeaLWHnO; Sun, 01 Feb 2026 20:27:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769966870;
 bh=Cigj110d2UgIT0XpGz4tB2+q+GOBy+tRTiVbB0csHfg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LdLhVS8YTPvaliSPR+7F+CulZkHVU3odNb9DS7a1p2YoB9Zr3xdOTBpyzPUP4XZBJ
 zK5rSB6luLP6jS83YKsx3GIFDAXWdmb5iZlSLru1cFKWN4n19OHtqzc6fANO8/J36e
 zECx9uiC7Dkl7GMYkngSTt7/ZBJrVLE5DeVyl9rg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/3] tpm_emulator: tpm_emulator_set_state_blobs(): move to
 boolean return
Date: Sun,  1 Feb 2026 20:27:46 +0300
Message-ID: <20260201172746.404481-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201172746.404481-1-vsementsov@yandex-team.ru>
References: <20260201172746.404481-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The returned error is only used to check for success, so no reason
to use specific errno values.

Also, this is the only function with -errno contract in the file,
so converting it simplifies the whole file from three types of
contract (0/-1, 0/-errno, true/false) to only two (0/-1, true/false).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
2.52.0


