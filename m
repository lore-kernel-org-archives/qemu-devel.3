Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B215DE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E1F-0003pF-36; Sat, 02 Nov 2024 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E11-0003GB-7K; Sat, 02 Nov 2024 09:18:07 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0z-00023W-OA; Sat, 02 Nov 2024 09:18:06 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a3dc089d8so443081666b.3; 
 Sat, 02 Nov 2024 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553483; x=1731158283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVflLGHPyO3cQe2iVaao8/FC1//CU9ki9Sx4TSq7Uus=;
 b=MiUXX3OizJENZUznn57QnhRV8HgCt0IhxwOJs1GE4iqmBpdwgECyqw9opm1kpzZ0L9
 0bRYoxiv5+GFwVuBMMnd5vT3y0jn473eTE6Kv+QdYwjDstGcOmlt04NaVooXZQHspkuj
 Agrw+5wvoTfThKt1tBZFhPwRKHvDLqYX/Ow0bz3KtokaEEhH9Fp0MaM+5DHkr2Zmzn72
 2cwCtIN2pOkcNkDuDf95jBsMMkqaSfmUCiCnLZy+P6SdANxGnKcMvsEjlbV6v/NtH/Qg
 VhPegXiR3iPRuyAwCDGYmmEOEuSQoK0fm1EpalN9bKu8vq/zXFbm2Fb1kdRRUGEHABMm
 qgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553483; x=1731158283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVflLGHPyO3cQe2iVaao8/FC1//CU9ki9Sx4TSq7Uus=;
 b=Dax8xFjpVZZ9fl/2fldtoTEXbNsinQ6N70XkwBQWnjOtKkJebUOpPoq3txpd7NP3o1
 q0R8WUdJT8c8ZdLedpsYNhPuwLB64NfaHshAzcvMVC26TUQ30wSe26qyIOVwx9/gmkfw
 aKw77GrdbN5PLflAybmr0BohJ3d756ptKvj2uJlZivAQ5de2XrOvHS948GA+drRezPWD
 TJwuLPx6GfCpUCgGlCSnWYQLbueC5XQPoiY6erFI0ikuHqJMHodNF/7I6lEEVMczBlkx
 ulxEUsv82VX7vj0VvWGsGRtaDrIi5Fp7VBTyAOANYKGzeapuHdRzh1LXOiaPVrk03DL4
 sRpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVxiiZxXjqngd9EOE+a6gpzn7voguMnfQPRCxCzC7Vy9spXJiYEKqqB5yoTl8Qw9jXcv9tl7aW//U=@nongnu.org,
 AJvYcCWCfxBOIO3/nu1kq75GNKn7EhMT0s80RKJ4fFiIFiFCUM4fuv1nHBM3dgEQghKoLRAZilLzeHe6hnoP@nongnu.org
X-Gm-Message-State: AOJu0Ywb1OZ0AY168Jznb9OP0USqcm5sdQoOKh4kSRAU/e1qQIKVbrjR
 NSe51FJa+L4eKK2IWtZ6y9Jh+6pOlXOYrGgNr+v30rsaqxWNMDvLNv+5Mw==
X-Google-Smtp-Source: AGHT+IH5PGDTc6SlGfbnhzBXuo3b+WgsM54VmDBAmCKbB/wOziGCVfWNp3CiR7zv6m7Q2Drvy//8SQ==
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id
 a640c23a62f3a-a9e654fb423mr655357866b.31.1730553482796; 
 Sat, 02 Nov 2024 06:18:02 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:18:02 -0700 (PDT)
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
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 25/26] hw/vfio/platform: Let vfio_start_eventfd_injection()
 take VFIOPlatformDevice pointer
Date: Sat,  2 Nov 2024 14:17:14 +0100
Message-ID: <20241102131715.548849-26-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Avoids one downcast, making the code more type-safe.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/vfio/platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a85c199c76..77bbfbf62c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -318,13 +318,12 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
 /**
  * vfio_start_eventfd_injection - starts the virtual IRQ injection using
  * user-side handled eventfds
- * @sbdev: the sysbus device handle
+ * @vdev: the VFIO platform device handle
  * @irq: the qemu irq handle
  */
 
-static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
+static void vfio_start_eventfd_injection(VFIOPlatformDevice *vdev, qemu_irq irq)
 {
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
     VFIOINTp *intp;
 
     QLIST_FOREACH(intp, &vdev->intp_list, next) {
@@ -417,7 +416,7 @@ fail_vfio:
     kvm_irqchip_remove_irqfd_notifier(kvm_state, intp->interrupt, irq);
     abort();
 fail_irqfd:
-    vfio_start_eventfd_injection(sbdev, irq);
+    vfio_start_eventfd_injection(vdev, irq);
     return;
 }
 
-- 
2.47.0


