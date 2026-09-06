Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3827C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38Sj-00041s-Dh; Sun, 06 Sep 2026 04:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Sh-00040G-0m
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Se-00082L-RI
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=88EwVqFTSxxPFTaCCvCGWpRx9NdU4wpx6DZzqnCIulQ=;
 b=PmRSuV0foTvJphaAo4fI8BoCXF318Bt0pkFqEwXMcy5VAgwqV+uw2acYU45W8L8g119xmv
 R9cr+72Dzt+uxY5/kcvEwyWHt1PRNkatVl5aFgLdxHQ43Nfv/Ius7+OeaN2F9z/5+KKxQq
 frXShiRw66GhaxJ/b9caoC1BOevTKdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-l7aCTDG6MVGwdBamaTWVMg-1; Sun,
 06 Sep 2026 04:42:42 -0400
X-MC-Unique: l7aCTDG6MVGwdBamaTWVMg-1
X-Mimecast-MFC-AGG-ID: l7aCTDG6MVGwdBamaTWVMg_1788684160
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB8121955E77; Sun,  6 Sep 2026 08:42:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6651F434; Sun,  6 Sep 2026 08:42:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/9] Make HMP optional - follow-up
Date: Sun, 06 Sep 2026 12:42:31 +0400
Message-Id: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMz3bz8jNwCXcMUI8s0g2RzE0uTFCWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQDIDcwVaQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mpRwCO6b6h3FKqAWyyce8+EVW537SX8CLReCjpHC4u4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5cRxEm7ug4wQRsrK2b9ABmZVmvXhig1wbc
 k/ryjkoUbiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5bNZEACW6zH5i3WviteE3WWwicogeEJGlb8lKOjes71x97WODeRkrbZxd1A8vMUsYrtat33ALT5
 19GMx8rkU4ebCgbRRotX6wphW1ptNLfrU1AlJiQsk5HREXjGwXpwZfoDG+6H7l5/0hl81J/jleZ
 gilAgh82+chpeHCjZm1Qz0E4zG72Vq4+osUwPXLxxlQoL9r2K/62zPrwqQfZZlS2rK5HBCAiUaA
 y0srsBDSQl+5V0k/t1cOt+6AL2CW1S0MryTanH6Fzv8xDrGJAeivjxr2ORvAQCDnp53xjpVT912
 yA2hHJfsiBS+fps+lVo8bZr+9l8UO8924ff/Wc/ORjWAmtR20kjAcOXxejwXtOSuZu3FjFhPfTN
 bSQDKCjRDFVQMiX1RExR4qu9N4JlsMlbvnXDJNyV7qycwjnxbeuAlqxyhRxm9jW0sGVDI3SDuwN
 t6rR0TDTd7/7f10dl75rJucLfbxPo46053YAfsI/bZgWOI6VU0EQiO2QlEE8EeBYzBGTxS/9FZs
 eHd2Wo6m5snU/9ToVbEyHzz8muAp2oug+PblPgDJnJzroJsRFjxvqHzY55Q6rzQTPpocTvg/Wb0
 QkvKJE9SBPe1y/uxUW3AOcj4wYXk/YOYSN2Ko2ZAdSDAaRGOVkGRuMpxZLlGfxJEYocHI8q0sxf
 7LfRDBrQkDlcpzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Hi,

Fix the issues that Peter reported while merging "[GIT PULL 00/50] Make
HMP optional".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (9):
      tests/ahci-test: replace HMP usage with QMP
      tests/functional: replace HMP with QMP
      tests/functional/s390x: use QMP for balloon
      tests/qtest: add qtest_qmp_job_wait()
      tests/ide-test: convert to QMP
      tests/drive_del-test: compile out HMP-dependent tests when !CONFIG_HMP
      qtest: compile out HMP helper when !CONFIG_HMP
      tests/functional: add skipTestIfNoHMP() helper
      tests/functional: fix some tests that require HMP

 tests/functional/arm/test_integratorcp.py |  7 ++---
 tests/functional/m68k/test_nextcube.py    |  6 ++--
 tests/functional/mips64el/test_malta.py   |  7 ++---
 tests/functional/ppc/test_ppe42.py        |  1 +
 tests/functional/qemu_test/testcase.py    |  6 ++++
 tests/functional/s390x/test_ccw_virtio.py |  4 +--
 tests/qtest/ahci-test.c                   |  5 ++--
 tests/qtest/drive_del-test.c              | 47 +++++++++++++++----------------
 tests/qtest/ide-test.c                    | 37 ++++++++++++++++++------
 tests/qtest/libqtest.c                    | 39 +++++++++++++++++++++++++
 tests/qtest/libqtest.h                    | 13 +++++++++
 11 files changed, 119 insertions(+), 53 deletions(-)
---
base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
change-id: 20260906-nohmp-1d29f0c7494d

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


