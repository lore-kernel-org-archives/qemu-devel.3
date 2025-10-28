Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307A5CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDobs-0003ea-9v; Tue, 28 Oct 2025 14:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDobg-0003dH-Li
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:39:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDobN-0005QG-EB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:39:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710022571cso65839835e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676760; x=1762281560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHowBX2Df07n1T0yG1K/ZRt6j4FXOVAvsLv2ZkOne3Q=;
 b=xzgwUY/j/fypRfifDU/UfAwUsMRjwG3YWbvl/eXktWsXO2dOUOsEi4d0fFi4rMIMmO
 f8XMwrBthOBd3xgHenWVEnWn28CCokePArgSMFeEOj8HsfMBif0Nc+OyqQTpztA9fQl3
 ii2AtyJsfZUQAJyWT8hV1XrnRQdvt44JVMOKEBeAfKaVhCS9LQmnERL+EsjjLMSJG91s
 lffEQlIOim9ffpV6ic0eYtX4iiih0+AN7D1HZG7g0DEROJ/ML8XrnTFt1oQM1kWYYEB7
 Nwo7Bog4S92xl6xcJytE5a2eBTA34/hEtMaZ2vuWUiPOTtC+MUI3NtH6Dk1TASe9vV/y
 0Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676760; x=1762281560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHowBX2Df07n1T0yG1K/ZRt6j4FXOVAvsLv2ZkOne3Q=;
 b=oYdspmy9qy3NbfIW7ymWKr3q7PTLL5B9DCqS4vyDe0I2bCJYNguj+gIF5jbZpggElN
 86jLQy5Prh5+3DPWiBe6TucWKbgcT7py0UhZVkF5PIZjoux5Yh2b0vsLZJKCweHf3Cjd
 gSw7Q0bhCueFzwReuP/LHIgGgRLVMS1xtEvY3G9gWgq4xX1+N53tOUggmGsc4pv6XFEi
 SkjNtlhqrOgIlzW7eA8ZDQbJxWRuxzsZEaXEpzjY9D2JJPDTIDrF7j1Bx0JQxc11S08w
 lfbSo0wuiJ9hRcOhPPgpYX3ORkrlvOhHYZhs/bHgVh13CVV/LX5p5+UAPEkzeVK3Svtc
 b8OQ==
X-Gm-Message-State: AOJu0Yz7et3/rehjEMMxftWTnneSpXIMzXQTuae3d+M4AJ7aUMK8mkPO
 rO0Y5LNZ6R0lEWGvZxI3eVtzhDbCp1zQeyfI041GypiIQtDSxWW9uWvMUfJLTfEpgKEXhOVNnce
 Lad0pNe8=
X-Gm-Gg: ASbGncupkAzflleoHHyNjf28srHSDAOSarxZjxds2Xf8UoC/UcOBx+I2rp7EPiEnoNq
 rEZYqTgT9By1eT76FK2n+sh/VnhlgDuI9E9hvHJHLiJyfB4AyDj2uxdpu8kaohDhNUK4/80t4Si
 bu+mPawZ4nUFz2QLM7JkYyWQSIk90vF7qZ4zDZujIMtPHvnj5XUEd0YBey4HgLWs5R+YUPrrVTp
 46WgZO0bBhQsg14c2e3rYKh9JoDl2mn1vIZ5O2b792ueRc3d9+W08JiYKLVTflqlFzHiQamg5AY
 lViDDxvYbuyQXZQdKiY4aK2E7lJQ6DyfHMAYMZI0k3D+e+wxhO2cytjWTht5gJU5PJiEjw2Aud3
 QEDp0uA0pITaUweiBHjW9IhqhjDQGzsBlnIQXJfb7/hnRAEBqeNHL8HheSPWXd1eqrfQ5Tk+pOH
 ORKdT81jOGxgTtje86EGQjJS6ggiN6sUODSiyNCuwPjnrjvQCcFWhbUBtSr0ku
X-Google-Smtp-Source: AGHT+IE7qtAGaEHOUPfc/qOTGQFIp/rFHMuxQNkbkoSFzl16xR11m2qcZXSdonN3rPR3t6pvvzFvoA==
X-Received: by 2002:a05:600c:1e28:b0:475:db8f:ae0e with SMTP id
 5b1f17b1804b1-4771e17412fmr4848315e9.2.1761676759905; 
 Tue, 28 Oct 2025 11:39:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3a8209sm4599205e9.11.2025.10.28.11.39.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:39:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 23/25] hw/sysbus: Remove sysbus_mmio_map_common()
 @may_overlap argument
Date: Tue, 28 Oct 2025 19:12:57 +0100
Message-ID: <20251028181300.41475-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

memory_region_add_subregion_overlap(priority=0) is
identical to memory_region_add_subregion(). Just use
the former to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index dca6e67a92d..e6acf8dba3b 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -120,7 +120,7 @@ bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n)
 }
 
 static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
-                                   bool may_overlap, int priority)
+                                   int priority)
 {
     MemoryRegion *mr;
 
@@ -136,22 +136,13 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
         memory_region_del_subregion(get_system_memory(), mr);
     }
     dev->mmio[n].addr = addr;
-    if (may_overlap) {
-        memory_region_add_subregion_overlap(get_system_memory(),
-                                            addr,
-                                            mr,
-                                            priority);
-    }
-    else {
-        memory_region_add_subregion(get_system_memory(),
-                                    addr,
-                                    dev->mmio[n].memory);
-    }
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        addr, mr, priority);
 }
 
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 {
-    sysbus_mmio_map_common(dev, n, addr, false, 0);
+    sysbus_mmio_map_common(dev, n, addr, 0);
 }
 
 int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
@@ -168,7 +159,7 @@ int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority)
 {
-    sysbus_mmio_map_common(dev, n, addr, true, priority);
+    sysbus_mmio_map_common(dev, n, addr, priority);
 }
 
 /* Request an IRQ source.  The actual IRQ object may be populated later.  */
-- 
2.51.0


