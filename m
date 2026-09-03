Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE53DC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Dby-0002KJ-1d; Thu, 03 Sep 2026 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2Dbw-0002Ji-Cv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2Dbv-0002Qu-1m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788465634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbFahMDvUA7+IOr+q1H2ezE/gcioYDrVsvOD/4q0LBI=;
 b=QQWkdImZn1heNKLXfopBKywiddZThuAoKvT/23bCG+LE2qXxWopabGmGizKk9gCMtuS6ZT
 Sk4Rq43a/xrngOL5nX6g3eSt1S1ZTPRGahW90Dy84f0waHgjWsYsDykUonIju0hklJHrCC
 EKHUcvZ2/Ukgq/VpMgwkC7OKkxT3Gfk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622--kx5DQ23NvGxV-6FfaowKg-1; Thu,
 03 Sep 2026 16:00:30 -0400
X-MC-Unique: -kx5DQ23NvGxV-6FfaowKg-1
X-Mimecast-MFC-AGG-ID: -kx5DQ23NvGxV-6FfaowKg_1788465629
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C70A8192DD56; Thu,  3 Sep 2026 20:00:28 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.104])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B2F41955F7C; Thu,  3 Sep 2026 20:00:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 4/5] qapi: convert simple event intros for machine.json
Date: Thu,  3 Sep 2026 16:00:07 -0400
Message-ID: <20260903200008.729791-5-jsnow@redhat.com>
In-Reply-To: <20260903200008.729791-1-jsnow@redhat.com>
References: <20260903200008.729791-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 qapi/machine.json | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 9d709cb53e0..cf905afd4f1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1125,10 +1125,9 @@
 
 ##
 # @BALLOON_CHANGE:
-#
-# Emitted when the guest changes the actual BALLOON level.  This value
-# is equivalent to the @actual field return by the `query-balloon`
-# command
+#     Emitted when the guest changes the actual BALLOON level.  This
+#     value is equivalent to the @actual field return by the
+#     `query-balloon` command
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
@@ -1556,10 +1555,9 @@
 
 ##
 # @MEMORY_DEVICE_SIZE_CHANGE:
-#
-# Emitted when the size of a memory device changes.  Only emitted for
-# memory devices that can actually change the size (e.g., virtio-mem
-# due to guest action).
+#     Emitted when the size of a memory device changes.  Only emitted
+#     for memory devices that can actually change the size (e.g.,
+#     virtio-mem due to guest action).
 #
 # @id: device's ID
 #
-- 
2.55.0


