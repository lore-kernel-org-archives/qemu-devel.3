Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F640FEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fj-0003IM-AS; Tue, 24 Mar 2026 15:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fd-0003G6-CP
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:09 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fb-0008EN-Nj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 867D15BD56;
 Tue, 24 Mar 2026 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqFU08QiemyHMKmACwXdYM3VqArmk1wjvFdrAmao4JI=;
 b=n031BixcOB1TXteDcoVZ0zbAOgEnVYA9yBNrBF9//Ev/k7dvhh11GAeHyZq2PX8Zrsl81Y
 pqPMlrZlYyQC0tN3jiXmf/ew84dYU1N37QzNUjxa5trVusqQyjxQz2RNEMYo/EPUeKzc9Q
 H/60EoGNytkvxwTGCYGIfqrdrursXHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqFU08QiemyHMKmACwXdYM3VqArmk1wjvFdrAmao4JI=;
 b=PEFEgJDwPPJ0lriYoNtNuwkSsyPzRUce5oP2DiM0gTJvRSIQwRGUw9YED0fgOFOTkUK8yu
 rjCHXmEVn9cPuDBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n031Bixc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PEFEgJDw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqFU08QiemyHMKmACwXdYM3VqArmk1wjvFdrAmao4JI=;
 b=n031BixcOB1TXteDcoVZ0zbAOgEnVYA9yBNrBF9//Ev/k7dvhh11GAeHyZq2PX8Zrsl81Y
 pqPMlrZlYyQC0tN3jiXmf/ew84dYU1N37QzNUjxa5trVusqQyjxQz2RNEMYo/EPUeKzc9Q
 H/60EoGNytkvxwTGCYGIfqrdrursXHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqFU08QiemyHMKmACwXdYM3VqArmk1wjvFdrAmao4JI=;
 b=PEFEgJDwPPJ0lriYoNtNuwkSsyPzRUce5oP2DiM0gTJvRSIQwRGUw9YED0fgOFOTkUK8yu
 rjCHXmEVn9cPuDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F42B43FE4;
 Tue, 24 Mar 2026 19:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kJjuC2/pwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 05/17] vmstate: Remove vmdesc_loop
Date: Tue, 24 Mar 2026 16:43:20 -0300
Message-ID: <20260324194333.30004-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 867D15BD56
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

The vmdesc_loop variable is being used as a hacky way of writing the
JSON description only for the first element of a compressed
array. There are also a few implicit uses, such as writing the JSON
for the first non-compressed element after a compressed portion.

Future work will have trouble with this. Use a simple boolean to be
explicit now.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index dec9cf920b..7a12245d36 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -622,8 +622,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
-            JSONWriter *vmdesc_loop = vmdesc;
             bool is_null_prev = false;
+            bool use_vmdesc = true;
+
             /*
              * When this is enabled, it means we will always push a ptr
              * marker first for each element saying if it's populated.
@@ -673,7 +674,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     is_null != is_null_prev) {
 
                     is_null_prev = is_null;
-                    vmdesc_loop = vmdesc;
+                    use_vmdesc = true;
 
                     for (int j = i + 1; j < n_elems; j++) {
                         void *elem = *(void **)(first_elem + size * j);
@@ -686,8 +687,13 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     }
                 }
 
+                if (use_dynamic_array) {
+                    use_vmdesc = true;
+                }
+
                 ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
-                                                    inner_field, vmdesc_loop,
+                                                    inner_field,
+                                                    use_vmdesc ? vmdesc : NULL,
                                                     i, max_elems, errp);
 
                 /* If we used a fake temp field.. free it now */
@@ -708,19 +714,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                      * NOTE: do not use vmstate_size() here because we want
                      * to dump the real VMSD object now.
                      */
-                    ok = vmstate_save_field_with_vmdesc(f, curr_elem,
-                                                        field->size, vmsd,
-                                                        field, vmdesc_loop,
-                                                        i, max_elems, errp);
+                    ok = vmstate_save_field_with_vmdesc(
+                        f, curr_elem, field->size, vmsd, field,
+                        use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
+
                     if (!ok) {
                         goto out;
                     }
                 }
 
-                /* Compressed arrays only care about the first element */
-                if (vmdesc_loop && vmsd_can_compress(field)) {
-                    vmdesc_loop = NULL;
-                }
+                use_vmdesc = false;
             }
         } else {
             if (field->flags & VMS_MUST_EXIST) {
-- 
2.51.0


