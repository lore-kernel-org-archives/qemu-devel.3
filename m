Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14755D3B986
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtgj-0008Fp-4B; Tue, 26 Nov 2024 06:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfk-0004kf-Ex
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:24:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfi-00031e-7s
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:24:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4349fd77b33so16573265e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620236; x=1733225036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0iDFiy4g206+uiI3tz8kmnBegTpSA+b+66gFGs5ekU=;
 b=xMNe6qCssTdvInzhR/rWRpAKzc4TYxKSKdMEHWwPrU2iE40rqgBcSEJlsTBc5AxlMO
 4Kn5qmdYpj0mbq0pbZmavVwYbreK9DWWaE26bkkCtkCJRDPx0763nz6yejg3750uxQPj
 aHhk1FNsvMyaMgVYT3yeCIGeMmfgV5rEvceNsDJ0kSjndjJSTziqQB9jq9kCWYjIW3uw
 3IkU/zTylI6qmITcNzqmy9lJSbmYrSOgO4iQp05k9Um+IZOysMowECSq1jDNDg7noiSc
 /YNrE8TykBCbWERq2fLxvWiTS19s5SdArGyiQ7JTtAZYZUOZkZvpYDDj+t5XX/I2s1Ze
 BXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620236; x=1733225036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0iDFiy4g206+uiI3tz8kmnBegTpSA+b+66gFGs5ekU=;
 b=auxh3tP/421v5SIDGTkJmQliy6W1xHrkywBuI7PZfwocY1Hb4r1ZqXzM+OHEKqk2tJ
 bA/7gvOyaAztG5twzoeJGq40WKcrsabAEyHgxaRygRyQmc5LmgbuAZIG5iaksMnzMgdn
 HHhIdXE9ELBRDMZcFtfhlXsRonT5CFqb3/Z90rQV/DQT1s375sjF+8QbEoDz4IWSwlOE
 yQmY4AhRltam8m0fZnIihoUujDGrZfxgj3aAjl30M9OnIc02yOj66qnSF3iLDXOx4GuD
 gOAp5qLJSZFG7ex2mI5LkwBqgbqZLUyfBPgDfbU9uCd84pkuuVHsixjFpx2K0S2rttcJ
 DowA==
X-Gm-Message-State: AOJu0Yx9sq3o54Wjls/2TVUbGQdHHSs2svTZgJdoLzyNZeWKRVS5btDB
 uWrTPwFd4N51EpfjnB7wVv0gJJ3uluHnN3v3Z76ge9lXyPE+xE20CqZdHuxovxhR1fyK8qIQ9Zc
 y
X-Gm-Gg: ASbGncu0pBu14g7arXxcQFHfgvvTCM5M4zA+zfg8Jv3uGnv/Bsjn1xLC5bX20sZzWhM
 S3E+ugPwdr0cRs5uBPpwAnfMWycC/ynHY76ZPXLvnUxgK9c6mLoAWBuYBPbgD475FRoBeYeKhaA
 HurffgHdXJAVek/ilNx7UCafHJyAh1wyHAN2f6Fgy8JEYgNystHXiRGCZmVC32Wwacy62AvXD4j
 CpyyWP1xV0vGuPIvEJY7m7/085JTTB5LmwLpjtvSb+XiI6PUn4marjLKn4BWVqze8vhQ0TM
X-Google-Smtp-Source: AGHT+IFg/gi+61i2OJlRicWC3cP19bowqD2mQdjF+QnLLM120B87cgN7yu5W5xYlEgHd5cop0f4Byg==
X-Received: by 2002:a05:600c:4683:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-433ce39e773mr149650775e9.0.1732620236161; 
 Tue, 26 Nov 2024 03:23:56 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349eeb375fsm75702535e9.3.2024.11.26.03.23.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:23:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 12/13] hw/riscv/virt: Create GPEX host bridge
 without refuse-bar-at-addr-0
Date: Tue, 26 Nov 2024 12:22:11 +0100
Message-ID: <20241126112212.64524-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

RISCV virt machine set MachineClass::pci_allow_0_address
(see commit acead54c78 "riscv: virt: Allow PCI address 0"),
directly create the GPEX host bridge using the default
'false' value of the "refuse-bar-at-addr-0" property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8999fc348cb..b28edb9ffd5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1158,8 +1158,6 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
                             pio_base, NULL);
     object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
                             pio_size, NULL);
-    object_property_set_bool(OBJECT(dev), "refuse-bar-at-addr-0",
-                             true, &error_fatal);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -1807,7 +1805,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
-- 
2.45.2


