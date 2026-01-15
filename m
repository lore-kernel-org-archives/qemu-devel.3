Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FA4D46606
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRfY-00083O-BH; Thu, 15 Jan 2026 13:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgRf7-0007vn-9q
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:01:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgRf4-0001is-Io
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768500093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fHp4Ni9+r2ZNN9z+AU02/dm2gs4w8p5NZOX1wWyP/IU=;
 b=O8OUqqyIVIes0nKAXcDz7FjLRVkR3DKYNBXa8fgHlSBCnrraZuQL8ypztliGMQw9ls8bmL
 1lKC29idPXHmp0TUuXqMHwAz7gAklaP8S2AFLpvmZ1tzpJLZ+4tY2N2bKNBr7aCm3uHDWC
 L/3AtW1WklHlU89t8zzm+DB49qOK1DY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-iZnTB4fnMb-vATGvjA3u0w-1; Thu,
 15 Jan 2026 13:01:29 -0500
X-MC-Unique: iZnTB4fnMb-vATGvjA3u0w-1
X-Mimecast-MFC-AGG-ID: iZnTB4fnMb-vATGvjA3u0w_1768500088
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F6061955F04; Thu, 15 Jan 2026 18:01:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99BE61800994; Thu, 15 Jan 2026 18:01:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/about: propose OS platform/arch support tiers
Date: Thu, 15 Jan 2026 18:01:23 +0000
Message-ID: <20260115180123.848640-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

Informally we have approximately three groups of platforms

 * Tier 1: fully built and fully tested by CI. Must always be
           kept working & regressions fixed immediately

 * Tier 2: fully built and partially tested by CI. Should
           always be kept working & regressions fixed quickly

 * Tier 3: code exists but is not built or tested by CI.
           Should not be intentionally broken but not
	   guaranteed to work at any time. Downstream must
	   manually test, report & fix bugs.

Anything else is "unclassified" and any historical code
remnants may be removed.

It is somewhat tricky to define unambiguous rules for each tier,
but this doc takes a stab at it. We don't need to cover every
eventuality. If we get the core points of view across, then it
at least sets the direction for maintainers/contributors/users.
Other aspects can be inferred with greater accuracy than today.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

This came out of the discussion about recent unnoticed breakage
in NetBSD builds and what maintainers are expected todo about
it (if anything)

  https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02543.html

 docs/about/build-platforms.rst | 152 +++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index e95784cdb5..950e164c02 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -171,3 +171,155 @@ Only 64-bit Windows is supported.
 .. _MacPorts: https://www.macports.org/
 .. _MSYS2: https://www.msys2.org/
 .. _Repology: https://repology.org/
+
+OS Support Tiers
+----------------
+
+While the QEMU code targets a number of different OS platforms, they don't
+all get the same level of support from the project. This applies to
+contributor & maintainer expectations, CI automation and requirements
+for merge gating.
+
+Tier 1
+~~~~~~
+
+These platforms attain the highest level of quality offered by
+the QEMU project.
+
+ * Builds and all tests pass at all times in both git HEAD and releases
+
+ * Builds for multiple build configuration are integrated in CI
+
+ * Runs all available tests frameworks (unit, qtest, iotests, functional)
+   in CI
+
+ * Merging code is gated on successful CI jobs
+
+This covers
+
+ * Linux (x86_64, aarch64, s390x)
+
+Responsibilities:
+
+ * Contributors MUST test submitted patches on one of Tier 1 platforms.
+
+ * Contributors SHOULD test submitted patches on Tier 1 platforms
+   by running a GitLab CI pipeline in their fork.
+
+ * Maintainers MUST request contributors to fix problems with Tier 1
+   platforms.
+
+ * Maintainers MUST test pull requests on Tier 1 platforms
+   by running a GitLab CI pipeline in their fork.
+
+ * Maintainers MUST co-ordinate fixing regressions identified
+   post-merge immediately.
+
+
+Tier 2
+~~~~~~
+
+These platforms are considered to be near Tier 1 level, but are
+lacking sufficient automated CI testing cover to guarantee this.
+
+ * Builds and all tests pass at all times in both git HEAD and releases
+
+ * Builds for multiple build configuration are integrated in CI
+
+ * Runs some test frameworks in CI
+
+This covers
+
+ * Linux (mips64el, ppc64el, riscv64)
+
+ * FreeBSD (x86_64)
+
+ * macOS (aarch64)
+
+ * Windows (x86_64)
+
+Responsibilities:
+
+ * Contributors MAY test patches on Tier 2 platforms
+   by running a GitLab CI pipeline in their fork
+
+ * Maintainers SHOULD request contributors to fix problems with Tier 2
+   platforms.
+
+ * Maintainers MUST test pull requests on all Tier 2 platforms,
+   by running a GitLab CI pipeline in their fork.
+
+ * Maintainers MUST co-ordinate fixing regressions identified
+   post-merge quickly.
+
+
+Tier 3
+~~~~~~
+
+These platforms have theoretical support in the code, but have
+little, or no, automated build and test coverage. Downstream
+consumers (users or distributors) who care about these platforms
+are requested to perform manual testing, report bugs and provide
+patches.
+
+ * Builds and tests may be broken at any time in Git HEAD and
+   releases
+
+ * Builds are not integrated into CI
+
+ * Tests are not integrated into CI
+
+ * Merging code is not gated
+
+This covers:
+
+ * NetBSD
+ * OpenBSD
+ * macOS (except aarch64)
+ * FreeBSD (except x86_64)
+ * Windows (except x86_64)
+ * Solaris
+
+Responsibilities:
+
+ * Contributors MAY test patches on Tier 3 platforms manually
+
+ * Maintainers MAY request contributors to fix problems
+   on Tier 3 platforms
+
+ * Maintainers MAY test patches on Tier 3 platforms manually
+
+ * Maintainers SHOULD NOT accept patches that remove code
+   targetting Tier 3 platforms even if currently broken
+
+ * Downstream vendors SHOULD test RC releases on Tier 3 platforms
+   and provide bug reports and patches to address problems
+
+Note: if a Tier 3 platform is found to be significantly broken,
+no patches are contributed for a prolonged period, and there is
+no sign of downstream usage, it is liable to be moved to
+"Unclassified" and thus be subject to removal.
+
+
+Unclassified
+~~~~~~~~~~~~
+
+These platforms are not intended to be supported in the code
+and outside the scope of any support tiers.
+
+  * Code supporting these platforms can removed at any time
+  * Bugs reports related to these platforms will generally
+    be ignored
+
+This covers:
+
+ * All 32-bit architectures on any OS
+ * Any OS not listed above
+
+Responsibilities:
+
+ * Maintainers MAY decline patches that add code targetting
+   unclassified platforms
+
+ * Maintainers MAY accept patches that remove code targetting
+   unclassified platforms
-- 
2.52.0


