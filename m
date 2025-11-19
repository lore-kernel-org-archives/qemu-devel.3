Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0E1CF58E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 20:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLowf-0002rd-RB; Wed, 19 Nov 2025 15:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vLowe-0002rH-AV
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:38:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vLowb-0007Ez-EV
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:38:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779a637712so1198165e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763584698; x=1764189498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTU5AJv9rSlIrVi5LXD3BPXP0DBJ54feNZIIwrMtGz0=;
 b=ETVwiB8Jb81KhDAFiWrJtKO2W45+FFGk+r2DiKWDfQyCrijX4qdc/a2nNQ3ST+YiLd
 Z0qZoSesy5XBOtvm98mcRuctuqlJqQZuzFFNoIN6H+vB3AjM8bIpOe8haO6VijxJqUFe
 j1NDo/e1XW/GdFaccH4FwsrtE+twqxOuSEcx5KixhidG+Nik51PCJvbU4UWa7+iWPdQn
 8HXAJQOW8Ci5vr8A4xD6OS7QSsKP+u+DF8vmbIqa4h0HkRJwDE6W9PU7XBwGxECWDSGO
 GDaTjvx/bq8Ikco0w/YTVVKfleSt4hjulfeaDws1RBZJp2Sf02Rm0hoonrH81E1RL/hY
 epAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763584698; x=1764189498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTU5AJv9rSlIrVi5LXD3BPXP0DBJ54feNZIIwrMtGz0=;
 b=COdkZa1bc4eDbhrhEZONAr4uW2vWnp3vbnMSdzsgNfh06FB0sjr7/Lk+61xPnA6LRA
 kJlYcEKBFgIA5S/3m5mMEWZWQTsj0DHWMSNFNZxHxiM4IubKWEN+iEjNL7R7ILt5T5ud
 lNAZl3HMw8qUhGUcwv9mhOitEcgCfYHV5wHPvW3vFaRkakhnuyAeMa3xG+fyEMs3S6T+
 4FlE2HLb4+RVYpiR7Fak8jv8yDnvfLHQuW+zgKIW4CyaSaZ7V/Auej1jPljK8YQUB62s
 Bg+w6rEmoRhvQaVIKZodZfRnBuyyWZPmoTtdRgN8XRVMpb1ODkzIgBDgSvSxsspyJNM2
 pXfw==
X-Gm-Message-State: AOJu0YxCA04EWu61fC/h9ltUzDXHlxO4Cftl1xifeLZmFK/lO7ary/vC
 qSzaMROB2rHIxPRsTrvrTqcr+E69CmvE+Uv8CsS3MofoCOFxs7uDfWDIu91mYA==
X-Gm-Gg: ASbGnctbeyFpzQiwla8YMnWGC46tFBay74MQ81TWDrrI+x+72fEEt1mohzURvmIWRHp
 qIIHV+ARLgMVZ+LKL835/Hq/ypdwvhUOjTqiLp5oDZMfM1jSEYJye04YZfuN5GAbZAtkgOuJvTW
 cuuBqxugUhCIUFfi1SbjECae8cILoAzpq5WoU+VsZTW10sQ7B270zylJv7exR1UgnAv1059edgv
 uxoiXoqsqDHzNX2iCbuqucG+jLeS/VVcFFqGLttuibEA7CWbyxCO1T5Xu/cSpg28tM0g9gKQ6am
 WvnqL+ZyTrmqMOnN18E5IZAdqOu30HC/RjAT/H5vr5ck1hZAjVc8vCgIJAc2vqnGNwzkfyuJDK0
 NvSUSCCjqDMnmhRAvHl4EPhSEb6NF+0ucH07+S8YFzL6qne4kB5ldl8csBZdI3sp4OsH0gmd4fO
 aflzwFH/DMTD/BXH1M8pv2645nfubmbfZgv4yyMqd/gIZrp4mLX7IavzBiXbfoYL8VvvbXeQIub
 hV8+Q==
X-Google-Smtp-Source: AGHT+IHYqA51Ows78jeeZK9wk1Pf8BZfYPElbC74LxH5mGYnLJCScE6yegcrna0Ew8plEC7CplSJoQ==
X-Received: by 2002:a05:600c:524b:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-477b8a95f5bmr5553655e9.17.1763584697555; 
 Wed, 19 Nov 2025 12:38:17 -0800 (PST)
Received: from archlinux (dynamic-002-245-001-202.2.245.pool.telefonica.de.
 [2.245.1.202]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffd37bsm68266995e9.3.2025.11.19.12.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 12:38:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2] hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only
 build
Date: Wed, 19 Nov 2025 21:37:59 +0100
Message-ID: <20251119203759.5138-1-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes make check failures on an aarch64 host when QEMU is configured
using '--enable-kvm --disable-tcg':
  qemu-system-aarch64: unknown type 'arm-gicv3'

Reported-by: Cornelia Huck <cohuck@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>

---
v2:
* Enhance commit message (Phil, Cornelia)
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0cdeb60f1f..7877506384 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -623,7 +623,7 @@ config FSL_IMX8MP_EVK
     bool
     default y
     depends on AARCH64
-    depends on TCG || KVM
+    depends on TCG
     select FSL_IMX8MP
 
 config ARM_SMMUV3
-- 
2.52.0


