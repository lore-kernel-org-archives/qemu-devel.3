Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D5CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrl9-0000ex-9j; Wed, 30 Sep 2026 06:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriv-0001WO-D3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrik-0006ob-OZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nm2n8tvLqHHX8Xa2NsRZk5g0CrdkObu5oRMmVzx+g4=;
 b=DBTtjZPB9R4DrYmP5ja3pczQfmcFFzV2Y6K21hSliL14WVw6FEa7gSt1n8ytJ06nQAo4uO
 jx8WLhvRfo1+2ejujB4QNmBlquc2VrikViraBQE0E/e5VLGlTL9ZMbMk67nkvbhL9Ctfcx
 tuHXkJuv1HzVANQQqQub8MaXWdHerq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-0-VJiu4pOEWjQk6F3kEaCQ-1; Wed,
 30 Sep 2026 06:39:28 -0400
X-MC-Unique: 0-VJiu4pOEWjQk6F3kEaCQ-1
X-Mimecast-MFC-AGG-ID: 0-VJiu4pOEWjQk6F3kEaCQ_1790764767
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 810651801337; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C37C76C; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D156121E65F0; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 077/105] qapi: convert simple data struct intros for virtio.json
Date: Wed, 30 Sep 2026 12:38:42 +0200
Message-ID: <20260930103910.3934848-78-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
Message-ID: <20260910203856.99003-8-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/virtio.json | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9aafc3a212..0a4753cc34 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -67,9 +67,8 @@
 
 ##
 # @VhostStatus:
-#
-# Information about a vhost device.  This information will only be
-# displayed if the vhost device is active.
+#     Information about a vhost device.  This information will only be
+#     displayed if the vhost device is active.
 #
 # @n-mem-sections: vhost_dev n_mem_sections
 #
@@ -110,10 +109,9 @@
 
 ##
 # @VirtioStatus:
-#
-# Full status of the virtio device with most VirtIODevice members.
-# Also includes the full status of the corresponding vhost device if
-# the vhost device is active.
+#     Full status of the virtio device with most VirtIODevice members.
+#     Also includes the full status of the corresponding vhost device
+#     if the vhost device is active.
 #
 # @name: VirtIODevice name
 #
@@ -473,9 +471,9 @@
 
 ##
 # @VirtioDeviceFeatures:
-#
-# The common fields that apply to most Virtio devices.  Some devices
-# may not have their own device-specific features (e.g. virtio-rng).
+#     The common fields that apply to most Virtio devices.  Some
+#     devices may not have their own device-specific features
+#     (e.g. virtio-rng).
 #
 # @transports: List of transport features of the virtio device
 #
@@ -754,8 +752,7 @@
 
 ##
 # @VirtioRingAvail:
-#
-# Information regarding the avail vring (a.k.a. driver area)
+#     Information regarding the avail vring (a.k.a. driver area)
 #
 # @flags: VRingAvail flags
 #
@@ -772,8 +769,7 @@
 
 ##
 # @VirtioRingUsed:
-#
-# Information regarding the used vring (a.k.a. device area)
+#     Information regarding the used vring (a.k.a. device area)
 #
 # @flags: VRingUsed flags
 #
@@ -938,13 +934,12 @@
 
 ##
 # @VirtIOGPUOutput:
-#
-# Describes configuration of a VirtIO GPU output.  If both @xres and
-# @yres are set, they take precedence over root virtio-gpu resolution
-# configuration and enable the corresponding output.  If none of @xres
-# and @yres are set, root virtio-gpu resolution configuration takes
-# precedence and only the first output is enabled.  Only setting one
-# of @xres or @yres is an error.
+#     Describes configuration of a VirtIO GPU output.  If both @xres
+#     and @yres are set, they take precedence over root virtio-gpu
+#     resolution configuration and enable the corresponding output.
+#     If none of @xres and @yres are set, root virtio-gpu resolution
+#     configuration takes precedence and only the first output is
+#     enabled.  Only setting one of @xres or @yres is an error.
 #
 # @name: the name of the output
 #
-- 
2.55.0


