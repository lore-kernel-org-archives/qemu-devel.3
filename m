Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29A5D2CDE3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROtJ-0001gF-GU; Fri, 05 Dec 2025 01:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROt9-0001bj-5B
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROt6-0001Ey-SD
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764914512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qGOgR92PbaloJbtRpGAhl0S29/CyafaNImltOSToic=;
 b=Z0MxkgqoGoxTGnl4S3fxxyh29g2GcHiSkRW1VVmOGZHlCb47JM+EY7aq2vlygxpzC/sviX
 GE/5VtLKa3afRKRFwOeYgLULUcmJbp0XoSxnClbtzIxiUqeyxgCLGyljxhzpACFmBEQYVI
 TM7y3awrxAx2nRyDDIr4iOKQOGeiY94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-7HaV-mW5OuOh6AeKMvUmfw-1; Fri,
 05 Dec 2025 01:01:49 -0500
X-MC-Unique: 7HaV-mW5OuOh6AeKMvUmfw-1
X-Mimecast-MFC-AGG-ID: 7HaV-mW5OuOh6AeKMvUmfw_1764914507
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FB7218001D7; Fri,  5 Dec 2025 06:01:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42AF93011A87; Fri,  5 Dec 2025 06:01:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/15] tests: ensure "make check-venv" is run for crash
 tests
Date: Fri,  5 Dec 2025 01:00:50 -0500
Message-ID: <20251205060058.1503170-9-jsnow@redhat.com>
In-Reply-To: <20251205060058.1503170-1-jsnow@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

We are preparing to drop the Makefile logic that installs python test
prerequisites, and so the trick to suppress ninja from re-configuring
the project will no longer work.

Move the "check-venv" step into the build part of the image instead so
that it is available for the fedora and debian device crash tests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 97bddbffb40..bf0fad1df10 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -72,7 +72,7 @@ build-system-debian:
     CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
       sparc-softmmu xtensa-softmmu
-    MAKE_CHECK_ARGS: check-build
+    MAKE_CHECK_ARGS: check-venv check-build
 
 check-system-debian:
   extends: .native_test_job_template
@@ -101,7 +101,6 @@ crash-test-debian:
     IMAGE: debian
   script:
     - cd build
-    - make NINJA=":" check-venv
     - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
 build-system-fedora:
@@ -115,7 +114,7 @@ build-system-fedora:
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg --enable-rust
     TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
-    MAKE_CHECK_ARGS: check-build check-doc
+    MAKE_CHECK_ARGS: check-venv check-build check-doc
 
 build-system-fedora-rust-nightly:
   extends:
@@ -158,7 +157,6 @@ crash-test-fedora:
     IMAGE: fedora
   script:
     - cd build
-    - make NINJA=":" check-venv
     - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
     - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
 
-- 
2.51.1


