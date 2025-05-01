Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254C1C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcvM-0000Sz-Hv; Thu, 01 May 2025 19:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvH-0000LC-Pb
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:33 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvF-0002M7-Lg
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:31 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d5e68418b5so13896405ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140547; x=1746745347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKlAvP/b7bRS8YoXdECBwma4F9omGf4fESvbK1cfcEc=;
 b=P7r0+NFBdixDD9pJAWHbaEE7RkA5/vScdf4hTS3Vxm8bIpUeAIx1Dks6KTYejWmXwJ
 7UkfS4SX9hdSBzEWb9ucddbFbP3UUoqBfXvDHdqLtWWqet2OdsIlRa0yLOxJUZWKW6o/
 eC4c0+J+kSF/wnHnI09bsyC/DvYWCT1opLM3KbuIOprka6e1bWH9ciFiJ+QxE1ndiP4C
 Z3Gcb1c4LIPA3TVZFTompAC6rZhgu9xoP0nRP09BizHOH8aHy47rgEAjF3D3npYE0gKh
 FELKA0f9O53TWit5dd2rPob/ceomgaywGszGwD5XdjAPB1lhvFdgZ9RJNI+j5m/9u8CP
 XjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140547; x=1746745347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKlAvP/b7bRS8YoXdECBwma4F9omGf4fESvbK1cfcEc=;
 b=kXA2odY0h743erM4YpIBSDRaMHzAC7AbNcPemMqz+bZD644+JMql4BAGlXKRu4GqMB
 8bQ65BsMC8lisEd+Dh2rCwYqFVEp7aGiwjCi0Jzlck3JGN1Re6ZszFazTpw6F93r5tc5
 IH3SeVB12Y2n0USm/dQgqFaKMwLp39l/ORkua5UxWrIfCyZ0Ut4MZE9WosrcIuR20tuw
 f6PMmVyzxUZY94RmZcSiZDvrTSZ6TwYTY1T26pOpNFFQ3NYF+kvfsGFdJmuOMqwykdSr
 yCkLUnbEJNQh2iT1RQby+VASiFKxmKquS8NIjnTRV7qwBY2HQU2va8wdqmsJnHAwfISA
 v6KA==
X-Gm-Message-State: AOJu0YzVObudXZmcgGlz4ffwh5mJZuV0XML688mD5D2v2AAUVgcIZcqT
 fOKy8XAsLeIHRuSTDVWeZIVrWMNRsYxmO3tbIXOgRCtOxRuuMjZf8k7hUMj5QGNHeWiMLJVALEa
 J
X-Gm-Gg: ASbGnctUXEN81jKEh00zj74hoFkDqfEnxw1zfxWPMoXCdsEQ3ZAdE42WppnbrB+qiDg
 3YL9k2iy6mgIWlr0bQaWlU33JwTIlfTgrynO7aujTlsE8A0YXphr1n3HdoolIlRfn2D1k8w5GiH
 Rkp1v5OnVxTcoYgMAyyOf9/wm5ZSFJqXDGCX8M+HyUd/defOoOxVMMsb1rV4J8dN/3DT2Cq/1FK
 5dOL0e+Ub7NbXSAQOiuR2A+fS3AX76YFZE4YOo/leTm4qgktxA8wNF8HqIVk5BE8oAUTofsbGTB
 rY1ztEio6yOY15uHFNHuRr4KDrqohVsssRPad9ize7d2VP+gFe4PAT+tqnxiOMUltieEo4uKUs7
 94Q5O4RNaMMm7XGxWa9YdPzCISmx7bro=
X-Google-Smtp-Source: AGHT+IHInVtaHMoThBEwz78LYSah4LbqdbEsU5tqkSnQzlF3/xydnsJ0rshcltIpx0QIZNoByYG1Aw==
X-Received: by 2002:a05:6e02:168d:b0:3d3:f6ee:cc4c with SMTP id
 e9e14a558f8ab-3d97be919c5mr8853545ab.0.1746140547164; 
 Thu, 01 May 2025 16:02:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a8d0e77sm91354173.24.2025.05.01.16.02.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:02:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 06/10] hw/net/e1000: Remove unused E1000_FLAG_TSO flag
