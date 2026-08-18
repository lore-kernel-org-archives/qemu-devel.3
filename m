Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8FDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUo-00082X-8p; Tue, 18 Aug 2026 14:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUm-00081d-3j
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:08 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUj-00039i-6Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD573E8C;
 Tue, 18 Aug 2026 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OApujg6O6m3Dquv+V7qQF2oVVDehESoVxw0de8YzCaA=;
 b=X3EWLj7rGRu6iTk1GkQlhaSfRdZPVNUYJOFiM0RQr7gM/3CrjBOP8JmRUfQEWLSU6FPx8o
 khc6NHws93v8T/NGUDjOfkVHQOGsrbRmTmBu2OKCN2KBYJPXpKsfOKAkGj2kf0/7WjSBMp
 bLK+KEo2bWEFpr5VgTT4xwWHCu6HO2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OApujg6O6m3Dquv+V7qQF2oVVDehESoVxw0de8YzCaA=;
 b=Jf+Up4cAAUZL9Im6hE3JQw8BqBzDC5gkk1k7EoM+CjKnnItAHlnGGk7qSJC+iL7m7UNwmm
 4mPmPuJ8jTXzMIBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OApujg6O6m3Dquv+V7qQF2oVVDehESoVxw0de8YzCaA=;
 b=xRk4IdxWDIyafxbER2WyoAPS1fzvx3Pa3sUizjU8pq/IpyBjvzFnMmN7k+/M6adXXiXFTf
 coOdMX6xdqI2NY2nZnUoVsAp1YK3T8bFhfP8Pf9+2s0dOj5W7lySAFfLrWoQ272AN87Vu2
 K2QT4vycS59Jg1ZQ9/Y3v02YZqURyto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OApujg6O6m3Dquv+V7qQF2oVVDehESoVxw0de8YzCaA=;
 b=uOSfBirXA/umEQ0h7VUYleCC2veSMGTzREfYOZOHNXFtE1swuWfgmQvw0Mewb6qfkmOmt+
 WDG3GArB6TaJz6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E484F364F;
 Tue, 18 Aug 2026 18:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AH7XLHWjhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:24:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 3/8] migration: Remove redundant flags
Date: Tue, 18 Aug 2026 15:24:36 -0300
Message-ID: <20260818182441.404790-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Remove the VMS_VARRAY and VMS_VBUFFER flags that became redundant due
to the previous commit which stores the size of the vmstate offset
variables along with the offset itself.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h        | 74 +++++++++++-------------------
 migration/savevm.c                 |  6 +--
 migration/vmstate.c                |  3 +-
 rust/bindings/migration-sys/lib.rs |  7 +--
 rust/migration/src/vmstate.rs      |  6 +--
 rust/tests/tests/vmstate_tests.rs  |  4 +-
 6 files changed, 37 insertions(+), 63 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 12bfa64fb92..a168651a062 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -69,8 +69,9 @@ enum VMStateFlags {
      * }). Dereference the pointer before using it as basis for
      * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
      * affect the meaning of VMStateField.num_indirect or
-     * VMStateField.size_indirect; see VMS_VARRAY* and VMS_VBUFFER for
-     * those. */
+     * VMStateField.size_indirect; see VMS_VARRAY and VMS_VBUFFER for
+     * those.
+     */
     VMS_POINTER          = 0x002,
 
     /* The field is an array of fixed size. VMStateField.num contains
@@ -80,12 +81,13 @@ enum VMStateFlags {
      * VMS_MULTIPLY. Each array entry will be processed individually
      * (VMStateField.info.get()/put() if VMS_STRUCT is not set,
      * recursion into VMStateField.vmsd if VMS_STRUCT is set). May not
-     * be combined with VMS_VARRAY*. */
+     * be combined with VMS_VARRAY.
+     */
     VMS_ARRAY            = 0x004,
 
     /* The field is itself a struct, containing one or more
      * fields. Recurse into VMStateField.vmsd. Most useful in
-     * combination with VMS_ARRAY / VMS_VARRAY*, recursing into each
+     * combination with VMS_ARRAY / VMS_VARRAY, recursing into each
      * array entry. */
     VMS_STRUCT           = 0x008,
 
