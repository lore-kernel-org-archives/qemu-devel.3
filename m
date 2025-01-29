Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ADFC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3ZY-0002xQ-Uy; Wed, 29 Jan 2025 03:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3ZW-0002wl-SL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3ZV-0006Wf-7n
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738139836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kI2fmnmJgUGnjqtQ5jhxKS9I/PiFpAzsz1KC537irc=;
 b=WTmsxbFa+KInwVLqvRiEdUi4oZXmLsDflswYkDF8V/S6SSfiWbnDNJzqgMmt9HSPxcNQeV
 mji6AyHk6j2PokhJdWde/wxUnl7X+yD/HBdMk5kaVvnQfyVynEYCY/2aq3V7wLObRHrHw2
 fEsXnd/VbNkrTDRVhX1QYzxm0Khf4Uw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-a4ZrR0dkPMGEFXi_XiKOdQ-1; Wed, 29 Jan 2025 03:37:14 -0500
X-MC-Unique: a4ZrR0dkPMGEFXi_XiKOdQ-1
X-Mimecast-MFC-AGG-ID: a4ZrR0dkPMGEFXi_XiKOdQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so3527350f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738139833; x=1738744633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kI2fmnmJgUGnjqtQ5jhxKS9I/PiFpAzsz1KC537irc=;
 b=IZ7pm7ISi3WMYsgl+shIm4bULreX0rLTKhKSnuLMGg8bw9DVhDW3Q3gOdNaO+bdfpk
 VfdS8E09dh6wml8w6zGkUbNeigEDPmTHYEdE7SioE21R7iRonygOBP3UVVxIzHC+Cwob
 z3dlSrVS5VYJx6mZtx9i1mb9VFPhNf0ppsth7bjRUCuL15wNm5cXcAReI5NDzLpkNYs8
 ZTcg8PhqhjuIJV6tmn11stc5d8/x0/kWfyy2R4ocqt8p/c4Ywn6YnuQuvaOUjfjz2rmV
 ng5UZ+fK2QLkcfFzEuulXwwQ+BtYTSs0ve7VmysfNtGQ573XuqbjnuF6tcdpvSVJtEK6
 QF4g==
X-Gm-Message-State: AOJu0YxZcbjFYytiHUdAB0785DZYOESkHeGFD1v0MIl51Ukwsr7rfEGo
 wlb9LrBv7Z1Du+kQR2fl24Ke3ZOvtDtwa1wVXUA4DKP/qyYrSRL136a1hNB6V4qU69rU0YsNNTR
 I1AzckhtpLCKj1bHvH6Er3/aUmtyGTYCHvzois8N8BmgeQVos5aEi7JNnFLGOIwtSweJGpg+alS
 ZD+Yz/THB8BRgZdAjoBja8aB1BwcM5DK9jKhZtNvU=
X-Gm-Gg: ASbGncuVnNbElib8Zv7uH/gkgAVeC5NQKJ4e7yTxuXLoH1gUGrdFCjoLn+LvczE1gXj
 n5UwrSb5ipPIaYvnq0us3DaJiV8qpqqfzRYuZfds2ZKT2rpyNXQsKcpbQig3K80z1pAqAnaFayW
 mazCSfoUSMx+fw0I+BmHycDvJErT/FTCxsSamp17Gf2mTOF2qWgIJ7oxxvZXkGBH2qHGd/1tkPn
 RA5isHEKwDcYhG88I08YfriBnXoLw0e3dxCM5ovRpkLqTXAYuS/wbenRql/p8L8syh5FRNrzjf2
 MNh96A==
X-Received: by 2002:a5d:64ec:0:b0:386:3e87:2cd6 with SMTP id
 ffacd0b85a97d-38c5209018cmr1720068f8f.38.1738139832991; 
 Wed, 29 Jan 2025 00:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvvrO4BLXQh9+pbCl+W9wYsMvVqRAEChnfpEN5RzNO87Anj0E6WrQQjnhiBH+RSt9V0/6zfQ==
X-Received: by 2002:a5d:64ec:0:b0:386:3e87:2cd6 with SMTP id
 ffacd0b85a97d-38c5209018cmr1720043f8f.38.1738139832485; 
 Wed, 29 Jan 2025 00:37:12 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc13202sm14625905e9.5.2025.01.29.00.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 00:37:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/2] rust: include rust_version in Cargo.toml
Date: Wed, 29 Jan 2025 09:37:04 +0100
Message-ID: <20250129083705.1321407-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129083705.1321407-1-pbonzini@redhat.com>
References: <20250129083705.1321407-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tell clippy the minimum supported Rust version for QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.toml          | 1 +
 rust/hw/char/pl011/src/device_class.rs | 1 -
 rust/qemu-api-macros/Cargo.toml        | 1 +
 rust/qemu-api/Cargo.toml               | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 2b4097864df..f2296cad58b 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -9,6 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 8a157a663fb..dbef93f6cb3 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -12,7 +12,6 @@
 
 use crate::device::{PL011Registers, PL011State};
 
-#[allow(clippy::missing_const_for_fn)]
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     unsafe { state.as_ref().migrate_clock }
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index b9b4baecddb..89dee1cfb39 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -9,6 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [lib]
 proc-macro = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 4aa22f31986..a51dd142852 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -12,6 +12,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-- 
2.48.1