Date: Fri,  2 May 2025 01:01:24 +0200
Message-ID: <20250501230129.2596-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501230129.2596-1-philmd@linaro.org>
References: <20250501230129.2596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-il1-x129.google.com
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

E1000_FLAG_TSO was only used by the hw_compat_2_11[] array,
via the 'migrate_tso_props=off' property. We removed all
machines using that array, lets remove all the code around
E1000_FLAG_TSO, including the vmstate_e1000_tx_tso_state
subsection.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Is it OK to remove migration subsection like that?
---
 hw/net/e1000.c | 58 +++++++-------------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index e0310aef872..c68645684b6 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -127,13 +127,10 @@ struct E1000State_st {
     QEMUTimer *flush_queue_timer;
 
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
-#define E1000_FLAG_TSO_BIT 3
 #define E1000_FLAG_VET_BIT 4
-#define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
 #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
 
     uint32_t compat_flags;
-    bool received_tx_tso;
     bool use_tso_for_migration;
     e1000x_txd_props mig_props;
 };
@@ -1331,7 +1328,7 @@ static int e1000_pre_save(void *opaque)
     }
 
     /* Decide which set of props to migrate in the main structure */
-    if (chkflag(TSO) || !s->use_tso_for_migration) {
+    if (!s->use_tso_for_migration) {
         /* Either we're migrating with the extra subsection, in which
          * case the mig_props is always 'props' OR
          * we've not got the subsection, but 'props' was the last
@@ -1368,30 +1365,16 @@ static int e1000_post_load(void *opaque, int version_id)
     }
 
     s->tx.props = s->mig_props;
-    if (!s->received_tx_tso) {
-        /* We received only one set of offload data (tx.props)
-         * and haven't got tx.tso_props.  The best we can do
-         * is dupe the data.
-         */
-        s->tx.tso_props = s->mig_props;
-    }
+
+    /* We received only one set of offload data (tx.props)
+     * and haven't got tx.tso_props.  The best we can do
+     * is dupe the data.
+     */
+    s->tx.tso_props = s->mig_props;
+
     return 0;
 }
 
-static int e1000_tx_tso_post_load(void *opaque, int version_id)
-{
-    E1000State *s = opaque;
-    s->received_tx_tso = true;
-    return 0;
-}
-
-static bool e1000_tso_state_needed(void *opaque)
-{
-    E1000State *s = opaque;
-
-    return chkflag(TSO);
-}
-
 static const VMStateDescription vmstate_e1000_mit_state = {
     .name = "e1000/mit_state",
     .version_id = 1,
@@ -1416,28 +1399,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     }
 };
 
-static const VMStateDescription vmstate_e1000_tx_tso_state = {
-    .name = "e1000/tx_tso_state",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = e1000_tso_state_needed,
-    .post_load = e1000_tx_tso_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
-        VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
-        VMSTATE_UINT16(tx.tso_props.ipcse, E1000State),
-        VMSTATE_UINT8(tx.tso_props.tucss, E1000State),
-        VMSTATE_UINT8(tx.tso_props.tucso, E1000State),
-        VMSTATE_UINT16(tx.tso_props.tucse, E1000State),
-        VMSTATE_UINT32(tx.tso_props.paylen, E1000State),
-        VMSTATE_UINT8(tx.tso_props.hdr_len, E1000State),
-        VMSTATE_UINT16(tx.tso_props.mss, E1000State),
-        VMSTATE_INT8(tx.tso_props.ip, E1000State),
-        VMSTATE_INT8(tx.tso_props.tcp, E1000State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_e1000 = {
     .name = "e1000",
     .version_id = 2,
@@ -1519,7 +1480,6 @@ static const VMStateDescription vmstate_e1000 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_e1000_mit_state,
         &vmstate_e1000_full_mac_state,
-        &vmstate_e1000_tx_tso_state,
         NULL
     }
 };
@@ -1637,8 +1597,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 
 static const Property e1000_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000State, conf),
-    DEFINE_PROP_BIT("migrate_tso_props", E1000State,
-                    compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_BIT("init-vet", E1000State,
                     compat_flags, E1000_FLAG_VET_BIT, true),
 };
-- 
2.47.1


