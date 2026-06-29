Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D1FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJfK-0006zB-HV; Mon, 29 Jun 2026 17:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfF-0006qM-L8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfE-0003x1-B0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyL4wLpNPIdGgRq99LX/VYY5Y/7woL6ls4ZoMSA+Bys=;
 b=gRxJQUdLeNpzjoVJUBL0IpgqqWlUyIfjGE8dpYdms52iOWNaDlMWgi4EKTWkm0YADYaYhn
 87JmehnWsEDRsZw/1ftiCth0opfFu1d7i7oww6Wb90jq8C5aG8HUANMNvR/71DW5p+ivYi
 FFlpsgU95SJPAYI7pJbyGGDtEKDc4tY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-RWFV-w0GNnOTiR_k5jF65w-1; Mon,
 29 Jun 2026 17:37:08 -0400
X-MC-Unique: RWFV-w0GNnOTiR_k5jF65w-1
X-Mimecast-MFC-AGG-ID: RWFV-w0GNnOTiR_k5jF65w_1782769026
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 307D719344BA; Mon, 29 Jun 2026 21:37:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B89D01956096; Mon, 29 Jun 2026 21:37:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 06/14] qapi: convert intro sections for vfio.json
Date: Mon, 29 Jun 2026 17:36:16 -0400
Message-ID: <20260629213624.936258-7-jsnow@redhat.com>
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/vfio.json | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index 17b60468712..47fff8b979d 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -10,14 +10,13 @@
 
 ##
 # @QapiVfioMigrationState:
-#
-# An enumeration of the VFIO device migration states.  In addition to
-# the regular states, there are prepare states (with 'prepare' suffix)
-# which indicate that the device is just about to transition to the
-# corresponding state.  Note that seeing a prepare state for state X
-# doesn't guarantee that the next state will be X, as the state
-# transition can fail and the device may transition to a different
-# state instead.
+#     An enumeration of the VFIO device migration states.  In addition
+#     to the regular states, there are prepare states (with 'prepare'
+#     suffix) which indicate that the device is just about to
+#     transition to the corresponding state.  Note that seeing a
+#     prepare state for state X doesn't guarantee that the next state
+#     will be X, as the state transition can fail and the device may
+#     transition to a different state instead.
 #
 # @stop: The device is stopped.
 #
@@ -49,8 +48,8 @@
 
 ##
 # @VFIO_MIGRATION:
-#
-# This event is emitted when a VFIO device migration state is changed.
+#     This event is emitted when a VFIO device migration state is
+#     changed.
 #
 # @device-id: The device's id, if it has one.
 #
-- 
2.54.0


