Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84827CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrjQ-00026l-UF; Wed, 30 Sep 2026 06:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrit-0001Tg-LU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrij-0006nt-Po
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OugSIjcArmV3R2YKBJiRg+oM7JSqbfPVSAyMCCarkWw=;
 b=P3MWUI8OJhVMWM65AiFTXjamSn4q4IjScDjJUYL+D4/piAuHr2Tc6NImacT4kvPOHQ0krl
 D0tgVw50/1JActW7E+I+avUYcm0LWGGa6N4RQxirPOXeBhM3eh4JFvpH/3H1ReQL5HhsE3
 Gsha257lK3SkRlCZ36Bcr7TyueQhIjI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-NfyFNoqbMyuCw9ILJAuTWw-1; Wed,
 30 Sep 2026 06:39:25 -0400
X-MC-Unique: NfyFNoqbMyuCw9ILJAuTWw-1
X-Mimecast-MFC-AGG-ID: NfyFNoqbMyuCw9ILJAuTWw_1790764764
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C75A919540D8; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 866B6180035F; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B8F121E66BA; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 060/105] qapi: convert simple event intros for block-core.json
Date: Wed, 30 Sep 2026 12:38:25 +0200
Message-ID: <20260930103910.3934848-61-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260903200008.729791-6-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5c6a882a24..b96558d750 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5595,11 +5595,10 @@
 
 ##
 # @BLOCK_IMAGE_CORRUPTED:
-#
-# Emitted when a disk image is being marked corrupt.  The image can be
-# identified by its device or node name.  The 'device' field is always
-# present for compatibility reasons, but it can be empty ("") if the
-# image does not have a device name associated.
+#     Emitted when a disk image is being marked corrupt.  The image
+#     can be identified by its device or node name.  The 'device'
+#     field is always present for compatibility reasons, but it can be
+#     empty ("") if the image does not have a device name associated.
 #
 # @device: device name.  This is always present for compatibility
 #     reasons, but it can be empty ("") if the image does not have a
@@ -5828,11 +5827,10 @@
 
 ##
 # @BLOCK_JOB_PENDING:
-#
-# Emitted when a block job is awaiting explicit authorization to
-# finalize graph changes via `job-finalize`.  If this job is part of a
-# transaction, it will not emit this event until the transaction has
-# converged first.
+#     Emitted when a block job is awaiting explicit authorization to
+#     finalize graph changes via `job-finalize`.  If this job is part
+#     of a transaction, it will not emit this event until the
+#     transaction has converged first.
 #
 # @type: job type
 #
@@ -5873,12 +5871,12 @@
 
 ##
 # @BLOCK_WRITE_THRESHOLD:
-#
-# Emitted when writes on block device reaches or exceeds the
-# configured write threshold.  For thin-provisioned devices, this
-# means the device should be extended to avoid pausing for disk
-# exhaustion.  The event is one shot.  Once triggered, it needs to be
-# re-registered with another `block-set-write-threshold` command.
+#     Emitted when writes on block device reaches or exceeds the
+#     configured write threshold.  For thin-provisioned devices, this
+#     means the device should be extended to avoid pausing for disk
+#     exhaustion.  The event is one shot.  Once triggered, it needs to
+#     be re-registered with another `block-set-write-threshold`
+#     command.
 #
 # @node-name: graph node name on which the threshold was exceeded.
 #
-- 
2.55.0


