Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FDCC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLl-0007dt-0U; Tue, 18 Jun 2024 12:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLi-0007M8-Gy
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLg-0007lT-Kc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso662871466b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726778; x=1719331578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKcHfZILllwrpcTCju5XbZjvoufywq+KUF9g31cZ3+o=;
 b=HuWYRsiP6XEFAzJQJQvlaWNN1kB6JWUpBd0bjpunhHnmq/QMBs3hcPPkSUYbAj6FqC
 jeof6DM8j6maI+Eg7HE4aBR/y8Y86x6dlfFkPPzcvqbMaaYdM+vSBW+oU5erjAVNtF3I
 fRBb5GL6WiixBHTEim5NZbR6i3MmVxojYec95omrEssCLvdUfPf0fTFej+R1UXDB6RL8
 b2J+QnAe58zPLIaxvAiH8jEykcM9tLbpFWWuqKqiUPeoH2m1wJK7fVeZ02JRmfF0VBY3
 VNGvWAVA1ebgjFBlJQCy9hVg2jpWHMHEijRimQoYVnC4YfIafvnhg/iAEHdBlU1G/m34
 Wnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726778; x=1719331578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKcHfZILllwrpcTCju5XbZjvoufywq+KUF9g31cZ3+o=;
 b=CPkAjFp8XjgZmLoGL87ftNVD4+xVz6mEfcim+MhD6HYgdmXYFoM6UXEe5slxBqMxGy
 DcD5h6g9svR0easKs+oYihCimnBeUFh8xD4ai7capQlG7lLgX4W3MsXGyrNjxhCjBrGC
 VlagA1scTo/nQlecfWqag3zIRpKDlZfl6ncaxvYIx5vp2dZAFma3Am88vWBeb/0IXd03
 y6WWqkTgu8opR+m4+2M0rTbmQ4/8OUQEd+++jw63McNgponVMMkjwyeWvfnhzuKZ4ipp
 Tw0s5JF+TlNXsHqDWj0fRa08cBdhSdRSUaYSk0Mqsg4W3fvwSlkU7fTW4kCmOIRqOVv2
 uMwg==
X-Gm-Message-State: AOJu0YxR1Fa8si/xFF/FAAo6oxc70rJsj75E5QcGPqDxh7uIJZTYKLPw
 0eIryjy1xqHaosiB0KdjMDfRtyGKwjr+eOThpFbTpQT+37RT+96WlQDkUCMGYj3FcUdvIbwLPop
 j
X-Google-Smtp-Source: AGHT+IGVsjYA8c/Y0CNMMg3PJds/k2IA6jxqv3GCs28VX5hk+gRSaC4wchbrpWSytgZejIXBIoFiOQ==
X-Received: by 2002:a17:907:c00f:b0:a6f:6721:b06d with SMTP id
 a640c23a62f3a-a6f6721b860mr961204366b.24.1718726778203; 
 Tue, 18 Jun 2024 09:06:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36095093653sm5811030f8f.11.2024.06.18.09.06.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 58/76] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu()
Date: Tue, 18 Jun 2024 18:00:20 +0200
Message-ID: <20240618160039.36108-59-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

@event access is read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240612132532.85928-3-philmd@linaro.org>
---
 include/exec/memory.h | 2 +-
 system/memory.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2bf5e23b6a..2d7c278b9f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1837,7 +1837,7 @@ uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr);
  */
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
                                 int iommu_idx,
-                                IOMMUTLBEvent event);
+                                const IOMMUTLBEvent event);
 
 /**
  * memory_region_notify_iommu_one: notify a change in an IOMMU translation
diff --git a/system/memory.c b/system/memory.c
index f3a37c97c1..47c600df63 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2052,7 +2052,7 @@ void memory_region_unmap_iommu_notifier_range(IOMMUNotifier *notifier)
 
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
                                 int iommu_idx,
-                                IOMMUTLBEvent event)
+                                const IOMMUTLBEvent event)
 {
     IOMMUNotifier *iommu_notifier;
 
-- 
2.41.0


