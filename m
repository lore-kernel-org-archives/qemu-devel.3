Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD6BD7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9KK-0008Ko-B0; Thu, 21 Nov 2024 10:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9KF-0008Ka-Lu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9KD-0000gb-OW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1kzY05YIyisaEtoHgIBuwAW769ac3YNgNHC2v90si6w=;
 b=QcrlFk5M5A48DcQFFRL2xjTE8GayAmVvx3QND9dokwlibysx0l+KgCuqrFh7Wv01GomoyZ
 dIWXItWnEI0LVyyX6nCrPAiBrcVeQF9i7ndsi+XfQD6NmdoO+S1ovKZcWEDRmhU9poZoPl
 mCwzi3BnAajEU6PLzuQSI8AQBaM++CU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-Yy6L9MsOOui5tPWwsGcs4g-1; Thu,
 21 Nov 2024 10:42:30 -0500
X-MC-Unique: Yy6L9MsOOui5tPWwsGcs4g-1
X-Mimecast-MFC-AGG-ID: Yy6L9MsOOui5tPWwsGcs4g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24A3219560BA; Thu, 21 Nov 2024 15:42:29 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C7181956086; Thu, 21 Nov 2024 15:42:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/18] test/functional: improve functional test debugging &
 fix tuxrun
Date: Thu, 21 Nov 2024 15:42:00 +0000
Message-ID: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This started out as a series to get rid of the many GBs of temp
files the functional tests leave behind. Then it expanded into
improving the functional test debugging by ensuring we preserve
the QEMU stdout/stderr log file created by the QEMUMachine class.
In the course of doing that I encountered some other minor points
worth fixing, and then got side tracked into looking at the tuxrun
hangs with aarch64be. Investigating the latter exposed some further
holes in the debugging story prompting yet more patches, as well as
a final solution for tuxrun. So this series does:

 * Purge all scratch files created by tests
 * Preserve the stdout/stderr log file
 * Capture debug log messages on QEMUMachine
 * Provide a QMP backdoor for debugging stuck QEMUs
 * Enhance console handling for partial line matches
 * Fix the tuxrun tests by eliminating sleeps

There's quite alot of code here, but at the same time it feels like
the kind of stuff that'll be valuable either in the 9.2 release, or
in the soon to exist 9.2 stable branch.

NB, with this series applied Thomas' tuxrun conversion to functional
testing survives 200 iterations on my machine, whereas it would
reliably hang in < 20, and often in < 10, before.

Changed in v2:

 - Changed console interaction to forbid 'failure_message'
   without 'success_message'
 - Reword console interaction log messages
 - Avoid stack trace when seeing early failure
 - Rewrote comment in acpi bits test
 - Avoid duplicate os.environ access

Daniel P. Berrangé (18):
  tests/functional: fix mips64el test to honour workdir
  tests/functional: automatically clean up scratch files after tests
  tests/functional: remove "AVOCADO" from env variable name
  tests/functional: remove todo wrt avocado.utils.wait_for
  tests/functional: remove leftover :avocado: tags
  tests/functional: remove obsolete reference to avocado bug
  tests/functional: remove comments talking about avocado
  tests/functional: honour self.workdir in ACPI bits tests
  tests/functional: put QEMUMachine logs in testcase log directory
  tests/functional: honour requested test VM name in QEMUMachine
  tests/functional: enable debug logging for QEMUMachine
  tests/functional: logs details of console interaction operations
  tests/functional: don't try to wait for the empty string
  tests/functional: require non-NULL success_message for console wait
  tests/functional: rewrite console handling to be bytewise
  tests/functional: remove time.sleep usage from tuxrun tests
  tests/functional: add a QMP backdoor for debugging stalled tests
  tests/functional: avoid accessing log_filename on earlier failures

 docs/devel/testing/functional.rst        | 16 +++++
 tests/functional/qemu_test/cmd.py        | 89 +++++++++++++++++++-----
 tests/functional/qemu_test/testcase.py   | 43 +++++++++---
 tests/functional/qemu_test/tuxruntest.py | 17 ++---
 tests/functional/test_acpi_bits.py       | 57 +++++----------
 tests/functional/test_arm_bpim2u.py      | 20 ------
 tests/functional/test_arm_orangepi.py    | 27 -------
 tests/functional/test_m68k_nextcube.py   |  3 +-
 tests/functional/test_mips64el_malta.py  |  4 +-
 tests/functional/test_virtio_gpu.py      |  3 +-
 10 files changed, 150 insertions(+), 129 deletions(-)

-- 
2.46.0


