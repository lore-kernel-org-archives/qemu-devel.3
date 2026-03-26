Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E643410AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtt-0004Ad-09; Thu, 26 Mar 2026 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtp-00049h-2J
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtm-00038F-QQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9bH3nFltdiRFFH0om8Ts5SFlEEyrXqfBGminAjx0uw=;
 b=jMlGAQqrlGmDVmw5LOxRGl7aFgIjT8zqwoOkBhZN5WyD1w5gS/JW0V2a2qdcImqoJ32GBe
 9gRM1BQI+vo380FglAtU4glqI8UtX0hkSEdr0p1IAwH6h5Zo4faAEylDN6WlE/MCor/AWx
 vKHL+HxFxzLJIu94zfO/Ljd42LmHQ6E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-_u04Y0w7ObS0pQFhMdkYbw-1; Thu, 26 Mar 2026 17:05:48 -0400
X-MC-Unique: _u04Y0w7ObS0pQFhMdkYbw-1
X-Mimecast-MFC-AGG-ID: _u04Y0w7ObS0pQFhMdkYbw_1774559148
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7fc27cf7so412667985a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559148; x=1775163948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9bH3nFltdiRFFH0om8Ts5SFlEEyrXqfBGminAjx0uw=;
 b=BN0zb81DIElbCFFCX+91I1ARkwJEl0p/JUkM7zulPqrwNopS/IJj/DFOK4ilUDDSD5
 Brg8gyhx4gJKHiISkLQKovokseJCU8/305DsFkZLxidxDlbyMD4sUfemefBqB/sTKr13
 cR6T2bVOr8j2Iso/KNiNRpcRrKYfvvvbUYHzySShloB0+sN00eWnw2SQMmsEG/4zoPnb
 8BjYOunQCM3EL4MfkOoxw5M4Ed0EX2+y/ABCqu9Rk9WfE8cIbJqmkYaov62A93Np0YBa
 Qg1CJ6tjvJ9mgOIFnUwTmx3hEXxuIcyhkWVwXSk/3Se03jvrPoPvMuLKV4dgr+excFL/
 qHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559148; x=1775163948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9bH3nFltdiRFFH0om8Ts5SFlEEyrXqfBGminAjx0uw=;
 b=shvtI0hte9elT9jGrQNkp83T5waXPAdV0zS0JL/hGXpSq7IEXSHU7XJ6PjTv9B4Um4
 IG7aC0lKoLagSyE3WTLJunGJaIdFMD1waA6AX57wApwrsxAkjtJCPZCc5hXKDIEWjDT8
 p7JrdzMxxFbFscskiNFeyI2mAIdk312eEvlGJnkHGzs+HL10RuDx3b0ScIt+MY/nml8F
 p/bdoFqc+N/o+pYzoZXxtVcbXBL1vHhjAMCCmrgc99RX51QbZd8u7nKwAMCJWzx1ZOFy
 lpuwz+1T9L6L8bPrGOJ8Cw+rGVj+4jnObhIOa2XhbMWLXZiez2uqsr29yc1g1To+5+Ag
 OqeQ==
X-Gm-Message-State: AOJu0YxTaTAfHXy5jnzBgKyhzwOTDkvFqliKipKqXngM2pIMV6Tibjd+
 tIsR+cKiOFvu9pJ8oUD8fz2fZc2VZc9Vw+7nWoCZCiug4UNt8e5ER+MipzsIToYL4YlfC/QcpGu
 bkz2U4YTHfGt70KeKiQYQiKxB96UD3r66kfRW9vTv7Ih/7gZ3PiYgoVB8dinAsxpDBW7uzacoUt
 WRS3U7vBEE4LA6fmNawwgpmo/4Wyd3MUWwN1vjKQ==
X-Gm-Gg: ATEYQzyhSl9TyuMCJqPlqRqT4pwk7vUV6bnlZ7aHHrz9uLGxhpIuKEFOpOT0MMe9oXL
 GDJFFzahzVcrN91rOLBfLcWVrH894swk47nizBPEsop8ywgfyc5jj28bW+Rb9as0zzW0bccrdPa
 1qdH3zVxhJWzVOI7p55CNOwTOo1tb1qmDxhFFxG7MkRel3MMrdTU+Qvme3cRcrMB/8QtxBy6XvX
 pUn5RTiy42+x6DDeXie0Gkrtp209xEfiYNZxCTvNVnVmnjxjZmBiZNEChV7XbiyidEvfyfoziXQ
 MYbwQqawDb2rMpFSHkmgMG/13a1ret1Cki3exnDly1J97RwgQpkoflNwLr+xGN1YMC+VmaN2SIB
 3RXh/Wh4lS/o=
X-Received: by 2002:a05:620a:3947:b0:8cf:db04:8a31 with SMTP id
 af79cd13be357-8d00100ea0fmr1306692185a.55.1774559147418; 
 Thu, 26 Mar 2026 14:05:47 -0700 (PDT)
X-Received: by 2002:a05:620a:3947:b0:8cf:db04:8a31 with SMTP id
 af79cd13be357-8d00100ea0fmr1306685385a.55.1774559146751; 
 Thu, 26 Mar 2026 14:05:46 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 09/11] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Thu, 26 Mar 2026 17:05:30 -0400
Message-ID: <20260326210532.379027-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  51 +++++++++++++-
 migration/savevm.c          |  27 ++++++-
 migration/vmstate.c         | 136 ++++++++++++++++++++++++++++++------
 3 files changed, 190 insertions(+), 24 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2e51b5ea04..d844b46e63 100644
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
index 47812eb882..9cd0a88ce9 100644
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
@@ -234,6 +240,67 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
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
+     * Some special cases use pointer markers: (1) _AUTO_ALLOC implies a
+     * ptr marker will always exist, or (2) the element on destination is
+     * NULL, which expects the src to send a NULL-only marker.
+     */
+    if (auto_alloc || !*pptr) {
+        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
+            trace_vmstate_load_field_error(field->name, -EINVAL);
+            return false;
+        }
+
+        if (load_field) {
+            /*
+             * When reaching here, it means we received a non-NULL ptr
+             * marker, so we need to populate the field before loading it.
+             *
+             * NOTE: do not use vmstate_size() here, because we need the
+             * object size, not entry size of the array.
+             */
+            assert(auto_alloc);
+            *pptr = g_malloc0(field->size);
+        } else {
+            /* Clear the pointer to imply a skip */
+            *next_elem = NULL;
+            return true;
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
@@ -279,27 +346,22 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -397,6 +459,16 @@ static bool vmsd_can_compress(const VMStateField *field)
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
@@ -583,6 +655,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -603,14 +681,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -657,6 +730,25 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
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
2.50.1


