Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB09C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmn-0004FJ-IB; Thu, 15 May 2025 06:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmm-0004D2-4T
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmi-000864-UY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a1f5d2d91eso426734f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304751; x=1747909551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DRuZri4+JHhBySzNzcQhM79/aaMB+kacQBfm+tsx07Y=;
 b=R0UL/O4MqkhIDNdOvIXJ1L0UBLFTOp2HCljZRbM+i/3y/SwF+z+4iqIKv1rN8YdChz
 v/4dq5+LkpSmJc5I1aGTQGG7SPPacsCoYyqLDW+L6oykgqvZjNTlw2bMvIDaC5B689M3
 4L/r45MqyqL+W1UWy0JQU5F9xI96KfTMTHgNx6ggF/KAYBwYe2pi59orH9mW4zTEFwbU
 UqbRjoY8hrqyTreAAU4ZwAGL/bOJ8s+fKteXfx4ZP+QvxK57mpoLxeYZW3RA21FqVA8Q
 ha6yE1hI+zqgSuTZM3y4FWa2Yk+f1LFdKvlW+pcbMlFC8wh9mOiLlioiZV+lxygaJ9Wo
 FKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304751; x=1747909551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRuZri4+JHhBySzNzcQhM79/aaMB+kacQBfm+tsx07Y=;
 b=iFYX9T+xI40slRpDBRXNMhmol0yfr8ReZa+Y2rWvxyFfgoKxTeq1VGP4h4cIl3+Fdm
 DkFtJFTILOoK05Mi1zGJ1ABtdWkPXbsXrx4e7JD3bUyZkWQQ8gNhTMBL/euJRfjTy1JW
 wB+ujqLxWTDo/A6zuTNEb4BMywptfYpjk7FknVbAZagmnA5ApWBorB/NcD1tllqj94W5
 wOqK2QjmjEEwbNgDeignpDoZd7iES4hc4J/+jLymC5HDyUJ65BqPtwfmzmwz54HS1oh4
 MHUGce2ND7OpfPj1d8aZJgzz9XCZ57lDAaCa2FtCc19sLGrd9vVceDNGCZ/48MtxU0uQ
 kBIw==
X-Gm-Message-State: AOJu0Yzxi71JMgG6Fj7Fo9oOFI3XPa+iTB7XzWhFataaRrsQvIsQKcpN
 W56bu0aGKeWZqfCPrL74K01Hq9UNkHk9mCpxku4qkTFebnS16Fu44w7O+IS7xMdGwgJDZ/F4gdf
 3PwY=
X-Gm-Gg: ASbGncthLdcVAVbbAkjDqMcpnq6+t02mL25Ban6UHg75h6zDMzXLROwiYQtzMLNeP3i
 fqSCtKgBY7q9A5MYRpsn5DY65vhZ5sdXQ3lWZRnOtN4el83On986YJd9fx1fBN3kbYqAy6kB9VT
 m/kcLjWORh78Au+tUCrgKd76v/843QlI3Z91TThpB4sf8HNaBqk4ApeLMSdZV/5voniEImkGkkD
 NEFBWuH3qMLiXGKfH4CcFXTOsWGjvLkRfLxD8+Dlt6kGthnFR/cbo9GzZEyksSsucv/1DbEvqYm
 ViRZukQSCAWMFVKCajdF3x7aZbLz8gmcU3B1BplOU5NwJGGoiVQR6qxBkA==
X-Google-Smtp-Source: AGHT+IH/aW/fMj81E/Si0c0zIuju5J38nYPJuAEahfIqnVXjqdx4C6suTJJUh+UC+x8v/8UFsNP3xg==
X-Received: by 2002:a05:6000:2dc7:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-3a34994d408mr5882258f8f.49.1747304751287; 
 Thu, 15 May 2025 03:25:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/58] target/microblaze: Use 'obj' in DEVICE() casts in
 mb_cpu_initfn()
Date: Thu, 15 May 2025 11:24:49 +0100
Message-ID: <20250515102546.2149601-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

We're about to make a change that removes the only other use
of the 'cpu' local variable in mb_cpu_initfn(); since the
DEVICE() casts work fine with the Object*, use that instead,
so that we can remove the local variable when we make the
following change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429132200.605611-2-peter.maydell@linaro.org
---
 target/microblaze/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d069e40e70c..d895d683956 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -344,11 +344,11 @@ static void mb_cpu_initfn(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     /* Inbound IRQ and FIR lines */
-    qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ip, "ns_axi_ip", 1);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
+    qdev_init_gpio_in(DEVICE(obj), microblaze_cpu_set_irq, 2);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_ip, "ns_axi_ip", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
 #endif
 
     /* Restricted 'endianness' property is equivalent of 'little-endian' */
-- 
2.43.0


