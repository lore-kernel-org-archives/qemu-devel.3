Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA01E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR6-0005t4-04; Sat, 27 Dec 2025 04:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR2-0005c9-UV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR1-0003b4-8K
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LinX1JQiwqc2ikT9Actgt6zsDgwmjLDHb98Wkwcyz80=;
 b=fkCeu0uR8Dq2wbS19lEUAe2v6k4eUUtWzEGL12XAUfDX/k9gpog4D+CRyvOb2oxiGDtTU9
 24fgvD0hkF3mFzI3ORqoBXcd3fSA+RmFcWaeTrCMli6Gt9PjQMKdftCA5wC8HxvLwTY3W6
 EerQ4OyOgCJLuXw3LIx3G1Knu+H8MEM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-9dw69hg8Mwur7C8SQguAaQ-1; Sat, 27 Dec 2025 04:18:01 -0500
X-MC-Unique: 9dw69hg8Mwur7C8SQguAaQ-1
X-Mimecast-MFC-AGG-ID: 9dw69hg8Mwur7C8SQguAaQ_1766827080
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47775585257so54467625e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827079; x=1767431879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LinX1JQiwqc2ikT9Actgt6zsDgwmjLDHb98Wkwcyz80=;
 b=sNnJyG0YbIvtvqQc4yu7MtvHPs0eU/FvLZNvg+xnIf5r2YIX05ZgGWDLy5kp27xagL
 No9UZO8OuV+jcGjCwx/8Su8aX9CvpWxxSKLNoIWP/1qxULkI37io4XhKcP6BlttSkOvY
 RJzEOXUDteNfzTFMevVTUXbUP06lGupTSz6PqdgKXZx4d/EymI/CDv3NyGObrd3xoonX
 jfIzTZiEYbTiqn6sS92fyX+2NYz2SrCIL+XF4JTKed4QTp9jroqeCtmVKJzB8JQS8UeR
 JQATXfi7YdRxT3RdN0XwixrXKSl3vtU1pbD4GoSNjORV1Y1QMqHdmAQFHye4dXKkFAPB
 JTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827079; x=1767431879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LinX1JQiwqc2ikT9Actgt6zsDgwmjLDHb98Wkwcyz80=;
 b=D8+iMhlkV1S9hlJOiIYl16sn8HTjN3m0vUln+nT+7bd0Z9QhDIa9MDWc55ICRXfa5W
 oI+rtI2FU38Wyz2s5pLg2BKXMfXxosb/DJWkqzqVzouNT1j6Vqv/1jJV8NxwY3BxUaMS
 hSTVLaCgG35VXudzLTAlPDdJQQQpvPagp7lpvklCAdQVuDkq3H23uDn8fslFHpNZBDz4
 bY1avAu0NE+LXsozpzsuAaWhj+boB8C6QhZDyIIuvHC1Qu1hkOTdiB/JmC9qtJTQovXL
 4HW/6icx82KxIDR0rz/JYSq0GHzYthqhnfDlgn3qkGIqdecR2cPq+w9BnHaeNtaMbgKE
 SVxA==
X-Gm-Message-State: AOJu0Yz6TWQKkXeaqlhYhY3jfRPzgBVsbEDCOvXNnzUh+xHxqJ219DUj
 IO7Lft40FG8/FOYuIt6dCt3N7Oj9sBSJxtpf10jxTjvL5zSzFuwwN3qMx0YpDF0TTpUdox4OB+E
 vaXULTjYj28Y1bDvVRMHrD82WHotzOfIbYXfheF1ECzIwLp9rEw/yVTkYDWo/hu+PAtGozfLpJt
 rH3q8uIciPOhWW+ckpjwzFglzwT/cS/VCiIX5eRkcq
X-Gm-Gg: AY/fxX4sYL0RTTetR01OJS5m1SoVdcKxD0ZGUjhA2XRP9kcDMtGugK4DC/rNgmbRbZP
 0ldwuUYizBIiuA8XbIAhUy4exgnYrqSYLi56DhDRXmCd+262OAkjXbOEYKKE7Zj5iTrwpZm2vqf
 HBeJUU1LBCTuwpoLYGrln7dbz2RqLNc7Ub88nSSASAzR6aQIdsn/DTUtVlO81EAAiaTax77hGGu
 eL81Q/wFF5hBDkP9ivQI3SlR5CgYq0zaEkvEWJjAa7flA+1k4MaNyF0WBEm4gyKmXUcFet6Gj+j
 wAUGj9avKK1prSQ/UPDl4tn4AkAMa+Lgn2ScG9DWkd7Ok0O/3zMxKP2Bh65fNrMTaQyYd6ytfOa
 MIjkfUYdalnPJTAyGhvhc1urtkHbk4VEPEWHL1QS4VDKNVUrA9sG7rA+KdsfGcvqNHBhFTb1Gy/
 1rXDdQOMENBslI140=
