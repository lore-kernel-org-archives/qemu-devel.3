Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E517FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdL-0006RU-0c; Thu, 23 Apr 2026 15:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzct-00050P-Bj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:16 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcp-0002PF-WC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 905376A8E3;
 Thu, 23 Apr 2026 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPuRrUsaEYWsuQOW5Bg2WU0kkK7920z9rqtJrvE9AB8=;
 b=gGzSVAFhRR5ZQSTYuNgsVFvd709hVdKH2dtEGhtGFwQS4V3Ze7Vgq9Yfx9icaOdesoRi4D
 WIjeDwO1OYBUlp9F3GM917NLT7b0xjygT99svQCHYB9ioO21MMfcxyq6GLHhAyhf/I8Ljq
 SS9pQUFSpHnpXdUnmHN00/5vQHpSS8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPuRrUsaEYWsuQOW5Bg2WU0kkK7920z9rqtJrvE9AB8=;
 b=HwQjmtMPEhCf4PPx44uQpS4hu/6KnBNPZuEB+hzAlCs9JwlQQvc15smDJJJF/F2HoYAYWc
 9DdBHeU2+IUPzHAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gGzSVAFh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HwQjmtMP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPuRrUsaEYWsuQOW5Bg2WU0kkK7920z9rqtJrvE9AB8=;
 b=gGzSVAFhRR5ZQSTYuNgsVFvd709hVdKH2dtEGhtGFwQS4V3Ze7Vgq9Yfx9icaOdesoRi4D
 WIjeDwO1OYBUlp9F3GM917NLT7b0xjygT99svQCHYB9ioO21MMfcxyq6GLHhAyhf/I8Ljq
 SS9pQUFSpHnpXdUnmHN00/5vQHpSS8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPuRrUsaEYWsuQOW5Bg2WU0kkK7920z9rqtJrvE9AB8=;
 b=HwQjmtMPEhCf4PPx44uQpS4hu/6KnBNPZuEB+hzAlCs9JwlQQvc15smDJJJF/F2HoYAYWc
 9DdBHeU2+IUPzHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52646593A3;
 Thu, 23 Apr 2026 19:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sHfaBxFx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 32/43] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Thu, 23 Apr 2026 16:19:46 -0300
Message-ID: <20260423191958.1440-33-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLjefarcnsteocuw7wptuakujg)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 905376A8E3
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

From: Peter Xu <peterx@redhat.com>

Introduce a new flag, VMS_ARRAY_OF_POINTER_AUTO_ALLOC, for VMSD field.  It
must be used together with VMS_ARRAY_OF_POINTER.

It can be used to allow migration of an array of pointers where the
pointers may point to NULLs.

Note that we used to allow migration of a NULL pointer within an array that
is being migrated. That corresponds to the code around vmstate_info_nullptr
where we may get/put one byte showing that the element of an array is NULL.

That usage is fine but very limited, it's because even if it will migrate a
NULL pointer with a marker, it still works in a way that both src and dest
QEMUs must know exactly which elements of the array are non-NULL, so
instead of dynamically loading an array (which can have NULL pointers), it
actually only verifies the known NULL pointers are still NULL pointers
after migration.

Also, in that case since dest QEMU knows exactly which element is NULL,
which is not NULL, dest QEMU's device code will manage all allocations for
the elements before invoking vmstate_load_vmsd().

That's not enough per evolving needs of new device states that may want to
provide real dynamic array of pointers, like what Alexander proposed here
with the NVMe device migration:

https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com

This patch is an alternative approach to address the problem.

Along with the flag, introduce two new macros:

  VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8|32}_ALLOC()

