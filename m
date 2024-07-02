Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BF3C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeBf-00055j-Kc; Tue, 02 Jul 2024 10:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBd-00052G-P9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBa-0008E3-KE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+zh1wfaSmmaGh+SRQcFGybC5BaSt211Udvwvhl5h14=;
 b=PluSL00/gLzNWD9tsLBh7dmEMqixlPcd8twL9SKBXeODiH3ewBsUGHgnwc/s89d1KM/hGS
 74tE8bKAIol3qWz/rCgg0Z8cXxf/HIH60nVL5NpG8ms128CC9bW9OU6nDIx6BzWahwDZdo
 AbjOBJABsebT5C5MpGYTimGiSXgyTHs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-m_7bE9mqOPyzFPvkHrswqA-1; Tue, 02 Jul 2024 10:08:42 -0400
X-MC-Unique: m_7bE9mqOPyzFPvkHrswqA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-363edcf12a3so2708920f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929320; x=1720534120;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+zh1wfaSmmaGh+SRQcFGybC5BaSt211Udvwvhl5h14=;
 b=MXbirWJYONReoCX64TjEJ+8FkY00AdE2z/jxC5EaqWA2lhMRBb3qpD0PFdaBSNPGvl
 S7wTVwPo5V5BTcIsU33fyN6RcHfjt2UJSv61yQ2s83NOlovyErNn3IUissrHP0tWmd43
 TLfeABq+wefimeS4gKVddyKUDCtDNTNVINK6TwgDOZV8bRUtJ/dVL7EjXQqRLzu/2Eg8
 eCT11QDZq3hpvwEQVvTjpzlUw73T+IfDJ6IDPohFekf+QeVBuIJEmp56OXLzQTUvcOJC
 cV9kbxWoZsxH3AS2EaY825NHHNQVT0yJFFW4t3MeJqCaObUvEMFpxiyBgRJ4U1jFcdvU
 E3GA==
X-Gm-Message-State: AOJu0YwK4FAfDXSx7Gx5EtUZQ/sZX2edeEVBJTMdOsJUs7+BtE5zuFgf
 6GABd3lMZ0vIwSn54A1ewTT8EtbRMs/3dK6yIFbfcxp+zVTU6tXDwYZKSkAJWnzrGczz41bThFu
 ENn441ZULQKrrTBuFKDRTIWeWd1fR2Dna62zDIzkvMhlbegMMv7r+7J6A2zxn2Ha8IvFmY/qL5O
 1BGEW/EojJdV5Ydnjx5xSt+D8je4Wz9Q==
X-Received: by 2002:a05:6000:18ab:b0:363:69dd:ac3a with SMTP id
 ffacd0b85a97d-367756decc7mr6509253f8f.42.1719929320384; 
 Tue, 02 Jul 2024 07:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmKdL5bbkTE4feBAsbAL+yjsWCYxU9rIuuygPgjDJhdpvKrPtPSX8Y3IlPRyodvzDF6hXF/Q==
X-Received: by 2002:a05:6000:18ab:b0:363:69dd:ac3a with SMTP id
 ffacd0b85a97d-367756decc7mr6509225f8f.42.1719929319866; 
 Tue, 02 Jul 2024 07:08:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d62sm13290326f8f.105.2024.07.02.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:39 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 32/91] tests/qtest/pvpanic: use centralized definition of
 supported events
Message-ID: <462dc749c110fe8e41ae0fb554b9bc2f2671e973.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Avoid the necessity to update all tests when new events are added
to the device.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-4-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/pvpanic-pci-test.c | 5 +++--
 tests/qtest/pvpanic-test.c     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index 2c05b376ba..b372caf41d 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -16,6 +16,7 @@
 #include "qapi/qmp/qdict.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
+#include "hw/misc/pvpanic.h"
 #include "hw/pci/pci_regs.h"
 
 static void test_panic_nopause(void)
@@ -34,7 +35,7 @@ static void test_panic_nopause(void)
     bar = qpci_iomap(dev, 0, NULL);
 
     qpci_memread(dev, bar, 0, &val, sizeof(val));
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     val = 1;
     qpci_memwrite(dev, bar, 0, &val, sizeof(val));
@@ -67,7 +68,7 @@ static void test_panic(void)
     bar = qpci_iomap(dev, 0, NULL);
 
     qpci_memread(dev, bar, 0, &val, sizeof(val));
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     val = 1;
     qpci_memwrite(dev, bar, 0, &val, sizeof(val));
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index 78f1cf8186..ccc603472f 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
+#include "hw/misc/pvpanic.h"
 
 static void test_panic_nopause(void)
 {
@@ -20,7 +21,7 @@ static void test_panic_nopause(void)
     qts = qtest_init("-device pvpanic -action panic=none");
 
     val = qtest_inb(qts, 0x505);
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     qtest_outb(qts, 0x505, 0x1);
 
@@ -43,7 +44,7 @@ static void test_panic(void)
     qts = qtest_init("-device pvpanic -action panic=pause");
 
     val = qtest_inb(qts, 0x505);
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     qtest_outb(qts, 0x505, 0x1);
 
-- 
MST


