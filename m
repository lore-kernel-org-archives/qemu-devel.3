Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C26CF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPm-0003Bq-Tt; Mon, 23 Sep 2024 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPd-0002as-W1; Mon, 23 Sep 2024 05:31:25 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPa-0006yl-VC; Mon, 23 Sep 2024 05:31:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so558177066b.1; 
 Mon, 23 Sep 2024 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083875; x=1727688675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6CZQD1xJ4Za1UOZKzua0E5ijXIgQYfhe3Y1vJtCOdo=;
 b=CM+3vsSazaMGn3z6d6FG3nEQEzZv6kPaR/5sxZs/M3wp9iwkz8xidfTxYqKZFUMQd9
 COIQmmq6O1djNBPTO1XC7eg/VKC/0d2yZwWPcXnxWj4ly5wUW+7Tieh/JzecetwqiUJ+
 d/GEHsBacMOrqkRk0ksvtqtmObEHESV/Y5nqrGpSDgGq5gbZN/+Fg+kCqMsWVfmuBkRk
 m2G3oTmoGgE9+C7Op6sR/+r9rEl7RygFKfXLryclfhNyg0+feqSVfelcaAiaCUzhSl0L
 rcxEGF8sZTAH1BVeJkf1OQj7D7CdnPQCJ+u0OqssYxmQ9yja7kLU92rBB5ndRxipAnHp
 +gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083875; x=1727688675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6CZQD1xJ4Za1UOZKzua0E5ijXIgQYfhe3Y1vJtCOdo=;
 b=YHiRSCd+7d+kjao1Mr7n4VXqpp9Dm/Z2dd3sqFXFsjCRfzmlxPbgNILpzwPhtXNo/j
 BJY4KMQuozNzqF27WUR3I3Hs3yso9sgZWF+lDOHC2Z88FrQQacXipaiAufZ7BsEwk7r/
 HsaCBiWikdVLS1Bg65pjO1bFIJn7Io0d6lbo7lWn/bHOIaBzvu5tVsZGCAl4DlNY3hv/
 RuLMMTt8Lhe42J+EqGoPCNVQX97FbibraS75TgzeZCgyyLhqr0yONsd9RUfjhidumyWq
 yc/kjDUGiNzQNO94Gp0UJrhzpdfCUcy9ozcQDBjUh4qf4K/pTdyOTc3Gg8OKZLvFY79G
 Eg/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV934OXNruIixzdHDhGKTqNYPp9ShY3qIXqJIkpS5QT/vn67g1SRVL93KzH45p/YqHbmRYzf2GqGKw=@nongnu.org,
 AJvYcCWRp/C9NGL6nzyEYXGqMrXvJgz0x85JI238OQ3GQgGBkfUvagNm44Cpz0Phz+LXyvIQV8HRYm2uO8pH@nongnu.org
X-Gm-Message-State: AOJu0Yx6fzsskuOCAF5wkV35ZVUgc7LInndWTvrjS7Y+Dpn0azZflC8V
 K5c8FTBcklHbK3Cg0LTawlU1fNOgFgDUoK+qGNuEtNRZFXxwyxxYUl9ZnA==
X-Google-Smtp-Source: AGHT+IEwJQIEHhCll5yjtbAaJ8IDBYP3vjsdaQHZgaoq4obMSCgozPrBBVQgRoQONBW/Xw0hlKXfJA==
X-Received: by 2002:a17:906:d262:b0:a86:851e:3a2b with SMTP id
 a640c23a62f3a-a90d4ffc82dmr1075343066b.29.1727083875320; 
 Mon, 23 Sep 2024 02:31:15 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:14 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 09/23] hw/ppc/mpc8544_guts: Populate POR PLL ratio status
 register
Date: Mon, 23 Sep 2024 11:30:02 +0200
Message-ID: <20240923093016.66437-10-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Populate this read-only register with some arbitrary values which avoids
U-Boot's get_clocks() to hang().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/mpc8544_guts.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index e3540b0281..6688fd44c3 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -29,6 +29,12 @@
 #define MPC8544_GUTS_RSTCR_RESET      0x02
 
 #define MPC8544_GUTS_ADDR_PORPLLSR    0x00
+REG32(GUTS_PORPLLSR, 0x00)
+    FIELD(GUTS_PORPLLSR, E500_1_RATIO, 16, 6)
+    FIELD(GUTS_PORPLLSR, E500_0_RATIO, 16, 6)
+    FIELD(GUTS_PORPLLSR, DDR_RATIO, 9, 5)
+    FIELD(GUTS_PORPLLSR, PLAT_RATIO, 1, 5)
+
 #define MPC8544_GUTS_ADDR_PORBMSR     0x04
 #define MPC8544_GUTS_ADDR_PORIMPSCR   0x08
 #define MPC8544_GUTS_ADDR_PORDEVSR    0x0C
@@ -75,6 +81,12 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
 
     addr &= MPC8544_GUTS_MMIO_SIZE - 1;
     switch (addr) {
+    case MPC8544_GUTS_ADDR_PORPLLSR:
+        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_1_RATIO, 3); /* 3:2 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_0_RATIO, 3); /* 3:2 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, DDR_RATIO, 6); /* 6:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, PLAT_RATIO, 4); /* 4:1 */
+        break;
     case MPC8544_GUTS_ADDR_PVR:
         value = env->spr[SPR_PVR];
         break;
-- 
2.46.1


