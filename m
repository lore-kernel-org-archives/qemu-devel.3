Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6937D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMB-0006or-IX; Tue, 05 Nov 2024 17:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLu-0006JP-Mu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLt-0004HU-8q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so46634695e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846923; x=1731451723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPiTbeFUpLsDNifMMkKjkFMgZkCHLSWYVGMZNdH6EJE=;
 b=nHXOKXbQdxTw2tHi9ATxjS44zFmaAXgw2omsAsZ32kJju9QJXwHGEbixGf1sIIjEJd
 Ne/46rw0ez6awleQe6mjDOslPHkokukksqjuXByIHAKN450zwSxXptTiFZ/piF/jAZTQ
 J74EyuWLirOB0b1dj6uQBMpnAdVKOChmgafaBOjZsjlXdyp8doBgzctReoaKgoeC8IFW
 kKryqaNf7qv0cV6LRCU2V6XaqXruflHgSQJEepMzcSiWr4bcj4TIryG3/QFfUX2+Ck4g
 G7i+ebzFqBQ1bO36GmaQx9fYGK0bLL6wiA36Ufn68fWkcFWujNnZJo5aZZg1Ko6vh6t/
 1VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846923; x=1731451723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPiTbeFUpLsDNifMMkKjkFMgZkCHLSWYVGMZNdH6EJE=;
 b=b4q0qZDXm3pT0Rwghic2HbGP3290nHD6kEa0VwG+cqoPzY8a24oibT1tnMqOWHrkSm
 trIcq7DA6z0HwzloNCGIBmL09RgyU1491dEnHrCZBuiuz+zIiQy6HRvTnWmH9CC7Jm+f
 qHPArOkoRUnKYvwJ4DPsGtGn+M+JqFpUdDZrkkWO0e3y0VWR2UdHDuHTXaQpWWnGoVBg
 t5S7irYOibdw8FRnwnzKDqtctuxi8vsIdcKws2EWefXd0zOoJIycWcn5KKcj1NGBAg95
 o/UJMKeJgDSb9sNHGuGOoQqb+we4szjYzELNLSfWsWHZeJJOSVmvLt8XO48Cg+h26Ze2
 05Tw==
X-Gm-Message-State: AOJu0YwjZyAhjswqMf4mKGTZjsOdpEARy5bGcVfWQKbG5qfiwNR64eDo
 n2Xuc4PBmKosiCRuy033a2TvQeZSQ8heW2K7CTDK6BcS27asciivuAW4S7kwonAgFjnxclbWX6c
 RD2Q0CQ==
X-Google-Smtp-Source: AGHT+IGgFv2AHyZsYpvVbFA3qfqouUD+2wnBvxKK6SnaOzJ+4Wi+Yo5/t8Le/8/A/5ypzZfSsZcZ4g==
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id
 5b1f17b1804b1-431bb9d1122mr246178075e9.26.1730846923577; 
 Tue, 05 Nov 2024 14:48:43 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa523a0esm1344825e9.0.2024.11.05.14.48.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/29] hw/ppc/e500: Add missing device tree properties to i2c
 controller node
Date: Tue,  5 Nov 2024 22:47:12 +0000
Message-ID: <20241105224727.53059-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

When compiling a decompiled device tree blob created with dumpdtb, dtc complains
with:

  /soc@e0000000/i2c@3000: incorrect #address-cells for I2C bus
  /soc@e0000000/i2c@3000: incorrect #size-cells for I2C bus

Fix this by adding the missing device tree properties.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d4d3a927968..46261223f3c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -203,6 +203,8 @@ static void dt_i2c_create(void *fdt, const char *soc, const char *mpic,
     qemu_fdt_setprop_cells(fdt, i2c, "cell-index", 0);
     qemu_fdt_setprop_cells(fdt, i2c, "interrupts", irq0, 0x2);
     qemu_fdt_setprop_phandle(fdt, i2c, "interrupt-parent", mpic);
+    qemu_fdt_setprop_cell(fdt, i2c, "#size-cells", 0);
+    qemu_fdt_setprop_cell(fdt, i2c, "#address-cells", 1);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, i2c);
 
     g_free(i2c);
-- 
2.45.2