@@ -93,9 +95,9 @@ enum VMStateFlags {
      * The field is an array of variable size. The integer at opaque +
      * VMStateField.num_indirect contains the number of entries in the
      * array. See the VMS_ARRAY description regarding array handling
-     * in general. May not be combined with VMS_ARRAY or any other
-     * VMS_VARRAY*. */
-    VMS_VARRAY_INT32     = 0x010,
+     * in general. May not be combined with VMS_ARRAY.
+     */
+    VMS_VARRAY     = 0x010,
 
     /* Ignored */
     VMS_BUFFER           = 0x020,
@@ -103,18 +105,12 @@ enum VMStateFlags {
     /* The field is a (fixed-size or variable-size) array of pointers
      * (e.g. struct a { uint8_t *b[]; }). Dereference each array entry
      * before using it. Note: Does not imply any one of VMS_ARRAY /
-     * VMS_VARRAY*; these need to be set explicitly. */
+     * VMS_VARRAY; these need to be set explicitly.
+     */
     VMS_ARRAY_OF_POINTER = 0x040,
 
-    /* The field is an array of variable size. The uint16_t at opaque
-     * + VMStateField.num_indirect
-     * contains the number of entries in the array. See the VMS_ARRAY
-     * description regarding array handling in general. May not be
-     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
-    VMS_VARRAY_UINT16    = 0x080,
-
     /* The size of the individual entries (a single array entry if
-     * VMS_ARRAY or any of VMS_VARRAY* are set, or the field itself if
+     * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
      * neither is set) is variable (i.e. not known at compile-time),
      * but the same for all entries. Use the integer at opaque +
      * VMStateField.size_indirect (subject to VMS_MULTIPLY) to determine
@@ -128,20 +124,6 @@ enum VMStateFlags {
      * allocated. Only valid in combination with VMS_VBUFFER. */
     VMS_MULTIPLY         = 0x200,
 
-    /* The field is an array of variable size. The uint8_t at opaque +
-     * VMStateField.num_indirect
-     * contains the number of entries in the array. See the VMS_ARRAY
-     * description regarding array handling in general. May not be
-     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
-    VMS_VARRAY_UINT8     = 0x400,
-
-    /* The field is an array of variable size. The uint32_t at opaque
-     * + VMStateField.num_indirect
-     * contains the number of entries in the array. See the VMS_ARRAY
-     * description regarding array handling in general. May not be
-     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
-    VMS_VARRAY_UINT32    = 0x800,
-
     /* Fail loading the serialised VM state if this field is missing
      * from the input. */
     VMS_MUST_EXIST       = 0x1000,
@@ -530,7 +512,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_INT32|VMS_POINTER,                      \
+    .flags      = VMS_VARRAY | VMS_POINTER,                          \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -540,7 +522,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                     \
+    .flags      = VMS_VARRAY | VMS_POINTER,                          \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -550,7 +532,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_INT32 | VMS_POINTER | VMS_ALLOC,        \
+    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -560,7 +542,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_POINTER|VMS_ALLOC,           \
+    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -570,7 +552,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
+    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -580,7 +562,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT16,                                 \
+    .flags      = VMS_VARRAY,                                        \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -659,7 +641,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
+    .flags      = VMS_POINTER | VMS_VARRAY |                         \
                   VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
                   VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
@@ -672,7 +654,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),         \
     .vmsd       = &(_vmsd),                                           \
     .size       = sizeof(_type),                                      \
-    .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
+    .flags      = VMS_POINTER | VMS_VARRAY |                          \
                   VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
                   VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
@@ -683,7 +665,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                             \
     .num_indirect = vmstate_field_offset(_state, _field_num),             \
     .info       = &(_info),                                               \
-    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
+    .flags      = VMS_VARRAY | VMS_ARRAY_OF_POINTER | VMS_POINTER,        \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
@@ -727,7 +709,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_UINT8,                       \
+    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -750,7 +732,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
+    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -760,7 +742,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
+    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -770,7 +752,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY_UINT16 | VMS_STRUCT,      \
+    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -780,7 +762,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_UINT32,                      \
+    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -790,7 +772,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .vmsd       = &(_vmsd),                                          \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_INT32|VMS_ALLOC|VMS_POINTER, \
+    .flags      = VMS_STRUCT | VMS_VARRAY | VMS_ALLOC | VMS_POINTER, \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -915,7 +897,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id   = (_version),                                      \
     .size         = (_size),                                         \
     .info         = &vmstate_info_unused_buffer,                     \
-    .flags        = VMS_VARRAY_UINT32 | VMS_BUFFER,                  \
+    .flags        = VMS_VARRAY | VMS_BUFFER,                         \
 }
 
 /* _field_size should be a int32_t field in the _state struct giving the
diff --git a/migration/savevm.c b/migration/savevm.c
index e1b707dda63..3e5cce6520d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -884,11 +884,9 @@ static void vmstate_check(const VMStateDescription *vmsd)
                 }
                 /*
                  * VMS_ARRAY_OF_POINTER must be used only together with one
-                 * of VMS_(V)ARRAY* flags.
+                 * of VMS_(V)ARRAY flags.
                  */
