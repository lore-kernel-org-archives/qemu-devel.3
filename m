Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C76CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kCI-0002vT-KO; Fri, 17 Oct 2025 09:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCE-0002su-2L
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kC9-0004Po-HV
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso14361555e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706508; x=1761311308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hf/fX2rpCUP9IbKU00LmPKijOrrmaaRZ3WsqBQoJa5I=;
 b=Fdo1lgjyrevsp6YMCa7rmGoCmhHAdxpACB/jOErUzh91D4qB/tMZfQeS7qt5Zr9oLF
 a3rbX01b2bDh+3uzeQYQNWFyfvjz2isiBKUnERzH6pNMcB0cznM5GV7kl+S5crr5Pg/0
 5RVIGMo9I5Sqf7mwgIzwaO5XQ4Z+LJHwFYEVNhUrMxCf+8LNt63es/A/Yn+nfvN+Eq/t
 PA7qy8WhGqOHAvnOZr8g4NSHGaGWr3se+1OwFlU/3Y5CEmFx0U4ybGSWvoAVdXq/UemY
 xEMvDHtjjJIxzMabOAUbJEVzFh4356Cv1xmnUwLpTrtb7GLQRm3kiqgyK58YqwBQ2ZEL
 EZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706508; x=1761311308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hf/fX2rpCUP9IbKU00LmPKijOrrmaaRZ3WsqBQoJa5I=;
 b=wvw4j3D+q3bZx3e1mQmyGNsRhmkxTxF3toQ/kstSxKoG7oa674l6XPhxBziFb+U+dj
 vP7S3btzXILBHu7hRrdwXLQ97vkUDovRP8QUrCs1e40fLngfJDO1pa24ghR4a7afHz9x
 yTbz04jksbCZGpDyL0cwnqop6+bArLuN89VNCA7efMPkIgj1HNxOFq8tB/CnXqacXf8X
 Fg1Zsy6ipYi9OXN66QK6YO1f1Hnq8jvG2l0UNM2J4tpW0bfl+3fnuto+14nFdzfSTAe2
 YL9TFxRfVL6l5PN5C1k60Jg6guOGVfsuxHeVHtNZ5AaGdXvmrcsWgRnBox2dtvtepogI
 RSCg==
X-Gm-Message-State: AOJu0YzBeBag8zCQ1a2d7+S3YPexiEpF+qHsrAAkU9lAo+kqlOSEY8kV
 JnZNZ7EcuIVvdCV4IOePo4CMUhVTG8A0w3PSnabqTHGru7P5kSVxM2Pt0kqRuxiArOAKTJ5W84D
 8phd28Z4=
X-Gm-Gg: ASbGncv86M1z3378Rifs7lVsbjRSvWmyr6L7IjU77RuQmRAjBcSbuxnWomE76Q8tYpH
 wQWhxQ+cvtYT22OhrD6+qCtHj1L/1rY7c561CK8QbP4ND0oZmsSdMxt3ILRbegTR4yioEPejf+O
 UKoPmaErDGL4uzCeKZys1w38V4KtAUiqm/CEqomZWAkgQ4bzwqGv4uifOU8IUZt/LqfOorJiZHE
 U4X2zUMD9mYfYT8z5WM0YgeBlfcSijUJvL5QYgYyYfuTZP19m5rXxmptr9rcR5piKzDvNb4EtUN
 LphVVwfSmLOISu2wQdm/d9pjUIod0evUpeCguHND6Fkqus1rYSwBvj0rNTn37zn73gCqmRPfDmb
 +Lpz1+wIaDmrYbadHQOOcSESqjuJBDE6VNhJMXDgOWj3KLUjnmlmSjfNFnK+Ejxo4LH+Bo13KVF
 E8XXB6Si9jiuiCjeWQ9AyHEeF9D+atfE/s8XImqDpp245Y7bGqzg==
X-Google-Smtp-Source: AGHT+IE8kWKFZcgmjbvULkqzf9/vo9AISaCKD1GOzrbmi+IgOldWjlPXVOABXPr+fxBRzKhW5gnc8Q==
X-Received: by 2002:a05:600d:62eb:b0:471:6d1:9895 with SMTP id
 5b1f17b1804b1-47109b58f90mr34356505e9.14.1760706507670; 
 Fri, 17 Oct 2025 06:08:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c29sm83548605e9.12.2025.10.17.06.08.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:08:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/20] hw/arm/virt: Remove deprecated virt-4.1 machine
Date: Fri, 17 Oct 2025 15:08:00 +0200
Message-ID: <20251017130821.58388-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a7..ed81f3fe8d8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3701,14 +3701,3 @@ static void virt_machine_4_2_options(MachineClass *mc)
     vmc->kvm_no_adjvtime = true;
 }
 DEFINE_VIRT_MACHINE(4, 2)
-
-static void virt_machine_4_1_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_4_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    vmc->no_ged = true;
-    mc->auto_enable_numa_with_memhp = false;
-}
-DEFINE_VIRT_MACHINE(4, 1)
-- 
2.51.0


