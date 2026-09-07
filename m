Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB9CC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WjK-0000jZ-4Z; Mon, 07 Sep 2026 06:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WjJ-0000jG-AZ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wj4-0004HI-OH
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dwcCBq9JxVWiIUYZWBjdCoyYEm1ieLlZHInZiBmG9Y=;
 b=Z8hSmweuQ5krNz4K8YY6A4Pn9ZjjjmI4xycKA9kE22hkFgnaOjX+JUFvZUHFd2Kr92CXy5
 XkUj8a+8RfdCS8rORVEr17n4i1o6f4i7bq8nXnuCdgq7pdPIKCvITcEG7ExwLu0zmpPCc2
 lpDKWj5pz1/G6YP7hRYHzs1M2S+PZIg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-VXMaZqTgNEavXlNPrXWaBQ-1; Mon,
 07 Sep 2026 06:31:10 -0400
X-MC-Unique: VXMaZqTgNEavXlNPrXWaBQ-1
X-Mimecast-MFC-AGG-ID: VXMaZqTgNEavXlNPrXWaBQ_1788777068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5B7A1802162; Mon,  7 Sep 2026 10:31:07 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 833DC1800577; Mon,  7 Sep 2026 10:31:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:28 +0400
Subject: [PATCH v2 10/10] tests/functional: fix some tests that require HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-10-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vczpgToxbft+6rJhaegC1wW8anYwt9OMkpy1ZKiQlu8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJD9XSdF1AMNldNGFvcxlc75vCXwjxhAjpYT
 N/ztgPdvG2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQwAKCRDa6OEJdZac
 5cUAD/4toRCY1ncsJpl1WT6J+rjFNK6cj5wWLmq61nWh+KNBj5G2BWXwU/9YOJVfCCb1Y6iMswc
 1JW1J9NoMzw8NtHsTpadbLrb5pqgxdk9GWNMCecJ72LB6qbJ9yB1OYf0KEPdnm8JWDsyNsJZdmb
 hLhBjcs2QdYmaq6wMOMYZkIPQFDRwclG2SM/AbAC/jcIpIgvY7XyhMuxLaT483qqX5+MWk+JlRc
 qb3hpefOUsOppZrrHEn7RV767OBxD0XB839Aq8MStFHVdCdsgD6yeG3Wcug95Cs/Iv2VjOXODfh
 +VuVPDfiq5tNrquvw1EKtXi04FReZbWaDsyrBKBebPx+UWQrw/Y+agO+RnLq1zdrONheWQJXrh9
 DjuJA6x+DtKXXdXrCOf2Z9VOMMhGqhHrSDg+m0B7IA5zkrKz1rIBLmTFC/C9wzB7nlHQUy0rvlN
 2Y5PjMITWoEoVgxfK2SWkN0ShRg4fFZdPjXq48rf9AANU/zyyUck0aN6fbbGfoGGlFD6Wz0PhBV
 aKv96GLS54APbMU9byeGFX4IFjgpwzFV7xFnCZXsHJ0JUwFUB4R4+GrTn6y89AZj73fZaZPo0Ax
 AU4/jVLTHplPQMGgRrePfah+SkB5uoOATqCb9k+sjJ+UqtHApKAgsJChjggZjcditZpaBuYiteD
 t6Ha1dEToCR7EXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Those tests use "info registers" command and cannot be converted
easily, for now skip them

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 2 +-
 tests/functional/ppc/test_ppe42.py     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index 82e157882e0a..cd7383f282a1 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -14,7 +14,7 @@
 from qemu_test.tesseract import tesseract_ocr
 
 
-@skipUnlessConfig("PIXMAN")
+@skipUnlessConfig("PIXMAN", "HMP")
 class NextCubeMachine(QemuSystemTest):
 
     timeout = 15
diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
index 53958a7938d1..a3b8d7fa89f1 100755
--- a/tests/functional/ppc/test_ppe42.py
+++ b/tests/functional/ppc/test_ppe42.py
@@ -7,9 +7,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import asyncio
-from qemu_test import QemuSystemTest, Asset
+from qemu_test import QemuSystemTest, Asset, skipUnlessConfig
 
 
+@skipUnlessConfig("HMP")
 class Ppe42Machine(QemuSystemTest):
 
     timeout = 90

-- 
2.55.0.543.g5ebe2ebe4ea8


