Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAA1C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzd-0001ew-Lc; Fri, 28 Aug 2026 11:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzb-0001dv-FG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzP-000052-Bv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B979122293;
 Fri, 28 Aug 2026 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+k6wT9dlIGPFseuREKh7ReD8czK6BKywdzvBqkErBQ=;
 b=0HK5s9V7ZT6nBSgZ9Ekxj2L0Ww569jDdHIBjbCIf+PYuXcEmGLt7UmNzcxijhXuTDCtDdN
 FzmZWR4itM4Acq6Y5b1MyiYSGcsXguoI8ew3y4gGfJ0TT2KTZyiDa/en5ccCW2tHZ2eEfM
 bsbHeVZR2TMVPiA7kp8iZzPSoCRWTFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+k6wT9dlIGPFseuREKh7ReD8czK6BKywdzvBqkErBQ=;
 b=hYB1qGz1MFIGlZM32s3fVHWAPL1uBlsJ1d1pQ9B4gMMBxAa4z+QSzMqeUaL8QtpdqcPUe3
 Zj63HXuDuPoLR8DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1qRo2LG/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FKDRe+Ts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+k6wT9dlIGPFseuREKh7ReD8czK6BKywdzvBqkErBQ=;
 b=1qRo2LG/sVBQBjHJeWvr7SyRztNT9erct1q8AeV4zIfHH1fkSvxvnxWoAYFcBszrDc+4ev
 eWi1Obi2Z0qh7x9yVpk7T8gXtPdkAkKaANU93AhwWfuTDNPganF73kkEyBaV3pIqaGttop
 R8pW4Nf57QQbdZrc/CiUivIakQr4+Do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+k6wT9dlIGPFseuREKh7ReD8czK6BKywdzvBqkErBQ=;
 b=FKDRe+TsR34rtFhVbrZuBnOSg4aLjjr24UQkedpCTNll4t9q5JmNHdCndzMNE8dhZC1sIx
 GP2HVEinlpREMcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD52413675;
 Fri, 28 Aug 2026 15:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iB4LK1mwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL v2 25/30] migration: Remove duplicate vmstate macros
Date: Fri, 28 Aug 2026 12:58:40 -0300
Message-ID: <20260828155845.2874508-26-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B979122293
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
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

Now that type-checking is not being done per integer size anymore,
various macros have duplicated bodies. Remove them.

The original names are left the same so the device code can be altered
per-subsystem in the next patches.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 135 ++++++++++++------------------------
 1 file changed, 44 insertions(+), 91 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a168651a062..4b6d52955ff 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -506,7 +506,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_sub_array(_state, _field, _type, _start), \
 }
 
-#define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
+#define VMSTATE_VARRAY(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
@@ -516,17 +516,11 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
-#define VMSTATE_VARRAY_UINT32(_field, _state, _field_num, _version, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .num_indirect = vmstate_field_offset(_state, _field_num),        \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY | VMS_POINTER,                          \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
+#define VMSTATE_VARRAY_INT32 VMSTATE_VARRAY
+#define VMSTATE_VARRAY_UINT32 VMSTATE_VARRAY
 
-#define VMSTATE_VARRAY_INT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
+#define VMSTATE_VARRAY_ALLOC(_field, _state, _field_num, _version, _info, \
+                             _type) {                                   \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
@@ -536,27 +530,12 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
-#define VMSTATE_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .num_indirect = vmstate_field_offset(_state, _field_num),        \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
-
-#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .num_indirect = vmstate_field_offset(_state, _field_num),        \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY | VMS_POINTER | VMS_ALLOC,              \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
+#define VMSTATE_VARRAY_INT32_ALLOC VMSTATE_VARRAY_ALLOC
+#define VMSTATE_VARRAY_UINT32_ALLOC VMSTATE_VARRAY_ALLOC
+#define VMSTATE_VARRAY_UINT16_ALLOC VMSTATE_VARRAY_ALLOC
 
-#define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _version, _info, _type) {\
+#define VMSTATE_VARRAY_UNSAFE(_field, _state, _field_num, _version, _info, \
+                              _type) {                                  \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
@@ -566,6 +545,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
+#define VMSTATE_VARRAY_UINT16_UNSAFE VMSTATE_VARRAY_UNSAFE
+
 #define VMSTATE_VSTRUCT_TEST(_field, _state, _test, _version, _vmsd, _type, _struct_version) { \
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
@@ -634,7 +615,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
  * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
  * start: size of (_type) pointed to (for auto memory allocation)
  */
-#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(\
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC( \
     _field, _state, _field_num, _version, _vmsd, _type) {            \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
@@ -647,20 +628,13 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
 }
 
-#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(\
-    _field, _state, _field_num, _version, _vmsd, _type) {             \
-    .name       = (stringify(_field)),                                \
-    .version_id = (_version),                                         \
-    .num_indirect = vmstate_field_offset(_state, _field_num),         \
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
+#define VMSTATE_VARRAY_OF_POINTER(_field, _state, _field_num, _version, _info, \
+                                  _type) {                              \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
     .num_indirect = vmstate_field_offset(_state, _field_num),             \
@@ -669,6 +643,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
+#define VMSTATE_VARRAY_OF_POINTER_UINT32 VMSTATE_VARRAY_OF_POINTER
+
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                                     \
     .version_id = (_version),                                              \
@@ -703,7 +679,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
                                            _n1, _n2),                \
 }
 
