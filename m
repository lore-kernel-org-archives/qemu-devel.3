Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E9FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcX-0003wB-Nv; Thu, 23 Apr 2026 15:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzc1-0002Ia-VH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:27 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbz-0001wR-Jq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EF9E6A890;
 Thu, 23 Apr 2026 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGdNtJD7CyO/idoRU9phWcfMReSkffagymXqK6GhVsU=;
 b=1DVPc85RtisrsI9NqjkZsVJ85y9wNPlHDbXcteboZoD2Ro34YmDgwh3N5qhjWEZO82XSYM
 JUwe+XnKzKqB4DKp1qi/LnFmkxlXNWi0Ze/rxYELYfg3dBxdxBHZ4emQoIemK7RvRWDSNL
 Rl7Z1t+9QtrmFaW6LurOx6hKFH6Wu9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGdNtJD7CyO/idoRU9phWcfMReSkffagymXqK6GhVsU=;
 b=1CrOfGtEwEk3Igzya62gtQTtbAdY9YywBHnIlnXoi58AZnnDYTGx93MyhC+inQEhnOAY5z
 lNJKFUuDdyqGV9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGdNtJD7CyO/idoRU9phWcfMReSkffagymXqK6GhVsU=;
 b=1DVPc85RtisrsI9NqjkZsVJ85y9wNPlHDbXcteboZoD2Ro34YmDgwh3N5qhjWEZO82XSYM
 JUwe+XnKzKqB4DKp1qi/LnFmkxlXNWi0Ze/rxYELYfg3dBxdxBHZ4emQoIemK7RvRWDSNL
 Rl7Z1t+9QtrmFaW6LurOx6hKFH6Wu9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGdNtJD7CyO/idoRU9phWcfMReSkffagymXqK6GhVsU=;
 b=1CrOfGtEwEk3Igzya62gtQTtbAdY9YywBHnIlnXoi58AZnnDYTGx93MyhC+inQEhnOAY5z
 lNJKFUuDdyqGV9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A19C593A3;
 Thu, 23 Apr 2026 19:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yGSvGfRw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 14/43] migration: VMStateInfo: introduce new handlers with errp
Date: Thu, 23 Apr 2026 16:19:28 -0300
Message-ID: <20260423191958.1440-15-farosas@suse.de>
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

Add new APIs with errp, to allow handlers report good
error messages. We'll convert existing handlers soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-13-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 17 ++++++++++++++---
 migration/vmstate.c         |  4 ++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9d42cf7a64..65683d8d87 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -32,12 +32,16 @@
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateField VMStateField;
 
-/* VMStateInfo allows customized migration of objects that don't fit in
+/*
+ * VMStateInfo allows customized migration of objects that don't fit in
  * any category in VMStateFlags. Additional information is always passed
- * into get and put in terms of field and vmdesc parameters. However
+ * into load and save in terms of field and vmdesc parameters. However
  * these two parameters should only be used in cases when customized
  * handling is needed, such as QTAILQ. For primitive data types such as
- * integer, field and vmdesc parameters should be ignored inside get/put.
+ * integer, field and vmdesc parameters should be ignored inside load/save.
+ *
+ * @get and @put are deprecated copies of @load and @save. For new interfaces
+ * use @load and @save.
  */
 struct VMStateInfo {
     const char *name;
@@ -46,6 +50,13 @@ struct VMStateInfo {
     int coroutine_mixed_fn (*put)(QEMUFile *f, void *pv, size_t size,
                                   const VMStateField *field,
                                   JSONWriter *vmdesc);
+    bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, size_t size,
+                                    const VMStateField *field,
+                                    Error **errp);
+    bool coroutine_mixed_fn (*save)(QEMUFile *f, void *pv, size_t size,
+                                    const VMStateField *field,
+                                    JSONWriter *vmdesc,
+                                    Error **errp);
 };
 
 enum VMStateFlags {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 8825aa3b1f..f16626d7d1 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -170,6 +170,8 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
     } else if (field->flags & VMS_VSTRUCT) {
         return vmstate_load_state(f, field->vmsd, pv, field->struct_version_id,
                                   errp) >= 0;
+    } else if (field->info->load) {
+        return field->info->load(f, pv, size, field, errp);
     }
 
     if (field->info->get(f, pv, size, field) < 0) {
@@ -495,6 +497,8 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
         return vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
                                     field->struct_version_id,
                                     errp) >= 0;
+    } else if (field->info->save) {
+        return field->info->save(f, pv, size, field, vmdesc, errp);
     }
 
     if (field->info->put(f, pv, size, field, vmdesc) < 0) {
-- 
2.51.0


