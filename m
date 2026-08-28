Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA8DC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyze-0001fQ-JC; Fri, 28 Aug 2026 11:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzc-0001eU-8i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzQ-00006l-7a
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 186411FE00;
 Fri, 28 Aug 2026 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8dF9OUUnpcySr+t0ld6YPJiSh8RGUF8V5AdKubVuxg=;
 b=M2PvzOpXs6aBwsRDGJ/0XJRLiQwFHoGg7eVUPTLi0Iex5rJ7H3aZyUEhrhjc8hfVzm7dyQ
 /R+3y75bUV0eFip+rNyCxnr3WqFXAYhr+OAMM59VL3V15Hka3ml9m/YsBtn9SsISbfPRiZ
 FXw4GY8LMieyA86qbeAucQEUDVm26R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8dF9OUUnpcySr+t0ld6YPJiSh8RGUF8V5AdKubVuxg=;
 b=4WR2X4RSKT6JVjVMynWGzXjgW/wquN2PZZxk+dEeR983LZ8LW8CucYh5UbM+TVcks2YA2s
 KtJJ86dIzfRgTWCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8dF9OUUnpcySr+t0ld6YPJiSh8RGUF8V5AdKubVuxg=;
 b=wUrD/z0EIL6mT1N695HgPmR8ucMYlbzDpFBgTG7jn2y7pV1bM0B3qWPw/0zXky19YrswgI
 OpwYqL6shRggUmSWSSQCmx3q8XKZmRbfpnFLkIsKoRcFCdXG0pDNJFs7+FhuXC91E9OlOg
 9X1jeLiXLskw7Cr8MaPsm5Yxu4mZlPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8dF9OUUnpcySr+t0ld6YPJiSh8RGUF8V5AdKubVuxg=;
 b=ZoaKgWgi/IdHuJTDtnTmsJZyHRM8yostB8ALi/9Pb4ow3dk8y5XAJBMsCce9fxtojxh/hO
 jQ7ouZSoMY2JH4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B9251368F;
 Fri, 28 Aug 2026 15:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EEOQA12wkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL v2 28/30] migration: Harden vmstate_handle_alloc
Date: Fri, 28 Aug 2026 12:58:43 -0300
Message-ID: <20260828155845.2874508-29-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Harden the vmstate_handle_alloc function against overflow of the 64bit
integers it consumes and failure to allocate due to an exceedingly
large request.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 1f9cb45923f..cbcd86e5b60 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -148,16 +148,28 @@ static uint64_t vmstate_size(void *opaque, const VMStateField *field)
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
@@ -367,7 +379,9 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
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


