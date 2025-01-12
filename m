Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEA5C02183
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Jn-0003Ns-UA; Sun, 12 Jan 2025 17:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6J1-0001sB-Hz
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6J0-0006ZL-22
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so42825605e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720376; x=1737325176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmxRTGMWROJpEWZSo1u+jDCiV46gwFTHUKYAuplU0Gc=;
 b=SXh4O31DEXF6kSz35CPArjT7T5ZXu5R8snUd6ZksTHwJxzF9uwukxAvdSwJSw3CLiI
 +Go90WcgA23g2hDJvJ7/yRwD+hfSaSYeGYAZGrqxrI7FaIG9xDtFh9GEm6vvdrffTary
 NEImkh5Nw3f8eYyKmqFoG0+SESSgMI/9XVhU7uIvfKzvZ8mtqj3tLGHkZPXf85AZDBni
 FgFm4KHc4ciSlM0Me/SAY5i9W7QK8I2257FlL0Ad3hTcfQ14TIZGtM5cTbpTZXUpeLVK
 sOggDhZzduy+Q32fYp/IBePwdShXEVE7/20xaroTAzySEvYy9Yvy3ITfnk0MDIF8KA0M
 CEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720376; x=1737325176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmxRTGMWROJpEWZSo1u+jDCiV46gwFTHUKYAuplU0Gc=;
 b=gVkR6NP5G3RoyXUlCq5QbUnkDdsQfQ3wCdbew/eUH8DMrNM0cmb1yhATjh+WhR2X3i
 3lwIVNyQhyfrueCeAqMPnEuzF4Obx8Wc/eIneJEQGtFVBeu6luf35xP8o0XTsmPK23iz
 /4OBjvKjuXXXYBkeodKOKrbDm6CoZX7PnF7WHq8VbsAS9ruEk72HQux0MkWdEBLWrjbf
 RrqlgjoPgdpqhIt3Vhm5xMtcD49Vypq2ew1FkCTLff7shFRhxH46ScsEccIi1/zHrijn
 wXIfrnBJOND0c9fHNRcKta+Bggq8W/0VBXR2nn+FJlCgRRmSz6pBqZS8fGxAUKh4W0Z3
 Njpg==
X-Gm-Message-State: AOJu0YxsJhdYPrBDeLYtRXB2ZsTLx44JaBvhElVBTeh3gzNTHdVZMDfL
 CZEbXRRShV90HpPMWevZKYFvDaaSpYArU6zO/GWhz43ckxBbu7Gkg6T3AB0b9ykALDKUDP/j0VO
 bKnI=
X-Gm-Gg: ASbGncs/3IdnfTZlH4Wit7GLOTpwpaNKWc8wTvJif3YbdYIaxq2qoRqmxWlkBOxRQIk
 F0sT7rNw2Q65wE66Qw+++8j+2SyJTyr5+ucWVpmKwgZQ/iiiWPxFDdGc8ZBgbXah8CdwP5noBSz
 4ccZvlMhrKqKw4C8tRM3DltdFT+yKS7j6VijwWEJehcLSA/V+bxC6pEy1V9bJX+1k9kiCBvP+aO
 isoIpnO/aba+x2C1TMetVzAJ297o90+OMvtiLa3mg5MMNbhGtGVuqOrq/Yy43XFUheqdiKPAJGF
 0XDqNosrjbjXDNzTkuvMIltaNlj3128=
X-Google-Smtp-Source: AGHT+IHqZ6eR+ozvfAZllFw/XbYtMPuVV32e3GLDlYjJpOn5cnMI+Jjl16LTW6PPqx1Z5dmx9ZafJA==
X-Received: by 2002:a05:600c:4e0b:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-436e26aeeeemr183787435e9.11.1736720376145; 
 Sun, 12 Jan 2025 14:19:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm10782948f8f.52.2025.01.12.14.19.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/49] hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
Date: Sun, 12 Jan 2025 23:17:02 +0100
Message-ID: <20250112221726.30206-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

In U-Boot, the fsl_esdhc[_imx] driver waits for both "transmit completed" and
"DMA" bits in esdhc_send_cmd_common() by means of DATA_COMPLETE constant. QEMU
currently misses to set the DMA bit which causes the driver to loop forever. Fix
that by setting the DMA bit if enabled when doing DMA block transfers.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108092538.11474-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 299cd4bc1b6..a958c114974 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -665,12 +665,13 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         }
     }
 
+    if (s->norintstsen & SDHC_NISEN_DMA) {
+        s->norintsts |= SDHC_NIS_DMA;
+    }
+
     if (s->blkcnt == 0) {
         sdhci_end_transfer(s);
     } else {
-        if (s->norintstsen & SDHC_NISEN_DMA) {
-            s->norintsts |= SDHC_NIS_DMA;
-        }
         sdhci_update_irq(s);
     }
 }
@@ -691,6 +692,10 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
     }
     s->blkcnt--;
 
+    if (s->norintstsen & SDHC_NISEN_DMA) {
+        s->norintsts |= SDHC_NIS_DMA;
+    }
+
     sdhci_end_transfer(s);
 }
 
-- 
2.47.1


