Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F45FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcg-0004Uz-2H; Thu, 23 Apr 2026 15:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcT-0003pW-OE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:51 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcR-00029P-OT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9727A6A891;
 Thu, 23 Apr 2026 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cps/+TDf6sawK3UL3T3/BEb1DwFfw9hUVfjlHW+dVCE=;
 b=d0ewgjhfU8Ehs3zaqPzUkOn/yphPywdhWVZi/HhaSmXzYkD5Xm53Qp++Crs8lTG9c9/OE0
 aX2lzN1V/4ljESipXaKAIPuxjlyU4yiHGgvGMiy6eEKib+ghoSziO3kJ4BqA4YtXmLMiO4
 NMdOIyS1it0TNNHFI0xluOKhs5Cc+2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cps/+TDf6sawK3UL3T3/BEb1DwFfw9hUVfjlHW+dVCE=;
 b=x3pVkF6eogbORMINI5+BE6oYdrUjEzF6z+xfEUuusuednmMnCFjcskF1FjNq5pfs+d1kwj
 sUNbRJJ0np4GGgDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d0ewgjhf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x3pVkF6e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cps/+TDf6sawK3UL3T3/BEb1DwFfw9hUVfjlHW+dVCE=;
 b=d0ewgjhfU8Ehs3zaqPzUkOn/yphPywdhWVZi/HhaSmXzYkD5Xm53Qp++Crs8lTG9c9/OE0
 aX2lzN1V/4ljESipXaKAIPuxjlyU4yiHGgvGMiy6eEKib+ghoSziO3kJ4BqA4YtXmLMiO4
 NMdOIyS1it0TNNHFI0xluOKhs5Cc+2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cps/+TDf6sawK3UL3T3/BEb1DwFfw9hUVfjlHW+dVCE=;
 b=x3pVkF6eogbORMINI5+BE6oYdrUjEzF6z+xfEUuusuednmMnCFjcskF1FjNq5pfs+d1kwj
 sUNbRJJ0np4GGgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E7FD593A3;
 Thu, 23 Apr 2026 19:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIcDOwZx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 26/43] vmstate: Do not set size for VMS_ARRAY_OF_POINTER
Date: Thu, 23 Apr 2026 16:19:40 -0300
Message-ID: <20260423191958.1440-27-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9727A6A891
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

From: Peter Xu <peterx@redhat.com>

When VMS_ARRAY_OF_POINTER is specified, it means the vmstate field is an
array of pointers.

The size of the element is not relevant to whatever it is stored inside: it
is always the host pointer size.

Let's reserve the "size" field in this case for future use, update
vmstate_size() so as to make it still work for array of pointers properly.

When at this, provide rich documentation on how size / size_offset works in
vmstate.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-4-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 20 ++++++++++++++++----
 migration/savevm.c          |  3 +++
 migration/vmstate.c         | 10 +++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 32bb8e8ebc..350e62a55a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -183,11 +183,26 @@ typedef enum {
 struct VMStateField {
     const char *name;
     size_t offset;
+
+    /*
+     * @size or @size_offset specifies the size of the element embeded in
+     * the field.  Only one of them should be present never both.  When
+     * @size_offset is used together with VMS_VBUFFER, it means the size is
+     * dynamic calculated instead of a constant.
+     *
+     * When the field is an array of any type, this stores the size of one
+     * element of the array.
+     *
+     * NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be specified,
+     * this parameter always reflects the real size of the objects that a
+     * pointer point to.
+     */
     size_t size;
+    size_t size_offset;
+
     size_t start;
     int num;
     size_t num_offset;
-    size_t size_offset;
     const VMStateInfo *info;
     enum VMStateFlags flags;
     const VMStateDescription *vmsd;
@@ -547,7 +562,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                        \
     .num        = (_num),                                            \
     .info       = &(_info),                                          \
-    .size       = sizeof(_type *),                                   \
     .flags      = VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
     .offset     = vmstate_offset_array(_state, _field, _type *, _num), \
 }
@@ -557,7 +571,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_v),                                              \
     .num        = (_n),                                              \
     .vmsd       = &(_vmsd),                                          \
-    .size       = sizeof(_type *),                                    \
     .flags      = VMS_ARRAY|VMS_STRUCT|VMS_ARRAY_OF_POINTER,         \
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
@@ -567,7 +580,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                             \
     .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
     .info       = &(_info),                                               \
-    .size       = sizeof(_type *),                                          \
     .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 8115203b51..f5a6fd0c66 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -868,6 +868,9 @@ static void vmstate_check(const VMStateDescription *vmsd)
 
     if (field) {
         while (field->name) {
+            if (field->flags & VMS_ARRAY_OF_POINTER) {
+                assert(field->size == 0);
+            }
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
                 /* Recurse to sub structures */
                 vmstate_check(field->vmsd);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index e98b5f5346..e29a8c3f49 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -110,13 +110,21 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
 
 static int vmstate_size(void *opaque, const VMStateField *field)
 {
-    int size = field->size;
+    int size;
 
     if (field->flags & VMS_VBUFFER) {
         size = *(int32_t *)(opaque + field->size_offset);
         if (field->flags & VMS_MULTIPLY) {
             size *= field->size;
         }
+    } else if (field->flags & VMS_ARRAY_OF_POINTER) {
+        /*
+         * For an array of pointer, the each element is always size of a
+         * host pointer.
+         */
+        size = sizeof(void *);
+    } else {
+        size = field->size;
     }
 
     return size;
-- 
2.51.0


