Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4411C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUh-0007yN-RF; Tue, 18 Aug 2026 14:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUg-0007xv-I4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:02 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUe-0002yy-Pf
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33880846B9;
 Tue, 18 Aug 2026 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3V/PR/3rZ16t+TPz1hsj/IbhHxe06d9rOuvrnFpHuk=;
 b=O0inj6KFNOcUgq9C/aCX/qtBYmldRyyf6USO3i/xs0ZPy01Afd5axdJ7rUl5l1GkmI6CAT
 kV38uThCwDQBG9rgcz8W3eGk9Jl2CF7+/YaAuyqqhr2ZIwqPgK5LZ0EwwsPWzcOsOoq6O/
 8Ae/4FuS9KtcpA9Q3tRv92heiqWwPew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3V/PR/3rZ16t+TPz1hsj/IbhHxe06d9rOuvrnFpHuk=;
 b=GEUXkjE6yZzjSlf84Puu9wiZWTnfgdHra5C2+GfycXdIUZWYQdqR30pRf/Yt0nyrfSQcws
 fNRkni9+jk6+WTCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bhLeGBhJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="6cf/oYya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3V/PR/3rZ16t+TPz1hsj/IbhHxe06d9rOuvrnFpHuk=;
 b=bhLeGBhJBqOeo/FjujGa0rKvY+87h+zpC/CHyauvkC0EzhlxPMTEQ8g9YeIZ0XpBQc1V8o
 Tmx2y52AQ91OhD3nw77EgTzDQQr1bZwU27IRUQMg+vT64uKYeDCZW+YAXIs1h5BWjfWBGe
 L7ttUXX1asw6vJoDTmMpk5ZN0TyLaIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3V/PR/3rZ16t+TPz1hsj/IbhHxe06d9rOuvrnFpHuk=;
 b=6cf/oYyavGGu41eubXZ/6i6noppyHGbqiz4G9utyhI8Rp5gVpEv/oQjlIs4DqNpfiFz8Hl
 6nIdJv/iOfOS5cBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7E6D362E;
 Tue, 18 Aug 2026 18:24:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iCi8KXGjhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:24:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/8] migration: Remove unused vmstate macros
Date: Tue, 18 Aug 2026 15:24:34 -0300
Message-ID: <20260818182441.404790-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 33880846B9
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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

Remove the several vmstate macros that don't have any users.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 45 -------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1b7f295417e..214a2131350 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -451,15 +451,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_sub_array(_state, _field, _type, _start), \
 }
 
-#define VMSTATE_ARRAY_INT32_UNSAFE(_field, _state, _field_num, _info, _type) {\
-    .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_INT32,                                  \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
-
 #define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
@@ -710,16 +701,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
-#define VMSTATE_STRUCT_VARRAY_INT32(_field, _state, _field_num, _version, _vmsd, _type) { \
-    .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
-    .version_id = (_version),                                        \
-    .vmsd       = &(_vmsd),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT|VMS_VARRAY_INT32,                       \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
-
 #define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
@@ -1069,8 +1050,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 
 #ifdef CONFIG_LINUX
 
-#define VMSTATE_U8(_f, _s)                                         \
-    VMSTATE_U8_V(_f, _s, 0)
 #define VMSTATE_U16(_f, _s)                                        \
     VMSTATE_U16_V(_f, _s, 0)
 #define VMSTATE_U32(_f, _s)                                        \
@@ -1116,15 +1095,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_BOOL_TEST(_f, _s, _t)                               \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_bool, bool)
 
-#define VMSTATE_INT8_TEST(_f, _s, _t)                               \
-    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int8, int8_t)
-
-#define VMSTATE_INT16_TEST(_f, _s, _t)                               \
-    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int16, int16_t)
-
-#define VMSTATE_INT32_TEST(_f, _s, _t)                                  \
-    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int32, int32_t)
-
 #define VMSTATE_INT64_TEST(_f, _s, _t)                                  \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int64, int64_t)
 
@@ -1140,12 +1110,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_UINT64_TEST(_f, _s, _t)                                  \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_uint64, uint64_t)
 
-#define VMSTATE_FD_TEST(_f, _s, _t)                                            \
-    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_fd, int32_t)
-
-#define VMSTATE_TIMER_PTR_TEST(_f, _s, _test)                             \
-    VMSTATE_POINTER_TEST(_f, _s, _test, vmstate_info_timer, QEMUTimer *)
-
 #define VMSTATE_TIMER_PTR_V(_f, _s, _v)                                   \
     VMSTATE_POINTER(_f, _s, _v, vmstate_info_timer, QEMUTimer *)
 
@@ -1155,9 +1119,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
     VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer)
 
-#define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
-    VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
-
 #define VMSTATE_TIMER_V(_f, _s, _v)                                   \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_timer, QEMUTimer)
 
@@ -1275,12 +1236,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_BUFFER_START_MIDDLE(_f, _s, _start) \
     VMSTATE_BUFFER_START_MIDDLE_V(_f, _s, _start, 0)
 
-#define VMSTATE_PARTIAL_VBUFFER(_f, _s, _size)                        \
-    VMSTATE_VBUFFER(_f, _s, 0, NULL, _size)
-
-#define VMSTATE_PARTIAL_VBUFFER_UINT32(_f, _s, _size)                        \
-    VMSTATE_VBUFFER_UINT32(_f, _s, 0, NULL, _size)
-
 #define VMSTATE_BUFFER_TEST(_f, _s, _test)                            \
     VMSTATE_STATIC_BUFFER(_f, _s, 0, _test, 0, sizeof(typeof_field(_s, _f)))
 
-- 
2.53.0


