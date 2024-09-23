Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37020CF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPV-00025Z-Uk; Mon, 23 Sep 2024 05:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPT-0001tT-01; Mon, 23 Sep 2024 05:31:11 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPR-0006xQ-F5; Mon, 23 Sep 2024 05:31:10 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so502550966b.2; 
 Mon, 23 Sep 2024 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083866; x=1727688666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIcGbmtd7uHKf6ZYKTXQmr65WTCHDsrdSE+qbZuFBjw=;
 b=Hs7sL7T074QKfuAcE8oIi58WQCANh1GPJdpKcOQFZouIWJwpbMeNbti8cy1CYMKlxR
 cHUdUCYcm68a2yUAkAvjPbGCUxFU6+Ia0xJlVXsqWUfspWM0uPthyVrBaL1q2+dR9/2t
 T/gn0i6g6V8HSmF0MHWAjuCt6iUWsv8eDFB7KTvAwpk/DzLyVVXugqtWW8hEDyvJdobg
 YXGwXTs66n4yHQX3tZHevY+3i6QIZJ4T8zydw5raZd2ugB+8Mm/4h3rFB98N1qv3+U0t
 tdlNxuPxIn292yeQhP/i9C2dyKUdQ0a+91tr2bjNpe3zEnY8FATUHYq+koUGTLHHu220
 gczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083866; x=1727688666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIcGbmtd7uHKf6ZYKTXQmr65WTCHDsrdSE+qbZuFBjw=;
 b=gom+9xeptDQCjikyBBtxXw9ciytcZw0Nrm74FURZ8OPwOEpq4e/1CVIMcdNttCWOKa
 p5k/vE48z36ySWyIDoHIuQP6IHOPsxQvOdf98/Bws2hcRb8P9lKxRzNv7eGSX/Pth1CD
 8Lc93Sa79L/bX7c/ngU3h/RW/MjIvjMOPa5Nktm4AN5M8bbNymjlPok5Jx5jJSCchWnu
 Lsiln68/l/VzI/7sjCtbRUgg7NBfByqnOPrYntuJ+nfxRrFl/TpnM9JeZ7NOEWo+hkYi
 6oxhWlWZcNrDR2q4f9m49InUwElWPFRThRMiBmf2ZJvjwpwBcD7qrgR8fouewPns7s4r
 J+LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURx5eUpJBgO0tCI3TwC1Ckt9plKCwRjWA8uebkPyx4hzAq/cwHehkNGB+hw5E+CgykmSsMd1mJpUQ=@nongnu.org,
 AJvYcCXeDe1ZGzCeW2ZbKbK7e2NojaafhOWV4BUQl9ch0frKOneW7oXWmEgKo+hzY00/Spr4VCGtzh1Blw0g@nongnu.org
X-Gm-Message-State: AOJu0YyfdtInBDAMtCA14InainBI5qIcA3Vx1U5wS3flzqUPSrjfIamg
 zPtRwkvjSRd6Qc8xPFiZySHpd6H3nLzvxwtP+M+d7TfvWMDYu2hpNpS4zA==
X-Google-Smtp-Source: AGHT+IF/pl/EoqM31sD4DdIC4SGsQT23Gm2p4puQIXkv2O1256sSVS/pMpvPk6LxXZHDUa2tjaknFw==
X-Received: by 2002:a17:907:98a:b0:a8d:5d28:8e07 with SMTP id
 a640c23a62f3a-a90d59292f6mr1148839466b.42.1727083866119; 
 Mon, 23 Sep 2024 02:31:06 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:04 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 04/23] hw/ppc/e500: Remove unused "irqs" parameter
Date: Mon, 23 Sep 2024 11:29:57 +0200
Message-ID: <20240923093016.66437-5-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 32996c188e..228287b457 100644
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
2.46.1


