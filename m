Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67279C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUn-00082B-7o; Tue, 18 Aug 2026 14:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUl-00081T-CB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:07 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUh-0002zf-3h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80C993E39;
 Tue, 18 Aug 2026 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYy26PXxKizQVID78SWYPZeYQFKEXBhX80lFvKgUAtI=;
 b=c0cSk/hs7oqkgfN3iSIqo3YaipeNrCbsqPskBQHgFu4mI5IsgQ6m7/TPhqWWsRj1vuFqpX
 2+ps0oFfUcLXh4RPfMoL7J3K8lOpMxp9r1XIfZYaUItOW8OJfsdWM+kzx5xzsigAZWC2qz
 I9czW0jZmXQQOP4okYmUCJgNHLzZb1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYy26PXxKizQVID78SWYPZeYQFKEXBhX80lFvKgUAtI=;
 b=KDtcSGtbjK01OOdYpZaSyudi21/caHbinUTr09Qzi7W1ZloXY6LZywv884nFX3UK9ou/RT
 oCA7y8OxlsNIg6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYy26PXxKizQVID78SWYPZeYQFKEXBhX80lFvKgUAtI=;
 b=kdrUy08VyHpTo01xFjmmDHszp6LX7immWdrp2y11QoN8x8krU9tALiBa32k8E8wLwvRQBb
 +YrupODTCr0aaw6/hfGY1AxWFS+WNRvngS6XHjM7FTxFlWYhirTEpkL02qQaM+HCiCyic8
 BwZA/QH6T2TMge8UEQH8Uhvh84Wo2oE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYy26PXxKizQVID78SWYPZeYQFKEXBhX80lFvKgUAtI=;
 b=IplBal8YJOaFiw38Ki8/+dxFVXkeUaG2CWvQ/PIhL5SggEgPM267L8HwqRbNzOWfi3Woj6
 K3OBEoHsiX+0DKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B2E922BA;
 Tue, 18 Aug 2026 18:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eCHnGnOjhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:24:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Seungjung Kim <seungjung0711@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 2/8] migration: Introduce VMStateStructMember
Date: Tue, 18 Aug 2026 15:24:35 -0300
Message-ID: <20260818182441.404790-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,yandex-team.ru,gmail.com,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

When migrating a buffer or array, the vmstate code needs to know the
size of the buffer and the number of elements of the array. Today a
vmstate writer can choose from a number of macros that take as last
input the name of a struct member from where the size/num will be
read.

At load time, the code will access those values via an opaque pointer
to the migrated data and therefore it needs to also know the size of
the struct member at that offset.

Currently that information is communicated by means of the
VMS_VARRAY_* and VMS_VBUFFER_* flags, where each possible type is
represented by a flag.

So far, that's all fine, but since the vmstate code makes heavy use of
macros, handling several types individually (i.e. by name: int,
int32_t, etc) requires several versions of a same macro, one for each
type. E.g: VMSTATE_VBUFFER_ALLOC_UINT32
                                 ^

This creates a pattern where the vmstate writer has to match the macro
name to the data type and has resulted in the code having a tendency
of having one macro version for each type, for each type of vmstate.

There is also some cognitive load to deal with, e.g.
VMSTATE_VARRAY_INT32 doesn't hold an array of int32, it holds an array
of something else and the number of elements for the array is stored
in a variable of type int32.

We're now dealing with the scenario where the code has been expecting
int32_t at some places, but a uint64_t macro variant has been added
without the code being updated.

To address all these situations, introduce a new struct that will hold
the offset of the struct members, but also their size, so the various
extra macros can all be removed and the person writing the vmstate
doesn't need to care about type-checking. Still, keep a minimum check
that those fields are at least integers and fit into 64 bits.

What changes:

1) type checking changes from individual types to a single check for
   all integers;

2) there are new ways to access the offsets;

num_offset -> num_indirect.offset
size_offset -> size_indirect.offset
[new] num_indirect.size
[new] size_indirect.size

