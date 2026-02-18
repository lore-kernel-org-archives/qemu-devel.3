Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00230E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vspCt-0007wE-3T; Wed, 18 Feb 2026 16:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vspCq-0007n9-Tt
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vspCo-0002EQ-Gw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771450533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svwUZmFcXrxAz0z+6CagrgvUzVmfiLjUGUqEXIJFjak=;
 b=SKRBuGl2WlftNZ1SKI+P/lL0P8Oq7yViugZViv2cEUDrm4cQcUBZk+bYmnpTX43SJmTSvj
 GCgtYARv2OqJ0D+Pn96FOOK1dNwVDI8ZbKk4r371GvIlbgm37ZyoyHRkwj45bIys58k9p3
 odp9heJFzdIH6IvVUPqD11tpB7Kma6g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-hL9NoCcqO5Cy3xeZBGRrKw-1; Wed,
 18 Feb 2026 16:35:30 -0500
X-MC-Unique: hL9NoCcqO5Cy3xeZBGRrKw-1
X-Mimecast-MFC-AGG-ID: hL9NoCcqO5Cy3xeZBGRrKw_1771450528
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B4F0195FDD5; Wed, 18 Feb 2026 21:35:28 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.233])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E59E19560B5; Wed, 18 Feb 2026 21:35:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v8 09/20] tests: use "run" script to execute device-crash-test
Date: Wed, 18 Feb 2026 16:34:04 -0500
Message-ID: <20260218213416.674483-10-jsnow@redhat.com>
In-Reply-To: <20260218213416.674483-1-jsnow@redhat.com>
References: <20260218213416.674483-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of invoking python from the configure venv manually, instruct
developers to use the "run" script instead. Change the test invocation
to be a good example going forward.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 6 +++---
 scripts/device-crash-test  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4c280dd29bc..b2db70ff904 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -102,7 +102,7 @@ crash-test-debian:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
+    - ./run scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
 build-system-fedora:
   extends:
@@ -159,8 +159,8 @@ crash-test-fedora:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
-    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
+    - ./run scripts/device-crash-test -q ./qemu-system-ppc
+    - ./run scripts/device-crash-test -q ./qemu-system-riscv32
 
 build-system-centos:
   extends:
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index f97d9909c05..8a91dcaee31 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -42,7 +42,7 @@ except ModuleNotFoundError as exc:
     print(f"Module '{exc.name}' not found.")
     print("  Try 'make check-venv' from your build directory,")
     print("  and then one way to run this script is like so:")
-    print(f'  > $builddir/pyvenv/bin/python3 "{path}"')
+    print(f'  > $builddir/run "{path}"')
     sys.exit(1)
 
 logger = logging.getLogger('device-crash-test')
-- 
2.53.0


