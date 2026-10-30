Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DA606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvaF382A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMq7z-00084l-4b; Fri, 30 Oct 2026 13:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq7x-00084I-Uf; Fri, 30 Oct 2026 13:10:53 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq7w-00049h-6W; Fri, 30 Oct 2026 13:10:53 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9467C60233;
 Fri, 30 Oct 2026 17:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6861F0093A;
 Fri, 30 Oct 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793380250;
 bh=L0u8i04DG/rWZLaQ0bQ7qztHk7Qv92DN7rVVoZS/Vv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hvaF382AxAw/ayyOl486mg7e+oEq7SCCgubipcpbvMfptfOoa21TeMW3AUn8U9esZ
 RhTQcjWhVNkb22/aEFxwPhhzgOw5dSDmtNXaKg3D2ThNJlPpA8Jbc3z5+ZxqIOSUBl
 6rcH1s8MPjCFi38gCfLkG3ESQC2qtfhWFxfgzCRpES1s4NgVR5RfokpArIyiMqNlT4
 XDQ3ESjtsjkFPtqmMZcFfPCij/QxDA3NOiMduPUb72J5ex5j8r1Nx2Q4DGwNtwqmwn
 Bw26bUmrx1ydfcFVhC+TepBpupQG5OaZHdSwE38QwCJuGuhHLFKp00fASUFaipo/q3
 xxRqmv2Pkfv0w==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Sam Li <faithilikerun@gmail.com>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Daejun Park <daejun7.park@samsung.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v16 1/9] docs/qcow2: add the zoned format feature
Date: Fri, 30 Oct 2026 18:10:28 +0100
Message-ID: <20261030171038.702962-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030171038.702962-1-cassel@kernel.org>
References: <20261030171038.702962-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sam Li <faithilikerun@gmail.com>

Add the specs for the zoned format feature of the qcow2 driver.
The qcow2 file then can emulate real zoned devices, either passed
through by virtio-blk device or NVMe ZNS drive to the guest
given zoned information.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes by Niklas Cassel:
- do not document a zone append size limit, which the driver no longer
  stores in the image
---
 docs/system/qemu-block-drivers.rst.inc | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 675daa72f9..70b9b8d1b4 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,50 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zone.mode
+
+    If this is set to ``host-managed``, the image is an emulated zoned
+    block device. This option is only valid for emulated zoned device files.
+
+  .. option:: zone.size
+
+    The size of a zone in bytes. The device is divided into zones of this
+    size with the exception of the last zone, which may be smaller.
+    Defaults to ``256 MiB``.
+
+  .. option:: zone.capacity
+
+    The initial capacity value, in bytes, for all zones. The capacity must
+    be less than or equal to zone size. If the last zone is smaller, then
+    its capacity is capped. Defaults to ``zone.size``.
+
+    The zone capacity is per zone and may be different between zones in real
+    devices. QCow2 sets all zones to the same capacity.
+
+  .. option:: zone.conventional_zones
+
+    The number of conventional zones of the zoned device. Defaults to ``0``
+    (all zones are sequential-write-required).
+
+  .. option:: zone.max_active_zones
+
+    The maximum allowed active zones (zones in the implicit open, explicit
+    open, or closed state).
+
+    The max active zones must be less or equal to the number of SWR
+    (sequential write required) zones of the device. Defaults to ``0``,
+    meaning no limit.
+
+  .. option:: zone.max_open_zones
+
+    The maximum allowed open zones (zones in the implicit open or explicit
+    open state). The max open zones must not be larger than the max active
+    zones. Defaults to ``zone.max_active_zones`` if that is set, otherwise
+    ``0`` (no limit).
+
+    If the limits of open zones or active zones are equal to the number of
+    SWR zones, then it is the same as having no limits.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.56.0