Which will be used very soon in the NVMe series.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-10-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h |  51 ++++++++++++-
 migration/savevm.c          |  27 ++++++-
 migration/vmstate.c         | 145 ++++++++++++++++++++++++++++++------
 3 files changed, 199 insertions(+), 24 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 492069b8d2..28e3640e60 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -161,8 +161,21 @@ enum VMStateFlags {
      * structure we are referencing to use. */
     VMS_VSTRUCT           = 0x8000,
 
+    /*
+     * This is a sub-flag for VMS_ARRAY_OF_POINTER.  When this flag is set,
+     * VMS_ARRAY_OF_POINTER must also be set.  When set, it means array
+     * elements can contain either valid or NULL pointers, vmstate core
+     * will be responsible for synchronizing the pointer status, providing
+     * proper memory allocations on the pointer when it is populated on the
+     * source QEMU.  It also means the user of the field must make sure all
+     * the elements in the array are NULL pointers before loading.  This
+     * should also work with VMS_ALLOC when the array itself also needs to
+     * be allocated.
+     */
+    VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
+
     /* Marker for end of list */
-    VMS_END = 0x10000
+    VMS_END                         = 0x20000,
 };
 
 typedef enum {
@@ -580,6 +593,42 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+/*
+ * For migrating a dynamically allocated uint{8,32}-indexed array of
+ * pointers to structures (with NULL entries and with auto memory
+ * allocation).
+ *
+ * _type: type of structure pointed to
+ * _vmsd: VMSD for structure _type (when VMS_STRUCT is set)
+ * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
+ * start: size of (_type) pointed to (for auto memory allocation)
+ */
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(\
+    _field, _state, _field_num, _version, _vmsd, _type) {            \
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .vmsd       = &(_vmsd),                                          \
+    .size       = sizeof(_type),                                     \
+    .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
+                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
+                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(\
+    _field, _state, _field_num, _version, _vmsd, _type) {             \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .vmsd       = &(_vmsd),                                           \
+    .size       = sizeof(_type),                                      \
+    .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
+                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
+                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
 #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
diff --git a/migration/savevm.c b/migration/savevm.c
index f5a6fd0c66..765df8ce2d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -869,8 +869,33 @@ static void vmstate_check(const VMStateDescription *vmsd)
     if (field) {
         while (field->name) {
             if (field->flags & VMS_ARRAY_OF_POINTER) {
-                assert(field->size == 0);
+                if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+                    /*
+                     * Size must be provided because dest QEMU needs that
+                     * info to know what to allocate
+                     */
+                    assert(field->size || field->size_offset);
+                } else {
+                    /*
+                     * Otherwise size info isn't useful (because it's
+                     * always the size of host pointer), detect accidental
+                     * setup of sizes in this case.
+                     */
+                    assert(field->size == 0 && field->size_offset == 0);
+                }
+                /*
+                 * VMS_ARRAY_OF_POINTER must be used only together with one
+                 * of VMS_(V)ARRAY* flags.
+                 */
+                assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
+                                       VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8 |
+                                       VMS_VARRAY_UINT32));
             }
+
+            if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+                assert(field->flags & VMS_ARRAY_OF_POINTER);
+            }
+
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
                 /* Recurse to sub structures */
                 vmstate_check(field->vmsd);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 47812eb882..de2ad822e8 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -153,6 +153,12 @@ static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
         return true;
     }
 
+    if (byte == VMS_MARKER_PTR_VALID) {
+        /* We need to load the field right after the marker */
+        *load_field = true;
+        return true;
+    }
+
     error_setg(errp, "Unexpected ptr marker: %d", byte);
     return false;
 }
@@ -234,6 +240,76 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
     return true;
 }
 
