Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CB3C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDBE-0002fM-9q; Wed, 29 Jul 2026 18:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpDBC-0002f6-Eu
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:55:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpDB9-00047v-8x
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:55:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0E5E7CD3D;
 Wed, 29 Jul 2026 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785365568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyklkPx2ViyV3piAWBpC9GUIpLr53m89qDGL4pJzm1I=;
 b=nEGIQ7o0jTZGvkJuzOq2j7NVmqdXMBD4PscOqA6DUMsoDjzX3yyS7nO7CDQa7pE7Pcc2Vr
 8Pf9zchbNuBsTnkT/Dyx+BrQ2S6Ael4Xhz7wVUsOlE9xLYzum4HS6CbU7LuJjiTKSpNGf5
 L/AYg3G/xNB/j7W8nCDNvNpgUq3QhEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785365568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyklkPx2ViyV3piAWBpC9GUIpLr53m89qDGL4pJzm1I=;
 b=KvkLzaMHjUB5BUStd4zAbvgUke1p9qa+odSplX3rj5g4+ig8NSmkfHf3m35btpV2C0mhKz
 P7pCJ020GSpLb9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785365563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyklkPx2ViyV3piAWBpC9GUIpLr53m89qDGL4pJzm1I=;
 b=SHOO2WgYN8vqNHCvdrM7IIR5L7CXRB/utFdZlU8933TNKO+mXu1MQ2xNzC3/mdSnyoJlv/
 cCl4E6rH3CvWUgeR8cjd/msQgkj3ICmgua6EmRiwozeVtbEal/z9WThMPlg7zo7hlLVaip
 mEjgbdMGbE8RFFeqw8iFUcesSLy0wHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785365563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyklkPx2ViyV3piAWBpC9GUIpLr53m89qDGL4pJzm1I=;
 b=jN9DgeBLDqKqifeBjujds0hJ4up/28MZGh/qg9BkucXU/NWenjnFTf8MYGLIQeV3mg/CAu
 juhefpGhm5o1QkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61515779B7;
 Wed, 29 Jul 2026 22:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wA7UDDqEamqHFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jul 2026 22:52:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 3/4] migration: Remove redundant flags
Date: Wed, 29 Jul 2026 19:52:26 -0300
Message-ID: <20260729225227.1170574-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729225227.1170574-1-farosas@suse.de>
References: <20260729225227.1170574-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Remove the VMS_VARRAY and VMS_VBUFFER flags that became redundant due
to the previous commit which stores the size of the vmstate offset
variables along with the offset itself.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h        | 76 ++++++++++++------------------
 migration/savevm.c                 |  6 +--
 migration/vmstate.c                |  3 +-
 rust/bindings/migration-sys/lib.rs | 15 ++++--
 rust/migration/src/vmstate.rs      | 30 ++++++++++--
 rust/tests/tests/vmstate_tests.rs  | 30 ++++++------
 6 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2ad3cc01371..c4fd036344d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -69,8 +69,9 @@ enum VMStateFlags {
      * }). Dereference the pointer before using it as basis for
      * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
      * affect the meaning of VMStateField.num_offset or
-     * VMStateField.size_offset; see VMS_VARRAY* and VMS_VBUFFER for
-     * those. */
+     * VMStateField.size_offset; see VMS_VARRAY and VMS_VBUFFER for
+     * those.
+     */
     VMS_POINTER          = 0x002,
 
     /* The field is an array of fixed size. VMStateField.num contains
@@ -80,21 +81,22 @@ enum VMStateFlags {
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
 
     /* The field is an array of variable size. The int32_t at opaque +
      * VMStateField.num_offset contains the number of entries in the
      * array. See the VMS_ARRAY description regarding array handling
-     * in general. May not be combined with VMS_ARRAY or any other
-     * VMS_VARRAY*. */
-    VMS_VARRAY_INT32     = 0x010,
+     * in general. May not be combined with VMS_ARRAY.
+     */
+    VMS_VARRAY     = 0x010,
 
     /* Ignored */
     VMS_BUFFER           = 0x020,
