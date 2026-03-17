Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7E5FD7074
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Re9-0001x7-Cn; Tue, 17 Mar 2026 06:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdu-0001vJ-Bp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdr-0006VZ-K0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so66479655e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773743232; x=1774348032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZugiD/Qj6JgHPutbm5MIWrUpWCKjPH2a1AseJPIji4=;
 b=W8/bp033B8Zu8FjZrfy31phkagPxwRZzt36MErwqwJe85031jJHexLnKxWwC3FZpjs
 TByr01E+QDQgW2DBiwsUrEWsXUTxUKKGeKJVbL74F45lTZkUBkp+iloU1GpTCXuoJoDP
 /RjzQaZkbAo7TjJ0/QQJwomc8/ZeOmph70G04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743232; x=1774348032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KZugiD/Qj6JgHPutbm5MIWrUpWCKjPH2a1AseJPIji4=;
 b=Z2A/SDN+za8DCeIUvEDD8KB2nAy4qYB5ByHfkns2KC3KzqjY3Y4ZpsDNkec5AzdyLN
 JB+FZyilNeQ/gX84czNe7OufAV77KlDFSJO2VucbYBK+t2bXZLVccGxgN/Bo/xGtzAi3
 fk/YDInjls+DwU8SfgA+vCMW58FsXn+nJIb8IctB++miGhwjYgLZEObsh1c63BhuNRHx
 F6wmdMPZ+LSPwrUOeV/wHiAAa9rxoXNBch75MZaQEQKWi92Lwv5ViVYtRK+UXH0zW2FO
 jJUfbykpD+0QcKl/uDQfUCGbiRgPf0k1UZl5C6lFStuluctF1mvDuH3jvP/OIuQu7jW2
 WjBw==
X-Gm-Message-State: AOJu0Ywf+3evSFWAD79zQ+m8OHR3yydx0zkYLVVJlVzoKDxYhwQs0Zx+
 /8ZRveaBlZiSXiYFViVP39CtDDkhuNrV/+oLhLSHK/jl9TobRQSF2UCDTa4d5UqjUjLFjfPzkZm
 nKEmQSqo=
X-Gm-Gg: ATEYQzyizf2RnfkcRGsGyNEqLnXa+2u41CHXR7bwgfaq1ng5GLVXNOyQaLbwg0l0SPK
 2jVPrIFKVV1+he0L0wwOn6Y5dV2/JbowSRJw3ypgg4AwFPY7V9lizOVnazXW5wVM4hGTiHGJO71
 pz9LJjzzlaHoNJIMgg2be4jE00k9BYDTXX+rz2AksSWBcifwQVXf11q7HLQUhnVG34YQknzqaOR
 r+veLFACBLgvVgO/9aAAzeCb0wntP6eCQECRXs5GpmafnqUkwqbljbts/Wi6vF25xXV1+fxwo8A
 44rRSB8tt8JGlMFhbTTmS2L64nbPKcJM/IoR5n7wusJ7m/AbCmMzOL9eJnsUwU0vbACvBOTyD8b
 gRMy+3J4wXgXg7JGxgpHjyaQnMJDlfedWRpRezSzm4i4smmdPxkTA66GF2qwIfZxBUBa6JoJjzk
 zj99K6e5pouexj17ZOa8yXJxx3G59X1c97TSoADsNaNuisSS7iHMdjxM3A8mIh2vMcLgAqkXKJ5
 qd7kF8vd0mmRtmtPD5ripQ=
X-Received: by 2002:a05:600c:45d5:b0:485:3ff1:d5c3 with SMTP id
 5b1f17b1804b1-485566cfa3cmr259038945e9.5.1773743231990; 
 Tue, 17 Mar 2026 03:27:11 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0051af80c54da1a9bc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:51af:80c5:4da1:a9bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c36bsm61977665e9.9.2026.03.17.03.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:11 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 2/8] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Date: Tue, 17 Mar 2026 11:27:02 +0100
Message-ID: <20260317102708.126725-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317102708.126725-1-alexander@mihalicyn.com>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC, which
helps to save/restore a dynamic array of pointers to
structures.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
v2:
- added VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC
v4:
- almost completely reworked, new flag VMS_ARRAY_OF_POINTER_ALLOW_NULL
  was introduced as suggested by Peter
