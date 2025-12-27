Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB3AE8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR2-0005Zi-7f; Sat, 27 Dec 2025 04:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR0-0005Ur-KJ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQy-0003ak-So
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTcYZX9SZysc77qo1jI98QwZgsIEhfX2i6Ty2BfwHw8=;
 b=BRzYXRZX5kWPDO6rjR7v4B6nfVOwROoPZe5QzRDCovimKT39THiKN0Z4tME7ZsFt+aiTk8
 mfK+8ISCfgfXtGHzoeWzKVU6viqvdp5SFZYxaVLhiJi5CS2iKx1Bsy82ejC1M0yhkzWUgg
 cQZVwcx8ifGemSTdn5tRYcOVVshaXcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-SuZXPxWfPHmY35c_SuZEOA-1; Sat, 27 Dec 2025 04:17:58 -0500
X-MC-Unique: SuZXPxWfPHmY35c_SuZEOA-1
X-Mimecast-MFC-AGG-ID: SuZXPxWfPHmY35c_SuZEOA_1766827077
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477bf8c1413so46121465e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827077; x=1767431877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTcYZX9SZysc77qo1jI98QwZgsIEhfX2i6Ty2BfwHw8=;
 b=ArM2J9VI7Tl17k6cyomWAFy0jNaemPZzgbWKoUHOdw3udYbl8HFtuCttswgLsRWHrl
 FhUK1XXcnzlxlL16QQvOYq0OQxdDD54NaUssWcXWcfVeCxRyDHDETDmuKM7RSs5zDN+C
 zYaw4PZsfEAq6mGy8C1EhIWx1rGpzDr1dOCanHIFzZQLOeoqyhdTchm2j3rmeQPSrXb7
 kWEgFShOiIR76hX1XyCkkIGjMknyesQah8mLYYwMvbTel0J+q1dvGpRea2HY0vzw16zw
 Wsc+0xs4nCWgY7NAIGkPTXnlJA7aWL2txvKLKr0kSZD+rEnjWkyP9Wua1FuSPir0DE6j
 qKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827077; x=1767431877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sTcYZX9SZysc77qo1jI98QwZgsIEhfX2i6Ty2BfwHw8=;
 b=As8aRFAea0TFsqOsF0+tJzkWBGqzzZfANnOJ8dUiDm6m+Nsa+8+bpB/yuextbrC6kZ
 leLXhMl+YsJoqb7J/p4eFk2X/fEENi1oqCwtxrSsjdsJtsjFmkqc5KPlfnm74QNYzn4q
 gZ9H8A/GiwLkW8R2zJF0w+2tmW7bOGxeLrjBGFnDFnGsyEagXAp3YAOe9h8ASk8kn6Rg
 MGjxLk9DMh/xYluN/9Esggo7l0NxrfHas5Otj4cXU1XPquzaWHubMOHhEcbASShxxJ7q
 vdGcQ1CZquW/5JKyQvR4N2GFyKxfXKA4Ok5gfgs1qafrEpt7sDzD7i3rjzHWL/fctxqQ
 o1oA==
X-Gm-Message-State: AOJu0YwKwJrvfjeXI/VA++V5ypKeNiK607tcCcnSSmurdM/x5+hUPTk3
 C4fRkYyDW1JAeJVf6DGxitMUUBR1dyRlzMaUHazmFjAZHvVE6pAT8nmV7WjkYIhkTAe9tIC2OKp
 JboFPCgn7AtFAuw4zkIj03Q9lNT9BPI0ZQzhJOnuj3SQqzRCWTf0OMee9ZxIwtOadU0t2/aVCXl
 clOZYHxT2WH1HxTOi/VkbnJdONN4W1/ZAIscRZUTEU
