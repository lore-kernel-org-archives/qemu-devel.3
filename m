Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EF0CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEw-0006Sy-F0; Tue, 14 Oct 2025 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEW-0005yo-TZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEP-00017p-Ux
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEG6T/J+GXYTGRUDDa6Uq81qUc1bn8Yy9qgoJUqKqdY=;
 b=N6fZQ6UoCB140bSOQNnO2HIZN9n8SHgdikazEf3R07KWUzq1NPELwum4weU3w1Gl2XxIqz
 qJf+xDLPtxujb9JmrOVdkF4/I6X1icR02GDicun1ZNrYjEEO3aAI6FcklDbR7eGWVSsEHA
 rYrqwtD4bka+4Wd9nYuEdLFwUAAt31I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-fLVKrTtqPQigEHydnBO77g-1; Tue, 14 Oct 2025 09:38:21 -0400
X-MC-Unique: fLVKrTtqPQigEHydnBO77g-1
X-Mimecast-MFC-AGG-ID: fLVKrTtqPQigEHydnBO77g_1760449101
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426ce339084so3990461f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449100; x=1761053900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEG6T/J+GXYTGRUDDa6Uq81qUc1bn8Yy9qgoJUqKqdY=;
 b=IymsIWQ8skL3F343935hXtSHr9UkgpIJb6Q+LvzwEj+S9uDQOM5DzoGkz0SKbO1B46
 x2OSrXKiTnSAR7VMz9P26qTaqKHYSL+Q5eTT7WPVEfRNifbNJTBNTmST51B3StEwOQ0I
 RPzmCfU2toCiTQOrfSqrlh8WX3P39k4EmKtwpivqZOi9cP6vIEm3plbYAKq4bAJeEtzH
 72B1iNVThCGFMSTipULwbqXwJn6XytMukmLYXHdgIxVATvfFAs8nhujQ47aiNn7FY9d9
 V4Cn3UZCWdyOVug8t4Gd20mHU9hcvcDZvu4n4iAf7OpcJzmqUDpwlwYX36BhOTpGntNF
 2kLQ==
X-Gm-Message-State: AOJu0YxR3EskeIL3NnaFrwXWnuzFoUYzI00CZuUkYPkxT+wNr/G0RWIb
 9RkgF/ooTiI1lFQiBh5+7btDX/3oSqVAEe/xSUzZJYpwPXpx3HEl+JHtprzUrZXmKqbiQI6FTdD
 AhkRaZAJDsqCtTig9YfwznmScOAwtqqCsOj1pKR+u5OBlPMCyKwwUTkY2kycRBb221DvMCW79+2
 ssuoFkmKzit0ugOYl8kiqfRVK/X0me4ZhFdlgEcQgx
X-Gm-Gg: ASbGnctxuEaJ6OYW2c6TWDypWHYe9p/R+yH58BppapaQgK2eWFmEANkOKeLni3s69B+
 KUgz2jg21Ki7oGAyL8vXUJBcsR3Gm0+aYP5MOWBZp9hLWpjrKeR1rsOtMwil8Y4YGUCF8s7M6bO
 nLx4iUqRE7uTBk+TN5XgNs1KOLLM5nPFMKAjFLExPX3OejqqCLOyqELi61nvX6zMP1A3M5STYLN
 lgtbD8AsKWdByWExPitA5D0ErKSvTyWhdsSSRsCWwcKalERThu9znDBBnaMbnMDJvqB9OtfTPtq
 NWzfqTuR0Q0Qlq7SLADRcofHVxZnN7PLi4dJX0dxPbdT9lF94gve+yjeBxAx0CjtNxQlD4RA6jx
 1A8+rdIqQLJ+nSLP4ekDu0ul8KCsAN/fmxwOlSlb/yvY=
X-Received: by 2002:a05:6000:2906:b0:3eb:c276:a347 with SMTP id
 ffacd0b85a97d-42666a9700fmr14230901f8f.0.1760449099645; 
 Tue, 14 Oct 2025 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTr4/jOIqoVUg6CIZOSz1yoksWQovr0g4YZjumlQG5UIWUrzcM99ZEu+9ytfXFqlAVh6Yw1A==
X-Received: by 2002:a05:6000:2906:b0:3eb:c276:a347 with SMTP id
 ffacd0b85a97d-42666a9700fmr14230879f8f.0.1760449099090; 
 Tue, 14 Oct 2025 06:38:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426f2f72e18sm2451882f8f.0.2025.10.14.06.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/28] rust: migration: extract vmstate_fields_ref
Date: Tue, 14 Oct 2025 15:37:08 +0200
Message-ID: <20251014133713.1103695-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is useful when building a VMState for generic structs, because you have
to avoid nested statics.  Using vmstate_fields! will fail in the likely case
where the _FIELDS static uses Self from an outer item, because that is
forbidden.

The separate macros are needed because you cannot just do

                 .fields(vmstate_fields_ref! {
                      vmstate_of!(PL011State, clock),
                 })

The value returned by vmstate_fields_ref! is not promoted to static, which is
unfortunate but intentional (https://github.com/rust-lang/rust/issues/60502):

error[E0716]: temporary value dropped while borrowed
   --> rust/hw/char/pl011/libpl011.rlib.p/structured/device.rs:743:17
    |
738 | /      VMStateDescriptionBuilder::<PL011State>::new()
739 | |          .name(c"pl011/clock")
740 | |          .version_id(1)
741 | |          .minimum_version_id(1)
742 | |          .needed(&PL011State::clock_needed)
743 | |          .fields(vmstate_fields_ref! {
    | | _________________^
744 | ||              vmstate_of!(PL011State, clock),
745 | ||         })
    | ||_________^- argument requires that borrow lasts for `'static`
    |  |_________|
    |            creates a temporary value which is freed while still in use
746 |            .build();
    |                   - temporary value is freed at the end of this statement

Thus it is necessary to use the "static", whether explicitly or hidden by
vmstate_fields.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 6b0f96c4da8..59e665f6c3a 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -412,19 +412,30 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
     }};
 }
 
+/// Add a terminator to the fields in the arguments, and return
+/// a reference to the resulting array of values.
+#[macro_export]
+macro_rules! vmstate_fields_ref {
+    ($($field:expr),*$(,)*) => {
+        &[
+            $($field),*,
+            $crate::bindings::VMStateField {
+                flags: $crate::bindings::VMStateFlags::VMS_END,
+                ..::common::zeroable::Zeroable::ZERO
+            }
+        ]
+    }
+}
+
 /// Helper macro to declare a list of
 /// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return
 /// a pointer to the array of values it created.
 #[macro_export]
 macro_rules! vmstate_fields {
     ($($field:expr),*$(,)*) => {{
-        static _FIELDS: &[$crate::bindings::VMStateField] = &[
+        static _FIELDS: &[$crate::bindings::VMStateField] = $crate::vmstate_fields_ref!(
             $($field),*,
-            $crate::bindings::VMStateField {
-                flags: $crate::bindings::VMStateFlags::VMS_END,
-                ..::common::zeroable::Zeroable::ZERO
-            }
-        ];
+        );
         _FIELDS
     }}
 }
-- 
2.51.0


