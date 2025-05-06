Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2BBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJQO-00016J-VE; Tue, 06 May 2025 10:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPa-0000K3-HB
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPX-00019o-St
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so19218115e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542202; x=1747147002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HW3GxR0INnkgvzDsQ5q2TkMd/I+Rsj25SGtcBDDOu8o=;
 b=O6gwuuaC9O0M0tjvUmJtgpAPmZlPRQSm046aOqN7T6D3ub7G9qFNjxrWiWDUNWej1/
 kQEDjtRsKYObfoynx6U0QuUAVUW7tq41jqrKCUzDW5uciDGFRY+lZL9hYdrkhyulcFOU
 jIl7iNvUfJ01/vgVTPUsMQtS353wGOmWqoZnL2HTs8hCLydjcYMEkrqweuEZrw3YWIuZ
 5e+f8zSrTCN3jFootLZJWUIeuMl5z1mOiHwMYtSPwMhwUniengLXw0llpjBggoyZ7+Uk
 X1Lh/LDUUpmVnzfBzhqTsejCJB6+GalZ3Z64Mo2PFYLwUdjbuRwCwPkURU3ArVjEO9Zi
 hzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542202; x=1747147002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HW3GxR0INnkgvzDsQ5q2TkMd/I+Rsj25SGtcBDDOu8o=;
 b=ECc4EfSyrrMJ6u4YuEmNQVJxejYw1B8xkHZv2ldHQnhOh9DojZU0rstDgGgHaYIT0G
 bfN1LfpJlJ2r03Hctyu+dl2DLev59UrbNLceri2R5Ety1JkT78whQ36+alR+O60XzYWt
 LG7kTofEj3vEyRME85q7JFE4NLNaa840DIxarK3NypacpqlWFXYDDmEM1Aodl0igEFPl
 oCNdZL6wuQpy94Fc1/5D6i/RX7PYn/Wqh/Qx5hVyGFRPhL0HKu3LKsRVgQubVMExmEZ3
 ZSHT5ywTv2kjZtiCswvEDWhmhCLX+aAUERjcMwll9YeySVnoEYto6shr22CYdwFqfMIR
 QN7Q==
X-Gm-Message-State: AOJu0YwTjGmwmKYLlBzY2+dBz/TMzj8jX+T9337GmTLladkFBsk+uuUX
 lkTmKF1Z1hFYMPWsco8kk7obNzytx6/ph1tOXxTk4LaG0inA1jdKdOGxxyA3iqLJI94lL70+QAX
 S
X-Gm-Gg: ASbGncvajaTVabdhktSS3xCqPMsWkZs+tDGGHuTghO4BVtOzWUxNKvaLZH2b0mpfngs
 hl+kOsGkEXBhVZ5gXwFfKH1wZn4oe/TBBPlIacJqiDqwJ3uqRkA1CEGJ1yS0feAnUCLBn+uit44
 bJPuHeRmLr8gB8A1Q1J5i2+TJ4qCyrILr6BpVx2KaHJCCXuLPEOXai7sKcwuiT7c5s8WTRhEbZY
 wgMNLFtlMzOKHGHOuXlIRn8VEWzYIi2gWlBj4bj2t73fkd6joJjf9N/IMnKc2xBtXb4XzQhTQmu
 rSkXCmvOymjl5M4KnxQ//9wBKluZ4DM2GMZI2PJGqyoAWgNwp8MXbzqycyT+e34hLQZojfkXcUz
 INXCotjHpVhcd1ZVIeqYG
X-Google-Smtp-Source: AGHT+IEhFPJs9m3cLsfx1o5kxIfkeNrMjbOQmGk5NhU6ZVbtEy6c1P65uL2QthvCLdvrsF0rhicTxQ==
X-Received: by 2002:a05:600c:1e02:b0:43c:e8ba:e166 with SMTP id
 5b1f17b1804b1-441bbf33b3emr139326505e9.22.1746542201888; 
 Tue, 06 May 2025 07:36:41 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0feb3sm13950230f8f.67.2025.05.06.07.36.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/22] hw/i386/acpi-build: Fix
 build_append_notfication_callback typo
Date: Tue,  6 May 2025 16:35:07 +0200
Message-ID: <20250506143512.4315-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eric Auger <eric.auger@redhat.com>

Rename build_append_notfication_callback into
build_append_notification_callback

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250428102628.378046-4-eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-build.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a3328..85c8a8566be 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -589,8 +589,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
     }
 }
 
-static bool build_append_notfication_callback(Aml *parent_scope,
-                                              const PCIBus *bus)
+static bool build_append_notification_callback(Aml *parent_scope,
+                                               const PCIBus *bus)
 {
     Aml *method;
     PCIBus *sec;
@@ -604,7 +604,7 @@ static bool build_append_notfication_callback(Aml *parent_scope,
             continue;
         }
         nr_notifiers = nr_notifiers +
-                       build_append_notfication_callback(br_scope, sec);
+                       build_append_notification_callback(br_scope, sec);
         /*
          * add new child scope to parent
          * and keep track of bus that have PCNT,
@@ -1773,7 +1773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
 
         scope = aml_scope("\\_SB.PCI0");
-        has_pcnt = build_append_notfication_callback(scope, b);
+        has_pcnt = build_append_notification_callback(scope, b);
         if (has_pcnt) {
             aml_append(dsdt, scope);
         }
-- 
2.47.1


