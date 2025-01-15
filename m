Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8173EC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qt-0008Oy-BD; Wed, 15 Jan 2025 13:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qA-0007H9-RU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7q9-0006mk-6y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91AZqunFcitL0HyZ4NOaEanpB7Q6GWIn9e4SYbBrSGc=;
 b=EjMV2t62NCajxpNMjdNp3YC9/1z4gyNUgcQEn2yltKV0tW/XuybIEX5lxhBTQNlEvrlQSk
 Z9vv1Un1OZ21AUUCW9EjgbcSgkSGbAFL2zTdthPdtT4gG0Uj48+ai8sz2qIti5NVKpztUk
 jd9Rw09LWXTy+r/qx9Hl3Jjq7RV/IA4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541---hhx54mNXuAbqWZnj7TTA-1; Wed, 15 Jan 2025 13:10:01 -0500
X-MC-Unique: --hhx54mNXuAbqWZnj7TTA-1
X-Mimecast-MFC-AGG-ID: --hhx54mNXuAbqWZnj7TTA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so37607315e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964600; x=1737569400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91AZqunFcitL0HyZ4NOaEanpB7Q6GWIn9e4SYbBrSGc=;
 b=byZeUsUB/pXXn11BMD2G2v+SjKhoP7Myeol6yK+5hpLmoGatk4SfO7o52SAQcrqPn3
 dUd3srSLOZzDzkNvaKHBj+WDxg0nPlpxpacuaJg0fUKGgoO8/K/TeaGpsvIEGP7a8dn3
 xizNuO8GjIuXv5Amv3r0UsuD+C6iZZPc4NAPz3ZvxE3q4XtOd9CS+IYDVmn/Z3bm21yS
 giFRbVkQgeq4Y+feOQ2/AueCjen3KOiDIo22opX70gPYQi60T81Hdiqu+qtTDHUNoUxh
 MHCSfcH0/PGsj/ZPRP06fFsyb6mFXfOMqwu3vHaS1sV8S94XJV5MjGKNoiZPXxEReFMf
 iLug==
X-Gm-Message-State: AOJu0YwQK1HXQeDpnXmabwjhmZyrdt0B31wc+WaP+BWlyobOwaaVwm3Y
 A6s6BTeto2+5+wROZFhoCBQRJ1D51/RphyuBG2aHX9Lwm9uTUCFF5Fhvj8b1hvzWWaqr8cG36P1
 ePHFEnZNv1Q9Qi6ZWawZU4B3zgSl9hNOfZYJZgL0RBPL+JAbFMfPCHPTWJzxNJWH+bcsYfUSyKw
 Uno2Y+B5Z6JW0Yy8yRHvx3TGZ1QMs1JQ==
X-Gm-Gg: ASbGncvTDLT5P4n0IIqeJFIFLbchfbM4Rdc4zWMuzSnx62jGaXLsigMOchEVd6nXVF0
 jHoEItMYgdZNtZsCxOec9kYKxV7hTnL2kYsoUgg6bOQW3fEX8jj4C+0XCFdyEJzuLNbjj4o8OUE
 2D3wWxtXer/Hf3ZeiDjxL0jJ4BChmhjOwl6MBEPb/qJTxY0sokCesABuTSPoO0lNloofuHu2H9n
 aZijbxdCfu4zUJuES1xt2XnV6uBudF9VG+F1xcJpamZOYjfeBRj
X-Received: by 2002:a05:600c:3584:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-436e26f47efmr207490055e9.23.1736964600131; 
 Wed, 15 Jan 2025 10:10:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoGFA4Tyll3sPlAq1Wj82NYZdXY4cmoGKcFXza8W813pfVn/Vn5aGlgczMg/8babH6tmJklw==
X-Received: by 2002:a05:600c:3584:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-436e26f47efmr207489775e9.23.1736964599689; 
 Wed, 15 Jan 2025 10:09:59 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d472sm17923756f8f.1.2025.01.15.10.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:58 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 28/48] acpi/ghes: simplify acpi_ghes_record_errors() code
Message-ID: <872b69f21fe34f133982e02d04e33425d761d33b.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reduce the ident of the function and prepares it for
the next changes.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <19af4188535217213486d169e0501e592bc78a95.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 56 ++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index dc217694de..e66f3be150 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -402,40 +402,42 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (physical_address) {
+    if (!physical_address) {
+        return -1;
+    }
 
-        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
+    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
+        start_addr += source_id * sizeof(uint64_t);
+    }
 
-        cpu_physical_memory_read(start_addr, &error_block_addr,
-                                 sizeof(error_block_addr));
+    cpu_physical_memory_read(start_addr, &error_block_addr,
+                             sizeof(error_block_addr));
 
-        error_block_addr = le64_to_cpu(error_block_addr);
+    error_block_addr = le64_to_cpu(error_block_addr);
 
-        read_ack_register_addr = start_addr +
-            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+    read_ack_register_addr = start_addr +
+                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
 
-        cpu_physical_memory_read(read_ack_register_addr,
-                                 &read_ack_register, sizeof(read_ack_register));
+    cpu_physical_memory_read(read_ack_register_addr,
+                             &read_ack_register, sizeof(read_ack_register));
 
-        /* zero means OSPM does not acknowledge the error */
-        if (!read_ack_register) {
-            error_report("OSPM does not acknowledge previous error,"
-                " so can not record CPER for current error anymore");
-        } else if (error_block_addr) {
-            read_ack_register = cpu_to_le64(0);
-            /*
-             * Clear the Read Ack Register, OSPM will write it to 1 when
-             * it acknowledges this error.
-             */
-            cpu_physical_memory_write(read_ack_register_addr,
-                &read_ack_register, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("OSPM does not acknowledge previous error,"
+                     " so can not record CPER for current error anymore");
+    } else if (error_block_addr) {
+        read_ack_register = cpu_to_le64(0);
+        /*
+         * Clear the Read Ack Register, OSPM will write it to 1 when
+         * it acknowledges this error.
+         */
+        cpu_physical_memory_write(read_ack_register_addr,
+                                  &read_ack_register, sizeof(uint64_t));
 
-            ret = acpi_ghes_record_mem_error(error_block_addr,
-                                             physical_address);
-        } else
-            error_report("can not find Generic Error Status Block");
+        ret = acpi_ghes_record_mem_error(error_block_addr,
+                                         physical_address);
+    } else {
+        error_report("can not find Generic Error Status Block");
     }
 
     return ret;
-- 
MST


