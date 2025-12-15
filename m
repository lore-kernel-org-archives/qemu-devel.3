Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D24D5B16C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3M4-0000gy-LZ; Mon, 15 Dec 2025 02:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lh-0000d8-Dr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Ld-0000nA-Rg
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEafbVoFGYyLMte4h/94bksiLJPMQ531LWBYvtDlkGg=;
 b=cgFS6HPzt/pBY6lV0O5+E2SckP+6hVqtTUXfaoYx5xAqIvwy40lKw09NWB/7Er1tNm12Y5
 5FQhbCciAY4zs1DXwxKdjl8MP7kpIRFof8TYN7IQhzRqZrGrNDSZ5Xv4XG0hl9VKAQquj9
 ThEQETXu1F11kwwghkO4RDmArT57W/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-iCYGXL3uOUSwG6_2V11GZA-1; Mon, 15 Dec 2025 02:50:23 -0500
X-MC-Unique: iCYGXL3uOUSwG6_2V11GZA-1
X-Mimecast-MFC-AGG-ID: iCYGXL3uOUSwG6_2V11GZA_1765785023
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso15222345e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785021; x=1766389821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEafbVoFGYyLMte4h/94bksiLJPMQ531LWBYvtDlkGg=;
 b=nxk3ved4tLYMbSKS/AsrtXqR5fmCLzO1WuapSEbB87lWf8Emx1uL0te5vNrEw8RbWS
 QkSul2O3kAJpIDtKBNLzEx/I6SnW+fDsQZtu6Rr0NML6vdX74kZj1HGJ9WQzO3Z6JRG0
 QUxRztaaY+NwLFEb+YXkRt2mA03GZvhpeJmZx6HdRUtpjNhQTDGJi0wcuQUhb5rxAMWq
 IquRS4v5Q9//patGdQAmlV7q6zGtpWbJh/RKkhJyoGD1uHCEbFaAL2KAMJMTzo/56TAc
 RhK4HOuoVILK0QRA27SL/wSZooP25akC6ANexvpB22mXCGqUmjjLmqRjsdq3LgPbevkB
 OSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785021; x=1766389821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vEafbVoFGYyLMte4h/94bksiLJPMQ531LWBYvtDlkGg=;
 b=JqkhPvwHQaWmpmsjNRu11hc0b39jo49gbZmYb2353FRhCW7wguImynFHYxLf7vg9/D
 Ptr8oAmEEbK5LRVYCJgiO7ZyHbnQm5qKRXDwTPABcPO1JlJXU7FBfdlL6hhKVaZ3Jg01
 M17AeJJ/zfenNk0kyNR3KI4zBMtzex2i2tqamPlfuq5RTuD4NH2QMezIIo0fosLDOyNg
 OFhBwgobmiroyblmEE7VGakMR99CBKaEFtSKfG2PHIX8T7WO3MCFembFdTgNKiTc4Zh1
 PDpqbCIpylQI3K5Z4qe+pYJQpDED5EpImQdOUGwN3hs+Cxe+jC9OtknHZVwE5hzHyWAe
 aSqA==
X-Gm-Message-State: AOJu0YxVpdNhih2OdFD0pXAmzmx4q5rq1Zesf23nKaSYrSIwomU4DtCe
 +0WB6avZF54Evc/HJt+oZvgI7miUUUaxBU0iiA8KeRUXu3wviqfn7MT8iQ+75fkxa5vadH81qrA
 d3r1hBjk27R7VsZcZNMB5hbk76lVVrQ0VHDwyCtVk807asHAgC17beDqWKN1m646Pa3uto7RdWH
 vcKtWfxuQTL6ueu3A1jiAfYEw6qAO2n8I5Sepf3aPk
