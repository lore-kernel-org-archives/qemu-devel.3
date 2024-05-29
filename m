Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75041C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgH-0000dw-U6; Wed, 29 May 2024 01:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgB-0000c9-DN
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:53 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBg9-0005Ss-Q7
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:51 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e964acff1aso16416381fa.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959806; x=1717564606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnRVHCDouTA+5HlMl31thguywp3whz3Nvn7kAUajqzI=;
 b=hekKaadge6WgKwFkOMFpgNYomJX57IUHABKjpUTMXebqy2y2e7SvKjvA6LAjTSRecM
 E+oTSu/Wvlz8tLh5ZLfukyIZme9B+TshV9W6KfOm90TTpBwA9BQx8EIqBqn7IsLM3srJ
 Uf6bJnymvS2SO42zOMKDe6vDlBbTGYgZsz+vieXHMDdm7J8YIqGS5FMrAyTQlmdjWl8j
 Xj6spMeKDrtnnEdyZrw/P+Ulho6uiihib4wqNvEWaBlMbM1cCTgKApBrMmqQMuNPhqhA
 HAEi0U+rbLDN5/bn/19/j6n8cC4vuivDdF0iJoXIan7dNQKbHRafEEGyeXMQjjNnzF1h
 xMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959806; x=1717564606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnRVHCDouTA+5HlMl31thguywp3whz3Nvn7kAUajqzI=;
 b=vJ1p/ra+uLEhx8710lOqxXZtdvQu+Hq5ka5z4gYNIpxAv4SO5e1qQlju0xz3TKNLa1
 oSNGBUjAWCp8qw+rRrebjs94j2xWOw34wgiBTnGimy1uIS+WiPnzcTxSDGGEROOx4UIe
 W7WGExdREslumY84JpkIrYWGWwRfroV9fRxOyXZltZq4ntyKTlojVkQ99NTEm+HyeCGm
 opfIP6k1lMv87wSQXhvq7CLqpf/OBRO9NMg/PPj0WBVlmTktQRVp0LJF2P/fEy87Y6Rn
 vuDgeBU0YxHfFk2S3jiWpggpKMeUdnZjflBVCPYYB1WlKTEiB/VQa9HnDhTGzcQeLlIJ
 n0AQ==
X-Gm-Message-State: AOJu0YzUQLhaV3ocwIXJY93D4nEJypdV/xTgkE4peTGu4QE+AZYCw8wK
 YrlvzQ0DxJ1QxP/u1P1HYps2DYZo2nOHe12fOrgVI0of1sUkvk08iP9oCNKWsjEvFH4wsNGFTsq
 Q
X-Google-Smtp-Source: AGHT+IEIfN4CrAwgABBGQI34J71C7M7OXR1LVEO5nV1kLjBfXW6qRpqWT6wtNJREceizeCcO7tTiNQ==
X-Received: by 2002:a2e:a178:0:b0:2e2:1a8b:e2f with SMTP id
 38308e7fff4ca-2e95b0bcf29mr88847571fa.2.1716959806519; 
 Tue, 28 May 2024 22:16:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fadcabsm197280155e9.35.2024.05.28.22.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:16:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 12/23] hw/smbios: Remove 'smbios_uuid_encoded',
 simplify smbios_encode_uuid()
Date: Wed, 29 May 2024 07:15:28 +0200
Message-ID: <20240529051539.71210-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'smbios_encode_uuid' is always true, remove it,
simplifying smbios_encode_uuid().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/smbios/smbios.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8261eb716f..3b7703489d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -30,7 +30,6 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-static const bool smbios_uuid_encoded = true;
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
@@ -600,11 +599,9 @@ static void smbios_build_type_0_table(void)
 static void smbios_encode_uuid(struct smbios_uuid *uuid, QemuUUID *in)
 {
     memcpy(uuid, in, 16);
-    if (smbios_uuid_encoded) {
-        uuid->time_low = bswap32(uuid->time_low);
-        uuid->time_mid = bswap16(uuid->time_mid);
-        uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
-    }
+    uuid->time_low = bswap32(uuid->time_low);
+    uuid->time_mid = bswap16(uuid->time_mid);
+    uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
 }
 
 static void smbios_build_type_1_table(void)
-- 
2.41.0


