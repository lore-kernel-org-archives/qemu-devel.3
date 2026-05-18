Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41305CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0PN-00086v-8U; Mon, 18 May 2026 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Ov-0007q5-8W
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Ot-0004Yf-F2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779120062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Il+IwQmwGobbEFnPaiWXFiSKLlyKAG5TiWOEIDWMvDY=;
 b=Zyen0I3wBUC5/yA2wtL5Sz1zDx8dlotsUHwyB/1704gE13THZSgKV1f/Mp86MCfM3szofF
 0F6rvDTL5IWwoNvbxSPyZokoIIfJBckUlzNXWzkjUNkEdsoJGRrMBLsTbR9nTWt6Kg05kE
 FBDGKKzS747OQa49MMmGeH5JOte0LjU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-r9eiCKT7Oqq7R9TlP-LwpA-1; Mon,
 18 May 2026 12:00:59 -0400
X-MC-Unique: r9eiCKT7Oqq7R9TlP-LwpA-1
X-Mimecast-MFC-AGG-ID: r9eiCKT7Oqq7R9TlP-LwpA_1779120057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A84C518002E8; Mon, 18 May 2026 16:00:57 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6279330001A2; Mon, 18 May 2026 16:00:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 00/16] tests: do more testing of block drivers
Date: Mon, 18 May 2026 17:00:35 +0100
Message-ID: <20260518160051.903616-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg01650.html
 v2: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02083.html
 v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02939.html
 v4: https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03245.html
 v5: https://lists.nongnu.org/archive/html/qemu-devel/2026-03/msg01252.html
 v6: https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg04861.html
 v7: https://lists.nongnu.org/archive/html/qemu-devel/2026-05/msg03163.html

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

Changed in v8

  - Use 'driver' more comprehensively in tests/qemu-iotests/meson.build
  - Use 'iotests:' as patch prefix
  - Fix series numbering - due to a laptop change I accidentally
    posted v6 twice, once without a version and once with a versio.
    IOW what I previously called v6 was in fact v7.

Changed in v7:

  - Support QEMU_TEST_FLAKY_TESTS in I/O tests framework
    and mark 185 as flaky
  - Drop the env var for skipping tests
  - Use a matrix job in gitlab definition for I/O tests jobs

Changed in v6:

  - Drop redundant change from gitlab yml config
  - Pull in rebase for qemu.qmp to 0.6.0 to fix two tests
    by avoiding deprecation warnings

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
  iotests: print reason when I/O test is skipped in TAP mode
  iotests: remove redundant meson suite for iotests
  iotests: ensure all qcow2 I/O tests are able to be run via make
  scripts/mtest2make: ensure output has stable sorting
  scripts/mtest2make: support optional tests grouping
  iotests: add a meson suite / make target per block I/O tests format
  docs/devel/testing: expand documentation for 'make check-block'
  iotests: add nbd and luks to the I/O test suites
  iotests: use 'driver' as collective term for either format or protocol
  iotests: validate dmsetup result in test 128
  iotests: fix check for sudo access in LUKS I/O test
  iotests: mark 185 as a flaky test
  gitlab: add jobs for thorough block tests
  gitlab: remove I/O tests from build-tcg-disabled job

John Snow (1):
  python: bump qemu.qmp to v0.0.6

 .gitlab-ci.d/buildtest-template.yml           |  30 +++++---
 .gitlab-ci.d/buildtest.yml                    |  27 +++++---
 docs/devel/testing/main.rst                   |  26 ++++++-
 python/scripts/vendor.py                      |   4 +-
 ...ny.whl => qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 bytes
 pythondeps.toml                               |   2 +-
 scripts/mtest2make.py                         |  30 +++++---
 tests/Makefile.include                        |   3 +-
 tests/qemu-iotests/128                        |   6 ++
 tests/qemu-iotests/149                        |  13 ++--
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/common.rc                  |  16 +++++
 tests/qemu-iotests/meson.build                |  65 +++++++++++++++---
 tests/qemu-iotests/testrunner.py              |   2 +-
 14 files changed, 171 insertions(+), 54 deletions(-)
 rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl => qemu_qmp-0.0.6-py3-none-any.whl} (64%)

-- 
2.54.0


