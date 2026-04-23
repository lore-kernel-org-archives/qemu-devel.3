Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE688FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcH-0002Wc-S4; Thu, 23 Apr 2026 15:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbw-0002GB-4n
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbq-0001uD-2E
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C0F66A8A4;
 Thu, 23 Apr 2026 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0ZCd2HuC4Fz3TAvfTlRO8nxqPP6uGkjnV2AsiN6Twc=;
 b=2QbVNoQXRToWbAnUkQv1+PA9/2sfaC51YMYvaGchpn07AlLEzneen8syMk7OCOCQh7vKKb
 R6GI6QLa/X0KJK4n9p7Gupq9Un2ISA/caykLb9DNJdLwys1zSxmZYc46NYVrfbPV90mIOB
 p0pDuD4oKnrr+u7sPcin0AJ5RkFAIsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0ZCd2HuC4Fz3TAvfTlRO8nxqPP6uGkjnV2AsiN6Twc=;
 b=9uvpbc3aV31u/EQWfdamR14HY7omgpQZ6t7sOLEz7+3VMrqHdGLF3opngmU5zlQ0S3udWN
 hsb+iIsQ+Gn3itDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0ZCd2HuC4Fz3TAvfTlRO8nxqPP6uGkjnV2AsiN6Twc=;
 b=2QbVNoQXRToWbAnUkQv1+PA9/2sfaC51YMYvaGchpn07AlLEzneen8syMk7OCOCQh7vKKb
 R6GI6QLa/X0KJK4n9p7Gupq9Un2ISA/caykLb9DNJdLwys1zSxmZYc46NYVrfbPV90mIOB
 p0pDuD4oKnrr+u7sPcin0AJ5RkFAIsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0ZCd2HuC4Fz3TAvfTlRO8nxqPP6uGkjnV2AsiN6Twc=;
 b=9uvpbc3aV31u/EQWfdamR14HY7omgpQZ6t7sOLEz7+3VMrqHdGLF3opngmU5zlQ0S3udWN
 hsb+iIsQ+Gn3itDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36480593A3;
 Thu, 23 Apr 2026 19:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KJZPAfNw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 13/43] migration: convert vmstate_subsection_save/load
 functions to bool
Date: Thu, 23 Apr 2026 16:19:27 -0300
Message-ID: <20260423191958.1440-14-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Convert them to bool return value, as preparation to further
convertion of vmstate_save/load_state().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-12-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 53b57c09d8..8825aa3b1f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -21,11 +21,11 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 
-static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc,
-                                   Error **errp);
-static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, Error **errp);
+static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, JSONWriter *vmdesc,
+                                    Error **errp);
+static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, Error **errp);
 static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp);
@@ -305,10 +305,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
     }
     assert(field->flags == VMS_END);
 
-    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
-    if (ret != 0) {
-        qemu_file_set_error(f, ret);
-        return ret;
+    if (!vmstate_subsection_load(f, vmsd, opaque, errp)) {
+        qemu_file_set_error(f, -EINVAL);
+        return -EINVAL;
     }
 
     if (!vmstate_post_load(vmsd, opaque, version_id, errp)) {
@@ -637,7 +636,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp) ? 0 : -EINVAL;
 
 out:
     if (vmsd->post_save) {
@@ -667,15 +666,14 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                                 errp);
 }
 
-static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, Error **errp)
+static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, Error **errp)
 {
     ERRP_GUARD();
     trace_vmstate_subsection_load(vmsd->name);
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
         char idstr[256], *idstr_ret;
-        int ret;
         uint8_t version_id, len, size;
         const VMStateDescription *sub_vmsd;
 
@@ -683,12 +681,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         if (len < strlen(vmsd->name) + 1) {
             /* subsection name has to be "section_name/a" */
             trace_vmstate_subsection_load_bad(vmsd->name, "(short)", "");
-            return 0;
+            return true;
         }
         size = qemu_peek_buffer(f, (uint8_t **)&idstr_ret, len, 2);
         if (size != len) {
             trace_vmstate_subsection_load_bad(vmsd->name, "(peek fail)", "");
-            return 0;
+            return true;
         }
         memcpy(idstr, idstr_ret, size);
         idstr[size] = 0;
@@ -696,41 +694,39 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
-            return 0;
+            return true;
         }
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
             error_setg(errp, "VM subsection '%s' in '%s' does not exist",
                        idstr, vmsd->name);
-            return -ENOENT;
+            return false;
         }
         qemu_file_skip(f, 1); /* subsection */
         qemu_file_skip(f, 1); /* len */
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
-        if (ret) {
+        if (vmstate_load_state(f, sub_vmsd, opaque, version_id, errp) < 0) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
             error_prepend(errp,
-                          "Loading VM subsection '%s' in '%s' failed: %d: ",
-                          idstr, vmsd->name, ret);
-            return ret;
+                          "Loading VM subsection '%s' in '%s' failed: ",
+                          idstr, vmsd->name);
+            return false;
         }
     }
 
     trace_vmstate_subsection_load_good(vmsd->name);
-    return 0;
+    return true;
 }
 
-static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc,
-                                   Error **errp)
+static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, JSONWriter *vmdesc,
+                                    Error **errp)
 {
     const VMStateDescription * const *sub = vmsd->subsections;
     bool vmdesc_has_subsections = false;
-    int ret = 0;
 
     trace_vmstate_subsection_save_top(vmsd->name);
     while (sub && *sub) {
@@ -754,9 +750,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
-            if (ret) {
-                return ret;
+            if (vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp) < 0) {
+                return false;
             }
 
             if (vmdesc) {
@@ -770,5 +765,5 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    return ret;
+    return true;
 }
-- 
2.51.0


