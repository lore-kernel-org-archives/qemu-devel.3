Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E401CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 20:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v58RZ-00012c-3J; Sat, 04 Oct 2025 16:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v58RN-0000wY-O7
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:01:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v58RL-0006Dn-1I
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:01:13 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so2729338b3a.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759608065; x=1760212865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpnV0onFW9tRiwZqt+4TaBfxtNgfz8HYk0xlDhGAU34=;
 b=VWQEMpjKWPYZGG9cLU5VrVcsBmSq6GExEDex6jGBahOXPeeiRyBGo4d5HLPyctoYHR
 daQUhE9EOZEsZ2bGCzuAVRKpo2nrfpTjfBo0nxlfxYTUqKBG/VTmGLdAgRmsvKfCzC+J
 NxSp9m4KYXJDsbQRED5SLJ/H6Vytc+lKrFG6+L0sKyWoCRjl6VaU9AvBGeTdN0XrrDDN
 sGhawcJZlopOFMQmWtjWaOG5s/GLr3am4Z1eSMsKbTjWBAs4eVNUJp9SwBHbgqt2QVxO
 OcvG2chz/deZCTuhM56voul7yuElbJ8MbqrexbmIt2RKN/fk3PSa7BPmWAkknxPOidnj
 QaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759608065; x=1760212865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TpnV0onFW9tRiwZqt+4TaBfxtNgfz8HYk0xlDhGAU34=;
 b=bfLzYnhb0kNMrfUdntO0m5Q1ZFt7+x5y+YCQCr63U6a5L/4oUtzutFRGr22/sgw/W2
 V47ekbbbNKS2yjCl2wurZwR+OqXqRO884klC3m1VwbdtMx0gfR7gU7SeHy663sFsqXk8
 UkcpR6BxB6QgUVAFizO/yOVstwJ8YqGXnVh+f/DX44kbjoFHmndIJ7bRBZF71jH5VhFA
 NYnEisfvhj5SK3Ad7HfVw4pjJ9PQ2xC+mf/3dKsQlvVeK1Xp2JnQi2vJXI4XYfZpmmWu
 Jnttzop9/i7ftyCeVTlUGDCsVy+v5FiQpKpT3byZ8EgerzJxtpOqnxxRW3dFKzR7F1cr
 KrjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI4UWiqf76KE+DKNk9XBvg2Q5/YzO04sSxPc6NEz0SydML7mFzvFrm4IaxtVbKJYmQ5zvLXbs5JacS@nongnu.org
X-Gm-Message-State: AOJu0Ywy9nwRWm6ou1ku08tuI5nUh6O3xfx5v0SI52v/Ro+0KD/8DLih
 zD5+Lnejkyz21Nien4PIhepj10M2LPLeRouCuB5UyQd0yETbyWmLYMmcqUliwwEe
X-Gm-Gg: ASbGnctvFvitBTe1XK9v/ubNEHJOYEzEbaqz/eSVl1KQM9UB0sXwt7ylvW00tr9seFN
 W4DMrINcJAdSZnmWPZ3jnTxHNXkIJ2iW70v83iy+ymNuJ19qQp3ui+rmLxx1AZYr7HPvEFwRRbW
 OIGTR/QsYcNwjZbbEEjE1rHmTnJWk/rUotYgRkCbR7jqNf/CiEv9Z3jBOrRRYoXjyrkta5DLLuE
 CmS09mzn946sKWgXtA5hVd8MLeNP725IP6vJU7xTFRID1FFp3L+cfMa7BFtNJbN/oS1gVLn+EfF
 5yrYRcsSuTqB9S0JX+28P3POD4xH+o/vdb7004xRoFCFYLAxZ/i5PE0/SnApMsOUwCaCn57Szgb
 rl1/iB5KVaPqyaxcbuvfjhkSxTgVNExmCL26AQ5Hdd9LUyLTnMNA+ZsXTXd9qkfbMo6FfAw==
X-Google-Smtp-Source: AGHT+IEOmX7z5/z/gyk7vj0N+uX2Tau8ZhA91fz4HpwKNdv/VKmP2FK+rh7cEuPvo8xmDOVLU98KAA==
X-Received: by 2002:a05:6a21:e082:b0:266:1f27:a024 with SMTP id
 adf61e73a8af0-32b620e6bf1mr8475747637.41.1759608064547; 
 Sat, 04 Oct 2025 13:01:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099f3b9c6sm7898235a12.23.2025.10.04.13.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 13:01:04 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/4] hw/net/cadence_gem: Add pcs-enabled property
Date: Sat,  4 Oct 2025 13:00:48 -0700
Message-ID: <20251004200049.871646-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251004200049.871646-1-linux@roeck-us.net>
References: <20251004200049.871646-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Linux kernel checks the PCS disabled bit in the R_DESCONF register
to determine if SGMII is supported. If the bit is set, SGMII support is
disabled. Since the Microchip Icicle devicetree file configures SGMII
interface mode, enabling the Ethernet interfaces fails when booting
the Linux kernel.

Add pcs-enabled property to to let the driver know if PCS should be
enabled. Set the flag to false by default (indicating that PCS is disabled)
to match the exiting code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/net/cadence_gem.c         | 7 ++++++-
 include/hw/net/cadence_gem.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 520324adfd..44896f1801 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1477,7 +1477,10 @@ static void gem_reset(DeviceState *d)
     s->regs[R_TXPARTIALSF] = 0x000003ff;
     s->regs[R_RXPARTIALSF] = 0x000003ff;
     s->regs[R_MODID] = s->revision;
-    s->regs[R_DESCONF] = 0x02D00111;
+    s->regs[R_DESCONF] = 0x02D00110;
+    if (!s->pcs_enabled) {
+        s->regs[R_DESCONF] |= 0x00000001;
+    }
     s->regs[R_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[R_DESCONF5] = 0x002f2045;
     s->regs[R_DESCONF6] = R_DESCONF6_DMA_ADDR_64B_MASK;
@@ -1821,6 +1824,8 @@ static const Property gem_properties[] = {
                       num_type2_screeners, 4),
     DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
                        jumbo_max_len, 10240),
+    DEFINE_PROP_BOOL("pcs-enabled", CadenceGEMState,
+                       pcs_enabled, false),
     DEFINE_PROP_BOOL("phy-connected", CadenceGEMState, phy_connected, true),
     DEFINE_PROP_LINK("phy-consumer", CadenceGEMState, phy_consumer,
                      TYPE_CADENCE_GEM, CadenceGEMState *),
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 21e7319f53..e63941f18f 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -62,6 +62,7 @@ struct CadenceGEMState {
     uint8_t num_type2_screeners;
     uint32_t revision;
     uint16_t jumbo_max_len;
+    bool pcs_enabled;
 
     /* GEM registers backing store */
     uint32_t regs[CADENCE_GEM_MAXREG];
-- 
2.45.2


