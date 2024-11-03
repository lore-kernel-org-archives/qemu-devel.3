Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE25D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al6-0006XY-Kn; Sun, 03 Nov 2024 08:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al0-0006Na-Mv; Sun, 03 Nov 2024 08:35:06 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akz-0001M8-6r; Sun, 03 Nov 2024 08:35:06 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso584862466b.3; 
 Sun, 03 Nov 2024 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640902; x=1731245702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+9sPr/c1Q3i7IBMZfbnvSvuFCvri5bfm/mYMzMrjI0=;
 b=RZHtWbkDgMOSgUmIFbjUF75gczBwAza3dwK6yqDcipel1PKRjmz+rqgfsB/kHwg4lE
 9YNqSyxXKQa4XLJGMTgDHeSDBWCAUqiS8AWpXIfk5w+SPZMSCrTBKCAuWHnpBLmxueuH
 0A79y6ZqvNEr5BKxqcxOdbLRf6nTEChZspLXIYyupsRzAaQSmjCNuqLIgdYKj/o1XXAS
 7bDbcNVZX/wtbVqqEbsbrf5qCX3KPoUtEpBk72kz6WlUkIlmrmItooqf/fDQlXrT2UaV
 lEjiFQZRgmgqMObCmUyzffjlIx+hNlOw5WMuuIdJksUD9Jey4yAzfvNjmUbeQNTYdCij
 8Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640902; x=1731245702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+9sPr/c1Q3i7IBMZfbnvSvuFCvri5bfm/mYMzMrjI0=;
 b=d3XHnH6ALlzVT8ARbacSgzo48qDNxbXADY2qRIbgVDiXHLoEkvsKkaoBV0Qrf/vI3y
 +4Opkmd8MEUXpEnO8jgYxGE9ZM8g2xKugXZTH/cz8swqs6+OClOrPi31qd5jS8LDpHzq
 RcxaXRqzvTUnlBu4g1Zrzc8M3gfQllMzhPNdsRqSvUtUFyurwY2TPgceZ4JCXaKLDTJb
 1ZTzyQwAbdXmebI9AVFdbluzMXexK3O38U2Deyj3qhH1170qjovVdfCvRbmk8W3XdiAU
 HwFFH98S0AFWZhho/nnfUkd/ZfIOafL6kBJCH4s36OQBy4QDgG2ve8svlFGa1B9U1Xtd
 reqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnaCR2wbw7p5oWhecm2yiatwH5YMDFMbkfFyXGh9LU9betdwtvbkgxxuXB47pSQgWyrL5wJVMa1Jj7@nongnu.org,
 AJvYcCVlolzk11LdVTrTj5x39+jr8DIEMUIlV45RNbAbQP00FWVtHOO2KrbVHNgi2Ol9wkHvrU4HnJIlBKs=@nongnu.org
X-Gm-Message-State: AOJu0Yz1lnBadO4vfQ5WXV5CJ4Zg4j+llWZHqcwEt18AQkYFxsCG5Tqe
 b3W43kJ37rlw8k8+K+Lt+A2jPsee6x7JAK/6WAkt+fGe3y4j3g01nmxu0g==
X-Google-Smtp-Source: AGHT+IHT9SaXazslt+65BMyp5+OO28E4LbbVWxvSN9SsnBSN0uy0dollThrUA4xZAQXb6fCbgn8B/w==
X-Received: by 2002:a17:907:6d0a:b0:a9a:d23:f8ca with SMTP id
 a640c23a62f3a-a9e3a57530fmr1299853366b.13.1730640902415; 
 Sun, 03 Nov 2024 05:35:02 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:01 -0800 (PST)
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 15/26] hw/net/fsl_etsec/miim: Reuse MII constants
Date: Sun,  3 Nov 2024 14:34:01 +0100
Message-ID: <20241103133412.73536-16-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Instead of defining redundant constants and using magic numbers reuse the
existing MII constants.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/fsl_etsec/miim.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/miim.c b/hw/net/fsl_etsec/miim.c
index b48d2cb57b..4e9169907a 100644
--- a/hw/net/fsl_etsec/miim.c
+++ b/hw/net/fsl_etsec/miim.c
@@ -29,13 +29,6 @@
 
 /* #define DEBUG_MIIM */
 
-#define MIIM_CONTROL    0
-#define MIIM_STATUS     1
-#define MIIM_PHY_ID_1   2
-#define MIIM_PHY_ID_2   3
-#define MIIM_T2_STATUS  10
-#define MIIM_EXT_STATUS 15
-
 static void miim_read_cycle(eTSEC *etsec)
 {
     uint8_t  phy;
@@ -47,14 +40,14 @@ static void miim_read_cycle(eTSEC *etsec)
     addr = etsec->regs[MIIMADD].value & 0x1F;
 
     switch (addr) {
-    case MIIM_CONTROL:
+    case MII_BMCR:
         value = etsec->phy_control;
         break;
-    case MIIM_STATUS:
+    case MII_BMSR:
         value = etsec->phy_status;
         break;
-    case MIIM_T2_STATUS:
-        value = 0x1800;           /* Local and remote receivers OK */
+    case MII_STAT1000:
+        value = MII_STAT1000_LOK | MII_STAT1000_ROK;
         break;
     default:
         value = 0x0;
@@ -84,8 +77,8 @@ static void miim_write_cycle(eTSEC *etsec)
 #endif
 
     switch (addr) {
-    case MIIM_CONTROL:
-        etsec->phy_control = value & ~(0x8100);
+    case MII_BMCR:
+        etsec->phy_control = value & ~(MII_BMCR_RESET | MII_BMCR_FD);
         break;
     default:
         break;
-- 
2.47.0


