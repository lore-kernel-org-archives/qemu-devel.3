Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17086CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJPz-0000mE-W3; Wed, 10 Sep 2025 07:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uwJPy-0000lu-Lz
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uwJPp-0001fj-Rd
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757505307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXG6nBRyssLRsnDK38URuLwEwpEb4ieR4NV7wjgJN8Q=;
 b=WyiS13nCcNy3yOPSVEfl5vjes0lb2MnhZWQuIPPJSvRRwx/VkwiQSX8bu4blP1NpOuZg4y
 ogPGROX1GuEv++diL44r7LrUOXbmBBymKSXrhF83R07tRmZNiRDhMeVF53f8ySOvTIjd+d
 MyObp8UasoPll2aY5lw0k3jIMIrrs94=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-3B9ScziGNTeLydmKuCCDkg-1; Wed,
 10 Sep 2025 07:55:06 -0400
X-MC-Unique: 3B9ScziGNTeLydmKuCCDkg-1
X-Mimecast-MFC-AGG-ID: 3B9ScziGNTeLydmKuCCDkg_1757505305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A7021800370; Wed, 10 Sep 2025 11:55:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A1A41800447; Wed, 10 Sep 2025 11:54:58 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, hi@alyssa.is, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, david@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v8 6/7] qmp: add shmem feature map
Date: Wed, 10 Sep 2025 13:54:19 +0200
Message-ID: <20250910115420.1012191-7-aesteve@redhat.com>
In-Reply-To: <20250910115420.1012191-1-aesteve@redhat.com>
References: <20250910115420.1012191-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add new vhost-user protocol
VHOST_USER_PROTOCOL_F_SHMEM feature to
feature map.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/virtio-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d..8c2cfd0916 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -127,6 +127,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
             "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
             "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHMEM, \
+                "VHOST_USER_PROTOCOL_F_SHMEM: Backend shared memory mapping "
+                "supported"),
     { -1, "" }
 };
 
-- 
2.49.0


