Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB548C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 18:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRbce-0008CG-RP; Wed, 10 Jul 2024 14:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sRbcb-00082L-Ty
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sRbcZ-0003JP-QV
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720634450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+znbF9pwZIVd04bzjM+SUKkhSFYNYBhE43jpaEEmEw=;
 b=OylzPiIW+/IdblRxRuhPMsEvNFpiOOuyG9XEAnbxPejnK1N7C+IdzpFRjWCNpKS/ZRPrxc
 4ZFdBWjD+qE7EMhrPW+TGkhhULYEPiMeLu372OhjzmQJ6soFMkp+fbSCINHcJox21FasZP
 gunRyFdgR0Gck20yScAti8InUhVAePc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-beyLO8Q4Phyes2mEywwywA-1; Wed,
 10 Jul 2024 14:00:47 -0400
X-MC-Unique: beyLO8Q4Phyes2mEywwywA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F5B919560AD
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 18:00:46 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 544B81955F40; Wed, 10 Jul 2024 18:00:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>, Liang Cong <lcong@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 1/1] virtio-mem: improve error message when unplug of device
 fails due to plugged memory
Date: Wed, 10 Jul 2024 20:00:36 +0200
Message-ID: <20240710180036.101149-2-david@redhat.com>
In-Reply-To: <20240710180036.101149-1-david@redhat.com>
References: <20240710180036.101149-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The error message is actually expressive, considering QEMU only. But
when called from Libvirt, talking about "size" can be confusing, because
in Libvirt "size" translates to the memory backend size in QEMU (maximum
size) and "current" translates to the QEMU "size" property.

Let's simply avoid talking about the "size" property and spell out that
some device memory is still plugged.

Message-ID: <20240416141426.588544-1-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Cc: Liang Cong <lcong@redhat.com>
Cc: Mario Casquero <mcasquer@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ffd119ebac..ef64bf1b4a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1832,8 +1832,8 @@ static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
     }
 
     if (vmem->size) {
-        error_setg(errp, "virtio-mem device cannot get unplugged while"
-                   " '" VIRTIO_MEM_SIZE_PROP "' != '0'");
+        error_setg(errp, "virtio-mem device cannot get unplugged while some"
+                   " of its memory is still plugged");
         return;
     }
     if (vmem->requested_size) {
-- 
2.45.2


