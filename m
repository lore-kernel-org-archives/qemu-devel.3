Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C12E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9I-00049h-O6; Fri, 13 Dec 2024 18:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8f-0003XH-2C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8d-00034g-9U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so16189955e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132720; x=1734737520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGu1RWDi+gwgcW3c9gaeL8ccTCliWtLZLUZIPeh5RIQ=;
 b=McfsTDec6PH303IE+3AMfVDtFLUkq0Xg7xwKa9n+SVtfm7HLkaqanGuSD9CMQxVoDy
 B59byVfGHySBpP6UMg5mG7paaIrOWcXIN+5WTnDT/UORdGFKaB7UNNFdR05BJ/x7dDmB
 bpGOIArMh0qPljUjQYeP2NaWNX2+zaGXN3Y740Wwrzyzf2YxknrG0eP/VWPReFf4a13O
 boHI+fka+eBY60a7guXzmkxIDdUtUyk6KRYsW3i/v4dN5TN3zQp/iyCFoCsxSpsaPTZx
 3Et8JGX576+yAylghw0yMsArhIBPhPLfqvxzpydiiyaIJHtmvLfgHp90MJxMPVGk3kK3
 uafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132720; x=1734737520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGu1RWDi+gwgcW3c9gaeL8ccTCliWtLZLUZIPeh5RIQ=;
 b=VagkIo00tYN5+k0wDlrs6asi1SxZrrYQb8fTi3JIrx5xKvNIuoySuogI/xiBk3gfH2
 lTdz0IslTYz34/EBJ8/OM56dOtJZ2XOAibnLzLHVl1xoAne/C1VkgzG1XRjXm19D1JPK
 hCIQE+CGMEwH0iioyLNB8KUWnAwFJo3nKQE0cOlUicJ9H3aewXtdeVWH3roQa4uygXU0
 DEuv0gv9HEnRd5Qz91wB09aZCQL8OmOn12DnHQQS+WuCo/OQmyEXuMUgcpyE+EgAz9pS
 YZXAwXW+4A4o3ME//0D87yytL/BbJf862ra8foKUQ4HD+nAgCAT4RQ9AtXFBWFAh2rlv
 9n6g==
X-Gm-Message-State: AOJu0YxVFSf3TKCne7sk1ktuXDuaOZ1znKC0bjI1QDqj07rJTPSBdxi0
 tBTBhY+V0C+/8kl33q8Y2iODtpPqT6DB02J3zXVaePVWAzB16HGhPq/PCsl7fIWz0BlznFQyTcM
 EZ24=
X-Gm-Gg: ASbGncvcOaEbWc4JT9V4vAVqQNajWLvlJX1cIJDEPQgMVk+7MN7Uu3ggB0/w88u0rE1
 yPQ3OLz9xHMmqQLEvh5sVCaX0pRCkBat0CT1J0jnRxQcHz8CWRip6pTNvXPQXwx6+Obdnz+WAKw
 IFF5xzoV8j5660rsuyutQJ3VxenKcqamdTMbY43Rm48wqkRE+ZapyH32H7ZS0OX5Hmm+R8yRp0D
 5bK+lLqs9Hd2V4Mm0Qr2zXaoaOwy69jZxycXrj+XKHS6OpGOa7xE34dl3hwKkp4c4mZhS1zc0X8
 SElMUw==
X-Google-Smtp-Source: AGHT+IFc1OfMYAjS5qAqCZ4gvTaUB2C9N0qBROnRile59Kq/hUd7/b+TZzGvhx8Nuq3it+v6IjdylQ==
X-Received: by 2002:a05:600c:3109:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-4362aab4e5amr39965535e9.30.1734132720170; 
 Fri, 13 Dec 2024 15:32:00 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625553213sm62212545e9.8.2024.12.13.15.31.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/20] hw/net/can: clean-up unnecessary includes
Date: Sat, 14 Dec 2024 00:30:47 +0100
Message-ID: <20241213233055.39574-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
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

From: Alex Bennée <alex.bennee@linaro.org>

The event_notifier, thread and socket includes look like copy and
paste of standard headers. None of the canbus devices use chardev
although some relied on chardev to bring in bitops and byte swapping
headers. In this case include them directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20241209100635.93243-1-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/can/can_kvaser_pci.c   | 4 ----
 hw/net/can/can_mioe3680_pci.c | 4 ----
 hw/net/can/can_pcm3680_pci.c  | 4 ----
 hw/net/can/can_sja1000.c      | 2 +-
 hw/net/can/ctucan_core.c      | 3 ++-
 hw/net/can/ctucan_pci.c       | 4 ----
 6 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 38434d3a04b..9e363d532f5 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -30,12 +30,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 21659b7afb1..580f099e00a 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -26,12 +26,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index af21dc6855f..3195b79954a 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -26,12 +26,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 6694d7bfd84..5b6ba9df6c4 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "chardev/char.h"
+#include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index 812b83e93e1..4402d4cb1f7 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -28,7 +28,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "chardev/char.h"
+#include "qemu/bswap.h"
+#include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index 65f1f823030..a8c77b91943 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -27,12 +27,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
-- 
2.45.2


