Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C2CEA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAD-00026N-O8; Tue, 10 Feb 2026 08:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA5-0001zC-NU
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA4-0006KO-3D
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso47910075e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731534; x=1771336334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=adjSQwHk3KULK9zaYzFCqBvXl4nV3J4QFwlScJUJ8xc=;
 b=pj24DzaKM5Tn9WIc9wjzMu3u3wRgkP1ggHGUlqwxMTA6KzQPaX+Rkj7rdbXLFIgp0Y
 lEEqY1I6bnOsJNeYieNB0vf8l3qFxsJWxWVJQJ2Q6NnGFTnX65uf2yo0vAhXCEs9aTq5
 ZXvNkcDOMbaWO80avzirj3zg6hbAjs2FDwfO3a4NnK/N6qLXi3AQ8Tox+NAxQ8wXepAJ
 7i7w5LCncRYi5TkGeNy4pjQOgr3R6mJJOR503xwGtDDs88niDURsutWgK+j8wMpXpBzE
 R2WsYSoSwOQkknILN3XkzRqpljBiUGoOW1ZqL4lPmLrnuTzITEXARlRVXVbDXdhWP4we
 cLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731534; x=1771336334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=adjSQwHk3KULK9zaYzFCqBvXl4nV3J4QFwlScJUJ8xc=;
 b=HV7UdCevBpCXVOTdKYDXDflNbnAcs2L87Stf0OKahqv7mLKLsFP4PpGhV+vP6qL3kv
 33r+MfqI6KJxDfM4iJ+JxbrDw4VFUZNOqwL7YzVB1WoxwSPNpUb3hek+YmUFOSoi/GRx
 S3qTs8ZHdukH9Hza3QM8L5Dr/nKYGTuj3zbKC7EMyJC73eSiXLUfTu7znCQE8B+YOHq4
 2xFL2GGcOI4f20qLMChUK1/iu4MlThZIyUlK3AVs5SdT/X9P1G6Mp9dzqBjQOP/4Cdm6
 KkAFGaHJSzvmvQ8zVbrL1WEJTIFTXM/5OApzidv+yDyerNzAoB16HduuzW5bvt870obo
 K5UA==
X-Gm-Message-State: AOJu0YwZiIhfGan2thlD8ox9bobxrGkbt+h757yJDNrkoWeqQvuGEVU3
 dnM8X9djrobQTtM4TAXmJtMlYR1OvYzSzDRyKWg3NotumhYwaJ6BzcjbaHf6+pPUAcT2eJ70J4E
 0xsGa
X-Gm-Gg: AZuq6aKkIjXQDojWAFHyROuzumIIeq3mCT4foucOr9weH1dQFKpJmxVRihcCRjglzqU
 Vx4PYC3ZSSFNdwC/cPVXKd6xzvUCcMZc7+U5bkIhriFNZZwDGf8kTPa4Nk1vhPy8GKmiegLq8OS
 ub8Fvx19KE5tr/HkUc6hOItYd2VHJvTgY9KdcNrM+XNgoP1I487PoEOK6HpL30Y/CKwd8j7DQ/K
 4/o5lac6tpLBJciYtUvlT0Pm5Qq4ebjgc/sA0k9yVqdSK+HpdRTlM56Bquc/s05jbcls2g0Ovcu
 p4cnTdSrilyU5iwJiQv+gNbNGs9gus7KI6OiqNd/NojTnGAKPgDarCCRv4R4//RRJ2goWM9x8Dj
 i1j7zf8CIaUoRDmIZ0meFyW4h28k9Kc4Qh8xZdB8oM8zBtS4gGevy45h/PrVbd8PMYCy2E77tjH
 MevsKorZBJAyHpD5gtAcTqIWERACQoGq38ccAHKM3fFkT+/BavAv7xXZqfW/P9skSwplHGjcAVW
 tfh4uIx743z2Bxnl3lQNJfJ0h3NGSI=
X-Received: by 2002:a05:600c:1e2a:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-48320216170mr193520005e9.19.1770731534513; 
 Tue, 10 Feb 2026 05:52:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/26] docs: arm: update virt machine model description
Date: Tue, 10 Feb 2026 13:51:48 +0000
Message-ID: <20260210135206.229528-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Update the documentation to match current QEMU.

Remove the mention of pre-2.7 machine models as those aren't provided
anymore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..f8148b5dcf 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -41,9 +41,10 @@ The virt board supports:
 - User-creatable SMMUv3 devices (see below for example)
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
-- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
-  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
-  that ITS is not modeled in TCG mode.
+- An MSI controller (GICv2m or ITS).
+  - When using GICv3, ITS is selected by default when available on the platform.
+  - If using GICv2, a GICv2m is provided by default instead.
+  - When ITS is not available on a GICv3 platform, a GICv2m is provided by default.
 - 32 virtio-mmio transport devices
 - running guests using the KVM accelerator on aarch64 hardware
 - large amounts of RAM (at least 255GB, and more if using highmem)
@@ -167,9 +168,22 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Specify the MSI and MSI-X controller (GIC) to provide.
+  Valid values are:
+
+  ``auto``
+    Use the best available MSI-X controller option. ITS when supported, GICv2m otherwise.
+  ``gicv2m``
+    GICv2m. Typically used with a GICv2. Also available with a newer GIC.
+  ``its``
+    GICv3 ITS. This is the default option when using a GICv3 or GICv4 with a supported
+    accelerator.
+  ``off``
+    Disable support for MSI/MSI-X interrupts.
+
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off`` to control ITS instantiation. This is a deprecated option, use ``msi`` instead.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.43.0


