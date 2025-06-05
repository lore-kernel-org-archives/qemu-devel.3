Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55040C5B559
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4Ze-0006Ba-Ud; Thu, 05 Jun 2025 02:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uN4Zc-0006B9-Az
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:59:36 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uN4Za-000391-9K
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:59:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:3878:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AA38860A22;
 Thu,  5 Jun 2025 09:59:28 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:976::1:1f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LxWRjF5FYqM0-CpjY7Rtr; Thu, 05 Jun 2025 09:59:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749106768;
 bh=ig1NU7fC86EK4kPQdQqVe1BbrlEmZOq9hDiSU4y6BY4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=rxwBuOtCeQQ7y5NNPibxMnAtDkE+ifMnLhPbIZRurOY/8xaobDJe1K4YEilD3/jQX
 71vu6grZ02AKI21PuUSzQ4E5gov6SzVRRdYUySfWZVrKEfAv/lDS0iJP/tSQWyx0LM
 xAi8V46V1vjN3k9J/42NJdRLFjE9YC6HrWUimjVM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v9 0/2] tests/functional: add memlock tests
Date: Thu,  5 Jun 2025 11:59:07 +0500
Message-Id: <20250605065908.299979-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add new tests to check the correctness of the `-overcommit memlock`
option (possible values: off, on, on-fault) by using
`/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck values:

* if `memlock=off`, then VmLck = 0;
* if `memlock=on`, then VmLck > 0 and almost all memory is resident;
* if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.

On `memlock=on` and `memlock=on-fault` VmLck will be the same.

---
v8 -> v9:
* meson.build: move test to x86 system quick list
* improve comment in memlock test

v7 -> v8:
* rewrite test, using process status file instead of smaps
for checking overcommit option;
* change error handling on opening status file;
* add SPDX identifier.

v6 -> v7:
* add skipTest if can't open smaps file of qemu process

v5 -> v6:
* add python3 shebang to tests/functional/test_memlock.py

v4 -> v5:
* refactor skipLockedMemoryTest decorator: using resource.getrlimit()
  function instead of spawning a process

v3 -> v4:
* add skipLockedMemoryTest decorator to skip test if system's locked
  memory limit is below the required threashold;
* add to MemlockTest skipLockedMemoryTest decorator with 2 GB limit.

v2 -> v3:
Move tests to tests/functional dir, as the tests/avocado dir is being
phased out.
v2 was [PATCH v2] tests/avocado: add memlock tests.
Supersedes: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>

v1 -> v2:
In the previous send, i forgot to specify new patch version (v2)
So i resend previous patch with version specified.


Alexandr Moshkov (2):
  tests/functional: add skipLockedMemoryTest decorator
  tests/functional: add memlock tests

 tests/functional/meson.build             |  1 +
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 18 ++++++
 tests/functional/test_memlock.py         | 79 ++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_memlock.py

-- 
2.34.1


