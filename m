Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEAFEE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvQ-0005wp-E6; Thu, 12 Feb 2026 09:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Ng-Ng
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuO-00060T-Uf
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZHLH0U5siZ164vGiDBTwZt96Hx+LUB/6fV12sKSbIg=;
 b=f6iYHd8dfZOKF7lo6qcHTYyZL6Rq8T5oG+kWGA0coP7xD2LRUmc17hSGc95hviscPd16KK
 O9trUxsJLraai2k3J5lmEcSy75NYOsJWVQUDk2IsGxiSaPmyD1XlVL14DJlLLhLQchgJ/S
 tx+CXv6rZhaF67BfrIOtXPAJx5K40Dw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-FBa-UIo0MKaD4U1q979Ldw-1; Thu, 12 Feb 2026 09:43:07 -0500
X-MC-Unique: FBa-UIo0MKaD4U1q979Ldw-1
X-Mimecast-MFC-AGG-ID: FBa-UIo0MKaD4U1q979Ldw_1770907386
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso64139695e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907385; x=1771512185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZHLH0U5siZ164vGiDBTwZt96Hx+LUB/6fV12sKSbIg=;
 b=j4EIdQos0Zjt3Uit11ahQ0JTt6tG0mGb9aCegTdS6bbpvRrrP1vrYuavdf3HKHobEw
 PENR2YCkzsRaEcUFkzSoUE99vBDQy+TNoQ0Ybvp0SLrEKaugIllSfpKO+BoMdRTXBMok
 DIgPEzLFsrF1rJaWaZrey8oQ18Xfy8XxeH/VTfqbQWXPBSErE/oW2ktlDWXyvCoHoa3C
 aWcNjFGomJVsVMLYuMSUg84yKhL7/YROgEBtci0yyeqjmmjAkQACPS3V0LolV+9WuhnE
 FzoPLnTS6jUoVH+7BxdaaM2pKzeNEPforNR0OwucOnlrlSNPtqLv2U4UCbsE152A4PvX
 I10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907385; x=1771512185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aZHLH0U5siZ164vGiDBTwZt96Hx+LUB/6fV12sKSbIg=;
 b=tCEJH810HNIIw7C5g+xvtM8jtJVY++gIY5eOQdaUHIyp3dHfggPOeQX3CNIwA7XvR9
 wvW3HeH/9lH6FcDLlaaU443tbilnb6VYoClZQok/r1/yLx8LfVpPXuPVBy/zP5cuLCG8
 GBf0OVNNaMg2BtTnEN6R9ZG3IZN7aof0Jlgzcd7wpXIKMUeGoVY0EWlinr3hFbSCKEt8
 fSbEc9ndASarYbbrLOVyOloMTd/dw+DHcjD9IR9tSYqWwHTw+HttzkicQpFShCx7LeOi
 XECtRdd/vy8JO7Tc3OkO6vKG5/kK6BitU27qa+PC63pHiOM/kyptWp4duXN4PjoQUCmO
 XXjA==
X-Gm-Message-State: AOJu0YyVe8ZENoMUmLe58pz+cqDfISGbypWMbjh4PMn+7BLqxCYUZZuS
 X6LuDpOq2DHiA3wuqOulywIUUPnrFX0QvtW7nil3/H9AM5R92a0OBtbPZ2iiQF4jZ8CZ4i+rF6W
 BJChk3pNXBFYvz8i8XLggxva2Xdt1VzX/X228g7NGVtj9Y6I/KvML0paejIygWgAVpQvmekbXCc
 FhWxPuZ9O3yhNMaeOa4TsqCqFY/hOso3xgIIL2rxff
X-Gm-Gg: AZuq6aJGHFa+E7QfJYOwj8h1rZjlwaY2KoCHank++kp0tj+GTo37XsTlxCWt0UgzwXd
 YespupHTIDYqROUfNkJIfR80M1qB4GKIYxtpHOrG/CNZlrsREa14X3F5FWIHTFnkYksOoEbmE5L
 VRgutGdzkGH8XBp0isF6qVwDX2nX9jRnslKYLAw9pR5/ohQsgm36TdZl/T2j0OvoGqFH9gy7iDa
 n1GAUhRrMALUS0GD3n/BtmuzOum0mqnlTjqQKgfmVkJPET870Xy5g1mU3HoUzfJqb9SsUUByi54
 EqL8B9ejaahO9sNO9iZi5g34yK3rEDN2T9BMAr3mlwauGu0f2lw3gOmnmy2u/Rt/gCgGgyAXd1D
 KNZE4iLRdf302hokEXjDqHAujzbNzPqdBhnOr99l+VRwSH1phcYIuncxI4YKPXtRcg0TaZvmaCj
 AJt4qvFQbD2WUFNZEA2yneWiyaij4rQcRgrw/3juCq2bVYbpTvNJg=
X-Received: by 2002:a05:600c:1d86:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4836571faf9mr44827695e9.35.1770907385279; 
 Thu, 12 Feb 2026 06:43:05 -0800 (PST)
X-Received: by 2002:a05:600c:1d86:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4836571faf9mr44826985e9.35.1770907384799; 
 Thu, 12 Feb 2026 06:43:04 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e15bsm103362835e9.13.2026.02.12.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 09/41] hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with '_nodma'
 suffix
Date: Thu, 12 Feb 2026 15:42:11 +0100
Message-ID: <20260212144244.22579-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Rename fw_cfg_init_mem() as fw_cfg_init_mem_nodma()
to distinct with the DMA version (currently named
fw_cfg_init_mem_wide).

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 3 ++-
 hw/hppa/machine.c         | 2 +-
 hw/nvram/fw_cfg.c         | 7 +++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index a29a5d55eab..510b227b7ef 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -307,7 +307,8 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
 
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
-FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
+FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
+                                  unsigned data_width);
 FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
                                  hwaddr data_addr, uint32_t data_width,
                                  hwaddr dma_addr, AddressSpace *dma_as);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 960aefc9e26..c3680667aee 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -208,7 +208,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     int btlb_entries = HPPA_BTLB_ENTRIES(&cpu[0]->env);
     int len;
 
-    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
+    fw_cfg = fw_cfg_init_mem_nodma(addr, addr + 4, 1);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 69e97361453..7751de3d977 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1088,11 +1088,10 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
+FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
+                                  unsigned data_width)
 {
-    return fw_cfg_init_mem_wide(ctl_addr, data_addr,
-                                fw_cfg_data_mem_ops.valid.max_access_size,
-                                0, NULL);
+    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL);
 }
 
 
-- 
2.52.0


