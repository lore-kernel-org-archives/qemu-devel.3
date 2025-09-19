Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C23CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbIp-0001Yn-9n; Fri, 19 Sep 2025 09:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbHU-000739-6C
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbHK-0004Br-Dv
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msb4UKtvSLmS0DJSTxPJEEU5eRGOe9nc3237xngWKRs=;
 b=DXUd+Waf5DpBs14O0m+iF6den/RI1+lW+SvEyeLPGZG6d/4ujsLQBZnxSvIC20DGiC69Bs
 bMgBQWRSomQ1Uv7wmvUrZ1eDN/kl708xKVlT2/TgyCdAnCMxFcDWa9Xy2S81T4MFZrSvL9
 6obpe4925t8FOQnZrmvXgRDHUUO2l2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-vmsNuKSoOjeGs3kRq6sfyw-1; Fri,
 19 Sep 2025 09:35:49 -0400
X-MC-Unique: vmsNuKSoOjeGs3kRq6sfyw-1
X-Mimecast-MFC-AGG-ID: vmsNuKSoOjeGs3kRq6sfyw_1758288947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68B4919560AF; Fri, 19 Sep 2025 13:35:47 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F16A830002C5; Fri, 19 Sep 2025 13:35:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 23/24] WIP: gitlab-ci: enable rust for msys2-64bit
Date: Fri, 19 Sep 2025 17:33:17 +0400
Message-ID: <20250919133320.240145-24-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-1-marcandre.lureau@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Currently fails with meson issue:
https://github.com/mesonbuild/meson/pull/14991

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitlab-ci.d/windows.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 1e6a01bd9a..51297d3647 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -17,7 +17,7 @@ msys2-64bit:
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
-    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0
+    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0 --enable-rust
     # The Windows git is a bit older so override the default
     GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
@@ -76,6 +76,7 @@ msys2-64bit:
       bison diffutils flex
       git grep make sed
       mingw-w64-x86_64-binutils
+      mingw-w64-x86_64-ca-certificates
       mingw-w64-x86_64-ccache
       mingw-w64-x86_64-curl-winssl
       mingw-w64-x86_64-gcc
@@ -86,6 +87,9 @@ msys2-64bit:
       mingw-w64-x86_64-pixman
       mingw-w64-x86_64-pkgconf
       mingw-w64-x86_64-python
+      mingw-w64-x86_64-python-certifi
+      mingw-w64-x86_64-rust
+      mingw-w64-x86_64-rust-bindgen
       mingw-w64-x86_64-zstd"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
@@ -96,10 +100,12 @@ msys2-64bit:
   - $env:CCACHE_MAXSIZE = "500M"
   - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
   - $env:CC = "ccache gcc"
+  - $env:LIBCLANG_PATH = Join-Path -Path $PWD.Path -ChildPath "msys64/mingw64/bin"
   - mkdir build
   - cd build
   - ..\msys64\usr\bin\bash -lc "ccache --zero-stats"
   - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
+  - ..\msys64\usr\bin\bash -lc "make V=1 rust/util/bindings.inc.rs"
   - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
-- 
2.51.0


