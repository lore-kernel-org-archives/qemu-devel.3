Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3833ACF45CD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 20:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfOiQ-00075g-85; Mon, 12 Jan 2026 15:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOiO-00074Z-CG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOiM-0000jj-NO
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768250436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v3iqS3ptfU8vrb7JLTbd+RpdKQrADNKG6zZVs470pg4=;
 b=geVuGz7JrFYXmIAjMQqjCUa2iLNxe8dA8v8S8WWqkD8Tfd/6wxL0+fFt4xQUxRL8yBjYdY
 9Xq5VFi5IfzJFD4msJBJ+5wIYJV9qolwYCK4GuNs/ESN96t+pJBrmi3ViwIUexvMfBJvjG
 +VzHlxXAzzDxBUmQ+FfE7c9ouC0hrS0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-wyGhetNdMZSCvv3hRtslGg-1; Mon,
 12 Jan 2026 15:40:32 -0500
X-MC-Unique: wyGhetNdMZSCvv3hRtslGg-1
X-Mimecast-MFC-AGG-ID: wyGhetNdMZSCvv3hRtslGg_1768250431
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 132801956071; Mon, 12 Jan 2026 20:40:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17A3C30001A2; Mon, 12 Jan 2026 20:40:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/13] tests: do more testing of block drivers
Date: Mon, 12 Jan 2026 20:40:13 +0000
Message-ID: <20260112204026.710659-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Original (very broken) v1 posting:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg01650.html

The recent set of regressions identified in the LUKS block driver
re-inforced that despite having a hugely useful set of I/O tests,
our CI coverage is still letting through too many bugs.

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

Showing the 'block-FORMAT-centos' jobs which test the 10
block formats/protocols currently enabled.

This series fixes a couple of bugs

 * sendmsg generates a deprecation warning on centos

 * Test 128 check for device mapper usage doesn't work
   sufficiently well to detect gitlab's containe env
   can't do dynamic devfs

 * Test 185 is reliably failing on gitlab

I'm unclear if there are other non-deterministic failures that
would only appear if we start running the tests regularly, or
against QEMU's private runners instead of gitlab shared runners.

The ones I've fixed have been consistent across quite a few test
pipelines so far with the shared runners.

At this point it is a chicken & egg problem though.

If we don't bite the bullet and enable block I/O tests in GitLab
we'll never find out if they're stable enough to rely on.

As a mitigation against instability a patch in this series adds
a QEMU_TEST_IO_SKIP env variable that we are able to set as a
GitLab CI env variable. This lets us skip broken tests without
waiting for a git commit to disable them.

Changed in v2:

  * TL;DR: this time is actally works as described, rather
    unlike v1 which was majorly broken in its understanding
    of how mtest2make.py was working
  * Expand mtest2make.py to support a concept of an "optional"
    test suite, to create new standalone make check-xxx targets
    that don't get run by default
  * Fix sorting of Makefile.mtest to be stable
  * Fix or disable  some bugs in iotests exposed by gitlab
  * Fix the 'make check-block-$FORMAT' targets so they really
    don't get triggered by 'make chck' by default.
  * Avoid duplicating the same qcow2 tests in the 'quick'
    suite and 'slow' suite. The latter must only have the
    tests not in the 'auto' group
  * Add RST documentation of the new make targets
  * Add env variable to let us dynamically skip I/O tests
    without git commit changes


Daniel P. Berrangé (13):
  Revert "python/aqmp: fix send_fd_scm for python 3.6.x"
  tests: print reason when I/O test is skipped in TAP mode
  tests: remove redundant meson suite for iotests
  tests: ensure all qcow2 I/O tests are able to be run via make
  scripts/mtest2make: ensure output has stable sorting
  scripts/mtest2make: support optional tests grouping
  tests: add a meson suite / make target per block I/O tests format
  docs/devel/testing: expand documentation for 'make check-block'
  tests: add nbd and luks to the I/O test suites
  tests: skip I/O test 128 on GitLab due to broken dmsetup
  tests: fix check for sudo access in LUKS I/O test
  tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
  gitlab: add jobs for thorough block tests

 .gitlab-ci.d/buildtest.yml       | 92 ++++++++++++++++++++++++++++++++
 docs/devel/testing/main.rst      | 34 ++++++++++--
 python/qemu/qmp/qmp_client.py    |  9 ++--
 scripts/mtest2make.py            | 30 +++++++----
 tests/Makefile.include           |  3 +-
 tests/qemu-iotests/128           |  2 +
 tests/qemu-iotests/149           | 13 +++--
 tests/qemu-iotests/meson.build   | 55 ++++++++++++++++---
 tests/qemu-iotests/testrunner.py | 18 ++++++-
 9 files changed, 224 insertions(+), 32 deletions(-)

-- 
2.52.0


