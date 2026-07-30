Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B8C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLtg-00079Q-Am; Thu, 30 Jul 2026 04:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtc-00076G-6M
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtY-00018I-0G
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so3258144a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399214; x=1786004014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0oNDH01FbQte7UkYHPhvNcB6113WA9wPSR1l+l/ks+A=;
 b=eO8GmMuRaMnN76J0Fny3Ltjkx6jjYYUTsSbudwjDu0MqqmvMqKYf2ITtHxi8Qh/cEQ
 DJmP9UXqmenTwjeSYIUdRxf2lGemhy47zhMrGNGBrBqoOvClbcD6rZHK974nHNRL04gi
 4Wk91at2GICgurCcZBPLUQiRmWa8uYr/iS3b/lPpoYL7gSsIGltpl3SsdZNx7QsxbBEJ
 2A7jSmXKTlk0cMY2eirhLJKJJcgDjcWpiiDybpyud47bTEXRHxugq+Ss3qfJ4EQ0WkgI
 4GDawFK8/oE2IpJqDMu79PMLbxHBXf7Vp9uxWe+4LBCMckfmNVBQmTkjwZQMI2HDjikz
 au8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399214; x=1786004014;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0oNDH01FbQte7UkYHPhvNcB6113WA9wPSR1l+l/ks+A=;
 b=FzTSxXBdcazsqeFw/qI+YJejYtnOaUkfPAEs/yQGU9n129FsJwFrw0N6vS6G/YkTNU
 XJoWweeK/4wyDTuk939MDIs0v9FTF4lsPbwRHkmg3dxSJ8zI3InwtG/RY49u5m0Ki2V9
 wMNmMcfUjXoiA1/MO/qHOcMXfgVhLPV8bkJQP/vcvX+FOkLOWQfrI3qpbAOD+vgbuKDh
 m0zHj2eHXyvQjEEb3sNKuCyUJ85oSCmDiwh4EBm+9MncMP5OZYaB5gndt3R/KEChRpg8
 9pUvZz1Hlh8sVlRp5NoCYrJUdqTh/ltts0NNlJpnZLpEUOQpZHiU/q0s6tHqWjbgNee8
 jFtw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSnP/1rrgXzWcwmQEDP70HpjHOW+0+Lo5PHMT54A9foNbJ0xnYUEi1/CHeLK0pYWdqo/lxTmzbUsBC@nongnu.org
X-Gm-Message-State: AOJu0Yzg2fSN4l4dv6QtqEy430MHEh76YbT1cxAYChBVsPW7S99qd+5s
 bfXQFmGjDQPmCQUKI/NnQZddELmvWgr1OJ4j4cGz+I2Z8TMQemwLl9qW9d0kiZW0IfQ=
X-Gm-Gg: AR+sD10LXjbJ1xoLQT+B3/cAh8XaW9OGH65Bzf8zpPPujBGoeS91kwR8YySENhlxM2c
 Z53dHk8C0ewsVg8YJwENtVPpz6bL+KaNLjA6dCHfUNPFQmHIzXcwbUJ1Pu0ACnXUjRHUaZA+XAC
 5QmHfeW7aGGEqHI/HaKs4KE3318d1GFFaUAtwsN4k8fO2vXkGAjrWOX2xrKkat+7J8jFwijChYK
 lDrBNdGyDNeh5OyGC3mB0r9rnIEztSIHHvF2567iYQH2lMn24dW4384uc/KkJn0l0e2+d6NpnKm
 TdUoKUeqVmN64YF9k59bpqpfNk9/DdtTrQj5Pj6zMAAWhNQwjyayFJHMv6nrLwnFw6QyxmX93ix
 zSMbcxuFSIREHXczDX+h/Nze47VfKQhNpaFcu17l4NfoCiX4rrM3rElgkvME79AtTpiZH/L3xYh
 VcCVJawW2KbnPPSdfc2BXrv4mhxaIsAbaDRiYg9HqryB0qXze3Sw==
X-Received: by 2002:a17:907:3cc3:b0:c19:481f:8a93 with SMTP id
 a640c23a62f3a-c1fa5afa634mr76989366b.49.1785399214099; 
 Thu, 30 Jul 2026 01:13:34 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 6/8] tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
Date: Thu, 30 Jul 2026 10:13:22 +0200
Message-ID: <20260730081325.1816193-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=den@openvz.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add /ahci/cdrom/{pio,dma}/raw: read several sectors with READ CD in
raw mode (atapi_raw), so the ATAPI 2352-byte unpack path is exercised
through the AHCI delivery, which IDE coverage does not reach. Each
sector's 2048-byte payload is verified at its in-sector offset.

The PIO case uses a byte-count limit of one raw sector per DRQ burst:
libqos asserts a one-sector PIO transfer, and the multi-sector unpack
loop is already covered by the IDE raw test.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ahci-test.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 44799eea15..58bc04b3ef 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1565,6 +1565,31 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     return 0;
 }
 
+static int ahci_cb_cmp_raw(AHCIQState *ahci, AHCICommand *cmd,
+                           const AHCIOpts *opts)
+{
+    unsigned char *tx = opts->opaque;
+    unsigned char *rx;
+    unsigned i, nsectors;
+
+    if (!opts->size) {
+        return 0;
+    }
+
+    nsectors = opts->size / ATAPI_RAW_SECTOR_SIZE;
+    rx = g_malloc0(opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
+    /* Each raw sector carries its 2048-byte payload past a 16-byte header. */
+    for (i = 0; i < nsectors; i++) {
+        g_assert_cmphex(memcmp(rx + i * ATAPI_RAW_SECTOR_SIZE + 16,
+                               tx + i * ATAPI_SECTOR_SIZE,
+                               ATAPI_SECTOR_SIZE), ==, 0);
+    }
+    g_free(rx);
+
+    return 0;
+}
+
 static void ahci_test_cdrom(int nsectors, bool dma, uint8_t cmd,
                             bool override_bcl, uint16_t bcl)
 {
@@ -1625,6 +1650,47 @@ static void test_cdrom_pio_multi(void)
     ahci_test_cdrom_read10(3, false);
 }
 
+static void ahci_test_cdrom_raw(int nsectors, bool dma)
+{
+    AHCIQState *ahci;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    AHCIOpts opts = {
+        .size = (uint64_t)ATAPI_RAW_SECTOR_SIZE * nsectors,
+        .atapi = true,
+        .atapi_dma = dma,
+        .atapi_raw = true,
+        .set_bcl = true,
+        .bcl = ATAPI_RAW_SECTOR_SIZE, /* one raw sector per DRQ burst */
+        .post_cb = ahci_cb_cmp_raw,
+    };
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * (nsectors + 1);
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+    opts.opaque = tx;
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=raw "
+                                "-M q35 "
+                                "-device ide-cd,drive=drive0 ", iso);
+
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_CD, &opts);
+
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_cdrom_dma_raw(void)
+{
+    ahci_test_cdrom_raw(3, true);
+}
+
+static void test_cdrom_pio_raw(void)
+{
+    ahci_test_cdrom_raw(3, false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2100,8 +2166,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/dma/single", test_cdrom_dma);
     qtest_add_func("/ahci/cdrom/dma/multi", test_cdrom_dma_multi);
+    qtest_add_func("/ahci/cdrom/dma/raw", test_cdrom_dma_raw);
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
+    qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
-- 
2.53.0