X-Gm-Gg: AY/fxX4vS3hvG8nzwaGsqwkyWQ7fV0EP/7UxfKwzypf9w+yTJfL48x4gkuzi4halxz6
 zUMyfcJ+PjuCzYrCmCM5PrBihPIgcxLGKvJlF9gNn/sk7sLpBx/Lak9O81hv6JjjxNVRFvz/zfx
 hgla0CFil5fv8qvRNpt9xU+cFIC5rPZ3pB5QYwUz+0BZrMJUd1qZJBYo84geBd5cdkx+csuvuh5
 oPnGFifBqYZrIUmDSeZTMlIyO/PJPTvGuvOMnhWTGa1HsoxgfZ0IN7UnRIWx3+m0YEI8D2H6nYQ
 GPPviOnLmhmMDkKuALZdfelf3dpt9R5A9KVZwl0eiruIEW+yNpVKRVmOyCIC1j+J/85p7He07bw
 4ImJrkdxQ4uFHLmrF6W3Ld1TKz+g0/AEFrwIdIyUdj1WAMelvcrYQ/vg0L0H27gh+PI+qatR1cl
 6CWhpiDUVSmIZUcb0=
X-Received: by 2002:a05:600c:1991:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47d1953318bmr266685865e9.8.1766827077041; 
 Sat, 27 Dec 2025 01:17:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk3+nhqts091f6gUJJWhmt6ZK4OSy4VKwWzucuKm/gpNrhgxYJSGib67M8ZDpz3CAcVLl3gA==
X-Received: by 2002:a05:600c:1991:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47d1953318bmr266685725e9.8.1766827076632; 
 Sat, 27 Dec 2025 01:17:56 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm442666875e9.12.2025.12.27.01.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 049/153] rust/migration: Check name field in
 VMStateDescriptionBuilder
Date: Sat, 27 Dec 2025 10:14:36 +0100
Message-ID: <20251227091622.20725-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The name field is necessary for VMStateDescription, so that it's
necessary to check if it is set when build VMStateDescription.

Since is_null()/as_ref() become rustc v1.84 and pointer cannot cast to
integer in const, use Option<> to check name with a new field in
VMStateDescriptionBuilder instead.

This can be simplified in future when QEMU bumps up rustc version.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index f9d9f335b98..595e7e9cd75 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -531,7 +531,11 @@ macro_rules! vmstate_subsections {
 unsafe impl<T: Sync> Sync for VMStateDescription<T> {}
 
 #[derive(Clone)]
-pub struct VMStateDescriptionBuilder<T>(bindings::VMStateDescription, PhantomData<fn(&T)>);
+pub struct VMStateDescriptionBuilder<T>(
+    bindings::VMStateDescription,
+    Option<*const std::os::raw::c_char>, // the name of VMStateDescription
+    PhantomData<fn(&T)>,
+);
 
 #[derive(Debug)]
 pub struct InvalidError;
@@ -592,7 +596,7 @@ fn from(_value: InvalidError) -> Errno {
 impl<T> VMStateDescriptionBuilder<T> {
     #[must_use]
     pub const fn name(mut self, name_str: &CStr) -> Self {
-        self.0.name = ::std::ffi::CStr::as_ptr(name_str);
+        self.1 = Some(::std::ffi::CStr::as_ptr(name_str));
         self
     }
 
@@ -718,13 +722,16 @@ pub const fn subsections(mut self, subs: &'static VMStateSubsections) -> Self {
     }
 
     #[must_use]
-    pub const fn build(self) -> VMStateDescription<T> {
+    pub const fn build(mut self) -> VMStateDescription<T> {
+        // FIXME: is_null()/as_ref() become const since v1.84.
+        assert!(self.1.is_some(), "VMStateDescription requires name field!");
+        self.0.name = self.1.unwrap();
         VMStateDescription::<T>(self.0, PhantomData)
     }
 
     #[must_use]
     pub const fn new() -> Self {
-        Self(bindings::VMStateDescription::ZERO, PhantomData)
+        Self(bindings::VMStateDescription::ZERO, None, PhantomData)
     }
 }
 
-- 
2.52.0


