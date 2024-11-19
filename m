Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CABBD44167
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDPnO-0005c2-G7; Tue, 19 Nov 2024 10:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnJ-0005XH-Cy
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnH-0003ep-B8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732028728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2xmuVFDb+PEPk8z9BPNYZYzwZgz+f8VmjZ2ATw2aCxw=;
 b=MkZUy2tqLqf4pM5lAT68ahuDta/f7bEhwg0+Y9ykg5xqgPKuKvXnDvE0L4POKnQ9EGsXpF
 lOg8tu9mcfHuVpMcRTcguIeoENX88/gi47fjM8uNU1xFTeA5nJWWv10ChagGSfiYH54co0
 mI6IcOs6+NAv2wmJ9lHXM5KEZKWUz4Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-XKuZbl-cNqWcpAoKVlFa1w-1; Tue,
 19 Nov 2024 10:05:25 -0500
X-MC-Unique: XKuZbl-cNqWcpAoKVlFa1w-1
X-Mimecast-MFC-AGG-ID: XKuZbl-cNqWcpAoKVlFa1w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EE5E1953948; Tue, 19 Nov 2024 15:05:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB17A195E480; Tue, 19 Nov 2024 15:05:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/15] test/functional: improve functional test debugging &
 fix tuxrun
Date: Tue, 19 Nov 2024 15:05:04 +0000
Message-ID: <20241119150519.1123365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Daniel P. Berrangé (15):
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
  tests/functional: rewrite console handling to be bytewise
  tests/functional: remove time.sleep usage from tuxrun tests
  tests/functional: add a QMP backdoor for debugging stalled tests

 docs/devel/testing/functional.rst        | 16 ++++++
 tests/functional/qemu_test/cmd.py        | 65 ++++++++++++++++++------
 tests/functional/qemu_test/testcase.py   | 33 +++++++++---
 tests/functional/qemu_test/tuxruntest.py | 17 +++----
 tests/functional/test_acpi_bits.py       | 56 +++++++-------------
 tests/functional/test_arm_bpim2u.py      | 20 --------
 tests/functional/test_arm_orangepi.py    | 27 ----------
 tests/functional/test_m68k_nextcube.py   |  3 +-
 tests/functional/test_mips64el_malta.py  |  4 +-
 9 files changed, 119 insertions(+), 122 deletions(-)

-- 
2.46.0


