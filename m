Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4DDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUt-00087e-6h; Tue, 18 Aug 2026 14:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUp-00083p-Lz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUm-0003Bv-Rr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69704846C1;
 Tue, 18 Aug 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhZ0Jaa2LTaWO+2UdkFJyZ/kFzMlnQ9CTe18Ey4xy/A=;
 b=woA9YSiISCKjedoHYgAg8IWEem66a/kgIAs2PCEOP7sKrCO3s1ZEQ5ZhIToWUEgXKvp0e/
 OOdOJ3py7FVIhE5Q4URgtST9PcA1pqdLPo+r1JvGpvjkZOcNE5RO+Ofxj/6gvkrogZ9/xV
 7njbvh/v7s9OyQy0rfUhfPYqNvM7vCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhZ0Jaa2LTaWO+2UdkFJyZ/kFzMlnQ9CTe18Ey4xy/A=;
 b=lBUU8hTWz4b0e2jwhqTtqnEHbX/kwaoWVx5vvYRduF+vzCNEr9e7tBBWb+/jyqmkJcnd9Z
 O2d6xfteNHj3gbAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vEn97KIv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Utw71iRd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhZ0Jaa2LTaWO+2UdkFJyZ/kFzMlnQ9CTe18Ey4xy/A=;
 b=vEn97KIvYEeQuhDv0Y9Yf8mXpr65CqDCdYP4kiSM3fDBMQdFbTYv2H95Q5ueaLosMV2lxz
 ma0sqaMkqY5CnMPwTFJKxSoOMnzA8z9nnNYlByfu02kErEKZWd6R2//MWkJbhUahJKpPlP
 YeOKVJT3iix0Jocctrv3LoSKIgmwaHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhZ0Jaa2LTaWO+2UdkFJyZ/kFzMlnQ9CTe18Ey4xy/A=;
 b=Utw71iRdz4o5E/GaF6TEPoy0VQc0drkMOT7bW30URc5p3WW1A2nWgnJFPFz+oJ+dAgV5r5
 msOa+VtSbT78yXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA6A367B;
 Tue, 18 Aug 2026 18:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IDQhF3mjhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:24:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 5/8] migration: Add VMS_NO_STATE flag
Date: Tue, 18 Aug 2026 15:24:38 -0300
Message-ID: <20260818182441.404790-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 69704846C1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

There are a few special cases of vmstate usage:

The vmstate_msix and vmstate_scsi_device have fields that contain no
data, only a vmstate_info structure.

The VMSTATE_VALIDATE macro serves only to invoke the .field_exists
routine for validation.

Regardless whether these scenarios are valid, add a separate flag to
identify them so we can enforce common constraints for the normal
vmstates such as having a size greater than zero.

Note that n_elems is hardcoded to 1 for all vmstates, except
VMS_[V]ARRAY, so VMSTATE_VALIDATE needed to set VMS_ARRAY to be able
to force n_elems to 0. This patch now checks the flag at
vmstate_n_elems().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/pci/msix.c                     | 6 +-----
 hw/scsi/scsi-bus.c                | 6 +-----
 include/migration/vmstate.h       | 9 +++++++--
 migration/vmstate.c               | 6 +++++-
 rust/migration/src/vmstate.rs     | 2 +-
 rust/tests/tests/vmstate_tests.rs | 2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 1b23eaf1007..adf76b5bccc 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -711,12 +711,8 @@ const VMStateDescription vmstate_msix = {
     .fields = (const VMStateField[]) {
         {
             .name         = "msix",
-            .version_id   = 0,
-            .field_exists = NULL,
-            .size         = 0,   /* ouch */
             .info         = &vmstate_info_msix,
-            .flags        = VMS_SINGLE,
-            .offset       = 0,
+            .flags        = VMS_SINGLE | VMS_NO_STATE,
         },
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index deb43d5560e..aa02ff631b7 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1980,12 +1980,8 @@ const VMStateDescription vmstate_scsi_device = {
         VMSTATE_UINT32(sense_len, SCSIDevice),
         {
             .name         = "requests",
-            .version_id   = 0,
-            .field_exists = NULL,
-            .size         = 0,   /* ouch */
             .info         = &vmstate_info_scsi_requests,
-            .flags        = VMS_SINGLE,
-            .offset       = 0,
+            .flags        = VMS_SINGLE | VMS_NO_STATE,
         },
         VMSTATE_END_OF_LIST()
     },
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 4b6d52955ff..e72c3fae9a6 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -109,6 +109,12 @@ enum VMStateFlags {
      */
     VMS_ARRAY_OF_POINTER = 0x040,
 
+    /*
+     * The field contains no data. Used for special cases such as
+     * invoking a custom VMStateInfo.
+     */
+    VMS_NO_STATE = 0x080,
+
     /* The size of the individual entries (a single array entry if
      * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
      * neither is set) is variable (i.e. not known at compile-time),
@@ -454,8 +460,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_VALIDATE(_name, _test) { \
     .name         = (_name),                                         \
     .field_exists = (_test),                                         \
-    .flags        = VMS_ARRAY | VMS_MUST_EXIST,                      \
-    .num          = 0, /* 0 elements: no data, only run _test */     \
+    .flags        = VMS_MUST_EXIST | VMS_NO_STATE,                   \
 }
 
 #define VMSTATE_POINTER(_field, _state, _version, _info, _type) {    \
diff --git a/migration/vmstate.c b/migration/vmstate.c
index bc5285bcea2..51d02b87e7e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -97,12 +97,16 @@ static uint64_t vmstate_read_from_offset(const VMStateStructMember *member,
 
 static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
 {
-    uint64_t n_elems = 1;
+    uint64_t n_elems;
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
     } else if (field->flags & VMS_VARRAY) {
         n_elems = vmstate_read_from_offset(&field->num_indirect, opaque);
+    } else if (field->flags & VMS_MUST_EXIST && field->flags & VMS_NO_STATE) {
+        n_elems = 0;
+    } else {
+        n_elems = 1;
     }
 
     trace_vmstate_n_elems(field->name, n_elems);
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 4ec54097148..a3a710ab3ac 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -418,7 +418,7 @@ macro_rules! vmstate_validate {
             field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),
             flags: $crate::bindings::VMStateFlags(
                 $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
-                    | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
+                    | $crate::bindings::VMStateFlags::VMS_NO_STATE.0,
             ),
             num: 0, // 0 elements: no data, only run test_fn callback
             ..::common::zeroable::Zeroable::ZERO
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 5f6dd8ae7f1..6578d54b37d 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -461,7 +461,7 @@ fn test_vmstate_validate() {
     assert_eq!(foo_fields[0].num, 0);
     assert_eq!(
         foo_fields[0].flags.0,
-        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_MUST_EXIST.0
+        VMStateFlags::VMS_NO_STATE.0 | VMStateFlags::VMS_MUST_EXIST.0
     );
     assert!(foo_fields[0].vmsd.is_null());
     assert!(unsafe { foo_fields[0].field_exists.unwrap()(foo_d_p, 0) });
-- 
2.53.0


