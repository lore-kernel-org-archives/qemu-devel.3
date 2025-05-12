Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FABEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOjd-0000XT-Kg; Mon, 12 May 2025 04:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiT-0007Rv-GB
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiQ-0001kO-6R
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a1f5d2d91eso2123675f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039248; x=1747644048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz/xSSjZEmm554UoAp4855/8BqJuWGFPG+bFUFjEtXE=;
 b=YbyUOftDX6I7bSRDy+Fmwcp61G+l+v14L1B+sktOVl1LQ0XntjjznrNOUfyMulrfc+
 +CI/rp+W5+Zccuqc13DFRVGrcVC7wFPkxMMhhqdqtFY8Nkh9wuaYYP+JXVcp05ahHAjy
 kuKxVcHvsLZn3hgnjD3nBhAQq54JM93qoeYmnGH1kdkV3qqyHTZZAA353oDSOCst5hYS
 n8VEo8sKfyCFBTumI+Mi8OyF/qGXCHiBty2Dw1QfftoVlsk+Eg8QSpYmw9TewDNeBvgm
 RRT6FtkUD7CcW6l8QLBEmzeD8eighzfejgPiPGn2HePAC+fRsB+qqzii71TQ7YUIRXax
 jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039248; x=1747644048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz/xSSjZEmm554UoAp4855/8BqJuWGFPG+bFUFjEtXE=;
 b=OUniMi55SE9pHTpsiKooenqoYQH0ZU9eoyu8ykdK74rS2Eez6KeH+evlQ9SovAnal7
 pKLpCCU4lDcLyZE9zAuZpx1WmtxvSQXO2hDXsOfjnKVnBSozapgds6hUvf1ZEp/nRRL6
 SYoqTJDR6LcRWmtRaLCT9EWIMElY+QNK+M9yfVtQgmSpOpKuCT+wnQJ4RhbzG2mN5804
 nmFDw0Rr8w0rf/mHQJkgdrv+SPJXd0BMB0lNHB+5ueE6ykndusYYwQYB3XvW9OY9U9Au
 k8v91xE+ZpOeY4+5PXqcgYd6aWwb7zLTK+7VWwBylIwilNC15949Ldr4hbCm1jqkGKJc
 sumw==
X-Gm-Message-State: AOJu0Yzk/7DOrYIrz2Hl+H7rI03ZlWNnhCN48eRXFVNcDfGKGNcpN9om
 SNm1bdDggBw9ySGkviYVKKfm2bdahD/eOtkg6P2JYGMBIQCpj7ZDab6o8rb5gYADYccs7SNiIMQ
 Ajg2bzA==
X-Gm-Gg: ASbGnctCVMAhKPdLFrm3whfDLvkjiV/aLHO+GgOIapCWkuu96e/pJLgUml9IrjCupwT
 w+txCjJHjBqYaHwR2p+p7+Pfyl4MdGQgJrhZg4U3AjmJn0yOxzBNU/k3ghpxpN7/IQcajMHncqM
 Ey/9rplGPO0/MbBbFy/q1XOWNzWG8INP6RVx+eRLX9pFefNLCmvJuvF21b46i/I45IyEmC9Z3hd
 P4XahuMBg6WSuDEb6RrE8VEP02tjpgia6kDfIScoyE5i0z4g1Yb20Cd1MUd84At0CC0ZJ7CtMwG
 34VSAYFHZdfs7dIsU9ModAxRFtumTKnqvxlLdNJ5RmcGedwThnz8S0Sq7pLWhMtAF5WiHaqH4jX
 tTfOHc7ovO3OXSeHoLDrJReI=
X-Google-Smtp-Source: AGHT+IHZRzwcr50xyc3Ub2XATRFVOw7JZERwauX5gadfnIplp8m1YVj9VoeGzCWpcIzR6CRZSUbqYQ==
X-Received: by 2002:a05:6000:18a9:b0:3a0:88d5:6126 with SMTP id
 ffacd0b85a97d-3a1f64a5c07mr9634594f8f.39.1747039248032; 
 Mon, 12 May 2025 01:40:48 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf2bsm11539471f8f.80.2025.05.12.01.40.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Date: Mon, 12 May 2025 10:39:35 +0200
