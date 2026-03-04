Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16E6EF8FE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxn6b-0007uT-Le; Wed, 04 Mar 2026 09:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn6V-0007td-Fe
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn6R-00065m-DK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772634090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZvYEH9aCimxbOY93AyEY4E6Mly68w1okWXM+711luxI=;
 b=A+fb33QD1WFO2BajMZa+JNDxBzfG4RrGBi4S9EGEwRoUzTtITDhcUlfhYIjYSVhighsShj
 3u145VWGF0WObSfC+l2DDhGkWP/ir5icXXDAvPMeIAhqOAt8NsEBlLJ9mN/DOZKhTPbYNN
 ScrmAzL21ZKkv14SDwBlxgqOW/NfcJM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-1PaHhA46PoauZJhF1tsPug-1; Wed,
 04 Mar 2026 09:21:27 -0500
X-MC-Unique: 1PaHhA46PoauZJhF1tsPug-1
X-Mimecast-MFC-AGG-ID: 1PaHhA46PoauZJhF1tsPug_1772634086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F18C19560AF; Wed,  4 Mar 2026 14:21:26 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC1791958DC2; Wed,  4 Mar 2026 14:21:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 00/15] tests: do more testing of block drivers
Date: Wed,  4 Mar 2026 14:21:05 +0000
Message-ID: <20260304142120.2635617-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg01650.html
 v2: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02083.html
 v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02939.html
 v4: https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03245.html

The recent (at the time of v1) set of regressions identified in the LUKS
block driver re-inforced that despite having a hugely useful set of I/O
tests, our CI coverage is still letting through too many bugs.

The core goals of this series were/are:

 * Add LUKS and NBD to the tested formats/protocols
   integrated into "make check-block SPEED=thorough"

 * Ensure that all qcow2 tests can be run with "SPEED=slow",
   not staying limited to only the 'auto' group used by the
   'make check-block' target in its default 'quick' mode

 * Add  'make check-block-$FORMAT' to expose a standalone
   target for running all tests for a given format (or
   equivalently a protocol)

 * Add GitLab CI jobs for exercising tests for all formats

A sample pipeline for this is

  https://gitlab.com/berrange/qemu/-/pipelines/2258731804/

Showing the 'block-FORMAT' jobs which test the 10 block formats/protocols
currently enabled.

This series fixes a couple of bugs

 * Test 128 check for device mapper usage doesn't work
   sufficiently well to detect gitlab's containe env
   can't do dynamic devfs

 * Test 185 is reliably failing on gitlab

 * Two tests fail when run on CentOS 9 because they trigger
   python deprecation warnings. This will be fixed when the
   python-qemu-qmp module is next released.

Testing of pipelines throughout development of v1-v5 postings does not
exhibit any non-deterministic failures with the shared runners. Hopefully
that will apply to QEMU's private runners used forthe staging tree too.

At this point it is a chicken & egg problem though.

If we don't bite the bullet and enable block I/O tests in GitLab CI for
everyone, we'll never find out if they're truely stable enough to rely
on.

As a mitigation against instability a patch in this series adds a new
QEMU_TEST_IO_SKIP env variable that we are able to set as a GitLab CI
env variable. This lets us skip broken tests dynamically without waiting
for a git commit to disable them in the buildtest.yml config that we
use for disabling the 3 known broken tests currently.

Changed in v5:

  - Adapt for python-qemu-qmp being spun off, by temp disabling
    tests that are broken by it, that we formerly fixed in-tree.

Changed in v4:

  - Remove tests from build-tcg-disabled job

Changed in v3:

  - Test whether dmsetup create device appeared or not, instead
    of unconditionally skipping test 128 in GitLab
  - Use 'driver' term instead of 'format' or 'protocol'
  - Fix misc typos & rephrasing

Daniel P. Berrangé (15):
  gitlab: ensure all meson jobs capture build/meson-logs by default
  tests: print reason when I/O test is skipped in TAP mode
  tests: remove redundant meson suite for iotests
  tests: ensure all qcow2 I/O tests are able to be run via make
  scripts/mtest2make: ensure output has stable sorting
  scripts/mtest2make: support optional tests grouping
  tests: add a meson suite / make target per block I/O tests format
  docs/devel/testing: expand documentation for 'make check-block'
  tests: add nbd and luks to the I/O test suites
  tests: use 'driver' as collective term for either format or protocol
  tests: validate dmsetup result in test 128
  tests: fix check for sudo access in LUKS I/O test
  tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
  gitlab: add jobs for thorough block tests
  gitlab: remove I/O tests from build-tcg-disabled job

 .gitlab-ci.d/buildtest-template.yml |  30 +++++---
 .gitlab-ci.d/buildtest.yml          | 115 +++++++++++++++++++++++++---
 docs/devel/testing/main.rst         |  33 +++++++-
 scripts/mtest2make.py               |  30 +++++---
 tests/Makefile.include              |   3 +-
 tests/qemu-iotests/128              |   6 ++
 tests/qemu-iotests/149              |  13 ++--
 tests/qemu-iotests/meson.build      |  59 ++++++++++++--
 tests/qemu-iotests/testrunner.py    |  18 ++++-
 9 files changed, 258 insertions(+), 49 deletions(-)

-- 
2.53.0


