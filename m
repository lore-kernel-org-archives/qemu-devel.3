Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B174105F7B0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13GM-0005Vv-5k; Fri, 13 Mar 2026 10:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fs-0005QN-Ir
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fl-0006MP-RD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439ac15f35fso1985423f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411147; x=1774015947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQ4LV65YsJl6GdSC63rqTaRoMXCCx30M/dn/ZkgCAiU=;
 b=Rj9ElFrACVLec2VikyrT21BE4noCIJQuYj0sZqd7lSmQrmVGkeEP1cOT0GAyWXf8qP
 t/uQO2INgP3lDEDDyefxp9NOfDTpZjMAB7VssaTl1AyjET+RB/DYVnp7QtZTujXGHT0z
 yXPkW0olH5p/TjCsAmnS1pnW8kG67RzEpaS7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411147; x=1774015947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kQ4LV65YsJl6GdSC63rqTaRoMXCCx30M/dn/ZkgCAiU=;
 b=V833W9mfyolOYOfYwX172zAZtVYkZRvfee8aK1VDtM/314jilcwubZl0hE17sFI3M1
 ihoF/+xErqcUNv3Tla19dTWjSnWNn10agbvpTImkfaXHpKw+dD9BCyvV6gaGLY2ZuNOg
 zTKUELQoVjf/9sCVbg5KVB9UyFVWRIwMYEKWxFnPYIwOb1z78LyPkdxVw04q6gz65G9j
 f2rPR+6eYjj3hBDV4J/w+gonXsGkriG0aMvWVT3MQAoZGsMADjQljpKgQfrarEYPCcMb
 yZG1x+Z4Eu3s6WqJoW8GvyNqGkTaIj2DDiVWWVz4mFoSQAEEUxhgLbn3Oqb6rqiVeSiz
 Ch6Q==
X-Gm-Message-State: AOJu0Yy+2rC4gD6gYLihDtFz+/poljpDs+r8U8jewa7xtP6w6C5T7FGZ
 ntQ93i9igoKXM5XvjHvcCahocBnx5OQaOHdEjSrhPeSzeTNV0526j1U4XRHoOou+zC2bi0j9g7r
 OKgSVp/Q=
X-Gm-Gg: ATEYQzxe85crOKXIqk5bbJw0ovLO5beVF8a0yCcpOx5Unvqj62YBLOVSxthhHCvD/A0
 din6RFGP6blw7u1O39980kklVMjN1nJ6tuaTx6EFdRl1d4qadn75Mw/eFxFO0ZB+12JrZIVj88H
 LF+f17adfq/CLismPfVCIZPg8KjzwKDIEakEJD5H2XM9AfNUkeJD72uMTR5TuvFqNxxRanM2pzD
 /XczNMwhkY3mwHoQJWTI3u1Lg7IHVjitOLZderDEkaX8JaFLQug2YqUZ1J1TSDyPBi0TjzLJuTx
 vJS8i/VhCLn9Uh7I3vOyK4PfgHAwAC3150mKuGvBfJYsrBDS8+T84/yoFqzDvlyMkKyP8DTZRs6
 h2TP8XOTl3L3ywqC13BmHsMUBGHNIyH8HzYLq+AftkTmi1ZgqJqUpyvOF7Sh0eTVfJCClu5OPm8
 7PxY5lUQJ/puAjQLVCCz4c62VRNrSgE4VaAgH7YVqur0UrwaHUFA2FcpxjlBYW0RXJZqTIT3ast
 fT5XKzaLZ3voOsFUkJ1ZL0=
X-Received: by 2002:a05:6000:4305:b0:439:afea:aff2 with SMTP id
 ffacd0b85a97d-43a04d81d37mr6812192f8f.23.1773411146429; 
 Fri, 13 Mar 2026 07:12:26 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:25 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 2/8] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Date: Fri, 13 Mar 2026 15:12:15 +0100