Message-ID: <20250512083948.39294-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
via the 'extra_mac_registers=off' property. We removed all
machines using that array, lets remove all the code around
E1000_FLAG_MAC, including the MAC_ACCESS_FLAG_NEEDED enum,
similarly to commit fa4ec9ffda7 ("e1000: remove old
compatibility code").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/net/e1000.c | 93 ++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index cba4999e6d0..a80a7b0cdb4 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -127,10 +127,8 @@ struct E1000State_st {
     QEMUTimer *flush_queue_timer;
 
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
-#define E1000_FLAG_MAC_BIT 2
 #define E1000_FLAG_TSO_BIT 3
 #define E1000_FLAG_VET_BIT 4
-#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
 #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
 #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
 
@@ -1212,52 +1210,51 @@ enum { NWRITEOPS = ARRAY_SIZE(macreg_writeops) };
 
 enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
 
-#define markflag(x)    ((E1000_FLAG_##x << 2) | MAC_ACCESS_FLAG_NEEDED)
 /* In the array below the meaning of the bits is: [f|f|f|f|f|f|n|p]
  * f - flag bits (up to 6 possible flags)
  * n - flag needed
- * p - partially implenented */
+ * p - partially implemented */
 static const uint8_t mac_reg_access[0x8000] = {
-    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
-    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
-    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
-    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
-    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
-    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
-    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
-    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
-    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
-    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
-    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
-    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
-    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
-    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
-    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
-    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
-    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
-    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
-    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
-    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
-    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
-    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
-    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
-    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
-    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
-    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
-    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
-    [BPTC]    = markflag(MAC),
+    [IPAV]    = MAC_ACCESS_FLAG_NEEDED,    [WUC]     = MAC_ACCESS_FLAG_NEEDED,
+    [IP6AT]   = MAC_ACCESS_FLAG_NEEDED,    [IP4AT]   = MAC_ACCESS_FLAG_NEEDED,
+    [FFVT]    = MAC_ACCESS_FLAG_NEEDED,    [WUPM]    = MAC_ACCESS_FLAG_NEEDED,
+    [ECOL]    = MAC_ACCESS_FLAG_NEEDED,    [MCC]     = MAC_ACCESS_FLAG_NEEDED,
+    [DC]      = MAC_ACCESS_FLAG_NEEDED,    [TNCRS]   = MAC_ACCESS_FLAG_NEEDED,
+    [RLEC]    = MAC_ACCESS_FLAG_NEEDED,    [XONRXC]  = MAC_ACCESS_FLAG_NEEDED,
+    [XOFFTXC] = MAC_ACCESS_FLAG_NEEDED,    [RFC]     = MAC_ACCESS_FLAG_NEEDED,
+    [TSCTFC]  = MAC_ACCESS_FLAG_NEEDED,    [MGTPRC]  = MAC_ACCESS_FLAG_NEEDED,
+    [WUS]     = MAC_ACCESS_FLAG_NEEDED,    [AIT]     = MAC_ACCESS_FLAG_NEEDED,
+    [FFLT]    = MAC_ACCESS_FLAG_NEEDED,    [FFMT]    = MAC_ACCESS_FLAG_NEEDED,
+    [SCC]     = MAC_ACCESS_FLAG_NEEDED,    [FCRUC]   = MAC_ACCESS_FLAG_NEEDED,
+    [LATECOL] = MAC_ACCESS_FLAG_NEEDED,    [COLC]    = MAC_ACCESS_FLAG_NEEDED,
+    [SEQEC]   = MAC_ACCESS_FLAG_NEEDED,    [CEXTERR] = MAC_ACCESS_FLAG_NEEDED,
+    [XONTXC]  = MAC_ACCESS_FLAG_NEEDED,    [XOFFRXC] = MAC_ACCESS_FLAG_NEEDED,
+    [RJC]     = MAC_ACCESS_FLAG_NEEDED,    [RNBC]    = MAC_ACCESS_FLAG_NEEDED,
+    [MGTPDC]  = MAC_ACCESS_FLAG_NEEDED,    [MGTPTC]  = MAC_ACCESS_FLAG_NEEDED,
+    [RUC]     = MAC_ACCESS_FLAG_NEEDED,    [ROC]     = MAC_ACCESS_FLAG_NEEDED,
+    [GORCL]   = MAC_ACCESS_FLAG_NEEDED,    [GORCH]   = MAC_ACCESS_FLAG_NEEDED,
+    [GOTCL]   = MAC_ACCESS_FLAG_NEEDED,    [GOTCH]   = MAC_ACCESS_FLAG_NEEDED,
+    [BPRC]    = MAC_ACCESS_FLAG_NEEDED,    [MPRC]    = MAC_ACCESS_FLAG_NEEDED,
+    [TSCTC]   = MAC_ACCESS_FLAG_NEEDED,    [PRC64]   = MAC_ACCESS_FLAG_NEEDED,
+    [PRC127]  = MAC_ACCESS_FLAG_NEEDED,    [PRC255]  = MAC_ACCESS_FLAG_NEEDED,
+    [PRC511]  = MAC_ACCESS_FLAG_NEEDED,    [PRC1023] = MAC_ACCESS_FLAG_NEEDED,
+    [PRC1522] = MAC_ACCESS_FLAG_NEEDED,    [PTC64]   = MAC_ACCESS_FLAG_NEEDED,
+    [PTC127]  = MAC_ACCESS_FLAG_NEEDED,    [PTC255]  = MAC_ACCESS_FLAG_NEEDED,
+    [PTC511]  = MAC_ACCESS_FLAG_NEEDED,    [PTC1023] = MAC_ACCESS_FLAG_NEEDED,
+    [PTC1522] = MAC_ACCESS_FLAG_NEEDED,    [MPTC]    = MAC_ACCESS_FLAG_NEEDED,
+    [BPTC]    = MAC_ACCESS_FLAG_NEEDED,
 
-    [TDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [PBM]   = markflag(MAC) | MAC_ACCESS_PARTIAL,
+    [TDFH]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFT]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFHS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFTS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFPC]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFH]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFT]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFHS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFTS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFPC]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [PBM]     = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
 };
 
 static void
@@ -1419,13 +1416,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool e1000_full_mac_needed(void *opaque)
-{
-    E1000State *s = opaque;
-
-    return chkflag(MAC);
-}
-
 static bool e1000_tso_state_needed(void *opaque)
 {
     E1000State *s = opaque;
@@ -1451,7 +1441,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     .name = "e1000/full_mac_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = e1000_full_mac_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
         VMSTATE_END_OF_LIST()
@@ -1679,8 +1668,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 
 static const Property e1000_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000State, conf),
-    DEFINE_PROP_BIT("extra_mac_registers", E1000State,
-                    compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
                     compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_BIT("init-vet", E1000State,
-- 
2.47.1


