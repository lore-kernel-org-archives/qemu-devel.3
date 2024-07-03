Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0HL-00038h-FY; Wed, 03 Jul 2024 09:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HI-00037Z-QK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HH-0005FT-8u
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42579b60af1so31800655e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720014245; x=1720619045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksCXrweICvZdx6I7fdFmk6nUZAJxdczj1oDiparfm0I=;
 b=rQKG4sOB5Q45U1BWziC5XjWgTPX+Y6vaMlIsX/D8q/h+7jNBeK8blWNH6RGidkY852
 HfUwK3YF7QZoICfkIKI8+z/d4fGPkWQ4lQF1T80yfjPJWFMDr+8aQ5Z/KarNfcq91e7w
 D0nNdAyMDItR2XxFfnsX1DUwd3GAaqRwQyNCBXyeJPQopPHO+U/Bre0Y0TLB6D+89MXg
 3J5euuNr4tqDGs7f7tYVa0qJ0Lrarpsi5YRdoiG0yqDa+7U+fTNY8se/kmRv7cQzGBZw
 RiPb8PHlIoKD/09pJh4O1S3s7Bs3UimHqx8AgGN8d2zsi2x0sUNvxg7l3BNwLxWTsmxf
 MOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014245; x=1720619045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksCXrweICvZdx6I7fdFmk6nUZAJxdczj1oDiparfm0I=;
 b=vbdHYRxQZjf+vOCWKeO58sS93dVcarv4qWVtK8HOrnfeZ7Y38cbQqr93o44HlwGXoL
 OX4cO2b97Z5ffo8MwlVIAV3E2KnCjHi32ZzDyyJ01KWFbJnzll2PafyKYprMh9pzB7u+
 u1hUvtILmccAFEYM9ox3m8tF6xYqgONt6y2WQefRoaoOVQ1l1qSNYmIYBecz90NcHNzv
 3YJyK2DhsHU0lS1LyFD4M/30bkEGbKR+W2HvGAFszikCdhD4tMiq4TAUiTj1DMLjbjlB
 AUQ7PQQxATYXKnPhn2RlhgpV5SuMnKD5EcoyJe/jBBXRZGVCSEvFO45LlYQvGwRenLVP
 WJYA==
X-Gm-Message-State: AOJu0YzZKwCarZ1pTshPLRonMGRDIGHdgipmxsIT6Vjrt63fVMw+qPwU
 G/slWLhW53QPP8gp/DDZK9lvL6QGGDBKZHkOE4QnqXLlE2pjaQJrNyVfe7Tm1fyJFf+Q0LsN2q6
 5
X-Google-Smtp-Source: AGHT+IERCRKXg5Zc25HhZE+waas+qAvjhaxApwatw41X0FEd+JkV5vBIy7WCkYHa0FLKo7FDbDnR3g==
X-Received: by 2002:a05:6000:24d:b0:367:8f29:f7ae with SMTP id
 ffacd0b85a97d-3678f29f8f6mr2046634f8f.49.1720014245561; 
 Wed, 03 Jul 2024 06:44:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367908768b4sm2423037f8f.79.2024.07.03.06.44.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 06:44:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v46 1/5] hw/sd/sdcard: Use spec v3.01 by default
Date: Wed,  3 Jul 2024 15:43:52 +0200
Message-ID: <20240703134356.85972-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
References: <20240703134356.85972-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: Daniel P . Berrangé <berrange@redhat.com>
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
index 53767beaf8..a08a452d81 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2471,7 +2471,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.41.0


