Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92663C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdT-0001Dx-Lu; Wed, 26 Aug 2026 10:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdR-0001DS-MG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdP-00025u-VN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FD402121A;
 Wed, 26 Aug 2026 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hagYU1EUz0RO8LHP2IW2Zhm75w1JTYi6QloT7uOI=;
 b=gHBQZGoDbtDQ/V4P5kexzErRRKNR9asSkNwDpPV64CiQ7KllnbBkqL8sxcpuEQty6KUmQj
 dtf0mHxWua5TWKMoCOQTAe9UCdS0wnBoeszRNGnyeIs6Q+B2sp3Tie6sRx9pqY3qjZ0hb9
 9DKdig4Yxl8OScBdvHfvA1DVVc7EBoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hagYU1EUz0RO8LHP2IW2Zhm75w1JTYi6QloT7uOI=;
 b=vkIq7O3fFDNkdvfABvw6YDdXsmeIOeJQ00xx5PhemRuzWhXDLU62Ccm74Pt9PW9Lc+2ZYJ
 Aa7C+km/QGqpaBCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hagYU1EUz0RO8LHP2IW2Zhm75w1JTYi6QloT7uOI=;
 b=AItfu4c+3oRVeZm+YkPw2LS5lLP72Fja6zGsKplvb1xR8YrWKO5IJEx6LG+k5jwZrxlogw
 I3m6rWMTtmqiR+ORjyY1YHnR57l/5B3odLwKG1rZXYgps37Hkfj/lyH6hEiVMpc3FQxHSA
 aYiMg6Z9hRjWZYJwPGAs6yzGOxhmpXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hagYU1EUz0RO8LHP2IW2Zhm75w1JTYi6QloT7uOI=;
 b=0qn7WqB8FDlPZ05pYQxGr0kgyE2JLIvVVyRj2lxCCq39k6BGo2VHnl5aMzvtpNahVL7l5e
 ofemaR6erL9qjdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD3BA13354;
 Wed, 26 Aug 2026 14:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OG8NI1H4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 22/30] migration: Remove unused vmstate macros
Date: Wed, 26 Aug 2026 11:28:57 -0300
Message-ID: <20260826142905.2315503-23-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.18)[-0.911];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Remove the several vmstate macros that don't have any users.

Acked-by: Peter Xu <peterx@redhat.com>
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


