Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2165C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2R-0000x2-Uv; Thu, 15 Feb 2024 13:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2K-00007t-PP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:41 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2F-0002IQ-Vi
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:39 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5600c43caddso1403496a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020034; x=1708624834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXfzEOj0hY/4x5MiiqGGaWqtsIu6euoUBioh29pYX9I=;
 b=xHbrDOkqODeWueV0VkFu97pTrV6wGWnI+WNPWo64qHXEcDBlG8mxeTKsixoglCKYld
 IIYLiaQAgXwSRYIrWLNHdtEaTTcyjlN/ZYEaMzC5dh7LCJEBn5csR3gULM9o00K5cB9B
 wcp1OlyACoAwOj3MUS54PZUhUzzMLYIJUnCADp8hdPq4cc1Wb3Ag4X3/6pNYpSDHIbm+
 lnGCfKSP+pZBOhfP7KnWy5RfOc5DhLJt43Z1MuM8X8Jmfx16OrlC8X6o5s//9/l4aoGv
 paoprbcHKLiX+sfC8g0o34r/AszSCv4ZUdEv0lKIwBU7EddD5U1b985PphsSq0DXmEma
 FFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020034; x=1708624834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXfzEOj0hY/4x5MiiqGGaWqtsIu6euoUBioh29pYX9I=;
 b=KzCV8eVGp9tmAMAAKt/zKbCzkbe0lzwA3EAE1KEmImxbhK5JJeH+e6qGeCDWl7Vd9N
 KEnTfQ9lAnNx3kQbTealCuHIv5bVUPZ8v/o9Blrv/cuVlbQCMHDEHrZDQRDICYwFUKsC
 6h8pfy1F11wfLyEZxGAK9liceCegpEpOKcS9MnFEtXOnA0OvyEL8o5mivYyVH47ktq9r
 n/3I6Qu7Fi8zdXDgML8GO87Z5+ztkuCklgcuXSEMdW9rUJqdUmWOj2NoHrTHvGRfi/7m
 iTEfoEJpejyl+RQJ635sIHTxfYPnGn8fGNYZYz/ydVV9QmMwuQgIizgfaDrEaWgOo+sH
 fdyQ==
X-Gm-Message-State: AOJu0YylHqkVFgCKSo66sbFHFPYK0g3lFMQEocdxxu7OOxPsBY1jDbFy
 lm6eGOX8IwFgsa4xz0xjgvBh1c7cu+vlEK3zNufvgLIl2LV0rdjaGAxKJPep5w7GHMq05ugJsH/
 pda8=
X-Google-Smtp-Source: AGHT+IEmZriUbrMzuMUn5LRrLeqtXigt31ovYC1bHeAUNfxOATbg3ZOAe9WNcd9RRATdMUwVie99JQ==
X-Received: by 2002:a17:906:b0d9:b0:a3d:2243:29da with SMTP id
 bk25-20020a170906b0d900b00a3d224329damr1812382ejb.36.1708020033980; 
 Thu, 15 Feb 2024 10:00:33 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a170906670700b00a3d2d81daafsm791088ejp.172.2024.02.15.10.00.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/56] hw/misc/macio: Realize IDE controller before accessing it
Date: Thu, 15 Feb 2024 18:57:18 +0100
Message-ID: <20240215175752.82828-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-7-philmd@linaro.org>
---
 hw/misc/macio/macio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index c9f22f8515..3f449f91c0 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -123,14 +123,17 @@ static bool macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(ide);
 
-    sysbus_connect_irq(sbd, 0, irq0);
-    sysbus_connect_irq(sbd, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
     object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
                              &error_abort);
     macio_ide_register_dma(ide);
+    if (!qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp)) {
+        return false;
+    }
+    sysbus_connect_irq(sbd, 0, irq0);
+    sysbus_connect_irq(sbd, 1, irq1);
 
-    return qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
+    return true;
 }
 
 static void macio_oldworld_realize(PCIDevice *d, Error **errp)
-- 
2.41.0


