Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D52CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkb-0005hw-3K; Sat, 05 Oct 2024 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkU-0005aa-Q9; Sat, 05 Oct 2024 15:47:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkS-0007lO-Un; Sat, 05 Oct 2024 15:47:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42f56ad2afaso41164245e9.1; 
 Sat, 05 Oct 2024 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157647; x=1728762447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/Zjzyk/99b3FvfdDneqC7YDOwNG7GIYmd9kWNwTs+4=;
 b=Zl1RXNV4KdeRmI0JC3MeR2wuL8c/pyXU5D1mNQ+kuYYcD8905P+lmgKqO64MwGR88z
 5gnPTXsh/pRTGyFH57FcisHN2ChLnzlw9Y4aGsNQX9EXHVL8RwDIlgH6u8PV62R/7hnF
 c9wRDQGuHfHmODlia8AhWpDSwELFKhLCpUbc5LCGg3CH/pnp6RBLPMmkY/KdFy4uaIhN
 MTrOqysrl7K4+Q6sDgdiCbUTfNjBfQROF3xNBbJw97tMZlfpXi97VBcQ+b5zMi/WdY68
 DvSnb8K+3rj4KfcWZ6LI1XLsohWNTnOyz+xCmlKBzog6QeABPkSAXHzDnO4aXNCihEUN
 8Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157647; x=1728762447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/Zjzyk/99b3FvfdDneqC7YDOwNG7GIYmd9kWNwTs+4=;
 b=BP6/6qmpVta/fNaqxRf0PDmj8pW+Mt5qJGgPI0dRui0l5KsBl5gKwTzZwjZi9zrFPO
 BE3N2hl5ibj94ZvBAkf6K2QPvZ46lrsN/0PKfcaAEOMPGTEfVKxPQ2shqMmrXpFFSTqe
 FGygslcn6X/j4alGN3OO12e31r8Kv7y9nyg9HIgVRTBNe4hIfE4Be9Zucrs0oDdNYTFm
 fzGyIutFgi0S1+xItpKBKAq2Hye/Bx8OjE8FgLXWpx722O1/p4Q3LOHJAv1CV6fuz3JJ
 KHGUihAB1BjCtQratNDGCWMQ7gyrzk8fokZ790SPPT08BYutgFxqt6J8oUlFRdELL9rO
 MSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIJLIzvA99IYgFGn58z32iMKKtvOoGx8QihRR4f+qFpb7MNT0tiv3JQfN3rsRIprSahXbpDyM8Zfk=@nongnu.org,
 AJvYcCX4f2KdvaUL3srMNq23N3Oi/WQme+05iqrX0xyG7ma+KI0vvjLCtf+ec5tjAt4GM9Nzh57KTpHxKdSz@nongnu.org
X-Gm-Message-State: AOJu0Yz5pL7fy6cOUT0B0BniZMydkXxHnIV7IIwkoyO1eDsVyTFyNaI8
 FUEhpMDgJ9QBw4aig1/Q7uwS31Z96iPo/3vsOJtPYwxEYJpoeAGGPhQVHw==
X-Google-Smtp-Source: AGHT+IFR52qnljiwTpPc9b0iVdklJYtViYGVQ/Wypl3QpXr3NIblivFNbEpIj5l3AfHiFNrrfb/0ww==
X-Received: by 2002:a05:600c:3c9c:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-42f85aa98ddmr67367915e9.13.1728157646492; 
 Sat, 05 Oct 2024 12:47:26 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 23/23] hw/vfio/platform: Let vfio_start_eventfd_injection()
 take VFIOPlatformDevice pointer
Date: Sat,  5 Oct 2024 21:46:03 +0200
Message-ID: <20241005194603.23139-24-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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
2.46.2


