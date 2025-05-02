Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28CCC3ABB0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZd-0004rj-Iv; Fri, 02 May 2025 14:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZV-0004m8-8k
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:17 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZT-0005Ol-O8
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso4436374a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212233; x=1746817033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7+NkoyA3HMTuquXVM6+FfGafWiuRck1O1aecj2hVgw=;
 b=xzd9roj+JrGBDb96hWO1kkuwO0nXKHzCVp7eEsJWbKeomOGs0gHBYlMndxhncRVJfT
 h9q7TARUqI49iosegStRebIkOTpMsGiLw2qnGH5KwTbz2V367jyeU7tqqLapgjPIS5Ld
 4PPZB0xzkUJgazOgpxTrZjOQEcV+r0Pen1TTkbZhF48/7y0DEeytlkPTvuhiv1nyS/L1
 DSBZFt03UIal7hHqvN3s+VaG34J3K3T+othVnoKsgSCp/yp0vfVrXhpx8FXdxdFz/H/j
 UktzLqwZRXAGcSR4LBS+XVsfuLhgZKylFtctYpWZAnOgpdr6FCGsgplxGNNoQ11w+Q8I
 qMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212233; x=1746817033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7+NkoyA3HMTuquXVM6+FfGafWiuRck1O1aecj2hVgw=;
 b=Vo+oAMw20UhiRFjrUOR5MI4dcrHaVgOErntNegcpTjwMAm/KwpaqXfZtOUrGRvC9tv
 OpzByN+rjOA4wHARK2X+sP0pUohZBFdoY081y60xI6/qGT9Fe7yx+hHfh3JDH3DQEgRc
 Scege0YlwGhYSYlaNNQkfVtQftE1a8t7czDucYw6aravsdgGgzduM2TE04ui2/6+3+PT
 flzlN2erPaIBQKyqEYCRBM0qu92PrBnUcctIC9O+Ch0vt0qWt3rSW/1E+suBPE4+6X13
 qoY+WZTOQibJDupUZYDJeCPqcOR3gGbx8lTg9gY6tZD2FZhpuBb1vsMK6eq6KYY0NZ12
 g3Xw==
X-Gm-Message-State: AOJu0YyhFsD9hal8AIjwdsk81tjky3ONse0QVxPx2g0HbA5RI10NaYWU
 gGKMlejXtRbHAXUEKj794Nlm9TKWyLgAu6FKp4K1u3wrJOMdlWkns9cn6Acq1E5F4UNWaNwvM4B
 y
X-Gm-Gg: ASbGncsuPcqCZJk4OheUqqs0BWby3g4a22kCmaNA9bEjeU9vAK0Yojs9lKHLP6q7Lq9
 JkBBw0oiuylzDXGl21O7zTbxAyhYU4H4cVm9GXHD0zaav4e2OyLvWVOefkbZ9kPp5rtZ4WseGrY
 sEWGhfEyChVTZY/uYLcXwfuXLI2A41P4fFx6VZDbkCOE1pxMLCHgZUDxxsCn830+jJxRCYreqmU
 pDw/6Ubk0NkgzXsJ79f9AHNI1kCfxS/kVeH3kLQvcKNWPlespoNid+JOXKqzGEcaLUcK4ozHkeW
 3ViF/1+zcZhdJvP7RpvdHsCUG9l/n9PDKjLOP36iiKQTp+is6BFN8tA92z3xEccMwc5IPp/mW+w
 8GsxD2b+OZMX++U3+12W3fU874zVfxLU=
X-Google-Smtp-Source: AGHT+IHRqG/lJzCcAQZCLKDNTp5GNZDqlp2eghm9UYNYKuxemB713efwdDXoNgoJGEp/ltp9p+a3Lg==
X-Received: by 2002:a05:6402:1e8e:b0:5f6:d53f:cb9d with SMTP id
 4fb4d7f45d1cf-5fa7891a94emr3357374a12.30.1746212233486; 
 Fri, 02 May 2025 11:57:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77755777sm1569609a12.6.2025.05.02.11.57.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 03/19] hw/mips/loongson3_virt: Prefer using
 fw_cfg_init_mem()
Date: Fri,  2 May 2025 20:56:35 +0200
Message-ID: <20250502185652.67370-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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
with DMA support. Without DMA, use fw_cfg_init_mem().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index de6fbcc0cb4..41733988729 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -286,7 +286,7 @@ static void fw_conf_init(void)
     FWCfgState *fw_cfg;
     hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
 
-    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
+    fw_cfg = fw_cfg_init_mem(cfg_addr, cfg_addr + 8, 8);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, loaderparams.ram_size);
-- 
2.47.1


