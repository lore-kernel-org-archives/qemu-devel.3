Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5FCE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdjy-0005vD-1Q; Fri, 06 Dec 2024 14:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdjv-0005ut-7P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdjt-0001ea-M9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434aafd68e9so17027245e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512304; x=1734117104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inpxKK/bSOw7wpkiYaFHlIXdNffEZkImnMWDkwESKJk=;
 b=OwemHclZSo9xwe1p0E0SEKFPyoaMRjsFhrQkJmkPDK+rhR0m/0Jfhws960RfCd8pnx
 /u7M3/JOhg0Q6z0tzigyRpXzdXi9BWZXgdKIT951YiPnSMgsUnin36QoisOd1IMwCXlA
 BXqs9U1kE/b7K/XTez4YQkn2zyG5tkzTot85W4Hf+yrHY6VDABD+oT1y61aRwId+egjL
 BELriPNNFei7cCvWSdNFfFp7uPbVgY/8WsJ0g4gxECXokFJrfOKT7CfoFIMpual6aDsU
 C0oF2jOvW00f7p7ebRkclZr5RnVZc/7lCJyhckeTbrffHnTwzXUlmwpSgFV5UafmMdKb
 /X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512304; x=1734117104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inpxKK/bSOw7wpkiYaFHlIXdNffEZkImnMWDkwESKJk=;
 b=ZpzaH2OcQZ2OKlcZIACMlyylbjOp/jcFTBflP4G2VjKrfrHHJTOj62OIZT8/W5x9Ed
 BmyaELyfyaEQNj/pY77zCeoN50S6x38w4p5Ay/vvhol+eAy6GTnRH8Xl9oeshveTFpb+
 mUs4+glzPbtJzqO/yTzvKzfWCurO4GydDGA0CLkneGJJEKL+SDuZrNjq9ZR1SX5dGuy/
 wg19iW2tsEbnOeJ/Z6cE5ohueskqTXSS680zKCoF++rpI72XaFAXSupG6akb0kczl9No
 T3fivP/hffQcYV0pPgo/hv6BTB+DnJQzWV+bfftEUrnTrAR+yUtbo0ReNHlKA7KPlMi/
 cUTQ==
X-Gm-Message-State: AOJu0Yz2aZqzMXxAzjtw4giDC7B2EsAG/ABBerPlOpqD+qXY/kJnYHi+
 11eXN8gJnRyAKJuVlb7/U6rueWNaSLQc0KOVhvkpEmQObTnVLXoieMeXFvO82nIwmYhx2OOmGml
 HfbY=
X-Gm-Gg: ASbGncuoZW+hyDkgce7NJV+Jwg99An7AWoYUKzQP9HXBbQTQbdCEobpTYlxao+WNrFm
 su+YNavz0rmDrU94yM4XE2qL6eKDJW1Mg1YOHdfC10BpMSJAwoh3RYy3TMGr7VLeX4yg0T58ORv
 KiztGOIaiYmopCoATq0kyFSLKJ80zz9Yk+GTjl5/+6roIuiwrqI6WNtG0H0ZjylPWtzu101fSZl
 E7IIodEes343OXXev//sK6SC2CiXBHYOrRtulj5nEiyRkoCVAo5k0fY80wvw6Ko9Mc=
X-Google-Smtp-Source: AGHT+IGZmG/pNmhqQC9Zl2YduQckfG9RFydzk6yGsvB17dGx/q9JXAqRNMGrQFYjvCi62acFg/oWfg==
X-Received: by 2002:a05:600c:4eca:b0:431:6060:8b16 with SMTP id
 5b1f17b1804b1-434ddedbb3bmr43086355e9.30.1733512303951; 
 Fri, 06 Dec 2024 11:11:43 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b312sm104463915e9.6.2024.12.06.11.11.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 11:11:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/timer/hpet: Reduce hpet_cfg[] scope
Date: Fri,  6 Dec 2024 20:11:22 +0100
Message-ID: <20241206191124.9195-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206191124.9195-1-philmd@linaro.org>
References: <20241206191124.9195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Now than hpet_cfg[] is only accessed within hpet.c, make
it static. No need to expose the hpet_fw_entry/hpet_fw_config
structure declarations outside of it, so move them in the
source too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/timer/hpet.h | 16 ----------------
 hw/timer/hpet.c         | 16 +++++++++++++++-
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index d361ab9e931..2a95799a679 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -60,22 +60,6 @@
 #define HPET_TN_INT_ROUTE_CAP_SHIFT 32
 #define HPET_TN_CFG_BITS_READONLY_OR_RESERVED 0xffff80b1U
 
-struct hpet_fw_entry
-{
-    uint32_t event_timer_block_id;
-    uint64_t address;
-    uint16_t min_tick;
-    uint8_t page_prot;
-} QEMU_PACKED;
-
-struct hpet_fw_config
-{
-    uint8_t count;
-    struct hpet_fw_entry hpet[8];
-} QEMU_PACKED;
-
-extern struct hpet_fw_config hpet_cfg;
-
 #define TYPE_HPET "hpet"
 
 #define HPET_INTCAP "hpet-intcap"
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 9ca1424565f..849cb3e669b 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -41,6 +41,20 @@
 #include "qom/object.h"
 #include "trace.h"
 
+struct hpet_fw_entry
+{
+    uint32_t event_timer_block_id;
+    uint64_t address;
+    uint16_t min_tick;
+    uint8_t page_prot;
+} QEMU_PACKED;
+
+struct hpet_fw_config
+{
+    uint8_t count;
+    struct hpet_fw_entry hpet[8];
+} QEMU_PACKED;
+
 #define HPET_MSI_SUPPORT        0
 
 OBJECT_DECLARE_SIMPLE_TYPE(HPETState, HPET)
@@ -87,7 +101,7 @@ struct HPETState {
     uint8_t  hpet_id;           /* instance id */
 };
 
-struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
+static struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
 static uint32_t hpet_in_legacy_mode(HPETState *s)
 {
-- 
2.45.2


