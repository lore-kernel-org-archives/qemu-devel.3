Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB7C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwu-00086m-Ic; Sun, 09 Mar 2025 06:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwr-00086C-JJ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwq-00043D-2T
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQFYgL5OvkIroXqJVu4wnMdYvtwWSlXNwP+wGqmQy7o=;
 b=cEZZK01HQAeUVcF1MIbpY3PXmN5cYC8O0PRinTqpBGHxkirgM8bytihkkhnuaaJSUJu/+3
 D+G99tJ2Brx6b+lKibgkOG/S97pBVQJWgY/uSouIt/6nlN+UlMLyunlUNgDvFAHC/Vk3sK
 RfKe2MenTl5n+R+AMhwgq9Q6ClegCUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-sgc4Zv6PM--BMi1USbMh-w-1; Sun, 09 Mar 2025 06:31:53 -0400
X-MC-Unique: sgc4Zv6PM--BMi1USbMh-w-1
X-Mimecast-MFC-AGG-ID: sgc4Zv6PM--BMi1USbMh-w_1741516313
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131851046so869601f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516312; x=1742121112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQFYgL5OvkIroXqJVu4wnMdYvtwWSlXNwP+wGqmQy7o=;
 b=C90L4imPSNubAsmJg0DdPCN/Kc64qWsztAfhE3LelRuZGyk4nCedut3HQJIuulvw8j
 0gx8/jMR6ReHNnOvaIBFefvCEITW1CTBH3+sUxvLJ5c7ytrq+kxJrnEt6FLHSBHYj6Rg
 9Q2dV593bU4NHfpOV+RMoAHdo7moanpGBq9OP7FWoF15ivPshzlxCf3e77VDL33LSwFd
 6pSdupcezclvIZBhTTGjIZ2ICPy66U+VXm14DmSBZ9j3MBw44hR9Cod2+whE4KUoKuCG
 Qg0CG+0hz/l+aw3sWE+GD/UYubjcNyYieljoS+mZbRQ8r5sfdp1Slb8i4Y8EpvYixGjJ
 6Jxg==
X-Gm-Message-State: AOJu0YwdFmC3vSxalMTtLrN3o8SYx1VTC4zMeVJrhwHgOV6c6bmJS5iM
 jGioX+UBnel/qGyTJbQEF9Bp/1vyWNDuVVF0ePKo+X3EFkgywnKq6Oj6Ueb4gvGdAR1LgdbvZwe
 8EP84uq+Hh1G71vzm84JX1QkTmEuH6mqVvM+UDzjq9WvGBrLUsYJwyLVZ9g530pN/iT/2kwrs1S
 JhVBXjSnXmrGhpToLi3nyhCuzp6gD6xdMCE5UBAi8=
X-Gm-Gg: ASbGnculxDF4kBioIXQmjOp2yrvuR/KOfD3RhSHnlqdk/igoXaB/VvbqmtzZFPKWjho
 dSrfXqtjr92Cjk0y7x08iP8vV1dDTRV9vleoJPUnygBt6LzSvIV4JLAJ3S0Qf7D1se+MuNLOzQA
 l7F6c20CVSIXSnlxi3HoE92jKq0oC6y1efcMzLaZ0QTUexrZrAoNtQxDKbNVv6tvUFWUxLF/C3w
 vWRCrIHcdJ6QTZYWUnuvt1oN7qBYL+fYlrXOWZ7pVJVF/VFJserVVfw35lOS4f7dBOwtipmoGDr
 6nUAEcfAny+KrxVT9ZX2wA==
X-Received: by 2002:a5d:64c7:0:b0:38f:2856:7d96 with SMTP id
 ffacd0b85a97d-39132d05fdcmr5696771f8f.1.1741516311977; 
 Sun, 09 Mar 2025 03:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCO6TT+AKB+eZ9XjXxviPBqg8zAPsrPqdDOO+q5CXmhHGGaBLNxE1LLFkxshKbXCOnraZSUw==
X-Received: by 2002:a5d:64c7:0:b0:38f:2856:7d96 with SMTP id
 ffacd0b85a97d-39132d05fdcmr5696759f8f.1.1741516311565; 
 Sun, 09 Mar 2025 03:31:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cd62sm11289481f8f.46.2025.03.09.03.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/25] rust: chardev: wrap Chardev with Opaque<>
Date: Sun,  9 Mar 2025 11:31:08 +0100
Message-ID: <20250309103120.1116448-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 3 ---
 rust/qemu-api/src/chardev.rs  | 8 ++++++--
 rust/qemu-api/src/qdev.rs     | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 26cc8de0cf2..c3f36108bd5 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -31,9 +31,6 @@ unsafe impl Sync for BusState {}
 unsafe impl Send for CharBackend {}
 unsafe impl Sync for CharBackend {}
 
-unsafe impl Send for Chardev {}
-unsafe impl Sync for Chardev {}
-
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 74cfb634e5f..a35b9217e90 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -6,9 +6,13 @@
 
 use std::ffi::CStr;
 
-use crate::{bindings, prelude::*};
+use crate::{bindings, cell::Opaque, prelude::*};
+
+/// A safe wrapper around [`bindings::Chardev`].
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct Chardev(Opaque<bindings::Chardev>);
 
-pub type Chardev = bindings::Chardev;
 pub type ChardevClass = bindings::ChardevClass;
 
 unsafe impl ObjectType for Chardev {
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1c4a67b5728..18b4a9ba687 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -334,6 +334,7 @@ fn init_clock_out(&self, name: &str) -> Owned<Clock> {
     fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
         assert!(bql_locked());
         let c_propname = CString::new(propname).unwrap();
+        let chr: &Chardev = chr;
         unsafe {
             bindings::qdev_prop_set_chr(
                 self.upcast().as_mut_ptr(),
-- 
2.48.1


