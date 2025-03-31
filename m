Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA6BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL9J-0004IB-Fy; Mon, 31 Mar 2025 15:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8a-0002Tf-HH
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8Z-0003Qm-0t
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso4633703f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450573; x=1744055373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeP6jQz4X7+XY7FtN/BipVDSziqVvseYgaJ7e11b81k=;
 b=xV5mj+FBzulAqGZz1AymvU/xLaZLOMQCCwNgFmlUQ3g2tmn7IqHFbmKxo27zKJSNJ+
 F2MpfMpo8hZQlWbPIhKDkiCefKiGSxW9OUXRJyex4zZpC8Ihn8qWixfTw1SYziQdRZQn
 XMdMpHlJgjgb9j6vAa3BD0i9/z7av9rmRLhV4/bPKDailvw82W+gHvUrPGDyRWVqE4mq
 9GPz4Lm95OXqEKRqkcFE22domYK43BgbRjXznl4yoo+5H2gszdtly+hoTei8J+yURSZq
 uQCnBWqQhtP8Puj0giX+LXsj2bS4uj3jA45XtcMBXpcoZF5EOIRf5FeT0Bn31WhUqyBa
 FaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450573; x=1744055373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QeP6jQz4X7+XY7FtN/BipVDSziqVvseYgaJ7e11b81k=;
 b=xQV2j/OLld7bGTR7+0v2h+imm6E6UxZ4vBG01FUI5GtZO01ZLZz/kCHbvp8diHaPDl
 vX28ABYDeJoRtnZleF5UfcBSWtiN2DheUINJmOE9B4cDw+tTlnw6DFVJRf9g5CxKd8y+
 qdBaehV/RVFZ5Hx9c5e+sBcGv0YtLtKB/N+mphZtqjLDl2DcU+W4D8GV2XOvhX97ZSYD
 znFWlstK6BSAyAzAaD+mYSre4ZRqrb+qLl0x8737iKlYHCwDzlY4dNQdVi6ueghQf0Gb
 qlZhDtHIknmU8sIyUt2V+DQ7CH+BBDFb9DnVWjooZ8ApsunVUt83gTCMUsiAH6M2ttwx
 8BSg==
X-Gm-Message-State: AOJu0YyOUpgly5IutG9DZpEi7uTs1jBRmI+0k4i4zgBG1mMijUGGiQiW
 oWiAkRIEW5L0rfSJ3BDIKIp+KGwC6ZGz+puLpE+N7s6WYP4HQ7Vs3gIfYzaSy+5nRZvXm7GdD6V
 /
X-Gm-Gg: ASbGncugjNm/d6rIn0ievAorxH0GS9DQylA2yNgpugjreLO5TlLLiCGT3zrLHzfDmor
 d1xkw564wFmz8f2CQQ62PVceiQ+T0fbIpMjQahTigv0mRycpc4LA/08MY4KonYamYw9YR51dhdG
 40Wpx+GG/O2tylASIuHyy//JCmcF92KImQRdiprN2ylPkFcOECM/pxpIZ244V26xSFdno5VSJ6P
 NI0xMRZquZ6DlLru4mmineXK2fTo2LE6RCDVskWouEmryWgd9rYPa5RKQaDEllVtUO/Zg1/7oQe
 w8wYEYcpf4GUQHmUGA+n/hvurVPeZpgaHz2A0uO2iT+C4FCuSImQ1LoxGAbmDpbpqqfPVRAGli+
 Xg6e+IDAq3mplg9gsMuc=
X-Google-Smtp-Source: AGHT+IHPkNX8mlPBJJVaShl76um6Dv5nAOBoqgSWsx+vME1rnw1bqT6PlOuDheO1psoGT4MPkQf3bQ==
X-Received: by 2002:a5d:5f90:0:b0:391:2e0f:efce with SMTP id
 ffacd0b85a97d-39c120ccaa4mr8262930f8f.1.1743450573350; 
 Mon, 31 Mar 2025 12:49:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efdff2sm174620815e9.17.2025.03.31.12.49.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zheng Huang <hz1624917200@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/23] hw/sd/sdhci: free irq on exit
Date: Mon, 31 Mar 2025 21:48:12 +0200
Message-ID: <20250331194822.77309-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Zheng Huang <hz1624917200@gmail.com>

Fix a memory leak bug in sdhci_pci_realize() due to s->irq
not being freed in sdhci_pci_exit().

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <09ddf42b-a6db-42d5-954b-148d09d8d6cc@gmail.com>
[PMD: Moved qemu_free_irq() call before sdhci_common_unrealize()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 5268c0dee50..bca149e8113 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
@@ -48,6 +49,7 @@ static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
 
+    qemu_free_irq(s->irq);
     sdhci_common_unrealize(s);
     sdhci_uninitfn(s);
 }
-- 
2.47.1


