Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405B0E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0A-0004Er-2x; Sun, 15 Dec 2024 14:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzz-0002t1-HA
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:51 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzx-0001Wm-Hv
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:51 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29e5c0c46c3so1728295fac.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289788; x=1734894588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YuFtZ+DmVXtIMH4G5/Ti8ZD+nNOe3CzMTkLQ80e6uw=;
 b=oQANsbIMUl6PAywZ+OLxg9fAHcCY6AU35oF6RsQ35VbaWE04cNSL1IJ5LnY36Ne56C
 ChfX4sJkxsj5op62MvIjH5rdUb2WVfJj+WbT6jswhHR+8GJh0947Nt3Tho/5PsHbuk3p
 sxAsXG6hQWhx+36GkWq7XR2AJeB551wa8AogQfTr+FDryXV3Wu3TjxaHZpMbt0vc6V+r
 XexekvmwgMssu62+tMuE1chbab+bHOzHnrvmG2tC3tknAoN80EclI4B5v4TkI/XCvnBb
 ZIxY3LDV+VA0mNieXcpCQPqYSPzJ2HtCP3YGKUnA0Hic3fwQQjn8U+oMtkit2UYPu2TU
 qtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289788; x=1734894588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YuFtZ+DmVXtIMH4G5/Ti8ZD+nNOe3CzMTkLQ80e6uw=;
 b=asyVrMV23JboBaUUGQBtotiFbZl6Tc2eAZ1CB2dKoB4NLPkCziD8v5WCbrmu2VI7z1
 hBvNeFHek9ir2KQoKbHuA61JQWCjTcoeioVaJ4sIrvluGSjWPCpoBgW2Dx8/9F5Zx+3s
 5M5+c5FowuTrgeEja40J1NNq5klIBSlmJlJbV8Oub2DL43kbVhph+++mMaOiacIZhjfJ
 Ng5NS5T0aR0utlOasSRtRsRu4yTVx0fdQ/G/DiHz5Yp64946j7sQn2jybdN+Hx46ZD5B
 +EipBL1KR1UdCHzuOxAIGkytNRmehMghrnBLqXRvdKmhLGV2nqyzZEgqKhg+RbVEobW3
 Sybg==
X-Gm-Message-State: AOJu0YwF7O8PMHB12FVys+BgT5+/gZUx6eoGg/Il0LybyBHQUPrxvhJW
 rX0Q0KINF6ERBDL9/FvLEEBEmOvNosRhhgnTbrPLHEtjdH/4n6G5smtkqfL9r8+0RGUrzeM8lbf
 GIXIoTZFy
X-Gm-Gg: ASbGncs7XuKszaHmBZ5qA4l2ZUCV5P/jVW2rqzaaz/hs/dLHR7+U9zlLnnTusHzZtX/
 +0BRwSOQTND+MTCHps2SmnQm1iHIpvwoac1ql3IDZK9Ss2npvUtjOSTbz764RT3E8H9C1B+J6Vs
 5CMYex4FzjcxZXu2qfT8YV0sh5ZV/K783LsFZCCMPehpXmiFcm9FADuwEhJR6J+dqy6re7jvKTY
 lKvpjhX5IaA9WxeVjpcdcV8ZmGqJQji5EUDA+MNccL+jOy67s1ky0AZK5Aedt2KaTrFvvhMEARQ
 yPuoaRcEIoQrfpkBeSHWchIZrQ6wguo+hoyLT43g3Rw=
X-Google-Smtp-Source: AGHT+IHEQLQvcGXXB5ibjNpl/QOe5oqEfsMII3bjSId+bszJJnD6Gjn5oY/v9RR3KtPB3ApXz2Bz5g==
X-Received: by 2002:a05:6871:4095:b0:29f:ecfc:32df with SMTP id
 586e51a60fabf-2a3ac5bc2b5mr5741324fac.14.1734289788281; 
 Sun, 15 Dec 2024 11:09:48 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 54/67] hw/sd: Constify all Property
Date: Sun, 15 Dec 2024 13:05:20 -0600
Message-ID: <20241215190533.3222854-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sd/allwinner-sdhost.c | 2 +-
 hw/sd/aspeed_sdhci.c     | 2 +-
 hw/sd/sd.c               | 6 +++---
 hw/sd/sdhci-pci.c        | 2 +-
 hw/sd/sdhci.c            | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index bcfb4c1322..be39ec2e71 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -808,7 +808,7 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
     }
 };
 
-static Property allwinner_sdhost_properties[] = {
+static const Property allwinner_sdhost_properties[] = {
     DEFINE_PROP_LINK("dma-memory", AwSdHostState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index f82b05397e..99703f1842 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -204,7 +204,7 @@ static const VMStateDescription vmstate_aspeed_sdhci = {
     },
 };
 
-static Property aspeed_sdhci_properties[] = {
+static const Property aspeed_sdhci_properties[] = {
     DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f9bd03f3fd..b994ef581e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2798,18 +2798,18 @@ static void emmc_realize(DeviceState *dev, Error **errp)
     sd_realize(dev, errp);
 }
 
-static Property sdmmc_common_properties[] = {
+static const Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property sd_properties[] = {
+static const Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property emmc_properties[] = {
+static const Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 9b7bee8b3f..83892a7a15 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -22,7 +22,7 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 
-static Property sdhci_pci_properties[] = {
+static const Property sdhci_pci_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 37875c02c3..e697ee05b3 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1544,7 +1544,7 @@ void sdhci_common_class_init(ObjectClass *klass, void *data)
 
 /* --- qdev SysBus --- */
 
-static Property sdhci_sysbus_properties[] = {
+static const Property sdhci_sysbus_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
-- 
2.43.0


