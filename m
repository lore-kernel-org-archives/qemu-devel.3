Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877A2C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thace-00076o-6F; Mon, 10 Feb 2025 15:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacP-0006vk-E7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacN-0003eR-Tz
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4368a293339so53823215e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220178; x=1739824978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwT9zD93oS9oyB85S1H2lF/ogmFYt+eViNb9oxoTPgo=;
 b=vGki82AFfU0K2Rw/dPpHZ8il91fYRw48385JDyz2VYv5r3YYHyxCTrVBQpnjmvUbos
 rCgBvDqskye1I8AdZkpCjkY80zEDkLDvc7+oV0xwo0RKUtAz42CAnsg+sGCjE3R+b4aW
 6CHxibA25Xd1ZQrGeDKhk9eePsDZHjmSPpyJkMlAuDPMjt9LrW+9CjddVd7+ETQSB/nA
 db+oAsLmOBJV6HIKAWsETQW5eSA++byrXBgIxtIrbGltKqjWqukyf5PMCb4zBr/Lb5RU
 VokXiHO3gqsm8AbHIbz+EXX/q7ps+wtQs9pKC7HdC29P8/Ch3ErRvhxWT7YJzAB1J6CY
 q2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220178; x=1739824978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwT9zD93oS9oyB85S1H2lF/ogmFYt+eViNb9oxoTPgo=;
 b=VqqF5IjbrN4xAC/h0e/DsnwXmEgMU96hzPuvQe8njRZ4+mh3hPK7Iq4pke4IOTmf5T
 Udrzw++dg/KsagmZiXPV7Gjf1B0jVcEbLsP26XfyaFyZ2gU5D4xN5Jcu9dkecCiOF+Af
 Gh/jqWyhUHpqGXaDLItpu4LQVRhL+tECUCc42kLVOwrLUhImDrkuLW0AW6gIHT5oyoS6
 TQENzB1q57864JthOgBAGFViTFf4A851Sz+hdfGKC7oz3aFis6UiiBIicMiza7o3u1mW
 PD/Ibc/uuVxukOiAN+pgf5vlJCQBT0Qnd+nz1UtlKenwlpF/+QsSbqZ6wqvMMN6p4O++
 378g==
X-Gm-Message-State: AOJu0YyFZ25m8mDWyQcC3w5wYCkE0yeix5C2x0IDGB/ep0v9GH0kctfk
 w+kEoXUZZhYn/fcF3IqlV5TFLGiu93k+/7a97OeE7O66FpBAx/RGoBlt1CNzlCjtm5cgDlwIY4X
 Z8AM=
X-Gm-Gg: ASbGnctJNchoZIsfP5Hzk5Er97VdaXMEg5IhbSoKkrV1gDe+4Gku0Zr/IercxmRJzyH
 0D57XXJMDrt+2V4wtpFyAmdAtJ2qAfrA+wOsU8wrPn5kHUFoTSImpG2QQbaYxFz4ROAxAHe8Xdr
 AZgJVQ4PdER1Tr3r0LnB/jOnlAIw5zuoWlWQ5snaOkJEduWNKTPZcFCbGHIhyMIZVQshXw6Aqtb
 q3no3mM+DhR30C//1N8Z9XX/hoV7daUHDVhQ37KmUzViMDCB7Hm5Nx+7lvlpEMY5GrcllP9a/mU
 pHVyFo1bTKjdYHCYZuZhYZJwZzyaM0eEdfdOiuKeiJhjYF8q/ZyzVCSNJZbZp2o+fA==
X-Google-Smtp-Source: AGHT+IEkAZ1IWJfrXmVsC+WIlnANHvpOxz4Y2chNl7EfHBnk8qpy9tDSIJKQUolQk/XW3Psp4TZEMw==
X-Received: by 2002:a05:600c:3d07:b0:439:4700:9eb3 with SMTP id
 5b1f17b1804b1-43947009ff1mr36068765e9.3.1739220177915; 
 Mon, 10 Feb 2025 12:42:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dcae80dsm153178905e9.22.2025.02.10.12.42.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Subject: [PULL 10/32] hw/sysbus: Use sizeof(BusState) in
 main_system_bus_create()
Date: Mon, 10 Feb 2025 21:41:42 +0100
Message-ID: <20250210204204.54407-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Rather than using the obscure system_bus_info.instance_size,
directly use sizeof(BusState).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Message-Id: <20250125181343.59151-2-philmd@linaro.org>
---
 hw/core/sysbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9355849ff0a..f713bbfe04f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -323,8 +323,8 @@ static void main_system_bus_create(void)
      * assign main_system_bus before qbus_init()
      * in order to make "if (bus != sysbus_get_default())" work
      */
-    main_system_bus = g_malloc0(system_bus_info.instance_size);
-    qbus_init(main_system_bus, system_bus_info.instance_size,
+    main_system_bus = g_new0(BusState, 1);
+    qbus_init(main_system_bus, sizeof(BusState),
               TYPE_SYSTEM_BUS, NULL, "main-system-bus");
     OBJECT(main_system_bus)->free = g_free;
 }
-- 
2.47.1


