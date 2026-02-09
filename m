Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94209E7E0D2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 18:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpWFB-00073F-Q6; Mon, 09 Feb 2026 13:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpWDt-0006C5-9t
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpWDp-000095-Ex
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770662572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SaEfClcDmb4nFGfC08rt5310gxP6p4JFNvWZoOFsCJo=;
 b=OGGz4PFwk8e7lTHjpEtqoNla1gkM96GgGMFcPb43jQ4Vb6DXrHLgvefKAfHY+wnsL3oKlF
 gx8RxHTAeimD/t2Cv+jchrR3NoZErIlRq2L6YzuiSGM/9KqoQl7PgW9kPZW39JNwfPh0Ja
 geAeJZRxuouB3SNxvf6i2omTeP3SyNQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-taCtt2McNbSSqRrn_1qvYg-1; Mon,
 09 Feb 2026 13:42:49 -0500
X-MC-Unique: taCtt2McNbSSqRrn_1qvYg-1
X-Mimecast-MFC-AGG-ID: taCtt2McNbSSqRrn_1qvYg_1770662567
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51F91180025F; Mon,  9 Feb 2026 18:42:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.77])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D92D18004AD; Mon,  9 Feb 2026 18:42:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v6 12/16] configure: unconditionally install "tooling" group
Date: Mon,  9 Feb 2026 13:41:19 -0500
Message-ID: <20260209184124.1263625-13-jsnow@redhat.com>
In-Reply-To: <20260209184124.1263625-1-jsnow@redhat.com>
References: <20260209184124.1263625-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alongside meson, always ensure our in-tree tooling group and its
out-of-tree dependency, qemu.qmp, is always installed.

As a result, several "check-venv" invocations can be removed from
various testing scripts.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                  | 2 +-
 .gitlab-ci.d/buildtest.yml | 2 --
 scripts/device-crash-test  | 3 +--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 4b61fd3bbf8..c4837eba2b1 100755
--- a/configure
+++ b/configure
@@ -966,7 +966,7 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 # Finish preparing the virtual environment using vendored .whl files
 
 $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
-     ${source_path}/pythondeps.toml meson || exit 1
+     ${source_path}/pythondeps.toml meson tooling || exit 1
 
 # At this point, we expect Meson to be installed and available.
 # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index b2db70ff904..1b656b9eb08 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -101,7 +101,6 @@ crash-test-debian:
     IMAGE: debian
   script:
     - cd build
-    - make NINJA=":" check-venv
     - ./run scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
 build-system-fedora:
@@ -158,7 +157,6 @@ crash-test-fedora:
     IMAGE: fedora
   script:
     - cd build
-    - make NINJA=":" check-venv
     - ./run scripts/device-crash-test -q ./qemu-system-ppc
     - ./run scripts/device-crash-test -q ./qemu-system-riscv32
 
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 8a91dcaee31..fc86babdf43 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -40,8 +40,7 @@ try:
 except ModuleNotFoundError as exc:
     path = Path(__file__).resolve()
     print(f"Module '{exc.name}' not found.")
-    print("  Try 'make check-venv' from your build directory,")
-    print("  and then one way to run this script is like so:")
+    print("  Try running this script like so:")
     print(f'  > $builddir/run "{path}"')
     sys.exit(1)
 
-- 
2.52.0