Message-ID: <20260313141221.359503-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313141221.359503-1-alexander@mihalicyn.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42c.google.com
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
---
 include/migration/vmstate.h |  77 ++++++++++++++++++++++++++-
 migration/savevm.c          |  26 +++++++++
 migration/vmstate-types.c   | 102 ++++++++++++++++++++++++++++++++++++
 migration/vmstate.c         |  54 +++++++++++++++----
 4 files changed, 247 insertions(+), 12 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5d7dfe70643..70588ed86d7 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -151,7 +151,19 @@ enum VMStateFlags {
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
@@ -184,6 +196,7 @@ struct VMStateField {
     int version_id;
     int struct_version_id;
     bool (*field_exists)(void *opaque, int version_id);
+    const struct VMStateField *real_field;
 };
 
 struct VMStateDescription {
@@ -252,8 +265,10 @@ extern const VMStateInfo vmstate_info_uint64;
 extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
-#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+#define VMS_NULLPTR_MARKER    (0x30U) /* '0' */
+#define VMS_NOTNULLPTR_MARKER (0x31U) /* '1' */
 extern const VMStateInfo vmstate_info_nullptr;
+extern const VMStateInfo vmstate_info_maybeptr;
 
 extern const VMStateInfo vmstate_info_cpudouble;
 
@@ -265,6 +280,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_ptrs_array_entry;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -547,6 +563,63 @@ extern const VMStateInfo vmstate_info_qlist;
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
index 197c89e0e65..1ce618d2e66 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -863,6 +863,32 @@ static void vmstate_check(const VMStateDescription *vmsd)
 
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
index 89cb2114721..8e5431057db 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -377,6 +377,108 @@ const VMStateInfo vmstate_info_nullptr = {
     .put  = put_nullptr,
 };
 
+static int get_maybeptr(QEMUFile *f, void *ppv, size_t unused_size,
+                        const VMStateField *field)
+{
+    Error *local_err = NULL;
+    Error **errp = &local_err;
+    int ret = 0;
+    const VMStateField *real_field = field->real_field;
+    /* size of structure pointed to by elements of array */
+    size_t size = real_field->start;
+    int marker;
+
+    assert(size);
+
+    if (ppv == NULL) {
+        error_report("vmstate: get_maybeptr must be called with ppv != NULL");
+        return -EINVAL;
+    }
+
+    /*
+     * We start from a clean array, all elements must be NULL, unless
+     * something we haven't prepared for has changed in vmstate_save_state_v().
+     * Let's check for this just in case.
+     */
+    if (*(void **)ppv != NULL) {
+        error_report("vmstate: get_maybeptr must be called with *ppv == NULL");
+        return -EINVAL;
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
+        ret = vmstate_load_field(f, pv, size, real_field, errp);
+        if (ret) {
+            error_report_err(local_err);
+            g_free(pv);
+            return ret;
+        }
+
+        *(void **)ppv = pv;
+    }
+
+    return ret;
+}
+
+static int put_maybeptr(QEMUFile *f, void *ppv, size_t unused_size,
+                        const VMStateField *field, JSONWriter *vmdesc)
+{
+    const VMStateField *real_field = field->real_field;
+    int ret = 0;
+    Error *local_err = NULL;
+    Error **errp = &local_err;
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
+        error_report("vmstate: put_maybeptr must be called with ppv != NULL");
+        return -EINVAL;
+    }
+
+    /* get a pointer to a structure */
+    pv = *(void **)ppv;
+
+    if (pv == NULL) {
+        /* write a mark telling that there was a NULL pointer */
+        qemu_put_byte(f, VMS_NULLPTR_MARKER);
+        return 0;
+    }
+
+    /* if pv is not NULL, write a marker and save field using vmstate_save_field() */
+    qemu_put_byte(f, VMS_NOTNULLPTR_MARKER);
+
+    ret = vmstate_save_field(f, pv, size, real_field, vmdesc, errp);
+    if (ret) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    return 0;
+}
+
+const VMStateInfo vmstate_info_maybeptr = {
+    .name = "maybeptr",
+    .get  = get_maybeptr,
+    .put  = put_maybeptr,
+};
+
 /* 64 bit unsigned int. See that the received value is the same than the one
    in the field */
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 8d192bcaa27..e52046f069d 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -71,10 +71,15 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
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
 
@@ -212,13 +217,28 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             }
             for (i = 0; i < n_elems; i++) {
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
@@ -226,6 +246,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                      */
                     inner_field = vmsd_create_fake_nullptr_field(field);
                 } else {
+                    assert(curr_elem || !size);
                     inner_field = field;
                 }
 
@@ -507,25 +528,38 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
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


