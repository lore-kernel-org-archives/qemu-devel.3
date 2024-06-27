Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A54C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsgH-0003Rx-3D; Thu, 27 Jun 2024 13:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgE-0003G5-BN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:13:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgC-0002Na-MY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:13:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so11170925e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508383; x=1720113183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3emiqbeR1uOJll/QBrY7vV5cW8ivGXHg4omZJGkoiU=;
 b=X3gA2FEqoIiqf/6sogkO646PfmZnu4YhlbFdXDAQFGGI2tRoxRMU/UFWB80F4qp1uS
 OZIs/YQD/n33kHNilI1gLpvx8Rg11nPWQVUXb8LIPRWvAOaasiEbrnBxjaZcp82bEaKy
 7TPf6C7JZmT16XFHj8gPvAAlYsPUNfVwdSu+l11tUz/xxjmIqIcFFJnIItye2eeRrrvV
 DFGixO8S0bwL+UtrVaX/5i3XaB8AoXI2iwAnyO0f6S3TOqBsRJsdkpd7WqqmFGO1NH26
 vPiqj9MYoBE51OS9IivE7OnOXeJok/eiVC7tEGiw0RCw37iePpfFNvPryAGxwZd19GE0
 5cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508383; x=1720113183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3emiqbeR1uOJll/QBrY7vV5cW8ivGXHg4omZJGkoiU=;
 b=guLpbkcOCAU6ZufSxrXq6I39z0NMUd/2SoZL/fGqerCm9cao4jkvDBaIMR+kKv/BT0
 67gVnGRQgVXmsKzNLm138ePWXoFobzkjVa1KnVo5k3z4lpfVwdq5tfygoZaumGDtFgMU
 4Hx4PI1kMz95v6LTGB5uEmu15f82OcJFh3+T9BK5Z8LHGh4YCh6jCAHn/lMRacF+h3v1
 DBOagZ46RD9GynbSe62hNrotuYYRl12VC/6iSvafM20t6zMyI0YGOq/j/GYS01+OUbLV
 /SArmD3ymmAbuK1Z5D9iqCxjUdQzabTES5d8APqc7xZYQfHydRjwTSom2UiBMZUlFrh3
 18bQ==
X-Gm-Message-State: AOJu0YyUumpqL6JiT4YRqIWeRHNDHZbZe9kuwZ5jHyBjWm92JkdCkIH4
 pUflbH7Ewokpp8S+0wa/zsV+D11PDWepV4jD2Qw7cChOBt+79NuB7mDWiIqMJzsV9ZXkLyDfwc2
 Uwu0=
X-Google-Smtp-Source: AGHT+IFNU45auTJRyUA+s5bP25FEgBmHPgM8yfwvljy+QAXUT+NyJ7KeDTE3ysMa5uWZKvA9A9eB4Q==
X-Received: by 2002:a05:600c:3782:b0:425:64c5:5750 with SMTP id
 5b1f17b1804b1-42564c558f6mr15758255e9.7.1719508382842; 
 Thu, 27 Jun 2024 10:13:02 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c15f8sm550105e9.47.2024.06.27.10.12.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:13:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 11/19] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
Date: Thu, 27 Jun 2024 19:10:51 +0200
Message-ID: <20240627171059.84349-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

When booting U-boot/Linux on Aspeed boards via eMMC,
some commands don't behave as expected from the spec.

Add the 'x-aspeed-emmc-kludge' property to allow non
standard uses until we figure out the reasons.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd77853419..dc692fe1fa 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -127,6 +127,7 @@ struct SDState {
 
     uint8_t spec_version;
     BlockBackend *blk;
+    bool aspeed_emmc_kludge;
 
     const SDProto *proto;
 
@@ -2567,6 +2568,8 @@ static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
+    DEFINE_PROP_BOOL("x-aspeed-emmc-kludge", SDState,
+                     aspeed_emmc_kludge, false),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
      * board to ensure that ssi transfers only occur when the chip select
-- 
2.41.0


