Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D0E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwA6-0001CN-GK; Wed, 04 Dec 2024 15:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwA0-0001Ak-4S
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:48 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9y-0008Jk-4h
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:47 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fc2dbee20fso198375a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344785; x=1733949585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INFqv3r+4Rnq62Eab2ceon0uXvH0WJurlI9tlF0uERo=;
 b=b/NeiQS9+dZ4HQB1lIwTmj2RGxnM45HvCIUWvOczirewaXYd5mJqGGnkkJsGYsgZO9
 QSrb7FZEJETxUEHYNhI8/bIKMfAPI2GiyzK00nf6nO/1kE4BFn6EZWzZ8EwZw1lPbIFG
 pIipINXMRp9se/J6BuxoIDj6062zZFYAkfId6TfPmxGcREBxRqBJox+bKawqKTwPWET8
 DY5Q2mUhrkI4pnzE10Y23FxWHOlN045iYLknixupxsckAAYbq/SVkY5BFFtS51P/BJ6/
 cBe0877NRGXw5XhQvhzDy7dIWwdIkB+Zf78djVoD6/kKLMF3dEEcLDJxoOgxZPxlKF3H
 P7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344785; x=1733949585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INFqv3r+4Rnq62Eab2ceon0uXvH0WJurlI9tlF0uERo=;
 b=fWFteS/d17Hzg3RZiBvd/BUrunnlIF6fxbFU3J2wI2UecV0NqRfY8SlyHaJMq3J2so
 NNAkQf6VCY6S2gAWAxei8TcfEA/sq+9XU0eKDch3iHrZbfeQH3A6guPtirTxJhGXjgX1
 2Cj6LC1JXEb6/2xq8GTBCjuNtIsohb9MiqLAdgcCWet5ecM+pnFKonxiSDNX+C/K3efu
 TEJSIJNuAFP0ZI889ZQMDzkfv6CY1QbPY/fzCysO7O7VOUj1p4b8wSGcI/B9kL4uLCEs
 6dK/6t8qIH2A+4LaGJQzaZtO/7f0FTsxdKazLZ6Dl38TcElh0LsB8/6K6J4OEWf6zzf2
 vv8Q==
X-Gm-Message-State: AOJu0Yx5ybVV5p2bg/Urj9oDq3juP3J0i+gvtDs/z2Od+0+e3SXfWaeb
 wXx/XxIKwqAgEIawew8nQhl4kgT2FFHj3qPFw6gHdhQE/6YZ6huTPLzvP4eCon6YK0EBuo7D6Ch
 Ro+s=
X-Gm-Gg: ASbGnctdGiXePJGyWpWybzNsOHPycrMphNSPDUX7WynW+9UJk3hyR2hS7Dm97oHUwF0
 UH/7BWzGGfAeHk5OeU+hjFCw693/lvGRad4VGkRu5TX6QdI79dOTgWSO3IsjKWrfYL/OkEKTIco
 2Fcyb1CiyKOSyrHt/DNVMf/fBDZB20js522dbhc9dYgicyAXkEv1jyl8E6TeenGkVFRqI8UFE0I
 sVcfJ4/Etcda7DU/qL0sv51yZjnT7oeItT6oK5UEbumDjXtMAWgfwK55vG0uzrEQzwW6lHkgJVJ
 IO9FQjLG
X-Google-Smtp-Source: AGHT+IEXwxk9YXiYm9HZonpNhGit3TZcpef++9rTEdAkFcAHlUMUvL6FptDpINRvxcL0pLYseoFEKA==
X-Received: by 2002:a17:90b:35d2:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2ef011f67cfmr9633254a91.11.1733344784688; 
 Wed, 04 Dec 2024 12:39:44 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2700cc6esm1873117a91.21.2024.12.04.12.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:39:44 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 4/4] docs/system/arm/virt: document missing properties
Date: Wed,  4 Dec 2024 12:39:12 -0800
Message-Id: <20241204203912.3037515-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/virt.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 11ceb898264..d25275c27ce 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -169,10 +169,18 @@ iommu
   ``smmuv3``
     Create an SMMUv3
 
+default-bus-bypass-iommu
+  Set ``on``/``off`` to enable/disable `bypass_iommu
+  <https://gitlab.com/qemu-project/qemu/-/blob/master/docs/bypass-iommu.txt>`_
+  for default root bus.
+
 ras
   Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
   using ACPI and guest external abort exceptions. The default is off.
 
+acpi
+  Set ``on``/``off``/``auto`` to enable/disable ACPI.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and
@@ -186,6 +194,14 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
 
+x-oem-id
+  Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
+  table header.
+
+x-oem-table-id
+  Set string (up to 8 bytes) to override the default value of field OEM Table ID
+  in ACPI table header.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.39.5


