Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E4AC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ldu-00018V-Vv; Tue, 29 Apr 2025 10:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldt-00011g-Kw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldr-0006JU-9r
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so42268365e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935737; x=1746540537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7M6Tutx3exMAOrtlWY2rOEtIIwc+eHcrkvSbvRNBy0=;
 b=KykhTJl4Xws9JBBG3bXZJk1mi0PGCMGBmyA/uNraDXH+B5TLulq+XEWv1W43Usr5V7
 q1eCfPhTZqFeykIi1jtpNP/bNNBJi6q2/bWFL9Q60v6GPfR2rTlgSq7VnoMaWi87pw6R
 Epe9sRDPS6h4qAEvFYXmLToolL3IoAYd4kTSdKM26AObU7syEaLAwjrEm4vrDepYvuSn
 749kNRhU/9U/JY1WivZiTo4WBNIxCct/TZTSv/Dq0mR6ixYXxhB2O0dIidHhmAuo6oaX
 tTYrrtb89sk7+YMk6m2gNCF3mpPaqkjMHBHkLKQAj3WCl1cA8jm5P/nKECYKTE+5B9u8
 Yhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935737; x=1746540537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7M6Tutx3exMAOrtlWY2rOEtIIwc+eHcrkvSbvRNBy0=;
 b=WUDP1ZhnC1edzWAEhm5faCSndLUsV65jW5HCifBSoWWtbsHLAUPPqoEYAHkmM+DX5s
 2cuPFVw2yb+BcFPF6FG3WR8UF6J/N1Ke/4f7jYWZdBBfcIlhqwq9m0UjtXFW8FPxItre
 dthYFdeHOqHJFdWu2KEoIbNk1nsyklt8u5Nf2mNRRy8MzN305i08Ei5tzam2ogaCpnv4
 S9yj0IiZM2bdSIZacgFQzz3rGqDxVGMFOz5nRm90GPuycyBu7Nhk9igP1ZfKk9hxLEB+
 wNHwqlZ2jMBkI6oKGr+++HEjb3FAyDa00Wohb/gY10FlL0xUJNyr4w6mlH3F+Rd4PPs8
 L9/w==
X-Gm-Message-State: AOJu0Yy+nV0+TfB+DOI5APQwdaYoOLEOImEDZPSWp3j/498cg711q6Dg
 nkxMuNi24w3pQtGK5qWCn5WIc0eJDL0tw6s8deJ1gbWaIP12x4WcnZAWb6TjeNRsK1bxRCiBxOs
 R
X-Gm-Gg: ASbGncsYsZmqP+GV7RiJBqEBVLpZrl5cAvlRi8ePd0ujFXBfa2dYNFYhXTBC9vPMzez
 FkzR1k2ysqrQi36fdcdc6x4tCfSpg810Dcki4Rmv/t2f7VFuZoFgDLskVaUKAt9Zea8T6dMT8A1
 1ZAkrqJiuZ0AwZs6z0dcj5C3l6Idrfs0+sqEti67uiQqyu8PdJhKG6JKMPXq8YbGOD7fwvLKm1j
 lXwfbDC+YVczSBaJMMIgXtNubZJxZtGXfTCAyWEouU+sqa9rvtB3C0U31+jqYajjnBhJ/AGOb6i
 Cjd+bAEpkvu5JA48ALT16Ki3kqPdXUE43ASjtIu+HABU2Gbdd7/uLOsY32qqe3kMQLXOYeisDFP
 lEkNzYxkfDnXEK7jKv8Cw
X-Google-Smtp-Source: AGHT+IFBdvLXaSfzgUODTJlwELKJq3jC658a3PXh4+8SDRkVU7raGgrxMfB7xaEKlZLs4jYTsI4TQw==
X-Received: by 2002:a05:600c:3ca5:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-441ac918133mr25754115e9.25.1745935737168; 
 Tue, 29 Apr 2025 07:08:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac26dsm191298615e9.21.2025.04.29.07.08.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Date: Tue, 29 Apr 2025 16:08:12 +0200
Message-ID: <20250429140825.25964-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


