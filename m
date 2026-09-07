Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544EDC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZAw-00044q-2X; Mon, 07 Sep 2026 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZAt-0003vr-Nb
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZAq-0006Ot-Hb
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sSTDCwIlmfh0kRb/u3POSdgu66kdRZsNqeQvwqyrrvU=;
 b=hHYSmUXYSLHEvrGOaYZ+6VPhnTAbsIoMsoMcFJ+QhFcvQRNwTsW+wUmDiIm7relZmsYaru
 GzgfKQPjAES7O2lmV1sozveZ6jdqPw4Dao5C2WHUr4cVkGptvV4lHYTbIdRIv5q4FRfsQt
 CryQIlrh032QvlBoZC95X0j/ifJgBNk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-_ntjX2NLNeyJMEYJqxFIOg-1; Mon,
 07 Sep 2026 09:14:08 -0400
X-MC-Unique: _ntjX2NLNeyJMEYJqxFIOg-1
X-Mimecast-MFC-AGG-ID: _ntjX2NLNeyJMEYJqxFIOg_1788786845
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05EFC19540EA; Mon,  7 Sep 2026 13:14:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8CEC1800577; Mon,  7 Sep 2026 13:14:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 0/9] Make HMP optional - follow-up
Date: Mon, 07 Sep 2026 17:13:54 +0400
Message-Id: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12N0QrCIBhGX2V4naH/zGFXe4/oYum/NNgcuqQYe
 /d0EVSXB75zvoVEDA4jOVYLCZhcdH7MUO8qom03XpE6k5kAA8kUk3T0dpgoN6B6phuhhCF5OwX
 s3WPrnM5vjvfLDfVc5LKwLs4+PLejxMvuv5k4ZdR0iEoKxbWo24DGdvNe+4GUaIJvrflokDVp1
 AGMakAD/9HWdX0BpT34BuQAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WEzYvatU2N8NMElQ7Udw9S2oIapumh9HHEFxFtBikXQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriXzjGwTtQ4i8PsCNvVzwDgO7+vtTlAW6h9b
 B+934YOguWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64lwAKCRDa6OEJdZac
 5fSxD/9+09UeSBRJ+Rk8n6M26GKug3j6g7TEaAQJhqzF3kn+WkSfxgahlFhHU5FI3uLdYe6Nquz
 WcQaFoZc0bMhLXnh+paPnz/HvPJJJwXircY9xsdlp2JhcugkQMqzNK46u4oPu2Dd8vS+v9cgYvy
 TZHh+pQ55mI3/drWMQhm6ay3a7380MZIKfyrqBO+RV2iPkXr5fciEQDfaf3HAWmCAZ2qTKUWEou
 QFXor14t/yL/LsHNbIXmJsOOlJZt7OXZLLIVM0jkwGurLZjbAy1NnEs/BIP2JK1JRPpz4iMcmmW
 FMG6PrsiZ9e79pvLI3bW5Fhqujx2IxI41jZetTRdswisVtmOnQIdTo4cbxB8n8A6nKTwOiSWjWu
 fbYAftEWnWgB0nfD+zh5m1dGPswNuWh4KdqA8yrmFZ65DHuGgsnGlQhUAg1cJNNN6wIyzjR7X6E
 6NAiNukT8nMUmaNIMtLk+YMeVcarf1LyosBO3blBzdhZqWPahQCiW6y/YO/ByFRpRF719eO3CLj
 lTnRkbVci/BgPEqf4K9TiSrxHRw0ySmLAnQn4ME17//ulH5i53IZbrO0KYJg742lhrGa7vcW2+5
 dGme23I9mP2BR/aGLdxNPUKYpXmsIUUvo6vzUvpeUg4+D5WHTYs1II5aGng1nf6OQBk3+ROhgmd
 ZQjU5l5P+JlzbZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

Fix the issues that Peter reported while merging "[GIT PULL 00/50] Make
HMP optional".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v3:
- back to skipTestIfNoHMP()
- handle QMP screendump CommandNotFound, skip test
- Link to v2: https://lore.kernel.org/qemu-devel/20260907-nohmp-v2-0-6d952d972c21@redhat.com

Changes in v2:
- replaced skipTestIfNoHMP() with more versatile @skipUnlessConfig()
- rebased on staging, added r-b tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260906-nohmp-v1-0-daee96491c43@redhat.com

---
Marc-André Lureau (9):
      tests/functional: replace HMP with QMP
      tests/functional: add skipTestIfNoHMP() helper
      tests/functional: skip some tests that require HMP
      tests/functional/s390x: use QMP for balloon
      tests/ahci-test: replace HMP usage with QMP
      tests/qtest: add qtest_qmp_job_wait()
      tests/ide-test: convert to QMP
      tests/drive_del-test: compile out HMP-dependent tests when !CONFIG_HMP
      qtest: compile out HMP helper when !CONFIG_HMP

 tests/functional/arm/test_integratorcp.py | 13 +++++----
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
 11 files changed, 137 insertions(+), 53 deletions(-)
---
base-commit: cacd3462963a0a4f5bab4263ce79c2aa4b32692d
change-id: 20260906-nohmp-1d29f0c7494d

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