X-Gm-Gg: AY/fxX5OuGWMJ1nJfwA+Oz5r+8pd0jcmsyO0VZE64UyUGLXk/8xl0avpezabNlayhC/
 PT9CtBXIqmEZK2zqYiH5n0O1gqjY0ylYnR2J9o+mqIWuCSUAKU10PIa+Cw0dyW0OvASFKoWDh+h
 8NK1tf5wHoJClWPgohlKtrmBdsIaAA8KsI1zjLaIVjEByizglG2DTrWRZlAknbqwkJp9tzL5iak
 c4PEkdFJxKh7n8c8FEABscK1EmJTjD1LNvxka6EeInahPBOQmK6SW1zXkS6CzQ7ZGzy8YLJGmXr
 xEfibrlbOFSdrxQvlNlSF5Bw3MuYzc9zZmTGOIPdKOgJCe2hTyDFOQZ+GCvssC2BKu3OYTAEXhF
 oi43FuO9smG9Q5mJep2J8tnK8/njiRZenjDEOJBvshqksBa9ouUEt7MCX1Dd2LPXqH2FZHlAXRf
 VCW4JcrhxY4EOmDsg=
X-Received: by 2002:a05:600c:444a:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47a8f1c20e1mr95104535e9.11.1765785021273; 
 Sun, 14 Dec 2025 23:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSi3cGxhN7llzfl7EE+mi08VkIniHymThWSLQFh2kluklyUzbcMleDmeBHzbbDlZgxLo37Lw==
X-Received: by 2002:a05:600c:444a:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47a8f1c20e1mr95104345e9.11.1765785020804; 
 Sun, 14 Dec 2025 23:50:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4b6e43sm65092205e9.2.2025.12.14.23.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 07/11] meson: let Meson handle mixed-language linking of Rust
 and C objects
Date: Mon, 15 Dec 2025 08:49:56 +0100
Message-ID: <20251215075000.335043-8-pbonzini@redhat.com>
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

With the bump to Meson 1.10.0, C objects can be passed to rust targets.
This way, the Rust libstd will be added by rustc itself in its final
linker invocation.  Use that to eliminate the staticlib and allow
dynamic linking with libstd (also introduced by Meson 1.9.0, but not
for staticlib crates due to lack of support in rustc).

The main() function is still provided by C, which is possible by
declaring the main source file of the Rust executable (which is
still created by scripts/rust/rust_root_crate.sh) as #![no_main].

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                     | 19 ++++++++-----------
 scripts/rust/rust_root_crate.sh |  1 +
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index e2de3832ac3..3790cf15f51 100644
--- a/meson.build
+++ b/meson.build
@@ -4352,25 +4352,22 @@ foreach target : target_dirs
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
+  main_rs = []
+  crates = []
   if have_rust and target_type == 'system'
     target_rust = rust_devices_ss.apply(config_target, strict: false)
-    crates = []
+    arch_deps += target_rust.dependencies()
     foreach dep : target_rust.dependencies()
       crates += dep.get_variable('crate')
     endforeach
     if crates.length() > 0
-      rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
+      main_rs = custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.rs',
                               command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
-      rlib = static_library('rust_' + target.underscorify(),
-                            structured_sources([], {'.': rlib_rs}),
-                            dependencies: target_rust.dependencies(),
-                            override_options: ['rust_std=2021', 'build.rust_std=2021'],
-                            rust_abi: 'c')
-      arch_deps += declare_dependency(link_whole: [rlib])
+      main_rs = structured_sources(main_rs)
     endif
   endif
 
@@ -4394,14 +4391,14 @@ foreach target : target_dirs
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
-      'sources': files('system/main.c'),
+      'sources': [main_rs, files('system/main.c')],
       'dependencies': [sdl]
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
-        'sources': files('system/main.c'),
+        'sources': [main_rs, files('system/main.c')],
         'dependencies': [sdl]
       }]
     endif
@@ -4410,7 +4407,7 @@ foreach target : target_dirs
       execs += [{
         'name': 'qemu-fuzz-' + target_name,
         'win_subsystem': 'console',
-        'sources': specific_fuzz.sources(),
+        'sources': [main_rs, specific_fuzz.sources()],
         'dependencies': specific_fuzz.dependencies(),
       }]
     endif
diff --git a/scripts/rust/rust_root_crate.sh b/scripts/rust/rust_root_crate.sh
index f05b8d02108..13ef7c1be5d 100755
--- a/scripts/rust/rust_root_crate.sh
+++ b/scripts/rust/rust_root_crate.sh
@@ -6,6 +6,7 @@ cat <<EOF
 // @generated
 // This file is autogenerated by scripts/rust/rust_root_crate.sh
 
+#![no_main]
 EOF
 
 for crate in $*; do
-- 
2.52.0


