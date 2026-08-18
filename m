Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672C1C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUs-00087b-O5; Tue, 18 Aug 2026 14:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUp-00083e-0n
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUm-0003B2-IB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2807B846BB;
 Tue, 18 Aug 2026 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sHt0NatwhLlnSWyxTBxDTi3HoA48Mx9LVOofzGh7Cc=;
 b=pd7UsquuaxrLN9liqaNj2UCmpDrV3UFjNMNlc03IfsN5GmY95TSHyLRZmkdqYGJszAJ/fc
 ponQovPOdujN8ynZslOPTEhfRp/XlLmUqBT0Adl7uP0Kkg1K4zaGGCaOof7bXkxHE+GIpJ
 Ba1b/K6gcX2mlBw1bYutqKKwYkTGnGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sHt0NatwhLlnSWyxTBxDTi3HoA48Mx9LVOofzGh7Cc=;
 b=4rsGO8v3y5rpy8CKn8kGUCFT/XDg7zxNYnb72VOywyhQQR/pICMsUttR7UoGH31gg3xZKI
 460aTRpSKUt/YnDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hVsJItC2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qLRoC1pe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sHt0NatwhLlnSWyxTBxDTi3HoA48Mx9LVOofzGh7Cc=;
 b=hVsJItC2Au8BScLRXswzt4hZU20T/8MV0crr9D71fnY3Tv+YmLhAdYT+EGAquIxTjFVDIE
 aouAHPpEnQG43HgMbenjq7yREdKC8xlPizkEoAXf7A8gwJ2Rd1car7IoYn5xmSTd8Kvt45
 ojniThb23f8wcxfDatcutoksRRbrKTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sHt0NatwhLlnSWyxTBxDTi3HoA48Mx9LVOofzGh7Cc=;
 b=qLRoC1pe3a2Ea7TdyTVbqSEAMGLuRXzE7khwnG9KkkulzgAHW3IspsPVHjoW647IlYDEkT
 Okd2iyf3EvQstJAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C900C367A;
 Tue, 18 Aug 2026 18:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KNUiJnejhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:24:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 4/8] migration: Remove duplicate vmstate macros
Date: Tue, 18 Aug 2026 15:24:37 -0300
Message-ID: <20260818182441.404790-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2807B846BB
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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


