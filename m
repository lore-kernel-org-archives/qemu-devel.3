Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9C1C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Pxw-0000l4-AW; Mon, 13 May 2024 03:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6Pxu-0000jr-AM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6Pxs-0004Ky-P7
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715584755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QywfJOibZQ5V4uDnSEhc87GGriUW4v0rdr0u0xgUeB8=;
 b=BNEegH9zGYDovXa0cBUe5U7bCWRbYt0dis+hxlj8c1B8yT7QU78SmD45CmZx0TBB7HqG0P
 sjmTV/HCJb2Vudr6KZ0csAl7p2NQaKTw8De7oa3obrfuZ2oI/bzplK//8rTpUeRJ2/jBtV
 o+iyV+8XoEndK3+kQHTwe/QXqQ16IVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-5hczHpFpM6OVX4YnOpytqQ-1; Mon, 13 May 2024 03:19:10 -0400
X-MC-Unique: 5hczHpFpM6OVX4YnOpytqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7D21800CB1;
 Mon, 13 May 2024 07:19:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB99E40C5B6;
 Mon, 13 May 2024 07:19:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?unknown-8bit?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/4] Fix "virtio-gpu: fix scanout migration post-load"
Date: Mon, 13 May 2024 11:19:01 +0400
Message-ID: <20240513071905.499143-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

The aforementioned patch breaks virtio-gpu device migrations for versions
pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is more
complex than it may initially appear, as evidenced in the problematic commit
dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").

v2:
 - use a manual version field test (instead of the more complex struct variant)

Marc-André Lureau (3):
  migration: add "exists" info to load-state-field trace
  migration: fix a typo
  virtio-gpu: add x-vmstate-version

Peter Xu (1):
  virtio-gpu: fix v2 migration

 include/hw/virtio/virtio-gpu.h |  1 +
 hw/core/machine.c              |  1 +
 hw/display/virtio-gpu.c        | 26 ++++++++++++++++++--------
 migration/vmstate.c            |  7 ++++---
 migration/trace-events         |  2 +-
 5 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.41.0.28.gd7d8841f67


