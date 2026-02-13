Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D725EF48D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 07:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqnL7-0002lL-OF; Fri, 13 Feb 2026 02:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnL2-0002kG-5M
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKz-0005eb-Lx
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770966697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XqBAWjNfsCkJWkYmrEfgAktWS9f9SYgLSbaxuuB2Dc=;
 b=dbRRzf+x1zp/vIEjndMvidrJop5eMuHwcExJ97wtJf/r1q2CGY2tq4hdfVIpbm0eqb+5vD
 pgi3GDtKs2HtxCfycGkg4Xwn/plFx6+GZotycMLTp+TFBlEb02bC4OmbYaLxRsmXs5HE3b
 G7r1WszHJ158lnO57Q/LsWE0ohSt4+k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-K0e8aoZdNBSe0yWh8aIrMA-1; Fri,
 13 Feb 2026 02:11:33 -0500
X-MC-Unique: K0e8aoZdNBSe0yWh8aIrMA-1
X-Mimecast-MFC-AGG-ID: K0e8aoZdNBSe0yWh8aIrMA_1770966692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DEDE18003F5; Fri, 13 Feb 2026 07:11:32 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9BE318003F5; Fri, 13 Feb 2026 07:11:28 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [RFC 5/5] qapi: add in/out_netdev to filter-redirector
Date: Fri, 13 Feb 2026 15:08:05 +0800
Message-ID: <20260213071042.3733239-6-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-1-lulu@redhat.com>
References: <20260213071042.3733239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Document the new in_netdev and out_netdev properties in the QAPI
schema for FilterRedirectorProperties:

- in_netdev: Name of an input netdev endpoint captured via AF_PACKET.
  Allows capturing packets directly from a TAP interface, bypassing
  the QEMU network stack.

- out_netdev: Name of an output netdev endpoint injected via AF_PACKET.
  Allows injecting packets directly to a TAP interface.

These properties are mutually exclusive with each other and with
indev/outdev on the same direction. They enable filter-redirector
to work with vhost-net backends for live migration packet mirroring.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 qapi/qom.json | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index b1fe55944c..a62a824403 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -476,8 +476,15 @@
 #
 # Properties for filter-redirector objects.
 #
-# At least one of @indev or @outdev must be present.  If both are
-# present, they must not refer to the same character device backend.
+# At least one of @indev, @outdev, @in_netdev, or @out_netdev must be
+# present.
+#
+# If both @indev and @outdev are present, they must not refer to the
+# same character device backend.
+#
+# @in_netdev and @out_netdev are Linux AF_PACKET based endpoints.
+# They are mutually exclusive with each other, and also with
+# @indev/@outdev on the same direction.
 #
 # @indev: the name of a character device backend from which packets
 #     are received and redirected to the filtered network device
@@ -485,6 +492,12 @@
 # @outdev: the name of a character device backend to which all
 #     incoming packets are redirected
 #
+# @in_netdev: the name of an input netdev endpoint captured via
+#     AF_PACKET
+#
+# @out_netdev: the name of an output netdev endpoint injected via
+#     AF_PACKET
+#
 # @vnet_hdr_support: if true, vnet header support is enabled
 #     (default: false)
 #
@@ -498,6 +511,8 @@
   'base': 'NetfilterProperties',
   'data': { '*indev': 'str',
             '*outdev': 'str',
+            '*in_netdev': 'str',
+            '*out_netdev': 'str',
             '*vnet_hdr_support': 'bool',
             '*enable_when_stopped': 'bool' } }
 
-- 
2.52.0