-                assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
-                                       VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8 |
-                                       VMS_VARRAY_UINT32));
+                assert(field->flags & (VMS_ARRAY | VMS_VARRAY));
             }
 
             if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 372aed258f1..bc5285bcea2 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -101,8 +101,7 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
-    } else if (field->flags & (VMS_VARRAY_INT32 | VMS_VARRAY_UINT32
-                               | VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8)) {
+    } else if (field->flags & VMS_VARRAY) {
         n_elems = vmstate_read_from_offset(&field->num_indirect, opaque);
     }
 
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
index baa2730ca9d..c8397dc8974 100644
--- a/rust/bindings/migration-sys/lib.rs
+++ b/rust/bindings/migration-sys/lib.rs
@@ -57,12 +57,7 @@ pub trait VMStateFlagsExt {
 }
 
 impl VMStateFlagsExt for VMStateFlags {
-    const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
-        VMStateFlags::VMS_VARRAY_INT32.0
-            | VMStateFlags::VMS_VARRAY_UINT8.0
-            | VMStateFlags::VMS_VARRAY_UINT16.0
-            | VMStateFlags::VMS_VARRAY_UINT32.0,
-    );
+    const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(VMStateFlags::VMS_VARRAY.0);
 }
 
 // Add a couple builder-style methods to VMStateField, allowing
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index e60c0860cc5..4ec54097148 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -287,9 +287,9 @@ unsafe impl $crate::vmstate::VMState for $type {
 impl_vmstate_scalar!(vmstate_info_int16, i16);
 impl_vmstate_scalar!(vmstate_info_int32, i32);
 impl_vmstate_scalar!(vmstate_info_int64, i64);
-impl_vmstate_scalar!(vmstate_info_uint8, u8, VMS_VARRAY_UINT8);
-impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
-impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
+impl_vmstate_scalar!(vmstate_info_uint8, u8, VMS_VARRAY);
+impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY);
+impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY);
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
 impl_vmstate_scalar!(vmstate_info_timer, util::timer::Timer);
 
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index c002ffb2bc4..5f6dd8ae7f1 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -113,7 +113,7 @@ fn test_vmstate_varray_uint16_unsafe() {
     assert_eq!(foo_fields[2].version_id, 0);
     assert_eq!(foo_fields[2].size, 1);
     assert_eq!(foo_fields[2].num, 0);
-    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY_UINT16);
+    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY);
     assert!(foo_fields[2].vmsd.is_null());
     assert!(foo_fields[2].field_exists.is_none());
 }
@@ -222,7 +222,7 @@ fn test_vmstate_struct_varray_uint8() {
     assert_eq!(foo_fields[2].num, 0);
     assert_eq!(
         foo_fields[2].flags.0,
-        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY_UINT8.0
+        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY.0
     );
     assert_eq!(foo_fields[2].vmsd, VMSTATE_FOOA.as_ref());
     assert!(foo_fields[2].field_exists.is_none());
-- 
2.53.0


