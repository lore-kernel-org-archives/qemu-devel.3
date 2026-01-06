Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF00C47BC8
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 08:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd2b2-0001tW-HE; Tue, 06 Jan 2026 03:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vd2az-0001tB-Ih
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:39:18 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vd2ax-0007WO-1u
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:39:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767688745; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YkugCPi23U7F/YVRWYuqNfefwD4PdQAVz0tiWyDjDD6Yj4L38yXqS1sc16B8kFgYB84HTer1eRy95d6BqNunDOW5ni9yLCAuH3W/FCtVDYNJViNsBfl9ZU/SVqsQNTYBq0A1M9ZyaHSOI204DHD74Qhf1xZOfhUV881owLAbJBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767688745;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wQhER49pCJdH9RYGPala/E5TT2h5UjcEyJS5CiemJys=; 
 b=NsDvcMKqt7qYPQhvQjYsYW7UwxUqVs123LnWsA/yvJEjO7axn2mW8QJjKbFJ/Au7uO+DSQZynfNmlueTgDTIRzNvmboCI/pKJa5e1XY7/RT07IwTxugBcRn0ThvgvT+Zx5VGM/DUcemjYRzhwHGKWpp3wOnDH7FrbtlOtUkTWCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767688745; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wQhER49pCJdH9RYGPala/E5TT2h5UjcEyJS5CiemJys=;
 b=FQOiX4pFKtXMk8nDI1IaVljn3agS8xa02YcfdJgH8phX8nnsFjtQvpej1j3ncW8P
 o/PmnDidlsneJGnhCLTlqktqJtdXX9qqQm6mG3UR2ZOmBdNf4JZaAI9TNA2bTDz1tGy
 gLKZl7XEzwE46Qyj5JESpOrXh8Yckif/T7e2vZ3g=
Received: by mx.zohomail.com with SMTPS id 1767688742583327.5420992961897;
 Tue, 6 Jan 2026 00:39:02 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH] virtio-pmem: ignore empty queue notifications
Date: Tue,  6 Jan 2026 16:38:59 +0800
Message-ID: <20260106083859.380338-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Li Chen <chenl311@chinatelecom.cn>

virtio_pmem_flush() treats a NULL return from virtqueue_pop() as a fatal
error and calls virtio_error(), which puts the device into NEEDS_RESET.

However, virtqueue handlers can be invoked when no element is available,
so an empty queue should be handled as a benign no-op.

With a Linux guest this avoids spurious NEEDS_RESET and the resulting
-EIO propagation (e.g. EXT4 journal abort and remount-ro).

Signed-off-by: Li Chen <me@linux.beauty>
---
 hw/virtio/virtio-pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 3416ea1827..cec1072f78 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -74,7 +74,6 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_pmem_flush_request();
     req_data = virtqueue_pop(vq, sizeof(VirtIODeviceRequest));
     if (!req_data) {
-        virtio_error(vdev, "virtio-pmem missing request data");
         return;
     }
 
-- 
2.52.0


