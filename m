Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB78FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVD-0001XG-Pe; Tue, 06 May 2025 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSR-00070i-2b
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSM-0001R9-Br
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so37357975e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542376; x=1747147176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7M6Tutx3exMAOrtlWY2rOEtIIwc+eHcrkvSbvRNBy0=;
 b=LtRH01ARqIqKI7ohlPV45FH1p7Fn3tMGeAsyrll6BtGwcvhOKdtpf5ihqZ9IeloHuo
 0REv1rlxgmJKOkRBxpMKiTOekfSufpebadX3VNXXanhSKuDInFH746IsE1Cx7aDLiDrY
 89/qnczTfvZAsGypqsPa70CPrB066UBbrua6I92iHu0/ivhTqGywhIZc4ScVIpV2ATbU
 QWd8v6tmlQCD08zjyZHw+QX2pMcNCHOY93R0GOtRuTU0Uggd2JLiXUe9FdQ4P18QICCA
 EU6Phq6AUWoHifMWwjJbnQheJTxBDaCauzwBXCUjZ/f0dZJFoHxeGfWvYj8Yc1TDXqkf
 YBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542376; x=1747147176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7M6Tutx3exMAOrtlWY2rOEtIIwc+eHcrkvSbvRNBy0=;
 b=uK4AOJAkhXpg6S/kghJIf6ZdH+NqFr41/Wy61TXzHXebHl4JzsR1NUDJdjf2E/ybfR
 wK6wMN67v82cbcrTEy5GO0di+dP17sxsK3H61bhLlajigYurfSr3dI4Cxvm80DDW9nLN
 m5untw2uszQWdCMIS+snhMasLvvGvNo9sizDcplY2GYuJ9ZAQjdBUhau/7tdskd8Zc/b
 Fu3oXrq/0G8+XTjeQ2P/rZsQOGvHNm9847cUJceWirEmFzBu8p8VACeH6BfS4tOiRf/i
 ghSCU5G7iaT+tndUhsTK9RJpuqxmJHk6GMvx8H2VO49dwTqQMrPB4v0dxoObRpvooBfG
 NbfQ==
X-Gm-Message-State: AOJu0Ywy0YaYrM4wAMY639ndWBAPBJxNFuBkNeOjBMru5zqFTq0NG+bw
 K/ldyL3Myb7pvQAjo04gOLzC43pgVZFd6z3OLvPusXcAdMAlaWnL0WV9BbY0i5X45DG+nQJAl8u
 b
X-Gm-Gg: ASbGncsts8dPZQz4bOv+UfM95IfBpQcQDxUdpxjA6w9vdENImcuDfHYV3KdTPJk4kKi
 WOWOu7bfS9eMNL9hZk8Ftbi9fJKuDRo6KkeF+KmpqqZmhBV8g7k7KdrG0VZ47xfPqG/3lia2uHW
 wcvhgqSenclqSgcPjxu0Q6Je8JblHm15xHp5gRg/LyZCI8HbgbAD7mYN8f0PMGt8z4Obhar7fpH
 u4f9CKkvq+C1n5x/fAJPhRFgij7pUDpof5GvqUHubt50FNIvgy9PZlhmW7yEE0PKvBuscF2qGnu
 c6L31nD4dW6yMlqhi2BHu9b1m8PuUBHjRTi/vVEDPIxLPJEAWoZU/xo2EbLgqzFAKu4i3Nm6GGz
 j+PhYVFVuejmxVj+QJdFJ
X-Google-Smtp-Source: AGHT+IHjGjeBqjNAq6PNN4oCiKrT5+5OSGxPt522b4owTCifWomyBNilED9wtBuJMBbin7nIGyHefw==
X-Received: by 2002:a05:600d:1a:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-441c4a6741amr89979685e9.19.1746542376513; 
 Tue, 06 May 2025 07:39:36 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441bc83d471sm148773255e9.26.2025.05.06.07.39.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Date: Tue,  6 May 2025 16:38:52 +0200
Message-ID: <20250506143905.4961-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
via the 'extra_mac_registers=off' property. We removed all
machines using that array, lets remove all the code around
E1000_FLAG_MAC, including the MAC_ACCESS_FLAG_NEEDED enum,
similarly to commit fa4ec9ffda7 ("e1000: remove old
compatibility code").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/e1000.c | 72 ++++++++++----------------------------------------
 1 file changed, 14 insertions(+), 58 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index cba4999e6d0..e0310aef872 100644
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
 
@@ -1210,54 +1208,24 @@ static const writeops macreg_writeops[] = {
 
 enum { NWRITEOPS = ARRAY_SIZE(macreg_writeops) };
 
-enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
+enum { MAC_ACCESS_PARTIAL = 1 };
 
-#define markflag(x)    ((E1000_FLAG_##x << 2) | MAC_ACCESS_FLAG_NEEDED)
 /* In the array below the meaning of the bits is: [f|f|f|f|f|f|n|p]
  * f - flag bits (up to 6 possible flags)
  * n - flag needed
  * p - partially implenented */
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
-
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
+    [TDFH]  = MAC_ACCESS_PARTIAL,
+    [TDFT]  = MAC_ACCESS_PARTIAL,
+    [TDFHS] = MAC_ACCESS_PARTIAL,
+    [TDFTS] = MAC_ACCESS_PARTIAL,
+    [TDFPC] = MAC_ACCESS_PARTIAL,
+    [RDFH]  = MAC_ACCESS_PARTIAL,
+    [RDFT]  = MAC_ACCESS_PARTIAL,
+    [RDFHS] = MAC_ACCESS_PARTIAL,
+    [RDFTS] = MAC_ACCESS_PARTIAL,
+    [RDFPC] = MAC_ACCESS_PARTIAL,
+    [PBM]   = MAC_ACCESS_PARTIAL,
 };
 
 static void
@@ -1268,8 +1236,7 @@ e1000_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     unsigned int index = (addr & 0x1ffff) >> 2;
 
     if (index < NWRITEOPS && macreg_writeops[index]) {
-        if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
-            || (s->compat_flags & (mac_reg_access[index] >> 2))) {
+        if (s->compat_flags & (mac_reg_access[index] >> 2)) {
             if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
                 DBGOUT(GENERAL, "Writing to register at offset: 0x%08x. "
                        "It is not fully implemented.\n", index<<2);
@@ -1295,8 +1262,7 @@ e1000_mmio_read(void *opaque, hwaddr addr, unsigned size)
     unsigned int index = (addr & 0x1ffff) >> 2;
 
     if (index < NREADOPS && macreg_readops[index]) {
-        if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
-            || (s->compat_flags & (mac_reg_access[index] >> 2))) {
+        if (s->compat_flags & (mac_reg_access[index] >> 2)) {
             if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
                 DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
                        "It is not fully implemented.\n", index<<2);
@@ -1419,13 +1385,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
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
@@ -1451,7 +1410,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     .name = "e1000/full_mac_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = e1000_full_mac_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
         VMSTATE_END_OF_LIST()
@@ -1679,8 +1637,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 
 static const Property e1000_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000State, conf),
-    DEFINE_PROP_BIT("extra_mac_registers", E1000State,
-                    compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
                     compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_BIT("init-vet", E1000State,
-- 
2.47.1


