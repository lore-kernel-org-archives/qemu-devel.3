Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A97CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfQD-0004z8-Qh; Mon, 23 Sep 2024 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPz-000485-Hg; Mon, 23 Sep 2024 05:31:43 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPx-00072s-Tq; Mon, 23 Sep 2024 05:31:43 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so496320166b.2; 
 Mon, 23 Sep 2024 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083899; x=1727688699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QazYJuwkb+nuQnDTinA3pE/6s10IXt5ACq+vDFbVeD4=;
 b=d7ImnK2lECBrjc0jm6ETz+EX2x/rMCjVk94APZwPut4Wfz1an10+r6nj9whvqzWO2A
 kZIx2ysQ5f9VQF+MkUS9L4vUT+VIhKPxLMQN2sC/DAH64q067pO6W3mW9w8cGsOUNioU
 7E4bD+mInsX8HBR/AJxP1GAlz6DCFayFZONN9wfQJnFV9KlhonM042h7SXKo+MyIe1uJ
 bF3Fpe2VU2dLXbdl2RCZNxS4Fzp3iS5WeZHSq7DgWbWhyumbvPSugs4wDR+RAsdw1cVB
 O9S7NIEgslD4qVGmmiFn3leLJzeczFaU7Ar+n8vEbeLZ22GQjjDJdsMahwGEZpbKRG9n
 giHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083899; x=1727688699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QazYJuwkb+nuQnDTinA3pE/6s10IXt5ACq+vDFbVeD4=;
 b=fFGechHVNJWwonhVHZhSyypVNW/QaVTqQ4i2sQsvQv9HJadUa1ChvnxgIDR42RUuhA
 FZHskGAR4eFVGdrRetJelheSoHUhpUdo2ML5Q2nKUpcS3HLs41gdxcMn1YZTqaxhGPnQ
 ayyfn2QXORflf7pzuUSt7e5b0SPhAzRVnYVQt+xz0He4QFab7zBwIVJfwew60ulNjt1e
 Q2Fv1OJbTH7XtWmEeDo7iVye5sep1yGtuTO++002yZcnfqZmghb7fVuyxV/37zOj4qwS
 TWB5vHZMd+Oeqee6WTeb6MuK7h9JiS2orjUd4lAtsG+tMmie4pb1GmbgjHNFQcrQ3xHO
 0JGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHuIi7P+0XOG4bvzx2M/0V4NBgus+c9I1JYxa6hGEGJPhHRWKqHmZH6uyu2fgitrJ7tWyNLNuGOLM=@nongnu.org,
 AJvYcCXFXEAxSDjau9dYK68gjVQBXWR1HngMzxDK+Y9sgQ50NVqe/a0rLc7JIdyx973A/D0sVaqBbAIZoYSW@nongnu.org
X-Gm-Message-State: AOJu0YzLT6hk795g7fzlCT0NwYpGEICzQk6yTdygpQQu/tHuvG/vkPyq
 T71CEOrkfmH1B0FW3dQNr9GAFzOuKNwSjhUPn0TMRnnclrAqpKwPF9wL4A==
X-Google-Smtp-Source: AGHT+IHiW18NJQyxd924KS3hFzgS8ngM98lDZCBq7qV+osEvw/ye+oDjvWfs/Sl7gbTW4ln8yMTUzg==
X-Received: by 2002:a17:907:f704:b0:a86:80ef:4fe5 with SMTP id
 a640c23a62f3a-a90d50ee84bmr1037087466b.47.1727083899120; 
 Mon, 23 Sep 2024 02:31:39 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:38 -0700 (PDT)
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
Subject: [PATCH 23/23] hw/vfio/platform: Let vfio_start_eventfd_injection()
 take VFIOPlatformDevice pointer
Date: Mon, 23 Sep 2024 11:30:16 +0200
Message-ID: <20240923093016.66437-24-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
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
2.46.1


