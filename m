Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C804C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRM1-000282-K5; Thu, 16 Jan 2025 10:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLt-00021r-KZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:09 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLs-0008WJ-45
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so978404f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039606; x=1737644406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=su0CZjE/5ewS32kCJYLrA1GOf40qLVdjf6VbZ1IHg8M=;
 b=nWnCKHWkJiGnnISfTdsXdywkWElwOhJDH2klqHmdbrX9yKVmdVJ4LYMdSyfGzsnBUE
 4NfhTnmm5qe2qRGwcoWPKo+mcAXSnsohmRQlgg3iWQAxG2gYT/ggx8mw9c+OlODfSouW
 S55FDqdJ32LuaCzNY9aBkzWvRONccdQz02tqU3VLK9ShdCjSY/NNyGE79XEstx5yrJ0V
 /dwrlnygm0ZgzkmSdH/sOXHW5a2jdr3W7yKycQG9oeofF6tAMiiy3/7iUW+lmWxE3j5F
 26uAsAEdrDKjZgEi38lCwXtHXlvnyxRpgQCShAi+gdte1L8a9suVeB3M61Me4wm/u2i8
 8G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039606; x=1737644406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su0CZjE/5ewS32kCJYLrA1GOf40qLVdjf6VbZ1IHg8M=;
 b=AvsyI9bZ3C7+x3JyDxfGUPDyh1F5lRJ3opX/DwFSGGl/p/xPD7jMqjJ2qij8gvQbbK
 zNRigPbJeazk/2wlMS5bwgS9xLz4rRRFvVxJnr+BhffjmaxdkpchDU2QmnL2u7GRO3Bd
 Jys6HfhISY79TagRlSENrnvlI3xdHdSZXKzPtwl9Ng73G4xxkYNElgbX6KB+7mxU0Zhn
 JiFDTir1J8gjahNHKBsYFpQ77lUjd3OfesTlMHCPjg2f6kTFZKNuXtHYEpPb2NGP+eDe
 ikImO/67nGjgNp1nNeBdwGrMAJBU+aTc8cPh5XWmVtZqWSbQBw73SgUstASVfCOzhyKZ
 FFMg==
X-Gm-Message-State: AOJu0Yx+aNMlO/1No3kdBK9M2nQqPeAu5hMPOUc201iq5weBBlpTqEpu
 FPYq4s6OaBdsEisPD/412oN1q+EY5/yTkclwCz8ttNsjsY/wTe5Xrjnr43VhTcNafnAD3hjOUNj
 Gfh4=
X-Gm-Gg: ASbGncv86nxZTNono75dmTBZnEIzCBGeO4vcI+QgE+2E6Rj3xxP54Ydf/Mg+Lag9QGk
 ESNxqQU5KzEBBtQQMXCghQ27UPvgfYnV7sS0PUsf8V1DwfkwPCeUODpOv6QugY4g13e9IX/ifs+
 c8uDj+bYCmw/LVTs/AdEPTbpDJBxq169CrFZwu9BhxeEB/KZKjKTMxtBHQ0bJZFSsX/79R9wrNH
 9UVwRu8mdASG5JLacqD46LRY6mShFjavN3vNi3wfPuTG+yVyTvqzGaXb+Ax+BJcnfsBxwGLl6RG
 r3fH0m9CkxdGD9dJTtfrKNSbkFyMW9c=
X-Google-Smtp-Source: AGHT+IEspvXms/1IclnMKzWLHVNSmlB1NvH1bB0X10sQK1RqiO4SP/5KgHkDKH6dNcFgfV0hyGp4Uw==
X-Received: by 2002:a5d:5e8a:0:b0:386:3918:16b1 with SMTP id
 ffacd0b85a97d-38a8730fc4bmr33835844f8f.39.1737039606201; 
 Thu, 16 Jan 2025 07:00:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32150a6sm95726f8f.15.2025.01.16.07.00.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 04/13] hw/arm/virt: Remove deprecated virt-2.7
 machine
Date: Thu, 16 Jan 2025 15:59:35 +0100
Message-ID: <20250116145944.38028-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 53f4a96e517..eb27305dcd3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3589,16 +3589,3 @@ static void virt_machine_2_8_options(MachineClass *mc)
     vmc->claim_edge_triggered_timers = true;
 }
 DEFINE_VIRT_MACHINE(2, 8)
-
-static void virt_machine_2_7_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_8_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    /* ITS was introduced with 2.8 */
-    vmc->no_its = true;
-    /* Stick with 1K pages for migration compatibility */
-    mc->minimum_page_bits = 0;
-}
-DEFINE_VIRT_MACHINE(2, 7)
-- 
2.47.1


