Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE0C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0R-0002Ep-CP; Tue, 25 Mar 2025 18:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0E-0001MP-VS
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0B-000724-7r
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso56970665e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942645; x=1743547445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9/STNz6nQDMG9kyJBqDX5R7dSuwG1jTpb/QPXoh7r8=;
 b=s2ZTPOPJs+eqBeYXrVm110GfrZ8gpa+8maI8Vfn8yUdQawg+foKJJSYzCGHkpgVYN/
 yai6KOOfE6h8lI75Xzg4TT3iGnDNo9hjiyJLBsvWYjV64lpxWXVEvIuqzQmh5Wa4xxBz
 5TC88HjQeogoy/zKdPglzdxBP3zageHuWpXs5MMD1cM9QTTOTDC8cpOUN9qSHwPnjq/c
 EyqfmcjEXFWn3oXkvmS4ivdfYKtdoitkTBGUrlkciqRhgRiMwWoOvZxfaMeSZndLQ33W
 A9+OMQtbCSZL63OHfdu7YHVtMYv2aKeDJgDXAHceXPBirNNht0Fje+aDA9XUgmUs4l91
 9x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942645; x=1743547445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9/STNz6nQDMG9kyJBqDX5R7dSuwG1jTpb/QPXoh7r8=;
 b=P3Z/S5SZyqoo834xYQIvIGX50eUDUWObry6puM5UnRNYqmcSK4b8LjztdY+7Jc7VVq
 saXyL+fxCRVsOJY6s9JCJDsr33N0QvVKYgQKKrNc64feWN7RzK5hqNsPgLfpa7bHQbGG
 k/6D93SpTgqRVFXxsDvvh0wjDn1ojaCOFpMwc0DeggWZusIpU3Tq5xS6wVncKfIjWYC9
 mXCTkseL8x8wbr0ofoRRCuW5YhBjsQK5TNOnITPFFlFBENdqe5m0SErNr7r9h9O9AoSb
 zTuX2LbYXN121ohOmtNTitjd1IdRzSTKTAsKQv+zKrux+ZnLAinMoqPIYqL/uc1Pxq1+
 aqPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8FhNZGgf/cLOJ1YUdFL0y6jLu362G6YN5NHukIMqzszTExZS63hENtolaa5c0rXRLa0XR+XwC3i9h@nongnu.org
X-Gm-Message-State: AOJu0YxiB4RW0Wur7f55cWY7GMtDxyC8imYZeJz+PcfVnpt6HPfWCjr8
 n6OfauadMI1pLH1CTz1WhWrevIOcTbbF1VDn0fAn2VFS9aLrHFcbrqrg/t4lVgs=
X-Gm-Gg: ASbGncv2wOQbtJu/V9tXrfbS8yRqZ6s8QD6ghlJIyqMTiN3ZSAePDksabVZKk+9QyY5
 FnF7C8M1snpnvvhnNdL18CqKCJwxMkURW4ekwqaafKDzgfZg7FihMTzFb4ji+nLplohM0Yv4D4O
 OgCoVkUEKsmRhrL56vxcFrsz2YPvY3nbI/SFbL18ls6sDjsi1ZVulg+jkI6O+RVNwjPmxrpo/Xc
 DQr3v7dJHBDIp4dIEHw9iDbzZD2Bbcsm/BviAqLcOxv83KsEPl0bhJQUgIObNt1dFMJWwdllvOp
 9F167jtt4YmPReis8i9ekFFVJQwAuF+NjGuMBXsuqYvNhJljDtHDjEJFs4mW7siMBb/dHrl22eW
 HquGETJAMAzsJGKP8TVM=
X-Google-Smtp-Source: AGHT+IHQncLLXGBF0htKe21i8k3nraJt/ZV1SOe2Y1LqXAFzYvG95pKq/Cj4J4oTKE397zrZrhet/w==
X-Received: by 2002:a5d:47af:0:b0:391:2dea:c98d with SMTP id
 ffacd0b85a97d-3997f8f89bbmr16627163f8f.8.1742942645300; 
 Tue, 25 Mar 2025 15:44:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeba1sm213436255e9.32.2025.03.25.15.44.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:44:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 09/12] hw/nvram/xlnx-efuse: Do not expose as
 user-creatable
Date: Tue, 25 Mar 2025 23:43:07 +0100
Message-ID: <20250325224310.8785-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

This device is part of SoC components thus can not
be created manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/xlnx-efuse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 29e7dd539ec..176e88fcd17 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -280,6 +280,8 @@ static void efuse_class_init(ObjectClass *klass, void *data)
 
     dc->realize = efuse_realize;
     device_class_set_props(dc, efuse_properties);
+    /* Reason: Part of Xilinx SoC */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo efuse_info = {
-- 
2.47.1


