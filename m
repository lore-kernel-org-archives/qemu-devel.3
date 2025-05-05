Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA065C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrr0-0004S6-K7; Mon, 05 May 2025 05:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnL-0007i4-1N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnI-0006MW-Sk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsiOM7q8g3d4IdE4tuHhf5VrIKTQ9VH185clY0vz75s=;
 b=Nt70SF8+GoJZlhsdynA6HYQtUgR3IJdwl1e9x2T3SZKDA8v0Z1EcwySrEyXgysAyEN0vSZ
 JsrrJDEtTuQNAPnC7fdA4GxBkaKA7W+WrGl3gWlBIhUObH7cxjl4Bzvs6sZlS+nzx13n/1
 Ig7+FAG2kQ11r3pijkR4htaptr6lDlI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-7vaVNXmjNNCpRVfL7dmQEw-1; Mon,
 05 May 2025 05:07:21 -0400
X-MC-Unique: 7vaVNXmjNNCpRVfL7dmQEw-1
X-Mimecast-MFC-AGG-ID: 7vaVNXmjNNCpRVfL7dmQEw_1746436040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F931956096; Mon,  5 May 2025 09:07:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1677330001A2; Mon,  5 May 2025 09:07:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/23] docs/system/arm/aspeed: Support vbootrom for AST2700
Date: Mon,  5 May 2025 11:06:26 +0200
Message-ID: <20250505090635.778785-15-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Using the vbootrom image support and the boot ROM binary is
now passed via the -bios option, using the image located in
pc-bios/ast27x0_bootrom.bin.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250424075135.3715128-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 08a33b7008b7..014545f4440f 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -306,7 +306,14 @@ Images can be downloaded from the ASPEED Forked OpenBMC GitHub release repositor
 Booting the ast2700-evb machine
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Boot the AST2700 machine from the flash image, use an MTD drive :
+Boot the AST2700 machine from the flash image.
+
+There are two supported methods for booting the AST2700 machine with a flash image:
+
+Manual boot using ``-device loader``:
+
+It causes all 4 CPU cores to start execution from address ``0x430000000``, which
+corresponds to the BL31 image load address.
 
 .. code-block:: bash
 
@@ -326,6 +333,26 @@ Boot the AST2700 machine from the flash image, use an MTD drive :
        -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd \
        -nographic
 
+Boot using a virtual boot ROM (``-bios``):
+
+If users do not specify the ``-bios option``, QEMU will attempt to load the
+default vbootrom image ``ast27x0_bootrom.bin`` from either the current working
+directory or the ``pc-bios`` directory within the QEMU source tree.
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M ast2700-evb \
+      -drive file=image-bmc,format=raw,if=mtd \
+      -nographic
+
+The ``-bios`` option allows users to specify a custom path for the vbootrom
+image to be loaded during boot. This will load the vbootrom image from the
+specified path in the ${HOME} directory.
+
+.. code-block:: bash
+
+  -bios ${HOME}/ast27x0_bootrom.bin
+
 Aspeed minibmc family boards (``ast1030-evb``)
 ==================================================================
 
-- 
2.49.0


