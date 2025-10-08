Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB09CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ST3-0003TA-8N; Wed, 08 Oct 2025 07:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6ST0-0003S9-Qb
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6SSx-0006lc-Hs
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759923377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XpgI0hxCrvyE2GNHMiI37SFRqXAYRij+ckgGZyLCyTg=;
 b=WMJcWsVP1jMbiwoPiTYHxs9UXbq0atlMLdBZrerXpyWXy+8Mf/xqetMQ5wvuRWWmswDVwB
 Jhr2AClR8DvwrG1zPJZNsK2WWxHKCPvfgaf+w7PqTElyOrRCHMjnAlP5vYY8NOE7yCrZcE
 7BYh135oKAEBSxD0HyQM5x1kqNavE40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-e22yoW_KNsS8mQzgt1xwMQ-1; Wed,
 08 Oct 2025 07:36:14 -0400
X-MC-Unique: e22yoW_KNsS8mQzgt1xwMQ-1
X-Mimecast-MFC-AGG-ID: e22yoW_KNsS8mQzgt1xwMQ_1759923372
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80DE21800447; Wed,  8 Oct 2025 11:36:12 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.74])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B4B01956056; Wed,  8 Oct 2025 11:35:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] tests: do more testing of block drivers in CI
Date: Wed,  8 Oct 2025 12:35:48 +0100
Message-ID: <20251008113552.747002-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The recent set of regressions identified in the LUKS block driver
re-inforced that despite having a hugely useful set of I/O tests,
our CI coverage is still letting through too many bugs.

This series expands the meson suites / make targets for running
I/O tests for more drivers, and then creates a CI job for each.

While the first three patches are functionally usable as is, the
last patch for gitlab is very much an RFC. A test pipeline

  https://gitlab.com/berrange/qemu/-/pipelines/2085907042

shows passes for qcow2, qed, vmdk & vpc, but failures for luks,
nbd and raw.

The luks failures all have patchs floating around pending merge.

The nbd failures are problems with non-deterministic output
ordering, or warnings from python deprecations that need
addressing.

The raw failures are problems with python deprecations, and
insufficient permissions checks wrt device mapper acess.

I'm unclear if there are other non-deterministic failures that
would only appear if we start running the tests regularly. That
is a chicken & egg problem though. At some point we have to accept
a (hopefully short) period of instability to tease out the rare
edge cases, in order to get a long term win of better code quality
through CI coverage.

Daniel P. Berrangé (4):
  tests: print reason when I/O test is skipped in TAP mode
  tests: rearrange suites for I/O tests
  tests: add nbd and luks to the I/O test suites
  gitlab: add jobs for thorough block tests

 .gitlab-ci.d/buildtest.yml       | 63 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/meson.build   | 52 ++++++++++++++++++++------
 tests/qemu-iotests/testrunner.py |  2 +-
 3 files changed, 104 insertions(+), 13 deletions(-)

-- 
2.50.1


