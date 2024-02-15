Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3B3C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2W-0001Xh-GK; Thu, 15 Feb 2024 13:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2N-0000NS-Fq
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:43 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag28-0002GS-9K
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:42 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so1531361a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020026; x=1708624826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZUd6/1kYGen5lB4knuCMVyKmswwesM/uAr4O9mJTQg=;
 b=SA8G65Y56wRAXmO8A3ICXug6xEnHY33sCFEVViJl38c0ble3TU4JxypZw23y6zocIX
 4WIttb148q42pR/nJ+J4Vmi11lLEqdDU++ZypVvkpMdb0IC6qWrRXNALRnJOsTjLVrUH
 sMxTDw0XPkTYOOGt9KHlhrxf+jgZQk15wqZ5ojyuf3x0v39EzlL7fqkPv2Lps8FABWRS
 1slz8/7wxgZXXf0fw/qSUe+0q85d9Y5NDM8TnA+r9BzXRElOcsKgRLrJ0UYO7rmm6Kwj
 YYN3vz0xpSEykW2rc77yTGiiBuEFgbARdNHP5Mc9M15yC/7wWmDMFWf9PifAmfAegSmo
 hb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020026; x=1708624826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZUd6/1kYGen5lB4knuCMVyKmswwesM/uAr4O9mJTQg=;
 b=kL/JYaC2CScRyercQZsYf8GMQlC7Rtna2YjsQvxCVPFM7bRjJMpFAjttdo8gaJoEZv
 y6to4ny5+ZLc3pWCZ3Q1bfCiRyeOmLaiEWZNTvJkOvuoGLd3hZbLYS1mh+Ftv+O2py65
 uEbdT4BeM10HLPFfEWrOe7fVH3/vJkXz6ZtBsQ1sXrKVHmI+FuWQ+K1mrtUZ1F1qB8Fj
 IlQE7PPYF65u0Chhb80sEdIqPdzJoJ6lFpvTWRwK4zR1ApiKguHM7jYv6xvptMz1Jfxy
 WlGVt6DiChjPgMdoz52dMsdoor3ScW8wx68QWVRrnEFIvg5Bsiaz7ctOPCZVhq7zafXE
 7P5g==
X-Gm-Message-State: AOJu0YyumqnziS/iEP4PbIJTUrive/F5MBVHmhnnMloF65uztgEVLTW2
 esYXHE8TAvpkiuJUotHuBCaj+eR17kJVEndvSAdhyfEtsJWO9bD5TkOecd22Q4ObePEOR04PrLt
 4L8k=
X-Google-Smtp-Source: AGHT+IFYgT+vDDL+L1xB5c0sCQGa2OQVdXXtbXz5kplU+491xWn7Mej0G4LpglrEhInReehmQEU2Eg==
X-Received: by 2002:a17:906:eb4a:b0:a3d:302e:268 with SMTP id
 mc10-20020a170906eb4a00b00a3d302e0268mr2001781ejb.45.1708020026223; 
 Thu, 15 Feb 2024 10:00:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 t21-20020a1709060c5500b00a3d29f0afeasm782742ejf.2.2024.02.15.10.00.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PULL 23/56] hw/ppc/prep: Realize ISA bridge before accessing it
Date: Thu, 15 Feb 2024 18:57:17 +0100
Message-ID: <20240215175752.82828-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-6-philmd@linaro.org>
---
 hw/ppc/prep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 1a6cd05c61..4eb5477069 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -278,9 +278,9 @@ static void ibm_40p_init(MachineState *machine)
 
     /* PCI -> ISA bridge */
     i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
+    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
     qdev_connect_gpio_out(i82378_dev, 0,
                           qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
-    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
 
     sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
-- 
2.41.0


