Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E2AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcDn-0003QW-Bx; Mon, 26 May 2025 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcDB-00035v-B2
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:06:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcD8-0004p2-SZ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:06:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso21645195e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748282765; x=1748887565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhBBZquPEa6qQqozAiO207w2d4gpZ5Cgam5MtutTPKg=;
 b=qyxctcRiDPUZgc5HL8+M4RLu9f0ddjKLxiQx5nkBSnBK/i1b/MU+owDadwfc6+hFTV
 wIYunoeDxge5BoVPfsDKo97RhF/X0pqbs8rovI32mnuCtEE4PTjIS0PVeZ0hfenPWOAW
 unZmPj8NJPPcXxcl/c4MoBcV8CPU07l/X0JgXoodf700COYczbVUal6eVsEQVQzAsuCD
 DAo6oxJjac35OqcMhszwdD5F4YjSIlXkp5p7bZ/65bMkyRTGGp75lBfVkr90R9Ium6xV
 LdttSo7613/0UuMWlU5nFA0nnHD3ADhjNNI9wqHD6Oi1W8Pv6RORMX04FLR0ezN9xBn4
 NMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748282765; x=1748887565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhBBZquPEa6qQqozAiO207w2d4gpZ5Cgam5MtutTPKg=;
 b=hqOllDvvS4oqPo4v3HZzGu2fzUzmkuAGEp5tCTzYYq9DF9M9CWSM4CXJc3pONA6oyZ
 FEL1aXoPG/JB8mhyuURsa46IPt9WumBp16GyF+JJIASPdS0zwJEwpj9iRMDUMn7AewWm
 ff728LGg+7HUogLdbL881snG8ROJpRwrAR511oqK02LptFnx+WTzxHlUNimI35pbqM1X
 4axwHKxLzXe6Fvcn6ZHfUQ4aF7f9kE7cHnB931Z84IFMh34s1FNPr9G6eDlHxOWtc1cH
 rIFX+gBEDU2JRHUYzJc+Ty9sb7Q5KS16Bes34UVgJJ9MPhZkN3ov72gpRr8mktB0+ZiG
 8BVw==
X-Gm-Message-State: AOJu0Yxk3WiqWfLTsjyrQokklhTdM9v9u07dHZ2jafCanOCYWEUt7V6N
 2/d+UXS8MpL031nOgsVN6YEA4Q+y7mmz6i6KLIlGCMoK6ifkrJ81k/w6fywCMRR3GqCy/+Ltj5D
 /0jQfydY=
X-Gm-Gg: ASbGncvJ4/siS1DwjY/um66PO6IwdIk4BS8qCCv6uXslAbacpafCP6sbFJ8xNAuQ82l
 6sD80EAkMlzmqgiHfP6j1RMw4iXrr0jO5RUnuzesruGC1HsvkgDYxtaRwV60NZiChsXSw2ikyol
 QTnAqh7T/c2PLCGwsuClVXUCnInKiLJeRU5CRb44/ZnbouPPiL49MntzTCDw6QGluxMvg4yFRB6
 oAYn4Kx3iMIgsbGhi3cYWQAP3pRIUqRnb2Iq3nIsfGpvrqOfa90rUFIpeSoHZsUZ/FIl950lxRM
 mEDt2M6sZIICLSvP++O9gFo+LG3YYxQnwUvqYt0gYMbhXwtQyItL+YioBJJcRF0LyXG8bYx2Eca
 R8XtUpbcNvr6kuGuuwboguHgRZcpvsZI=
X-Google-Smtp-Source: AGHT+IG3/bXEOeWaouYhu1+H8iDVpJgTeEJK125Fkr72MMn8pa2fC+Va1h7OyrcGZjk0j/4YBwE5fQ==
X-Received: by 2002:a05:600c:1f91:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-44c9301659dmr75581475e9.1.1748282765013; 
 Mon, 26 May 2025 11:06:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cfbf2644sm7294056f8f.59.2025.05.26.11.06.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 11:06:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/2] hw/ide/ahci: Introduce ahci_reset_delayed() and
 ahci_reset_complete()
