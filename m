Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C675CCD1A2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ijD-0000sX-Pl; Fri, 17 Oct 2025 07:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9ij8-0000r5-RH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9iiq-00061w-SX
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711f156326so4640845e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760700846; x=1761305646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQnslZlvL/ycghWXR/jv6T9Aq0fKGJTc5vHN36t+VJw=;
 b=F45eIRMlYdwRVbgsxKk22mh1tooZIUWGafXTjemdGjqvVvrO3cJIP6Z+dCzXphNNLs
 5oBjnhSupX/5A+B+m232xyi0Qv2WZpPodb/hvMmAjI6qnglCywBedsXumAc3YMQDa3MS
 9iOAZzKHlJKbUgfgPg5nr7yje2gUYAu78YZNdPP17/1AuremIckUatrI7Jy4im8jZFeC
 FLIVUhnrX2nI1AS1RGc5opW8LseKx22jaFLR8EiGghtZAS6RqTM9Lcs5LIIF3cpf3yxP
 S3SoWMPlUMLxwsbRHlGowz4Wo3LGn1jXZvvaKRc+B83A1MLBNdkH2QQABnTr01YBz/kO
 4BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760700846; x=1761305646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQnslZlvL/ycghWXR/jv6T9Aq0fKGJTc5vHN36t+VJw=;
 b=npIOXSwTBpIWIjyeA8oSyWFjE28ke196tqfA/9oblyLYHVSk8DPUGHSXHFj8+vNmzJ
 EgiI4/EUtd6MeI2iE/fc/in5pmpjiD6Sw2q8Jh/4s5NwBZE409kLtmNkR1bXtyJB9JBc
 lrYpnG5oaP0EujiXmdMmQYKeL77FSuWH8pEl1a7u6MF/oJHdUnKj2AsogRIOuc7sWR4H
 e8RsBBmIOsTPxtR8xF1e5zZqcuwEF6zXObzIcwzuwaoF9JAKZvlEiZM96xHhhkal9kOg
 Kjf57sqrnKskG0lJvRsE/IX62lwxIFwIlJmxOIJb4ELdRGh09VkGgfJt7mkpl/i3ztjO
 DTeQ==
X-Gm-Message-State: AOJu0Yx2vmBCa67sI1ImK771sxx92tbfpw/IXw/m4/vX8YVubxKVakbY
 wcipH3npkfxPqYUBCvMaXMqq1I6FeDurh57cvuwow+72gRG4GY+99m6HbNaMsg==
X-Gm-Gg: ASbGncvPsyeTlrsc7DnKFKe0znVCod+KUcE3XcDTcIpLPEA1fGqzVhiJT7zJm3xcW4O
 uW3sp6N6cHIZH3FjQpaDKowtmeWPxDdT63yAu92+4bZAxhjA0frcsOJH/h94qEmgT0UTTq9tlCZ
 AtPSHotUH8Rde+5Il4JfdGwVOEqi3Rh8H6s9LGCtWORXgzNSiWFkaZMwBSR9i1++6QpSrCBeFCq
 3McyOrzAMM4f5aJyCmypaQQY8zcSApBmkCllKdXluI3SM5Gzkl87ZQenGLs/BqirLCWVVgA1Wtr
 nDPpdDn7pX0+kHvPq6UXsbPgDzqxRWiB0tjVeXCitw2E6bBRAnKz9Dp56PXFDp8DZ3yYWLL27SS
 fUQLsjiSPtIT+lR24U/6h4HjCEMoLgU1S0ydYIOjoDEiuB6siAbhvtyfNposIf4sq+qYsRgfWSJ
 4P924N8NDnVE0at1lRtyo6UKpnCrmE9aWe
X-Google-Smtp-Source: AGHT+IGDXcu2rXaYf088S0s5/SDu9Cf2kgWGnkugds6Z0E40Y/sQzyHqYGd7lbYq4iS2oi2fq9qvDg==
X-Received: by 2002:a05:600c:3e86:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-471178a3a94mr25753985e9.10.1760700845944; 
 Fri, 17 Oct 2025 04:34:05 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444c8adsm80395435e9.13.2025.10.17.04.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:34:05 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 8/8] tests/qtest/ds1338-test: Reuse from_bcd()
Date: Fri, 17 Oct 2025 13:33:38 +0200
Message-ID: <20251017113338.7953-9-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017113338.7953-1-shentey@gmail.com>
References: <20251017113338.7953-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


