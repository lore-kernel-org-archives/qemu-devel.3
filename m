Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6F8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnCv-0001Ev-0J; Tue, 28 Oct 2025 13:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDnCp-0001Dp-SO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:09:59 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDnCV-0000JT-Tm
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:09:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C91C0811D6;
 Tue, 28 Oct 2025 20:09:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id U9hrmt1IrqM0-7pGDBc2Z; Tue, 28 Oct 2025 20:09:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761671372;
 bh=36XrE2FiyYGWPsWsaZEcXpEbfljyDHhrmcPoWm5Itbo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HQvRKoOoZlDhMytm+VLQBAWghH3FXrZLWMVyPBtvwd4YlvPXTqGQcE54PgFK2dJYq
 ANJNr7lCOhhb4u6ocqJ4gg+HmI6Rm/98Ody1acTvg0lHY+UVckSYcsYFnjDf+W2Hon
 UF6Q+c/KicZ04t/l1WUpL+/Ji6DQaDpx6IVyy6/8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, vsementsov@yandex-team.ru,
 armenon@redhat.com
Subject: [PATCH v4 4/4] migration: vmsd errp handlers: return bool
Date: Tue, 28 Oct 2025 20:09:26 +0300
Message-ID: <20251028170926.77219-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028170926.77219-1-vsementsov@yandex-team.ru>
References: <20251028130738.29037-1-vsementsov@yandex-team.ru>
 <20251028170926.77219-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

No code actually depend on specific errno values returned by
vmstate_load_state. The only use of it is to check for success,
and sometimes inject numeric error values into error messages
in migration code. The latter is not a stopper for gradual
conversion to "errp + bool return value" APIs.

Big analysis of vmstate_load_state() callers, showing that
specific errno values are not actually used, is done by Peter
here:

https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/

Converting of vmstate_load_state() itself will follow in
another series.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/tpm/tpm_emulator.c   | 10 ++++------
 docs/devel/migration/main.rst |  6 +++---
 include/migration/vmstate.h   |  6 +++---
 migration/vmstate.c           | 11 +++++------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 6abe9872e6..846ac015b3 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -962,24 +962,22 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
 
 /*
  * Load the TPM state blobs into the TPM.
- *
- * Returns negative errno codes in case of error.
  */
-static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
+static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
 {
     TPMBackend *tb = opaque;
     int ret;
 
     ret = tpm_emulator_set_state_blobs(tb, errp);
     if (ret < 0) {
-        return ret;
+        return false;
     }
 
     if (tpm_emulator_startup_tpm_resume(tb, 0, true, errp) < 0) {
-        return -EIO;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_tpm_emulator = {
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 1afe7b9689..234d280249 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -446,15 +446,15 @@ The functions to do that are inside a vmstate definition, and are called:
 
 Following are the errp variants of these functions.
 
-- ``int (*pre_load_errp)(void *opaque, Error **errp);``
+- ``bool (*pre_load_errp)(void *opaque, Error **errp);``
 
   This function is called before we load the state of one device.
 
-- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
+- ``bool (*post_load_errp)(void *opaque, int version_id, Error **errp);``
 
   This function is called after we load the state of one device.
 
-- ``int (*pre_save_errp)(void *opaque, Error **errp);``
+- ``bool (*pre_save_errp)(void *opaque, Error **errp);``
 
   This function is called before we save the state of one device.
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 63ccaee07a..dbe330dd5f 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -218,11 +218,11 @@ struct VMStateDescription {
     int minimum_version_id;
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
-    int (*pre_load_errp)(void *opaque, Error **errp);
+    bool (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
-    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
+    bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
-    int (*pre_save_errp)(void *opaque, Error **errp);
+    bool (*pre_save_errp)(void *opaque, Error **errp);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 677e56c84a..4d28364f7b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -154,13 +154,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return -EINVAL;
     }
     if (vmsd->pre_load_errp) {
-        ret = vmsd->pre_load_errp(opaque, errp);
-        if (ret < 0) {
+        if (!vmsd->pre_load_errp(opaque, errp)) {
             error_prepend(errp, "pre load hook failed for: '%s', "
                           "version_id: %d, minimum version_id: %d: ",
                           vmsd->name, vmsd->version_id,
                           vmsd->minimum_version_id);
-            return ret;
+            return -EINVAL;
         }
     } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
@@ -256,11 +255,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return ret;
     }
     if (vmsd->post_load_errp) {
-        ret = vmsd->post_load_errp(opaque, version_id, errp);
-        if (ret < 0) {
+        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
             error_prepend(errp, "post load hook failed for: %s, version_id: "
                           "%d, minimum_version: %d: ", vmsd->name,
                           vmsd->version_id, vmsd->minimum_version_id);
+            ret = -EINVAL;
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -438,7 +437,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     trace_vmstate_save_state_top(vmsd->name);
 
     if (vmsd->pre_save_errp) {
-        ret = vmsd->pre_save_errp(opaque, errp);
+        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
-- 
2.48.1