Date: Mon, 26 May 2025 20:05:57 +0200
Message-ID: <20250526180558.65613-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526180558.65613-1-philmd@linaro.org>
References: <20250526180558.65613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

AHCI reset is not instantaneous in physical world, and software
might poll the reset bits of port and host control registers to
detect completion (see chapter 14 of AHCI spec).

In preparation of adding a timed reset, split ahci_reset()
as ahci_reset_delayed() which keeps the reset bits and
ahci_reset_complete() which resets them.

No logical changes so far.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci.c       | 31 ++++++++++++++++++++++++++++---
 hw/ide/trace-events |  1 +
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1303c21cb70..7e586c7a0a4 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,6 +46,7 @@ static bool ahci_map_clb_address(AHCIDevice *ad);
 static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
+static void ahci_reset_delayed(AHCIState *s, bool immediate);
 
 static const char *AHCIHostReg_lookup[AHCI_HOST_REG__COUNT] = {
     [AHCI_HOST_REG_CAP]        = "CAP",
@@ -1623,7 +1624,22 @@ void ahci_uninit(AHCIState *s)
     g_free(s->dev);
 }
 
-void ahci_reset(AHCIState *s)
+static void ahci_reset_complete(void *opaque)
+{
+    AHCIState *s = opaque;
+
+    trace_ahci_reset_done(s);
+
+    for (unsigned i = 0; i < s->ports; i++) {
+        AHCIPortRegs *pr;
+
+        pr = &s->dev[i].port_regs;
+        pr->cmd &= ~PORT_CMD_LIST_ON;
+    }
+    s->control_regs.ghc &= ~HOST_CTL_RESET;
+}
+
+static void ahci_reset_delayed(AHCIState *s, bool immediate)
 {
     AHCIPortRegs *pr;
     int i;
@@ -1639,16 +1655,25 @@ void ahci_reset(AHCIState *s)
      *
      * We set HOST_CAP_AHCI so we must enable AHCI at reset.
      */
-    s->control_regs.ghc = HOST_CTL_AHCI_EN;
+    s->control_regs.ghc = HOST_CTL_RESET | HOST_CTL_AHCI_EN;
 
     for (i = 0; i < s->ports; i++) {
         pr = &s->dev[i].port_regs;
         pr->irq_stat = 0;
         pr->irq_mask = 0;
         pr->scr_ctl = 0;
-        pr->cmd = PORT_CMD_SPIN_UP | PORT_CMD_POWER_ON;
+        pr->cmd = PORT_CMD_SPIN_UP | PORT_CMD_POWER_ON | PORT_CMD_LIST_ON;
         ahci_reset_port(s, i);
     }
+
+    if (immediate) {
+        ahci_reset_complete(s);
+    }
+}
+
+void ahci_reset(AHCIState *s)
+{
+    ahci_reset_delayed(s, false);
 }
 
 static const VMStateDescription vmstate_ncq_tfs = {
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 57042cafddc..979145c58b8 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -82,6 +82,7 @@ ahci_mem_write_host(void *s, unsigned size, const char *reg, uint64_t addr, uint
 ahci_mem_write_unimpl(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
 ahci_set_signature(void *s, int port, uint8_t nsector, uint8_t sector, uint8_t lcyl, uint8_t hcyl, uint32_t sig) "ahci(%p)[%d]: set signature sector:0x%02x nsector:0x%02x lcyl:0x%02x hcyl:0x%02x (cumulatively: 0x%08x)"
 ahci_reset_port(void *s, int port) "ahci(%p)[%d]: reset port"
+ahci_reset_done(void *s) "ahci(%p): reset done"
 ahci_unmap_fis_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to unmap NULL FIS address"
 ahci_unmap_clb_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to unmap NULL CLB address"
 ahci_populate_sglist(void *s, int port) "ahci(%p)[%d]"
-- 
2.47.1