X-Received: by 2002:a05:600c:470a:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47d1958a61fmr275526105e9.31.1766827078856; 
 Sat, 27 Dec 2025 01:17:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFpmz/kkWzre+yKSsaqZMtgvSe4yE86hi47PQ3yn7UEscppUy/QAmNtPPhp4p/RcW9rwiiwQ==
X-Received: by 2002:a05:600c:470a:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47d1958a61fmr275525865e9.31.1766827078362; 
 Sat, 27 Dec 2025 01:17:58 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82f6asm51482780f8f.27.2025.12.27.01.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 050/153] rust/bql: Ensure BQL locked early at BqlRefCell
 borrowing
Date: Sat, 27 Dec 2025 10:14:37 +0100
Message-ID: <20251227091622.20725-51-pbonzini@redhat.com>
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

At present, BqlRefCell checks whether BQL is locked when it blocks BQL
unlock (in bql_block_unlock).

But the such check should be done earlier - at the beginning of
BqlRefCell borrowing.

So convert BqlRefCell::borrow field from Cell<> to BqlCell<>, to
guarantee BQL is locked from the beginning when someone is trying to
borrow BqlRefCell.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/src/cell.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index f4bfa697d32..b25906a6503 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -142,8 +142,10 @@
 //! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::borrow),
 //! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut).  The
 //! thread will panic if these rules are violated or if the BQL is not held.
+#[cfg(feature = "debug_cell")]
+use std::cell::Cell;
 use std::{
-    cell::{Cell, UnsafeCell},
+    cell::UnsafeCell,
     cmp::Ordering,
     fmt,
     marker::PhantomData,
@@ -378,7 +380,7 @@ pub struct BqlRefCell<T> {
     // for std::cell::BqlRefCell), so that we can use offset_of! on it.
     // UnsafeCell and repr(C) both prevent usage of niches.
     value: UnsafeCell<T>,
-    borrow: Cell<BorrowFlag>,
+    borrow: BqlCell<BorrowFlag>,
     // Stores the location of the earliest currently active borrow.
     // This gets updated whenever we go from having zero borrows
     // to having a single borrow. When a borrow occurs, this gets included
@@ -427,7 +429,7 @@ impl<T> BqlRefCell<T> {
     pub const fn new(value: T) -> BqlRefCell<T> {
         BqlRefCell {
             value: UnsafeCell::new(value),
-            borrow: Cell::new(UNUSED),
+            borrow: BqlCell::new(UNUSED),
             #[cfg(feature = "debug_cell")]
             borrowed_at: Cell::new(None),
         }
@@ -689,12 +691,12 @@ fn from(t: T) -> BqlRefCell<T> {
 }
 
 struct BorrowRef<'b> {
-    borrow: &'b Cell<BorrowFlag>,
+    borrow: &'b BqlCell<BorrowFlag>,
 }
 
 impl<'b> BorrowRef<'b> {
     #[inline]
-    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRef<'b>> {
+    fn new(borrow: &'b BqlCell<BorrowFlag>) -> Option<BorrowRef<'b>> {
         let b = borrow.get().wrapping_add(1);
         if !is_reading(b) {
             // Incrementing borrow can result in a non-reading value (<= 0) in these cases:
@@ -790,12 +792,12 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 struct BorrowRefMut<'b> {
-    borrow: &'b Cell<BorrowFlag>,
+    borrow: &'b BqlCell<BorrowFlag>,
 }
 
 impl<'b> BorrowRefMut<'b> {
     #[inline]
-    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRefMut<'b>> {
+    fn new(borrow: &'b BqlCell<BorrowFlag>) -> Option<BorrowRefMut<'b>> {
         // There must currently be no existing references when borrow_mut() is
         // called, so we explicitly only allow going from UNUSED to UNUSED - 1.
         match borrow.get() {
-- 
2.52.0


