Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEFCE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaJ-00044c-4V; Thu, 02 Jan 2025 16:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaE-00041t-1z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaC-0001OQ-G0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4368a293339so79819405e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852698; x=1736457498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=424nUjnt0mSbCqT2Iy8fBR2D+25DbV9xd+ohVsIuqlU=;
 b=JUIiF/u3H/ziU1vcqi3gbUpIbiyRQ25D8v9fgvkGWb1QTSWOBVHSvvo9wVej+Jsu9K
 6C1cwUNdsUuMltpwbvqi64jJZnr4tDL1gRKZgfYV69EaaeuorK9wKt7hbTphY0Qzwgs3
 BXOilkUX7TB7XqlJ8Lhz1/l4IHX8qbHfntcRbOxSnWLxMYbAbNka0hRNuBdwSZWKCMDF
 RG4Gigq6kYlR1wqWjKcxwnK7KCXpjToVZng6dyS8jF45vXAvG/ZoBk8LysNgvXK5aRky
 tz3yEKQrZ/hci64ywPQAOC1O/2Bd0hh+qPcheKcJPHI+PZsECp4TNdeGuEDRL5xPsiLo
 0QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852698; x=1736457498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=424nUjnt0mSbCqT2Iy8fBR2D+25DbV9xd+ohVsIuqlU=;
 b=b0/eLUYb51Z3HracUjalir2U3qlCDEN0lY8s+VFIzNO7KWcgp6/6J7XhP4rvaBM7XO
 xrYY1MlU43Y3/iVuiFiQEZoqe1YsLMJWlMvnAM33ufzuubN5Qnt8XsaEboDPuDvWNk7W
 jE/Xh5VZSJOCFB7PHtYH1G3AxXluVyitOnQfnMQnO3Mnvy88lrqK7ySCoXjz2z0MqDoz
 WikyEwrfcEphbQItvYStK3Fl2R28j8GwwoLkegr3KaexiX/nw910m3thAs4+4RizDvYK
 hEFbfy8sd2vTvMkrYk1BuLfVJ02b8XPtMAEbKJrDrCPUWWzmwF352OK3ovj0QRBBlTsM
 oSmw==
X-Gm-Message-State: AOJu0Yzr0Yioomjkk+Bnh+4wyb5r+zMIr3zh6U9Bq+2cwzeQlaRBU+bO
 wUsn6yDNzfsvolAizU4kDOHVldQdC9HWgFjMaUGZ2jhp/cxVrXJuff+SJkPiN1bpviAghghrT9B
 +qTCh6Q==
X-Gm-Gg: ASbGnct42nuBAvQvYyxFwcSjTtY6dhMmZJUrhAakxBQeMj+XR1MagzdlgCR4s4GMIvT
 seuTd5IEsE410xVeMmbjxIkBJ3slbT1Ywd9VpjsX0Kb8G6YykE7gYfpq6pClNw5OKFEdbBxXTfl
 WMdLZI5cp65579CC6VR6ssSYLoZvGKyFWH1hHCfvTFWI2Z8itOWxjIFVcx7IYi4DdBPOiuLxHgZ
 jPf15z65PoW6TDUiIsNVvXcrZ+lr78soTwPFuz0wIjeM4aRwGEocnwy0zvmON4Tzv+xOnGaCbg6
 UCB7oX6E1r0YG3zFw1cSgJpoujKCF7Y=
X-Google-Smtp-Source: AGHT+IGfozx6MUYu1gUMV/CUhu3LI1INkamt5mCUXdSqXJmJvsY6cOxsqASOCiMuu5ImKU/ES+5/Rg==
X-Received: by 2002:a05:600c:693:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-4366a0cf7f2mr341455805e9.7.1735852698527; 
 Thu, 02 Jan 2025 13:18:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm459186485e9.44.2025.01.02.13.18.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 3/8] qdev: Add machine_get_container()
Date: Thu,  2 Jan 2025 22:17:55 +0100
Message-ID: <20250102211800.79235-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Peter Xu <peterx@redhat.com>

Add a helper to fetch machine containers.  Add some sanity check around.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-10-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 10 ++++++++++
 hw/core/qdev.c         | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b83b1439968..2434065bad2 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1037,6 +1037,16 @@ Object *qdev_get_machine(void);
  */
 Object *qdev_create_fake_machine(void);
 
+/**
+ * machine_get_container:
+ * @name: The name of container to lookup
+ *
+ * Get a container of the machine (QOM path "/machine/NAME").
+ *
+ * Returns: the machine container object.
+ */
+Object *machine_get_container(const char *name);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index bc5b60212a7..9973e029ffa 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -829,6 +829,17 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *machine_get_container(const char *name)
+{
+    Object *container, *machine;
+
+    machine = qdev_get_machine();
+    container = object_resolve_path_component(machine, name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 char *qdev_get_human_name(DeviceState *dev)
 {
     g_assert(dev != NULL);
-- 
2.47.1