+/*
+ * Try to prepare loading the next element, the object pointer to be put
+ * into @next_elem.  When @next_elem is NULL, it means we should skip
+ * loading this element.
+ *
+ * Returns false for errors, in which case *errp will be set, migration
+ * must be aborted.
+ */
+static bool vmstate_load_next(QEMUFile *f, const VMStateField *field,
+                              void *first_elem, void **next_elem,
+                              int size, int i, Error **errp)
+{
+    bool auto_alloc = field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
+    void *ptr = first_elem + size * i, **pptr;
+    bool load_field;
+
+    if (!(field->flags & VMS_ARRAY_OF_POINTER)) {
+        /* Simplest case, no pointer involved */
+        *next_elem = ptr;
+        return true;
+    }
+
+    /*
+     * We're loading an array of pointers, switch to use pptr to make it
+     * easier to read later
+     */
+    pptr = (void **)ptr;
+
+    /*
+     * If auto_alloc is on, making sure the user provided an array of NULL
+     * pointers to start with
+     */
+    assert(!auto_alloc || *pptr == NULL);
+
+    /*
+     * When pointer is null, we must expect a ptr marker first.  Use cases:
+     *
+     * (1) _AUTO_ALLOC implies a ptr marker will always exist, or,
+     *
+     * (2) the element on destination is NULL, which expects the src to send a
+     *     NULL-only marker.
+     *
+     * Here, checking against a NULL pointer will work for both.
+     */
+    if (!*pptr) {
+        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
+            trace_vmstate_load_field_error(field->name, -EINVAL);
+            return false;
+        }
+
+        /*
+         * If loading is needed, do pre-allocation first (otherwise keeping
+         * *pptr==NULL to imply a skip below)
+         */
+        if (load_field) {
+            /* Only applies when auto_alloc=on on the field */
+            assert(auto_alloc);
+            /*
+             * NOTE: do not use vmstate_size() here, because we need the
+             * object size, not entry size of the array.
+             */
+            *pptr = g_malloc0(field->size);
+        }
+    }
+
+    /* Move the cursor to the next element for loading */
+    *next_elem = *pptr;
+    return true;
+}
+
 bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
@@ -279,27 +355,22 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
-                /* If we will process the load of field? */
-                bool load_field = true;
-                bool ok = true;
-                void *curr_elem = first_elem + size * i;
+                void *curr_elem;
+                bool ok;
 
-                if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    curr_elem = *(void **)curr_elem;
-                    if (!curr_elem) {
-                        /* Read the marker instead of VMSD itself */
-                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
-                            trace_vmstate_load_field_error(field->name,
-                                                           -EINVAL);
-                            return false;
-                        }
-                    }
+                ok = vmstate_load_next(f, field, first_elem, &curr_elem,
+                                       size, i, errp);
+                if (!ok) {
+                    return false;
                 }
 
-                if (load_field) {
-                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
+                if (!curr_elem) {
+                    /* Implies a skip */
+                    continue;
                 }
 
+                ok = vmstate_load_field(f, curr_elem, size, field, errp);
+
                 if (ok) {
                     int ret = qemu_file_get_error(f);
                     if (ret < 0) {
@@ -397,6 +468,16 @@ static bool vmsd_can_compress(const VMStateField *field)
         return false;
     }
 
+    if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+        /*
+         * This may involve two VMSD fields to be saved, one for the
+         * marker to show if the pointer is NULL, followed by the real
+         * vmstate object.  To make it simple at least for now, skip
+         * compression for this one.
+         */
+        return false;
+    }
+
     if (field->flags & VMS_STRUCT) {
         const VMStateField *sfield = field->vmsd->fields;
         while (sfield->name) {
@@ -583,6 +664,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             int size = vmstate_size(opaque, field);
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
+            /*
+             * When this is enabled, it means we will always push a ptr
+             * marker first for each element saying if it's populated.
+             */
+            bool use_dynamic_array =
+                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
@@ -603,14 +690,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 is_null = !curr_elem && size;
-                use_marker_field = is_null;
+                use_marker_field = use_dynamic_array || is_null;
 
                 if (use_marker_field) {
-                    /*
-                     * If null pointer found (which should only happen in
-                     * an array of pointers), use null placeholder and do
-                     * not follow.
-                     */
                     inner_field = vmsd_create_ptr_marker_field(field);
                 } else {
                     inner_field = field;
@@ -657,6 +739,25 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     goto out;
                 }
 
+                /*
+                 * If we're using dynamic array and the element is
+                 * populated, save the real object right after the marker.
+                 */
+                if (use_dynamic_array && curr_elem) {
+                    /*
+                     * NOTE: do not use vmstate_size() here because we want
+                     * to save the real VMSD object now.
+                     */
+                    ok = vmstate_save_field_with_vmdesc(f, curr_elem,
+                                                        field->size, vmsd,
+                                                        field, vmdesc_loop,
+                                                        i, max_elems, errp);
+
+                    if (!ok) {
+                        goto out;
+                    }
+                }
+
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && max_elems > 1) {
                     vmdesc_loop = NULL;
-- 
2.51.0


