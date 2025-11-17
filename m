Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEBCCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvNd-0001YM-Pt; Mon, 17 Nov 2025 04:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKvNH-0000pl-Kd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:18:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKvNB-0002lE-N0
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:18:15 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so3362773f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371087; x=1763975887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z1G+OLaL4n0dcENeYQN6K/NmT7uSXZsSdALs6YUFBg4=;
 b=PMK7OjmcDrfHkWKQ7spT7XdBHL35YNiTExpEDWtUsgLNjAgDihxPfEca1lKm0zug74
 OAVmrJhFP48w81/4HsNKNKayTKbdfqu1/dWv22VDfeSWs5yb+mxNa4mF+Dq19km4eB8k
 /o3+cWAPoJDOc9bdnX4i23LD9gkYuGcWPT7VRmqS+I3r2Bft61r9eTmpKtyL17f4mIOh
 v5uFvqziXgiGOP6Js8l/cnJHPZUeyWpGUvDQwbIJ2Clon6B60/McpIPrPs4a1awg/n7H
 490CzkpNvKhceDqJfnhNj+l7lJIcvWvui/gnGMr/FLWunzQmexH/NGTdrzfEmS8jgfOy
 jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371087; x=1763975887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1G+OLaL4n0dcENeYQN6K/NmT7uSXZsSdALs6YUFBg4=;
 b=kEK3q8HfVBvVSoXaSBww13HFcplHRrb05gtuMfHInlWeewOUTaPp908f10A9n1xU21
 rDRY89kANSPDxoqOEgqrZ4bE2pqTL8VAbYFIMFP0f2H9NS/3oimbu9KyKBtor60pXRCG
 3ypeWxkKhlOBKbDdoqk7A6/XYD5MQcuLDV3b3Syw1X0RsabLz86Om4ixtbT3pVy0HhYt
 sSTOh/mI2w2KjJy2faZJ8xEpcIgmQW66Du/lpus2TbbB2doozxo7i51+0V5Z9/3KS9Ic
 1A+KZ6/LCQYnD/6ByWjPE+J8iI1FvSQWwbyeBfA1Nccn/ylm4jaugkvC3Y/Kt+QhNU56
 dUew==
X-Gm-Message-State: AOJu0YyX13k08ZyI6OMkbE6uESXSm2ZFEq4JFMDQM4Ya+Lq+agDRn5gC
 7zlphvauvp0RAIbeUKoR/co+Vgr9P2Z7sAnKBT41NHL3aikrZhxpZY+il1WJ7TlPpUJAm/SmwKc
 +fhFOo65bgQ==
X-Gm-Gg: ASbGnctM7jlNNEBKkp3VDF0yvQzTKVOLMMyampw6/UNItGOEdmleUunszt1swQTXl6o
 jqiFapYTXnbm/pCcmPTiIS2EinbOMXhRHEr5N92ZmyaJM8EZRU1rRWXnRIWIKNtTc8kYSJ1mtX/
 CxAVQEpGU5eioHYL5v3e3rp8ZE3Vk5R2lCF+DXZ0ZXH4t4HPjmXAuiH2+anIWXFOhCiC7U+o4gs
 efFMkBwa5gXb/oTv5FGkDqiYcbN4EUfYPPgNhDD49QJrjqV5S3erd8mz2LDhWGKhRM3WnTEuEwj
 B+La1nnbp2aZ0wYDELGNMTVvt9DX1infAvsy2ZfZqLrgp3h00iQwR6IchZrI4wbkmATqGR2zcqi
 Uu2b66enbjmpvqBmccMeURq2KedXeO2rbpWJ3PEDKXu4LP0QoeqcfPQukhdhpFVq/3tl5y3kwoX
 pQiduKKWHcSI4wte1EqAfVwOSzwInNtcv5pOqswz7jIweVl+tVYZ30g+IDBiPT
X-Google-Smtp-Source: AGHT+IFctotpgdkF2s48ZutUeIzhKMylJVkhAyOkHunscCcYBLSbJ4gMIaoFG/wQ00TT+BXzqhW1OQ==
X-Received: by 2002:a05:6000:605:b0:42b:3b62:cd9b with SMTP id
 ffacd0b85a97d-42b593722f4mr10927762f8f.37.1763371086878; 
 Mon, 17 Nov 2025 01:18:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e845bdsm24322205f8f.12.2025.11.17.01.18.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 01:18:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2] hw/southbridge/lasi: Correct LasiState parent
Date: Mon, 17 Nov 2025 10:18:04 +0100
Message-ID: <20251117091804.56529-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

TYPE_LASI_CHIP inherits from TYPE_SYS_BUS_DEVICE, not
TYPE_PCI_HOST_BRIDGE, so its parent structure is of
SysBusDevice type.

Fixes: 376b851909d ("hppa: Add support for LASI chip with i82596 NIC")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/lasi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 04312d0b589..0e95be1c32a 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -13,8 +13,8 @@
 #define LASI_H
 
 #include "system/address-spaces.h"
-#include "hw/pci/pci_host.h"
 #include "hw/boards.h"
+#include "hw/sysbus.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
@@ -63,7 +63,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
 #define LASI_IRQ_PS2MOU_HPA 26
 
 struct LasiState {
-    PCIHostState parent_obj;
+    SysBusDevice parent_obj;
 
     uint32_t irr;
     uint32_t imr;
-- 
2.51.0


