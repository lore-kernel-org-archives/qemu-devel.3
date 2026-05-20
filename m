Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CBECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYR-00011p-SD; Wed, 20 May 2026 17:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYP-00011Z-VD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYN-00079E-JO
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/FOPpomrl3+0V2dZRYto+HcFWAdZXe964znPRUTvqs=;
 b=NtRvrSrLMHQJOZWHvg9tsDAZtKsaa3xhnwDD0vI9TqcPdbCehy+eZmTeqA4jsCKlJv8HWQ
 sE8vObxEzAg4jD8TuTom5PTXse/J49ZYmIrSic0YJR3UShPhbL46zRYL3m8/WU/YFYPX3i
 iqIYeUflghH30ZPyVS6fS7vIVJMNV5s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-oBvr3sxDP3uGb4-MKSeWxQ-1; Wed, 20 May 2026 17:34:09 -0400
X-MC-Unique: oBvr3sxDP3uGb4-MKSeWxQ-1
X-Mimecast-MFC-AGG-ID: oBvr3sxDP3uGb4-MKSeWxQ_1779312849
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8acb26fbbb2so30935156d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312849; x=1779917649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/FOPpomrl3+0V2dZRYto+HcFWAdZXe964znPRUTvqs=;
 b=Jzgu+NHhJEwWlUCMWeNRn+P73gXCUT1hxnjgeed3B4IurAS91HqE8WOppGgriEOKEn
 DEpyZDFJRaGOaNE6VEtDz0ifxEE2eqbN5GMlgth79+L5UV9vFx3kYoIh3ezcJXaAOAV2
 xRDWaSEfVIaxCM0W63iCu0c9XHNyG/dXFZl5qYkYgEsOuvHhmwvtpBEjc2PGmebX3nme
 vwVoo0WUcO0WsHJxMggp3hlNK9eTKGkNHrzlBIiSqc52wZm4+eFw00cz8RSiF/x0Funt
 CuHh+wD0vUYDSSu9ofuHLxl/64UDiGJGnVxpIArut0GU/8CKgG6MLQTMDJSBaJ8ySFWs
 aeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312849; x=1779917649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y/FOPpomrl3+0V2dZRYto+HcFWAdZXe964znPRUTvqs=;
 b=XrS2UQo+xC1iw60u62LebjD+yX8qynvc1U1O3rqt2EGlAum8n+yFAALVjf6834KMh8
 DepUvNDYYkJm9x7T+priLyAdQ3isPg7ORayRhgj7fobpXTGfzbStmQybCMwnvoNERiCC
 /uBLpHm96cxbmWmCdjgTiCeS1q6wP8QCMCdIVZalEG9SzXQQ8gX4ngiPhgZci3yIi9r8
 SKgmjZ9Vz/8tmFk3DhmuIntyCrWoJWYBoYf7o/OTiSWCEusMWy8Y/7pqeRcTRsnUaWTp
 wqMM7ugBnApufOb9qwVCnx0fcLbDVoiTmJgdASXhpDgy+ZqnB80lWjzexw7ugBH0B0Wy
 DwBg==
X-Gm-Message-State: AOJu0YwvftvxqTa4OMN9qqimvTHXR1AdpMEeY8kTxFq5mHLwtGdIPcgP
 akAe1Ap+QXC3MU7298sjNmeLO6h0UT57ML1he334x+3fAH4pBH9H//BMfUpsJDsH7Fn1kfX2juU
 f5O8I/bPdK07Y9y60B5KO1Yp+0UnarYkjxjI52CE1mWWZ0F/lAIk+wP9a3NGzpALc76HDpCScvE
 7ZhVtgSnXBfLgeAIyP8w+FpkACjIW6TuWHGV7z4g==
X-Gm-Gg: Acq92OH+iyWtBbp/NDuQ5dSNheOEXZV0j6XiPqN7RlPOJBhpxy10/zcCPuQHW5O3E9Q
 Rc0iIjuZtulN1LY7YuYp3Re1Cuu9gX30+F24Js0S5FJU7j/vh/4c7PZhK/nOskgfgKxsBTAcAaL
 alMtQVVk3Pzan/JGj/j5XPYp1kMAiQNqXaBCi0AAcBWtY7jLLaVDwRVuph/QnLm0GBDVkTgHVlE
 a+dHo4rnKffaxHpMlFjbJPUr1Jsi3MW0Rrr4xVmVZYgAiQFn4SwNFyOKRmzG9FBKun6jO2g+UJX
 LZSbELOZ/mbeycX28rWrC2l+zb/o8bAD/PMGafr5gDFPIEWoGPBWtxgY1eREwyEMaz0SFlnU67L
 u7iDfvG6jUJsr3k+swa0/xnVoI9J6Vq1oQKxW7+8y7iuzexHAvILoFYI=
X-Received: by 2002:a05:6214:5f12:b0:8ae:3e38:54ca with SMTP id
 6a1803df08f44-8cc6e2048edmr5666146d6.0.1779312848553; 
 Wed, 20 May 2026 14:34:08 -0700 (PDT)
X-Received: by 2002:a05:6214:5f12:b0:8ae:3e38:54ca with SMTP id
 6a1803df08f44-8cc6e2048edmr5665396d6.0.1779312847829; 
 Wed, 20 May 2026 14:34:07 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 02/29] migration: Remove VMS_MULTIPLY_ELEMENTS and
 VMSTATE_VARRAY_MULTIPLY()
