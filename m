Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93D2C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucoVJ-0005Zu-Oc; Fri, 18 Jul 2025 13:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt5-0007hS-Sg; Fri, 18 Jul 2025 12:24:43 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt2-00072R-MM; Fri, 18 Jul 2025 12:24:43 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5561c20e2d5so2972472e87.0; 
 Fri, 18 Jul 2025 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752855875; x=1753460675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8kJDLuC+UaKMIjK/HRmpSPdwsiOoh88VgdFCc0iMko=;
 b=iB+PD8GRkYhqXb9O2eXg+CEVokL4xtijvGdeAoqI9JCb507DKQTJ4k1OaTk5FqYgUJ
 P562DY+PKN5idvjTMVcmnZ4AW0oOC9R2fxG1q49QPpTaLmP2ShbPGaHuwF/mHiWY/yZM
 xVOInucAMqZWdB0nFUN5xostgRwSafT8rOrZwn76w8S42FagoOLmQPR1ABHS8KfGvHMI
 rvGHHBsHNwq2miFhOF3cXLvy+RlyUSkoHtRnsCYrKOyu8pciuweVhl9QMWavbUYhOyOh
 ZRBdyOi/lrvr9lj84GeiNtD9SOhK0rLj4goUIZ2cqT5oj8ifX9DA549IuOgrWtUbs4nI
 srtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752855875; x=1753460675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8kJDLuC+UaKMIjK/HRmpSPdwsiOoh88VgdFCc0iMko=;
 b=wtItX+xOEhBUBxS5M/mUct4ItGk1OXwJueWS+0pfmE0VJjstfxoFJOpVIt/oLmvdCt
 5kCne6B3RViJNm6pW/oUk8K51hfacM3evoFyEZUfQRjcBPxHAUUN15JPKAoa5J7pV8o6
 uVvstm3mRZiSI1IxPOCXGn8cIUn7kYOiJXr6yMKZF5r87G7qSZx6yLYKtOsI7Vt285Mr
 q+StqEZVSdGJOU/+tG9m76TthiUGkjJtQx+o3SpcvjCWv4yl8yPSfbXiHjJ6Jdx2gzwQ
 KvgcLqQEZLkJ713a3HByC2n/ZHN5rsqtcqjcZIGGpmEQ/YlWHn4fCbFQdtErv6l5Dt59
 0pWg==
X-Gm-Message-State: AOJu0YzRX7Od/5EcyX83/lOt0uOT+lFN/hIqFpYexutSJY8yH/hQTNsu
 VTaJ4SFiMP+6zMFh5krF1vjXKPkHYxREMB5ZuggANyVXQbnIpbnY6FYUrAScKMQZmI2Hkw==
X-Gm-Gg: ASbGncshR6U4nz1Pp4AB/BkkU2D3htg5VPAdf2gedOmw9IxAQMJO8rp0IEdw8GPjrzM
 bGICVEM94h21kvu0yJBqo9er/42S/NOq0aQbAxZQ5FaOLvCMU3Brb5ZI3/5clTLCLMZ6aYh3LE3
 AZxFtEN6+JFFX9Esnf+e2ElBxWMlCeJg0Mp0GeCe1Kr5oy9R5fgBTZPlb3jtM7HGFUWBAy+wkQo
 BCIv8kXA1S0Fd0C5d7jzIZqOw1R+hZrRPy1HtA7MbYER/evGPGh8bvbZoPGmxMqevSf6k98d2Uu
 0hiS35F4hbvN5H96QGzl3uhgh11kSlG5fTJIrWM624cfBnCi02Y3fnA0iYtSeJUx4uAdJWqXVbU
 LuBaJO8p6OCe0QwmOQonJ7NHrypaFnRvJ9SZ1JXT4Fy5OdvzRlYObcdBP7yHJ3wHA5rPZh0Irq8
 Zhw24iKlAbhzm5Ww==
X-Google-Smtp-Source: AGHT+IENXYP1k/2GxplmkUb0rUBIwCEFpwx/rq0d8RZS6SPEvHiRAopRfMQ9+dhcX67N0jNSPLj0xQ==
X-Received: by 2002:ac2:42cf:0:b0:553:d7f1:6297 with SMTP id
 2adb3069b0e04-55a3188e89bmr747653e87.34.1752855874422; 
 Fri, 18 Jul 2025 09:24:34 -0700 (PDT)
Received: from localhost.localdomain (m91-129-102-83.cust.tele2.ee.
 [91.129.102.83]) by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-55a31dacd84sm310615e87.206.2025.07.18.09.24.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Jul 2025 09:24:34 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/4] hw: acpi: add support for SPCR revision 3
Date: Fri, 18 Jul 2025 19:20:42 +0300
Message-Id: <20250718162045.49012-2-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718162045.49012-1-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lf1-x12b.google.com
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

The UART clock frequency field of the SPCR table was added in revision 3.
Currently, build_spcr() treats revision 3 tables the same as revision 2 and
only includes this field in revision 4 tables.

Fix build_spcr() to include the clock frequency field in revision 3 tables.
Per the specification, this is the only change between revisions 2 and 3.

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 hw/acpi/aml-build.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e685f982f..9855d5f053 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2123,20 +2123,22 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->pci_flags, 4);
     /* PCI Segment */
     build_append_int_noprefix(table_data, f->pci_segment, 1);
-    if (rev < 4) {
+    if (rev < 3) {
         /* Reserved */
         build_append_int_noprefix(table_data, 0, 4);
     } else {
         /* UartClkFreq */
         build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
-        /* PreciseBaudrate */
-        build_append_int_noprefix(table_data, f->precise_baudrate, 4);
-        /* NameSpaceStringLength */
-        build_append_int_noprefix(table_data, f->namespace_string_length, 2);
-        /* NameSpaceStringOffset */
-        build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
-        /* NamespaceString[] */
-        g_array_append_vals(table_data, name, f->namespace_string_length);
+        if (rev >= 4) {
+            /* PreciseBaudrate */
+            build_append_int_noprefix(table_data, f->precise_baudrate, 4);
+            /* NameSpaceStringLength */
+            build_append_int_noprefix(table_data, f->namespace_string_length, 2);
+            /* NameSpaceStringOffset */
+            build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
+            /* NamespaceString[] */
+            g_array_append_vals(table_data, name, f->namespace_string_length);
+        }
     }
     acpi_table_end(linker, &table);
 }
-- 
2.39.5 (Apple Git-154)


