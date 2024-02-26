Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A07C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reW0m-0004g6-VA; Mon, 26 Feb 2024 03:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW0l-0004eh-CH
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:06:55 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW0j-0001dF-5B
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:06:55 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so32792231fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934811; x=1709539611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scR0cVRlUQ+FFZFfcolEQrGBOQjFaxkZH3KxNR75t0E=;
 b=eYZzuphjZKw3vm3Rf8/6HUtXUzPpf6O1Y/rIvn3QmnlaSKM8PRADxCIU2psatcc667
 MuYVgjp3lf38Kn8NaWbzpDaHAIy1vFiS/AdTHOZyOxUIwwVc1ZtbA4yzoat34yKIkPvU
 g8GDjxGmZNlQu6/9yhiQbm7pG1gMXDeF3WyzcoN1BLN7U17klCnRKM4F/AqIztP7iHd7
 tvYK1wUDo9koPgyU3ysu2qh0xzHcsO6qPRi8tUfvP2j5/5ZyGGna7B3kndBuKipduFDK
 UuxKulDKV1jRFiGudE7t0Gq3AlO1exCEu+kIFfgeEOeZBaj3f/ORr7OQAunBllxwK2Kt
 1L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934811; x=1709539611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scR0cVRlUQ+FFZFfcolEQrGBOQjFaxkZH3KxNR75t0E=;
 b=euTvtk61Rm4lUm73LFhP97VSqtkzJ+1mq7JpTMRtnXr7bTINRDurx6xP1rzsUUkT+G
 VgsFYnwkXHjc/8atp8R4qH/15p6Uq4IkgiVWjcvl+f0p1RPcmIZlydXHV5vrDHPoDXDM
 KP+v32v1XKcamMX/46Ib2siEZvlzwLZXgdcM+r2rl7hea40/XcA+nLQbzAo5MmXyVr8H
 i6YWkYhVERcT+DXzacO6JhoXZYXr/JMpITtDS9Dg50t7dGa6MyT5cs1L21Gxo4SmbBWx
 UcGkUjgFIx5Cbhdo2hET80pc1YQv9dzUMUnl/MOly7U59RI0pRYdtZi+stbv9foIHAfS
 kt5Q==
X-Gm-Message-State: AOJu0Yzy2E9p3X12Yembk1Ez/SOYUmtqooOILlkZli0f6HoDJgLhLOtP
 rjv9xc7ge3QFjTZ8TssTxOFHefDmh7H2rLtHryVWNIug020DWnodTMrtd6WhcHtrFihzAsMrrz3
 h
X-Google-Smtp-Source: AGHT+IHvKCQ/D9Ia7u7jl5WKNzW5hrTeei1SFPL+TV15MHWcDpatxBrkhxEryihDY7WXO9FwQ2F1wA==
X-Received: by 2002:a05:6512:3290:b0:512:dc3d:6bf8 with SMTP id
 p16-20020a056512329000b00512dc3d6bf8mr2955095lfe.56.1708934811087; 
 Mon, 26 Feb 2024 00:06:51 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a056512376100b00512d252759bsm756622lft.212.2024.02.26.00.06.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 00:06:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-block@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 2/3] hw/ide: Remove last two uses of ide/internal.h outside
 of hw/ide/
Date: Mon, 26 Feb 2024 09:06:30 +0100
Message-ID: <20240226080632.9596-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226080632.9596-1-philmd@linaro.org>
References: <20240226080632.9596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
replace them with newly added public header to allow moving internal.h
into hw/ide to really stop exposing it.

Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240223142633.933694E6004@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 {include/hw => hw}/ide/internal.h | 0
 include/hw/misc/macio/macio.h     | 2 +-
 hw/arm/sbsa-ref.c                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {include/hw => hw}/ide/internal.h (100%)

diff --git a/include/hw/ide/internal.h b/hw/ide/internal.h
similarity index 100%
rename from include/hw/ide/internal.h
rename to hw/ide/internal.h
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 86df2c2b60..2b54da6b31 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -28,7 +28,7 @@
 
 #include "hw/char/escc.h"
 #include "hw/pci/pci_device.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/misc/macio/gpio.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 4a59e2fd37..13dde50cba 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,7 +36,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
-- 
2.41.0


