Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73976D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3Lr-0000ek-El; Mon, 15 Dec 2025 02:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LX-0000bA-Bh
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LV-0000lq-OI
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlW7wtP3S7BSZhssQjq1auHlBWMlcMZTjjKdz6k84jU=;
 b=QMlh0PMWdx82Vju6uCF0llhVAXos+2j8fT3QuMZJ9f5nojz6/ftSU8Hm1GJ6aFWx5qhRM6
 bT8uZ8wjxUjjAEOLk7tDPHLSUp/9hztXCHeY0yVudi9gWtlQ0Do+qmb0tSmZ1i2tFn9BLj
 uDFF6CH1sciTZgtOUs0nnHDVcqFzlJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-8O-r0KKEO7aUTPtVe0GSdg-1; Mon, 15 Dec 2025 02:50:15 -0500
X-MC-Unique: 8O-r0KKEO7aUTPtVe0GSdg-1
X-Mimecast-MFC-AGG-ID: 8O-r0KKEO7aUTPtVe0GSdg_1765785014
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47777158a85so38084575e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785014; x=1766389814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlW7wtP3S7BSZhssQjq1auHlBWMlcMZTjjKdz6k84jU=;
 b=nrRu3HcdHueJP3RG+5SrO3bFnp3GKAItDMKM2jwLHuA53ETXGxiSucbaf/cRHWec7p
 kaOLQJXVQnfX0rFswD6/h+6cyhaC6y5DlAtDPgqgSuccZFBUrDveaz70TU4RUDgXL4Wb
 U9VtoOn7DXl5J4OKnTn+ib4bhugYAyKLekt3VxkrWNht97I+EeZD5yJNxPcrwPM5mUGm
 Y2zRIYTy1atNlMwscFeDcnFZyDIHJCC9QnxVnnlfxWq8JnW+13NnK1udPL63OI52X4fU
 cggfeP7uTXDMfn2VGhqezBldQQSwzWclvv3vn9VWgaMKbgcpzCggvVTq1A3H2JQrU9gQ
 v0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785014; x=1766389814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TlW7wtP3S7BSZhssQjq1auHlBWMlcMZTjjKdz6k84jU=;
 b=JtIblzRD8v6hA7UyZ6hfT27W/y1RLm7DvhdbRf/WcfucI4YKNYLBPx2osUqAuTK5fm
 27SPYo6KqvSSp7UJ0VP6cmJJAcJtfk0ApAHKOZVQWBtKuXkQQmqIUJZCjXL+oYUuuRb+
 xy/OFF3XqSiTndwsaR17jJCJ4/Je2R2Yv8I0eOSpjsXAwyjbOwvhkcA8aUtXoJJSJSra
 RNIo2W/nJ4tIXzGQwHPRavHFaxP385SO1sdAtq6iDkR8VgbUL0rfdkp1+aUh9XoHCB6r
 gafKvCxc4UjfRyy3FMBKhbsAL0R9pxJL3/tDsy+CKGmRSt2wn96YXKs4IcAfsBP4B+0x
 7tPA==
X-Gm-Message-State: AOJu0YxUoM/rM4DsLtSD2jxaEMavc54m88N4uZ/xM65iuTe+LLDZbfwZ
 o/UFCjwIWNPHCHDmWxCC+VSXzjkHIczlaJgP98CNCvfpC2NS6ssJBRjxf6D0d8aikjDBVcW/fBt
 9aAdledS2u595JmLCBW9KEg4O3O0MTcqt5H0BN5nVqzEFfeDqNbZV3Zj5xhMtYcVCMNwmCFZ0Fr
 TLF0dAtzVcGa+Sk+Wdx0CeM+6xI3OTn2CFDjLs9huk
X-Gm-Gg: AY/fxX61EdLBN3ypPJ1N5R9BwyzNlyW5Wr9iItj9hO7fB4LTEX0OD+Mlzvml2Rju1sq
 CvwnjRXItys60vVN+bv5E5TbIYMixb9TN3civKdehiIlmSqnJ91hYM4mPloAXKamZoDr2UkCV4l
 G/lHKUdhHV8qgT71bATPNYgTZ4j8ZukmGq4UpA4cj7sPqtLrEdlQVM3rP6UWF6HFUsxU4z4MvY4
 S4AeH1IEH/qIaabtAeKAFJeXe1Qqli7UI14oDXWw6i2d+GD39PUMfbf9xpXyGsSk6yzmkHTI7l4
 Aw1Be6G4m2xg9c3VSu0yHSgpLg5cKoAjNZhLabrhNV7cGUc1wDo19GKwszk+btL6F5Ozx3VUaiI
 QEbVOEezyb9owhu66YJvV7sLAU6H1pte0pzdp3AYQD8CVZBTRf0Bjeqsgnf+xNplCPBN2ldp+hT
 yxQKd4v+rp09c118s=
X-Received: by 2002:a05:600c:4e91:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-47a8f904609mr104987875e9.21.1765785013747; 
 Sun, 14 Dec 2025 23:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjNGTw3rR71LFrJggoEPZa2W3FOLAe6o0RAXtCN9YS+s1RCdf7zA9dPxCtSG8SqIKOWz8MFw==
X-Received: by 2002:a05:600c:4e91:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-47a8f904609mr104987625e9.21.1765785013256; 
 Sun, 14 Dec 2025 23:50:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4f424bsm173496925e9.10.2025.12.14.23.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, marcandre.lureau@redhat.com,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 04/11] rust: Do not link qemuutil into Rust rlibs
Date: Mon, 15 Dec 2025 08:49:53 +0100
Message-ID: <20251215075000.335043-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Martin Kletzander <mkletzan@redhat.com>

Commit de037ab8d83d removed qemuutil dependency from chardev and util
rust crates.  However it stayed in the _util_rs static library.  The
dependency is also defined as `link_with`, which is fine for C targets,
where the resulting archive gets linked as another parameter on the
command line when it is a static library.

However, when a C library is linked into a Rust rlib, rustc remembers
the dependency into the metadata and adds the library to the linker
command line.

Unfortunately, static libraries are sensitive to their
position on the command line and rustc does not always get it right.
Fortunately, simply removing it from dependencies of any rust libraries
and instead adding them into the dependencies of executables and
doctests fixes the behaviour.

Without this patch the error I get is:

  FAILED: [code=1] rust/tests/rust-integration
  ...
  = note: rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          collect2: error: ld returned 1 exit status

Meson could work around it itself by never adding these static libraries
to the rlibs (after all, Meson tracks the transitive dependencies already
and knows how to add them to dependents of those rlibs); at least for now,
do it in QEMU: never link C libraries into Rust rlibs, and add them to the
final build products only.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/chardev/meson.build | 2 +-
 rust/qom/meson.build     | 2 +-
 rust/util/meson.build    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 54bb2962528..2e4f4670bd8 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -38,4 +38,4 @@ _chardev_rs = static_library(
   dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 551c4f0bf5f..dda26c3f981 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -30,7 +30,7 @@ _qom_rs = static_library(
   dependencies: [common_rs, glib_sys_rs, qemu_macros],
 )
 
-qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom])
+qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom, qemuutil])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 95b44f7c670..98629394afb 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,10 +39,10 @@ _util_rs = static_library(
     ],
     {'.': _util_bindings_inc_rs}
   ),
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs],
 )
 
-util_rs = declare_dependency(link_with: [_util_rs])
+util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
 
 rust.test('rust-util-tests', _util_rs,
           dependencies: [qemuutil, qom],
-- 
2.52.0


