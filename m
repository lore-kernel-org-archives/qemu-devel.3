Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C8EE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvQ-0005wY-AT; Thu, 12 Feb 2026 09:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Nn-RQ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuf-00063s-0p
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeyKAy+Sk16BZBcLEdZFiLIsmU/3OCDrP03DNwve1oA=;
 b=G8cyH3QGF4cGIS6hOF/3ugHPIFrjSvFbg2ZPgTmUsv7pjK5AKPzfb6jCriMJBIJiNqgDH5
 TDAF2JB4WlVWsf22FKnSI/byT6qE8YI1mDyUJEbtW8Z+X4l1Ul98RMDR2YQ91cI/IL5I/5
 LLXnXDofyX4+DTnqa5see1qy+7BvOV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-b-qTDgxeMXK405QVihxjWg-1; Thu, 12 Feb 2026 09:43:22 -0500
X-MC-Unique: b-qTDgxeMXK405QVihxjWg-1
X-Mimecast-MFC-AGG-ID: b-qTDgxeMXK405QVihxjWg_1770907401
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-482eec44485so24801975e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907401; x=1771512201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeyKAy+Sk16BZBcLEdZFiLIsmU/3OCDrP03DNwve1oA=;
 b=brufwcFodL5mfg2u4lh/GjsxbzqSHABfVKKBQy9uJrZbvVEwYu32l1EFHCx26qqXTp
 9gR7kmdlUpd6h3mAbfdx1TuHL9bCr315bbb4UtAX/wFwhhmvU6taTLCcd1Uf4b371RlG
 orLgU7MQ2XtArYpML4KYWx1XUxTqJIslYJIVMUXgTAaC9kkz9qeJCs0WvWj4nKlF/4Es
 BwbZQ+RAw193xiyEdlE6/JHY3/mXJpn29CsD1TJMddnB+oL1DjgB2MV0aLTkneDFgHjh
 Wvuzx42mvRP9NnZ4NDxiJzyIFgutnV2wzxPeT9zDW2/073VjEAlnMIkW+dD/tREGiKX3
 +UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907401; x=1771512201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jeyKAy+Sk16BZBcLEdZFiLIsmU/3OCDrP03DNwve1oA=;
 b=XJ6GMsrWtaDo0uc7xA30Zl1sd117kUC8JRCdgynIF0bd8BHAl3+AnixUggL6OG08EY
 zHH+MPLLdu9zlrg+ATpnyO/MbCMfKuKEwd1Og4NrXtLEajapIPJtZ1I502yVgLdCrNEC
 KbxIJF4WS9eNkSwffGl3MYXsBBZ1l5U8DeUcg2VhuKnObMco6ys9Kp2uHbA/5TnwmnDn
 3Fopa+JtuEIAAAUtoK58/tkgJee6+q3MFa0aLF1tMCQih0C6H+rhUDQOTqsTnHg+iSAo
 7s4bHzgo0SidwmtOrvIyqexcxvOHBeKjJo1PLwlQ6GYqmb2Za5o8nn3hLRp9UOdiykDN
 Yfjw==
X-Gm-Message-State: AOJu0YxVDQH7FXQJb/xGupIpQ75I3PV2d+qx0i6AifsvFq3Bzv1OP8pn
 brQ6Rof27+L5vA+zYXSM6DA4DGLWSDlE0BxBIDblL0LZB5fR4Y1tEprbqpbVE2HVahkN12Y6ih3
 CsngmRBxq7Hykb8hcCu2S87cS+jgDePvWwGJHuxm/L0IcnOP+v6RHZMkiw8rltACxXAh7v7ntUT
 HUvN9YBTUxi6l3AX3D/TYpB+aqP87yV5fItRQkpWbu
