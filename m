Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5DBC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvij-0001WK-2P; Wed, 03 Jul 2024 04:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvih-0001VT-Kz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvif-0003yj-PL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42579b60af1so29610795e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996720; x=1720601520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t+GbJBD58UyWaUHFeiM6fRRrol1LCDDEUBkP2sRRWQ=;
 b=cGV8OzWcx6hw9a4v3Gy85y6bHH73qDgmXUdynLEfEpaDwp0eg5s/M0Qn75WxdNIPJg
 wt3bL30RsU2W4IaqdstSS3WLyPwvq1jj+iWqgu4fVO2xV3G9YQKCOqOwJqgoSjzjlHtc
 o+i3rgsENywmid0H5peyX3Yw/Cju+pbR9N6rEt+4R0m98ft4WJffbyP7QYpexBAEevms
 8UmvcPCz6NGMeR+DOgpNxpUj/VrbksgH5NxfC7++gQOBwHGR28HbUKqAMyJ/mgmcfJh8
 HzSl1xSz7OlUmbpwzv13F04ZoMn6G1AqzNMLIbMOjlSBmtKTSudiFThTFsbSwbAJuT/z
 LbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996720; x=1720601520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t+GbJBD58UyWaUHFeiM6fRRrol1LCDDEUBkP2sRRWQ=;
 b=urxDkhs0KwUmSrBvZeZMsixbv0d/5xq/cUpnkLWHf3+pPirdokUnPaAA1kIpeVgw3b
 DoK4fDjp3/zArBHDNn6en2EgXqVjS97SSlXVJ5xEZn18MXUaPGgDQxd9WV9a0rGnuxcl
 kHuxbBNXW47+upHR2Y3tz2715u8mx8qzpasPLB7u4m2PXWMdtIPUja5cay+g4UXtjT1b
 2/+uUKGh9nKcBTV3imVvtaDfaxf0t/xdac6Mzb7psPWiLHTc9/D38o80i07Pw/kdD+K8
 /nIYDnxQMFqNpqQ00EjzFvEsMolei51Lw5tz29Fx6YYnOoy5OrkFeJQNC+0GTeQ8Cu6A
 TnNQ==
X-Gm-Message-State: AOJu0Yy0tWP9ZQNxnKrY9Ls2nOAK6aNL+YJ9RZxLHAKs9EbsDVxM+/jc
 5GfJPkXNOqARdhNErTmUBNS4eeBTX4pzHfPFZ45xvtln8LUJptaS93n6tF3P+UEad+e7Br0Dl7c
 C
X-Google-Smtp-Source: AGHT+IHBRFnQ8sHjgM0aHRx7B9d1Yug6D0s0+D98mADBDNXbdKjtLSmgs+S6dmg9Uo6b9jlkAjsaYg==
X-Received: by 2002:a05:600c:3089:b0:425:7835:4382 with SMTP id
 5b1f17b1804b1-4257a06da46mr83354855e9.34.1719996719944; 
 Wed, 03 Jul 2024 01:51:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42573c55ff4sm205970375e9.46.2024.07.03.01.51.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:51:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v44 1/3] hw/sd/sdcard: Use spec v3.01 by default
Date: Wed,  3 Jul 2024 10:51:46 +0200
Message-ID: <20240703085148.66188-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703085148.66188-1-philmd@linaro.org>
References: <20240703085148.66188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Recent SDHCI expect cards to support the v3.01 spec
to negociate lower I/O voltage. Select it by default.

Versioned machine types with a version of 9.0 or
earlier retain the old default (spec v2.00).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
v43: update versioned machines (danpb)
---
 hw/core/machine.c | 1 +
 hw/sd/sd.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..4377f943d5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    {"sd-card", "spec_version", "2" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b158402704..808dc1cea6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2471,7 +2471,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
-- 
2.41.0


