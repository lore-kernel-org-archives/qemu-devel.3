Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45796606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBf7ifhc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTsp-0003KR-T4; Mon, 23 Nov 2026 08:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xVTsf-0003Jr-SU
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xVTsc-00080X-4H
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795439679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PIvK3Ky05562Cv6tR+TFF3YWEcnaxHFmzLlsCwJj24s=;
 b=EBf7ifhcwnscvMJFpWuxtxEIlWTQv3UX0CPSUc8a44TSUC2SIbAyOQeE+QRSaktpVP+tqL
 gEYXAgsPD6BBRg0l06e1CTDze2KYv8JEHS8ghAxVQ1DF5YJ7VAWgtybUoZLtkT/0MxqsOZ
 MoY83KNDC9jUOUqXBusfhGwOQEjzEyI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-VT0Fu66sPdqJT-WW6g7s4g-1; Mon,
 23 Nov 2026 13:14:35 +0000
X-MC-Unique: VT0Fu66sPdqJT-WW6g7s4g-1
X-Mimecast-MFC-AGG-ID: VT0Fu66sPdqJT-WW6g7s4g_1795439673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E6C11955F0B; Mon, 23 Nov 2026 13:14:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C9E3195604C; Mon, 23 Nov 2026 13:14:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
Subject: [PATCH] gitlab-ci: Switch the msys2 job to use ucrt
Date: Mon, 23 Nov 2026 14:14:26 +0100
Message-ID: <20261123131427.209394-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MSYS2 folks marked the MINGW64 environment as deprecated a while ago:

 https://www.msys2.org/news/#2026-03-15-deprecating-the-mingw64-environment

Now they also removed the mingw-w64-x86_64-libnfs package, so the msys2 job
is currently failing. It's expected that other MINGW64 packages will be
removed in the near future, so switch to the UCRT64 environment now instead
to fix the issue in a future-proof way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 145500ae464..ec697f407f4 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -12,8 +12,7 @@ msys2-64bit:
   stage: build
   timeout: 100m
   variables:
-    # Select the "64 bit, gcc and MSVCRT" MSYS2 environment
-    MSYSTEM: MINGW64
+    MSYSTEM: UCRT64
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
@@ -76,24 +75,24 @@ msys2-64bit:
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
-      mingw-w64-x86_64-binutils
-      mingw-w64-x86_64-ca-certificates
-      mingw-w64-x86_64-ccache
-      mingw-w64-x86_64-curl-winssl
-      mingw-w64-x86_64-gcc
-      mingw-w64-x86_64-glib2
-      mingw-w64-x86_64-libnfs
-      mingw-w64-x86_64-libssh
-      mingw-w64-x86_64-ninja
-      mingw-w64-x86_64-pixman
-      mingw-w64-x86_64-pkgconf
-      mingw-w64-x86_64-python
-      mingw-w64-x86_64-python-certifi
-      mingw-w64-x86_64-python-setuptools
-      mingw-w64-x86_64-python-wheel
-      mingw-w64-x86_64-rust
-      mingw-w64-x86_64-rust-bindgen
-      mingw-w64-x86_64-zstd"
+      mingw-w64-ucrt-x86_64-binutils
+      mingw-w64-ucrt-x86_64-ca-certificates
+      mingw-w64-ucrt-x86_64-ccache
+      mingw-w64-ucrt-x86_64-curl-winssl
+      mingw-w64-ucrt-x86_64-gcc
+      mingw-w64-ucrt-x86_64-glib2
+      mingw-w64-ucrt-x86_64-libnfs
+      mingw-w64-ucrt-x86_64-libssh
+      mingw-w64-ucrt-x86_64-ninja
+      mingw-w64-ucrt-x86_64-pixman
+      mingw-w64-ucrt-x86_64-pkgconf
+      mingw-w64-ucrt-x86_64-python
+      mingw-w64-ucrt-x86_64-python-certifi
+      mingw-w64-ucrt-x86_64-python-setuptools
+      mingw-w64-ucrt-x86_64-python-wheel
+      mingw-w64-ucrt-x86_64-rust
+      mingw-w64-ucrt-x86_64-rust-bindgen
+      mingw-w64-ucrt-x86_64-zstd"
   - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
-- 
2.56.1


