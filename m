Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE124C55164
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDAx-0002V3-SO; Wed, 29 Jul 2026 18:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpDAw-0002Uu-5B
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:54:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpDAt-0003uB-SF
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:54:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B6733E01;
 Wed, 29 Jul 2026 22:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785365569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdtdeNXBikH2S9GAny8nlHj8GAbM/kbRKfPkOJJo0SA=;
 b=IFkJ0/jX0zEfedS66mbBT9sKZK2IoD4takZJFx1zvCsIBdio458jPdQ7bAAiLf46dizDDS
 d50961nB5KDvBNFmJf8Qx4PzlzV3R+03tu9GB6KTQHQ0rUSPFLYO6ZVrmPxB54o+rMdFQu
 +dOdkSjVSSxWxqAjC+xCxrEalbJJ5lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785365569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdtdeNXBikH2S9GAny8nlHj8GAbM/kbRKfPkOJJo0SA=;
 b=tE5bobGl03zl/c7B6x9YgGlSPvF3d00RMgFrGRUdfY7ODyAQSX8L7WEPT8nBTS79pbfwyl
 p5IKKAuFroQci+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785365565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdtdeNXBikH2S9GAny8nlHj8GAbM/kbRKfPkOJJo0SA=;
 b=xY3RAjfISEkhDkMldsk4J5QuGsPoJZsmy0Ar9ypf9s7UJ3yTFVdUrpWJnKLMVn6Sojviih
 LwwwLuew60a268asAXBBxjncjF9XjTk1KP+5WPgXdgeasF0nCFjlFAL6/4mOlWb2Enm9Db
 WVpb309VglLVedjAmMqxUnj7+Z9EQ+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785365565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdtdeNXBikH2S9GAny8nlHj8GAbM/kbRKfPkOJJo0SA=;
 b=8HFPfVR4HqH1lVTjCIcJ4be+Zpzx+zEU+Jl50pSA1edVzfefA4uG7xcXkkZfkDCVtYrV1H
 S7bKboSfjgh/myDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 467FC779B9;
 Wed, 29 Jul 2026 22:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2NgvBjyEamqHFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jul 2026 22:52:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH 4/4] migration: Remove duplicate vmstate macros
Date: Wed, 29 Jul 2026 19:52:27 -0300
Message-ID: <20260729225227.1170574-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729225227.1170574-1-farosas@suse.de>
References: <20260729225227.1170574-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.987];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

Now that type-checking is not being done per integer size anymore,
various macros have duplicated bodies. Remove them.

The original names are left the same so the device code can be altered
per-subsystem in the next patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 136 ++++++++++--------------------------
 1 file changed, 36 insertions(+), 100 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index c4fd036344d..24631fd6782 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -449,7 +449,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_sub_array(_state, _field, _type, _start), \
 }
 
-#define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
+#define VMSTATE_VARRAY(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
@@ -459,17 +459,10 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
-#define VMSTATE_VARRAY_UINT32(_field, _state, _field_num, _version, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .num_offset = vmstate_field_offset(_state, _field_num),          \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY | VMS_POINTER,                          \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
+#define VMSTATE_VARRAY_INT32 VMSTATE_VARRAY
+#define VMSTATE_VARRAY_UINT32 VMSTATE_VARRAY
 
-#define VMSTATE_VARRAY_INT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
+#define VMSTATE_VARRAY_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
@@ -479,27 +472,11 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
-#define VMSTATE_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .num_offset = vmstate_field_offset(_state, _field_num),          \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
-
-#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .num_offset = vmstate_field_offset(_state, _field_num),          \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
+#define VMSTATE_VARRAY_INT32_ALLOC VMSTATE_VARRAY_ALLOC
+#define VMSTATE_VARRAY_UINT32_ALLOC VMSTATE_VARRAY_ALLOC
+#define VMSTATE_VARRAY_UINT16_ALLOC VMSTATE_VARRAY_ALLOC
 
-#define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _version, _info, _type) {\
+#define VMSTATE_VARRAY_UNSAFE(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
@@ -509,6 +486,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
+#define VMSTATE_VARRAY_UINT16_UNSAFE VMSTATE_VARRAY_UNSAFE
+
 #define VMSTATE_VSTRUCT_TEST(_field, _state, _test, _version, _vmsd, _type, _struct_version) { \
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
@@ -577,7 +556,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
  * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
  * start: size of (_type) pointed to (for auto memory allocation)
  */
-#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(\
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC( \
     _field, _state, _field_num, _version, _vmsd, _type) {            \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
@@ -590,20 +569,12 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
 }
 
-#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(\
-    _field, _state, _field_num, _version, _vmsd, _type) {             \
-    .name       = (stringify(_field)),                                \
-    .version_id = (_version),                                         \
-    .num_offset = vmstate_field_offset(_state, _field_num),           \
-    .vmsd       = &(_vmsd),                                           \
-    .size       = sizeof(_type),                                      \
-    .flags      = VMS_POINTER | VMS_VARRAY |                          \
-                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
-                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
-    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
-}
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC \
+    VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC \
+    VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
 
-#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
+#define VMSTATE_VARRAY_OF_POINTER(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
     .num_offset = vmstate_field_offset(_state, _field_num),               \
