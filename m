Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DA606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2kAJSKT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjR-0000ss-7D; Mon, 26 Oct 2026 06:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHif-00006T-Om; Mon, 26 Oct 2026 06:14:27 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHic-0001Yz-0N; Mon, 26 Oct 2026 06:14:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6574340F2E;
 Mon, 26 Oct 2026 10:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842B31F01828;
 Mon, 26 Oct 2026 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009655;
 bh=Rlz6sg2epMlNWbEykes8mVRO1HyWEVjutqVapdsf0qU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=n2kAJSKT36KiXk9ZR5FBY+VLYDAk/J1//3uBDWKNIRxRnCl/4ZGDKeeisBbmI8hOh
 o9kIeZ/0e1Ti4Rm1yWuctaNEKrJVtUhQv7WjD4je6h3q2g3hBFDdJadRIvl26Opto8
 e7/DTzygDAuaO+MK+5jP+xLnTOXh75hQg0ScI+0x0hGxzMjCrxl2iVZNgCmGvaJE1C
 11Zs/fthq6LzFrcIPJQ2Sgae3wGeO9jC/ksnRZ2QwDcHvj34jyRFMT61HxKgk06Vro
 cMPsrB5IuNzbz/Hy1tC2iaFbNfxiooSR4llPbHb5/oVHUahjI7g3ujZg1AazPpO+hj
 HZpHz2wMIlnxA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:13:59 +0100
Subject: [PATCH RESEND 4/5] hw/nvme: add multiple atomicity mode support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-nvme-mam-v1-4-5d53b5529ffa@samsung.com>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
In-Reply-To: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009644; l=5312;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=h/ImcKoqql35lEHU5Ym3ikhk3FjEt45HaFcrFsMz+4E=;
 b=oNDkdEphFo0t8v4rV+bgDgcw52e4dzB8nqfwd3PvxAmcqikpJ+6/G8VfpBcC+WUkKawn7tO/e
 KIlrUeD5YrwBuUJ5pcjP+ut5bFLSdp2haC3UCH8qtgMj8C1z8xET1N5
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Gomez <da.gomez@samsung.com>

NVMe spec defines Multiple Atomicity Mode (MAM) as a superset of Single
Atomicity Mode (SAM) where the controller works in either mode. In this
mode, a write command that crosses the Namespace Atomic Boundaries is
divided at those boundaries into atomic LBA subranges, each written
atomically, although the full command is not atomic as a whole.

Add an "atomic.mam" nvme-ns boolean that sets the existing
NVME_ID_NS_NSFEAT_MAM bit once the configured geometry satisfies the
mode's requirements: NSABP, with a nonzero NABSN/NABSPF and ==
NAWUN/NAWUPF.

This lets a guest use the atomic-write/MAM path with the following
emulated NVMe option atomic.mam=on, e.g.:

  -device nvme,serial=foo,id=nvme0\
  -drive file=nvme0.qcow2,if=none,format=qcow2,id=nvme0-ns0\
  -device nvme-ns,drive=nvme0-ns0,bus=nvme0,atomic.nawun=7,\
  atomic.nawupf=7,atomic.nabsn=7,atomic.nabspf=7,atomic.mam=on

Note that for MAM emulation, the atomic boundaries limits are skipped and
the whole command is serialized as one atomic write.

Also, fix a typo in the error message reported when nabspf and nawupf
are checked when setting the Namespace Atomic Boundaries.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c |  7 +++++--
 hw/nvme/ns.c   | 27 ++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  1 +
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 3baf57af634..c912a4df8da 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -56,6 +56,7 @@
  *              zoned.max_active=<N[optional]>, \
  *              zoned.max_open=<N[optional]>, \
  *              zoned.cross_read=<true|false[optional]>, \
+ *              atomic.mam=<on|off[optional]>, \
  *              atomic.nabo=<N[optional]>, \
  *              atomic.nabsn=<N[optional]>, \
  *              atomic.nabspf=<N[optional]>, \
@@ -7830,6 +7831,8 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeAtomic *atomic)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    NvmeNamespace *ns = nvme_ns(n, le32_to_cpu(cmd->nsid));
+    bool mam = ns && (ns->id_ns.nsfeat & NVME_ID_NS_NSFEAT_MAM);
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
     uint64_t elba = slba + nlb;
@@ -7837,14 +7840,14 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
     int i;
 
     if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
-        ((nlb + 1) > atomic->atomic_max_write_size))) {
+        !mam && ((nlb + 1) > atomic->atomic_max_write_size))) {
         cmd_atomic_wr = false;
     }
 
     /*
      * Check if a write crosses an atomic boundary.
      */
-    if (cmd->opcode == NVME_CMD_WRITE) {
+    if (cmd->opcode == NVME_CMD_WRITE && !mam) {
         if (!nvme_atomic_boundary_check(n, cmd, atomic)) {
             cmd_atomic_wr = false;
         }
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 7f0f9ac7662..344c16d1aa0 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -769,7 +769,7 @@ static bool nvme_ns_set_nab(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         }
 
         if (nabspf && nabspf < le16_to_cpu(id_ns->nawupf)) {
-            error_setg(errp, "nabspf must be great than or equal to nawupf");
+            error_setg(errp, "nabspf must be greater than or equal to nawupf");
             return false;
         }
     }
@@ -787,6 +787,30 @@ static bool nvme_ns_set_nab(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     nvme_ns_atomic_configure_boundary(n->dn, nabsn, nabspf, &ns->atomic);
 
+    if (ns->params.atomic.mam) {
+        uint16_t nawupf = le16_to_cpu(id_ns->nawupf);
+        uint16_t nawun = le16_to_cpu(id_ns->nawun);
+
+        if (!(id_ns->nsfeat & NVME_ID_NS_NSFEAT_NSABP)) {
+            error_setg(errp, "atomic.mam requires per-namespace atomic writes");
+            return false;
+        }
+
+        if (!nabsn || !nabspf) {
+            error_setg(errp, "atomic.mam requires a nonzero atomic.nabsn and "
+                             "atomic.nabspf");
+            return false;
+        }
+
+        if (nabsn != nawun || nabspf != nawupf || nawun != nawupf) {
+            error_setg(errp, "atomic.mam requires atomic.nabsn == atomic.nawun "
+                             "== atomic.nabspf == atomic.nawupf");
+            return false;
+        }
+
+        id_ns->nsfeat |= NVME_ID_NS_NSFEAT_MAM;
+    }
+
     return true;
 }
 
@@ -1096,6 +1120,7 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic.nabsn, 0),
     DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic.nabspf, 0),
     DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic.nabo, 0),
+    DEFINE_PROP_BOOL("atomic.mam", NvmeNamespace, params.atomic.mam, 0),
 };
 
 static void nvme_ns_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 43e3c916f73..edc84f347b3 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -232,6 +232,7 @@ typedef struct NvmeNamespaceParams {
         uint16_t nabsn;
         uint16_t nabspf;
         uint16_t nabo;
+        bool mam;
     } atomic;
 } NvmeNamespaceParams;
 

-- 
2.56.0


