Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DAAC71150
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 11:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQlQb-0003pV-3W; Sun, 15 Jun 2025 07:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQM-0003en-Gk; Sun, 15 Jun 2025 07:21:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQL-0007z5-1K; Sun, 15 Jun 2025 07:21:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so29486905e9.1; 
 Sun, 15 Jun 2025 04:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749986474; x=1750591274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2c5qfKZcmwYpDnUHRh6s6NpbcxxLoJdjpMU5BVDJlAk=;
 b=LrqmGHg5WmX09giCpVzHt/4ga0b2kC3j8bvaQvTs0iUUmbITM6VlnAjec0o/tievWg
 SzKLLcxjaxhq1kcyU4VrCsdJWvB5EhBvxuMKIOerMwrBcIF7dZ82YTXIWOhRpB/cajFy
 JQiXj4x9knrw2S4i4mXazPMg6e3LnZlpo5LGV83HlvJ5FpqTUhSetJ5U4eIosOKIxdA0
 2vifg9KK0brPITn3NzGg6b326+cjWQXgoO/XhVyTaWeTEDHGYFKsE+k2dLQH/Ua413nr
 PcwBWmMcBACAt4dNDPR6tGqmbM3N0js16OjoK1knyrWOY7ZExEW3TsJEFS7BRRPlaPjc
 WdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749986474; x=1750591274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2c5qfKZcmwYpDnUHRh6s6NpbcxxLoJdjpMU5BVDJlAk=;
 b=s2+N3w8/SZvx5U/EitMW0/YzQbiVdqtCyFdpoX+PAUF3Vm2Cxnn8ktBu53QfMRQTpL
 zict1M2qgRE9mn01Q6X/evCPtpaMMeRpHFtT783pZcQNyzvYiM2CUnIyEiI95RUqoqq6
 K+J027FRcrZDVSFqzveOsZhDWYbVlfDCF3PoPP3DBmSxS6GFxFyx+4cpsXGZ+oPrqXF+
 5ELyCiSudrHnweb09LABD0M68NWh5+hyhL7RCdl/Rb7WHPLVnj2yAUubCqBWYX0MAiFN
 xIF9H8Sx2KTBeDomjQggo7OWXpMD+KNcWakoVfptHnEiI1skeUOjSMeh8BnDs5G10oiE
 ek5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXSDWb9gJiHqAjkg/7Z90nsuUr3KWYSa3M/tYxkiCtAO3xTKR0QzVi6JWIUPq/nrWKNAKlicyZtzY=@nongnu.org
X-Gm-Message-State: AOJu0YzVzgNgRTCI7Cv8SDIM0HfViYznCA5saGTxz36/kq+hsG6mSLUk
 KmJdtdwLBQf8umYT8Jv4GCxgdsl8kMpxDp6NFiCqUbp+hCasU83BmkrXxA9C9Q==
X-Gm-Gg: ASbGncvwW66vzSJcoX5OiYxqk5oncsTddptkiPcIH8Xr2E/EzgPSJqo0WHb9AfBNweE
 ClsePEWy6JvhooRzeEM5yWGKCVAo2wgQNgJHvehSLxokaEoBfdO+gfeuyqK9px186E34ESgdKP7
 Gljdwx2dFf2QF/ZVodTNwUJv+PSnrSDTMA0KI5rIEnxLCFg1FNJD5h+INrezc2EGwPramgjYYJC
 ixdgnmWJeAvU7EY87+XY3YCsNkBIlw3bbBchiL2B+G/ahx3SMsIQ3h6bnXA1VJXkv+Quy4i5T2y
 cWXLkyp5baWDHF6M0i20J/vTf10ac+Z0vr4huEHkVBaL9ty5oWBlv81LhbVJYOgdDOju3bbOzWx
 aUS0uPL5VEDGVSXUn6VkIACZrRoylcCIyOXEQXHs2Hyg9iDbH0aCYlqmxkG94me0jj0vbTqJ3FP
 4YmhRHkg==
X-Google-Smtp-Source: AGHT+IHAaIVSOBh7QurW4GdAIH3p1GVLkLBB77gQHQfwKB0esk0dVHziuPn65jh5CqXEGevpKUa2lQ==
X-Received: by 2002:a05:600c:4f4b:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-453449ea4b5mr22834735e9.12.1749986473941; 
 Sun, 15 Jun 2025 04:21:13 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-231b-9b00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:231b:9b00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm7327099f8f.89.2025.06.15.04.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 04:21:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 4/4] rust/qemu-api: Fix clippy lint `missing_const_for_fn`
Date: Sun, 15 Jun 2025 13:20:37 +0200
Message-ID: <20250615112037.11992-5-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250615112037.11992-1-shentey@gmail.com>
References: <20250615112037.11992-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 rust/qemu-api/src/cell.rs | 2 +-
 rust/qemu-api/src/qom.rs  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 27063b049d..851573f8ef 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -965,7 +965,7 @@ impl<T> Opaque<T> {
     /// # Safety
     ///
     /// The pointer must be valid, though it need not point to a valid value.
-    pub unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
+    pub const unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
         let ptr = NonNull::new(ptr).unwrap().cast::<Self>();
         // SAFETY: Self is a transparent wrapper over T
         unsafe { ptr.as_ref() }
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 14f98fee60..29d1b02720 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -634,7 +634,7 @@ impl<T: ObjectType> Owned<T> {
     /// back to `from_raw()` (assuming the original `Owned` was valid!),
     /// since the owned reference remains there between the calls to
     /// `into_raw()` and `from_raw()`.
-    pub unsafe fn from_raw(ptr: *const T) -> Self {
+    pub const unsafe fn from_raw(ptr: *const T) -> Self {
         // SAFETY NOTE: while NonNull requires a mutable pointer, only
         // Deref is implemented so the pointer passed to from_raw
         // remains const
-- 
2.49.0


