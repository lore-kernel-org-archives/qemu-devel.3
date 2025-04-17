Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324F9C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z8G-0007Ab-HE; Thu, 17 Apr 2025 19:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8E-00079z-7N
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8C-0003wI-J1
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so13869775e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934334; x=1745539134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXmcwYVTU4L9Er4BkpjqN8dz0sYT7bRQoVVZQuGVa5c=;
 b=eWW/rGz7gyAkjB9n4/xM/0D7bALy2i6b0ODl1zy/Z9l9cECg4JsfisZy6igp02nWSv
 InSCfAwmQgLLrrVT/UL4S8MRM2w7Ao3wdIvMs4hTYCIKkt5XcnFi4rza2609Gmh6UwBY
 kKjvHQx3Wvrt62orsxLDXEhscx62iKp5rHD7TlUI81h6Tknt1tRwlUqkvEF7VaKsTl03
 NBSTmBB5dnjTxgdi9RE4tLlgqLXgDBkYB9b+156IOK0UWoPN+Pq+47x4+LyBuqAv5EsI
 hPDX0nnD9VDhf0ziM7B2sNFZYmo8OG4hPINj+PoZMB9mLCbx4jZG3SWshExpmkMUk9TM
 G3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934334; x=1745539134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXmcwYVTU4L9Er4BkpjqN8dz0sYT7bRQoVVZQuGVa5c=;
 b=nqaf4KrBOn0P54KFF6izUtJ48Km08HoExdJ65t/NywjGb0khmuvtp5OpJN3lPSim9A
 /br2V9ztABb4PeJm2lp+RAMZeFFMiCnRuNU71RB32dLwUCkPBVvTKoI0Hy2D/qyr7WP4
 RLbej4VYnFry5KDeD2Dzfp5iKTVvL901vW/m+033XkUoysuFp3rUabdH9D/aaLvNRTs1
 n3uDO4nzqBtob19igVBv9dA+pGV1W6HT88flGWS9D0jHsbrHwNd259GrhR7CwjXCLRCq
 WDCbvDLab0gvR1Wm/UQI5crrhUqozrIyrAFc/9RXZgwO86xqyTZgMPgoUfbV/kkXk8kw
 rQYA==
X-Gm-Message-State: AOJu0YwRQzW+5IW6F1446giPf1whQ3dQDQICat0GhgzN/fx6G7WVrolh
 GGS7HszoNLmQCBiXGSOdlouy+cz7kux9kqH8UQdpVe/UZZ+MAM0sxtvilOwJstN2+82WDq6vIR8
 v
X-Gm-Gg: ASbGncuOvgHKI1DG67nn7UswzlrYiLJaehoH+fBfXFC0posorCh4jW89gJpqpRhCBV5
 NoLsWVkoP4PA6UBqEfLS4Ts35GI4xoxRFRfrybDxQgm4+FJhj2UdHmoeMHVKwWeVdI85UdpeXq7
 6IbO/PhHYOk1+8y1UcH3q64Wd3qNK6kFq8uUJKPQaBLfJO1g1j3wBLytk4nL4BzWoPkinXbhObN
 PLEB/WuwfhWf9MQXEbglfInPxxICLPvEKaaVkasRiP0atR9F7aKeb3X8rOql9qHCvOpL3u4Sa6h
 ZfvN7UTEtyQCUbPReuxhtk3zXgzfuc5q/bnA5TSEr1Ktn2OqdQaO7Vjx1P0Bgx/LXWuezntStoC
 Gx8zRRJYr293xZWiAxVaS
X-Google-Smtp-Source: AGHT+IEa4QsL8kYXIznZeaN0S6Qu4A+ZT7KgnZdEO66l6OAZ1zUuPKR7teizmiImXLqmM8swOrPVsw==
X-Received: by 2002:a05:6000:1acb:b0:39c:268e:ae04 with SMTP id
 ffacd0b85a97d-39efb947474mr596531f8f.0.1744934334502; 
 Thu, 17 Apr 2025 16:58:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6e034csm800435e9.39.2025.04.17.16.58.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 07/11] hw/arm/kzm: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:10 +0200
Message-ID: <20250417235814.98677-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/kzm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 362c1454099..b56cabe9f94 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -131,12 +131,22 @@ static void kzm_init(MachineState *machine)
     }
 }
 
-static void kzm_machine_init(MachineClass *mc)
+static void kzm_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM KZM Emulation Baseboard (ARM1136)";
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init)
+static const TypeInfo kzm_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("kzm"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = kzm_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(kzm_machine_types)
-- 
2.47.1


