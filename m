Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F11CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrjZ-0002Kf-3E; Wed, 30 Sep 2026 06:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriu-0001Vs-MY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrik-0006oB-1F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9jPAZtj93wiN5C2wgp74shlqO9mkABvG90fJJsiNAs=;
 b=P9NujrLFmeuMVw+iWiprjzquxgE5lk4kaamRAwdBmbfBNlyGR4XHFF00zLsdpDfpFCT3fT
 WSccWDq0Z1XdrscJREG81diwXg+pVfiImaq6nBaUoFhGjyZYR5A0dLU0gs1cWWa4hghRMn
 lBxWzzHXiYURVMUFIy69aeHCKHtWMiw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-pQUo706aM_qMFMRBHA45cQ-1; Wed,
 30 Sep 2026 06:39:25 -0400
X-MC-Unique: pQUo706aM_qMFMRBHA45cQ-1
X-Mimecast-MFC-AGG-ID: pQUo706aM_qMFMRBHA45cQ_1790764765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC80A180A9FB; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A165C30001BE; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 83BB121E66AC; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 058/105] qapi: convert simple event intros for migration.json
Date: Wed, 30 Sep 2026 12:38:23 +0200
Message-ID: <20260930103910.3934848-59-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260903200008.729791-4-jsnow@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 1d4cdba5a0..8c12d47121 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1721,11 +1721,10 @@
 
 ##
 # @UNPLUG_PRIMARY:
-#
-# Emitted from source side of a migration when migration state is
-# WAIT_UNPLUG.  Device was unplugged by guest operating system.
-# Device resources in QEMU are kept on standby to be able to re-plug
-# it in case of migration failure.
+#     Emitted from source side of a migration when migration state is
+#     WAIT_UNPLUG.  Device was unplugged by guest operating system.
+#     Device resources in QEMU are kept on standby to be able to
+#     re-plug it in case of migration failure.
 #
 # @device-id: QEMU device id of the unplugged device
 #
-- 
2.55.0


