Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CCBC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZo-00056q-AV; Fri, 02 May 2025 14:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZm-00053N-G1
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:34 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZk-0005Ry-NO
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso513668466b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212250; x=1746817050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKc325giSSG2jMz6IXz+I31l486LYr2x6p+yz3FOCTQ=;
 b=LbYJAXqeYlyA+n48oQPf1aDKuXQ6z0RTYiD3c2R7GFGBMtceu3SugEvvc1JNX322mH
 N9ljLW879TxLzchXf77SvL/2l2aAqXROuXLrG+SZfcxF2iWlvZu3Epip0+u7hGqkTz0A
 rbS7pI3xuV7rsjYfSSDDAM98KPwpKb0EdwSipcuy7U1cn+gsh3dh+7sqAZIxn90iLtCR
 kIfv1jeCF2JfYzG9QxX4XdaH6osdRUkmbQi29owwTntLbuQOrY41jVf2KlB756opB2Yy
 jHI8v/TplCs9nO9QI6Ncbj9hsWUgYQ6J0ha7uE6AeLbDTSEn6H3J7SqoMAWCCgEnQ7nD
 XOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212250; x=1746817050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKc325giSSG2jMz6IXz+I31l486LYr2x6p+yz3FOCTQ=;
 b=KQNtwoO2TqfqnJKsl9YWtFSz65b8q0giAnWIebpt54M86U4d1qRZL7kxtdCnDN/I1j
 HFWYREX8CBynVwTW85o8uCc4ePFg9O0Ls8gkWMNAoXppJ1pbgJkoh34qEtiShXTpbQNL
 +jGhwTgDly/q0qs7+DP49g9y2CKvP9uXy82AHS8FyisilPss7OifIpZz1JpVqHrrcb/W
 hdMt6mX++3adFi2Zf+wFkau7+T7cnVjNqUw2uv/YQO0PXK1H4FI6IEQWwB7PrWD31dIp
 Kgr5kaelgORxoY4WKM8uBg9o5fLGfl8GFetElvmZi6lkFq7LBprFdtbYfohK3Xcu8iGh
 UAMw==
X-Gm-Message-State: AOJu0Yz76BLUQtO/CCRGl7f7zi+hu3J+eN1SZc+dTvorHn6swdZm/eOj
 QKgSVtcHwIKTviajUkC8i2UAA/cHGbAGLtSzoQs99K2mJE49FmUXMnR6ohTdjuaxlB5zeo+dRE3
 1
X-Gm-Gg: ASbGncup/lR25KOnXh5StOtuNwrG2vysukNp86gzd5G7vGK9W7FLzlWcuLGICrEIvm0
 sQP1vwdxdzL2/tmiqi7TYgrQpllIRanvHXt6iRa/dGtfwiEJ0/GeB81KAT2ZmM3rI61GD/+hhCg
 spMuhRhS6YqlpfAGCZZkrcH2PWpsOP5mYr1N0eoQ52TARKIJ/aDJK6jWq2H0pks84d2sBIP6K99
 LLs840Eg30wYXPUrzYfYN1DBMzaa63kPArpPbvdzEuZCXBYjT90yW2JCIs5d+GwoOFl/7D5y5iZ
 6wWRn4suYoUAUUKKgPKTI1hSmdeuCF4vSjjJCfKSnCO5lD9Ey83UK3kFqqdM3wuscCMGs3nHvXo
 5f8NpQSnvZxo3ze5+DhYH
X-Google-Smtp-Source: AGHT+IGwRzfNH9Uyfm9woG2N70pWcCB01As/wFVe87zj/jtYsrT5SkouYaK47dFnrgzuRoKqkzl0lg==
X-Received: by 2002:a17:907:1999:b0:acb:b966:3a8f with SMTP id
 a640c23a62f3a-ad17af47f9fmr369374766b.39.1746212250389; 
 Fri, 02 May 2025 11:57:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895094basm85876966b.145.2025.05.02.11.57.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:29 -0700 (PDT)
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
Subject: [PATCH v3 06/19] hw/nvram/fw_cfg: Remove
 fw_cfg_io_properties::dma_enabled
Date: Fri,  2 May 2025 20:56:38 +0200
Message-ID: <20250502185652.67370-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Now than all calls to fw_cfg_init_io_dma() pass DMA arguments,
the 'dma_enabled' of the TYPE_FW_CFG_IO type is not used anymore.
Remove it, simplifying fw_cfg_init_io_dma() and fw_cfg_io_realize().

Note, we can not remove the equivalent in fw_cfg_mem_properties[]
because it is still used in HPPA and MIPS Loongson3 machines:

  $ git grep -w fw_cfg_init_mem
  hw/hppa/machine.c:204:    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
  hw/mips/loongson3_virt.c:289:    fw_cfg = fw_cfg_init_mem(cfg_addr, cfg_addr + 8, 8);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/fw_cfg.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index d119c10d308..c1bd229e8f3 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1026,12 +1026,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     FWCfgIoState *ios;
     FWCfgState *s;
     MemoryRegion *iomem = get_system_io();
-    bool dma_requested = dma_iobase && dma_as;
 
+    assert(dma_iobase && dma_as);
     dev = qdev_new(TYPE_FW_CFG_IO);
-    if (!dma_requested) {
-        qdev_prop_set_bit(dev, "dma_enabled", false);
-    }
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
@@ -1042,13 +1039,10 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     memory_region_add_subregion(iomem, iobase, &ios->comb_iomem);
 
     s = FW_CFG(dev);
-
-    if (s->dma_enabled) {
-        /* 64 bits for the address field */
-        s->dma_as = dma_as;
-        s->dma_addr = 0;
-        memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
-    }
+    /* 64 bits for the address field */
+    s->dma_as = dma_as;
+    s->dma_addr = 0;
+    memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
 
     return s;
 }
@@ -1185,8 +1179,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
 }
 
 static const Property fw_cfg_io_properties[] = {
-    DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
-                     true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
                        FW_CFG_FILE_SLOTS_DFLT),
 };
@@ -1207,11 +1199,9 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
                           FW_CFG(s), "fwcfg", FW_CFG_CTL_SIZE);
 
-    if (FW_CFG(s)->dma_enabled) {
-        memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
-                              &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
-                              sizeof(dma_addr_t));
-    }
+    memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
+                          &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
+                          sizeof(dma_addr_t));
 
     fw_cfg_common_realize(dev, errp);
 }
-- 
2.47.1


