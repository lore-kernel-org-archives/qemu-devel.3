Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E5ED11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwJ-0007kc-AG; Thu, 27 Nov 2025 08:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvr-0005gD-9O
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvl-00028q-Ap
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3KQ67zMHkLC6e0eL/mpugWGJ8PZCERDSAdDuM8oV1k=;
 b=bp/UcrOp8WjanRO2BPAIWOwvsel/nGC/nt9seCtaxV58AyLcs35azSgwL22OHObf+caTbR
 kTDZvI2v9ry2lwRBf0A00fbwtfAo0d7qmPL8xhzWQKe1bRfWE0gQ24Oszyrhykgz6e14sp
 VTHJ0YBHuhxJb615Nf+AEXcn/uDnmCg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-st1u8evLNnyj9pZ1422k_w-1; Thu, 27 Nov 2025 08:21:02 -0500
X-MC-Unique: st1u8evLNnyj9pZ1422k_w-1
X-Mimecast-MFC-AGG-ID: st1u8evLNnyj9pZ1422k_w_1764249661
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b764b80358bso78125766b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249660; x=1764854460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3KQ67zMHkLC6e0eL/mpugWGJ8PZCERDSAdDuM8oV1k=;
 b=r+1pLT2bgnuz2foxYvpXbqx/LP0tAoW/djMOhxKNJD4yjJUXtyKblRRJintwagVKFA
 ROpSeuiMA314yng20jSYyonbDufooyXfTrYPK1bBoMXrSPeJIuyz3QvenCRf4Jc/HjJO
 40J5S1rwGDKqtaeItuQg58Mjoc3a99s3B4npBNjC1dPgDWPJu9W3K0KBNYbJyAxOiV1g
 Nx8YeldvKh0uZgDZ1ip4cC2FW7liYnGp6fd24gXc4bkTsQ9wtU5Nh8UyndYBk3OaVUGg
 qN9VBiYc6qth8eJ6/V83RTFxP9GhDFvJjOo14+ymEYDtPsLF4eZKxaZHm8GgVndOw0UW
 GJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249660; x=1764854460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v3KQ67zMHkLC6e0eL/mpugWGJ8PZCERDSAdDuM8oV1k=;
 b=WRGtQ74s1lPOOFEF/0GoAaP5D2V3VS4z7h5miyLT+y9Ag0oVeNiBUZOYXuv+YRtU4O
 zQwAkxlT/i8t+U87/IdLBDRoDOcdWiWGrTNT31QczIq5B5sS+OKH6/1jpJlAkh3zyXjC
 FKwTyiXgqAXe565MhTxO2JgPvjUMxZBXhrTmcyuFa62lBJCk+wZUeXdSoF/5mFtLj4de
 QyMIa1/Dc3ooRvbsgxjsh2I2zsBSgwvF71kRlocvich0uc8f6QKqPnJUgVO7v/lVK3PX
 LfyuBo37knHtfGWnOPxy1Ypm3Gs6du9wVI0lQ+8kwyTijSDKqn6FDXY4B7Ry7AQfyV28
 SQgQ==
X-Gm-Message-State: AOJu0YyUTNNppIsYvsVkMWol3YGYKLIO4WOAGlivuU5huT/+O5jUuqoi
 N1xfltDbePI9jJz83OJTdJsOncTgz1IyZZjLaTeTg+XCn2GAoboKH2P9PS/fXCKH17fQ4omUJQ5
 pznfmG993Uu6bMcxdvme1PPky7lbyyUFEqG6ulygaRL5GbY7PYIfOKDaS97Dr8gBBVuIsccxprO
 lnmBM6cnJcaZJejebsVcVoFFjuIflxXPnUKrN6UTUk
X-Gm-Gg: ASbGncsV4YTtgklGGHLkUvspNk88YpYISQ5iNPnphxo8YN2FLJe2GV70UNBCQeLwKGv
 za0JrLZgC4cSNgJJ63zzC4wbcBWFNO8SLCs5mCqF4nck8uHe+/YWcZjZePE0UHJpKPCvihk2NLF
 wtG5VSRH2O92XewvPv6J8O2T3k2ayRTnzK07OlIoJ/w/EgXGJlrghNnOcMmtm0MtXarDUY04xMy
 qXca2NQRqsCEOnFduN/TZRbfTUubwLatD8DAIinWVucmT3bw60J4h93zE7HI8+QINB6ZSdm1hTN
 L8PXi2TLy9yfaeGAbakBDPeZwQwyvbprg9Kvz6OiIVb1eSMOX3LdP55omZAMiCSFMH9e9X2sDBI
 YbCWCtdQMdDEEQL0kZ2mB8GjFhbQRy9W4bzvMo/t9F5qKUlvj5CJk7MLJMcMxsl8wVhf2Y6nxu7
 xCQdYT95MhkLMTx14=
X-Received: by 2002:a17:907:a08a:b0:b73:6b85:1a9a with SMTP id
 a640c23a62f3a-b76c53c3047mr1130346966b.21.1764249659881; 
 Thu, 27 Nov 2025 05:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+dX20BcpzNt6Shwzf6B0ooNdSdSBgJcc/1t4wum4wd8ZO1guQS4/LbUufQfIfuqAidBX6hA==
X-Received: by 2002:a17:907:a08a:b0:b73:6b85:1a9a with SMTP id
 a640c23a62f3a-b76c53c3047mr1130341366b.21.1764249659326; 
 Thu, 27 Nov 2025 05:20:59 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5162bb6sm166980166b.12.2025.11.27.05.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 9/9] rust: only link the Rust part of the code into devices
Date: Thu, 27 Nov 2025 14:20:36 +0100
Message-ID: <20251127132036.84384-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not include libqemuutil in the device crates for the same
reason as in the previous commit.  Static libraries like qemuutil
are sensitive to their position on the command line and rustc does not
always get it right.

If rustc places the library too early on the command line, the stubs
are included in the final link product, which results in duplicate
symbols.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build | 18 ++++++++++--------
 rust/hw/timer/hpet/meson.build | 16 ++++++++--------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 33b91f21911..9c0e8290e9a 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -28,20 +28,22 @@ _libpl011_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _chardev_rs,
+    _system_rs,
+    _hwcore_rs,
+    _trace_rs
+  ],
   dependencies: [
     bilge_rs,
     bilge_impl_rs,
     bits_rs,
     common_rs,
     glib_sys_rs,
-    util_rs,
-    migration_rs,
-    bql_rs,
-    qom_rs,
-    chardev_rs,
-    system_rs,
-    hwcore_rs,
-    trace_rs
   ],
 )
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index bb64b96672e..7eb758ae347 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -3,15 +3,15 @@ _libhpet_rs = static_library(
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [
-    common_rs,
-    util_rs,
-    migration_rs,
-    bql_rs,
-    qom_rs,
-    system_rs,
-    hwcore_rs,
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _system_rs,
+    _hwcore_rs,
   ],
+  dependencies: [common_rs],
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
-- 
2.51.1


