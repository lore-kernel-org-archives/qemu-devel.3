Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9A1CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJvm-00067x-7K; Tue, 19 May 2026 08:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJvg-000635-Re
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJvd-0008V0-IB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CmT6zgtKSby0nO8WGh3evkbZD5SZS0IliQEYFr3oquc=;
 b=N7y5dSO/7LS9l/QlHPcGBOfM1c0Z22bEUxjpKWvuQpEuehuLL0PE44UHw8xPKzSjaXVabA
 nvI/d6fbMoPPW1j+qvPsK2FzFAk55E/yCQoiOMAeQ3Z68SloZtNt6BcU9GYn1iMnPf8EnX
 /uDnm4UK2HXi+nsnW/foIYqju/5aV1E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-yUSTD_LyMcCO1lA2Fh4sQA-1; Tue,
 19 May 2026 08:51:59 -0400
X-MC-Unique: yUSTD_LyMcCO1lA2Fh4sQA-1
X-Mimecast-MFC-AGG-ID: yUSTD_LyMcCO1lA2Fh4sQA_1779195118
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99225195606E; Tue, 19 May 2026 12:51:58 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 244751800347; Tue, 19 May 2026 12:51:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 00/28] Misc patchesfor python, iotests, qom, crypto & io
Date: Tue, 19 May 2026 13:51:24 +0100
Message-ID: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The following changes since commit ac6721b88df944ade0048822b2b74210f543d656:

  Merge tag 'vhost-user-rtc-pr-1' of https://gitlab.com/epilys/qemu into staging (2026-05-16 17:37:33 -0400)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to d92ae44c28906a219e4c8e4ee8929e5fcfb2d32c:

  qom: drop user_creatable_add_type method (2026-05-18 18:23:34 +0100)

----------------------------------------------------------------
Misc patches for python, iotests, qom, crypto & io

 * Bump python-qemu-qmp to 0.6.0
 * Fix client side anoymous TLS credentials
 * Fix return value semantics for qio_channel_flush
 * Add ID validation of internal QOM constructor
 * Fix ability to create internal QOM objects
   without a parent
 * Merge user creatable object constructor into
   main QOM file
 * Print reason for skipping I/O tests
 * Remove redundant meson suits for I/O tests
 * Add I/O tests in meson for NBD and LUKS
 * Expose make targets for all block driver I/O tests
 * Run I/O tests for 10 block drivers in GitLab CI
 * Fix sudo check for LUKS I/O test
 * Mark I/O test 185 as flaky
 * Ensure stable sorting for mtest2make output

----------------------------------------------------------------

Daniel P. Berrangé (26):
  crypto: fix client side anonymous TLS credentials
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
  qom: add trace events for object/property lifecycle
  qom: validate ID format when creating objects
  qom: make errp last param in methods taking va_list
  qom: shorten name of object_set_properties_from_keyval
  qom: have object_set_props_keyval return bool
  qom: move object_set_prop_keyval into object.c
  qom: add object_new_with_props_from_qdict
  qom: fix ability to create objects without a parent
  qom: allow object_new_with_prop* to trigger module loading
  qom: drop user_creatable_add_type method

John Snow (1):
  python: bump qemu.qmp to v0.0.6

Tejus GK (1):
  io: invert the return semantics of qio_channel_flush

 .gitlab-ci.d/buildtest-template.yml           |  30 ++-
 .gitlab-ci.d/buildtest.yml                    |  27 +-
 authz/listfile.c                              |   4 +-
 crypto/tlscredsanon.c                         |   2 +
 docs/devel/testing/main.rst                   |  26 +-
 include/io/channel-socket.h                   |   6 +-
 include/io/channel.h                          |   4 +-
 include/qom/object.h                          | 121 +++++++--
 include/qom/object_interfaces.h               |  18 --
 io/channel-socket.c                           |  16 +-
 python/scripts/vendor.py                      |   4 +-
 ...ny.whl => qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 bytes
 pythondeps.toml                               |   2 +-
 qom/object.c                                  | 230 ++++++++++++++++--
 qom/object_interfaces.c                       | 101 +-------
 qom/trace-events                              |  12 +-
 scripts/mtest2make.py                         |  30 ++-
 system/qdev-monitor.c                         |   4 +-
 system/vl.c                                   |   7 +-
 tests/Makefile.include                        |   3 +-
 tests/qemu-iotests/128                        |   6 +
 tests/qemu-iotests/149                        |  13 +-
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/common.rc                  |  16 ++
 tests/qemu-iotests/meson.build                |  65 ++++-
 tests/qemu-iotests/testrunner.py              |   2 +-
 tests/unit/check-qom-proplist.c               |  97 ++++++--
 tests/unit/test-crypto-tlssession.c           | 120 ++++++++-
 28 files changed, 712 insertions(+), 255 deletions(-)
 rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl => qemu_qmp-0.0.6-py3-none-any.whl} (64%)

-- 
2.54.0


