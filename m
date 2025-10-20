Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B633CCD1AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmNU-0002cR-DN; Mon, 20 Oct 2025 05:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNR-0002c2-0G
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNP-0000P0-1A
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-471076f819bso33079855e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953224; x=1761558024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=grfkl5mKuMnsdzFL06eSw4GbmqS2DSCVTXLFKaN33PI=;
 b=Zq/91YpgVO2RlO/EAoyrCcidUP0IEqddfPgnygvZoihUWQsfZh4mU8qt2IWrbwE5TP
 dEJPLcZl9WOiSCYERLTHHBoZTUyZrdkcreR+shua4cenyCm7cbvJzGQ1eSDlYJe//Q/l
 7lc5FxsQMS0y8icmrvMMMXp3G1o6RI2SnYgXiLOBU7qbrU2aM8F3MFFO39Se/3+sTmgy
 E3tGaZQFYNLTQWu8I/7P3dYXCEGMEHa6teTJfWMIhid8HXK/lN75+9+27U+9GC3wzljS
 TrEJDxIPneBAt3MUqcsBxWiZR7d/7kSJ4mfNLPtOXU5vJXEwY1ftnA/cVZaJdli0dJoS
 7SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953224; x=1761558024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=grfkl5mKuMnsdzFL06eSw4GbmqS2DSCVTXLFKaN33PI=;
 b=DK8+g3xccJLJ1fa6aMv4DwM1GUdC1gTqID+D4GZ9WgIHDEGW6ZteYr0RpFBGU/nKbW
 yUSV7t315kxu1DTyu0kUjuUMEl+y6daX+ddLI9/nH9ts04V+RrtSpKS5rEHQNLGV1LZa
 h4z4w9IOh0AQekB9JYIQ72dyAaHDOjeikiSTGvA91P+/GeKztAF3ZWHBlYgSPOZSMpdL
 nNUzvKC/Dg4pWjsL5D/M7omRakPlcBrBd/LnNbupN81MCC1T7DohZ687gDy4VUTI6UbM
 x+erc2+xeU/ShByYPuFg1vAWUjvdQmSX2HNPQKs2zrWss6P87SPSu8RVE8Y+XY5acWnv
 e4TA==
X-Gm-Message-State: AOJu0YxTIO8jI2uwmfZbpsmApTbW4nI+vLY0+/OcXn9v+Xz1OCnn6dNC
 z1VSNxqmyTsWqdBLpjvUy0p1bQtZBxY9yb0IDCEV6wZnyMwTjiqEg93/ZU2/3RL9DUOONE0PPIX
 vcXCCjcw=
X-Gm-Gg: ASbGncuPEtDt4n4qrOo2mgFGTSFpjRhp2loks2qSozdhGbNN2eloakJF0pFdYz+6Jol
 6qftKaEbGvQ4qiSEn826AxCdVEoJd2z6T7llL+Iob/xzlmApij98ebQMA7tu9jNnGV+FVgfx0U7
 r3Zu0ewkWnhrra6HKpZvB3RS0uF+3UELxUexQnKf2rFGPQ7ni9V3EeHP7562z9wFfzKZbkdZIBx
 v2osNTnPc+jcqaM28RWeBiZVquVaJktLM0B3NQU72AL+EVSBq8inA8cjJ4nNMagdwZs1lnFmJCX
 DWofXRnK1ON6HSvOysAjl23UJEUcMprDzu+JOyCSkUBWEHSfvD9V+/iHlpieIu75R6cTOuNIf4w
 cwihDz5rENZmeBsZ0oYpi3B7XsyKcKpKQw5TARaHlxELSyeNzkSRCJFIwgjAvGhzQ72rI0MyNQK
 K0W4jihCpZYAEYIEhnIoTWKNyCvhX/AnPvRSsOqoLojNJCg1VgFg==
X-Google-Smtp-Source: AGHT+IE1qVanHZDGHewTUyiAL8EuvFWb5zbDZYoVy0pxb+uxE/ntxCNuPQ4t+Nrgw1DJUY3nBZ309Q==
X-Received: by 2002:a05:600c:8217:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-4711790c372mr96184865e9.22.1760953224099; 
 Mon, 20 Oct 2025 02:40:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm216196705e9.6.2025.10.20.02.40.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:40:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] hw/arm/virt: Remove virt-4.1 and virt-4.2 machines
Date: Mon, 20 Oct 2025 11:40:17 +0200
Message-ID: <20251020094022.68768-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- Do not remove virt-6.0 -> virt-7.2 (danpb)

Remove the deprecated virt-4.1 and virt-4.2 machines,
which are older than 6 years. Remove resulting dead code.

Philippe Mathieu-Daudé (4):
  hw/arm/virt: Remove deprecated virt-4.1 machine
  hw/arm/virt: Remove VirtMachineClass::no_ged field
  hw/arm/virt: Remove deprecated virt-4.2 machine
  hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime field

 include/hw/arm/virt.h |  2 --
 hw/arm/virt.c         | 29 +----------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

-- 
2.51.0


