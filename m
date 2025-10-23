Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA174CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54n-0004py-Sg; Thu, 23 Oct 2025 19:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54l-0004iY-2X
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:35 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54j-0007Rm-6e
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:34 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b67ae7e76abso1021220a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263431; x=1761868231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zk8Kix8Kg+2CjYkxMY72LuG/VHJwD8T3oyL5Prb33rA=;
 b=I6d/isWpKbglwg498K8SfgOAc/srfei8JoI1yqes3YjOpgxyepH60wI1FM+oAW8Yoj
 RBdIONjvOLr3+msMnLSVWTm6lSfRrL+0XskHqyrWmLhgkbcYOHFYMsyJcNxy5BPRP15J
 Sfqp7HVAB795Kp/wIy+0yPr6Fr7qwKNgdBasUd90B+Rwx07EbaEvYO84vOyISGpJMMY0
 kQpClKLBOeLddun0hOeOBwW8sCjoHPejz/qHKEOLRrecDajxWGDQI157BB01TJAv/KCl
 A/Js2BmGnk3un7tdfN2KS13JEtxvUu8yZEWNVbayp1J3AzNOXvxJqJphHNyiDf5QTO1s
 8Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263431; x=1761868231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zk8Kix8Kg+2CjYkxMY72LuG/VHJwD8T3oyL5Prb33rA=;
 b=hIiuh5OrQk20SqpQn7QMBVHZu4sNMft2Gf3jMSHZZKcjfF6MeCG+zJE6sWDqmodfta
 pkGIJPaxRBG+w55taOKU1P/Bxl610V4UyVEzDZ0vNokqSZXofdpIkOgXpRg22vy7E5wD
 txLPMD4gIIvPC7FXZR/GCG+woz0qBNojAvsBMu0BM0NJXHBr1KMzr2xHAXdGs36bqLT6
 bwEPcHIFrfWAWRBuvk7eB0OsweAnL85UNXtkCbnp9yzTid2phA/xWD8131RR3uD+Xyei
 LVhjQCZXsWEyBl3Ed8p4B6c78NSt3Ga0y+t8J8hR42QmYzdXNuIEAZTfPITjs0xRrP+E
 Oxew==
X-Gm-Message-State: AOJu0YzSryoIaLEvaMkKwf8oqD2A26brVXz3pLdUMXFgZDmC05d36wbN
 LVTmyfQ12m6EGwPOTl3TT9RmSt2pdbPPse5M9AF0H+ZjF6HKrZfqod8DS8zcVQ==
X-Gm-Gg: ASbGncudMydXsT7S1wa9eIS/jP5sx3b70VL8NJUi+P3QEK8Evi87RvEdV4/lqsra6db
 IBWxUTsQSOMWy4Q9aksVwCLnDfYr1RzHNrrOyLT92GpawerrrnR7mOkw91EQTVrzh7kr/Ss3yiC
 f3OssxZb25DxaCBukxEhRiIOpbNkuRZgv3VFlB8yB4rG5JK/YoXeW2Kh3PlShd8AeQH+v2v6XXq
 uUTHTzDZgIobGbzVrJamssn6aWMw6R4Rx33iHMRXbqkA6lxriwQHI48xw3NJB4GLuYEmWpcLyPO
 9Bsb0GskcOU4e+LHMhhRuJXqcHk0aAYJkDauz4aWAGFLQnFPZrjlWklwR8s4gpqRO2ItS5jCidM
 HfEP+VaeUHZpY/znjldAdY9JQZ+lU0EEzVFZZ0yZVJBV1bltBlKSTD4hDUtq0SyXT8d6PWGLSgA
 epD+DmfIWm7PYMtdmOQoUkjF5E3crcg2cj9gzg8rAy1bl9pLOypohQD3fLYQArapJ908BbkkEPb
 /Tr9jU+I5YZxLxmwrI=
X-Google-Smtp-Source: AGHT+IGxLjMSQr5D/j1xAU7W3VHu9YPYKcERBa6x4nhpPvsizQMHu/HNviZO0YIjXC6X3vbnAoNN/w==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id
 d9443c01a7336-290c9c8968cmr352865305ad.7.1761263431273; 
 Thu, 23 Oct 2025 16:50:31 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 16/25] hw/net/cadence_gem: Add pcs-enabled property
Date: Fri, 24 Oct 2025 09:49:18 +1000
Message-ID: <20251023234927.1864284-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Guenter Roeck <linux@roeck-us.net>

The Linux kernel checks the PCS disabled bit in the R_DESCONF register
to determine if SGMII is supported. If the bit is set, SGMII support is
disabled. Since the Microchip Icicle devicetree file configures SGMII
interface mode, enabling the Ethernet interfaces fails when booting
the Linux kernel.

Add pcs-enabled property to to let the driver know if PCS should be
enabled. Set the flag to false by default (indicating that PCS is disabled)
to match the exiting code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251004200049.871646-4-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/net/cadence_gem.h | 1 +
 hw/net/cadence_gem.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
-- 
2.51.0


