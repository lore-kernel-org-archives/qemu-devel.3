Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31418D26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeR-0000fo-Cm; Tue, 20 Jan 2026 13:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeC-00007H-3O
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:13 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeA-0006HS-Kq
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so4902985f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934409; x=1769539209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rHYnLcWqPL3nm1YZeMaij1EJHr7gqZmxOOXoEH5DQLI=;
 b=I5tmBOtNEhmAAOV567C3m/mmdSOwb8t+yvpoWHLYL4arFZ4HA5bOvN41qMsV8gejA1
 VhINS73Mg7OQ+dWlxkiF+iWCZ5dQa2j1ityv9DdMrR6x/V6aOD7gxbGzz2rHt0cy9jMA
 6TSE/wo69l9e67eJFm0PGlJArFzNXsJeQmmSzBYHFUV0otI1q+H44X4usEyeHynweSGT
 2aoPut0WguYaa5LJL2FepLxi7cSw4rXcepL+FPLLcgIEuesn39/MZ/R1i2/cQHVSyUmn
 d4mncG+ECLjvCC0Wa4KUnnbyvK0lKnrqSurk39Pzbb6HLnicWKnZ+uBra2Fayrjq9z3I
 p4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934409; x=1769539209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rHYnLcWqPL3nm1YZeMaij1EJHr7gqZmxOOXoEH5DQLI=;
 b=JKEmBXBtt+twgZpgthHkhbBmPwWHd4OGcsFupaa8CmjFxo97ktHZEf88equ0cqa689
 aqP2DZw1YXDNMPUyVX6hzlOAuzOUJkf2IOCTC+hp0cLvlbO345ZsMYKpCIVygSMpFTJ9
 dzhEIM2UuwI+3RNL8NYvpG5YwDihRSv3DEucFjwU8yu4Shdb9BWPtvu80h9UuI8jyCPL
 BKdZ/hWurGS8rv4S8IEjhvGwF+TL56T2CHdv8yosxh/iwGh4T+RywPvH9sepBNpeNFLt
 Fp1cCtwdb1V+N/YVJcY72yvzvW/a3pfO7I16vtbQPgigfljTOopZPiFePvl8ZxYzMdIJ
 2FXA==
X-Gm-Message-State: AOJu0Yx1ket7sewbCcq1DlcTOy+J7eL/rgGYas6Q0b9gGm7nSszCBXfY
 CzO9plhSZNzPiFcTRaeov8leq876b7gvGl63f7OH0K3o5t/TpuHsfWrM3X5y1mI7x7N+6ICdpRF
 QdJvSHjQ=
X-Gm-Gg: AZuq6aJZ4WeBonNGddpKSvSv8ft542eP+5eH25ulgJfa6MUUS6ZfBylNRckjE/u2KtA
 NZEyeHCC/1dl4Ousfxj/BqRRaWoZt5GEC+2kzGeb4LrCLvc/8gW0iOjToOCKbSSJ9RTcmq4C4uk
 UWfB67o4202wcvF/4Q0/usW/MgJFlVJ13oyBtjmOJHnNCHqWyfpLED3QI/CkhUzZ4dYiF+Xg2if
 uuh1xmKm1Hlw6TZG7h/RnTK61fk5GdhBGLWu0dv6c2YmJ5KO876JHT3wqw8fjB9vxyFEwNzQo3B
 wA0zWYSPuh4I9vWAuKtr+hc2IihpgzgCcZdvF6kDhxNPQMFo4rhlT9FmjSfkD6KSvr4/v02LbEP
 6AqQey66+sqMQ02/OvO8TDiEWsyohgFPL77ayMfS4g+++bgYtusEFGO67iGjdgoiXjVqwyPIWQb
 LN3EDT9g+7bj6/EdfrDOg5ovqSfjA5zM4sVOWbkfGUIJLRQRK9ELDcYsy85Yzi
X-Received: by 2002:a05:6000:2002:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-435930a65c8mr4482016f8f.53.1768934408646; 
 Tue, 20 Jan 2026 10:40:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm31461782f8f.22.2026.01.20.10.40.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/29] hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement
 sd-spec-version 3 by default
Date: Tue, 20 Jan 2026 19:38:42 +0100
Message-ID: <20260120183902.73845-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Fixes TYPE_FSL_IMX6UL, TYPE_FSL_IMX7, and TYPE_FSL_IMX8MP to implement
version 3 of the SD specification.

Note that TYPE_FSL_IMX6 already had "sd-spec-version" set accordingly and
that TYPE_FSL_IMX25 correctly sets the same property to version 2 since the
real hardware is an eSDHC which is the uSDHC's predecessor.

Fixes: fd1e5c817964 ("sdhci: Add i.MX specific subtype of SDHCI")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 9146e0cde06..23d8f7cbc8d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1884,9 +1884,11 @@ static const MemoryRegionOps usdhc_mmio_ops = {
 static void imx_usdhc_init(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
+    DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
 /* --- qdev Samsung s3c --- */
-- 
2.52.0


