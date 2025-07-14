Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7648C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHj-0007qj-Nt; Mon, 14 Jul 2025 19:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGl-0004Kk-1o
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGi-0005Y8-VA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=43SwpP7LqsZkv1SwArkQUMqFNNuviE/llERHShW6waE=;
 b=b265TZqB1ACVlp7nOT2LJ9sFZqx/ip+8Tvn/znt0SFILNBYLAdA+QEASeFttpi2AmIuCRV
 8SDltoGlwDBTfyhMc/TX+EvOA3yUMjlNTwKyYajWb8wBHdJ16aS9pbiVoNq6mGf10euyDr
 3n6sfn+p1phY3Vy4aGSbDNzKZNOv9/4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Z384lALhMI-k8kxxxXuMAg-1; Mon, 14 Jul 2025 19:07:26 -0400
X-MC-Unique: Z384lALhMI-k8kxxxXuMAg-1
X-Mimecast-MFC-AGG-ID: Z384lALhMI-k8kxxxXuMAg_1752534445
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so2163206f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534445; x=1753139245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43SwpP7LqsZkv1SwArkQUMqFNNuviE/llERHShW6waE=;
 b=bgGIqTc6iXB3ZZPym7lOP4JcrwtoyRu9gBP3RgKs0iTL25O/1FXb0JjNcMW7HvmiLz
 m4jejz0rEis9CJ2YY6U7Daq+0DR4a/W+MDEgu+vvX28wgi+qE+fSve6GfXFlYBarm7dc
 xqkp0xLKL43/JpwpsHYqU8a0n64YIuKaDg/EIFxt9faTa8d1sbFqz3NWgeytblddUuvX
 AQHeXvnPhOVpJOOJDxgYyVe4DHjxlIH89Sy95BRqfLWegqROh6gmxAtKR/5NLBG0znVi
 wAJJ6eEznDzFA/TeWlfwY/aoQxK3O3skHtJ+BRRZ73ghP0tqRNUAltolqioHb0Nh/hlZ
 4XjQ==
X-Gm-Message-State: AOJu0YxKHYNsIfq8lL6LXEsDywRnW94pPYZKqeSk/iyrNaZ1SbrUa/SS
 aoAae3ie1FWVUd0fUbBq8Exl5eHSB7Ln0sFA4SCnNrGqwNCxn6Tq1l9Q2YDrYAECsLaR26G3VEc
 xiaEXZ2J0I9nsV5YBmtcv6DbT9y/DAzGCIDV9S+Teb04+NWaKU834GvUqhSPWoOX+JuDF3FJ26b
 fmBDqjR893+mb7hGpr108ZRquUvFm8DhJbtQ==
X-Gm-Gg: ASbGnct7aN01vpgLmDox2ivZ34Ce315vRwXKxRrFNFfl+mfCRDq/Anwd5cqanKUj23B
 hdV2lCx2cWK2L2PNn5fEim9zZm9giXdCW3Pw8Fqj/4u9NzsujsPA6hoq52RXlW/UcqCcNJ8qyID
 kkFtTFvUBVOopvqaf8Y/MOxE7Ou0VhTcn4K57WaUYHcsspbAxAv2l3rRQoHgLtKZBPXkqlR0jJF
 HYBsizSZoMJE7doRWptINAkXx6d5/R4KYR7gXm3vWkT+YfHrNDuk3GiaqtEme8HL+KlaaF8PjIm
 ecDQLnJL/bNrz/ICttBfoXLH1J7tWDCg
X-Received: by 2002:a05:6000:1e4a:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3b60a1939d6mr209003f8f.31.1752534444775; 
 Mon, 14 Jul 2025 16:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHte4/xKkHSzr4bDOZy+jXaQY01TTvojzmgDFgYCUcR/L17XN84XuxQjauI9NUrp17Fcx0H9w==
X-Received: by 2002:a05:6000:1e4a:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3b60a1939d6mr208989f8f.31.1752534444363; 
 Mon, 14 Jul 2025 16:07:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1f4edsm13340584f8f.83.2025.07.14.16.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:23 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Chen <chenl311@chinatelecom.cn>, Sunil V L <sunilvl@ventanamicro.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 27/97] tests/qtest/bios-tables-test: Add test for disabling
 SPCR on RISC-V
Message-ID: <da77fc6c2e28a17249a6f459213247720e22e170.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Li Chen <chenl311@chinatelecom.cn>

Add ACPI SPCR table test case for RISC-V when SPCR was off.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Message-Id: <20250528105404.457729-4-me@linux.beauty>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c84cf1070d..e988deac02 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1807,6 +1807,26 @@ static void test_acpi_aarch64_virt_tcg_acpi_spcr(void)
                   " -machine spcr=off", &data);
     free_test_data(&data);
 }
+
+static void test_acpi_riscv64_virt_tcg_acpi_spcr(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+        .variant = ".acpispcr",
+    };
+
+    test_acpi_one("-cpu rva22s64 "
+                  "-machine spcr=off", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
 {
     test_data data = {};
@@ -2701,6 +2721,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_riscv64_virt_tcg_numamem);
+            qtest_add_func("acpi/virt/acpispcr",
+                           test_acpi_riscv64_virt_tcg_acpi_spcr);
         }
     } else if (strcmp(arch, "loongarch64") == 0) {
         if (has_tcg) {
-- 
MST


