Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6118EC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNNb-0000j3-5F; Mon, 31 Mar 2025 18:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNZ-0000hQ-3R
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:13:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNX-000782-9K
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:13:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso33117215e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459189; x=1744063989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOLUfD1F1xE/t9Kpw+vUCexBlPtvjXU3F4WVgeXz17k=;
 b=DRRtsb4UZqCZEyliBcoFJyQq+sV2ddUGZbvubLy6XeKcYuoB5dZEGrHhROfJmSVMg5
 Ww9tBc7CdPVCs/aRHTE+NmTauaViQ65NJGSQ+XT97BqcewNmkxMdigisVMu+j3Qqaexc
 jEykcs4+xdmEkT75d932/gKpLBTHFeX53KMwFfe+QSxW6slkmWVHBktCw05RViTGrTc9
 R2YhnjNg/FbStfoAyeqm4bl0B7GJ0yL/SCk1gGWdLV5QBwPmwFu7P9xDLyCUoCNyzXBE
 RfXiKoK9s80ZUyj+IG+L18z0RGDBrXcLmjiTc5NTu2Xt7l5lqe3CyMyS39k9Q5Nz6mDR
 Bsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459189; x=1744063989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOLUfD1F1xE/t9Kpw+vUCexBlPtvjXU3F4WVgeXz17k=;
 b=VrcOsSo1vMOW8yxrYd7A6s8M213CbC09oFgGWVAqd9Nl17T2HeXvhKcY5rblDgGUNM
 75cCua3dWfNfYL5lBKUVuV163X3s8CXsg1GqrJ3Ih++nZfFVlHK9DNx6oaF2zJzJzVOL
 +Tyy8Rox3+KlhId/ob9JtrYYDfcX9ApXiRu2br2vzOAwCfyMFqDzXfqYCZ+IrzmyUbaU
 KJpYEOxhJab9FDuSC8o4NyA7TLM6tSBEMkWh5oXo/nHyKCGGWF+4evj9G7NwvfdYzwW0
 mDdCyDdpt15xI/YYV6V/Qew9j/hxb+niHWdkzQRtXgj3SSRwTdGHzNRR/+uuPdfZshb/
 ZBXw==
X-Gm-Message-State: AOJu0Yw28v7MxmGSauPdGurIWFc1QYZyqFfgYKebyCXpFBDORWuXEeFY
 QvCIcRHnHOHXfR3sroA1e8vQX1hhY6slX7zmfC1ZnlWsGTLbnqu2Fd+CX6hJnoRVcbgrKvLh4mp
 x
X-Gm-Gg: ASbGncuI3jfHTw8aclCZ9c2WqQ8+RYgYX5d500sUDDn/rz7kKM2AL7jLRCkQpCq/XEU
 QMlvXvfEwMOh8A+eLIzqApk1OfdJ8Q5zqT1/vlwBQLMONAjfwLen32JQYY0WonXLri/fSavOBnB
 R8gODpzb8RcW5/TWVVdekHyY17ut725QQwXIxJA2obt57C5W6oXeqNdER/wXKmiiLqOmmcO8q9N
 EG6T3RoyURQu99Kh0aryLC86nP0YDL9frbPXxdbn4ka3fjpq9P45bA/cCnnxZsscrW89JctNrcd
 cABPAw5knYM4gbWRhnZ5aTo5SXOVu0nAFNMQRR51mhLbA6fX4HfT9g2rc+zNjSGMf7PK4+Hsuww
 GlTX4QypyWpMPfu55Fno=
X-Google-Smtp-Source: AGHT+IHzDg7FfFOhx7o+pOCX/cTjM+fnzVAvlGQW0i3mMlD5ipQ3sNQmtpWe6IM4Zu4HyHE87YqhDw==
X-Received: by 2002:a05:6000:2ae:b0:391:2e6a:30de with SMTP id
 ffacd0b85a97d-39c120db4b2mr8556010f8f.19.1743459189344; 
 Mon, 31 Mar 2025 15:13:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a8e0asm12267209f8f.101.2025.03.31.15.13.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 15:13:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 5/5] qtest/bios-tables-test: Update
 aarch64/virt/APIC.its_off blob
