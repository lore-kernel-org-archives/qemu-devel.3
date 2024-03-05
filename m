Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685CBC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQdg-0003tJ-CY; Tue, 05 Mar 2024 03:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdd-0003rv-TH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQda-0003eX-Th
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:05 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso45842135ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709629141; x=1710233941;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=41HOhmfFzvzHUWDzT1tLGC+0kqqS1QTmSsIo/CJC9aw=;
 b=gTtgVVLc2iwUZWKKFnuz0bydQOTsdACWA69S2teEQ5tVNyqGR0rBK0c1cXRb5goASK
 0nikpL8K7RZQF8ikX5Bthkq2aItDA6ZRecS0SehUycJXDc0E+fBbLCqnLjE/qGuJvaNz
 ZZDEOIzPHHyDuuyQOxMX7Nlcj9rI0EUNVQwBV9BSqnK2yMzLKv/8277VRGGPCUIivLG6
 HAoqBmEQBoZHNGn4Y6HNweaHnBLQ04x6afAMtBTNU9/0dAMSppWhGHjJwT4wFf7na35Z
 ieNtW2JnprStcfPHEBebSSSRJEhlkz8mj7wIo2urVKwqBCZqkK1hAruHk1nVfKUkJ5Sf
 UK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629141; x=1710233941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41HOhmfFzvzHUWDzT1tLGC+0kqqS1QTmSsIo/CJC9aw=;
 b=MUnvKIkrFtw8qTl7MxddLoI96LY9bbnZlv2XktVJLZuPWKRp6BglJ1/vN6z9Qv2Y4D
 TwH5RP7F0QfjxJ43GX+Hz9MfZVzsFV33BcVC52lnrVClHFHbyVcqpd7NKXx+dY8qVB8p
 S4WPr2cDb2sFUGogrAtwE7fhVGm0B6DL7Mzn3jmsVO8+zgPMSgvj57xlQScjORtn8/lE
 yVI4z67pqFpIsUvGA4kh3qk3FXY4ZgYflI6zsuITkss5kGyrXiYrlrnTb/h5ry5M6VCr
 2fd+I+YetirNbgnICyv8mcqp7+sk4HkYXSEtE9B6CUWBa64sP9xlxq7j9oyHsr3OL8Ib
 bsSw==
X-Gm-Message-State: AOJu0Yy0OxWD+7mq9+c/O0sB5i6pDrbByeWzXgRUGnUylx8ZfAAsPNVt
 nVQBWr9IdP5vVJRJvlY7rsx+/fIvycNpXz3MG6yVGq5hGbzWJrJ0oZAZAYoZwdk=
X-Google-Smtp-Source: AGHT+IGR2YzRjLxs4vKHJWgiJis2qudqTHhJ8QiUBQ3YaGqJTP++Zq1W3IpdBMbJ8yHv3NEAwjgnhA==
X-Received: by 2002:a17:902:eb8f:b0:1db:ab9c:d33d with SMTP id
 q15-20020a170902eb8f00b001dbab9cd33dmr1561733plg.9.1709629141222; 
 Tue, 05 Mar 2024 00:59:01 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 u11-20020a170903124b00b001dc01efaec2sm9959404plh.168.2024.03.05.00.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:59:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 17:58:48 +0900
Subject: [PATCH RFC v3 1/6] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-sriov-v3-1-abdb75770372@daynix.com>
References: <20240305-sriov-v3-0-abdb75770372@daynix.com>
In-Reply-To: <20240305-sriov-v3-0-abdb75770372@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 20240228-reuse-v8-0-282660281e60@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cb5ac46e9f27..201ff64e11cc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar != UINT32_MAX) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.44.0