Date: Wed, 20 May 2026 17:33:30 -0400
Message-ID: <20260520213357.40646-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit c1eb3ac3468 ("target/sparc: Replace
VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY") removed the
last use of the VMSTATE_VARRAY_MULTIPLY() macro. We can now
remove it as unnecessary, along with the VMS_MULTIPLY_ELEMENTS
flag and the associated tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20260507070228.48877-1-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h        | 22 ++----------
 migration/vmstate.c                |  4 ---
 rust/bindings/migration-sys/lib.rs |  8 -----
 rust/migration/src/vmstate.rs      |  3 +-
 rust/tests/tests/vmstate_tests.rs  | 55 ------------------------------
 5 files changed, 4 insertions(+), 88 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 28e3640e60..0a8a2e85a6 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -105,7 +105,7 @@ enum VMStateFlags {
     VMS_ARRAY_OF_POINTER = 0x040,
 
     /* The field is an array of variable size. The uint16_t at opaque
-     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * + VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -126,14 +126,14 @@ enum VMStateFlags {
     VMS_MULTIPLY         = 0x200,
 
     /* The field is an array of variable size. The uint8_t at opaque +
-     * VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
     VMS_VARRAY_UINT8     = 0x400,
 
     /* The field is an array of variable size. The uint32_t at opaque
-     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * + VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -150,12 +150,6 @@ enum VMStateFlags {
      * cause the individual entries to be allocated. */
     VMS_ALLOC            = 0x2000,
 
-    /* Multiply the number of entries given by the integer at opaque +
-     * VMStateField.num_offset (see VMS_VARRAY*) with VMStateField.num
-     * to determine the number of entries in the array. Only valid in
-     * combination with one of VMS_VARRAY*. */
-    VMS_MULTIPLY_ELEMENTS = 0x4000,
-
     /* A structure field that is like VMS_STRUCT, but uses
      * VMStateField.struct_version_id to tell which version of the
      * structure we are referencing to use. */
@@ -446,16 +440,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_2darray(_state, _field, _type, _n1, _n2),  \
 }
 
-#define VMSTATE_VARRAY_MULTIPLY(_field, _state, _field_num, _multiply, _info, _type) { \
-    .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
-    .num        = (_multiply),                                       \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
-
 #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 2f13b48a37..6fa7523f04 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -100,10 +100,6 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
         n_elems = *(uint8_t *)(opaque + field->num_offset);
     }
 
-    if (field->flags & VMS_MULTIPLY_ELEMENTS) {
-        n_elems *= field->num;
-    }
-
     trace_vmstate_n_elems(field->name, n_elems);
     return n_elems;
 }
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
index 7ee30a3f7d..9581481e42 100644
--- a/rust/bindings/migration-sys/lib.rs
+++ b/rust/bindings/migration-sys/lib.rs
@@ -114,12 +114,4 @@ pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.with_varray_flag_unchecked(flag)
     }
-
-    #[must_use]
-    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
-        assert!(num <= 0x7FFF_FFFFu32);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
-        self.num = num as i32;
-        self
-    }
 }
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index f34a36f680..63d78b4f27 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -159,8 +159,7 @@ macro_rules! vmstate_of {
             )$(.with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
                     $struct_name,
-                    $($num).+))
-               $(.with_varray_multiply($factor))?)?
+                    $($num).+)))?
         }
     };
 }
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 87176a8099..c2c12cfab5 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -118,34 +118,6 @@ fn test_vmstate_varray_uint16_unsafe() {
     assert!(foo_fields[2].field_exists.is_none());
 }
 
-#[test]
-fn test_vmstate_varray_multiply() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) };
-
-    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
-    // VMSTATE_VARRAY_MULTIPLY)
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
-        b"arr_mul\0"
-    );
-    assert_eq!(foo_fields[3].offset, 6);
-    assert_eq!(foo_fields[3].num_offset, 12);
-    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_int8 });
-    assert_eq!(foo_fields[3].version_id, 0);
-    assert_eq!(foo_fields[3].size, 1);
-    assert_eq!(foo_fields[3].num, 16);
-    assert_eq!(
-        foo_fields[3].flags.0,
-        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
-    );
-    assert!(foo_fields[3].vmsd.is_null());
-    assert!(foo_fields[3].field_exists.is_none());
-
-    // The last VMStateField in VMSTATE_FOOA.
-    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
-}
-
 // =========================== Test VMSTATE_FOOB ===========================
 // Test the use cases of the vmstate macro, corresponding to the following C
 // macro variants:
@@ -256,33 +228,6 @@ fn test_vmstate_struct_varray_uint8() {
     assert!(foo_fields[2].field_exists.is_none());
 }
 
-#[test]
-fn test_vmstate_struct_varray_uint32_multiply() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
-
-    // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
-    // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
-        b"arr_a_mul\0"
-    );
-    assert_eq!(foo_fields[3].offset, 64);
-    assert_eq!(foo_fields[3].num_offset, 124);
-    assert!(foo_fields[3].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
-    assert_eq!(foo_fields[3].version_id, 2);
-    assert_eq!(foo_fields[3].size, 20);
-    assert_eq!(foo_fields[3].num, 32);
-    assert_eq!(
-        foo_fields[3].flags.0,
-        VMStateFlags::VMS_STRUCT.0
-            | VMStateFlags::VMS_VARRAY_UINT32.0
-            | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
-    );
-    assert_eq!(foo_fields[3].vmsd, VMSTATE_FOOA.as_ref());
-    assert!(foo_fields[3].field_exists.is_none());
-}
-
 #[test]
 fn test_vmstate_macro_array() {
     let foo_fields: &[VMStateField] =
-- 
2.53.0