X-Gm-Gg: AZuq6aKDDCHj/NqyGT9mGf3hLG5SHTVKsOQIajcdgN6Xlo9DEkfauXSJ2JvF740XMq9
 LWiwgNeORUN+oke3OAI8urUn8EiK1K35N5Q8RDyQPbBJ6awGgoyFoFSW7/vWSsON3XWgnrZ3xZU
 kE9s7ITL0W4nZtEA9vMQ2j10lnMG4XF7cHntWdDBLhdEwnuYTdfrAiL79/fbFGHlf92xv/qp0GZ
 YyjrhgjZTyyDuKH6A6IK8QkPbB9yTo8V9i7AeHRUFwUpPBLvXXTw23U3AHPFe0NaEzB6wr6FNPc
 rOP7CvoqA8jKOSFlRL2Q0tgzaVQ09YcMUz5q/vbvINZ8kc7y1Kg8SsJG10HgoUO3zyJOrHM5IvD
 5DOhHiB3bLbY187hkEgc1VD5QcRsK4ZcZ154jxKfqJUsPMkMU5UckrVCRLPRvndw9lcxbh4ero3
 TVQsZoaKtnlz2Yc5qsyirr62MweuIufH02TyeooPECcUcOjkIddDw=
X-Received: by 2002:a05:600c:5489:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483671146f6mr31599625e9.11.1770907400511; 
 Thu, 12 Feb 2026 06:43:20 -0800 (PST)
X-Received: by 2002:a05:600c:5489:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483671146f6mr31599085e9.11.1770907399918; 
 Thu, 12 Feb 2026 06:43:19 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba3e4b5sm69694995e9.5.2026.02.12.06.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 15/41] hw/i386: Assume fw_cfg DMA is always enabled
Date: Thu, 12 Feb 2026 15:42:17 +0100
Message-ID: <20260212144244.22579-16-pbonzini@redhat.com>
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

Now all calls of x86 machines to fw_cfg_init_io_dma() pass DMA
arguments, so the FWCfgState (FWCfgIoState) created by x86 machines
enables DMA by default.

Although other callers of fw_cfg_init_io_dma() besides x86 also pass
DMA arguments to create DMA-enabled FwCfgIoState, the "dma_enabled"
property of FwCfgIoState cannot yet be removed, because Sun4u and Sun4v
still create DMA-disabled FwCfgIoState (bypass fw_cfg_init_io_dma()) in
sun4uv_init() (hw/sparc64/sun4u.c).

Maybe reusing fw_cfg_init_io_dma() for them would be a better choice, or
adding fw_cfg_init_io_nodma(). However, before that, first simplify the
handling of FwCfgState in x86.

Considering that FwCfgIoState in x86 enables DMA by default, remove the
handling for DMA-disabled cases and replace DMA checks with assertions
to ensure that the default DMA-enabled setting is not broken.

Then 'linuxboot.bin' isn't used anymore, and it will be removed in the
next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20260108033051.777361-15-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c     | 16 ++++++++--------
 hw/i386/x86-common.c |  6 ++----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 5c0bcd5f8a9..5670e8553ea 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -215,18 +215,18 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
 #ifdef CONFIG_ACPI
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
 {
+    uint8_t io_size;
+    Aml *dev = aml_device("FWCF");
+    Aml *crs = aml_resource_template();
+
     /*
      * when using port i/o, the 8-bit data register *always* overlaps
      * with half of the 16-bit control register. Hence, the total size
-     * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
-     * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
+     * of the i/o region used is FW_CFG_CTL_SIZE; And the DMA control
+     * register is located at FW_CFG_DMA_IO_BASE + 4
      */
-    Object *obj = OBJECT(fw_cfg);
-    uint8_t io_size = object_property_get_bool(obj, "dma_enabled", NULL) ?
-        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
-        FW_CFG_CTL_SIZE;
-    Aml *dev = aml_device("FWCF");
-    Aml *crs = aml_resource_template();
+    assert(fw_cfg_dma_enabled(fw_cfg));
+    io_size = ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t);
 
     aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 192e91042f2..de4cd7650a4 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1002,10 +1002,8 @@ void x86_load_linux(X86MachineState *x86ms,
     }
 
     option_rom[nb_option_roms].bootindex = 0;
-    option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (fw_cfg_dma_enabled(fw_cfg)) {
-        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
-    }
+    assert(fw_cfg_dma_enabled(fw_cfg));
+    option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     nb_option_roms++;
 }
 
-- 
2.52.0


