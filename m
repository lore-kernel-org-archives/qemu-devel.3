Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F06C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucoR9-0007oc-Os; Fri, 18 Jul 2025 12:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt7-0007kk-Ru; Fri, 18 Jul 2025 12:24:46 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt6-000783-8b; Fri, 18 Jul 2025 12:24:45 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5561ab55c4dso2321215e87.2; 
 Fri, 18 Jul 2025 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752855882; x=1753460682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBrX8kFqn3SKWgrzeGigP/iZk6FEK2hdUWJr2evgfk0=;
 b=NiBtA1QqKI6Zx57J3XDhk0dZAA77YZU/GbGWM84eUVA/qPOBOIJl11Urg/LafgKTwX
 IeeQuWqlrF/WylkCIw+Z4CBqD04WpoeBqT5BVH7y81Z+PpaGXmFIA9RcV8jzJJwKDwvO
 2fb5qm6wayfv7DyqC16+kKQx1u7IUWNw+Fy8Oc9W5238YqcYb3am/lMsnLMNHi+zSpJV
 s+k46atsf49Z34OKUKI/tSsTuD4HVVWa3J04X6jJvhneTruQt37zkS9/djUu4P3HECpp
 imWZB64+knw8PLkKalRj/AliNSpwd3DWn1JiPUW5wdbDs1d/JbzL2WD924Gvenu5moNL
 jB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752855882; x=1753460682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBrX8kFqn3SKWgrzeGigP/iZk6FEK2hdUWJr2evgfk0=;
 b=dvFbH63/e+uxYM2s/69FLkViOH3ekJsfQbRpm+HKYVu7/XKMCH01jMRqAa2st4bmES
 QM2G/jeUHLHfEjYW8gDgwPhm2TAEfI6OkcoZzj34uw3sXWoWtwcD/tcVn2sq9460s8Ah
 Fwcqu00Pb3K2Procml+dHtptOUuEEcnyh2an/NUUVehpDvyWn+9wibPu/SGhyZKLxsml
 cZn9D4v+KS6ltaBSE0MIZABwdC6sKTEK4/8ARD4SQFlMlB0Ua4ppJO4Nm+UJs5Wo/Xga
 HTA/nk3Qyjx7O669pi2YSsbquPfLtz6JbjBnqlSoNVVDucGAt7Mp9fklqcWaKHPnIaXf
 VZuw==
X-Gm-Message-State: AOJu0YyT1T+nfNVBK1dwCmCBzHJWGVIOzB3RbKSEScU7YsRi2ytqsCpc
 zY69QHv453RWEmC0mto8yTQlllMUlWfZP/wMXCh5o40eksCzpTvPyDspXCZz/30YGFJkyQ==
X-Gm-Gg: ASbGncu2NBjRtw/gsnYp2+OMSdX/A56BUx9t9gqueFrDfj0udtjSTm+Db0PhyU8MStd
 NKAyGMsJ7cEr6JWQ8SBIMMDnfWsYSocvz3z1wt/TcZRfRLYjs62zFRzw58cacxM83mswlsCtUBh
 Gxi7L4v35I/HGXNs8HNSbznV6oI/oXsmvOMmEd+b9t+S3N4km7ZiV/IneZUetAgjTHG4uNdL+rs
 kxrQ/w/uBL2fZ6hk/+37cwwvFHMcw427VjQ21ap957xbYswXKEN860JszhtGVAGlUANtInJN9hE
 VpUlo+knKQ2zr4rHwNZ5aX5HF/uKsOFzSHkZhXhFRLwga9HsP3kD3PWOzOKYIP//zNGkimIwVJw
 NvYkhJ8iCUW+ImF6/aF2HV5Cjj8iUdxzZyR8jEy7BdStduNVcrWhA1GZAQI9fF7iiAgUqoqtZ8j
 R5vUA=
X-Google-Smtp-Source: AGHT+IGlHiMksbEmRW0KxRp1iZ6W6YbmkAf69uMpLqxicNJIdMpRH+IefAPftUveOA/RA17QXw0NZQ==
X-Received: by 2002:a05:6512:238e:b0:553:24f4:8736 with SMTP id
 2adb3069b0e04-55a318a967amr897237e87.53.1752855881576; 
 Fri, 18 Jul 2025 09:24:41 -0700 (PDT)
Received: from localhost.localdomain (m91-129-102-83.cust.tele2.ee.
 [91.129.102.83]) by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-55a31dacd84sm310615e87.206.2025.07.18.09.24.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Jul 2025 09:24:41 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/4] tests: acpi: update expected blobs
Date: Fri, 18 Jul 2025 19:20:45 +0300
Message-Id: <20250718162045.49012-5-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718162045.49012-1-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lf1-x131.google.com
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

Previous patch changed the SPCR ACPI table for AArch64 virt:
@@ -15,2 +15,2 @@
-[008h 0008 001h]                    Revision : 02
-[009h 0009 001h]                    Checksum : B1
+[008h 0008 001h]                    Revision : 03
+[009h 0009 001h]                    Checksum : 0B
@@ -49 +49 @@
-[04Ch 0076 004h]                    Reserved : 00000000
+[04Ch 0076 004h]                    Reserved : 016E3600
@@ -53 +53 @@
-0000: 53 50 43 52 50 00 00 00 02 B1 42 4F 43 48 53 20  // SPCRP.....BOCHS
+0000: 53 50 43 52 50 00 00 00 03 0B 42 4F 43 48 53 20  // SPCRP.....BOCHS
@@ -57 +57 @@
-0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 36 6E 01  // .............6n.

In a revision 3 SPCR table, the "Reserved" field is the UART clock frequency
field.

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 tests/data/acpi/aarch64/virt/SPCR           | Bin 80 -> 80 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
index cf0f2b75226515097c08d2e2016a83a4f08812ba..76ac417fbdc4dc6a473c51b82164f40bc5320c58 100644
GIT binary patch
delta 20
bcmWFt;0g|K4hmpkU|{B+$mPszmd6MHD|7?L

delta 20
acmWFt;0g|K4hmpkU|`xfk;|DG$N&H@90SJy

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2a30472d57..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/SPCR",
\ No newline at end of file
-- 
2.39.5 (Apple Git-154)