Date: Tue,  1 Apr 2025 00:12:39 +0200
Message-ID: <20250331221239.87150-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331221239.87150-1-philmd@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Changes in the tables:

  @@ -1,32 +1,32 @@
   /*
    * Intel ACPI Component Architecture
    * AML/ASL+ Disassembler version 20240927 (64-bit version)
    * Copyright (c) 2000 - 2023 Intel Corporation
    *
    * Disassembly of tests/data/acpi/aarch64/virt/APIC.its_off
    *
    * ACPI Data Table [APIC]
    *
    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
    */

   [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
  -[004h 0004 004h]                Table Length : 000000B8
  +[004h 0004 004h]                Table Length : 000000A4
   [008h 0008 001h]                    Revision : 04
  -[009h 0009 001h]                    Checksum : A7
  +[009h 0009 001h]                    Checksum : EE
   [00Ah 0010 006h]                      Oem ID : "BOCHS "
   [010h 0016 008h]                Oem Table ID : "BXPC    "
   [018h 0024 004h]                Oem Revision : 00000001
   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
   [020h 0032 004h]       Asl Compiler Revision : 00000001

   [024h 0036 004h]          Local Apic Address : 00000000
   [028h 0040 004h]       Flags (decoded below) : 00000000
                            PC-AT Compatibility : 0

   [02Ch 0044 001h]               Subtable Type : 0C [Generic Interrupt Distributor]
   [02Dh 0045 001h]                      Length : 18
   [02Eh 0046 002h]                    Reserved : 0000
   [030h 0048 004h]       Local GIC Hardware ID : 00000000
   [034h 0052 008h]                Base Address : 0000000008000000
   [03Ch 0060 004h]              Interrupt Base : 00000000
  @@ -49,37 +49,29 @@
   [06Ch 0108 008h]    Virtual GIC Base Address : 0000000000000000
   [074h 0116 008h] Hypervisor GIC Base Address : 0000000000000000
   [07Ch 0124 004h]       Virtual GIC Interrupt : 00000019
   [080h 0128 008h]  Redistributor Base Address : 0000000000000000
   [088h 0136 008h]                   ARM MPIDR : 0000000000000000
   [090h 0144 001h]            Efficiency Class : 00
   [091h 0145 001h]                    Reserved : 00
   [092h 0146 002h]      SPE Overflow Interrupt : 0000
   [094h 0148 002h]              TRBE Interrupt : 100E

   [094h 0148 001h]               Subtable Type : 0E [Generic Interrupt Redistributor]
   [095h 0149 001h]                      Length : 10
   [097h 0151 002h]                    Reserved : 0000
   [098h 0152 008h]                Base Address : 00000000080A0000
   [0A0h 0160 004h]                      Length : 00F60000

  -[0A4h 0164 001h]               Subtable Type : 0F [Generic Interrupt Translator]
  -[0A5h 0165 001h]                      Length : 14
  -[0A7h 0167 002h]                    Reserved : 0000
  -[0A8h 0168 004h]              Translation ID : 00000000
  -[0ACh 0172 008h]                Base Address : 0000000008080000
  -[0B4h 0180 004h]                    Reserved : 00000000
  +Raw Table Data: Length 164 (0xA4)

  -Raw Table Data: Length 184 (0xB8)
  -
  -    0000: 41 50 49 43 B8 00 00 00 04 A7 42 4F 43 48 53 20  // APIC......BOCHS
  +    0000: 41 50 49 43 A4 00 00 00 04 EE 42 4F 43 48 53 20  // APIC......BOCHS
       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
       0020: 01 00 00 00 00 00 00 00 00 00 00 00 0C 18 00 00  // ................
       0030: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00  // ................
       0040: 04 00 00 00 0B 50 00 00 00 00 00 00 00 00 00 00  // .....P..........
       0050: 01 00 00 00 00 00 00 00 17 00 00 00 00 00 00 00  // ................
       0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0070: 00 00 00 00 00 00 00 00 00 00 00 00 19 00 00 00  // ................
       0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0090: 00 00 00 00 0E 10 00 00 00 00 0A 08 00 00 00 00  // ................
  -    00A0: 00 00 F6 00 0F 14 00 00 00 00 00 00 00 00 08 08  // ................
  -    00B0: 00 00 00 00 00 00 00 00                          // ........
  +    00A0: 00 00 F6 00                                      // ....

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 184 -> 164 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bfc4d601243..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/APIC.its_off",
diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index c37d05d6e05805304f10afe73eb7cb9100fcccfa..f24ac8fbff5261a52434abcfcff96dbdc7709de4 100644
GIT binary patch
delta 18
ZcmdnNxP+0*F~HM#2?GNI%e#qOvj8xy1yKM1

delta 39
jcmZ3&xPy_)F~HM#2Ll5G%kqg_vqbnsfJ`vp;DE6Jpmzmj

-- 
2.47.1


