Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F75BD11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7akz-0006Mp-QN; Sun, 03 Nov 2024 08:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akv-0006EC-7l; Sun, 03 Nov 2024 08:35:01 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7aks-0001GH-K2; Sun, 03 Nov 2024 08:35:00 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so392509566b.0; 
 Sun, 03 Nov 2024 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640895; x=1731245695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek6CJz/W/BZPJLQDBSj5hrEIX9vzfAv/et55GzS0YMU=;
 b=HX8XAsNb23G7vjga9CHfq1rLCNSNF4MQYiVtUzUjq8uJ4TJvMRlm1vJomnlURVjVvP
 mo9lVtwhKvwDetARdRCzKtK5UWmrDNEJRYs+vQ8iofcVuCkYjzG4aKYQxRKJiUqSJJKL
 ir+8AeVpYCyc8mdEP0bqgXSO+stj0J1FOY6mr7t9OXwyiflRbBdBtprrubvQ1l6xYU+O
 FxV2UlrbAKoNgdPfzpHuH5GgD6W98dF9ekRG6hcEaAAE8+kIDv7YlMvThb99C++BWZwR
 WS3PyV4R9cPG6TCuV0lbbqcyaL9GFnsxRHnzZL0QdTYEqPamHextT+aIYH6/Kl5iWde+
 DRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640895; x=1731245695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek6CJz/W/BZPJLQDBSj5hrEIX9vzfAv/et55GzS0YMU=;
 b=j+DCeG+EUxQB9p5Yo1epW2E4gqpHdzDKpso8EDF3ps7BJ3pbvQ37mKAjdsO3pQgVTn
 4WI4B+0Kpad8ZoEKJCkbwvKHWsGDMI/T9mgHR5uXPOw+Y6FSQbrnt3fR1VFzGfEfzCun
 +VYa5w+RfF/+Fgns7tKJ5X9DipivwGIulAJ/wH/ihl9FDYIu2ElEaheqZWrmjobxrL9Y
 QEvaX4/GwmXpF0KGQ2Vs/ot18l1FOLkp5JGT94YP2cg4Y6nOJGFBSE6H1nUeLX8VPt05
 POdbepMYGqPbFOdM7dgHww6pFVFw6ZHqfwp7nh3RAyBrHWNtqxraRESHiwqM7miIVQu/
 ClZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWeGqh/tuDNCIvR9WcADU6AYdIILei7HAkHU7Ka4/BFIzrBzgvAc3MTNFFnV/mNgqYlkNBi7k5kwo=@nongnu.org,
 AJvYcCXDImv7Wmyk4ajO1IFMe9Zabdr7JKovOq18EohLmEoqJykqMkfCvetj/AQ1xKI2WGZqQs/vQMm08ck+@nongnu.org
X-Gm-Message-State: AOJu0YxVbu0QKZtqStojm7gPwyUJRusTpkC9OaqZTBmXkW9TLCu+gAzO
 n5ycEo+PJn/h9YFl3bLJuJLpLNWBSSIDGj7RABYXoC0ggWiH1/Z3DEkd2g==
X-Google-Smtp-Source: AGHT+IHU1zHgnSJYKblp4Y2Phk1qGDzo9lmKgHdHvby6tWb3uuE0Pzqbi12wiCC0k3hd9DC9+Y4wZg==
X-Received: by 2002:a17:906:6a12:b0:a99:f746:385 with SMTP id
 a640c23a62f3a-a9e3a573d11mr1837250766b.1.1730640895195; 
 Sun, 03 Nov 2024 05:34:55 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:54 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 10/26] hw/ppc/mpc8544_guts: Populate POR PLL ratio status
 register
Date: Sun,  3 Nov 2024 14:33:56 +0100
Message-ID: <20241103133412.73536-11-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/mpc8544_guts.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index e3540b0281..c02b34ccde 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -29,6 +29,12 @@
 #define MPC8544_GUTS_RSTCR_RESET      0x02
 
 #define MPC8544_GUTS_ADDR_PORPLLSR    0x00
+REG32(GUTS_PORPLLSR, 0x00)
+    FIELD(GUTS_PORPLLSR, E500_1_RATIO, 24, 6)
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
+        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_1_RATIO, 6); /* 3:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_0_RATIO, 6); /* 3:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, DDR_RATIO, 12); /* 12:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, PLAT_RATIO, 6); /* 6:1 */
+        break;
     case MPC8544_GUTS_ADDR_PVR:
         value = env->spr[SPR_PVR];
         break;
-- 
2.47.0


