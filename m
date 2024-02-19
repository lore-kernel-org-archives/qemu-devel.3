Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC5C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4jF-0007iA-P2; Mon, 19 Feb 2024 09:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jD-0007gv-FV
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4j6-0003qZ-Cn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708353275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UOmJStdOUdAc5bMPw3MUG8fMn6Zg7A3ozeWn+9e6xm8=;
 b=K2OYK447uxUdqVt9nANAjjLfxhzrPaLFpB4K2RZGA2cPXjBUsJTWKP/OFsfOjUbiEI023b
 m0ZjO1QjZRyPWCXAsnEdkr6WPZDm7kWvRMngU1Fnzb5YQF9q9ImtlnBjTgdTNWI4gCeObz
 fbzpC/mQ04oHCnxGhr+s4tmj9P3mhis=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-QjKdi4FpNyehHwy5tu5lfQ-1; Mon, 19 Feb 2024 09:34:32 -0500
X-MC-Unique: QjKdi4FpNyehHwy5tu5lfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0D5588CC46;
 Mon, 19 Feb 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FACC2022AAC;
 Mon, 19 Feb 2024 14:34:29 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 0/5] Virtio dmabuf improvements
Date: Mon, 19 Feb 2024 15:34:18 +0100
Message-ID: <20240219143423.272012-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014615.html
v3: Virtio dmabuf improvements
v3 -> v4
  - Changed GMutex by QemuMutex in virtio-dmabuf
  - Made the value at VirtioSharedObject an union
    to make naming more clear
  - Added some documentation

Various improvements for the virtio-dmabuf module.
This patch includes:

- Check for ownership before allowing a vhost device
  to remove an object from the table.
- Properly cleanup shared resources if a vhost device
  object gets cleaned up.
- Rename virtio dmabuf functions to `virtio_dmabuf_*`

Albert Esteve (5):
  hw/virtio: check owner for removing objects
  hw/virtio: document SharedObject structures
  hw/virtio: change dmabuf mutex to QemuMutex
  hw/virtio: cleanup shared resources
  hw/virtio: rename virtio dmabuf API

 docs/interop/vhost-user.rst       |  4 +-
 hw/display/virtio-dmabuf.c        | 98 +++++++++++++++++++------------
 hw/virtio/vhost-user.c            | 31 +++++++---
 hw/virtio/vhost.c                 |  3 +
 hw/virtio/virtio.c                |  3 +
 include/hw/virtio/virtio-dmabuf.h | 73 +++++++++++++++++------
 tests/unit/test-virtio-dmabuf.c   | 82 +++++++++++++++++++-------
 7 files changed, 211 insertions(+), 83 deletions(-)

-- 
2.43.1


