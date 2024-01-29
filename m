Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D817C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUV4i-000885-Q2; Mon, 29 Jan 2024 12:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUV4h-00087h-RH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:05:35 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUV4g-0008JU-7s
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:05:35 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51028fadfe2so3305856e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706547932; x=1707152732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gaer7CC5Q8Pb/+eDIFM+B255KCC9Szo86mfDtaUoLpA=;
 b=JA4LOPvBY3az2G+NpoQWPSE+Z0FK4NMKiE4iTXPdjLbdKewk7zD7eQnzKdAbTm6nVJ
 gquJst5pJ+iuRUWRs8qO76N9gdGT8kCLY3vZ2h5MRBwqy+R2Pkdlwwa7or7g53KR7l0o
 KRcS3Zy2spIaJzK26CR3NblVEiIUvd4ST/E6ZrpWmkgU26Z1flQhddW1wxCKredu7BfD
 We74aXWVDDtB6q1VJKHaPse4Gu7B+V6G1m+WYkgdDp2+knsQKUwSY4n5aF3nPUJgdYRO
 W3MjPfRBPOIkbqI+ho1WiyT6JdlIr0CZ3QObzh0+CZfeX1A2ZWS9rHBuEhHOl2XzQ0m/
 xB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706547932; x=1707152732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gaer7CC5Q8Pb/+eDIFM+B255KCC9Szo86mfDtaUoLpA=;
 b=P9ftaNbUkv5ySnQOhEDPbyqERfyT4OgZSgeVDIAHS5yFUV27EHol+K6Rc78iNOhnCL
 XXkNMPUsdCGcPCzIQViZphHUKRSP5KKQD5UFR/M0BNBV3P7wqiRMTD9sPThQljKlgUMM
 lknqdYS7KfRzXnanlWEkLHd151uhQR7WW3A2w/ORfhAIElv5A5kxVNbY/bYhYtC5YU7h
 al9NLRbYZJHYel7NB9cY362OtAILYOlshSiPOFD0s4dFWyWbQ1JudbXlHx49TvI1qwUm
 GOhDF1WtZVMiXJzqpsgJAqo6fpY/L+1Eis1i/btXR3XKW5Lp0W1agfgL79Ns6tNmnN0g
 1BGA==
X-Gm-Message-State: AOJu0YwhY4Jear9GSrcwcaA8smncwZG/1ampi8bwLGBZ3oT6VDDBfA7z
 VOgtESUT3ojZ36vrFzmViW5saV/GCDVQfV8lmg6xA26PC093GcQZvAF9B7OM9+g788pIVu7MOBU
 Y
X-Google-Smtp-Source: AGHT+IHFg3RR+ZrvQ9etlC998BrrK7UXF1U29I3TfQt2xC/C4za17KjTMGU4X4PQeUVL3+DDZXH51g==
X-Received: by 2002:ac2:4835:0:b0:50e:95cf:e7b1 with SMTP id
 21-20020ac24835000000b0050e95cfe7b1mr3736216lft.9.1706547932125; 
 Mon, 29 Jan 2024 09:05:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 fm25-20020a05600c0c1900b0040e3bdff98asm14681581wmb.23.2024.01.29.09.05.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 09:05:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/intc/xics: Include missing 'cpu.h' header
Date: Mon, 29 Jan 2024 18:05:29 +0100
Message-ID: <20240129170529.74305-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Include missing headers in order to avoid when refactoring
unrelated headers:

  hw/intc/xics.c: In function 'icp_realize':
  hw/intc/xics.c:304:5: error: unknown type name 'PowerPCCPU'
    304 |     PowerPCCPU *cpu;
        |     ^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/xics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 8b25787227..700abfa7a6 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -40,6 +40,7 @@
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
+#include "target/ppc/cpu.h"
 
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
-- 
2.41.0


