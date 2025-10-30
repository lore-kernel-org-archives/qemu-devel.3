Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BCCCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7b-00032Q-NE; Thu, 30 Oct 2025 03:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7N-0002rv-6j; Thu, 30 Oct 2025 03:30:49 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7G-00054r-GU; Thu, 30 Oct 2025 03:30:43 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 1C0C0EC01C4;
 Thu, 30 Oct 2025 03:30:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 30 Oct 2025 03:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761809430; x=
 1761895830; bh=UbSHMYHQEqILcxNEHTUCvzZwo6tZO6GTUL3a7ABniGE=; b=x
 diAl9Xb0K7LGZLDArKK0OoeiGy48Bs3Kkg/x3zUCxakQmo9/Pd0TFozNNyL1zqNL
 5LwC4QSBCjRn/ZqzMOjHKDan6wg+kcvQQ5d37Zr8oWMQkSCJcl0lGhyr9PkZZw0x
 oToYX9tnjunng/DolOZKHn0LjHqSqiuPrya4EP9fg2CcTCj6tuKe3Jh8Z/y7V5+v
 nd1AypvDpI9MSe4m7CHaBA1KUBuJ2ABFYiSv/QPML7HnypUGxX/r+sn1gCoBXHh2
 fD+S5T+yCMV5d6zIAygkWfUVXj1tC2lghnVFR1tH7FIFxpLxCT9zn+BpnP6rAScr
 3frAdQcyWtj/B6wn47Pcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761809430; x=1761895830; bh=U
 bSHMYHQEqILcxNEHTUCvzZwo6tZO6GTUL3a7ABniGE=; b=hlRCifjRezoQsy3uJ
 aJdQu24Pp3EJMtRdPBIGzybnvzkpP9xl5636z/RcnPrKsaf1S0BaJDdSiCWImcMe
 hNODjvBRsAypJWT4Q1BaVghuHDtXF4Crl1Y6WyZMMGja6jGrIHKVu+oatMew2WF5
 tw33UtxUUWyH4ilT088FrAPC5HRyacaIZZOynxT3DJ4f/rbU0BeOs51eJzZohIhh
 vfe5k+7wP2w4wB7HsvJBauQFDSWrXsmIYKF1B9IzNmJkMAjiTgDyrqpNiK4u8Xmm
 7AKR/8l6f0S/iwXHBxpxFAVW4ikDDO2k0jJAGU0sQcRoIgV9YJ7hTfuEX2XeMndF
 yzOjA==
X-ME-Sender: <xms:FRQDaRNsPGBz8itziw1Pro3F-5LGDqGajGx825dPpV2L6-isbyWToA>
 <xme:FRQDaeB1pLDmJIXXzvxhNEVLnLB2M2vvUoCKHEEry99KuxzrUaxIfOeUylUczxosI
 0IOfJ0LWmY6YC18V2OI_BfxFVEfFA8lx6b03RAclP7JuZEB925l0Ps>
X-ME-Received: <xmr:FRQDaQLMR1aZXQGZJSaaDJk2xpQ7OjQZ8AYRLVWVe6-wpjsgzwB6LOurDXPGwaqgbXClaB7dNG2ZgGOQpuiXqGYsJ3vA6BmbzYFAR9wtzGvjTL52iX0u6nRJghd2Xv4zQlalC7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopegrlhgrnhdrrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepfh
 hoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghm
 shhunhhgrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprh
 gtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhu
 qdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:FRQDafOjHJqzne6Urvd4evOyq4Ve1mzpp4eZBWiAXNoINEGtfQCVFA>
 <xmx:FRQDaW7eDsvS1wpC3RsxsC2Ud4f2bI7ghINsW07hbMaTQa72hQwVsQ>
 <xmx:FRQDaZ6mfLdc50IENsVHcD2s1eG_2biokTRYObO8bAxR8_v0lFX3JA>
 <xmx:FRQDacFzq-ObU_Hj-AQ6GErJ_afaJ2YfA7krgNUxowpbEYtsR3_pLA>
 <xmx:FhQDacaEWoN3DvUPhNwqOIcHuPPkSdGy6Gu-zOmXPZPuqFA589rdoFoL>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:28 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alan Adamson <alan.adamson@oracle.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Subject: [PULL 6/7] hw/nvme: enable ns atomic writes
Date: Thu, 30 Oct 2025 08:29:54 +0100
Message-ID: <20251030072956.1194-7-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030072956.1194-1-its@irrelevant.dk>
References: <20251030072956.1194-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Alan Adamson <alan.adamson@oracle.com>

Add support for the namespace atomic paramters: NAWUN and NAWUN. Namespace
Atomic Compare and Write Unit (NACWU) is not currently supported.

