Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BFCE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0y-0003DJ-DN; Sat, 02 Nov 2024 09:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0Z-00032j-Sn; Sat, 02 Nov 2024 09:17:40 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0Y-0001wW-4N; Sat, 02 Nov 2024 09:17:39 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso201796866b.1; 
 Sat, 02 Nov 2024 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553455; x=1731158255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n35w2VDiQsxwqNroL2qJeQnt4HfjJdNE+pLX1JQDjcs=;
 b=ljcOl5+v7+SMpVpuvpi/LqaC9Lcpo/PslmCREfdPC22OLSF5HiLXQKrYOiPShdsiJT
 JZ/vhNJAyeSVdh3pnHhClH8OWE3H5oOsLeBh7Z0UiD8L2SUdrEFMkcI/e7Iw3Il1AeCf
 RY4VyF/RlC4HOczmBaeXcFEiBsC0QpKfpzcbYY9jSs7jrnsjmUrC8CMeDWAEKcSsVQ8Q
 ZuPPbF1qbMi9awFhzbhlJqCQbz1MRy4pRf3zWHPU8O5i/lFTIio/g/UZz9F4t0YGBWS2
 O0GMQ5Z1PkIyF3tEV/aZhcE8HHHdhaHQ8pNg0WfVjbKJh0WVvd2PIGcdb9T67HQn7QY0
 6DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553455; x=1731158255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n35w2VDiQsxwqNroL2qJeQnt4HfjJdNE+pLX1JQDjcs=;
 b=ZAIm+ZaXB9sJw0pHz8FNGh8Y1uQCDyZXpOUdSBJ0wZQtFgqPpTqMVxJ+gCiFzPRrNQ
 L6eEgzqXem+yqGfSFc0CU1aTjFbp0WnjZxjF94gB2zZk4fBhmG+QfQzIt49oGhMpmqpc
 g2GfUhdU66e6ZKly/k9AKWvPEusOZh9722sUh1t33/x8Jmr6jmG4uT4uYcRRABagrJpR
 xDa+FEJT6a4RTxoSeu77h55rXITXHk/xulcGUceeXd4dWT3YTspa+l7CRNU7LGgAIjTh
 xZK9vY77Q8lBaE3u0fb9nk82W7zdXWRtTgiV1ghVlNKOlVMjRYS+TPnjCWmEMHgiTmU6
 +2/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU1vX6m9gIJdKsuo7e12bc+5KyG+42Ih+acjGiYtoiMfpe4BwOlbJXf6I9HzUiL9Ymvg1y06fBBCl7@nongnu.org,
 AJvYcCXNAUyeMLmOqWj5riuIaExyFT5nZEZcmhS59sZHDw4VWhiLoyE4K/6ICZs4qNDEUFq2ZikjGTiYiJo=@nongnu.org
X-Gm-Message-State: AOJu0YwOhUZXnJLalPUtgDrG0tjylfIyN/VDfNSxEsuyy3ejMngM4e2R
 J+09JADJDTCg96S81PHFoeA7JqlMbtINbVyl+y0TBcI9RkdllN+/3IFGrQ==
X-Google-Smtp-Source: AGHT+IH0+GjB2T+xG/7LWhUEDx+m5Jcqp2EFl5x8evcmMUqTVigJFrjh8hWMxlOb0egl2uhtTQdobA==
X-Received: by 2002:a05:6402:524b:b0:5ce:afba:f48a with SMTP id
 4fb4d7f45d1cf-5ceb935bbc3mr8312113a12.27.1730553455039; 
 Sat, 02 Nov 2024 06:17:35 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 04/26] hw/ppc/e500: Remove unused "irqs" parameter
Date: Sat,  2 Nov 2024 14:16:53 +0100
Message-ID: <20241102131715.548849-5-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 964a22c5b7..ecaaab1558 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -825,7 +825,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 }
 
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
-                                          IrqLines *irqs, Error **errp)
+                                          Error **errp)
 {
 #ifdef CONFIG_KVM
     DeviceState *dev;
@@ -865,7 +865,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
         Error *err = NULL;
 
         if (kvm_kernel_irqchip_allowed()) {
-            dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
+            dev = ppce500_init_mpic_kvm(pmc, &err);
         }
         if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
-- 
2.47.0


