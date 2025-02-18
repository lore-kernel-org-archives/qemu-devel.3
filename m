Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FD7C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPVy-0007oN-13; Tue, 18 Feb 2025 10:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPVu-0007nb-L3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPVs-0007zb-EX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EwQzFErkc0Z0XYWwbHj8UH1vccsCgBFL+ycBX1LN9rc=;
 b=FeR7GpAZry6yicO9uUpzz/KhZiLawZMABMFwCmonm8dWpbAtrkv/cFirH03vBiz+w8JsJr
 vl37gC7UUN1tLM4wiHwyqgKsDdX77yunwlTSb2ht/yOQP5kT6i3Le7S9yu0sKUlUYms7qA
 RgtIn7jNoeLaYIhRKRmpDEpy9Kwbwvo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-qhbrP7vjNDuwNuJtBNPI8g-1; Tue,
 18 Feb 2025 10:27:50 -0500
X-MC-Unique: qhbrP7vjNDuwNuJtBNPI8g-1
X-Mimecast-MFC-AGG-ID: qhbrP7vjNDuwNuJtBNPI8g_1739892469
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68AF180036F; Tue, 18 Feb 2025 15:27:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AA401800359; Tue, 18 Feb 2025 15:27:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/14] tests/functional: Convert the replay_kernel tests
Date: Tue, 18 Feb 2025 16:27:30 +0100
Message-ID: <20250218152744.228335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Convert the remaining Avocado tests from replay_kernel to the functional
framework. It's all pretty straight forward, we just have to use the
new ASSET_* framework now and make sure to put all tests related to
one CPU target into a separate file, since the functional framework
uses one qemu-system-* per file, and not per subtest.

Thomas Huth (14):
  tests/functional: Provide a proper name for the VMs in the replay
    tests
  tests/functional: Convert the xtensa replay test to the functional
    framework
  tests/functional: Convert the sparc replay avocado test
  tests/functional: Convert the 32-bit ppc replay avocado tests
  tests/functional: Convert the or1k replay avocado tests
  tests/functional: Convert the ppc64 replay avocado tests
  tests/functional: Convert the microblaze replay avocado tests
  tests/functional: Convert the m68k replay avocado tests
  tests/functional: Convert the arm replay avocado tests
  tests/functional: Convert the alpha replay avocado tests
  tests/functional: Convert the s390x replay avocado tests
  tests/functional: Convert the aarch64 replay avocado tests
  tests/functional: Convert the x86_64 replay avocado tests
  tests/functional: Convert the i386 replay avocado test

 tests/avocado/replay_kernel.py             | 412 ---------------------
 tests/functional/meson.build               |  14 +
 tests/functional/replay_kernel.py          |   2 +-
 tests/functional/test_aarch64_replay.py    |  30 ++
 tests/functional/test_alpha_replay.py      |  29 ++
 tests/functional/test_arm_replay.py        |  69 ++++
 tests/functional/test_i386_replay.py       |  28 ++
 tests/functional/test_m68k_replay.py       |  42 +++
 tests/functional/test_microblaze_replay.py |  28 ++
 tests/functional/test_or1k_replay.py       |  27 ++
 tests/functional/test_ppc64_replay.py      |  49 +++
 tests/functional/test_ppc_replay.py        |  34 ++
 tests/functional/test_s390x_replay.py      |  28 ++
 tests/functional/test_sparc_replay.py      |  27 ++
 tests/functional/test_x86_64_replay.py     |  35 ++
 tests/functional/test_xtensa_replay.py     |  28 ++
 16 files changed, 469 insertions(+), 413 deletions(-)
 delete mode 100644 tests/avocado/replay_kernel.py
 create mode 100755 tests/functional/test_aarch64_replay.py
 create mode 100755 tests/functional/test_alpha_replay.py
 create mode 100755 tests/functional/test_arm_replay.py
 create mode 100755 tests/functional/test_i386_replay.py
 create mode 100755 tests/functional/test_m68k_replay.py
 create mode 100755 tests/functional/test_microblaze_replay.py
 create mode 100755 tests/functional/test_or1k_replay.py
 create mode 100755 tests/functional/test_ppc64_replay.py
 create mode 100755 tests/functional/test_ppc_replay.py
 create mode 100755 tests/functional/test_s390x_replay.py
 create mode 100755 tests/functional/test_sparc_replay.py
 create mode 100755 tests/functional/test_x86_64_replay.py
 create mode 100755 tests/functional/test_xtensa_replay.py

-- 
2.48.1


