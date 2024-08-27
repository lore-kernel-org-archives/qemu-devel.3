Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9734C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivMH-0002gx-0Z; Tue, 27 Aug 2024 08:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sivM0-0001eu-GT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sivLz-0007xZ-0M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724761878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mVSql3b/wGkiTANpSBEoKw6Q8gmiXzuQUFTsam4y7Y=;
 b=VrePxfuU5RVQeMi/HLNFYitC13U6EOrICz6EVyyzdlmF98SGAU8Hbs+Pr5H1qyvsrjuXAn
 pXjmx5AxE3FsvTN6WLKu8mnqkeyiZCd3PMXI/Ba1SKYvg6ubcytfz01LmA17ciQFALL2hl
 FxB/8rV3KKYkGVY/Nzxz7Um3N6pEB+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-vnYUWAyIPGumdfdTDlxivQ-1; Tue,
 27 Aug 2024 08:31:12 -0400
X-MC-Unique: vnYUWAyIPGumdfdTDlxivQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01FCB195421E; Tue, 27 Aug 2024 12:31:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CEF719560A3; Tue, 27 Aug 2024 12:31:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/2] tests/functional: Add LinuxKernelTest class and convert
 Q800 test
Date: Tue, 27 Aug 2024 14:31:05 +0200
Message-ID: <20240827123107.34475-1-thuth@redhat.com>
In-Reply-To: <aeb7bd72-095f-43cf-8216-18c341310915@linaro.org>
References: <aeb7bd72-095f-43cf-8216-18c341310915@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Here's how I'd suggest to convert the tests from
tests/avocado/boot_linux_console.py :
Copy the whole LinuxKernelTest class (well, let's drop extract_from_rpm
for now since it is completely unused), so we can copy the test code
with only some few modifications (using the Q800 test as an example here).

Thomas Huth (2):
  tests/functional: Add the LinuxKernelTest for testing the Linux boot
    process
  tests/functional: Convert the m68k Q800 Avocado test into a functional
    test

 MAINTAINERS                               |  1 +
 tests/avocado/boot_linux_console.py       | 24 -------------
 tests/functional/meson.build              |  3 +-
 tests/functional/qemu_test/__init__.py    |  1 +
 tests/functional/qemu_test/linuxkernel.py | 41 +++++++++++++++++++++++
 tests/functional/test_m68k_q800.py        | 37 ++++++++++++++++++++
 6 files changed, 82 insertions(+), 25 deletions(-)
 create mode 100644 tests/functional/qemu_test/linuxkernel.py
 create mode 100755 tests/functional/test_m68k_q800.py

-- 
2.46.0


