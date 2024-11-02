Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DB0E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E10-0003Fl-FG; Sat, 02 Nov 2024 09:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0h-00035i-Pu; Sat, 02 Nov 2024 09:17:50 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0f-0001yE-U8; Sat, 02 Nov 2024 09:17:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so4007307a12.0; 
 Sat, 02 Nov 2024 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553463; x=1731158263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek6CJz/W/BZPJLQDBSj5hrEIX9vzfAv/et55GzS0YMU=;
 b=nLgd8/Qn/FvEGbteKmkT5h/uR7i3CknRldaC041UALlkpPnCWHJ4pGk1p6cGbN3B8V
 BsTk6y3/Nlj9k0zKoZaO2uraesfcEgF+UJiw05vVPR1GlQjUWgz6cFtkA6Fpw97nLagn
 MghBs8I3Zselyh9KE9wkyZL5aBxmqazyKK72+qf3DUJzMesQqbape42RHaaRnhQDf+Ro
 I7+Hx5db9wlP/nAR2SWMb/5NZy7CySSCoGq5VIxAj2TnHxoNwPKLqI+GwC/RVOYMei49
 NLHqoHewNYlnz2JhCVlw1HsLyyl0a8P+HirKZ7W6qdzDamerZ8euCPUt2qpHl3dmWPOw
 bANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553463; x=1731158263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek6CJz/W/BZPJLQDBSj5hrEIX9vzfAv/et55GzS0YMU=;
 b=mRACrC8bJ79lw0guScfASnpFCGoy+pNwCgctxL3H40RsgPWMChT3DawQcNR+k70yHo
 7hJ6kWV81tAyyfzEemCNLCvSKgPxn5Pbngh3vLsG71uCoevLFHY3rD69jJLHSJbdKPlh
 jHT/szLYae/CN7hKPe75wBWZXEpxzULRsKXfaZs/zIOxRgDgT+1U5TqyNzuxPYp8cua0
 NESNB9uNsTYD0xCLqKvmNtRdy9cYgP53OsN8lDMy1oTnho8MfkCNXTJOGiocF0H2D+EU
 7FqK3/bA5UIXcBjQRSpJ0jmGNvDotsPMMj+4viDrnqk7+AY1Dwkb1VkpcPBJSo2QuY+P
 thVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjEwV3RylGt+UH0CIfUy7nzxYRt4jyYT5VpK1hXnuKqHWourf5ZGRw9vIn+x5xEBVeUxnwrePJkRg=@nongnu.org,
 AJvYcCX+1eRpiQnfE/J8nsUeZbvBzTP9rWLoSwBSrealkO2BkzTskYBNP5EVq39SlZ2w5ThhrHDWI0G7PPPZ@nongnu.org
X-Gm-Message-State: AOJu0YyuAFKTJxfTfUsXO7G2BCfJ3T/Ei+3eXbgpH9lvXx8grdKegCyf
 3yHeujn5xbxf6uJf1VFvYgbQS9zaGJ0VzS+cO70g6nkEa+Nl/hgIY+I+2g==
X-Google-Smtp-Source: AGHT+IHWFe6cGCaufEG+XkBAm6iobJJIWeJKqiVLk0VPMUPq9+ZTuBGJOs+xgkYcXFmW8rxUHuS2TA==
X-Received: by 2002:a17:907:948a:b0:a9a:238a:381d with SMTP id
 a640c23a62f3a-a9e3a6ca29cmr1366243366b.52.1730553463105; 
 Sat, 02 Nov 2024 06:17:43 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 10/26] hw/ppc/mpc8544_guts: Populate POR PLL ratio status
 register
Date: Sat,  2 Nov 2024 14:16:59 +0100
Message-ID: <20241102131715.548849-11-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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


