Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B44C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z7t-0006ri-GP; Thu, 17 Apr 2025 19:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7n-0006mF-HZ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7h-0003ni-3s
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso13327215e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934303; x=1745539103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwNdCVQK4SCHhqiHgDn0u2GpHg+WdyoIk2s3HtNhdH8=;
 b=CMfc+wPP1hV2v+nhzRNG8aPPWaCzFaCnBCyTsYgyuai+m+tSaVswu2aBMwV8bPq2Gv
 sPKV3jcadd7SSPEZgDgxLQjNBklNCqQu0HAnjbJ3TWA98XwF6opPi2i1DJArFHfJWcyH
 jQUObieQadHb8YKA98CmoN1c92YIDXQ7FQ9g65R+zZqZn4OC6z8jR2C35FUQAJZhjA9v
 VcRAE9fI8EGtvHXfiMA3ZWBtQsjhIts7zUyajKn1GZQhcejZVENZdBHnLOp7aYApb3PK
 BPOUPV1A2HA6MZU7oDvvVCkH+HfAsICBh8vneG/k7vXj8DOA/MZOg2/PZjhVwqs4TaSF
 YDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934303; x=1745539103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwNdCVQK4SCHhqiHgDn0u2GpHg+WdyoIk2s3HtNhdH8=;
 b=AkEz2j3akT9bS6gf0lpq/kgWKMT/nTc7JXp5jeynv7fFmMWwNLNpLZPBIBhHJ/xwiH
 kyqHtslCi4y/aRgWSEKezfIZAObcINJ9idlY4nNVatoAwGXMP6Tz+mQPHYI5k85N08gd
 au5wflrg9PC8ufrnwL1jRGSPGPxd48a1n4xg7CARyKJMUz3a0iwnic6qAo2bWvnboCbS
 TXVQY5+f4xOKoTsRbtCKPJdtTy6/XKj0QmLuHY3YJFz2L+mB5kiNO6ZrNp1cp99BT+qJ
 +Xij4X0u0jC2NG5KMTKq1/fjX1B90v8mosuUjEfE2Rg5lm0tqZIFd1nZTxevZ6DP9Svc
 gefA==
X-Gm-Message-State: AOJu0YyWhKk3CmaUQ1oLcl1RFlmfqKRCH4/oweRXfba6LEjnLGy8mGcQ
 rBN3Wl9tYfCn3Fy2aHOLBRUO3YDFRjp8jgU3Yf4kLrVKgUBmVe3sdWPu+5RZ/TYc7HrB/I4VfBW
 t
X-Gm-Gg: ASbGncuS718HcLdkof1j5KJ7QDZ149oXBw/RfIZRVX3UUvGdUkZze3XCJ6TPOumH4wd
 nsNeM3yCAk7lzKitF7sejjlfnYcxtBV29M0NpEUiJAgc2mzTgAB0+JuXfIDaBWIyIMS18QzycrB
 ZftMMDinsu+mnMwnz2N8AcbbGhdNZ5A2yjlwLhAJPMEBjdx9Wu8V43DpGdg601vRapR6/igyFDD
 EJxlo5EiSvvoKMeW7+U6/wuLT/LEQrdG6jHR8RfIY2cByM9EWdFbMVCDEr5BS8f1EP8KruH06sp
 ixrpmd2YM8OCl8C4wSTbmLniAdC9Td3yua9fJMet+Zvv1ZROuaFqU0JsAnzYdLB1BrzHut0cpEG
 F3MyEyKW8h36rxk4Ochoy
X-Google-Smtp-Source: AGHT+IErtzPSFj9GXfw38oQh5m+6oZfqUFZlco3CjCjD7fJ8H8xaqXAOUPVmjtBEhjft2XN9zFR6pg==
X-Received: by 2002:a05:6000:250f:b0:39e:f51d:9cf9 with SMTP id
 ffacd0b85a97d-39efbb01f56mr501047f8f.48.1744934302803; 
 Thu, 17 Apr 2025 16:58:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa421c79sm1074033f8f.1.2025.04.17.16.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:21 -0700 (PDT)
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
Subject: [PATCH 01/11] hw/core/null-machine: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:04 +0200
Message-ID: <20250417235814.98677-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
 hw/core/null-machine.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index a6e477a2d88..1ccaf652eb4 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -42,8 +42,10 @@ static void machine_none_init(MachineState *mch)
     }
 }
 
-static void machine_none_machine_init(MachineClass *mc)
+static void null_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "empty machine";
     mc->init = machine_none_init;
     mc->max_cpus = 1;
@@ -55,4 +57,12 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+static const TypeInfo null_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("none"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = null_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(null_machine_types)
-- 
2.47.1


