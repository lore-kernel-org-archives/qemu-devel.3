Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC965C3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 10:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u10Ps-00077y-Rt; Sat, 05 Apr 2025 06:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pr-00077p-WF
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pq-0005sl-C5
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743847577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+CY5CveonKo7CWmyzLUAVkunDmtEX2A2L1U4F0vskc=;
 b=EDQDYcNHD6or4zH2J4o9A08mqLAeA1eXWYDCnxa1JOYYu18EQpV8R5cyaZC//L96mYnMvO
 eF6v8iGGZF93mdoAyTngVBU7FkCDZj280IiyEViXUA47ABueOsLUxuuomvvqyNluIPjodJ
 mHxn6a2iPKMgSR0ypVm9DEiXqO+NgaY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-7Cj3FUNpMgi8_7a1RNPj9Q-1; Sat, 05 Apr 2025 06:06:16 -0400
X-MC-Unique: 7Cj3FUNpMgi8_7a1RNPj9Q-1
X-Mimecast-MFC-AGG-ID: 7Cj3FUNpMgi8_7a1RNPj9Q_1743847575
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so21801245e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 03:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743847574; x=1744452374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+CY5CveonKo7CWmyzLUAVkunDmtEX2A2L1U4F0vskc=;
 b=XyHwfKUHdfFxDBFpzS+VmBfZHz5ySRkBEG3lp1Cmjp09hd08TUT9ZtTrbalqtcTpg3
 yxXTTEY+LQfmjO8Gi5fVXItme+C4EQYq1ap/wnqttFhjz30PxW00PCaCjtwAZAkhjKgQ
 whg5PyOv7wBgwTkGQHp0i+w1mzDoOMeuUWhl0bREXiVhDvtMC6/83meeJGA+F6QhJ7SV
 TXfGgKZkMQDFTy0bZIqgFfqWkumEUPFN4ZWAI9X8QiGUtR//eecqEuWKQheSjjlM9CoG
 eNQGc8DL2vurXTvlYlOJjhrLwlvnEoosZ9FJXFcXMLr6uuVda96C6Vb9sntGYtSbJKLb
 tJ0Q==
X-Gm-Message-State: AOJu0YxjNpWlWQi4uE9uDHHSE7/aeXLTfWjd5xc7b2F5A8prc73dT4mD
 4eqs8/XuMHXM3FnvwW7Z/pwrQmVlkwYEW8xMXMR3M5wTewr7mglH/2u7cQxEXw+mY+C08tgRnyN
 J/1szjPFzZC97NqPo4ONS1UOgznLUG7dRmpXRblzxVgvNy7dmnm+s7OThF/ZJ/n9kZMXBl8Ears
 vj5W526EMEZYjj11sKIxN1aTLG+O6tGbCdmqTG
X-Gm-Gg: ASbGncuic5/F+S24gXlpmE8OqS+E+ahSHcMjq41ibQhrHCqkLdmDosqDiZNTFpzyUEB
 yQ3vQmGF1dG7BDHKrwfiHyg7dDTQTjsPFP0Rm4o9vMGG0CPOmzqhBk/ukA5nKP9lHSNNq9ho3cE
 Dja5UHp1dNKy7iW2e9MwU94ABLJtJagU/nk3NWG05vHKYe9wDrJG8Edd00TdxqYUwR4/6iryQJ4
 SkA3HbQlrCdT+7TRfLOrkrcSf9xnav6Uopuy621/aiAjEr8oRjMNRKXa3+xFgo3dlxZZX9PnJ9v
 sBE1bcNiIbHWGwljUA==
X-Received: by 2002:a05:600c:4f45:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-43ed0bc8db0mr57683025e9.12.1743847574407; 
 Sat, 05 Apr 2025 03:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsJOk8rj9MLj0V7b4tIP01ZxaS8FB506z1sQ+AQ07CjHSmQdux5aDECfP96KRjf7/evRKQQ==
X-Received: by 2002:a05:600c:4f45:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-43ed0bc8db0mr57682855e9.12.1743847573960; 
 Sat, 05 Apr 2025 03:06:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ed7sm6299833f8f.8.2025.04.05.03.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 03:06:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/3] rust: cell: remove support for running doctests with
 "cargo test --doc"
Date: Sat,  5 Apr 2025 12:06:03 +0200
Message-ID: <20250405100603.253421-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405100603.253421-1-pbonzini@redhat.com>
References: <20250405100603.253421-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is not needed anymore now that tests link with libqemuutil.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/cell.rs  | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index ab0785a2692..b3d68bf4a0d 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -225,27 +225,23 @@
 
 /// An internal function that is used by doctests.
 pub fn bql_start_test() {
-    if cfg!(MESON) {
-        // SAFETY: integration tests are run with --test-threads=1, while
-        // unit tests and doctests are not multithreaded and do not have
-        // any BQL-protected data.  Just set bql_locked to true.
-        unsafe {
-            bindings::rust_bql_mock_lock();
-        }
+    // SAFETY: integration tests are run with --test-threads=1, while
+    // unit tests and doctests are not multithreaded and do not have
+    // any BQL-protected data.  Just set bql_locked to true.
+    unsafe {
+        bindings::rust_bql_mock_lock();
     }
 }
 
 pub fn bql_locked() -> bool {
     // SAFETY: the function does nothing but return a thread-local bool
-    !cfg!(MESON) || unsafe { bindings::bql_locked() }
+    unsafe { bindings::bql_locked() }
 }
 
 fn bql_block_unlock(increase: bool) {
-    if cfg!(MESON) {
-        // SAFETY: this only adjusts a counter
-        unsafe {
-            bindings::bql_block_unlock(increase);
-        }
+    // SAFETY: this only adjusts a counter
+    unsafe {
+        bindings::bql_block_unlock(increase);
     }
 }
 
-- 
2.49.0


