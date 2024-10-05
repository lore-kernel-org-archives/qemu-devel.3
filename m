Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA35DCFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkO-0005S2-CY; Sat, 05 Oct 2024 15:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkC-0005Nh-59; Sat, 05 Oct 2024 15:47:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk8-0007fG-U3; Sat, 05 Oct 2024 15:47:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so31425425e9.1; 
 Sat, 05 Oct 2024 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157626; x=1728762426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+XxmN8aD/MZ6DGzlhF4E6QfY0KHf9UNl0Gr9lvIaYE=;
 b=hB7qymWJDBYO9eR7JvhaZ681VDYse6aU+va8/2Hs7HPsTEPCJ8O5EBfSj9ITwaf7zq
 5xlXeyzvNao2oNL43LUsG4sVFZJgMv7OSvCM1xosgzNLAVXMPwwZtsvvRPpX4ODia1F6
 TfhzPz6YpURLcgZD0QBImTEF8hYyc9T3tF+/y74re0I+KOr5OnDKS8FPuvFq2PZLcvEc
 Djy90lFOOjFnv1niIWFZaQeHaPSpiCAeeME1D0q8m1qOsDAlNFU1MkgP+W64bgKHDxgY
 zoKx9aTKVYN9PZtfcgxSw5JaqEaV7TiMcX8p4bWzY84MXkgoa34rx1GADhoZzBOfzzF/
 SZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157626; x=1728762426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+XxmN8aD/MZ6DGzlhF4E6QfY0KHf9UNl0Gr9lvIaYE=;
 b=cLiWdqzJ+bX/vAmcGPcHIaJ7RRRkTwQIEiuNR4nm60CVJcWGwRl+aiTD+pBSYvQRVz
 ew1gsYnz3Cs8pMCRNt9ALPceO7t34i7PqSYWOsmoOM2BTumsSr1oEgstiFZtWBsAFT4/
 Ovuz51XAPp1N48vxYvMPBaCn/dMdcQZRnCwnK+VE0CP7ZN8d693WMSlTQJKuuUlytSjj
 2q0E2n3z7z/3KgPnl1Pkxk5ce18koXwJk4NbqvqRnAdiSDoIRyvoHS0T66YJ1N1IcgIy
 NUFpBhM721A5iNatg1AAJRpaYdaBVDz95h07W0y3NpXZ1SJSq3Q+swShkrDVCwfHJtx7
 k50g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOlFjla8vdGh53AgbilTfcECYzKZZTsO47AyphYJMfLEpCvDXJHBqKFjQLQMy9FBys65hBZsZ+y4d/@nongnu.org,
 AJvYcCWm3V3wXjkQQkAUtB2WCOErqPcfLPPwQr3fEWAbgqfW46ystMAWQSv28ECycTYUBN0t7QNI5E/AiO8=@nongnu.org
X-Gm-Message-State: AOJu0YyaY084xNv6y5ru7njuHPO/emI1ytbNUxVtP4BPjjnZcuox5Ydz
 8EqXVo0rADveFKSXJ64/Ul5l88lF/pY7Mhz+nHxylr0nohY7NnTOGwQcbg==
X-Google-Smtp-Source: AGHT+IF6LakbRBuk2PKoeaM+x98od3+6dNX5dPx9nGmSnBzmoj/+W8+58VaL74PBpL0eWovVGY0sTA==
X-Received: by 2002:a05:600c:3c83:b0:42c:b037:5fce with SMTP id
 5b1f17b1804b1-42f85a6c5d5mr52557465e9.3.1728157625983; 
 Sat, 05 Oct 2024 12:47:05 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:05 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 09/23] hw/ppc/mpc8544_guts: Populate POR PLL ratio status
 register
Date: Sat,  5 Oct 2024 21:45:49 +0200
Message-ID: <20241005194603.23139-10-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
2.46.2


