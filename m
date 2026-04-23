Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DC8FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzb8-0001q5-Mi; Thu, 23 Apr 2026 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzb6-0001pp-UG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzb5-0001mI-3v
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AB1D6A894;
 Thu, 23 Apr 2026 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNu+6SUCFbQGXOQhLmMux0cecIlR+BfYVaYKEuipyCA=;
 b=H7RPSn4fRav4CznEyxhAXNcVZdfxIaxQQ2i2VJiB/WW0r8Rio8eWSvgNPMe/L7Sg2d5BI3
 zmN5zruBui79nMP+sRZl5FyJulYcrKGHO5f5UHtKkRtypKIfIizUduOdgnSg6dTWX6tZep
 TLKGzCO3ZrWvIQmNFNUQd+rWhMKn0oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNu+6SUCFbQGXOQhLmMux0cecIlR+BfYVaYKEuipyCA=;
 b=YILaJC44/jH0bti1B3RAPgL4h1+22OtfcAszH/W3adaJbaVbhFpMYvlgoFSuIabrELioeK
 N6UK7+le58OAI7CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H7RPSn4f;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YILaJC44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNu+6SUCFbQGXOQhLmMux0cecIlR+BfYVaYKEuipyCA=;
 b=H7RPSn4fRav4CznEyxhAXNcVZdfxIaxQQ2i2VJiB/WW0r8Rio8eWSvgNPMe/L7Sg2d5BI3
 zmN5zruBui79nMP+sRZl5FyJulYcrKGHO5f5UHtKkRtypKIfIizUduOdgnSg6dTWX6tZep
 TLKGzCO3ZrWvIQmNFNUQd+rWhMKn0oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNu+6SUCFbQGXOQhLmMux0cecIlR+BfYVaYKEuipyCA=;
 b=YILaJC44/jH0bti1B3RAPgL4h1+22OtfcAszH/W3adaJbaVbhFpMYvlgoFSuIabrELioeK
 N6UK7+le58OAI7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B2C593B0;
 Thu, 23 Apr 2026 19:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eCjACOlw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 06/43] migration: vmstate_load_state(): add some newlines
Date: Thu, 23 Apr 2026 16:19:20 -0300
Message-ID: <20260423191958.1440-7-farosas@suse.de>
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
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5AB1D6A894
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

Split logical blocks by newlines, that simplify reading the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-5-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5111e7a141..dd7cd27993 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -139,6 +139,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
     int ret = 0;
 
     trace_vmstate_load_state(vmsd->name, version_id);
+
     if (version_id > vmsd->version_id) {
         error_setg(errp, "%s: incoming version_id %d is too new "
                    "for local version_id %d",
@@ -146,6 +147,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
+
     if  (version_id < vmsd->minimum_version_id) {
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
@@ -153,6 +155,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
+
     if (vmsd->pre_load_errp) {
         if (!vmsd->pre_load_errp(opaque, errp)) {
             error_prepend(errp, "pre load hook failed for: '%s', "
@@ -171,9 +174,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             return ret;
         }
     }
+
     while (field->name) {
         bool exists = vmstate_field_exists(vmsd, field, opaque, version_id);
+
         trace_vmstate_load_state_field(vmsd->name, field->name, exists);
+
         if (exists) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
@@ -184,6 +190,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
             }
+
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
@@ -235,6 +242,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                                    vmsd->name, ret);
                     }
                 }
+
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
                     trace_vmstate_load_field_error(field->name, ret);
@@ -249,11 +257,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
+
     ret = vmstate_subsection_load(f, vmsd, opaque, errp);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
         return ret;
     }
+
     if (vmsd->post_load_errp) {
         if (!vmsd->post_load_errp(opaque, version_id, errp)) {
             error_prepend(errp, "post load hook failed for: %s, version_id: "
@@ -271,7 +281,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        ret);
         }
     }
+
     trace_vmstate_load_state_end(vmsd->name, "end", ret);
+
     return ret;
 }
 
-- 
2.51.0


