Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C767CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cRb-0008R0-M1; Tue, 30 Sep 2025 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRa-0008Pb-76
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRT-0004PD-2x
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnHoGa6GbN0hh9V/MSQpqRR2eK1qQRWWptgarG6ZgMw=;
 b=Dzth3oEkN9sQiNDyMVYwMIPX4mhV3xcOOpyuJ8umVSMDlRzUrXGNj1yN6noA1q3fct/ldV
 F/5h0tCdVLjjg5CNnowtzPvr3LqOJZECgkemNHq1YLJsJ9/CTkjBHoP1FkoswH5iCAc53l
 4pu9j/aRz/NXEJ0BlK11dmlU+0cDDZ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-0mShz1HXMbGg74Wd-0PJvg-1; Tue,
 30 Sep 2025 11:38:58 -0400
X-MC-Unique: 0mShz1HXMbGg74Wd-0PJvg-1
X-Mimecast-MFC-AGG-ID: 0mShz1HXMbGg74Wd-0PJvg_1759246736
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76AB419560A5; Tue, 30 Sep 2025 15:38:56 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6779B30002C5; Tue, 30 Sep 2025 15:38:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 11/23] build-sys: cfi_debug and safe_stack are not compatible
Date: Tue, 30 Sep 2025 19:37:32 +0400
Message-ID: <20250930153746.573875-12-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It fails to link on fedora >= 41:
/usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memcpy':
(.text.__sanitizer_internal_memcpy+0x0): multiple definition of `__sanitizer_internal_memcpy'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memcpy+0x0): first defined here
/usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memmove':
(.text.__sanitizer_internal_memmove+0x0): multiple definition of `__sanitizer_internal_memmove'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memmove+0x0): first defined here
/usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memset':
(.text.__sanitizer_internal_memset+0x0): multiple definition of `__sanitizer_internal_memset'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memset+0x0): first defined here

cfi_debug seems to pull ubsan which has conflicting symbols with safe_stack.

See also: https://bugzilla.redhat.com/show_bug.cgi?id=2397265

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250924120426.2158655-12-marcandre.lureau@redhat.com>
---
 meson.build                | 3 +++
 .gitlab-ci.d/buildtest.yml | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index c08e2df6bb..14e626aa1e 100644
--- a/meson.build
+++ b/meson.build
@@ -681,6 +681,9 @@ if get_option('cfi')
     error('-fsanitize-cfi-icall-generalize-pointers is not supported by the compiler')
   endif
   if get_option('cfi_debug')
+    if get_option('safe_stack')
+      error('cfi_debug is not compatible with safe_stack')
+    endif
     if cc.compiles('int main () { return 0; }',
                    name: '-fno-sanitize-trap=cfi-icall',
                    args: ['-flto', '-fsanitize=cfi-icall',
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 3be36e5499..0502094b9a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -479,7 +479,7 @@ build-cfi-aarch64:
     LD_JOBS: 1
     AR: llvm-ar
     IMAGE: fedora
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi --enable-cfi-debug
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi
       --enable-safe-stack --disable-slirp
     TARGETS: aarch64-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -517,7 +517,7 @@ build-cfi-ppc64-s390x:
     LD_JOBS: 1
     AR: llvm-ar
     IMAGE: fedora
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi --enable-cfi-debug
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi
       --enable-safe-stack --disable-slirp
     TARGETS: ppc64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -555,7 +555,7 @@ build-cfi-x86_64:
     LD_JOBS: 1
     AR: llvm-ar
     IMAGE: fedora
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi --enable-cfi-debug
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi
       --enable-safe-stack --disable-slirp
     TARGETS: x86_64-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.51.0


