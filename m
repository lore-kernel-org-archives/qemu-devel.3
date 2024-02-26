Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6E7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwq-0001I8-Pi; Mon, 26 Feb 2024 06:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwp-0001Gx-Cj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:03 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwk-0008Td-Ua
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:03 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512fb30dbc9so882386e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946097; x=1709550897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TigdV5o9U2RQOXS96IAt9eTEOL4XXPfJaJK2cWAa5tc=;
 b=JiYzeFN6IcMsr85i2AppNruUhCx4XRyZMaBkz3K9CPgtKXQRZ59fXQasRc1C16caxw
 zucdTF5BF2D3wyyZNmXyW0RpC3uJwzkSkcRM1rD6RW6dP/OmEEviWAXaCyHqy4LgX1CY
 14WU7nVrWoPl/BuN9f4IB9yKBR6YyuMWXF+wpUGFz1WAAV4F+wMi2xHWp+ZgfMOgR/1X
 UKm0uQ61Gclxvl05t5c2hAtSH49Q/imEbvJbZoT7Kw9YzdfQD2egllcaCK0i6BqUUEHD
 zchRHRf63ZWIOxskoUAW2TNctOqQ84uthbQNcsJm5Qcj6Ffpo+jB9XZ/GxEpRjN1V+vE
 Afuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946097; x=1709550897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TigdV5o9U2RQOXS96IAt9eTEOL4XXPfJaJK2cWAa5tc=;
 b=dudK9NN8evMOwO8eD8vmRudWg2hk5oeC5ttdT7ReWuei4yrFjkTZ3ltL0OEYfKje7b
 VrOKwcLoQCrpWt5lQ+qCxcBTjdmYonz88mU2/O/XPJ0sOso9kkPTAS5feV+Nf65GVDvr
 33+Hdhsseqddwa9/S7etrRf31Nf68D/gyc2oNiB+oiP70X7dpGX0wFpd0LPE73Lsy4We
 v2dYIYWpke9ZRbnL8SPPUiGCMFN+3kZCS1ms8jyHMEc9sJPvW3sWyxdkXgt1o4FB/5lA
 SP7EdS6qLMtD31xamFzzCy6DzWN/Y91hSAZjVEaGbQT5Hjsdkox8F6s/LDQCV/u8YzUc
 OKTw==
X-Gm-Message-State: AOJu0YxlisNt45y2Zk6A7VMnN1D1zg+l8p2tPKNoR7eetHPVzip1VwsU
 iUIpv4qXF0avGvc0Mqj59OxMhd5tvaIphZz50Txp3K9Ponnmnv3LyHNiz3Gfx2Ddl4lAfp5IsW2
 f
X-Google-Smtp-Source: AGHT+IEBnqjD6zs6CrSNLxvyWNO0CgoOrS55AUsQ8EO8yOauMI9sYEzf6JTjtpvvGuTnorfBRkNDSw==
X-Received: by 2002:a05:6512:1599:b0:512:e594:885f with SMTP id
 bp25-20020a056512159900b00512e594885fmr4691679lfb.55.1708946096682; 
 Mon, 26 Feb 2024 03:14:56 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b004128f41a13fsm8040564wmo.38.2024.02.26.03.14.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/15] hw/ide: Rename ich.c -> ich9_ahci.c
Date: Mon, 26 Feb 2024 12:14:05 +0100
Message-ID: <20240226111416.39217-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Most ICH9-related files use the 'ich9_' prefix.
Mention 'AHCI' in the file name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/{ich.c => ich9_ahci.c} | 0
 hw/ide/meson.build            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/ide/{ich.c => ich9_ahci.c} (100%)

diff --git a/hw/ide/ich.c b/hw/ide/ich9_ahci.c
similarity index 100%
rename from hw/ide/ich.c
rename to hw/ide/ich9_ahci.c
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index d09705cac0..2a7cd8405d 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -1,5 +1,5 @@
 system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
-system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
+system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich9_ahci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
 system_ss.add(when: 'CONFIG_IDE_BUS', if_true: files('ide-bus.c'))
 system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
-- 
2.41.0


