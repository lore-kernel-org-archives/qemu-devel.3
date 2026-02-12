Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EBEEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvJ-0005pK-GT; Thu, 12 Feb 2026 09:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Nk-P9
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuW-00062Q-NG
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88S69tjfHiWtrSxu0v7zYgbs5OyDo7TvODXnvOF9ylI=;
 b=bhyZfuAB4kPX5hmNCicobTRZkXa2YX7jYzeXm7vuY7oXYDgb4sm/9/BVZsbBedVf1SCCMe
 O81YIrEBqImIsiYGp20kHdxz+una18u7/CtY7iMFAMCBhpR3T4aFev1neI+S0mG7FuAn0h
 2ISwp8QPms844b5lGb/i2uwY4YbrRs0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-mXAw7z5MO-WxNfb0AbGfmQ-1; Thu, 12 Feb 2026 09:43:14 -0500
X-MC-Unique: mXAw7z5MO-WxNfb0AbGfmQ-1
X-Mimecast-MFC-AGG-ID: mXAw7z5MO-WxNfb0AbGfmQ_1770907393
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so60279945e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907393; x=1771512193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88S69tjfHiWtrSxu0v7zYgbs5OyDo7TvODXnvOF9ylI=;
 b=InOpTc8OIfwwcvvCNqc4KKIX2dWoK27GAq8UQgFKYCtEDcmWvjNuTMU+SmnFYO5PzY
 ogL1Lh2rhswVeEUm0X2ck5pjGQcDfOuuG4s5KPuVTyiQQA12wfyCfr3iS+Y++U6Rm6ow
 Yy2yzDz+MIKlbr3iHhUrFleQo2ji0sPspqLTiV5ZV5xFSRmrZKSTbty1DTv9hD3WLaHB
 IkhmXTo7HnshWb/CnK9m+Y2UHZcJ92bwleHerz7JWlbuIZcopUXRDXExgNlk9j0z3rub
 2mHtJndQHMjGcVZz2S8sSWoqZGBO2T9jRakButE+jPVBQboEcHQybqkzVqkTTSNkgpPy
 heOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907393; x=1771512193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=88S69tjfHiWtrSxu0v7zYgbs5OyDo7TvODXnvOF9ylI=;
 b=HZs3LiWtwxlTOZqih7cXwuPBNlQsrFPTePsClYQh7hxI+Urkz/wy2pkspK2eNisYTr
 oDdYV0i23xvdz8SlCHCh/4jartQTSIeSgb3qBM2rBtqQyOFLBunuHb7anhXegJ+MaFg4
 lnpEV6MdYRKlvEdM+fZMJws4HmwV84l6twpzVnnGl37nWq01PnHdcgfgqCPa5qyIXal6
 RVPg5J0iaYH1eICrdya/O6icKHpm6MEAUwgDrSIltaL9kdHeTeKgvKUoIr2QolTZ8bB7
 neqUWEtvVgKMTYJ5NjgdGWjCECjPhT1Is4IsU+Ri+Md461ItH3kMPWyBkj/gi8qbjwEY
 kvVg==
X-Gm-Message-State: AOJu0YyteQv2Yl39vK9Tn2+3kyig6ddLxfmGB4P8BM14MrKMn5UVPWJd
 EbXpSFxD7mIP+TAvHgGiF2Z2edW8I7IEtkCuGOWei4nVWjJme4BypWv8rLg3S4h53zbWqOfT9v9
 LMpxUVCLwze6fVuc0hxuLXRguosCJS/mWrZVnwj2Hn8mjKHwyWyzIXhHlygxtgLklWubT+xjqHf
 JmRtsmrxogMd+eH74S6IomebwX1fpwFlbLBRLfwYSx
X-Gm-Gg: AZuq6aJS4VQDY1dWEtEwP3kBdhJiDwp1dK8dps89GP/FdmAPXU5enFh+yCT23q/G7ZA
 KBTA2rBaU7wJwOEAhwpkODHTHSfLLtTZaVyWQTQeTVkRC2b+lt4jv0fgoJ85xVkxqWDUIK+ttNN
 GBZb8t8N4KqpG+mmxMrBDJiEDSz0TLCihjFRkSCXi579IZb9vcv0tSwfnOSftf6QhRb4wY2GZFz
 y4O3hOqiWRIJBT4YkE5+EBEUnBWpcnMcdbEeH54C4oYbWRoA4q4Jv0wcGHCBdlG55jmwPI95dxP
 J3s7kNVfcqBDheQSeR1tBBrE3ihOvc+SwnJY3aiAoX8lisSHKoyGa5Z0d4C/a3Ewwtu9Jurd9Jk
 4W3TWTHv+TLQyoJbKjKzKmoHZ45a87/8rjMCR6jVG6TURWd55O4Q16HEP14ZVisEI9+sCccs/KO
 VMYlf2DunbTihsFv7bo0JFEtP8BOB99ipqgrFIHmN5vYsz/kuQ0SQ=
X-Received: by 2002:a05:600c:a09:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4836570d0e7mr35992125e9.20.1770907392615; 
 Thu, 12 Feb 2026 06:43:12 -0800 (PST)
X-Received: by 2002:a05:600c:a09:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4836570d0e7mr35991585e9.20.1770907392049; 
 Thu, 12 Feb 2026 06:43:12 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a5bf1efsm93492635e9.0.2026.02.12.06.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 12/41] hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
 fw_cfg_init_mem_dma()
Date: Thu, 12 Feb 2026 15:42:14 +0100
Message-ID: <20260212144244.22579-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"wide" in fw_cfg_init_mem_wide() means "DMA support".
Rename for clarity.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-12-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 6 +++---
 hw/arm/virt.c             | 2 +-
 hw/loongarch/fw_cfg.c     | 4 ++--
 hw/nvram/fw_cfg.c         | 6 +++---
 hw/riscv/virt.c           | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 510b227b7ef..56f17a0bdcf 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -309,9 +309,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as);
+FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
+                                hwaddr data_addr, uint32_t data_width,
+                                hwaddr dma_addr, AddressSpace *dma_as);
 
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 390845c503b..13d2057fb30 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1412,7 +1412,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     FWCfgState *fw_cfg;
     char *nodename;
 
-    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
diff --git a/hw/loongarch/fw_cfg.c b/hw/loongarch/fw_cfg.c
index 493563669e5..d2a79efbf76 100644
--- a/hw/loongarch/fw_cfg.c
+++ b/hw/loongarch/fw_cfg.c
@@ -23,8 +23,8 @@ FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms)
     int max_cpus = ms->smp.max_cpus;
     int smp_cpus = ms->smp.cpus;
 
-    fw_cfg = fw_cfg_init_mem_wide(VIRT_FWCFG_BASE + 8, VIRT_FWCFG_BASE, 8,
-                                  VIRT_FWCFG_BASE + 16, &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(VIRT_FWCFG_BASE + 8, VIRT_FWCFG_BASE, 8,
+                                 VIRT_FWCFG_BASE + 16, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8a21cdae4fc..1d7d8354213 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1088,9 +1088,9 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
+                                hwaddr data_addr, uint32_t data_width,
+                                hwaddr dma_addr, AddressSpace *dma_as)
 {
     assert(dma_addr && dma_as);
     return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bd8608ea5bf..07e66b39364 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1274,8 +1274,8 @@ static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
 
-    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
-                                  &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
+                                 &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     return fw_cfg;
-- 
2.52.0


