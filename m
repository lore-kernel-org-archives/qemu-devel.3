Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B58FC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53ok-00057u-P1; Thu, 09 May 2024 09:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rsamarnz@gmail.com>)
 id 1s53oj-00057i-Vv; Thu, 09 May 2024 09:28:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rsamarnz@gmail.com>)
 id 1s53oi-0000ZO-G4; Thu, 09 May 2024 09:28:13 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f45020ac2cso754141b3a.0; 
 Thu, 09 May 2024 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715261290; x=1715866090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ES82ewI1NIHI1vn/pNjCtvapE45ezZFMf+6qtK8J3mk=;
 b=JXowYWv9rYJyWvZ6Na4C+oZoKK/WYltv2Wz+mYyIoAOZHNjF8LW0FTTOgj4KbrPcl1
 BE+pnSkmyCEAPo8tyxKjr+WbevCCZOBX0CfzABsK7PacrbgiBlDMYlVC4wZ2cKbzW5V3
 tRh68IBJHU85eHzCUROxYEKcKIm28E+y6VCMAoFBTbwW1G8tfl4IgJSHZmj0OugkBNXL
 N8ImNqHRvVNCQ4yK4pXQldBfXh6cFLhG+S1T9lF2VpaOuOAeBsyqT+Ab32Jhelesh0D2
 N3kUkIZ/IlKNqYQy22mIcS+w3bFFTQTxnctg9e9sBs8qCPaKCArfHIfYRA0U8U+FKFUa
 pJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261290; x=1715866090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ES82ewI1NIHI1vn/pNjCtvapE45ezZFMf+6qtK8J3mk=;
 b=L2h/uSUK1WgLZfZ0iS8SNuWhy8DM2aso8aYD3rF4MdGFaugq6auPaNSEr7XvAcnMx8
 2TpNNJnFC0dnGpz408gT1O3ueQPm3K+x4tXEyDM5tMHw3c1ku1oM81X0ziQD7oxcuNxd
 VB47FA7/znp/y6a6FxSjEK55OhL5M1QId4G5BJd+ehhx9P9dQ/XtIIabpPD7yNKSKk1f
 yLeiJdY5xkDVcMUgT9ju5KGeIiz8SVclRCdVSVwo8u8pAxe12rIA2H44DUXvjqWQF5ah
 f33vL1bDpwMpc9AHhbqocubfH+Vem94h/SD1/4cvJicrc5fpQfSa65OCg9tIzfZwKU7a
 fHYQ==
X-Gm-Message-State: AOJu0Yw8veP86jCXYs2QGBV1agL9FP1V+isWhJPSPJIU7TPM6Gfs9r+t
 NchGQdGHmG7qUB72sfXAFOJM2oVHd/Ok8tuhs1HjMW3gft78/DLBbHtWwg==
X-Google-Smtp-Source: AGHT+IGrdaOqmIij8VL+i4U/wIL2ZrZvQb3tcT4nag7867Rb38x0hFeCFp3MpdrTTcgrxTKOojEmFA==
X-Received: by 2002:a05:6a00:1387:b0:6ea:d7b6:f4b4 with SMTP id
 d2e1a72fcca58-6f49c292487mr6799321b3a.21.1715261290010; 
 Thu, 09 May 2024 06:28:10 -0700 (PDT)
Received: from rs.ip (115-189-84-241.mobile.spark.co.nz. [115.189.84.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ae0dd5sm1265247b3a.135.2024.05.09.06.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:28:09 -0700 (PDT)
From: "R.Samarasekara" <rsamarnz@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, gaosong@loongson.cn, raj3sr@gmail.com,
 "R.Samarasekara" <rsamarnz@gmail.com>
Subject: [PATCH] hw/loongarch/virt.c: Fixes memory leak in ramName during loop
 iterations
Date: Fri, 10 May 2024 01:28:02 +1200
Message-Id: <20240509132802.247147-1-rsamarnz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rsamarnz@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch fixes a memory leak in the ramName variable within the
hw/loongarch/virt.c file. The leak occurs due to repeated calls to
g_strdup_printf within a loop, causing memory allocated for ramName on
previous iterations to be unfreed.

Signed-off-by: R.Samarasekara <rsamarnz@gmail.com>
---
 hw/loongarch/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c0999878df..1fe02f8501 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -954,6 +954,7 @@ static void loongarch_init(MachineState *machine)
         fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
         offset += numa_info[i].node_mem;
         phyAddr += numa_info[i].node_mem;
+        g_free(ramName);
     }
 
     /* initialize device memory address space */
-- 
2.40.1


