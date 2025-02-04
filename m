Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AB8C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6jO-0001NP-3Y; Mon, 03 Feb 2025 19:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6jL-00018b-8H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6jJ-00079J-JC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so58711625e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628632; x=1739233432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA2PPeT4tEXlHcRLWASfffMgNqf9rFhBVYtXHQy1PNU=;
 b=IQrZrO1QrWQfaoU5XjzGAPz4NFl9cUwXdnIIydOX2I38cPlg3857A6inzBBHKStcDC
 8j5O411HG4VWbsOO1ei2dQEMxomlewl12jWDMu3WRSXKPYkfki90YvfCitLkvikyOVlP
 O4DnkwEJHeRVHAtdUMArDSE8bCLks0p5+l3JkqTsk301ebGa84eDlnR4ox212kk2VzPT
 X7CjXp0ojGukBWANpfQmyi/UDRKn7Wb/4rvN2doT/uJt/rlpqVUoHPOUJCFMCIxHn1Af
 aSmnpO//zZqWhbzla+PZ18JT1ae/2SceacKGgJFTBFaOGeTM1Asx5K21zyd0U6NiZyPS
 z0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628632; x=1739233432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA2PPeT4tEXlHcRLWASfffMgNqf9rFhBVYtXHQy1PNU=;
 b=n0D06qWk9wWzQSgwqq9pO/HGqgJcDfJrIenqYB7uqv/gVkAVR5rOixnyPFz92y/fxv
 /y1kmt7ENod9bf4qIKcUkefqTpqWK9jGo0EjqSJxJ5NbQF6GrR8sfWkGxmNRI8zkSNmo
 67jHIJLhC5Kk9pYjFPz2e7WNOsxp49ESXhUOmEmw6aLIoP51DpqraRM3j6fU655LonRU
 Zqq0hNOia/bPEc02fdlfHwylXry3TofSm5sC2dm9CitVaPLrNbeTqNj0lwBabf7T6CxA
 Oij9qQ3o7MKylkDklwFjo3W9FJ0rJ9TBjEooIBFXW3U7PPEYTriqO2lHvrncssWp42+5
 oKgQ==
X-Gm-Message-State: AOJu0YyhJdITNI1NyytpSNN5VNQYcDvuKHpDYtGIeMEGjK1eQxpqWdnX
 Y/AHXAcddg7ZJM17wp6mHYnm0geqdk4YsgBvePYeZ87b3YtLKwyxC2aZ/gwweGck0awkeXQngtc
 m4ac=
X-Gm-Gg: ASbGncto/qiAWJpLtAtdzJwoCBJj/JuTED+0u8yilNGIodtTTr6IzFymi8Rn0iX64/1
 4l//xJ0OM6Cb7gH1OGkCc4jcd/iG/JBoGKKFGKJ5Yg1rCaPWOetNl9hhnLeZK0Kz1CE8FC7bVdn
 eK9aui/pyL3oBiEkJSbbPnPg/c6XPyqNGJGempEStrKoKCjDMHHfa5ZZhP2JmnDMh2vhrQ4ci9J
 jR3qbqWam3o97eiH0+TszJv5IWzY9+DzsAOGBWkx2ky97+4xftREgYL/3I3NqBu9YfDj6aDhpXz
 eGs6vHS1Vt6ukks9k5YCSKreD136cSpGFX7KGkeu7W9tgu8unIaiSZ6h4sW7ekadwg==
X-Google-Smtp-Source: AGHT+IE7Rvp8IWHSG8TN0cuLH5HU1vI0hraFlRdcsxcb82PnxgLdH74SRsYB5zKwwE/skHQ3fqKOMw==
X-Received: by 2002:a05:600c:5486:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-438dc40d3fdmr219161265e9.21.1738628631843; 
 Mon, 03 Feb 2025 16:23:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42dfsm174646505e9.4.2025.02.03.16.23.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 12/12] hw/arm/raspi: Support more models
Date: Tue,  4 Feb 2025 01:22:40 +0100
Message-ID: <20250204002240.97830-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Allow to create the following machines:

  - Zero2W
  - 400
  - CM4 and CM4S

Fill the arrays with the BCM2712-based machines (raspi5),
but since we don't model the SoC, these machines can't
be created (and aren't listed in the 'help' output).

List taken from:
https://github.com/raspberrypi/documentation/blob/9b126446a5/documentation/asciidoc/computers/raspberry-pi/revision-codes.adoc

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 86ecc988e06..2346550eec5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -71,6 +71,7 @@ typedef enum RaspiProcessorId {
     PROCESSOR_ID_BCM2837 = 2,
     PROCESSOR_ID_BCM2838 = 3,
     PROCESSOR_ID_BCM2711 = 3,
+    PROCESSOR_ID_BCM2712 = 4,
 } RaspiProcessorId;
 
 static const struct {
@@ -82,6 +83,7 @@ static const struct {
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS,  1 * GiB},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS,  1 * GiB},
     [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS,  8 * GiB},
+    [PROCESSOR_ID_BCM2712] = {NULL,         BCM283X_NCPUS,  16 * GiB},
 };
 
 static const struct {
@@ -106,6 +108,17 @@ static const struct {
     { },
     {PROCESSOR_ID_BCM2837, "CM3+"},
     {PROCESSOR_ID_BCM2711, "4B"},
+    {PROCESSOR_ID_BCM2837, "Zero2W"},
+    {PROCESSOR_ID_BCM2711, "400"},
+
+    {PROCESSOR_ID_BCM2711, "CM4"},
+    {PROCESSOR_ID_BCM2711, "CM4S"},
+    { },
+    {PROCESSOR_ID_BCM2712, "5"},
+    {PROCESSOR_ID_BCM2712, "CM5"},
+    {PROCESSOR_ID_BCM2712, "500"},
+    {PROCESSOR_ID_BCM2712, "CM5lite"},
+    { },
 };
 
 uint64_t board_ram_size(uint32_t board_rev)
-- 
2.47.1


