Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EBBFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzbE-0001r2-84; Thu, 23 Apr 2026 15:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbC-0001ql-ST
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbB-0001mx-1T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEE326A895;
 Thu, 23 Apr 2026 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JKcEOnO7xBPxJ/X7f5K350z+JIenmi31J54e57taoM=;
 b=lxywY9JUDE72cjl4oX3pFLZapl/uFpefOKORVaAd8ykWSUpdrG8C0hSHBHU0OxBvPptVBh
 iwAz2NXCldl0Rs2Co3Xb+W3t3PjIx9L68s/Z/Ht4ornoJLxaPqHFP8G8N2XWY9fTyQrOOE
 of/hg8f5vv1VDBwCPP+PBZ07zposk7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JKcEOnO7xBPxJ/X7f5K350z+JIenmi31J54e57taoM=;
 b=oatIl6uBesPAcpFUw53Lec7cCwFoW8sMiSBlmkmdPhBWPBmcGIvzDREL7kIgQr17MXTw9i
 ucVYjSPQ5RzwpiCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BuuP4Vqp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Px0krCV9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JKcEOnO7xBPxJ/X7f5K350z+JIenmi31J54e57taoM=;
 b=BuuP4VqpTzs1ENm5Gfsej0DxXk6NFAb54sduzRF4XrDgThr9hCkC2qPYKfJthWC8HgORwq
 OdT08X5+7cpTQF2zftbQ9mROPEkQmHSnixlvM6S/fLEu2zYKR9hjEHPcd/KR0GlssU9XW7
 t+htG3oUkWQAmhwYoOqUdVrpJncCags=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JKcEOnO7xBPxJ/X7f5K350z+JIenmi31J54e57taoM=;
 b=Px0krCV9EoR80vTQef3UU43ZxbjCQcvFt+KcS3uxA20+JHOY2wgqfl4qxhiV7LBzW/WYXb
 S9M92aN1UXQXdjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B61593A3;
 Thu, 23 Apr 2026 19:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sLkzIepw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 07/43] migration: vmstate_save/load_state(): refactor tracing
 errors
Date: Thu, 23 Apr 2026 16:19:21 -0300
Message-ID: <20260423191958.1440-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BEE326A895
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

To simplify further changes (convertion to bool+errp APIs),
let's rework some error paths:

- get rid of int ret in traces, as we are moving to bool+errp APIs
- split traces to _fail / _success (seems better than add boolean
  result to the message).
- prefer short error paths (return immediately on error)
- around trace_vmstate_load_field_error(), do not call
  qemu_file_set_error(), if the erroc comes from qemu_file_get_error()

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-6-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/trace-events |  6 ++++--
 migration/vmstate.c    | 25 +++++++++++++++----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index 60e5087e38..27459dfb78 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -56,13 +56,15 @@ postcopy_page_req_sync(void *host_addr) "sync page req %p"
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
 vmstate_load_state(const char *name, int version_id) "%s v%d"
-vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
+vmstate_load_state_fail(const char *name, const char *reason) "%s %s"
+vmstate_load_state_success(const char *name) "%s"
 vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
 vmstate_n_elems(const char *name, int n_elems) "%s: %d"
 vmstate_subsection_load(const char *parent) "%s"
 vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
 vmstate_subsection_load_good(const char *parent) "%s"
-vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
+vmstate_save_state_pre_save_fail(const char *name) "%s"
+vmstate_save_state_pre_save_success(const char *name) "%s"
 vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
 vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index dd7cd27993..87e1f04959 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -144,7 +144,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too new "
                    "for local version_id %d",
                    vmsd->name, version_id, vmsd->version_id);
-        trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
+        trace_vmstate_load_state_fail(vmsd->name, "too new");
         return -EINVAL;
     }
 
@@ -152,7 +152,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
                    vmsd->name, version_id, vmsd->minimum_version_id);
-        trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
+        trace_vmstate_load_state_fail(vmsd->name, "too old");
         return -EINVAL;
     }
 
@@ -240,10 +240,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                         error_setg(errp,
                                    "Failed to load %s state: stream error: %d",
                                    vmsd->name, ret);
+                        trace_vmstate_load_field_error(field->name, ret);
+                        return ret;
                     }
-                }
-
-                if (ret < 0) {
+                } else {
                     qemu_file_set_error(f, ret);
                     trace_vmstate_load_field_error(field->name, ret);
                     return ret;
@@ -269,7 +269,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             error_prepend(errp, "post load hook failed for: %s, version_id: "
                           "%d, minimum_version: %d: ", vmsd->name,
                           vmsd->version_id, vmsd->minimum_version_id);
-            ret = -EINVAL;
+            trace_vmstate_load_state_fail(vmsd->name, "post-load");
+            return -EINVAL;
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -279,12 +280,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        "minimum_version: %d, ret: %d",
                        vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
                        ret);
+            trace_vmstate_load_state_fail(vmsd->name, "post-load");
+            return ret;
         }
     }
 
-    trace_vmstate_load_state_end(vmsd->name, "end", ret);
+    trace_vmstate_load_state_success(vmsd->name);
 
-    return ret;
+    return 0;
 }
 
 static int vmfield_name_num(const VMStateField *start,
@@ -444,20 +447,22 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     if (vmsd->pre_save_errp) {
         ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
+            trace_vmstate_save_state_pre_save_fail(vmsd->name);
             return ret;
         }
     } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
             error_setg(errp, "pre-save failed: %s", vmsd->name);
+            trace_vmstate_save_state_pre_save_fail(vmsd->name);
             return ret;
         }
     }
 
+    trace_vmstate_save_state_pre_save_success(vmsd->name);
+
     if (vmdesc) {
         json_writer_str(vmdesc, "vmsd_name", vmsd->name);
         json_writer_int64(vmdesc, "version", version_id);
-- 
2.51.0


