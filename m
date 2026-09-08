Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CC9C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sUp-00047a-53; Tue, 08 Sep 2026 05:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sUn-00046f-2u
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sUk-0002Zs-QX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ia7S7rFQJCAwoiw6ml/d0IuklJXIWlFUcRzlqZbGzpI=;
 b=jBaxTzNC8aEDGjI8L5Ou4C0/i6NL9/Y1twmWjMjgjkaFga18G26LV5S3RKhJko3EZXrUcp
 xqfq24oC/Bst448ESqZ4zfkd/qZBJN55iPX/X2DVTbIr+U/Mp7PJA6f969QH5g8KNGcS6+
 inPj3s6fu2sU2a4309fm00EPAfAsHU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-64HU_vSDPlurhZs3yg-rhw-1; Tue,
 08 Sep 2026 05:51:59 -0400
X-MC-Unique: 64HU_vSDPlurhZs3yg-rhw-1
X-Mimecast-MFC-AGG-ID: 64HU_vSDPlurhZs3yg-rhw_1788861118
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B3321977309; Tue,  8 Sep 2026 09:51:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4849919560AB; Tue,  8 Sep 2026 09:51:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/10] Make HMP optional - follow-up
Message-Id: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
Date: Tue, 08 Sep 2026 13:51:49 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QUcU0hNOheF2PvIK45whKY/GhpBQRzj/NhN0XOcItms=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6530r1qNks28cs+hcCQ+DkDrsuMVR6/vD1
 6K3LEqIN4iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5YCWD/9khlXfK1cSQSWXEYkdlvIFGx5ChVmJjJDKEocRdhWdcgE1MGYNgqKv9s3UHvk50fKQtf3
 LPX7AQ10CC63osqsLtvFhEdmqzO/uPcO4/2c9rzTgf5spSuhGpsxOH2LqCzC4m0JhG24OYZN/i+
 GxgklJ13LDHqEypRhP2XAuXddsLkWzGpj/OKnqy76ZoyzEVY+tjaRsVjQ4XEOVBtnSySX4edhAu
 2R/7GT+WborgSON+YnXoKfSYaFWa8qSOWG1ZoKKG/35jiQwVnFbS/4IyQVUbPP4IpCG6kbuKY9b
 iaJ1mtAfT0VLUO0oN7WBKPsDagejR0PZ2EC3Dz/c5/uXV6jAZtQimnIuv5efh0MxTWjQ50L7RPE
 S84vdhA0/fVkzrKDzRxrZfBZfR/ePP94+twPfVM48LN5iYIAfjFqvuaVCGV8i5Fedm/aR4LoM/u
 A1p52ueX4GfGSWvVQE+KKUmhgPwCPAeRmAaWKL3ZRPJHk8thzWUMYJRJL2iTSaL1yp17VRgb/NR
 tZN2mFJcGMUPI8x6a/p6BvH0v6AdteTTPbRLy/w6G6dIxAxqjQ++YGW5pa6A4MpggAnxpZLZNhZ
 k9rF/OVugC2683FsBcn/4OBQLjLP9+8fojB98vwp7dAyxeQENrWDbNNYyBo0gMyVVCUHJGEagtZ
 HwZayFbcRnkWHdw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 35500e5c41aec76cde59befe750600dac7a9e37a:

  Merge tag 'pull-aspeed-20260906' of https://github.com/legoater/qemu into staging (2026-09-07 13:33:12 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v1

for you to fetch changes up to 7e72db1dd160628f2b806d5a3fe25125f5aee823:

  tests: fix qemu:func-hexagon-linters (2026-09-08 13:51:37 +0400)

----------------------------------------------------------------
Make HMP optional - follow-up

Fix left-overs tests failing when --disable-hmp

----------------------------------------------------------------
Marc-André Lureau (10):
      tests/functional: replace HMP with QMP
      tests/functional: add skipTestIfNoHMP() helper
      tests/functional: skip some tests that require HMP
      tests/functional/s390x: use QMP for balloon
      tests/ahci-test: replace HMP usage with QMP
      tests/qtest: add qtest_qmp_job_wait()
      tests/ide-test: convert to QMP
      tests/drive_del-test: compile out HMP-dependent tests when !CONFIG_HMP
      qtest: compile out HMP helper when !CONFIG_HMP
      tests: fix qemu:func-hexagon-linters

 tests/functional/arm/test_integratorcp.py | 13 +++++----
 tests/functional/hexagon/test_systests.py |  6 ++--
 tests/functional/m68k/test_nextcube.py    | 12 +++++---
 tests/functional/mips64el/test_malta.py   | 13 +++++----
 tests/functional/ppc/test_ppe42.py        |  1 +
 tests/functional/qemu_test/testcase.py    |  6 ++++
 tests/functional/s390x/test_ccw_virtio.py |  4 +--
 tests/qtest/ahci-test.c                   |  5 ++--
 tests/qtest/drive_del-test.c              | 47 +++++++++++++++----------------
 tests/qtest/ide-test.c                    | 37 ++++++++++++++++++------
 tests/qtest/libqtest.c                    | 39 +++++++++++++++++++++++++
 tests/qtest/libqtest.h                    | 13 +++++++++
 12 files changed, 140 insertions(+), 56 deletions(-)


