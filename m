Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2868BC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKO-0005Xi-BC; Wed, 22 May 2024 18:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKK-0005VB-EG
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKF-0003kb-Td
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A43B61F8BA;
 Wed, 22 May 2024 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsUD1GeNmcZw5+Wpgn8pet7lnx8FfXKpKqeRHlDOv0w=;
 b=DKJPeUbDIuaXKhT2MbfBPXiCQLmJzE08JNAJgIDrxrIzzlNqpqjf1Sh9f1gzAjJS9RNhIp
 psevU1fy+Hq0YDvz02OyveyA5ci6rKzT97bMce7eS0OWuqr3nDLoDWT4E+dP9rOfobRi7t
 42xHDA0ooMXAoPM3wnCqP6m9cuZxUxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsUD1GeNmcZw5+Wpgn8pet7lnx8FfXKpKqeRHlDOv0w=;
 b=Sd+YCGWprsPMsXON64lekEbpvSYVV7HX1XWlNXtmtbtGctfm9Ta0IRY+F7zxdvvaozcOU3
 q6Wyh3pZDfR1U/Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DKJPeUbD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sd+YCGWp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsUD1GeNmcZw5+Wpgn8pet7lnx8FfXKpKqeRHlDOv0w=;
 b=DKJPeUbDIuaXKhT2MbfBPXiCQLmJzE08JNAJgIDrxrIzzlNqpqjf1Sh9f1gzAjJS9RNhIp
 psevU1fy+Hq0YDvz02OyveyA5ci6rKzT97bMce7eS0OWuqr3nDLoDWT4E+dP9rOfobRi7t
 42xHDA0ooMXAoPM3wnCqP6m9cuZxUxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsUD1GeNmcZw5+Wpgn8pet7lnx8FfXKpKqeRHlDOv0w=;
 b=Sd+YCGWprsPMsXON64lekEbpvSYVV7HX1XWlNXtmtbtGctfm9Ta0IRY+F7zxdvvaozcOU3
 q6Wyh3pZDfR1U/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0506613A6B;
 Wed, 22 May 2024 22:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oE98L7xvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 4/9] migration: add "exists" info to load-state-field trace
Date: Wed, 22 May 2024 19:20:29 -0300
Message-Id: <20240522222034.4001-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A43B61F8BA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/trace-events | 2 +-
 migration/vmstate.c    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index d0c44c3853..0b7c3324fb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -58,7 +58,7 @@ postcopy_page_req_sync(void *host_addr) "sync page req %p"
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
 vmstate_load_state(const char *name, int version_id) "%s v%d"
 vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
-vmstate_load_state_field(const char *name, const char *field) "%s:%s"
+vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
 vmstate_n_elems(const char *name, int n_elems) "%s: %d"
 vmstate_subsection_load(const char *parent) "%s"
 vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ef26f26ccd..b51212a75b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -128,8 +128,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         }
     }
     while (field->name) {
-        trace_vmstate_load_state_field(vmsd->name, field->name);
-        if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
+        bool exists = vmstate_field_exists(vmsd, field, opaque, version_id);
+        trace_vmstate_load_state_field(vmsd->name, field->name, exists);
+        if (exists) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
-- 
2.35.3


