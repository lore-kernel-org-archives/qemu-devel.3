Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31B1C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJPS-0008Ox-H6; Tue, 06 May 2025 10:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJP2-0007pq-5s
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOy-000161-RK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so5945185f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542166; x=1747146966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJMsf8d9E7od1eerUg9AnKC8aiveIyxhwsrRajuSRCM=;
 b=s5UumaTapMU27ohp56n5Oj0C5wIV3H5cF1xnAvLv7+HoMC8yPl1AD9Ge6936eRgk3U
 O1X5qQCQqb3Hoh9RCcLCZ17su6SSt8P/+xse06ZovvkRX8ZCNQabSgWaWreiZ/AndK1e
 ve8McUKB5fvN1PM0jzpzZhWfF+XGG6GzITPiOw4330RW8f4zUsRYrgSOPiMiAGFn9xSj
 ydMM11InxRRz7B32rO4I3nMcWYjwkXWl5Z5VkvaQWyDNWsZMoBwQ8aQhcTuPLhN2rt6Z
 tUy2Epa0IDIpx6ovUEMaZOF4Osrp8WzVrL3aBQ4O6ANSzVfpcGYB2kC2nvlGjL2OaGoQ
 PRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542166; x=1747146966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJMsf8d9E7od1eerUg9AnKC8aiveIyxhwsrRajuSRCM=;
 b=ZXrR1ZrntXrQw1JGgflfr7mR3GCqCXDsl3PxQ9LYRBjozgNowyGvrMvUwERJ6XTFfE
 mqcMSsAY8TOZLcD2sDlHpz/UEtEXDqYqbw+xPyy44A76eJQ2gS3L8iqBQF0KlNoJWfl7
 HNn261D+cmVvC/0JibPq0iKD6oqSeayaHWJZ72TMkKXQasANa4pHOduOm+AhCLelxb2X
 6f7K1TLLKlFAT0VuL4gBmLrdiA/7AOptdGk/pYCiqZHcwCuZIy5qzt7AO0MGiJPrzX7M
 zfnMgfWus2G6+jU7SRpbBqN1MA1I4LfASPTiXrIUi6rleq2n5Hotb1iftP0yrRd8ijxA
 tw9w==
X-Gm-Message-State: AOJu0YyH3vidz9HnaIxx0GFMyCcvO/Wi0TLp1BJu4Psd3AHQ48YQjLqq
 uFlySo/AeYV5tMsXGFJmsybFLKLtv+VbhpBQlUZpzoH6NeeybMpMmxylDtAsVZVjtE9zjRTeGBi
 f
X-Gm-Gg: ASbGncvzg5YasTXpxLfHi7H8aDxKNndYn/QmA/smSOO4A6cOLK6+ZXorHUwAY5dw0Lo
 R/AT5RBcEjWaYiuVxvQrRhKNmQCBvjqgVnjPNSCc8XsvdbJtMKrpLnW13s7o0+la0kF7gex7kXy
 fLZyavH1OWUR89HHPp6y/sFrlJmGde9Oc9rdAQy8waakR9+8zo3C7U22RVz/wqXy9aLOs1BXw2e
 ecaEmZ43Z7ufmY+gBN6W2mAvSHRLsoHjfj0AWXw3YEb8t9+mj3hi9hrGdjm8b8tAJagPJaf7qJ0
 HbrJvZvEPHJOFDyAbhWVOh84+g4bX1LAy2Zd/sSSFS4uG43N8NdRoFbYYhYWpMRnQHfe5NdB9E2
 LVIAhhamAagV5T4NnzDI5
X-Google-Smtp-Source: AGHT+IG8gdzcrLUK4hyzHzUlFZVKGNgKT1Bv1OcU+Tzdh6+VKGqHHpd7tfpkjF7i2jKkEmz41CEHtw==
X-Received: by 2002:a5d:5f85:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-3a0ac0d976cmr2881628f8f.15.1746542166185; 
 Tue, 06 May 2025 07:36:06 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ee39esm170797135e9.21.2025.05.06.07.36.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/22] hw/hyperv/syndbg: common compilation unit
Date: Tue,  6 May 2025 16:35:00 +0200
Message-ID: <20250506143512.4315-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We assume that page size is 4KB only, to dimension buffer size for
receiving message.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250424232829.141163-5-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/syndbg.c    | 9 ++++++---
 hw/hyperv/meson.build | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index ca291826a07..8b8a14750dd 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -10,11 +10,11 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/loader.h"
-#include "cpu.h"
 #include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -184,12 +184,15 @@ static bool create_udp_pkt(HvSynDbg *syndbg, void *pkt, uint32_t pkt_len,
     return true;
 }
 
+#define MSG_BUFSZ (4 * KiB)
+
 static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
                                 uint32_t count, bool is_raw, uint32_t options,
                                 uint64_t timeout, uint32_t *retrieved_count)
 {
     uint16_t ret;
-    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
+    g_assert(MSG_BUFSZ >= qemu_target_page_size());
+    uint8_t data_buf[MSG_BUFSZ];
     hwaddr out_len;
     void *out_data;
     ssize_t recv_byte_count;
@@ -202,7 +205,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
         recv_byte_count = 0;
     } else {
         recv_byte_count = recv(syndbg->socket, data_buf,
-                               MIN(sizeof(data_buf), count), MSG_WAITALL);
+                               MIN(MSG_BUFSZ, count), MSG_WAITALL);
         if (recv_byte_count == -1) {
             return HV_STATUS_INVALID_PARAMETER;
         }
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index c855fdcf04c..a9f2045a9af 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
-specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
+system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.47.1