@@ -102,18 +104,12 @@ enum VMStateFlags {
     /* The field is a (fixed-size or variable-size) array of pointers
      * (e.g. struct a { uint8_t *b[]; }). Dereference each array entry
      * before using it. Note: Does not imply any one of VMS_ARRAY /
-     * VMS_VARRAY*; these need to be set explicitly. */
+     * VMS_VARRAY; these need to be set explicitly.
+     */
     VMS_ARRAY_OF_POINTER = 0x040,
 
-    /* The field is an array of variable size. The uint16_t at opaque
-     * + VMStateField.num_offset
-     * contains the number of entries in the array. See the VMS_ARRAY
-     * description regarding array handling in general. May not be
-     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
-    VMS_VARRAY_UINT16    = 0x080,
-
     /* The size of the individual entries (a single array entry if
-     * VMS_ARRAY or any of VMS_VARRAY* are set, or the field itself if
+     * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
      * neither is set) is variable (i.e. not known at compile-time),
      * but the same for all entries. Use the int32_t at opaque +
      * VMStateField.size_offset (subject to VMS_MULTIPLY) to determine
@@ -126,20 +122,6 @@ enum VMStateFlags {
      * allocated. Only valid in combination with VMS_VBUFFER. */
     VMS_MULTIPLY         = 0x200,
 
-    /* The field is an array of variable size. The uint8_t at opaque +
-     * VMStateField.num_offset
-     * contains the number of entries in the array. See the VMS_ARRAY
-     * description regarding array handling in general. May not be
-     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
-    VMS_VARRAY_UINT8     = 0x400,
-
-    /* The field is an array of variable size. The uint32_t at opaque
-     * + VMStateField.num_offset
-     * contains the number of entries in the array. See the VMS_ARRAY
-     * description regarding array handling in general. May not be
-     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
-    VMS_VARRAY_UINT32    = 0x800,
-
     /* Fail loading the serialised VM state if this field is missing
      * from the input. */
     VMS_MUST_EXIST       = 0x1000,
@@ -473,7 +455,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_INT32|VMS_POINTER,                      \
+    .flags      = VMS_VARRAY | VMS_POINTER,                          \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -483,7 +465,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                     \
+    .flags      = VMS_VARRAY | VMS_POINTER,                          \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -493,7 +475,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_INT32 | VMS_POINTER | VMS_ALLOC,        \
+    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -503,7 +485,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_POINTER|VMS_ALLOC,           \
+    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -513,7 +495,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
+    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -523,7 +505,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT16,                                 \
+    .flags      = VMS_VARRAY,                                        \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -602,7 +584,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
+    .flags      = VMS_POINTER | VMS_VARRAY |                         \
                   VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
                   VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
@@ -615,7 +597,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),           \
     .vmsd       = &(_vmsd),                                           \
     .size       = sizeof(_type),                                      \
-    .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
+    .flags      = VMS_POINTER | VMS_VARRAY |                          \
                   VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
                   VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
@@ -626,7 +608,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                             \
     .num_offset = vmstate_field_offset(_state, _field_num),               \
     .info       = &(_info),                                               \
-    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
+    .flags      = VMS_VARRAY | VMS_ARRAY_OF_POINTER | VMS_POINTER,        \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
@@ -670,7 +652,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_UINT8,                       \
+    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -693,7 +675,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
+    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -703,7 +685,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
+    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -713,7 +695,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .size       = sizeof(_type),                                     \
     .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY_UINT16 | VMS_STRUCT,      \
+    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -723,7 +705,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_INT32,                       \
+    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -733,7 +715,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_UINT32,                      \
+    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
@@ -743,7 +725,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .vmsd       = &(_vmsd),                                          \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_INT32|VMS_ALLOC|VMS_POINTER, \
+    .flags      = VMS_STRUCT | VMS_VARRAY | VMS_ALLOC | VMS_POINTER, \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
@@ -868,7 +850,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id   = (_version),                                      \
     .size         = (_size),                                         \
     .info         = &vmstate_info_unused_buffer,                     \
