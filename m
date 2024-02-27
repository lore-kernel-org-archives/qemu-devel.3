Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57507C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaD-0000gA-JE; Tue, 27 Feb 2024 08:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaC-0000fg-7k
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaA-0002pZ-Mf
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412af664954so3095865e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040796; x=1709645596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HnAhjwsLeVDki2L/dt5NeuP6uPlgrzrYPZ3yiJ+bVUI=;
 b=DnON/gmSoxwumDZLHdcn4hXFbVV9C1NrkczKnNSDJvAe6xfGmvRa1dhlMNLsMB4eFc
 2t9MrRFXfhTorqdkMyTrdfkInIgRyDhcxXkyK2LpywqScGSI1CfGowDAvlWSPjr8YrvB
 w4ygDaXWmJi0tNxk2+0pxdtEi26AemXCLMbfvBojoRSCNwb6MOc7PrqFHvqktKo71kOY
 A1Q1puwOYDD81WuCA1sluDNFohXx71xnCBX+bMbzOQzcd4KmExBHFjDKZTfP0COSGW01
 ghRiVcqCO6QE7Y9WmyLTVM+w66ofXq5dY/wKo/dIK3iCpOjNYSFgk9F+ZaQpbRRxyE56
 c0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040796; x=1709645596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnAhjwsLeVDki2L/dt5NeuP6uPlgrzrYPZ3yiJ+bVUI=;
 b=vnqRZKc7KF/CTkasa5E0S9eUb4j+d2CgIFKBMkPZS6VP+Sbe0ttP5HtByiCgdvPe+H
 H8kZpyBuRBtrW7zY3ptbmdPq/221DRYefpXMrdiFCshZiNuzT3O61a5bCal4RA856iJ1
 c8/ckVvyeKaLpaAcsakEpLup9uzCGQPmieBiC5A6+trk82virZ9099SIB9HpNAZ0+AP8
 YDplFu3yHrmmuAyKmqRqOAqf5DbuZZxhfuk1KzL1ReIM33JG9xhbdApB8M8v+8xZrzbj
 OGWT7iRhWSujZpypF0yu0fbwfkJDDxhiA1icYkHPh194Q2X+6yl1q1I2OAfOfJ5EUvpt
 Vqqw==
X-Gm-Message-State: AOJu0YzHKZ+5jde2/dBmxd43e6/MHNIHWwvmPyi3/xu/tra/JIfG6RZv
 thcqaMfxoyd9Mznw6hT2BsyWNHRfilxwp/OU8yA8j0EJl1tNeCWWwQRhXZ+dFgqRA6BBuDNJg1X
 v
X-Google-Smtp-Source: AGHT+IFwdTz/xOYJKLaGei6mAibgcCxZd4rKmG1CWam5qiFe4d7eYuvS1vL8WIOjQsCU9WWC93SkbA==
X-Received: by 2002:a05:600c:5114:b0:412:9830:a259 with SMTP id
 o20-20020a05600c511400b004129830a259mr7500297wms.25.1709040796713; 
 Tue, 27 Feb 2024 05:33:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/45] hw/arm/sbsa-ref: Simplify init since PCIe is always
 enabled
Date: Tue, 27 Feb 2024 13:32:30 +0000
Message-Id: <20240227133314.1721857-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

There is no point in checking do we have PCIe if first thing after check
is adding PCIe card without checking.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240215153311.186772-1-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 13dde50cba2..f5709d6c141 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -664,9 +664,8 @@ static void create_pcie(SBSAMachineState *sms)
     }
 
     pci = PCI_HOST_BRIDGE(dev);
-    if (pci->bus) {
-        pci_init_nic_devices(pci->bus, mc->default_nic);
-    }
+
+    pci_init_nic_devices(pci->bus, mc->default_nic);
 
     pci_create_simple(pci->bus, -1, "bochs-display");
 
-- 
2.34.1