2) reading the offsets goes from checking the VMS_VARRAY_* flags in an
   if/elseif block to comparing offset.size against the hardcoded
   sizes in bytes;

3) the VMS_VARRAY_* and VMS_VBUFFER_* flags become obsolete. Removed
   in the next patch;

4) memory usage increases +1 byte per vmstate;

Reported-by: Seungjung Kim <seungjung0711@gmail.com>
Fixes: CVE-2026-6426
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h        | 163 +++++++++++++++++++++--------
 migration/savevm.c                 |   4 +-
 migration/vmstate.c                |  50 +++++----
 rust/bindings/migration-sys/lib.rs |  10 ++
 rust/migration/src/vmstate.rs      |  24 ++++-
 rust/tests/tests/vmstate_tests.rs  |  26 ++---
 6 files changed, 197 insertions(+), 80 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 214a2131350..12bfa64fb92 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -31,6 +31,7 @@
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateField VMStateField;
+typedef struct VMStateStructMember VMStateStructMember;
 
 /*
  * VMStateInfo allows customized migration of objects that don't fit in
@@ -67,15 +68,15 @@ enum VMStateFlags {
      * to the actual field (e.g. struct a { uint8_t *b;
      * }). Dereference the pointer before using it as basis for
      * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
-     * affect the meaning of VMStateField.num_offset or
-     * VMStateField.size_offset; see VMS_VARRAY* and VMS_VBUFFER for
+     * affect the meaning of VMStateField.num_indirect or
+     * VMStateField.size_indirect; see VMS_VARRAY* and VMS_VBUFFER for
      * those. */
     VMS_POINTER          = 0x002,
 
     /* The field is an array of fixed size. VMStateField.num contains
      * the number of entries in the array. The size of each entry is
      * given by VMStateField.size and / or opaque +
-     * VMStateField.size_offset; see VMS_VBUFFER and
+     * VMStateField.size_indirect; see VMS_VBUFFER and
      * VMS_MULTIPLY. Each array entry will be processed individually
      * (VMStateField.info.get()/put() if VMS_STRUCT is not set,
      * recursion into VMStateField.vmsd if VMS_STRUCT is set). May not
@@ -88,8 +89,9 @@ enum VMStateFlags {
      * array entry. */
     VMS_STRUCT           = 0x008,
 
-    /* The field is an array of variable size. The int32_t at opaque +
-     * VMStateField.num_offset contains the number of entries in the
+    /*
+     * The field is an array of variable size. The integer at opaque +
+     * VMStateField.num_indirect contains the number of entries in the
      * array. See the VMS_ARRAY description regarding array handling
      * in general. May not be combined with VMS_ARRAY or any other
      * VMS_VARRAY*. */