-#define VMSTATE_STRUCT_VARRAY_UINT8(_field, _state, _field_num, _version, _vmsd, _type) { \
+#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vmsd, \
+                              _type) {                                  \
     .name       = (stringify(_field)),                               \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .version_id = (_version),                                        \
@@ -712,6 +689,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
+#define VMSTATE_STRUCT_VARRAY_UINT8 VMSTATE_STRUCT_VARRAY
 
 /* a variable length array (i.e. _type *_field) but we know the
  * length
@@ -726,7 +704,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = offsetof(_state, _field),                          \
 }
 
-#define VMSTATE_STRUCT_VARRAY_POINTER_INT32(_field, _state, _field_num, _vmsd, _type) { \
+#define VMSTATE_STRUCT_VARRAY_POINTER(_field, _state, _field_num, _vmsd, \
+                                      _type) {                          \
     .name       = (stringify(_field)),                               \
     .version_id = 0,                                                 \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
@@ -735,28 +714,12 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
+#define VMSTATE_STRUCT_VARRAY_POINTER_INT32 VMSTATE_STRUCT_VARRAY_POINTER
+#define VMSTATE_STRUCT_VARRAY_POINTER_UINT32 VMSTATE_STRUCT_VARRAY_POINTER
+#define VMSTATE_STRUCT_VARRAY_POINTER_UINT16 VMSTATE_STRUCT_VARRAY_POINTER
 
-#define VMSTATE_STRUCT_VARRAY_POINTER_UINT32(_field, _state, _field_num, _vmsd, _type) { \
-    .name       = (stringify(_field)),                               \
-    .version_id = 0,                                                 \
-    .num_indirect = vmstate_field_offset(_state, _field_num),        \
-    .size       = sizeof(_type),                                     \
-    .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
-
-#define VMSTATE_STRUCT_VARRAY_POINTER_UINT16(_field, _state, _field_num, _vmsd, _type) { \
-    .name       = (stringify(_field)),                               \
-    .version_id = 0,                                                 \
-    .num_indirect = vmstate_field_offset(_state, _field_num),        \
-    .size       = sizeof(_type),                                     \
-    .vmsd       = &(_vmsd),                                          \
-    .flags      = VMS_POINTER | VMS_VARRAY | VMS_STRUCT,             \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
-}
-
-#define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
+#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vmsd, \
+                              _type) {                                  \
     .name       = (stringify(_field)),                               \
     .num_indirect = vmstate_field_offset(_state, _field_num),        \
     .version_id = (_version),                                        \
@@ -765,8 +728,11 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags      = VMS_STRUCT | VMS_VARRAY,                           \
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
+#define VMSTATE_STRUCT_VARRAY_INT32 VMSTATE_STRUCT_VARRAY
+#define VMSTATE_STRUCT_VARRAY_UINT32 VMSTATE_STRUCT_VARRAY
 
-#define VMSTATE_STRUCT_VARRAY_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) {\
+#define VMSTATE_STRUCT_VARRAY_ALLOC(_field, _state, _field_num, _version, \
+                                    _vmsd, _type) {                     \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
     .vmsd       = &(_vmsd),                                          \
@@ -808,28 +774,11 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset       = offsetof(_state, _field),                        \
 }
 
-#define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, _field_size) { \
-    .name         = (stringify(_field)),                             \
-    .version_id   = (_version),                                      \
-    .field_exists = (_test),                                         \
-    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
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
-    .size_indirect  = vmstate_field_offset(_state, _field_size),     \
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
@@ -839,6 +788,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset       = offsetof(_state, _field),                        \
 }
 
+#define VMSTATE_VBUFFER_ALLOC_UINT32 VMSTATE_VBUFFER_ALLOC
+
 #define VMSTATE_BUFFER_UNSAFE_INFO_TEST(_field, _state, _test, _version, _info, _size) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
@@ -890,7 +841,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 }
 
 /* Discard size * field_num bytes, where field_num is a uint32 member */
-#define VMSTATE_UNUSED_VARRAY_UINT32(_state, _test, _version, _field_num, _size) {\
+#define VMSTATE_UNUSED_VARRAY(_state, _test, _version, _field_num, _size) {\
     .name         = "unused",                                        \
     .field_exists = (_test),                                         \
     .num_indirect   = vmstate_field_offset(_state, _field_num),      \
@@ -900,6 +851,8 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .flags        = VMS_VARRAY | VMS_BUFFER,                         \
 }
 
+#define VMSTATE_UNUSED_VARRAY_UINT32 VMSTATE_UNUSED_VARRAY
+
 /* _field_size should be a int32_t field in the _state struct giving the
  * size of the bitmap _field in bits.
  */
-- 
2.53.0


