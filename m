Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD47E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvT-0005sI-0m; Sat, 27 Dec 2025 04:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvR-0005n7-CF
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvP-00071X-Jf
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlW7wtP3S7BSZhssQjq1auHlBWMlcMZTjjKdz6k84jU=;
 b=giilRezEO2Md3QzC1bwmHhxhUSCUkkBGpa8CzXv85BzLhT0VwuQc0Zz2NJF7c/zTezKX00
 kSzmPRb2sD0Xc5qNlMDZR908NdhgSLRNcJReck6dY69spogjZBf0ZeFZqHasq8NQV8UHg0
 kiFZdy4skBcdgKTNUwGld8UxBFX9lMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-_lkaos3SMW2H37-_mUh4MA-1; Sat, 27 Dec 2025 04:49:25 -0500
X-MC-Unique: _lkaos3SMW2H37-_mUh4MA-1
X-Mimecast-MFC-AGG-ID: _lkaos3SMW2H37-_mUh4MA_1766828964
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso53729675e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828963; x=1767433763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlW7wtP3S7BSZhssQjq1auHlBWMlcMZTjjKdz6k84jU=;
 b=VWrUzf0SsvT6bHmIBM8o7u3CDMWhnR0aXWfWoUc9ck1vuDXXLDO0tSfSA3/4Eeg7G5
 dUq/GNjHR5hkbDTJEKW+ebcZ71eXSOveqG0GU8Ut56yD6tDUmNGFm6RiX2BCvc7FNmOz
 HcB1+/vA/8gx/gsgKX63HY94miCNnr/iZwItG6YPtSq+Fx8n1Sbs/kLzNmfDINvKyG5I
 VGGvms0ROS+09vXR4HPXrJIOo3/f2Kdq8hzemzi1gxPPADA5G7T5GgZ3vG2Dhct1eO6t
 W/wKulFKPKDar+9+M2meKy0rK1Rzw3AYQB+NZSUR+ltJ0Y5qOwa8e9E5hYKPp6X+jisI
 H09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828963; x=1767433763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TlW7wtP3S7BSZhssQjq1auHlBWMlcMZTjjKdz6k84jU=;
 b=nUT2zKYMZuxvjcdsmJNACXsKb2fkAWYM/16x701I/vZRzLDbPfzF7lCi15B9CSq0J+
 akYIBLsn8A3j0LSAkXIPEEhTDI4tB8ophsJU1YjOsjyOXzPsP6+eK7XWonp2ZSiF5m8D
 l77IiJOhGa08n+d+GMETXSm1lfEROK5W/yQifaeROLy2bSnihaFPLc8DLZjQVpEBIhY2
 zoG6/jb+3jBqlH6Gs87XKnLgGUdAARP04lTSSkJaT8thHTu/elBHSU+hyBcjy8KtPi5q
 Zu52t4Iz/p2/+JQtWkij4/DO7XGFl5P29b/sNwVDdrdswQDngxfNkL0xF6kTP9gWdchd
 phHw==
X-Gm-Message-State: AOJu0Yx+UobyEMca7KyzzrspBNo0rOGxkHHV0uSGVuj3LEGoXEp1wIs7
 Q844AEWkBhfZAVNyqrPWcfQ1HDgZGtC9cI7jfxXn85u0TBYgHcHvcdATDAbpgVHSOqxM8ymLj3I
 ePqUITJl9l8X4S6bQ/ClcjQnxDKE34noH2zt1Ttq30DW+pzf6WcpBSsNTjVMo8iJhQOSvV4hpOY
 28w6nzrcszfZ077svSTSJpGzdswj/dqOptgOunhCMw
X-Gm-Gg: AY/fxX5iUnnkxCN4ICOee7Lb9t+3LE4mm4ffdX1jMZA/yMQ6fBhNVJekuBvw+yjsKq1
 ZvC3KGNu2wzXjoQJ8z331QJP5WxN8Pppn1oOdmswS5kHT9HA2uHHqvrBV+DhgWWeYBQzjQwlDo9
 cjOLynzr7ZSVA32T8nSK0XGGyu8Hhylcuw42q5VqaWhFAUTPo9tAgNii9eHT8VelGJv82e4I62u
 usFFDGIZPlzUWwaryXAO7cRYu4kY2YuydCq8YdSWs8inT1oEh7Oe2e1GY8BArrhWUqcW05vbZEv
 hH4+a53n9PAa3uCzX4DgaFSwB5FOMPZA5PisqCmF0SRzcr2eMsuVlQzaLgypa6LjRcs8EjweZAJ
 2osXrLicfvO3RPPYX9Y/RctspNmGfM9BhW3chvXCbk5+HURbPuWbKMVI8OJOOkXEVFLfftHpRl4
 pnTBIc/yKPhN7nW2I=
X-Received: by 2002:a05:600c:c05b:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-47d1c03867amr202464205e9.12.1766828963182; 
 Sat, 27 Dec 2025 01:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTOqNPEUAnV+SrkuR1C2RHdhjIElAAqPcfi9+BeOCXal0UHYwVj/NHoF9i2PrVxbqh7vxO8w==
X-Received: by 2002:a05:600c:c05b:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-47d1c03867amr202464015e9.12.1766828962705; 
 Sat, 27 Dec 2025 01:49:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2253csm50803908f8f.14.2025.12.27.01.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 107/153] rust: Do not link qemuutil into Rust rlibs
Date: Sat, 27 Dec 2025 10:47:12 +0100
Message-ID: <20251227094759.35658-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