@@ -105,7 +107,7 @@ enum VMStateFlags {
     VMS_ARRAY_OF_POINTER = 0x040,
 
     /* The field is an array of variable size. The uint16_t at opaque
-     * + VMStateField.num_offset
+     * + VMStateField.num_indirect
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -114,26 +116,27 @@ enum VMStateFlags {
     /* The size of the individual entries (a single array entry if
      * VMS_ARRAY or any of VMS_VARRAY* are set, or the field itself if
      * neither is set) is variable (i.e. not known at compile-time),
-     * but the same for all entries. Use the int32_t at opaque +
-     * VMStateField.size_offset (subject to VMS_MULTIPLY) to determine
+     * but the same for all entries. Use the integer at opaque +
+     * VMStateField.size_indirect (subject to VMS_MULTIPLY) to determine
      * the size of each (and every) entry. */
     VMS_VBUFFER          = 0x100,
 
-    /* Multiply the entry size given by the int32_t at opaque +
-     * VMStateField.size_offset (see VMS_VBUFFER description) with
+    /*
+     * Multiply the entry size given by the integer at opaque +
+     * VMStateField.size_indirect (see VMS_VBUFFER description) with
      * VMStateField.size to determine the number of bytes to be
      * allocated. Only valid in combination with VMS_VBUFFER. */
     VMS_MULTIPLY         = 0x200,
 
     /* The field is an array of variable size. The uint8_t at opaque +
-     * VMStateField.num_offset
+     * VMStateField.num_indirect
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
     VMS_VARRAY_UINT8     = 0x400,
 
     /* The field is an array of variable size. The uint32_t at opaque
-     * + VMStateField.num_offset
+     * + VMStateField.num_indirect
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -187,29 +190,88 @@ typedef enum {
     MIG_PRI_MAX,
 } MigrationPriority;
 
+
+/*
+ * VMStateStructMember: Metadata about a single member of the struct
+ * being migrated by the vmstate. This is kept separate from
+ * VMStateField because a single VMStateField can reference other
+ * members of the struct aside from the main struct member that's
+ * being migrated.
+ *
+ * One situation where extra fields are referenced is the common case
+ * of a struct containing an array or buffer, the size of which is
+ * stored in another member of the same struct.
+ *
+ * Example 1:
+ * struct IDEState {
+ *     ...
+ *     uint8_t *io_buffer;
+ *     int32_t io_buffer_total_len;
+ *     ...
+ * }
+ * VMSTATE_VARRAY_INT32(io_buffer, IDEState, io_buffer_total_len, 1,
+ *                      vmstate_info_uint8, uint8_t)
+ *
+ * In the above, io_buffer is the main field being migrated by the
+ * VMSTATE_VARRAY while io_buffer_total_len is the meta field that
+ * provides the size of the io_buffer. In this particular case,
+ * io_buffer_total_len is never migrated.
+ *
+ * Example 2:
+ * struct SpaprMachineState {
+ *      ...
+ *      uint32_t fdt_size;
+ *      void *fdt_blob;
+ *      ...
+ * }
+ * VMSTATE_UINT32(fdt_size, SpaprMachineState),
+ * VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, SpaprMachineState, 0, NULL, fdt_size),
+ *
+ * Here, fdt_blob is the field being migrated by VMSTATE_VBUFFER_ALLOC
+ * and fdt_size is the meta field providing the size. In this case,
+ * the extra field is also independently migrated by the
+ * VMSTATE_UINT32 above.
+ */
+struct VMStateStructMember {
+    /* offsetof the field inside the migrated struct */
+    uint32_t offset;
+    /* size of field itself */
+    uint8_t size;
+};
+
 struct VMStateField {
     const char *name;
     size_t offset;
 
     /*
-     * @size or @size_offset specifies the size of the element embeded in
-     * the field.  Only one of them should be present never both.  When
-     * @size_offset is used together with VMS_VBUFFER, it means the size is
-     * dynamic calculated instead of a constant.
+     * @size directly specifies the size of the element being
+     * migrated.
      *
-     * When the field is an array of any type, this stores the size of one
-     * element of the array.
+     * @size_indirect specifies the offset inside a struct where the
+     * size of the element is stored.
      *
-     * NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be specified,
-     * this parameter always reflects the real size of the objects that a
-     * pointer point to.
+     *   Only one of the above should be present (except for
+     *   VMSTATE_MULTIPLY which uses .size as a multiplier). When
+     *   @size_indirect is used together with VMS_VBUFFER, it means
+     *   the size is dynamic calculated instead of a constant.
+     *
+     *   When the field is an array of any type, these refer to the size
+     *   of one element of the array.
+     *
+     *   NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be
+     *   specified, these parameters always reflect the real size of the
+     *   objects that a pointer point to.
+     *
+     * @num_indirect specifies the offset inside a struct where the
+     * number of elements of an array is stored.
      */
     size_t size;
-    size_t size_offset;
+    VMStateStructMember size_indirect;
+    VMStateStructMember num_indirect;
 
     size_t start;
     int num;
-    size_t num_offset;
+
     const VMStateInfo *info;
     enum VMStateFlags flags;
     const VMStateDescription *vmsd;
@@ -328,6 +390,17 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     (type_check(t1, typeof_elt_of_field(t2, f))                      \
      + QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(((t2 *)0)->f)))
 
+#define type_check_int64(t)                                     \
+    (~((t)0) * sizeof(struct {                                  \
+            QEMU_BUILD_BUG_ON(sizeof(t) > sizeof(uint64_t));    \
+    }))
+
+#define vmstate_field_offset(_state, _field) {                  \
+    .offset = (offsetof(_state, _field) +                       \
+            type_check_int64(typeof_field(_state, _field))),    \
+    .size = sizeof(typeof_field(_state, _field)),               \
+}
+
 #define vmstate_offset_value(_state, _field, _type)                  \
     (offsetof(_state, _field) +                                      \
      type_check(_type, typeof_field(_state, _field)))
