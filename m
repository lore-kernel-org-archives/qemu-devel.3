Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFFBC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUt-000887-Us; Tue, 18 Aug 2026 14:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUr-00086e-W7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUq-0003Ca-EH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C8E8A846C2;
 Tue, 18 Aug 2026 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wD3CVIRX8903SHtXpBw3TNTneDODNtlzxFonZCIu80=;
 b=FXx800ruGgZu/cFcZOOhLU0eMXcZfzsyP5JuRUkOrMPkw0yIEIFpS6N64zHn+3vWWd9v8P
 2dMMGHhdE3LSwzvRKO/rhHSddFmlgqMU9we+QwWGTZAl5GV3rk8vwedvTNAfDH5++2QzpI
 d6oCt2K3Csa+5zrr2QQJcX2YIn2lEZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wD3CVIRX8903SHtXpBw3TNTneDODNtlzxFonZCIu80=;
 b=d1v0CeEP+G1bYJa8PtTMN5+F2Tormggsiy/sZvJ/taiWLT1iSPjFqHXamSguVgb4CDGgcS
 wPZK6AA3sHjvgrBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sCInR/s8";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9T+rCui6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wD3CVIRX8903SHtXpBw3TNTneDODNtlzxFonZCIu80=;
 b=sCInR/s8AN9mPEcLeV9fAcDAT7G35X3YzzhG9UQjcEcuAbUhvpWK3NXozamOnsEdkuWl7c
 t5tjvOdQFDlXgIYNXXUI7ihsYA5M/ljAilWLeWXXEiDo8Ck0nguMhcnYT6KAkcZBBOejTv
 C5D7AdznweDaYRvkwC7aydABUjx5bRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wD3CVIRX8903SHtXpBw3TNTneDODNtlzxFonZCIu80=;
 b=9T+rCui6/5SPhehcSLJ4CrQcU/VTmL+z4KLLf59The6huuWUP2q3zYygDNqO+VOus2zoaZ
 S6PgEmcWiESeKDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DBC7362E;
 Tue, 18 Aug 2026 18:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CC0E32jhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:25:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 7/8] migration: Harden vmstate_handle_alloc
Date: Tue, 18 Aug 2026 15:24:40 -0300
Message-ID: <20260818182441.404790-8-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C8E8A846C2
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Harden the vmstate_handle_alloc function against overflow of the 64bit
integers it consumes and failure to allocate due to an exceedingly
large request.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 51d02b87e7e..1d028bfe009 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -135,16 +135,28 @@ static uint64_t vmstate_size(void *opaque, const VMStateField *field)
     return size;
 }
 
-static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
-                                 void *opaque)
+static bool vmstate_handle_alloc(void *ptr, const VMStateField *field,
+                                 uint64_t n, uint64_t size, Error **errp)
 {
+    void *p;
+
     if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
-        uint64_t size = vmstate_size(opaque, field);
-        size *= vmstate_n_elems(opaque, field);
-        if (size) {
-            *(void **)ptr = g_malloc(size);
-        }
+        if (size && n) {
+            if (umul64_overflow(size, n, &size)) {
+                error_setg(errp, "%s: field '%s' multiply overflow",
+                           __func__, field->name);
+                return false;
+            }
+            p = g_try_malloc(size);
+            if (!p) {
+                error_setg(errp, "%s: Could not allocate memory for field '%s'",
+                           __func__, field->name);
+                return false;
+            }
+            *(void **)ptr = p;
+         }
     }
+    return true;
 }
 
 static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
@@ -354,7 +366,9 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             uint64_t n_elems = vmstate_n_elems(opaque, field);
             uint64_t size = vmstate_size(opaque, field);
 
-            vmstate_handle_alloc(first_elem, field, opaque);
+            if (!vmstate_handle_alloc(first_elem, field, n_elems, size, errp)) {
+                return false;
+            }
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
-- 
2.53.0


