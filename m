Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18591D3ABFB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAqXx-0005Z9-1p; Tue, 12 Nov 2024 08:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tAqXv-0005YU-Ha
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tAqXs-0003bh-Pl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731416579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DK53IjCHi6Qbc7tXpbI4et1d8ofBb39k/MJbVROcd/s=;
 b=hYfFfWAfggSJjfyjpq6w3LilE/Up5hGB7xHjfv+HcGnTvCbBaure5QSnumhFlLMo+LZCu8
 OLW5Ag4O/NxQiWlCdHEoIZy75jDNQ76D1i5ZnPPlXvZ5yEgMMHtTEFEp/DzoZ9aD7n2sqG
 wYAi5thayUSSaPpa4yKSGMBPyoh8g5w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-3ItCtIKQNdq6VD8HFdYuLg-1; Tue,
 12 Nov 2024 08:02:56 -0500
X-MC-Unique: 3ItCtIKQNdq6VD8HFdYuLg-1
X-Mimecast-MFC-AGG-ID: 3ItCtIKQNdq6VD8HFdYuLg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A6611955EEA; Tue, 12 Nov 2024 13:02:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6024A1955F40; Tue, 12 Nov 2024 13:02:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/4] tests/functional: Finish conversion of Aspeed tests
Date: Tue, 12 Nov 2024 14:02:42 +0100
Message-ID: <20241112130246.970281-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

Hello,

The first patch is a proposal to fix a long-standing issue when
capturing the console output. In some cases, the expected string does
not match in the output, causing the test to fail with a timeout. The
change introduces a _console_read() routine that processes the console
output character by character as a possible fix.

Last patches complete the conversion of the Aspeed tests and remove
the console workarounds.

Thanks,

C.

Changes in v2:

 - Redirected all console output in console.log file
 - Added a "found" prefix when an expected string is captured
 - Used a user mode network backend in SDK tests
 - Changed the expected string to "login:" in buildroot tests
 
Cédric Le Goater (4):
  tests/functional: Introduce _console_read()
  tests/functional: Convert Aspeed aarch64 SDK tests
  tests/functional: Convert Aspeed arm SDK tests
  tests/functional: Remove sleep workarounds from Aspeed tests

 tests/avocado/machine_aspeed.py         | 202 ------------------------
 tests/functional/meson.build            |   2 +
 tests/functional/qemu_test/cmd.py       |  22 ++-
 tests/functional/test_aarch64_aspeed.py |  97 ++++++++++++
 tests/functional/test_arm_aspeed.py     |  79 ++++++++-
 5 files changed, 191 insertions(+), 211 deletions(-)
 delete mode 100644 tests/avocado/machine_aspeed.py
 create mode 100644 tests/functional/test_aarch64_aspeed.py

-- 
2.47.0