-    .flags        = VMS_VARRAY_UINT32 | VMS_BUFFER,                  \
+    .flags        = VMS_VARRAY | VMS_BUFFER,                         \
 }
 
 /* _field_size should be a int32_t field in the _state struct giving the
diff --git a/migration/savevm.c b/migration/savevm.c
index a272bcfd0b4..0b4fbfc72bb 100644
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
index 0a0b9faa20e..bc8eb3d3ca6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -102,8 +102,7 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
-    } else if (field->flags & (VMS_VARRAY_INT32 | VMS_VARRAY_UINT32
-                               | VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8)) {
+    } else if (field->flags & VMS_VARRAY) {
         n_elems = vmstate_read_from_offset(opaque, &field->num_offset);
     }
 
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
index 9581481e421..75b8c1387c2 100644
--- a/rust/bindings/migration-sys/lib.rs
+++ b/rust/bindings/migration-sys/lib.rs
@@ -47,6 +47,7 @@ fn default() -> Self {
 unsafe impl Zeroable for VMStateFlags {}
 unsafe impl Zeroable for VMStateField {}
 unsafe impl Zeroable for VMStateDescription {}
+unsafe impl Zeroable for VMStateOffset {}
 
 // The following higher-level helpers could be in "migration"
 // crate when Rust has const trait impl.
@@ -57,10 +58,7 @@ pub trait VMStateFlagsExt {
 
 impl VMStateFlagsExt for VMStateFlags {
     const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
-        VMStateFlags::VMS_VARRAY_INT32.0
-            | VMStateFlags::VMS_VARRAY_UINT8.0
-            | VMStateFlags::VMS_VARRAY_UINT16.0
-            | VMStateFlags::VMS_VARRAY_UINT32.0,
+        VMStateFlags::VMS_VARRAY.0
     );
 }
 
@@ -115,3 +113,12 @@ pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
         self.with_varray_flag_unchecked(flag)
     }
 }
+
+impl VMStateOffset {
+    pub const fn new(off: usize, size: usize) -> Self {
+        Self {
+            off: off as u32,
+            size: size as u8,
+        }
+    }
+}
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 63d78b4f275..7023ebd2c22 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -42,7 +42,7 @@
 };
 
 use crate::bindings::{self, VMStateFlags};
-pub use crate::bindings::{MigrationPriority, VMStateField};
+pub use crate::bindings::{MigrationPriority, VMStateField, VMStateOffset};
 
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
+            $(num_offset: $crate::vmstate::VMStateOffset {
+                off: ::std::mem::offset_of!($struct_name, $($num).+) as u32,
+		size: $crate::size_of_field_type!($struct_name, $($num).+) as u8,
+            },)?
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
@@ -267,9 +287,9 @@ unsafe impl $crate::vmstate::VMState for $type {
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
index c2c12cfab52..c5baed4d40b 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -65,7 +65,7 @@ fn test_vmstate_uint16() {
         b"elem\0"
     );
     assert_eq!(foo_fields[0].offset, 16);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_offset.size, 0);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int8 });
     assert_eq!(foo_fields[0].version_id, 0);
     assert_eq!(foo_fields[0].size, 1);
@@ -86,7 +86,7 @@ fn test_vmstate_unused() {
         b"unused\0"
     );
     assert_eq!(foo_fields[1].offset, 0);
-    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].num_offset.size, 0);
     assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_unused_buffer });
     assert_eq!(foo_fields[1].version_id, 0);
     assert_eq!(foo_fields[1].size, 8);
@@ -108,12 +108,12 @@ fn test_vmstate_varray_uint16_unsafe() {
         b"arr\0"
     );
     assert_eq!(foo_fields[2].offset, 0);
-    assert_eq!(foo_fields[2].num_offset, 4);
+    assert_eq!(foo_fields[2].num_offset.off, 4);
     assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[2].version_id, 0);
     assert_eq!(foo_fields[2].size, 1);
     assert_eq!(foo_fields[2].num, 0);
-    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY_UINT16);
+    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY);
     assert!(foo_fields[2].vmsd.is_null());
     assert!(foo_fields[2].field_exists.is_none());
 }
@@ -172,7 +172,7 @@ fn test_vmstate_bool_v() {
         b"val\0"
     );
     assert_eq!(foo_fields[0].offset, 136);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_offset.size, 0);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_bool });
     assert_eq!(foo_fields[0].version_id, 2);
     assert_eq!(foo_fields[0].size, 1);
@@ -193,7 +193,7 @@ fn test_vmstate_uint64() {
         b"wrap\0"
     );
     assert_eq!(foo_fields[1].offset, 128);
-    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].num_offset.size, 0);
     assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_uint64 });
     assert_eq!(foo_fields[1].version_id, 0);
     assert_eq!(foo_fields[1].size, 8);
@@ -215,14 +215,14 @@ fn test_vmstate_struct_varray_uint8() {
         b"arr_a\0"
     );
     assert_eq!(foo_fields[2].offset, 0);
-    assert_eq!(foo_fields[2].num_offset, 60);
+    assert_eq!(foo_fields[2].num_offset.off, 60);
     assert!(foo_fields[2].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
     assert_eq!(foo_fields[2].version_id, 1);
     assert_eq!(foo_fields[2].size, 20);
     assert_eq!(foo_fields[2].num, 0);
     assert_eq!(
         foo_fields[2].flags.0,
-        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY_UINT8.0
+        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY.0
     );
     assert_eq!(foo_fields[2].vmsd, VMSTATE_FOOA.as_ref());
     assert!(foo_fields[2].field_exists.is_none());
@@ -240,7 +240,7 @@ fn test_vmstate_macro_array() {
         b"arr_i64\0"
     );
     assert_eq!(foo_fields[4].offset, 144);
-    assert_eq!(foo_fields[4].num_offset, 0);
+    assert_eq!(foo_fields[4].num_offset.size, 0);
     assert_eq!(foo_fields[4].info, unsafe { &vmstate_info_int64 });
     assert_eq!(foo_fields[4].version_id, 0);
     assert_eq!(foo_fields[4].size, 8);
@@ -264,7 +264,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
         unsafe { CStr::from_ptr(foo_fields[5].name) }.to_bytes_with_nul(),
         b"arr_a_wrap\0"
     );
-    assert_eq!(foo_fields[5].num_offset, 228);
+    assert_eq!(foo_fields[5].num_offset.off, 228);
     assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0) });
 
     // The last VMStateField in VMSTATE_FOOB.
@@ -316,7 +316,7 @@ fn test_vmstate_pointer() {
         b"ptr\0"
     );
     assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_offset.size, 0);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int32 });
     assert_eq!(foo_fields[0].version_id, 2);
     assert_eq!(foo_fields[0].size, 4);
@@ -341,7 +341,7 @@ fn test_vmstate_struct_pointer() {
         b"ptr_a\0"
     );
     assert_eq!(foo_fields[1].offset, PTR_SIZE);
-    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].num_offset.size, 0);
     assert_eq!(foo_fields[1].vmsd, VMSTATE_FOOA.as_ref());
     assert_eq!(foo_fields[1].version_id, 0);
     assert_eq!(foo_fields[1].size, size_of::<FooA>());
@@ -366,7 +366,7 @@ fn test_vmstate_macro_array_of_pointer() {
         b"arr_ptr\0"
     );
     assert_eq!(foo_fields[2].offset, 2 * PTR_SIZE);
-    assert_eq!(foo_fields[2].num_offset, 0);
+    assert_eq!(foo_fields[2].num_offset.size, 0);
     assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[2].version_id, 0);
     assert_eq!(foo_fields[2].size, PTR_SIZE);
@@ -391,7 +391,7 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
         b"arr_ptr_wrap\0"
     );
     assert_eq!(foo_fields[3].offset, (FOO_ARRAY_MAX + 2) * PTR_SIZE);
-    assert_eq!(foo_fields[3].num_offset, 0);
+    assert_eq!(foo_fields[3].num_offset.size, 0);
     assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[3].version_id, 0);
     assert_eq!(foo_fields[3].size, PTR_SIZE);
@@ -454,7 +454,7 @@ fn test_vmstate_validate() {
         b"foo_d_0\0"
     );
     assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].num_offset.size, 0);
     assert!(foo_fields[0].info.is_null());
     assert_eq!(foo_fields[0].version_id, 0);
     assert_eq!(foo_fields[0].size, 0);
-- 
2.53.0


