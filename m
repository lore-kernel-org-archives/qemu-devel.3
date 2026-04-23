Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963D2FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzb3-0001p4-7X; Thu, 23 Apr 2026 15:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzb2-0001oq-05
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzaz-0001l6-VB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB1475BD43;
 Thu, 23 Apr 2026 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW9G0EYa6E6Tg/mKSmoKUz9WbeXqnsVcQ2JCueVsOkk=;
 b=V2qU2uqv+P2qtJ49qdNvMTlwDZG8l9Bs6Yrms4Pfwh03JjL1MBGQVLqR/8PyibhfoRPHqq
 guUqi7a8CxpsuCXaJHjBsLHmS3f7cadcbQgJjJ4W1d3OY7MEEB8ASuN+ctCczI86b59mFZ
 BABi4+dHFCkbueFPJ7JvZD10E0en3DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW9G0EYa6E6Tg/mKSmoKUz9WbeXqnsVcQ2JCueVsOkk=;
 b=4OFwzZipFRWthgDNcHG4jFZCzcny01Kr9vkNZc/Tq7DYJt6u44G0hiDLg5ZBoz0eIuzYlG
 qcnGXd4lFILpqJDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW9G0EYa6E6Tg/mKSmoKUz9WbeXqnsVcQ2JCueVsOkk=;
 b=PlRc8HQ/CrHjCfclTihGf1Pjc24sDvOnZG1vabi1pWFUxhtHWsqaHL6ho1V/zaAdPomLzK
 E1Fcnyhr/H6HslnUQ+B6RvGJxdgrwSZ6ni6NbMqvJrzjBWoXq34+5s5paIktMQyr3NoqXW
 iz0pfiGSTyzF6YVVoM3RczMbvolFwjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW9G0EYa6E6Tg/mKSmoKUz9WbeXqnsVcQ2JCueVsOkk=;
 b=g3xSr8Fd6QhP211N2JbNWBmeF8jaMm/1DLZq8zHLJl9IXfdIh73iboThgHjtcZ52IFcaNN
 cN0Svvdvzk059BCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3382593A3;
 Thu, 23 Apr 2026 19:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIzOH+dw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/43] migration: make .post_save() a void function
Date: Thu, 23 Apr 2026 16:19:19 -0300
Message-ID: <20260423191958.1440-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

All other handlers now have _errp() variants. Should we go this way
for .post_save()? Actually it's rather strange, when the vmstate do
successful preparations in .pre_save(), then successfully save all
sections and subsections, end then fail when all the state is
successfully transferred to the target.

Happily, we have only three .post_save() realizations, all always
successful. Let's make this a rule.

Also note, that we call .post_save() in two places, and handle
its (theoretical) failure inconsistently. Fix that too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com> #rust
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-4-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/main.rst    |  2 +-
 hw/ppc/spapr_pci.c               |  3 +--
 include/migration/vmstate.h      |  8 +++++++-
 migration/savevm.c               |  3 +--
 migration/vmstate.c              | 12 +++---------
 rust/migration/src/migratable.rs |  6 ++----
 rust/migration/src/vmstate.rs    | 12 +++++++-----
 target/arm/machine.c             |  4 +---
 8 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 234d280249..2de7050764 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -439,7 +439,7 @@ The functions to do that are inside a vmstate definition, and are called:
 
   This function is called before we save the state of one device.
 
-- ``int (*post_save)(void *opaque);``
+- ``void (*post_save)(void *opaque);``
 
   This function is called after we save the state of one device
   (even upon failure, unless the call to pre_save returned an error).
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ea998bdff1..1dc3b02659 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2093,14 +2093,13 @@ static int spapr_pci_pre_save(void *opaque)
     return 0;
 }
 
-static int spapr_pci_post_save(void *opaque)
+static void spapr_pci_post_save(void *opaque)
 {
     SpaprPhbState *sphb = opaque;
 
     g_free(sphb->msi_devs);
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = 0;
-    return 0;
 }
 
 static int spapr_pci_post_load(void *opaque, int version_id)
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 78d97151bd..9d42cf7a64 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -223,7 +223,13 @@ struct VMStateDescription {
     bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
     bool (*pre_save_errp)(void *opaque, Error **errp);
-    int (*post_save)(void *opaque);
+
+    /*
+     * Unless .pre_save() fails, .post_save() is called after saving
+     * fields and subsections. It should not fail because at this
+     * point the state has potentially already been transferred.
+     */
+    void (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index dd58f2a705..699d2c9f8b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -321,14 +321,13 @@ static int configuration_pre_save(void *opaque)
     return 0;
 }
 
-static int configuration_post_save(void *opaque)
+static void configuration_post_save(void *opaque)
 {
     SaveState *state = opaque;
 
     g_free(state->capabilities);
     state->capabilities = NULL;
     state->caps_count = 0;
-    return 0;
 }
 
 static int configuration_pre_load(void *opaque)
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 651c3fe011..5111e7a141 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -550,10 +550,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_prepend(errp, "Save of field %s/%s failed: ",
                                   vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
-                    }
-                    return ret;
+                    goto out;
                 }
 
                 /* Compressed arrays only care about the first element */
@@ -578,12 +575,9 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
+out:
     if (vmsd->post_save) {
-        int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
-            ret = ps_ret;
-            error_setg(errp, "post-save failed: %s", vmsd->name);
-        }
+        vmsd->post_save(opaque);
     }
     return ret;
 }
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index 7748aac2f2..b9e5e1fc15 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -406,10 +406,8 @@ fn pre_save(&self) -> Result<(), InvalidError> {
         Ok(())
     }
 
-    fn post_save(&self) -> Result<(), InvalidError> {
-        let state = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
-        drop(state);
-        Ok(())
+    fn post_save(&self) {
+        let _ = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
     }
 
     fn pre_load(&self) -> Result<(), InvalidError> {
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index edc7c70265..f34a36f680 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -492,6 +492,11 @@ fn from(_value: InvalidError) -> Errno {
     into_neg_errno(result)
 }
 
+unsafe extern "C" fn vmstate_post_save_cb<T, F: for<'a> FnCall<(&'a T,), ()>>(opaque: *mut c_void) {
+    // SAFETY: the function is used in T's implementation of VMState.
+    F::call((unsafe { &*(opaque.cast::<T>()) },));
+}
+
 unsafe extern "C" fn vmstate_post_load_cb<
     T,
     F: for<'a> FnCall<(&'a T, u8), Result<(), impl Into<Errno>>>,
@@ -597,12 +602,9 @@ pub const fn pre_save<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>
     }
 
     #[must_use]
-    pub const fn post_save<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>(
-        mut self,
-        _f: &F,
-    ) -> Self {
+    pub const fn post_save<F: for<'a> FnCall<(&'a T,), ()>>(mut self, _f: &F) -> Self {
         self.0.post_save = if F::IS_SOME {
-            Some(vmstate_no_version_cb::<T, F>)
+            Some(vmstate_post_save_cb::<T, F>)
         } else {
             None
         };
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b0e499515c..50d80ffb68 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -998,7 +998,7 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
-static int cpu_post_save(void *opaque)
+static void cpu_post_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
@@ -1008,8 +1008,6 @@ static int cpu_post_save(void *opaque)
 
     cpu->cpreg_vmstate_indexes = NULL;
     cpu->cpreg_vmstate_values = NULL;
-
-    return 0;
 }
 
 static int cpu_pre_load(void *opaque)
-- 
2.51.0