@@ -454,7 +527,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_INT32|VMS_POINTER,                      \
@@ -464,7 +537,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_UINT32(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                     \
@@ -474,7 +547,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_INT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_INT32 | VMS_POINTER | VMS_ALLOC,        \
@@ -484,7 +557,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_UINT32|VMS_POINTER|VMS_ALLOC,           \
@@ -494,7 +567,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
@@ -504,7 +577,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_UINT16,                                 \
@@ -583,7 +656,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     _field, _state, _field_num, _version, _vmsd, _type) {            \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
@@ -596,7 +669,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     _field, _state, _field_num, _version, _vmsd, _type) {             \
     .name       = (stringify(_field)),                                \
     .version_id = (_version),                                         \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),         \
     .vmsd       = &(_vmsd),                                           \
     .size       = sizeof(_type),                                      \
     .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
@@ -608,7 +681,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
+    .num_indirect = vmstate_field_offset(_state, _field_num),             \
     .info       = &(_info),                                               \
     .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
@@ -650,7 +723,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 
 #define VMSTATE_STRUCT_VARRAY_UINT8(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
@@ -674,7 +747,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_STRUCT_VARRAY_POINTER_INT32(_field, _state, _field_num, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = 0,                                                 \
-    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
     .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
@@ -684,7 +757,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_STRUCT_VARRAY_POINTER_UINT32(_field, _state, _field_num, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = 0,                                                 \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
     .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
@@ -694,7 +767,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_STRUCT_VARRAY_POINTER_UINT16(_field, _state, _field_num, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = 0,                                                 \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
     .flags      = VMS_POINTER | VMS_VARRAY_UINT16 | VMS_STRUCT,      \
@@ -703,7 +776,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 
 #define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
@@ -715,7 +788,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
-    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
+    .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_STRUCT|VMS_VARRAY_INT32|VMS_ALLOC|VMS_POINTER, \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
@@ -736,7 +809,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
-    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
+    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
     .size         = (_multiply),                                      \
     .info         = &vmstate_info_buffer,                            \
     .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
@@ -747,7 +820,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
-    .size_offset  = vmstate_offset_value(_state, _field_size, int32_t),\
+    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
     .info         = &vmstate_info_buffer,                            \
     .flags        = VMS_VBUFFER|VMS_POINTER,                         \
     .offset       = offsetof(_state, _field),                        \
@@ -757,7 +830,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
-    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
+    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
     .info         = &vmstate_info_buffer,                            \
     .flags        = VMS_VBUFFER|VMS_POINTER,                         \
     .offset       = offsetof(_state, _field),                        \
@@ -767,7 +840,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
-    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
+    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
     .info         = &vmstate_info_buffer,                            \
     .flags        = VMS_VBUFFER | VMS_POINTER,                       \
     .offset       = offsetof(_state, _field),                        \
@@ -778,7 +851,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
-    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
+    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
     .info         = &vmstate_info_buffer,                            \
     .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
     .offset       = offsetof(_state, _field),                        \
@@ -838,7 +911,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_UNUSED_VARRAY_UINT32(_state, _test, _version, _field_num, _size) {\
     .name         = "unused",                                        \
     .field_exists = (_test),                                         \
-    .num_offset   = vmstate_offset_value(_state, _field_num, uint32_t),\
+    .num_indirect   = vmstate_field_offset(_state, _field_num),      \
     .version_id   = (_version),                                      \
     .size         = (_size),                                         \
     .info         = &vmstate_info_unused_buffer,                     \
@@ -852,7 +925,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .name         = (stringify(_field)),                             \
     .field_exists = (_test),                                         \
     .version_id   = (_version),                                      \
-    .size_offset  = vmstate_offset_value(_state, _field_size, int32_t),\
+    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
     .info         = &vmstate_info_bitmap,                            \
     .flags        = VMS_VBUFFER|VMS_POINTER,                         \
     .offset       = offsetof(_state, _field),                        \
diff --git a/migration/savevm.c b/migration/savevm.c
index 34dd06f9f73..e1b707dda63 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -873,14 +873,14 @@ static void vmstate_check(const VMStateDescription *vmsd)
                      * Size must be provided because dest QEMU needs that
                      * info to know what to allocate
                      */
-                    assert(field->size || field->size_offset);
+                    assert(field->size != 0 || field->size_indirect.size != 0);
                 } else {
                     /*
                      * Otherwise size info isn't useful (because it's
                      * always the size of host pointer), detect accidental
                      * setup of sizes in this case.
                      */
-                    assert(field->size == 0 && field->size_offset == 0);
+                    assert(field->size == 0 && field->size_indirect.size == 0);
                 }
                 /*
                  * VMS_ARRAY_OF_POINTER must be used only together with one
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 50ebe378452..372aed258f1 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -78,32 +78,44 @@ vmsd_init_ptr_marker_field(VMStateField *fake, const VMStateField *field)
     };
 }
 
-static int vmstate_n_elems(void *opaque, const VMStateField *field)
+static uint64_t vmstate_read_from_offset(const VMStateStructMember *member,
+                                         void *opaque)
 {
-    int n_elems = 1;
+    uint8_t *ptr = (uint8_t *)opaque + member->offset;
+    uint64_t v = 0;
+
+    switch (member->size) {
+    case 1:
+    case 2:
+    case 4:
+    case 8:
+        memcpy(&v, ptr, member->size);
+        return v;
+    }
+    g_assert_not_reached();
+}
+
+static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
+{
+    uint64_t n_elems = 1;
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
-    } else if (field->flags & VMS_VARRAY_INT32) {
-        n_elems = *(int32_t *)(opaque + field->num_offset);
-    } else if (field->flags & VMS_VARRAY_UINT32) {
-        n_elems = *(uint32_t *)(opaque + field->num_offset);
-    } else if (field->flags & VMS_VARRAY_UINT16) {
-        n_elems = *(uint16_t *)(opaque + field->num_offset);
-    } else if (field->flags & VMS_VARRAY_UINT8) {
-        n_elems = *(uint8_t *)(opaque + field->num_offset);
+    } else if (field->flags & (VMS_VARRAY_INT32 | VMS_VARRAY_UINT32
+                               | VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8)) {
+        n_elems = vmstate_read_from_offset(&field->num_indirect, opaque);
     }
 
     trace_vmstate_n_elems(field->name, n_elems);
     return n_elems;
 }
 
-static int vmstate_size(void *opaque, const VMStateField *field)
+static uint64_t vmstate_size(void *opaque, const VMStateField *field)
 {
-    int size;
+    uint64_t size;
 
     if (field->flags & VMS_VBUFFER) {
-        size = *(int32_t *)(opaque + field->size_offset);
+        size = vmstate_read_from_offset(&field->size_indirect, opaque);
         if (field->flags & VMS_MULTIPLY) {
             size *= field->size;
         }
@@ -124,7 +136,7 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
                                  void *opaque)
 {
     if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
-        gsize size = vmstate_size(opaque, field);
+        uint64_t size = vmstate_size(opaque, field);
         size *= vmstate_n_elems(opaque, field);
         if (size) {
             *(void **)ptr = g_malloc(size);
@@ -335,8 +347,9 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 
         if (exists) {
             void *first_elem = opaque + field->offset;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            int i;
+            uint64_t n_elems = vmstate_n_elems(opaque, field);
+            uint64_t size = vmstate_size(opaque, field);
 
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
@@ -650,8 +663,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
     while (field->name) {
         if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
             void *first_elem = opaque + field->offset;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            int i;
+            uint64_t n_elems = vmstate_n_elems(opaque, field);
+            uint64_t size = vmstate_size(opaque, field);
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
             /*
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
index 9581481e421..baa2730ca9d 100644
--- a/rust/bindings/migration-sys/lib.rs
+++ b/rust/bindings/migration-sys/lib.rs
@@ -47,6 +47,7 @@ fn default() -> Self {
 unsafe impl Zeroable for VMStateFlags {}
 unsafe impl Zeroable for VMStateField {}
 unsafe impl Zeroable for VMStateDescription {}
+unsafe impl Zeroable for VMStateStructMember {}
 
 // The following higher-level helpers could be in "migration"
 // crate when Rust has const trait impl.
@@ -115,3 +116,12 @@ pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
         self.with_varray_flag_unchecked(flag)
     }
 }
+
+impl VMStateStructMember {
+    pub const fn new(off: usize, size: usize) -> Self {
+        Self {
+            offset: off as u32,
+            size: size as u8,
+        }
+    }
+}
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 63d78b4f275..e60c0860cc5 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -42,7 +42,7 @@
 };
 
 use crate::bindings::{self, VMStateFlags};
-pub use crate::bindings::{MigrationPriority, VMStateField};
+pub use crate::bindings::{MigrationPriority, VMStateField, VMStateStructMember};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -120,6 +120,23 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
     T::VARRAY_FLAG
 }
 
+pub const OPAQUE: &[u8; 1048576] = &[0; 1048576];
+
+pub const fn size_of_ptr_type<T>(_: *const T) -> usize {
+    ::core::mem::size_of::<T>()
+}
+
+#[macro_export]
+macro_rules! size_of_field_type {
+    ($struct_name:ty, $($field_name:ident).+) => {
+        $crate::vmstate::size_of_ptr_type(unsafe {
+            ::core::ptr::addr_of!(
+                (*$crate::vmstate::OPAQUE.as_ptr().cast::<$struct_name>()).$($field_name).+
+            )
+        })
+    };
+}
+
 /// Return the `VMStateField` for a field of a struct.  The field must be
 /// visible in the current scope.
 ///
@@ -148,7 +165,10 @@ macro_rules! vmstate_of {
                 .as_bytes()
                 .as_ptr().cast::<::std::os::raw::c_char>(),
             offset: ::std::mem::offset_of!($struct_name, $($field_name).+),
-            $(num_offset: ::std::mem::offset_of!($struct_name, $($num).+),)?
+	    $(num_indirect: $crate::vmstate::VMStateStructMember {
+                offset: ::std::mem::offset_of!($struct_name, $($num).+) as u32,
+		size: $crate::size_of_field_type!($struct_name, $($num).+) as u8,
+            },)?
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index c2c12cfab52..c002ffb2bc4 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -65,7 +65,7 @@ fn test_vmstate_uint16() {
         b"elem\0"
     );
     assert_eq!(foo_fields[0].offset, 16);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_indirect.size, 0);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int8 });
     assert_eq!(foo_fields[0].version_id, 0);
     assert_eq!(foo_fields[0].size, 1);
@@ -86,7 +86,7 @@ fn test_vmstate_unused() {
         b"unused\0"
     );
     assert_eq!(foo_fields[1].offset, 0);
-    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].num_indirect.size, 0);
     assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_unused_buffer });
     assert_eq!(foo_fields[1].version_id, 0);
     assert_eq!(foo_fields[1].size, 8);
@@ -108,7 +108,7 @@ fn test_vmstate_varray_uint16_unsafe() {
         b"arr\0"
     );
     assert_eq!(foo_fields[2].offset, 0);
-    assert_eq!(foo_fields[2].num_offset, 4);
+    assert_eq!(foo_fields[2].num_indirect.offset, 4);
     assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[2].version_id, 0);
     assert_eq!(foo_fields[2].size, 1);
@@ -172,7 +172,7 @@ fn test_vmstate_bool_v() {
         b"val\0"
     );
     assert_eq!(foo_fields[0].offset, 136);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_indirect.size, 0);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_bool });
     assert_eq!(foo_fields[0].version_id, 2);
     assert_eq!(foo_fields[0].size, 1);
@@ -193,7 +193,7 @@ fn test_vmstate_uint64() {
         b"wrap\0"
     );
     assert_eq!(foo_fields[1].offset, 128);
-    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].num_indirect.size, 0);
     assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_uint64 });
     assert_eq!(foo_fields[1].version_id, 0);
     assert_eq!(foo_fields[1].size, 8);
@@ -215,7 +215,7 @@ fn test_vmstate_struct_varray_uint8() {
         b"arr_a\0"
     );
     assert_eq!(foo_fields[2].offset, 0);
-    assert_eq!(foo_fields[2].num_offset, 60);
+    assert_eq!(foo_fields[2].num_indirect.offset, 60);
     assert!(foo_fields[2].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
     assert_eq!(foo_fields[2].version_id, 1);
     assert_eq!(foo_fields[2].size, 20);
@@ -240,7 +240,7 @@ fn test_vmstate_macro_array() {
         b"arr_i64\0"
     );
     assert_eq!(foo_fields[4].offset, 144);
-    assert_eq!(foo_fields[4].num_offset, 0);
+    assert_eq!(foo_fields[4].num_indirect.size, 0);
     assert_eq!(foo_fields[4].info, unsafe { &vmstate_info_int64 });
     assert_eq!(foo_fields[4].version_id, 0);
     assert_eq!(foo_fields[4].size, 8);
@@ -264,7 +264,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
         unsafe { CStr::from_ptr(foo_fields[5].name) }.to_bytes_with_nul(),
         b"arr_a_wrap\0"
     );
-    assert_eq!(foo_fields[5].num_offset, 228);
+    assert_eq!(foo_fields[5].num_indirect.offset, 228);
     assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0) });
 
     // The last VMStateField in VMSTATE_FOOB.
@@ -316,7 +316,7 @@ fn test_vmstate_pointer() {
         b"ptr\0"
     );
     assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_indirect.size, 0);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int32 });
     assert_eq!(foo_fields[0].version_id, 2);
     assert_eq!(foo_fields[0].size, 4);
@@ -341,7 +341,7 @@ fn test_vmstate_struct_pointer() {
         b"ptr_a\0"
     );
     assert_eq!(foo_fields[1].offset, PTR_SIZE);
-    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].num_indirect.size, 0);
     assert_eq!(foo_fields[1].vmsd, VMSTATE_FOOA.as_ref());
     assert_eq!(foo_fields[1].version_id, 0);
     assert_eq!(foo_fields[1].size, size_of::<FooA>());
@@ -366,7 +366,7 @@ fn test_vmstate_macro_array_of_pointer() {
         b"arr_ptr\0"
     );
     assert_eq!(foo_fields[2].offset, 2 * PTR_SIZE);
-    assert_eq!(foo_fields[2].num_offset, 0);
+    assert_eq!(foo_fields[2].num_indirect.size, 0);
     assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[2].version_id, 0);
     assert_eq!(foo_fields[2].size, PTR_SIZE);
@@ -391,7 +391,7 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
         b"arr_ptr_wrap\0"
     );
     assert_eq!(foo_fields[3].offset, (FOO_ARRAY_MAX + 2) * PTR_SIZE);
-    assert_eq!(foo_fields[3].num_offset, 0);
+    assert_eq!(foo_fields[3].num_indirect.size, 0);
     assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[3].version_id, 0);
     assert_eq!(foo_fields[3].size, PTR_SIZE);
@@ -454,7 +454,7 @@ fn test_vmstate_validate() {
         b"foo_d_0\0"
     );
     assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_indirect.size, 0);
     assert!(foo_fields[0].info.is_null());
     assert_eq!(foo_fields[0].version_id, 0);
     assert_eq!(foo_fields[0].size, 0);
-- 
2.53.0


