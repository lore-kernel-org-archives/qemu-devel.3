Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3501FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVb-0002Q7-V2; Tue, 06 May 2025 10:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSK-0006vR-H4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSI-0001QE-2X
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso50574125e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542372; x=1747147172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y41oplbkU9wFEHQN9IFbTeGkihP8bHFwwIYrwg5eFCU=;
 b=iz0UvBvKjols+D0ayI0og4g5WP7Kga/4VVi31ggAm13H5RW/oGWXjfwNwO7uATLReu
 7L44enF+fs0ocEqMdQwtqf3wveuzskjj8mezmppzwyZFp1ck6olCeOCrM2uJdXlMyC0S
 6WjpujNS7T/wDRYvZzgmfB8pTWvNM8v47KTV4u+BX2C7wA6kb0gLcsf6DSt7Qe7CH1M2
 lDjil7v5IBWZQmaXGxRsfKPi+SeUkRUFv5ZErm46NDNGNW8c9COF2KQ6JnXlKMzDhOAQ
 lrkgSdqmbi2x0A6uU/VirfbnLl8JG0BHfjDs9v8w/+ggAQBrIDgSd/7tgY6iTx6WV1LW
 hBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542372; x=1747147172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y41oplbkU9wFEHQN9IFbTeGkihP8bHFwwIYrwg5eFCU=;
 b=DaHsX1bkY+tfcejzq6pzxp6XnjFPRFfYpfUfB6ov2EGFpxeoES/PV0e+4oImDX5Z1o
 aT7DlBd4cUsEqH8paJetoct6dZ9clAa+lJwyfLS1Nu0c55ST7jS5JFY7AqzNjFyjq281
 OWFhQb1bw48Uik+DoSA9B01g6drUACe5NMITeCtofobvl47uvQ9aGTitE5yERPS83Tkh
 vELzJ+XVGdzz9oVmEjkSnLOeXJWOkeIXplMa84eRqRwxUNKNmRwCs1cgqHUE1jgbBEPh
 PS2FXQmt4FBIbbO6VeaQQFlOP6WbLq78B4MSvguhC2hZfxzr1uo69BJiEoUiDzpDgf10
 4Qsg==
X-Gm-Message-State: AOJu0Yzehc0DDkib6hO7TeeWVFSa91oxddojlIKIQoZWAL4tZ2VGC0NL
 RGHmt6F/SltS93P7O16ACnhZNek6ZezmK4RXobIcof2Dce3S81L0zcGFnS1CSXniYhvnNSKaY/b
 k
X-Gm-Gg: ASbGnctdx+TEmFC2o8f3slPqSfjIx4/c8/VfA99mDPHtfVjn92O5A94VP/f+bQ7u0uf
 wjWo2zKD8H+JyrjGiPIIjtRnXBtBy48C1nkqJ2bQwWkHr+U/s+gwT4RPbNvt3cfoD9ROZeAD/Lu
 tvZxTgOiVaFxwpm0hOmjQ5uABMpQPtsPH4E31S32QVgqGmQcn8PXmt4Ouzhv4qNgvqCTb64tirK
 TD/9TDfZnwFgFf5ygsS5bqaP2iJnZ/VSA/dkV4MKGisq6fRobqz4Fz2Jh5Y88VlhvcZF4lqg+fk
 fTbHyA9xesMS3txbM/M562bWDSp0V1FaHCsW9Q5mM6C2b8cEf/Si5ESIwgniYiusdeLX475Oeu6
 azFef/MHhj0eu8MR0Mx8N
X-Google-Smtp-Source: AGHT+IFoh4RR0OIkIF5+cMebMMPmK9AtZs/srIzyoYY+yR3biP5kJAjkBm+XzCjJjRsiPU11gjqljQ==
X-Received: by 2002:a05:6000:4312:b0:3a0:7b07:af9 with SMTP id
 ffacd0b85a97d-3a09fddf4e0mr8991925f8f.56.1746542371675; 
 Tue, 06 May 2025 07:39:31 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b05334e0sm1887665f8f.43.2025.05.06.07.39.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 05/19] hw/core/machine: Remove hw_compat_2_4[] array
Date: Tue,  6 May 2025 16:38:51 +0200
Message-ID: <20250506143905.4961-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The hw_compat_2_4[] array was only used by the pc-q35-2.4 and
pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 765dc8dd35e..5c4e3d2a2cd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -848,7 +848,4 @@ extern const size_t hw_compat_2_6_len;
 extern GlobalProperty hw_compat_2_5[];
 extern const size_t hw_compat_2_5_len;
 
-extern GlobalProperty hw_compat_2_4[];
-extern const size_t hw_compat_2_4_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37c..d66b02b564c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -292,15 +292,6 @@ GlobalProperty hw_compat_2_5[] = {
 };
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
-GlobalProperty hw_compat_2_4[] = {
-    { "e1000", "extra_mac_registers", "off" },
-    { "virtio-pci", "x-disable-pcie", "on" },
-    { "virtio-pci", "migrate-extra", "off" },
-    { "fw_cfg_mem", "dma_enabled", "off" },
-    { "fw_cfg_io", "dma_enabled", "off" }
-};
-const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


