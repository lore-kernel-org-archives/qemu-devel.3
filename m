Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962F8C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeD-0007ux-Ie; Thu, 15 Feb 2024 12:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeB-0007uO-Rn
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafe9-0003tf-PC
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:43 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41202eae372so9216705e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018540; x=1708623340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gdK902k3mV/+S1hCWShYjttM//ciaEE1vsEEQ2RlFOg=;
 b=DTrWRloIUVzK8uvonH9TuEYLHga5LzQI5RxWwIqRyajeFjAPd1PmDvKORFuPmmO9ww
 UAJIEOmpLxk6U9BNlIvwZwfEZjzuvSbGwf17IL+DvgFcXszlR8Vr7sNThcCU/fFP6JtR
 08XVuV5gkEnEPVQPQHd5LyHXwKoJvDOFMkxTlZffFOCnUv4TbLf25tLJHeTQARvAjEZS
 VvnCTDjhHf9Zk7hFxfydsZKPfvacqazvGSjHSDvRZwcaP7FgwdYadki+mQUh7Yr2dUpG
 rvKhYPknrdDqoDJO0P5jH/pqLRXYFDF4W2KwIDtlZk/a3CTX658CXnQbQSXVaeTVldv3
 rCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018540; x=1708623340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdK902k3mV/+S1hCWShYjttM//ciaEE1vsEEQ2RlFOg=;
 b=InWUDgiliTBEV45wZiTuyEZBj9kTjg6E51f/BKmysiljkDkoEbgbPPk5zGQNLxDuJv
 TpgNfs7geD9YD23n4LFVaglemeedQLcE3zQKgm+SOIW26QL4Zx1goDba3RquKuuWfUiw
 jKl9jkIIWeaQxGlDzTEVUeR9rCJro2eH5ubCNcoXKAd+5l2ig2C+gVF68b/EwwpALaXF
 YtmlS1KfV3JXdXKZp+39n7CNhngHK40feOKVpoON9eoJ/n7oCr9sZ8Is3Kq+NUTBVclX
 +LoR/mK8DWr1w33AR91hHeG2kvGhknYFpxBAyFJhCnglvKL4hJDXIc2RY2eNJN0gGiOB
 DqEQ==
X-Gm-Message-State: AOJu0YxVLJTkwZ/C6vfKVEEV9HlIQJOaE7XJUmfrP0XwqHhsYH8Qtgrd
 YOe76IRSrueqUkX2KQP0W10xb8dMGM0XdbVccLb8X6hk5cRCQAPX56npNix/DpTMD+RzuQNfRpG
 l
X-Google-Smtp-Source: AGHT+IED+GoFtSaRxuqsb2GMFmVQqRhCjpC7uHVBBptH6em8wz/hWXoVSF9jND+8TX/SU+Z/d/OSlw==
X-Received: by 2002:a5d:5258:0:b0:33a:ff6f:744e with SMTP id
 k24-20020a5d5258000000b0033aff6f744emr1869868wrc.18.1708018540274; 
 Thu, 15 Feb 2024 09:35:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/35] hw/arm/xilinx_zynq: Wire FIQ between CPU <> GIC
Date: Thu, 15 Feb 2024 17:35:04 +0000
Message-Id: <20240215173538.2430599-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Similarly to commits dadbb58f59..5ae79fe825 for other ARM boards,
connect FIQ output of the GIC CPU interfaces to the CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240130152548.17855-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index a41a118346b..fc3abcbe88b 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -243,6 +243,8 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
+    sysbus_connect_irq(busdev, 1,
+                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ));
 
     for (n = 0; n < 64; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
-- 
2.34.1


