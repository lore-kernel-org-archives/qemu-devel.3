Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5A8C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk37J-0005Rx-S5; Tue, 12 Mar 2024 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36x-0005NA-Jy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:13 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36v-0005P1-Ag
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:11 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so7619277e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1710253687; x=1710858487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KV5ZYoaHLmWxMWoTm01z+WFnwLPqemdbnw4H9NY/m5g=;
 b=D3weMhcyg6l86G8cjFIhxFkuxYNcrqd2jZgvo8xQaBh3nCNfeDwaXWSKhT7Ax0Y2je
 LdYXUN4sAaXBA5OwqBMtX+/9sFX5XEaytSlNGunDTtL3aScc3YSpoMhbuU85grl4ro/s
 IEtfPDOWnP7s/ItC2jzARQIstJ+3JYvFpgyTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710253687; x=1710858487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KV5ZYoaHLmWxMWoTm01z+WFnwLPqemdbnw4H9NY/m5g=;
 b=PK3rOgvCQPmSap2M1agtEJKKG7f/3Vu0ByFrDw8hspg3/uby3wyEPetJIN29ncx2sP
 PXF3U7kskaGC4NWI12bO7mWJ2j/e6iILOtJbiUv1oH6uJoXse5DMFbbdWrkUEtalbkh7
 dP5dUjn4LGCUH8lN7kRSleOQ3ChzyAk2QI/7Hf7mCJv531di0tfb/ueQKqGZFXwN+5sI
 QBpguSA6SQuA/rXE6wacUNpDZ4CrpmiTiSq/nyKRDRh0XMa5+GJhwCR7u34qU7FuNE5t
 gozHo3PvklxRTlRzQNaVXu2AWFdfj8SBCTqg6dcewB/qWrplCWeSy4hqhZVLFXrgAuXd
 QxlQ==
X-Gm-Message-State: AOJu0YxY0XVh+E4cm/NMcxpS9W1b2DsBSdiVuUuBXA+35jkJjKTOFIPL
 vRfSFnOs1nWWrCjgmpr3R8o028BY+49wHpgAhVBCENsfE/S9ziQphMK+ELD5gTg/dMaj/bZXFQc
 x
X-Google-Smtp-Source: AGHT+IHxcatKHz1Lw5UPK3bYSr7CQ6xYEictmegTTCZPXUOugN4Ji7BehjBt+Tk1QwsXItEqzOEItQ==
X-Received: by 2002:a05:6512:48c6:b0:513:8030:fde9 with SMTP id
 er6-20020a05651248c600b005138030fde9mr2754940lfb.58.1710253686936; 
 Tue, 12 Mar 2024 07:28:06 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92320-cmbg19-2-0-cust35.5-4.cable.virginm.net. [82.13.64.36])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c198d00b00412b0e51ef9sm12810270wmq.31.2024.03.12.07.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:28:06 -0700 (PDT)
From: Anthony PERARD <anthony.perard@citrix.com>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PULL 1/3] xen/pt: Emulate multifunction bit in header type
Date: Tue, 12 Mar 2024 14:27:55 +0000
Message-Id: <20240312142757.34141-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312142757.34141-1-anthony.perard@citrix.com>
References: <20240312142757.34141-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=anthony.perard@cloud.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

The intention of the code appears to have been to unconditionally set
the multifunction bit but since the emulation mask is 0x00 it has no
effect. Instead, emulate the bit and set it based on the multifunction
property of the PCIDevice (which can be set using QAPI).

This allows making passthrough devices appear as functions in a Xen
guest.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20231103172601.1319375-1-ross.lagerwall@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen_pt_config_init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index ba4cd78238..3edaeab1e3 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -292,7 +292,10 @@ static int xen_pt_header_type_reg_init(XenPCIPassthroughState *s,
                                        uint32_t *data)
 {
     /* read PCI_HEADER_TYPE */
-    *data = reg->init_val | 0x80;
+    *data = reg->init_val;
+    if ((PCI_DEVICE(s)->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)) {
+        *data |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    }
     return 0;
 }
 
@@ -677,7 +680,7 @@ static XenPTRegInfo xen_pt_emu_reg_header0[] = {
         .size       = 1,
         .init_val   = 0x00,
         .ro_mask    = 0xFF,
-        .emu_mask   = 0x00,
+        .emu_mask   = PCI_HEADER_TYPE_MULTI_FUNCTION,
         .init       = xen_pt_header_type_reg_init,
         .u.b.read   = xen_pt_byte_reg_read,
         .u.b.write  = xen_pt_byte_reg_write,
-- 
Anthony PERARD