Writes that adhere to the NACWU and NAWUPF parameters are guaranteed to be
atomic.

New NVMe QEMU Paramters (See NVMe Specification for details):
        atomic.nawun=UINT16 (default: 0)
        atomic.nawupf=UINT16 (default: 0)
        atomic.nsfeat (default off) - Set Namespace Supported Atomic Boundary &
                Power (NSABP) bit in Namespace Features (NSFEAT) in the Identify
                Namespace Data Structure

See the NVMe Specification for more information.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 23 +++++++++++++++++++++++
 hw/nvme/ns.c   | 38 ++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h |  6 ++++++
 3 files changed, 67 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fa003031e719..121a95b2e373 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6705,6 +6705,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         } else {
             atomic->atomic_writes = 1;
         }
+        for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+            ns = nvme_ns(n, i);
+            if (ns && ns->atomic.atomic_writes) {
+                if (n->dn) {
+                    ns->atomic.atomic_max_write_size =
+                        le16_to_cpu(ns->id_ns.nawupf) + 1;
+                } else {
+                    ns->atomic.atomic_max_write_size =
+                        le16_to_cpu(ns->id_ns.nawun) + 1;
+                }
+                if (ns->atomic.atomic_max_write_size == 1) {
+                    ns->atomic.atomic_writes = 0;
+                } else {
+                    ns->atomic.atomic_writes = 1;
+                }
+            }
+        }
         break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
@@ -7688,6 +7705,12 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
 
 static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
 {
+    NvmeNamespace *ns = nvme_ns(n, cmd->nsid);
+
+    if (ns && ns->atomic.atomic_writes) {
+        return &ns->atomic;
+    }
+
     if (n->atomic.atomic_writes) {
         return &n->atomic;
     }
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 6df2e8e7c5ac..28aacb8db59a 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -724,11 +724,46 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     BusState *s = qdev_get_parent_bus(dev);
     NvmeCtrl *n = NVME(s->parent);
     NvmeSubsystem *subsys = n->subsys;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeIdNs *id_ns = &ns->id_ns;
     uint32_t nsid = ns->params.nsid;
     int i;
 
     assert(subsys);
 
+    /* Set atomic write parameters */
+    if (ns->params.atomic_nsfeat) {
+        id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABPNS;
+        id_ns->nawun = cpu_to_le16(ns->params.atomic_nawun);
+        if (!id->awupf || (id_ns->nawun && (id_ns->nawun < id->awun))) {
+            error_report("Invalid NAWUN: %x AWUN=%x", id_ns->nawun, id->awun);
+        }
+        id_ns->nawupf = cpu_to_le16(ns->params.atomic_nawupf);
+        if (!id->awupf || (id_ns->nawupf && (id_ns->nawupf < id->awupf))) {
+            error_report("Invalid NAWUPF: %x AWUPF=%x",
+                id_ns->nawupf, id->awupf);
+        }
+        if (id_ns->nawupf > id_ns->nawun) {
+            error_report("Invalid: NAWUN=%x NAWUPF=%x",
+                id_ns->nawun, id_ns->nawupf);
+        }
+    }
+
+    if (id_ns->nawun || id_ns->nawupf) {
+        NvmeAtomic *atomic = &ns->atomic;
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawupf) + 1;
+        } else {
+            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawun) + 1;
+        }
+        if (atomic->atomic_max_write_size == 1) {
+            atomic->atomic_writes = 0;
+        } else {
+            atomic->atomic_writes = 1;
+        }
+    }
+
     /* reparent to subsystem bus */
     if (!qdev_set_parent_bus(dev, &subsys->bus.parent_bus, errp)) {
         return;
@@ -804,6 +839,9 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_BOOL("eui64-default", NvmeNamespace, params.eui64_default,
                      false),
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
+    DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic_nawun, 0),
+    DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic_nawupf, 0),
+    DEFINE_PROP_BOOL("atomic.nsfeat", NvmeNamespace, params.atomic_nsfeat, 0),
 };
 
 static void nvme_ns_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 67ed562e0086..7d01080fc1f9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -218,6 +218,9 @@ typedef struct NvmeNamespaceParams {
     struct {
         char *ruhs;
     } fdp;
+    uint16_t atomic_nawun;
+    uint16_t atomic_nawupf;
+    bool     atomic_nsfeat;
 } NvmeNamespaceParams;
 
 typedef struct NvmeAtomic {
@@ -280,6 +283,9 @@ typedef struct NvmeNamespace {
         /* reclaim unit handle identifiers indexed by placement handle */
         uint16_t *phs;
     } fdp;
+    uint16_t  atomic_nawun;
+    uint16_t  atomic_nawupf;
+    NvmeAtomic  atomic;
 } NvmeNamespace;
 
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
-- 
2.51.0


