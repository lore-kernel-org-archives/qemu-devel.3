Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE48C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uZ-0007NL-Q5; Wed, 15 Jan 2025 12:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uX-0007La-Ba
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uV-0006Xk-QL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so71877975e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961030; x=1737565830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkO7QKHSSU9JZ7UVLVh7P3hTPCbkidV6rATGTGJe5AU=;
 b=fD28RMNhfEmp6c1uGGBQPLMyvqdk5IkfpWs5Cc2v/TuZAY4sDMcHcCy1HC/wALt/JQ
 vDv1odHdzQBfl+/iz8BDtgkkkCfeKDbYERMv+xjFqCNe22fmKgRkU8Hxk9Jh4/NzidpU
 z5HuZv6u4MxEP/6BfwjVxVMhKv9ZgfEfao98sVA3ZbJEkdxDqGg+b9/o5p8Cwr98rNh4
 /knH7yno7qpCKqRIZhQgnPpzbQiCNEAIoo59SNmv4VVhlP6Wru7K0jFCjz8Of6zr1I4H
 2Bn9bHCNCSpFeBO6BnlTUIhYpG0VJ4wP195bsE7lFU1PzQWpwLkf0qYR/Su7M/XwI6/U
 ldNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961030; x=1737565830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkO7QKHSSU9JZ7UVLVh7P3hTPCbkidV6rATGTGJe5AU=;
 b=sOjsQDWbZROLl2dT9ZAUhj53ew1WO/X+/opxGO3FvMM0v1qhyftrbnEjoY7I9f97uC
 cAW57FV+qx5hnl55qJRAyWJC2ANSEzq5A5xC+06CHyr2/AS6nqc23Nyq531xkHTZP4G4
 iZnLibjIxpbAQTLkeKAvF9n+EukPw412TLAWUtV9BGoAF7Mu44cLco329IEPfFUIr6RO
 JYyzYRyXgwvFDiNHrTf7lGRKtBRGyD8H7UJzM52WjZgmkVE1ry8kG/M6u5K/nSw6lCK1
 m8dsYgQVdK0w6nSUyC+IiFd/pbLKCUvjhKgyule6IK2Hs5YjRqita3/XfUEPAGMuam67
 sQ4g==
X-Gm-Message-State: AOJu0Yz2JURpbCbgXUlPvtKobXt0Rq3CUEtW260LN3B1i4L46kiYtmBx
 mX1Q6+D6uPFK7xY4guEhL54kVvvcsF7YBuV50M4ZGKpXoVZxP5l+37leKhgyZyd0jPYLqhQKU2j
 mSg8=
X-Gm-Gg: ASbGncsPlRB6/WWHTj6R3wUNpnMWys+eA4okaXueAAyEQf7mCCjsPkMcOvFX8t+Nls1
 iuzlwYyH7NDB5REJcLZu7x98B9BWTSL9QRRV1dcmq7sgKsC2VwhMa/0/hmDg8C+e6FIyvIcp3eR
 95jPm19RcEcV9zI6YNgRizuNPjnxaLiIyfDyECRB4s+F6AMAWmYjjEp8lR/3F6aOONG0PDyYgdX
 lglwYtXoiULOFQ7vHEObgUPXUWTtcCtvPJHTlWFD11F8vmqnkIwwfPs9doIOblGnb4qh0rhviIC
 lwxX723WuFAddHMVL6Z7b8P5kZtthNag02g2
X-Google-Smtp-Source: AGHT+IHt86hKvlML0gTfYHRjrnjDz+M7M0iTGTXKTpXHkkydCvFPrk3Zi1j6+jGrVxKADfXOe37azQ==
X-Received: by 2002:a7b:c315:0:b0:434:ffb2:f9df with SMTP id
 5b1f17b1804b1-436e26adf94mr292003035e9.17.1736961029857; 
 Wed, 15 Jan 2025 09:10:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1cf2sm18303571f8f.99.2025.01.15.09.10.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/13] hw/arm/virt: Remove deprecated virt-2.7 machine
Date: Wed, 15 Jan 2025 18:10:00 +0100
Message-ID: <20250115171009.19302-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  6 +++---
 hw/arm/virt.c                   | 13 -------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 813988fad4a..435f081d805 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,9 +1065,9 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
-Arm ``virt-2.6`` (removed in 10.0)
-''''''''''''''''''''''''''''''''''
-This versioned machine has been supported for a period of more than 6 years.
+Arm ``virt-2.6`` and ``virt-2.7`` (removed in 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+These versioned machines have been supported for a period of more than 6 years.
 
 linux-user mode CPUs
 --------------------
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2a2a0bd9154..7747dae4dc7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3573,16 +3573,3 @@ static void virt_machine_2_8_options(MachineClass *mc)
     vmc->claim_edge_triggered_timers = true;
 }
 DEFINE_VIRT_MACHINE(2, 8)
-
-static void virt_machine_2_7_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_8_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    /* ITS was introduced with 2.8 */
-    vmc->no_its = true;
-    /* Stick with 1K pages for migration compatibility */
-    mc->minimum_page_bits = 0;
-}
-DEFINE_VIRT_MACHINE(2, 7)
-- 
2.47.1


