Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51B9CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZJ-0007Xt-PP; Sun, 19 Oct 2025 17:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZG-0007Vz-Nc
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZD-000240-1d
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:53 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b457d93c155so542181066b.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907827; x=1761512627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQnslZlvL/ycghWXR/jv6T9Aq0fKGJTc5vHN36t+VJw=;
 b=LpY0szDXKHb2hGm8477/xrqtA7rDzKAFs4rNIwDeFuWjyrx+k+zxTnAKVhCU3RWxpb
 lGeAOZIA58LiORMaiSbfDp+6/QlOTjbgFw61oIvuq4zHMfkhF3Ue6ST4mD+VPFzRGwDk
 MFRWd4lYmjnQP0GmP94+cMKB1EZ63ycgnjURQ2kPcHJHq9L4BDmU/3WCtUKPbNHfdi8m
 dFYCY3iWslhUXXpz4l1LqWXL7rzih/H7hD5iZVVSO2yvw2IWQusFT9tRmu39KE6V4Pdl
 0+pqqRnPVUUGP1un3UL2Q2A58M//qrAuv8OlK/PvHOOLysuHyiQOBX+BqqnP9VSkknrQ
 Jcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907827; x=1761512627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQnslZlvL/ycghWXR/jv6T9Aq0fKGJTc5vHN36t+VJw=;
 b=VGGjfy2Q+UamSTcbFRexKbwKDYge/4Ei7OIW1a+tWumtZgjZLrEExNRgu+BL53rHMO
 5mJSOvRCN1KPUtdGXrvcRRT53ErWGlsaPaIpS1qY6Yi23CLiAZKPU6sWoTd0/cD4Ghok
 eQfyoebF/SfjKNjko59i+fRRxMs3DGFznG4jBZ3bzx6r5r8Z5/auc4lAyJvzcb+FhNYG
 k8llIzLcDEIZDV3s9AOWrGgC02bCA3NN7jieSrR7Dudury9EZ1xwAIRxx7RSn7liEeRt
 p6VxH1Zt2RWJ4GI/CTZwEFK4S3MkmScYXc92nQjO3Ga4aKlGV62ViHLCZdEG/n4punUH
 QZ4w==
X-Gm-Message-State: AOJu0Yy8JHmJrpZkiaEHCVHSfgUamom98m3rszImfpq096CdvnSE1lxB
 aREf7UpGtTemv6PqstSDL54BrYj3O8fsDKWDXQnfwDvMIQtDfYkwV+qscQmXehSX
X-Gm-Gg: ASbGncsYi+cjyIf2sAUSAaCmdtIX6sxkx93UUbeHW3w8PPqm72Ay9fMuFRorXMDCj+4
 pPYPxYHVNZDp1Jn1W6fOk2elk8X9YM0QgYqbFSd+4k0GXGqTh/nrMD+SlJ3frP9nVsyG2rhAn2O
 wAAx0WzGS/DBZYOENAT/V1+0CYFQiny/w903nM4eyYLEelXKETCkkVH/2648IzChZzql9HQkDhw
 j21Y/lmXae8yn4Kq4Y/y2VnOGoRmSPn98P7zA/xFXyxI8TEJn8EqpYRm9lKEG0QF1J3JpmQE8Mm
 BXN10sIzOLQvs79W6pl7XNMZPhzVPOrySnKgTdxtSlWD8kpquTrus/A5h1CdhevqG6tj2b3Gj2e
 o4USl5D3BV2VGsMXVWgpK5XX5ESHHw/3vfjjmtL879moO7tEvObRr0d2HxFxcfWeUFBeRqXblF5
 pcPEQiYr/GWxN+2eyOPG8fP1qR7E5dWeVvKph86yUkEtUKHPoHON75GNwFs7+K4Q1kvOiU
X-Google-Smtp-Source: AGHT+IFxPtXo9vzXd3rOAqwwxaNDvJIFsK7Eo1zA6M2lE6v+t/sNoVY4Repet5YBzuRnemWgklColw==
X-Received: by 2002:a17:907:c06:b0:b3c:bd91:28a4 with SMTP id
 a640c23a62f3a-b6473045139mr1262880766b.28.1760907826411; 
 Sun, 19 Oct 2025 14:03:46 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 10/10] tests/qtest/ds1338-test: Reuse from_bcd()
Date: Sun, 19 Oct 2025 23:03:03 +0200
Message-ID: <20251019210303.104718-11-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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


