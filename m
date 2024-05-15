Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F497C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7FQo-0004FZ-2t; Wed, 15 May 2024 10:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7FQV-000449-3B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7FQP-0005eN-T2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715782569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SbUxgf7bDW9Dc3KIs+3blromY2juehAlMOJMQHH61mA=;
 b=cXFPIMOl76G4azFPlbQQtgDJMLTMvQqUTcebZIklmcMmR5gIKEJJsYZorpQB+ERo4E45ny
 sRZSGmtzfjOTSKApQopWm7Z1qV/wDIcqj2WwHJVsOVxGeFrOVi9t70X0ZzEEj4UQ0GOoAp
 PhEnGyOdQ4NmgbZkAotrUIeSInMZ+l8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-93m0S43YMZO8aZlP5Rkmug-1; Wed,
 15 May 2024 10:16:02 -0400
X-MC-Unique: 93m0S43YMZO8aZlP5Rkmug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BE751C00ABD;
 Wed, 15 May 2024 14:16:02 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAACD1C008B9;
 Wed, 15 May 2024 14:15:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?unknown-8bit?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PATCH v3 0/5] Fix "virtio-gpu: fix scanout migration post-load"
Date: Wed, 15 May 2024 18:15:51 +0400
Message-ID: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v3:
 - introduce machine_check_version()
 - drop the VMSD version, and use machine version field test

Marc-André Lureau (5):
  migration: add "exists" info to load-state-field trace
  migration: fix a typo
  hw/boards: add machine_check_version()
  Set major/minor for PC and arm machines
  virtio-gpu: fix v2 migration

 include/hw/boards.h     | 14 ++++++++
 include/hw/i386/pc.h    |  4 ++-
 hw/arm/virt.c           |  2 ++
 hw/display/virtio-gpu.c | 21 +++++++-----
 hw/i386/pc_piix.c       | 74 ++++++++++++++++++++---------------------
 hw/i386/pc_q35.c        | 62 +++++++++++++++++-----------------
 migration/vmstate.c     |  7 ++--
 migration/trace-events  |  2 +-
 8 files changed, 105 insertions(+), 81 deletions(-)

-- 
2.41.0.28.gd7d8841f67


