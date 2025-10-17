Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2043ECCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lDC-00053v-Ot; Fri, 17 Oct 2025 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lD5-00050d-Az
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCY-0005kh-AW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471131d6121so15684095e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710378; x=1761315178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQnslZlvL/ycghWXR/jv6T9Aq0fKGJTc5vHN36t+VJw=;
 b=c5wykiyxzSpjQNSSy0pfMlC5KU3GMx4FO7WU5+prJpQOVbxKR8Y5A9pAab2pGNh89J
 /p0XcqyCepHtAKFzvMKAHUBPsuffd2C5GIeTmlGK+0Ygcjqg4UUto4Y50fXf8ShKaTIo
 x220rd/v8DSwE1b3hgjUwbsyJ+CxxJx2jcbr5ns6Mc04KAdtFCICrt/TLDTezsoPB1Fk
 7fv23mcxxqtdQvv9pSCtsQATU1WAoHBuDI1iBXh2fWoj4nYc0SrOK26Vwaw1hlLPZjzL
 XI0DyKgD+o/SBPyuGu2GIzFJemIEYtqJQ9bmHt8Emfy6z083ijYdziP4M98kBCsdnrpj
 ChXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710378; x=1761315178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQnslZlvL/ycghWXR/jv6T9Aq0fKGJTc5vHN36t+VJw=;
 b=ISBf8u8cVIw4ydPbbW4Gry+HV2SBChGDSyznGCJIkvx/zlvmJgQRy9pU9N9RBNSopO
 iXPyEPFF6tLdnUraFfUbFBrhMOrDHTuonzI0XMmhUg4A05fKzOH9SadC/EBDJCLpz4VB
 bZGmJRdjL+zM5FDs55HAVmG0z1IpEc1WiscAiwTPJOpbshsJYOQxR+DdZ0exyTF4k92C
 //Rt/aXYJxF9iWvGuf6XehCSx9YLs5AG90flUeIOqbn1OPTzo2bHZwc1R2hfBk6iTnQF
 MwrCJ9M6sKH1JM3Loq+Re2jtUuaHBzMep+TW9E8X5le8iB5Ta78K7ujnWOKyhG+izf9v
 DuHw==
X-Gm-Message-State: AOJu0YxzTilrxVdtDbf9TOOKUGI/+mak3a3vd9CXQFv1fSChorQlZ2B7
 LuBUCA8u8uaDtz/OWGlpJubbdEW1nlcvnrRax0gdYNuC8NrXjBdUDNK9Wcr9Ww==
X-Gm-Gg: ASbGncuSiGQT79XUrA1oXzzWz2FVNadfkBS+TSysIN3zjAXVcPQj81aeZLZld8JWiQt
 7WjvoppddHuVF9aUEjPc2BDsstlelZi5upeBBvCqy+SKoY3AnVHgScdXhrBG2duQmAVAom9IWOT
 8BWQ4WNsIFULPDAiN9IF6ZwOtP3VrTnDj0WRJKHvKE0bRc1NxgKWZ8m9mS3QnoiZFihSvtjXNvg
 5uxGLxcqOK73pBhEhfGhI3h/IEAbzU2DF7k4610fq8INZRkcWC0lXGCu0uCBsMNR3yc4j/Cfily
 RobxaQla+6Cva7iCNqLXQKO4johpfZavMV+l8zrJ8fjSMl1R3Bpc/Skr47sMJAWGSvUeCFhzAJx
 QWDIRqY99ypuxCMoyp3Frs18atgja/PvNqZxoyXnrV6ZBdKg7rDGUAGV39jhRIhY9LkdXT3b7nn
 XMglA4akDqbO7fR0uhApEtjaDCZWbHF+Hc
X-Google-Smtp-Source: AGHT+IE3VdA3wZK4Q+OXcjfSwZbSfpo04I9zXOgWlNizZyarmBkO2VPXkxj5kadJ9tYwUN2d2fgUFA==
X-Received: by 2002:a05:600c:37c7:b0:471:12ef:84be with SMTP id
 5b1f17b1804b1-47117900c2dmr26449135e9.22.1760710377632; 
 Fri, 17 Oct 2025 07:12:57 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 11/11] tests/qtest/ds1338-test: Reuse from_bcd()
Date: Fri, 17 Oct 2025 16:11:17 +0200
Message-ID: <20251017141117.105944-12-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017141117.105944-1-shentey@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

from_bcd() is a public API function which can be unit-tested. Reuse it to avoid
code duplication.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 tests/qtest/ds1338-test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index d12424d27f..b8d0e65ec4 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -18,16 +18,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bcd.h"
 #include "libqtest.h"
 #include "libqos/i2c.h"
 
 #define DS1338_ADDR 0x68
 
-static inline uint8_t bcd2bin(uint8_t x)
-{
-    return ((x) & 0x0f) + ((x) >> 4) * 10;
-}
-
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
@@ -39,9 +35,9 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     i2c_read_block(i2cdev, 0, resp, sizeof(resp));
 
     /* check retrieved time against local time */
-    g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
-    g_assert_cmpuint(bcd2bin(resp[5]), == , 1 + tm_ptr->tm_mon);
-    g_assert_cmpuint(2000 + bcd2bin(resp[6]), == , 1900 + tm_ptr->tm_year);
+    g_assert_cmpuint(from_bcd(resp[4]), == , tm_ptr->tm_mday);
+    g_assert_cmpuint(from_bcd(resp[5]), == , 1 + tm_ptr->tm_mon);
+    g_assert_cmpuint(2000 + from_bcd(resp[6]), == , 1900 + tm_ptr->tm_year);
 }
 
 static void ds1338_register_nodes(void)
-- 
2.51.1.dirty


