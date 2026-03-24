Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C987EFEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fz-0003Wf-Jl; Tue, 24 Mar 2026 15:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fx-0003Vq-Hc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:29 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fv-0008I6-UX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A35F4D302;
 Tue, 24 Mar 2026 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63mC52iV5MkEp+HLbHVQPfmQqczrd6LZlI71WtZfISA=;
 b=n9ClH9OIXYJRv+J6b0tKUi41js7PAQOxs/Nt/zTxVNN7G7anacnzVUAb5rVWl8QB3q76Ql
 rz6gWhCtg+t0oE52l4hCrFm7RmSHnqMhUvyzXv6oD5mhilFrCOgZdxqaqqsn0UrmFGxLgs
 fJSQKutobobHyguRLPNmMxZvMU6348o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63mC52iV5MkEp+HLbHVQPfmQqczrd6LZlI71WtZfISA=;
 b=9l22+0Ft+kV+ljQozBBmqSzxxrTJHiBBJlXHqCvSS16BeU1jnaZZkhpUqz3hRUigyIqezi
 xHR8vRlZP6Kj8RCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63mC52iV5MkEp+HLbHVQPfmQqczrd6LZlI71WtZfISA=;
 b=n9ClH9OIXYJRv+J6b0tKUi41js7PAQOxs/Nt/zTxVNN7G7anacnzVUAb5rVWl8QB3q76Ql
 rz6gWhCtg+t0oE52l4hCrFm7RmSHnqMhUvyzXv6oD5mhilFrCOgZdxqaqqsn0UrmFGxLgs
 fJSQKutobobHyguRLPNmMxZvMU6348o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63mC52iV5MkEp+HLbHVQPfmQqczrd6LZlI71WtZfISA=;
 b=9l22+0Ft+kV+ljQozBBmqSzxxrTJHiBBJlXHqCvSS16BeU1jnaZZkhpUqz3hRUigyIqezi
 xHR8vRlZP6Kj8RCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6384C43FE4;
 Tue, 24 Mar 2026 19:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJD3DH3pwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 14/17] vmstate: Move VMS_MUST_EXIST check
Date: Tue, 24 Mar 2026 16:43:29 -0300
Message-ID: <20260324194333.30004-15-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLuo5zndapfjusa9yqdunguuf8)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Move the VMS_MUST_EXIST check into the vmstate_field_exists() function
and make it return bool + errp. This deduplicates a bit of code
between save and load.

XXX: why do we assert on save?

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 8f0f9383e2..5bc860129e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -30,10 +30,10 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp);
 
-/* Whether this field should exist for either save or load the VM? */
-static bool
-vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
-                     void *opaque, int version_id)
+static bool vmstate_field_exists(const VMStateDescription *vmsd,
+                                 const VMStateField *field,
+                                 void *opaque, int version_id,
+                                 bool *exists, Error **errp)
 {
     bool result;
 
@@ -51,7 +51,16 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
         result = field->version_id <= version_id;
     }
 
-    return result;
+    *exists = result;
+
+    if (!result && field->flags & VMS_MUST_EXIST) {
+        error_setg(errp, "Expected field to exist, but it doesn't: "
+                   "%s/%s version_id: %d",
+                   vmsd->name, field->name, vmsd->version_id);
+        return false;
+    }
+
+    return true;
 }
 
 static int vmstate_n_elems(void *opaque, const VMStateField *field)
@@ -257,6 +266,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 {
     ERRP_GUARD();
     const VMStateField *field = vmsd->fields;
+    bool ok = true;
 
     trace_vmstate_load_state(vmsd->name, version_id);
 
@@ -281,7 +291,13 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     while (field->name) {
-        bool exists = vmstate_field_exists(vmsd, field, opaque, version_id);
+        bool exists;
+
+        ok = vmstate_field_exists(vmsd, field, opaque, version_id, &exists,
+                                  errp);
+        if (!ok) {
+            return false;
+        }
 
         trace_vmstate_load_state_field(vmsd->name, field->name, exists);
 
@@ -296,7 +312,6 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 /* If we will process the load of field? */
                 bool load_field = true;
-                bool ok = true;
                 void *curr_elem;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -326,10 +341,6 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                     return false;
                 }
             }
-        } else if (field->flags & VMS_MUST_EXIST) {
-            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
-                       vmsd->name, field->name, vmsd->version_id);
-            return false;
         }
         field++;
     }
@@ -635,7 +646,14 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     while (field->name) {
-        if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
+        bool exists;
+
+        ok = vmstate_field_exists(vmsd, field, opaque, version_id, &exists,
+                                  errp);
+        if (!ok) {
+            g_assert_not_reached();
+        }
+        if (exists) {
             void *head;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
@@ -725,12 +743,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                 use_vmdesc = false;
             }
-        } else {
-            if (field->flags & VMS_MUST_EXIST) {
-                error_report("Output state validation failed: %s/%s",
-                        vmsd->name, field->name);
-                assert(!(field->flags & VMS_MUST_EXIST));
-            }
         }
         field++;
     }
-- 
2.51.0


