Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D1C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lM9-0000KP-9I; Wed, 08 May 2024 13:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lM3-0000Ju-D7
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:24 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lM1-0007Eo-IT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:23 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f17ac14daso5022891e87.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190319; x=1715795119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlGsXUjV2W0lKSgAhb3hMEfQKjBImD4L/wTsIn42n4A=;
 b=W8Rhtlocu8pi5o+Z8UzyKLcoBMx8yifHG6WDL439iDao++k16NVfrQJf46JjR6lLFu
 WJKvp6XVl1k6JSdtqFZJBIz8dnv2e6Rg4RDTBYkjME0G74SkQkMk1FWe6KTox5pWUEq1
 XOGcRzlNZS8SMsDpg43l9XeCfiPNoo1OcjuZOZHvkigOZ+Uj6+I2ArLbADLc/UkqI50R
 ApCGMg3mlBV/gCGSeuehP5sUYJVSNrW7kJgPqvqrOCI5eGkSUsnw5ZVTdzAjsiozrkvK
 KDmGgVWwsyutvcbUVvVkdF/8AnycKqdxzcvGB48X/FxSOt5zgzo7qjbc9n7g5QLAdw79
 rSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190319; x=1715795119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlGsXUjV2W0lKSgAhb3hMEfQKjBImD4L/wTsIn42n4A=;
 b=nD3nln0iV5C5LFjJGuz5yVDazAlrea3FYG7w4PNNw/VM5fwqUH7ZR6KLWpPIo7/yrn
 NdfCJzQXeoopPoS8mAoXB+Tq0dQ9RydfrGkWi+A/2aMjonmRPesXMgPIEPViNHvgXzQJ
 MvIr/jSLGwBKaRlk+UCsBpaqDk6miekltIJQJxMSg7CLBay0QOFWwrM+cVjJtwTJxylV
 IvAdCiTFeT6BMx9hktsU+Zl9pinnyfBeCLO9/XLgILZZ4K5QFL0TRIMyV5fVxfVFCOO5
 YV66l4lzAbQXjAykw+6/AnPfQMsrg4Q0Z4TAzaFb0qJoJCAjGZDVtHuE+HPXN9vCxrJ0
 n1kw==
X-Gm-Message-State: AOJu0YwwUXN27VUmGQmbpgP6XhVJLn7uVl+bPk2PaY+YQAPoA1NEp9KP
 tDD16Dlte8r1rKbvDrvzl7HxY1mFL7Voz7pV4J7NmH5rcPcOTgQgcQxJPpaA3s1LklqC4wiaUmo
 X
X-Google-Smtp-Source: AGHT+IHqJ41t+W2NY1uEe4aJJR8EPf/cxDLZsAV30Odi/J8mVbO3UXhCM7U5C4hOExpdjJALQpaOfQ==
X-Received: by 2002:ac2:53a1:0:b0:521:cee5:db36 with SMTP id
 2adb3069b0e04-521cee5dbdbmr574063e87.48.1715190318753; 
 Wed, 08 May 2024 10:45:18 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 oy6-20020a170907104600b00a59a86b85ecsm5746604ejb.78.2024.05.08.10.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/26] block/qcow2-bitmap: Replace g_memdup() by g_memdup2()
Date: Wed,  8 May 2024 19:44:45 +0200
Message-ID: <20240508174510.60470-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Per https://discourse.gnome.org/t/port-your-module-from-g-memdup-to-g-memdup2-now/5538

  The old API took the size of the memory to duplicate as a guint,
  whereas most memory functions take memory sizes as a gsize. This
  made it easy to accidentally pass a gsize to g_memdup(). For large
  values, that would lead to a silent truncation of the size from 64
  to 32 bits, and result in a heap area being returned which is
  significantly smaller than what the caller expects. This can likely
  be exploited in various modules to cause a heap buffer overflow.

Replace g_memdup() by the safer g_memdup2() wrapper.

Trivially safe because the argument was directly from sizeof.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20210903174510.751630-6-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/qcow2-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 874ea56948..256ec99878 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1609,7 +1609,7 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                            name);
                 goto fail;
             }
-            tb = g_memdup(&bm->table, sizeof(bm->table));
+            tb = g_memdup2(&bm->table, sizeof(bm->table));
             bm->table.offset = 0;
             bm->table.size = 0;
             QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
-- 
2.41.0


