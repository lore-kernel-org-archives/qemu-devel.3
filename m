Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9465EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjaA-0004my-K2; Tue, 16 Apr 2024 10:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rwja5-0004mW-9Q
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rwja2-0005c7-Se
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713276876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7YpE1eEq60PPyPPGLOLzheBER822cSy7TAfjKqgTugw=;
 b=bM0c/ZXLOnz0HZBEI9Nve1fyG88IfHTdfHbTwKeudmdI4ySmJAh4Ug38tBgbWcQmZjum8J
 2rZgrslqEIJm7Mc4uHOJagkUIwY1p/xe5PRZz1EsKNTsphaCrIzJFAkaoxTGISjjll5yUx
 O3BHTi9/DdC+4d2zwQaCN2D2oCv1HXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-dBMF9b63OTCv3rC4_5XKSA-1; Tue, 16 Apr 2024 10:14:34 -0400
X-MC-Unique: dBMF9b63OTCv3rC4_5XKSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 587341802A04
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 14:14:34 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91EE0C13FA2;
 Tue, 16 Apr 2024 14:14:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Liang Cong <lcong@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v1] virtio-mem: improve error message when unplug of device
 fails due to plugged memory
Date: Tue, 16 Apr 2024 16:14:26 +0200
Message-ID: <20240416141426.588544-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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
2.44.0


