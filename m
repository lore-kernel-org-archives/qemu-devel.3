Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25EFE77186
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB3n-00066D-8j; Fri, 13 Dec 2024 14:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3S-0005an-C1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:29 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3P-00071B-GR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:26 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e15d9629bso528382a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117022; x=1734721822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNM7GoGVjyi9pb6tl93/GE1pyMMqg1z6U/rJvq0HOPE=;
 b=Kio51QSThz88XZ7IqsIPF0CupWyYUBZT82tpVw4ixlr9pcnKvywGlVqfbQTykxdqg1
 nhuUoRgLlW1Q2Sm7HLgxJb1ppp/9DxHUQ+IXpuiDC527lQUxaL9tGhRS1iBjli9lOTw3
 xbg4WGkX0CAkQUbc6S5dZ8lFOV8uFjtU6n5RcZIxWoVBT/wfjNJLlZFm1kyO/evoP7O5
 xAtgaxBxidYpmjunbJyY5UikNmD4mcr7FuDKj38/ObzaxoXbmhgeaq3fAtxcTtmJnBC/
 EKQD6Fum5atlmXidGrrolpSQb3uNhxP9XmmtzECgq5mfSb3ljn7Vmgsj3pxTKUT/yz3V
 2GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117022; x=1734721822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNM7GoGVjyi9pb6tl93/GE1pyMMqg1z6U/rJvq0HOPE=;
 b=ccA9puFoMqWAS73QfEtXuQJIbEsccgoRzmJ4cewGFBo4jMEK2Cw1BCb8BS/RjM7RKD
 ehML1HALX0ZzOsz84CVPalJrOpc7oEKXOUZzO9wg31ENpLMXNTgPoCZ7TIW1+BXVGi5h
 XXs7Tr3CYSCfeYw9GC9MuQ3xZX3ImJREs7DAYagSjKL1mMoAINGqFIjO1Kh8DoN36+LT
 hfuDPklgxMqKgYcMWpgh5+FZfxREtdjQBbndrEksMswZJO8Kf5MgNJ+4I0RsNGepLvI9
 aXmmM27wdbksq04SDypCcCxgqp5jRnLFsDub1nbWYS5QvDwQQN6WYXVqetGPVzjpISQb
 RJpQ==
X-Gm-Message-State: AOJu0YwEXUlE34vD8IALybM5z8v7nmGJ7cVkS7IpNPpdxeUCBhs/X+f2
 jc9VUFLJzpQlUXRQ+V+COXwi/uLEzeXQSPAjoU1GpkSMXma70FRiTVAFSmtJ1nDzaRDx9JL9xvF
 rhUWA5sJU
X-Gm-Gg: ASbGncuupQnRhnpwL7KzfuwRT8eFoxuqU+ILlkx+qeSa0AUohJ3RUrxToVw/2mbSNrq
 l5gorcRSPYT+qo4UpHdoqw7O1Rq/R8g2qyVEKi37xKqsGgU5hvgvOgu9c+yyQ0AGctu32+/5iii
 3JvstvZ0WhugXdlMU1WSdoWVHacKdArzbsXpzCmsne04iFn9BLpj9LbGEVA4jV9IXC2HudM/E+4
 1eCuGEJI210pcw1R6eu3OJX7rPS4BVnjDQ7TX+4f20Dtg1iXcGeLw2+FhtY8N0P
X-Google-Smtp-Source: AGHT+IHr0INjwVzgtiBXE9quaOGtoLF1XTz33VkEZb2w7XZaCpxw0pkK4Ss/q5sPUZy5df58fe/wsg==
X-Received: by 2002:a05:6830:658a:b0:71d:e0b8:5f0f with SMTP id
 46e09a7af769-71e3ba43471mr2152421a34.29.1734117022151; 
 Fri, 13 Dec 2024 11:10:22 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH 27/71] hw/hyperv: Constify all Property
Date: Fri, 13 Dec 2024 13:07:01 -0600
Message-ID: <20241213190750.2513964-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hyperv/hv-balloon.c | 2 +-
 hw/hyperv/syndbg.c     | 2 +-
 hw/hyperv/vmbus.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 3a9ef07691..74897b1604 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1733,7 +1733,7 @@ static void hv_balloon_finalize(Object *obj)
     hv_balloon_unrealize_finalize_common(balloon);
 }
 
-static Property hv_balloon_properties[] = {
+static const Property hv_balloon_properties[] = {
     DEFINE_PROP_BOOL("status-report", HvBalloon,
                      status_report.enabled, false),
 
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 065e12fb1e..0193addd42 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -366,7 +366,7 @@ static const VMStateDescription vmstate_hv_syndbg = {
     .unmigratable = 1,
 };
 
-static Property hv_syndbg_properties[] = {
+static const Property hv_syndbg_properties[] = {
     DEFINE_PROP_STRING("host_ip", HvSynDbg, host_ip),
     DEFINE_PROP_UINT16("host_port", HvSynDbg, host_port, 50000),
     DEFINE_PROP_BOOL("use_hcalls", HvSynDbg, use_hcalls, false),
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index b36bd3d67d..3d1f4d14e8 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2346,7 +2346,7 @@ static void vmbus_dev_unrealize(DeviceState *dev)
     free_channels(vdev);
 }
 
-static Property vmbus_dev_props[] = {
+static const Property vmbus_dev_props[] = {
     DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
     DEFINE_PROP_END_OF_LIST()
 };
@@ -2653,7 +2653,7 @@ static const VMStateDescription vmstate_vmbus_bridge = {
     },
 };
 
-static Property vmbus_bridge_props[] = {
+static const Property vmbus_bridge_props[] = {
     DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.43.0