@@ -612,6 +583,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
+#define VMSTATE_VARRAY_OF_POINTER_UINT32 VMSTATE_VARRAY_OF_POINTER
+
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                                     \
     .version_id = (_version),                                              \
@@ -646,7 +619,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
                                            _n1, _n2),                \
 }
 
-#define VMSTATE_STRUCT_VARRAY_UINT8(_field, _state, _field_num, _version, _vmsd, _type) { \
+#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .version_id = (_version),                                        \
@@ -655,6 +628,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
+#define VMSTATE_STRUCT_VARRAY_UINT8 VMSTATE_STRUCT_VARRAY
 
 /* a variable length array (i.e. _type *_field) but we know the
  * length
@@ -669,7 +643,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = offsetof(_state, _field),                          \
 }
 
-#define VMSTATE_STRUCT_VARRAY_POINTER_INT32(_field, _state, _field_num, _vmsd, _type) { \
+#define VMSTATE_STRUCT_VARRAY_POINTER(_field, _state, _field_num, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = 0,                                                 \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
@@ -678,38 +652,11 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
+#define VMSTATE_STRUCT_VARRAY_POINTER_INT32 VMSTATE_STRUCT_VARRAY_POINTER
+#define VMSTATE_STRUCT_VARRAY_POINTER_UINT32 VMSTATE_STRUCT_VARRAY_POINTER
+#define VMSTATE_STRUCT_VARRAY_POINTER_UINT16 VMSTATE_STRUCT_VARRAY_POINTER
 
-#define VMSTATE_STRUCT_VARRAY_POINTER_UINT32(_field, _state, _field_num, _vmsd, _type) { \
-    .name       = (stringify(_field)),                               \
-    .version_id = 0,                                                 \
-    .num_offset = vmstate_field_offset(_state, _field_num),          \
-    .size       = sizeof(_type),                                     \
-    .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
-
-#define VMSTATE_STRUCT_VARRAY_POINTER_UINT16(_field, _state, _field_num, _vmsd, _type) { \
-    .name       = (stringify(_field)),                               \
-    .version_id = 0,                                                 \
-    .num_offset = vmstate_field_offset(_state, _field_num),          \
-    .size       = sizeof(_type),                                     \
-    .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
-
-#define VMSTATE_STRUCT_VARRAY_INT32(_field, _state, _field_num, _version, _vmsd, _type) { \
-    .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_field_offset(_state, _field_num, int32_t), \
-    .version_id = (_version),                                        \
-    .vmsd       = &(_vmsd),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
-
-#define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
+#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .num_offset = vmstate_field_offset(_state, _field_num),          \
     .version_id = (_version),                                        \
@@ -718,6 +665,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
+#define VMSTATE_STRUCT_VARRAY_INT32 VMSTATE_STRUCT_VARRAY
+#define VMSTATE_STRUCT_VARRAY_UINT32 VMSTATE_STRUCT_VARRAY
 
 #define VMSTATE_STRUCT_VARRAY_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) {\
     .name       = (stringify(_field)),                               \
@@ -761,28 +710,11 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset       = offsetof(_state, _field),                        \
 }
 
-#define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, _field_size) { \
-    .name         = (stringify(_field)),                             \
-    .version_id   = (_version),                                      \
-    .field_exists = (_test),                                         \
-    .size_offset  = vmstate_field_offset(_state, _field_size),       \
-    .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
-    .offset       = offsetof(_state, _field),                        \
-}
+#define VMSTATE_VBUFFER_UINT32 VMSTATE_VBUFFER
+#define VMSTATE_VBUFFER_UINT64 VMSTATE_VBUFFER
 
-#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
-    .name         = (stringify(_field)),                             \
-    .version_id   = (_version),                                      \
-    .field_exists = (_test),                                         \
-    .size_offset  = vmstate_field_offset(_state, _field_size),       \
-    .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
-    .offset       = offsetof(_state, _field),                        \
-}
-
-#define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
-                                     _test, _field_size) {           \
+#define VMSTATE_VBUFFER_ALLOC(_field, _state, _version,              \
+                              _test, _field_size) {                  \
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
@@ -792,6 +724,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset       = offsetof(_state, _field),                        \
 }
 
+#define VMSTATE_VBUFFER_ALLOC_UINT32 VMSTATE_VBUFFER_ALLOC
+
 #define VMSTATE_BUFFER_UNSAFE_INFO_TEST(_field, _state, _test, _version, _info, _size) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
@@ -843,7 +777,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 }
 
 /* Discard size * field_num bytes, where field_num is a uint32 member */
-#define VMSTATE_UNUSED_VARRAY_UINT32(_state, _test, _version, _field_num, _size) {\
+#define VMSTATE_UNUSED_VARRAY(_state, _test, _version, _field_num, _size) {\
     .name         = "unused",                                        \
     .field_exists = (_test),                                         \
     .num_offset   = vmstate_field_offset(_state, _field_num),        \
@@ -853,6 +787,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags        = VMS_VARRAY | VMS_BUFFER,                         \
 }
 
+#define VMSTATE_UNUSED_VARRAY_UINT32 VMSTATE_UNUSED_VARRAY
+
 /* _field_size should be a int32_t field in the _state struct giving the
  * size of the bitmap _field in bits.
  */
-- 
2.53.0


