Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B91C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1SF-0000RX-A6; Thu, 08 May 2025 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1RU-0007ku-OO
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:37:45 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1RT-0003pU-6L
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:37:40 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30ab344a1d8so988175a91.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711457; x=1747316257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL4pIFttZ2qmq1tFiNzzTmUrRSAgtctinyd6wOyzE6Q=;
 b=pZEXRn+uUUcZV7rv5n+DbYGDAf7vo8d+hGkxidM8y0S9kSSlKk2Vaqjq+4xIyOXiZs
 19UANWsu9Kd/pUgNGJqvO/m55ZZ8DFEunL6EEf4lxLnDWNbTQ+CKI48GmhDkGxcoqI1v
 clb3AxFZyTsu4XHeTeIG7HwKYbncKHGVsUlMJfyXt4u5AauhqyJZ7pJT8+XmN4osl1kr
 O1fOO/1jRse3c2H+1gmnHCATwKFYsfeqgQynZ9pmk6+z6dGoItTxFkjJqBNmvWjvn0Gw
 OeyUJt+KjJo43TNcgcJitpVgCNYBj2YzDpuPsWHggwIS0RNfVq35qJMrbcY5oE10KMNx
 7uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711457; x=1747316257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kL4pIFttZ2qmq1tFiNzzTmUrRSAgtctinyd6wOyzE6Q=;
 b=QMlu3BBdoq7WLq4DBXWUZSbKP0+2fLic3jx3n2QowbZ7b0clTHuWQJEhzuh3h+Z5xP
 5cQa+ni1/hz1AqB39ZlhUSo0Ji5+kPQXhN4J4JkI+yCm1fu5Iout+NiRy7MQ0j1TN6CJ
 s/VU0lbwR1oJese9yeA5g7gXCx3SolFEVsF+iZYcDVjiMbI6A+li09/MXenFBrJjBgbG
 hlLmhdbrZo0IYq7NJefMzWXb/qOyfR3B5lgCCWtZWqx4trBCFXbdcUY7xCAsUpjM+e2j
 usdICMFCkRnAV2r/dCyUSXXe35UvKHUrooNPLDoZJd0kFs3vH5s4qeXvZzSWpYVmdGLS
 9R+w==
X-Gm-Message-State: AOJu0YwWsfYuHPw0uQLX/nbtAf4M75SUGYNOP4iZsKOMc1YUKrEPMYwD
 qiRoA+Z7M08jjvRxF/VoxnSd/h6jrJVNJw9D5hrX6juNCbYzaJ77uSuHAtDF5QJVsxDRmIoTcai
 fUQJOKw==
X-Gm-Gg: ASbGncvQKYp//WZgOry5+TK20SLxVkAOKb4Hi45k0RLPlxrKnXnGtiykwKNBLJoO5dv
 7olF+jyRQF2qisYKmnRN1z6KbA4+zxJSnyf5z19sGn9wE8ZNb06A/w3SuPgi1ABKifYq/k/SPiC
 XMfojxHtxTC/2F8MQJ1tdD2mH0ByaQCSj5N2qWfuZ20IwVileV4jkCknecbhMQXGweqHdH9BI9V
 nJ7IjiEIH2SQK/iV8sLjvHt5RLNbMJd8+MDXYfghh+guNxzkGU70hTo7fqUCyH4nT+0OZxyAiEl
 skaKb6tflwOGrmktoHv/zGtqBm5hKxBez1FynWvGcE5gLZ/0EqpCkq4+VIG3JZEWv6tlp2PEj/6
 +UeHuoEa5aBKrvQQBiJAR8P4k8Q==
X-Google-Smtp-Source: AGHT+IEk1b8ISPttgleiSmQEDw2klEkwqCgpYadFc8f0DOCy8FGYg03X1jjsNrMZ6SJ85jEJZpDRnw==
X-Received: by 2002:a17:90b:1d03:b0:2fe:e0a9:49d4 with SMTP id
 98e67ed59e1d1-30b28cd784amr5179358a91.2.1746711457171; 
 Thu, 08 May 2025 06:37:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15228ce9sm112128395ad.163.2025.05.08.06.37.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:37:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 04/27] hw/mips/loongson3_virt: Prefer using
 fw_cfg_init_mem_nodma()
Date: Thu,  8 May 2025 15:35:27 +0200
Message-ID: <20250508133550.81391-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1030.google.com
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

fw_cfg_init_mem_wide() is prefered to initialize fw_cfg
with DMA support. Without DMA, use fw_cfg_init_mem_nodma().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index de6fbcc0cb4..654a2f0999f 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -286,7 +286,7 @@ static void fw_conf_init(void)
     FWCfgState *fw_cfg;
     hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
 
-    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
+    fw_cfg = fw_cfg_init_mem_nodma(cfg_addr, cfg_addr + 8, 8);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, loaderparams.ram_size);
-- 
2.47.1