v5:
- rebased on top of https://lore.kernel.org/all/20260304212303.667141-1-vsementsov@yandex-team.ru/
---
 include/migration/vmstate.h | 77 ++++++++++++++++++++++++++++++-
 migration/savevm.c          | 26 +++++++++++
 migration/vmstate-types.c   | 91 +++++++++++++++++++++++++++++++++++++
 migration/vmstate.c         | 54 ++++++++++++++++++----
 4 files changed, 236 insertions(+), 12 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 7ed4a0742b2..0a409700598 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -162,7 +162,19 @@ enum VMStateFlags {
     VMS_VSTRUCT           = 0x8000,
 
     /* Marker for end of list */
-    VMS_END = 0x10000
+    VMS_END                         = 0x10000,
+
+    /* The field is a (fixed-size or variable-size) array of pointers
+     * (e.g. struct a { uint8_t **b; }) that can contain NULL values.
+     * This instructs vmstate engine to:
+     * - Dereference each array entry before using it.
+     * - Assume that array is initialized with NULLs on load phase
+     * - Automatically allocate memory for array entries (with size
+     *   specified in (VMStateField).start) on load phase
+     * - Produce NULL/not-NULL markers in migration stream
+     *
+     * Note: Does not imply VMS_ARRAY_OF_POINTER; it needs to be set explicitly. */
+    VMS_ARRAY_OF_POINTER_ALLOW_NULL = 0x20000,
 };
 
 typedef enum {
@@ -194,6 +206,7 @@ struct VMStateField {
     int version_id;
     int struct_version_id;
     bool (*field_exists)(void *opaque, int version_id);
+    const struct VMStateField *real_field;
 };
 
 struct VMStateDescription {
@@ -268,8 +281,10 @@ extern const VMStateInfo vmstate_info_uint64;
 extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
-#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+#define VMS_NULLPTR_MARKER    (0x30U) /* '0' */
+#define VMS_NOTNULLPTR_MARKER (0x31U) /* '1' */
 extern const VMStateInfo vmstate_info_nullptr;
+extern const VMStateInfo vmstate_info_maybeptr;
 
 extern const VMStateInfo vmstate_info_cpudouble;
 
@@ -281,6 +296,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_ptrs_array_entry;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -562,6 +578,63 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+/*
+ * For migrating a dynamically allocated uint{8,32}-indexed array
+ * of pointers to structures (with NULL entries and with auto memory allocation).
+ *
+ * _type: type of structure pointed to
+ * _vmsd: VMSD for structure _type (when VMS_STRUCT is set)
+ * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
+ * start: size of (_type) pointed to (for auto memory allocation)
+ */
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .vmsd       = &(_vmsd),                                          \
+    .start      = sizeof(_type),                                     \
+    .size       = sizeof(_type *),                                   \
+    .flags      = VMS_POINTER|VMS_VARRAY_UINT8|VMS_ARRAY_OF_POINTER| \
+                  VMS_ARRAY_OF_POINTER_ALLOW_NULL|VMS_STRUCT,        \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_UINT8_ALLOC(_field, _state, _field_num, _version, _info, _type) { \
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .info       = &(_info),                                          \
+    .start      = sizeof(_type),                                     \
+    .size       = sizeof(_type *),                                   \
+    .flags      = VMS_POINTER|VMS_VARRAY_UINT8|VMS_ARRAY_OF_POINTER| \
+                  VMS_ARRAY_OF_POINTER_ALLOW_NULL,                   \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .vmsd       = &(_vmsd),                                           \
+    .start      = sizeof(_type),                                      \
+    .size       = sizeof(_type *),                                    \
+    .flags      = VMS_POINTER|VMS_VARRAY_UINT32|VMS_ARRAY_OF_POINTER| \
+                  VMS_ARRAY_OF_POINTER_ALLOW_NULL|VMS_STRUCT,         \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) { \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .info       = &(_info),                                           \
+    .start      = sizeof(_type),                                      \
+    .size       = sizeof(_type *),                                    \
+    .flags      = VMS_POINTER|VMS_VARRAY_UINT32|VMS_ARRAY_OF_POINTER| \
+                  VMS_ARRAY_OF_POINTER_ALLOW_NULL,                    \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
 #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
diff --git a/migration/savevm.c b/migration/savevm.c
index 8115203b518..882c882f684 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -868,6 +868,32 @@ static void vmstate_check(const VMStateDescription *vmsd)
 
     if (field) {
         while (field->name) {
+            /*
+             * VMS_ARRAY_OF_POINTER must be used only together
+             * with one of VMS_(V)ARRAY* flags.
+             */
+            assert(!(field->flags & VMS_ARRAY_OF_POINTER) ||
+                   ((field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
+                     VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8 | VMS_VARRAY_UINT32))));
+
+            /*
+             * When VMS_ARRAY_OF_POINTER_ALLOW_NULL is used, we must:
+             * 1. have VMS_ARRAY_OF_POINTER set too;
+             * 2. have ->start field set and it should tell us a size
+             *    of memory chunk we should allocate for every array member.
+             */
+            assert(!(field->flags & VMS_ARRAY_OF_POINTER_ALLOW_NULL) ||
+                   (field->flags & VMS_ARRAY_OF_POINTER));
+            assert(!(field->flags & VMS_ARRAY_OF_POINTER_ALLOW_NULL) ||
+                   field->start);
+
+            /*
+             * (VMStateField).real_field is only for internal purposes
+             * and should never be used by any user-defined VMStateField.
+             * Currently, it is only used by vmsd_create_fake_nullptr_field().
+             */
+            assert(!field->real_field);
+
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
                 /* Recurse to sub structures */
                 vmstate_check(field->vmsd);
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 23f34336964..a55f4d51f4b 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -391,6 +391,97 @@ const VMStateInfo vmstate_info_nullptr = {
     .save = save_nullptr,
 };
 
+static bool load_maybeptr(QEMUFile *f, void *ppv, size_t unused_size,
+                          const VMStateField *field, Error **errp)
+{
+    bool ok = false;
+    const VMStateField *real_field = field->real_field;
+    /* size of structure pointed to by elements of array */
+    size_t size = real_field->start;
+    int marker;
+
+    assert(size);
+
+    if (ppv == NULL) {
+        error_setg(errp, "vmstate: get_maybeptr must be called with ppv != NULL");
+        return false;
+    }
+
+    /*
+     * We start from a clean array, all elements must be NULL, unless
+     * something we haven't prepared for has changed in vmstate_save_state_v().
+     * Let's check for this just in case.
+     */
+    if (*(void **)ppv != NULL) {
+        error_setg(errp, "vmstate: get_maybeptr must be called with *ppv == NULL");
+        return false;
+    }
+
+    marker = qemu_get_byte(f);
+    assert(marker == VMS_NULLPTR_MARKER || marker == VMS_NOTNULLPTR_MARKER);
+
+    if (marker == VMS_NOTNULLPTR_MARKER) {
+        void *pv;
+
+        /* allocate memory for structure */
+        pv = g_malloc0(size);
+
+        ok = vmstate_load_field(f, pv, size, real_field, errp);
+        if (!ok) {
+            g_free(pv);
+            return false;
+        }
+
+        *(void **)ppv = pv;
+    }
+
+    return true;
+}
+
+static bool save_maybeptr(QEMUFile *f, void *ppv, size_t unused_size,
+                          const VMStateField *field, JSONWriter *vmdesc,
+                          Error **errp)
+{
+    const VMStateField *real_field = field->real_field;
+    /* size of structure pointed to by elements of array */
+    size_t size = real_field->start;
+    void *pv;
+
+    assert(size);
+
+    /*
+     * (ppv) is an address of an i-th element of a dynamic array.
+     *
+     * (ppv) can not be NULL unless we have some regression/bug in
+     * vmstate_save_state_v(), because it is result of pointer arithemic like:
+     * first_elem + size * i.
+     */
+    if (ppv == NULL) {
+        error_setg(errp, "vmstate: put_maybeptr must be called with ppv != NULL");
+        return false;
+    }
+
+    /* get a pointer to a structure */
+    pv = *(void **)ppv;
+
+    if (pv == NULL) {
+        /* write a mark telling that there was a NULL pointer */
+        qemu_put_byte(f, VMS_NULLPTR_MARKER);
+        return true;
+    }
+
+    /* if pv is not NULL, write a marker and save field using vmstate_save_field() */
+    qemu_put_byte(f, VMS_NOTNULLPTR_MARKER);
+
+    return vmstate_save_field(f, pv, size, real_field, vmdesc, errp);
+}
+
+const VMStateInfo vmstate_info_maybeptr = {
+    .name = "maybeptr",
+    .load  = load_maybeptr,
+    .save  = save_maybeptr,
+};
+
 /* 64 bit unsigned int. See that the received value is the same than the one
    in the field */
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 616eb310e61..29e63751105 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -74,10 +74,15 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
     /* Do not need "field_exists" check as it always exists (which is null) */
     fake->field_exists = NULL;
 
-    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
-    fake->size = 1;
-    fake->info = &vmstate_info_nullptr;
-    fake->flags = VMS_SINGLE;
+    if (!(field->flags & VMS_ARRAY_OF_POINTER_ALLOW_NULL)) {
+        /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
+        fake->size = 1;
+        fake->info = &vmstate_info_nullptr;
+        fake->flags = VMS_SINGLE;
+    } else {
+        fake->real_field = field;
+        fake->info = &vmstate_info_maybeptr;
+    }
 
     /* All the rest fields shouldn't matter.. */
 
@@ -258,13 +263,28 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 bool ok;
                 void *curr_elem = first_elem + size * i;
+                bool need_fake_field = false;
                 const VMStateField *inner_field;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    curr_elem = *(void **)curr_elem;
+                    if (!(field->flags & VMS_ARRAY_OF_POINTER_ALLOW_NULL)) {
+                        assert(curr_elem);
+                        curr_elem = *(void **)curr_elem;
+                        need_fake_field = !curr_elem;
+                    } else {
+                        /*
+                         * We expect array of pointers to be initialized.
+                         * We don't want to overwrite curr_elem with it's
+                         * dereferenced value, because we may need to
+                         * allocate memory (depending on what is in the migration
+                         * stream) and write to it later.
+                         */
+                        assert(!*(void **)curr_elem);
+                        need_fake_field = true;
+                    }
                 }
 
-                if (!curr_elem && size) {
+                if (need_fake_field && size) {
                     /*
                      * If null pointer found (which should only happen in
                      * an array of pointers), use null placeholder and do
@@ -272,6 +292,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                      */
                     inner_field = vmsd_create_fake_nullptr_field(field);
                 } else {
+                    assert(curr_elem || !size);
                     inner_field = field;
                 }
 
@@ -546,25 +567,38 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
+                bool need_fake_field = false;
                 const VMStateField *inner_field;
                 bool is_null;
                 int max_elems = n_elems - i;
 
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    assert(curr_elem);
-                    curr_elem = *(void **)curr_elem;
+                    if (!(field->flags & VMS_ARRAY_OF_POINTER_ALLOW_NULL)) {
+                        assert(curr_elem);
+                        curr_elem = *(void **)curr_elem;
+                        need_fake_field = !curr_elem;
+                    } else {
+                        /*
+                         * We always need a fake field to properly handle
+                         * VMS_ARRAY_OF_POINTER_ALLOW_NULL case, because
+                         * even if pointer is not NULL, we still want to
+                         * write a marker in the migration stream.
+                         */
+                        need_fake_field = true;
+                    }
                 }
 
-                if (!curr_elem && size) {
+                if (need_fake_field && size) {
                     /*
                      * If null pointer found (which should only happen in
                      * an array of pointers), use null placeholder and do
                      * not follow.
                      */
                     inner_field = vmsd_create_fake_nullptr_field(field);
-                    is_null = true;
+                    is_null = !curr_elem;
                 } else {
+                    assert(curr_elem || !size);
                     inner_field = field;
                     is_null = false;
                 }
-- 
2.47.3


