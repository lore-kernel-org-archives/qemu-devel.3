Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE42C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oob-0008VB-Bv; Thu, 10 Sep 2026 20:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x4lYj-0006vX-Bp
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x4lYd-0005BZ-1w
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nw7JEpbtaai2fySGK5XqeVhBPUXDsLTe8heCM5m/fpo=;
 b=VVtfergKNs3bUtFuAIOWq18F48H3ieMia31t9C0LkJ3Z/GB7gZ78OhNKiJ0h1DMslDuFGX
 /8Fue4Vmho0B2m8j8K+EgwBICF4b/fdD33ebhaU8xf7s+ZB0RJ0J/+upEqxMSKYW17kfrk
 MR8znJYCriGn2hjQVudglXuPAEFa3Xg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-wzACXLQ3M8G_wjvS3J720w-1; Thu,
 10 Sep 2026 16:39:35 -0400
X-MC-Unique: wzACXLQ3M8G_wjvS3J720w-1
X-Mimecast-MFC-AGG-ID: wzACXLQ3M8G_wjvS3J720w_1789072774
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02E51180067B; Thu, 10 Sep 2026 20:39:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37B4046E; Thu, 10 Sep 2026 20:39:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Markus Armbruster <armbru@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/10] qapi: convert simple data struct intros for virtio.json
Date: Thu, 10 Sep 2026 16:38:53 -0400
Message-ID: <20260910203856.99003-8-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qapi/virtio.json | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9aafc3a212f..0a4753cc343 100644
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


