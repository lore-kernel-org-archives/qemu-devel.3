Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676C6E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvj-0006lv-1d; Sat, 27 Dec 2025 04:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvh-0006bO-9Q
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvf-00073T-JY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEafbVoFGYyLMte4h/94bksiLJPMQ531LWBYvtDlkGg=;
 b=GnSvCC+uS37lwg1szejW2NHFLMZkzjFab83yOzlyB+IKzo2HveepEnpcvKJKMk4aSifpH/
 sVRVUuCLlDRN/extV013nn7XLrAMSePvRylvaV8CtDhy/j+8d2WKu5wQae2zECzKRI0t57
 z5ggSKnNxy7wUwMMGI7N8iaXwkfDQT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-7MGo14YDORSsuUPtginSlA-1; Sat, 27 Dec 2025 04:49:41 -0500
X-MC-Unique: 7MGo14YDORSsuUPtginSlA-1
X-Mimecast-MFC-AGG-ID: 7MGo14YDORSsuUPtginSlA_1766828980
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso99684525e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828980; x=1767433780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEafbVoFGYyLMte4h/94bksiLJPMQ531LWBYvtDlkGg=;
 b=jQGbxDFs2ZfsYePPGiR3Q0SpKNpTX9Y/OwtYYXWYeNQ5le4DIorT9UBDY+gmWeioCN
 EC4b4xr7YfBU9jUAAk66zOkBepI8dRV6/Nf+fNTW+yCa1T/ibbXPR3hSmAb2rMm+Y1ym
 yKYNOwFGm3vbcCTQ0l85aPdutjUEW7kjRkmGMJK9FxYLZzY6Bt2/JIc/ZDDd6fUa90XC
 3bGJTdd7Gmgyu8ivKEYOw9InDR+RjNoHLALmX9djwurBrpAzIyINNBJgHK+eL95gpoO/
 PS3L5T+I7CStXxchNHvGqxeIHVfZZynlRoO0egI7NDniPLGbBAkdmny6bBJLlDqF7mAq
 NQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828980; x=1767433780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vEafbVoFGYyLMte4h/94bksiLJPMQ531LWBYvtDlkGg=;
 b=cF3/0CHnZL3i0e5sRXlMq3m6a0RxuSOvlJnLMPziaOwi1bd7RKZ/IIN+J3s4/o+8HM
 eQZtsv/V6Us2kN00M0TMtWMT/rkXOkIP0NziXmN1syrFNlucIu8FQyp3NCNhsnORtu2W
 Ydj4R3miAP+et9MXg+6olcvrMxlCMxG17U53UVqifICU7UX2/T+6q9EU9Vd4fmtfCXCs
 j1W6TI8bhqcW3AJiFfLr2VIUWClP2EF5KgCctx549PlELsrfOCEmX7BlettZf21/5wwf
 zvXHD5LrL9CekOi5QOLqgf2bEkXCz/zV4nkk/c7l20QGg2HzyYzSrT5A8BunAKJiDGYE
 wecw==
X-Gm-Message-State: AOJu0YxGAIfq0pNc1jTN4TySOIiXUHK7DqYZ2jHmEKpWaJ0gd7ZYmUnJ
 G/WwEaLxePIkGvg0sP6gcOGamxQF9c9lvX29WgOwqDrVhPwu4Nan8+LI19VupHTJQ0l+eIsKWIx
 UK6uxl1OyzlF1UiY7JZzfwjxycjwPpJ0GViguO6cZfWYAT1p04E4ijpbfGjb2sNzqkPT0M7JOdd
 Bw7t/I6vEu++ZOgKxf5KLevFcDRWo3CRssVvsb+3tJ
X-Gm-Gg: AY/fxX49U1NvyhYBlMyBaW7YkPDE41kZTSdxUbnZe4f3QvhhRhpiS4naiGnfaWnPPN8
 JGzvd5DSdsBDZSC04A0DEI25xmap+0Rn5FS3Y0DyVU4dnXGCuSgGKzV4zR4LiHRwa8/wwi08EMA
 M9qmWQ23KGIzEIr0Ul8dgttuV2cyJ3rrRDMbEi9XhloUbo0QwxQL4w7DkxmbP/+hJSp4rn/YLdP
 FJSeshuKgAvcIpNAJ1Gr5kIt+2vsL8On3z3BvqC7mVg8oRyrzcJIm1qzSlNkMhionJUGH5N6dOJ
 1pIcRzJtsz116vcRVcW4bZ9lIryferWx/+CFT48cqeW8pExurLGg6XKA5ukI/BqiH77mrhO5ljt
 ZyLs4G+F+YcT3I+ybs3rpNEU3IVM8EDLFsLuwFVRJ/RX0UlmU3Ve2z0exJQXTBcZ/nL0MnFPd3h
 mOcDIdUBS5jLwIE/I=
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-47d19566f0dmr280439665e9.13.1766828979928; 
 Sat, 27 Dec 2025 01:49:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq40utbYsa880r+AQWCp4ZfyIsSsvFGDfikbrf+5XXfHgQDBH5f0pqJFPome/MU8jVCNaFDw==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-47d19566f0dmr280439455e9.13.1766828979473; 
 Sat, 27 Dec 2025 01:49:39 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm50765730f8f.37.2025.12.27.01.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 112/153] meson: let Meson handle mixed-language linking of Rust
 and C objects
Date: Sat, 27 Dec 2025 10:47:17 +0100
Message-ID: <20251227094759.35658-38-pbonzini@redhat.com>
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


