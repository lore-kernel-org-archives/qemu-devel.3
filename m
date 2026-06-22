Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CABCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcgC-0002cd-1N; Mon, 22 Jun 2026 07:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wbcg5-0002bv-2U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:18:57 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wbcg3-0000AT-6G
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:18:56 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE3213F29B
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782127131;
 bh=BUdhaKvf5DEBkvneugNQbuoIDY1mj1OKv54YuTKP+Xs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=JbSfYEkukUhqI8Yq5KWBm5op8CrT5n/EHV9BHkvR4Inm4jo6/0U4aVkNIPs9AqKcS
 L6HB3mMQr1mIZg+TUHrdUo/g+UdW7AZProZlHOv61A5i/xVmBkyhb+0z1HFj1DXUMO
 niYowaFzxNeUIWuJIJ/GW/sjqkfeJvN+cmEMmVOD/UXpXdnAWoYxJ4LJyLNWNEgYV5
 VE/5nSeZIZJ0MmZjIRFYB3bqm5ej1Op161rxEtKqPsKwPSyNarbVzYiiiJ0Bz9z+AT
 tyxzKWbzjvBoYldEKTPBK0OLrALditnznfUiBfml/6R0aulPMr6ijTuCB4j7bFf82O
 /BcnolUy4AQyDg/QPg2SY1x57B/4wFCq4qG7GS+46bEh5CVy3lmzfi3UFs4QgaD44J
 JPit5la+i84MH3dzPjOxKDfFM6iC/kb6O2i3/v8oHR2ss9B8+HX2ZEEqlRK299CZdR
 l3vQ3Q1FkC0pqwmcu3vm592hBq/XsCEdAsmQ2mp11pMbpqB2WyO0PXmW0xYoifg3li
 JQfWK+ws4homFyvOMiLeoeyNJsI6pRyHaYlEIYDc0ai3h94SUKo/ZSZhXhSgLzAgaM
 L2a2+h5mfI57j3s9t+ZDno+kChyy2NO8hYQ9yRVUbBgkOq2DW8ppAmpvnqMxCBj7BA
 oQ38ZjBKpFHZcZWS8qA3SRbA=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b37e1f47so28048955e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 04:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782127131; x=1782731931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUdhaKvf5DEBkvneugNQbuoIDY1mj1OKv54YuTKP+Xs=;
 b=GhyqBJ97DqnG0y8nqFb3rzKhOAaUTsdU9mSU7vh476qG5Qv7DkUN7Ynyja2nB8nGYi
 5Y5alrX98IQX5cTP/hzjJkX8XpcudzLnuOApgbRv/+JTxvHJU3GdJw40z/rfm2GAbDx2
 oDBLtOjKhs0oDG9iaBygmt4gTN6UoAwH3MA3CN+2zmIB2KpLUrcn958APDN8LaNY1lGI
 XPxTNCQBAQ81i88dNulN2fetSYGBMLwFAhA+ZWg78r020MaA8Jn/mDlOqfPrNyd8cxVm
 QgPgYi2dNpHc0XrY90wSqq6S0gyzHrucJe3RIifPT3PXqFJysLlgD6TKAHUTBUI/7Hgx
 YtRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LGj5zM1AXGWtznMIdMfKsTkVj5zd7XnYfyKBYR9ldFvwJQC+lh/vjsua8o2rFOAiPGzgGCrsey/TS@nongnu.org
X-Gm-Message-State: AOJu0YzjuDDDwFdcd8ulJk6eFc82SBjWKvqgCFNGoUqycWj5NOc3wE62
 QY3mHNpOSMkPqHNKu/6bUVLP8YfxIMva/DNFkg1cimwCpK/EFhSvgVKkPieI1uQiCmQPGr14DUU
 JJ2dSPsOt9JBigE43rPNMCXaXZ7M0m2pi36Frhfklf0VgpWA+wJ4jB91nFxAH1mAh0+gcoZrB
X-Gm-Gg: AfdE7ckI/N969rHnYaqAI0JlPQYL4+D0ckFmrkEeWyPUZC0b7AfPOJPq9oCzPLZ5wBV
 HZZlqWfc3zYdcRrb/Vcwur4IOTxiKrAXiHZf2K3nLRqLx7fF+my8nGgKo2EYdZlNnDkS+WFOwPH
 lPk4pquTdPU72fT1zK9PTsE5xCsX8BOT2Oyp4WlvcuMB3eEc5/EJripnGIhd7zE1GkAiEFpzbqB
 XDvPK4YHtWSCc1rM78NMXSeQmsix35xUheFtf/VESAGgk3oFqNBP6tdFGZgtmkZ/n8uzvJ05Iht
 92rEqVQMfrvk4pKOSLmyp028aj0z3gTJwnHzUz7Vvw9Eeo0fYlTAyArFJKyrUCTIFyHVzpJp7JB
 uxpu0wIjz9AQL4ObghzRNPS25OmxahnHe9z62a7R+U7QgfqPHTCG6wEED8FC5oGAzOQ==
X-Received: by 2002:a05:600c:628f:b0:490:9804:afdc with SMTP id
 5b1f17b1804b1-4923f56c067mr230128095e9.23.1782127131159; 
 Mon, 22 Jun 2026 04:18:51 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:490:9804:afdc with SMTP id
 5b1f17b1804b1-4923f56c067mr230127625e9.23.1782127130690; 
 Mon, 22 Jun 2026 04:18:50 -0700 (PDT)
Received: from workstation5 ([2a02:3035:605:b91c:8708:9b24:1b42:7a43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm313672525e9.14.2026.06.22.04.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:18:50 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 1/2] hw/acpi: correct field sequence in SPCR table
Date: Mon, 22 Jun 2026 13:18:42 +0200
Message-ID: <20260622111843.34056-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
References: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On LoongArch and RISC-V invalid SPCR tables are created:

    Terminal Type : 00
    Language : 03

The correct values are:

    Terminal Type : 03
    Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	Reproduce the test data changes using rebuild-expected-aml.sh
	creating the same diff as v3 but in two separate patches.
v3:
	Update test data
v2:
	Mention the different specification versions used by our code
	https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
v1:
	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
---
 hw/acpi/aml-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 9b3cdd3781..990abc64cd 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->stop_bits, 1);
     /* Flow Control */
     build_append_int_noprefix(table_data, f->flow_control, 1);
-    /* Language */
-    build_append_int_noprefix(table_data, f->language, 1);
     /* Terminal Type */
     build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
     /* PCI Device ID  */
     build_append_int_noprefix(table_data, f->pci_device_id, 2);
     /* PCI Vendor ID */
-- 
2.53.0


