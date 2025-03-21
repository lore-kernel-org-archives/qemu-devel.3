Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD3C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFM-0003e7-2p; Fri, 21 Mar 2025 14:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEg-0003Cd-Np
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEe-00076L-Vr
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k78nL9wKTuaLgNByzOaVa642KSVUTzjjwBq+ZhaFZTg=;
 b=EbzEYFqtoVQZGueW8gHlQeNEjiLKzNMFxaUpY8RqHV9e0HM6Z2xlX99nuor7DWkhEXsHhn
 LRougDMN06zkYcPkOtLJx94HBJBwXRsnNcClW/vPbYX0Q3WKLeFwuU1NNSryP0eKYxK+8M
 uwlLHQt82xJpbTc1EkP7eAXQy8uSiBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-SZotqt4DPCKEXwPWXuOGuA-1; Fri, 21 Mar 2025 14:36:46 -0400
X-MC-Unique: SZotqt4DPCKEXwPWXuOGuA-1
X-Mimecast-MFC-AGG-ID: SZotqt4DPCKEXwPWXuOGuA_1742582205
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso1018676f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582204; x=1743187004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k78nL9wKTuaLgNByzOaVa642KSVUTzjjwBq+ZhaFZTg=;
 b=Epem23VJ5h6J5ylLX8/6OLXXkERzTa9y5lRU9sY04rHlNvkz3GHRVDoD5FBXDtAruI
 wbP7kT9y7UfWUtLA6QZ7AfoigrJVGqIN8+E9L7+a+M2M1UPHXBrV3gYdFYdO/CsUBfHV
 AJOvErdy5xL1gGea4+0BuiLGqxNmeTD6OIsQ6TQF2Ukzjwji55SrdZuzDeHnPM1R03Y7
 6etGzF+gJxvitOee/aaqUOk8adIxPZ2PoYtLX0kx9829rZPiigxJOBuT3VflolpiFQAV
 cGwMFKxz0pZiln9XWOQLrfIzPio1dn+XJpAMXw1OUbbTR2OfrA/Hh/nGScWb4e7qDnX3
 yjIw==
X-Gm-Message-State: AOJu0YwHL7VZgoQ5ZTwzX4TyVnRv7cVCyIfx+Lk1i36qM79/XT6akBRe
 r9j1Sof2qJ/lSNzfC0HTxQcANcvmmlfwcT+LdsBh6ibC69zFhSV/Yrj8WaX7PaVOQY1Ojc+cqf+
 MKh0Pw0WhAn+kmZKkmrHZVEGDi96mVLR5NKYgDj7N09DbGSfm2hQYam7WvLd4MWPnfBJnn71iAg
 F4iaR0NOPhB2zhMDam6z65a7lubPfWldZgikQS
X-Gm-Gg: ASbGncs9F91Gp1d/LP0w6LnTIHKDIHSyaDeo6CZkHtXF/Jn4COjEGX/qy8h/VzUYPd5
 xeY7nW5YV9nYwHx37uxXLlNuhaIG/RlVci4qvbDjkZ5iLAK+Ug1XhpkJ3lswxTw2pqhhyqJ8gwg
 iCDUgt07nzZQ5zp46inRc45m+vonMK5E9/38jjm880gYdPZiWQxCVBOI9s878N+sQI6hpHV5y14
 ZszOKpJk5IQa+QjLeZHpJj04GQghNQZ6dXeAFVYkgDwsE4+u0RR5DIt5FFPiYyVcbjpjQPUsccs
 m1fNgP0JoKaH4uw3lEhd
X-Received: by 2002:a5d:64ab:0:b0:391:487f:27e4 with SMTP id
 ffacd0b85a97d-3997f90d377mr4892751f8f.27.1742582203703; 
 Fri, 21 Mar 2025 11:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhhuFZL9LtAlQYU+6afn2i5o2v0wR/LS1hEEa/facmGS7hN/qa4EaaEpSbmOgKfOqmzkDnRQ==
X-Received: by 2002:a5d:64ab:0:b0:391:487f:27e4 with SMTP id
 ffacd0b85a97d-3997f90d377mr4892726f8f.27.1742582203168; 
 Fri, 21 Mar 2025 11:36:43 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3428sm3077477f8f.26.2025.03.21.11.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 17/24] rust/vmstate: Re-implement VMState trait for timer
 binding
Date: Fri, 21 Mar 2025 19:35:49 +0100
Message-ID: <20250321183556.155097-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

At present, Rust side has a timer binding "timer::Timer", so the vmstate
for timer should base on that binding instead of the raw
"binding::QEMUTimer".

It's possible to apply impl_vmstate_transparent for cell::Opaque and
then impl_vmstate_forward for timer::Timer. But binding::QEMUTimer
shouldn't be used directly, so that vmstate for such raw timer type is
useless.

Thus, apply impl_vmstate_scalar for timer::Timer. And since Opaque<> is
useful, apply impl_vmstate_transparent for cell::Opaque as well.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 0b5af1c90b1..01f06ed7379 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -27,12 +27,7 @@
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::{
-    bindings::{self, VMStateFlags},
-    prelude::*,
-    qom::Owned,
-    zeroable::Zeroable,
-};
+use crate::{bindings::VMStateFlags, prelude::*, qom::Owned, zeroable::Zeroable};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -344,6 +339,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
@@ -390,7 +386,7 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
 impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
-impl_vmstate_scalar!(vmstate_info_timer, bindings::QEMUTimer);
+impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
 
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
-- 
2.49.0


