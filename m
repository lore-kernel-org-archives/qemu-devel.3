Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D8AC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wdr-0005DU-6a; Mon, 07 Sep 2026 06:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wdc-0004mZ-86
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WdZ-0003an-Cs
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EgVer5Kt/Dp7YYq7S8JGA3Yvgj7JhgveZsVZ7tESQzk=;
 b=GlW00aSQe/oRpnlOXgWhglfKmpD5T/ezc0ez0MR2SGNZMW9L2jcCNZk/G1vFJRf6TeKgG5
 gi9V31Wy5HESr+mqLFbQmI2dBg5G68AqS1c0MoAUW9m2ht0BdpFfa+rgmILfkPih7g0Gvu
 dfL7e6E0vAYZbtcG2sd+A15HSrY3P94=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-2SFIhjE5O9WjJvSfIuiKWw-1; Mon,
 07 Sep 2026 06:30:34 -0400
X-MC-Unique: 2SFIhjE5O9WjJvSfIuiKWw-1
X-Mimecast-MFC-AGG-ID: 2SFIhjE5O9WjJvSfIuiKWw_1788777032
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6595D193F079; Mon,  7 Sep 2026 10:30:31 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EEB81956042; Mon,  7 Sep 2026 10:30:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/10] Make HMP optional - follow-up
Date: Mon, 07 Sep 2026 14:30:18 +0400
Message-Id: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ7CIBQFr9L8tRhAUoMr72G6QPgVTAoNINE03
 F2oO5eTzJu3QcLoMMFl2CBicckF34AfBtBW+QcSZxoDp3ykko7EB7ushBkuZ6rPQgoDzV0jzu6
 9d27Tj9Pr/kSd+7gb1qUc4mc/Kqx7/83CCCVGIcpRSKbF6RrRWJWPOiww1Vq/Japxfa0AAAA=
X-Change-ID: 20260906-nohmp-1d29f0c7494d
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h+YeDbXBfas4cXMgbVlLFi9y5SHL+BZizOeWNGGan1I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJCwIE0RDqwSumMpo6FIKJ49yguwrZgAkrPy
 JS6Xpq1swyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQgAKCRDa6OEJdZac
 5Uk6D/9B1mPPZaxRB4LnKW9ZoBFcgf5JL7iT7FKKbChgJQdazR00Jg0fLMYy4msjpUYShUwt/C2
 xPium8/8aOTUiBNY+ncgLnzENSB1D0vE+bvtddv85bIb7Tvy7Mir1dRXjciJxfer3EN9V7RBawk
 BsxiSwyl1c9wUHuB6NBig1azM1QhEB+z0R5UkRS1WFM8HftJOPbrQDAYCUa1dQ2Av9utEh9oQ7g
 8xwqMccGioSCiZfRADAPrMw0WZiNsFh33WHTz6pVpm5se950tKlLebch4+gNrgpcqv/Jc/AwGaM
 kFtkoxoNFiDygIm7EqVMWz9K8xfDuhz55i2P82mGzUhtroktFDYCPoxDfvS1MBECuxiPgMAI4wm
 pfTyuB5IA6tdnjF878xQ14JOhtmduKbzNMEdRex/bCtJSBf5eCJ/Q2gJ3OgJZuR7OsWTORdQCyv
 29MgleYemw5EoDXA+ohc8sf4n5cnn8V13UYcOHk0emWE8Q5TpFMqam3ovwY5WLac+sgh7e7cgMp
 JCaMBsXycUsR793ONZYHOxm6J7T3Vw8Y/tJyzg47xKnKOer4+RhKx3XiFOrPCwVYiLE8IzEWHAC
 DPouVZXDsqmD7HhA0gLwJcUuOtngMt37U0JE9GEU7GaGyAFBmax2L/+PJbB2QihhEixT0nr4RZD
 4M9VpAgARdBGBuA==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Hi,

Fix the issues that Peter reported while merging "[GIT PULL 00/50] Make
HMP optional".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2:
- replaced skipTestIfNoHMP() with more versatile @skipUnlessConfig()
- rebased on staging, added r-b tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260906-nohmp-v1-0-daee96491c43@redhat.com

---
Marc-André Lureau (10):
      tests/ahci-test: replace HMP usage with QMP
      tests/functional: add skipUnlessConfig() helper
      tests/functional: skip if CONFIG_PIXMAN
      tests/functional: replace HMP with QMP
      tests/functional/s390x: use QMP for balloon
      tests/qtest: add qtest_qmp_job_wait()
      tests/ide-test: convert to QMP
      tests/drive_del-test: compile out HMP-dependent tests when !CONFIG_HMP
      qtest: compile out HMP helper when !CONFIG_HMP
      tests/functional: fix some tests that require HMP

 tests/functional/arm/test_integratorcp.py | 10 +++----
 tests/functional/m68k/test_nextcube.py    |  8 ++----
 tests/functional/mips64el/test_malta.py   | 11 ++++----
 tests/functional/ppc/test_ppe42.py        |  3 +-
 tests/functional/qemu_test/__init__.py    |  2 +-
 tests/functional/qemu_test/decorators.py  | 25 ++++++++++++++++
 tests/functional/s390x/test_ccw_virtio.py |  4 +--
 tests/qtest/ahci-test.c                   |  5 ++--
 tests/qtest/drive_del-test.c              | 47 +++++++++++++++----------------
 tests/qtest/ide-test.c                    | 37 ++++++++++++++++++------
 tests/qtest/libqtest.c                    | 39 +++++++++++++++++++++++++
 tests/qtest/libqtest.h                    | 13 +++++++++
 12 files changed, 146 insertions(+), 58 deletions(-)
---
base-commit: cacd3462963a0a4f5bab4263ce79c2aa4b32692d
change-id: 20260906-nohmp-1d29f0c7494d

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


