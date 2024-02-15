Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72514C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2U-0001Ed-Fb; Thu, 15 Feb 2024 13:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2P-0000hA-8k
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:45 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2N-0002Jx-If
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:44 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2d7e2e7fe0so220771666b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020041; x=1708624841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdETzWg8sMtllnYJcpe7xJU6Mgoke/FLcBGSchABTcY=;
 b=CTLvtPi1TGn19RPnyO+PoX1Gsm1ioB9587tJsSDWrmc02ysB0ikZKow1xOyTAkGIem
 Cxdo9LdTFIujscwm57NCaYcOqm8fu1m68/wa5W6qe7WTfaaWCL/FUEhkCXNW8TooPtnr
 6LncgT1wkksPYiwXNubkpAQNZkG9bwoyS05yi3HIf5Fygbms/kBXoGtOiLqs95ni5vmh
 Oxgb2SHoadUczkahuRBuNBpNr+j6Gft57tx1Ag8c/JRhhfvJhAC+Mi1tcAVBr4PfdKJP
 1nt3xuwt2S0H0jUWn5JxuwtWqQ1CTxyV1Kj8V6F3ECDGIs+HzJ/0Oj6njscRmDScW3dc
 HKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020041; x=1708624841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdETzWg8sMtllnYJcpe7xJU6Mgoke/FLcBGSchABTcY=;
 b=OpXIptzGoJbpL+MnKNuBD6YMiIjzQx37NBIZBH9FfZ5DRzUnwlWAk3LLNrTLY1XhhI
 CWLAW4U6ugUWjvKfhstXQDU2o9k1ij8sVDUq+Pd/EqmF64iQ3z1p8CPDsPIzmY+EsLXz
 VqhC8MwapuCV1ZjopVXGjrLW3KohipOhb1/MpLP649D40rc3TlNbGFWMS7U48euPDfhB
 gi6la5skiT0vJ9U1b1wKpU5rkJUqEx4xCfWhtIDhq4b5F8ohB8xniR8lKjd9ArbkGTQO
 rwkwW0ah8gcTAuHlPbg8r0URBKPhPVBKmpWQiGEWvmnFmbGIU4+c2FNI87uaCuksWkyq
 dwCA==
X-Gm-Message-State: AOJu0YwQ4oud/0muAYka1pQ8xKdgeypyR9urKQDd5lIqDge7kIoDjKLN
 tRtu4A+2pfO6wwx03RHiYf8uoxgnYIpIB+RZ12pWPz5voVfi0cKjqKpa4VwtQrA4bYYxWeapoAp
 6NRg=
X-Google-Smtp-Source: AGHT+IEP4UD1MBXliZJtL3nWBbp1eYZb2pcj4PwhjNnf/xcKtJQZdDsgv9kffc5IJ5B9N/1KKUGMtQ==
X-Received: by 2002:a17:907:6d0c:b0:a3d:37a4:809d with SMTP id
 sa12-20020a1709076d0c00b00a3d37a4809dmr6462232ejc.7.1708020041080; 
 Thu, 15 Feb 2024 10:00:41 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 fj5-20020a1709069c8500b00a3d310a2684sm783255ejc.158.2024.02.15.10.00.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PULL 25/56] hw/sh4/r2d: Realize IDE controller before accessing it
Date: Thu, 15 Feb 2024 18:57:19 +0100
Message-ID: <20240215175752.82828-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-8-philmd@linaro.org>
---
 hw/sh4/r2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e9f316a6ce..c73e8f49b8 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -285,9 +285,9 @@ static void r2d_init(MachineState *machine)
     dinfo = drive_get(IF_IDE, 0, 0);
     dev = qdev_new("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
     sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     sysbus_mmio_map(busdev, 0, 0x14001000);
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
-- 
2.41.0


