Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A528CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8Gl-0007Vt-Jh; Wed, 13 May 2026 08:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8GC-0007Ou-BH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8G7-0004to-54
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9k9moTdE1Nl+J5dvnNgRK3cSimdzI8a0FfKS7K2xCgA=;
 b=gmM24z3G3LbOgb6A4q3/fNQfyt8bvIyiDLbLOQPKI3tnckqdF4b7Cb2LfN4g8ZruaK53HE
 G3uUszbsw7zgVjZJRaaEo2EqWjdynx3JCAfgKOfQUtru/qsjMPh0MXcuAzA3QJTp1Ha97P
 I73o2RYjEdWlXHMeCiXRM0xh4JSDgD8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-W5IR2NOuMeObwzskglvRNg-1; Wed,
 13 May 2026 08:00:11 -0400
X-MC-Unique: W5IR2NOuMeObwzskglvRNg-1
X-Mimecast-MFC-AGG-ID: W5IR2NOuMeObwzskglvRNg_1778673610
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B60D195608C; Wed, 13 May 2026 12:00:10 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EA481800577; Wed, 13 May 2026 12:00:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 00/16] tests: do more testing of block drivers
Date: Wed, 13 May 2026 12:59:47 +0100
Message-ID: <20260513120003.226790-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg01650.html
 v2: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02083.html
 v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02939.html
 v4: https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03245.html
 v5: <...somewhere...mailman is dead again at time of sending...>

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

 * Test 185 is failing on gitlab so is marked as flaky

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

Changed in v6:

  - Support QEMU_TEST_FLAKY_TESTS in I/O tests framework
    and mark 185 as flaky
  - Drop the env var for skipping tests
  - Use a matrix job in gitlab definition for I/O tests jobs

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
  tests/qemu-iotests: mark 185 as a flaky test
  gitlab: add jobs for thorough block tests
  gitlab: remove I/O tests from build-tcg-disabled job

John Snow (1):
  python: bump qemu.qmp to v0.0.6

 .gitlab-ci.d/buildtest-template.yml           |  30 +++++----
 .gitlab-ci.d/buildtest.yml                    |  27 +++++---
 docs/devel/testing/main.rst                   |  26 +++++++-
 python/scripts/vendor.py                      |   4 +-
 ...ny.whl => qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 bytes
 pythondeps.toml                               |   2 +-
 scripts/mtest2make.py                         |  30 ++++++---
 tests/Makefile.include                        |   3 +-
 tests/qemu-iotests/128                        |   6 ++
 tests/qemu-iotests/149                        |  13 ++--
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/common.rc                  |  16 +++++
 tests/qemu-iotests/meson.build                |  59 +++++++++++++++---
 tests/qemu-iotests/testrunner.py              |   2 +-
 14 files changed, 168 insertions(+), 51 deletions(-)
 rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl => qemu_qmp-0.0.6-py3-none-any.whl} (64%)

-- 
2.54.0


