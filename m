Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C55DD11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwF-0007KO-SE; Thu, 27 Nov 2025 08:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvU-0005MW-Uu
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvT-00024g-GL
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ej+NEQo6jms3lrgLCYBMX0aiWkPrDCX/+jDp/JUrTk=;
 b=SU32pi3t0KBfPXFAKlxxMfvlH4Anw8w/PFpXvwVX2PTa9iLXYn+W+WvSinV2mhpwJlJp+L
 s0cApf5g4BI/cHLId3U3P78QJE6zB8VAuSlGi37c4Rz9LglCxLO/OFl3ipbFOJTPXmsk1i
 /K8o8sLXe9zhSvOS6O2AA9qEzXm7OkQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-C6CEk6OwOaieozHpIgiyiw-1; Thu, 27 Nov 2025 08:20:45 -0500
X-MC-Unique: C6CEk6OwOaieozHpIgiyiw-1
X-Mimecast-MFC-AGG-ID: C6CEk6OwOaieozHpIgiyiw_1764249644
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b7270cab7eeso90149466b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249643; x=1764854443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ej+NEQo6jms3lrgLCYBMX0aiWkPrDCX/+jDp/JUrTk=;
 b=oGyaSaWiG613hNpHAoX0RtLi1XODwIODf+G/ZyfliO06N/G+UncRv5C5HYqV5DFdsp
 xh1gaGXf5qlmKmd+Pv/ujam6g8RIL1CF/YYLCmH+TP1aIrMpKD68fPpvrsgcIzkEVdcF
 xyUTaLHYeuie1gyy8kYJAC85s3lWvPqqBKd6bEL5BSKjfdzjUHK8K/nhAdCl2iuIEGS0
 XgCBwSLILdQjGM68mN/gSkg4Osd3zZW/FK0S8E7HnlwSoGBohpSJdjJvFfyELHW1sslz
 tnIbG2ebmnh5dsybGJ15ROhRxBgfkmkdVWwhyj73odm2fCIz27ps5crg0q4yDZq36i0m
 7v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249643; x=1764854443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Ej+NEQo6jms3lrgLCYBMX0aiWkPrDCX/+jDp/JUrTk=;
 b=shPDo9J+PabuTGbHM3/+ZrEyBCTIhWb0ZjMSOB03vD68dlqSLhnAqgFtZ6+8c8Xn1Z
 LKFmMDf0a1cmHumUMjDX6Z6vxDBLrUc4mDEFFGZ5/qDmtYJkylV4C4to+qyWs+agwNWB
 FAGYj8mW+d82mJsvMcvU8JoVB3/Y92b5twKj7G/qZSY/S2YOVUK7HPgC/1c1h5vSKg47
 tt43SeY5XCehSCPNvFZRl71bBI5uNEvUtWANR9r6Zp2Xn+ZTW+rv2wkbcdF/jFBFatUr
 IK9d0pXziAKGw7IN67En/xrePSIYwzuacI+FsrPkHmWYVAUscPzubCcWLn1iwMkKiGzx
 0LgA==
X-Gm-Message-State: AOJu0YzX2WRWPeqhZp+BmyKHHlLqbu3X2NiwicCc5YI9pQFDW3F3MBTr
 59JTixTc7BP2r3N7EJWVtXcGBZPKhCOmmCuAkHVo3d/k5fg+cdVsp9iFr3FKru8lMkGgUbC/oh+
 +ZcGQl+2nzOtGnXAccDlX0cGGN4E7aa/E1HCVkoV19aS+qrBWC0J/JNlmWiVB9vS3F1NOksVnKk
 jxMtBbbJb6Y4QgSXfyUI+P+Vwx/sG5hUom/2N6Pzro
X-Gm-Gg: ASbGncutY7u+dt2NlcIaL6+udhvdM1inihKIlaV8WrQHxscnSgSOxO/elFogUg+72yl
 to4uNRr9kCOEVq6SQwuWp5AOGJVUHxtQDvxZty0UYSiCUIZADriU+D9bzf72z0Vfw5/7P/OdhU8
 NiZXfqZDd6h2OK4h+21Q6Q/NUC0KCsebYl7txt5SUmeY1jg4CsEtIN0I0HCQNfdiyzKxIn6CDBM
 EoFacQNHc7XSku7CKvN9Din/ndlqyG1UDFZOArCONgKFZtQQn6bRQQPEVQ8rfutTwJPdSYBtyJQ
 szI7gY8JkawByUaW+WfOpuRHALp7VgbX8CeNWWVQ7EM62vsq0pooaHWNPuXO3IyxuUtMMvKxJ8B
 /Im9d6KcsROyuOg1KR8oM0ct3/EBOUb0oN4alSGmoDK+i43p2dnsimbnQnYf+VOrDxTT5PBrTl9
 C+b5yfjwHVmYgU2l4=
X-Received: by 2002:a17:907:2d12:b0:b73:594e:1c47 with SMTP id
 a640c23a62f3a-b76c540b1d5mr1223688266b.26.1764249643220; 
 Thu, 27 Nov 2025 05:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFpHoMvSxice3thP7boE62vLNuG3swgAyYCW49Owu/+p7HtWt/Znh3xUHNlWDMyUWFsQA8tw==
X-Received: by 2002:a17:907:2d12:b0:b73:594e:1c47 with SMTP id
 a640c23a62f3a-b76c540b1d5mr1223683166b.26.1764249642706; 
 Thu, 27 Nov 2025 05:20:42 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51c55e9sm159175066b.26.2025.11.27.05.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/9] rust: remove unused --cfg arguments
Date: Thu, 27 Nov 2025 14:20:29 +0100
Message-ID: <20251127132036.84384-3-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-macros/meson.build                                 | 5 -----
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build       | 3 ---
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build   | 1 -
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build      | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/rust/qemu-macros/meson.build b/rust/qemu-macros/meson.build
index 0f27e0df925..17b2a4e2e24 100644
--- a/rust/qemu-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -2,11 +2,6 @@ _qemu_macros_rs = rust.proc_macro(
   'qemu_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_args: [
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
-  ],
   dependencies: [
     attrs_rs_native,
     proc_macro2_rs_native,
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 42b03dcd53c..04617b875c5 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -26,9 +26,6 @@ _bilge_impl_rs = rust.proc_macro(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_args: [
     '--cap-lints', 'allow',
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
     itertools_dep,
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 10c2741085c..8ba558e1330 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -23,7 +23,6 @@ _proc_macro_error_rs = static_library(
     '--cap-lints', 'allow',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
     '-A', 'non_fmt_panics'
   ],
   dependencies: [
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index c4c4c5e397c..a85d7c07143 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -17,9 +17,6 @@ _proc_macro_error_attr_rs = rust.proc_macro(
   override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_args: [
     '--cap-lints', 'allow',
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"'
   ],
   dependencies: [
     proc_macro2_dep,
-- 
2.51.1


