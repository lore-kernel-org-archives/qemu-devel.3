Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBB9D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krN-0006gU-O4; Sun, 03 Nov 2024 19:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr5-0005Nc-BA; Sun, 03 Nov 2024 19:22:06 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr3-0002kH-JH; Sun, 03 Nov 2024 19:22:02 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720d14c8dbfso2325857b3a.0; 
 Sun, 03 Nov 2024 16:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679719; x=1731284519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ftki89nEYstrfFSAin/yFBIlJQIjomoZE+uZMXBkVss=;
 b=GvB9gOVu8LFfncOekovFH77bLyXmdcXz9QF8+wMZOWYfZVNKUbYZ0zq9Yi4MqEgHcb
 tWoDF8IMyjYQ1zfgOyro6+3eoPQ0YSh6KUW+Z17jwPeWOo9CSuX6h8+6PrRAu2ElSpKx
 oxKgcT1f3v/60nLBIPXOcDN/1D0tN3DDKks+yYaI+QXe6sGV5kTb/upmBvyfZDw3NWz1
 IYZnkUPCdJNe70q4Iq94iVbfHcfA4PInJ9UQ3ThddST5fD+WHUGFPe0lEdD25sFR23sG
 +tUDOq3CN2KnC9R1OBVt8TEhbD3fM7iZF7vXnFxC7kc8Czrn5Ujhc162FOYtOgT07Ha8
 fNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679719; x=1731284519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ftki89nEYstrfFSAin/yFBIlJQIjomoZE+uZMXBkVss=;
 b=pV1j4IIYBVqGwyR+8XDVgQ3pZ7CPljL/RDVPT2TcBo7Q/rcoFTaUrYZ1GsSHD/g/Cj
 uR7sXEUZxI1n1bvse1mwC+E2pS+bu7BNN1QVEDc1nvvK/eOMAHuwz9n/tv9fue9w6wWe
 NVZDq06QNLAYSBQ/9/kUARknAbYHD8nSxauEurnJz+UWuNQh5/3L8jahK0AuWwhWpMU6
 FeGIXjN9TixnxyJoCoUPnCqsYQNglvGunPxLzEsQW/bkE4sSv3c/znefoSXFdNmBkO4u
 IXDcxc9jw2ITjbJjWvj6V9nsBHLhVzQ2Sh30wVWXuOnN6MXoEzfUQEE7svGtEL7h6H8A
 5KGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5p25Kd/4uQ4J1WG+0NmKTPj52Ro9tz7Vx2M48BUASz1fwuqeqxwr7lZYW62rLKy9VVTNzuSyk2A==@nongnu.org
X-Gm-Message-State: AOJu0YwJsOl8wEzapCSphzCeK5Tirf2657cO5kmF5aWq5tmfbfm3Bl0H
 jCCfH1Ivnd3DI6pgYwrUScjt5tCjSX/9k26auMqZtpLw1/i80OM+aF0t3A==
X-Google-Smtp-Source: AGHT+IHO1sQuIOtze6zkEGzlWozl1J1Y8MlNv5lV+kDD4mmRWTnSES24uoqlMfixeLExFDykDj9XaA==
X-Received: by 2002:a05:6a21:38f:b0:1d9:282f:3d17 with SMTP id
 adf61e73a8af0-1db91e53617mr22126673637.35.1730679718971; 
 Sun, 03 Nov 2024 16:21:58 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 47/67] ppc/xive: Fix ESB length overflow on 32-bit hosts
Date: Mon,  4 Nov 2024 10:18:36 +1000
Message-ID: <20241104001900.682660-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

The length of this region can be > 32-bits, which overflows size_t on
32-bit hosts. Change to uint64_t.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/spapr_xive_kvm.c | 4 ++--
 hw/intc/xive.c           | 2 +-
 include/hw/ppc/xive.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5789062379..7a86197fc9 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -720,7 +720,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc = &xive->source;
-    size_t esb_len = xive_source_esb_len(xsrc);
+    uint64_t esb_len = xive_source_esb_len(xsrc);
     size_t tima_len = 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
@@ -824,7 +824,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc;
-    size_t esb_len;
+    uint64_t esb_len;
 
     assert(xive->fd != -1);
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5a02dd8e02..b600546e78 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1242,7 +1242,7 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc = XIVE_SOURCE(dev);
-    size_t esb_len = xive_source_esb_len(xsrc);
+    uint64_t esb_len = xive_source_esb_len(xsrc);
 
     assert(xsrc->xive);
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 28c181faa2..3a65c2f29a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -218,7 +218,7 @@ static inline bool xive_source_esb_has_2page(XiveSource *xsrc)
         xsrc->esb_shift == XIVE_ESB_4K_2PAGE;
 }
 
-static inline size_t xive_source_esb_len(XiveSource *xsrc)
+static inline uint64_t xive_source_esb_len(XiveSource *xsrc)
 {
     return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
 }
-- 
2.45.2


