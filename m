Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0312DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WfE-0002tx-V0; Thu, 16 May 2024 04:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7WfC-0002t9-C8
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7WfB-0003UX-0b
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715848831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=It9Ng292lFpN2CUkE/WxM/OeFyGmuXIykM+ElTLFdbY=;
 b=AghbCPt+mXnQil+xmh8+PA2l1muH3vGCEqCMn8Mr1tK7h0IIxOAD9J7/o4sF8fkkJ/Zaj8
 inkN09OyECSlFhNv9l8QmoU8V3VFnd8PeVdeR6uVifKcVZgF8E1l09CwvIr4s6Z1ArRq4t
 ssHeQLC1Us4oIthYrcKiibI3LwMtADA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-4HdyzAiPNGWgmQcMszcpMw-1; Thu, 16 May 2024 04:40:27 -0400
X-MC-Unique: 4HdyzAiPNGWgmQcMszcpMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED178857A83;
 Thu, 16 May 2024 08:40:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9D93740F;
 Thu, 16 May 2024 08:40:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?unknown-8bit?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PATCH v4 0/3] Fix "virtio-gpu: fix scanout migration post-load"
Date: Thu, 16 May 2024 12:40:19 +0400
Message-ID: <20240516084022.1398919-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

v4:
 - drop machine_check_version() approach
 - property renamed to x-scanout-vmstate-version

Marc-André Lureau (3):
  migration: add "exists" info to load-state-field trace
  migration: fix a typo
  virtio-gpu: fix v2 migration

 include/hw/virtio/virtio-gpu.h |  1 +
 hw/core/machine.c              |  1 +
 hw/display/virtio-gpu.c        | 24 ++++++++++++++++--------
 migration/vmstate.c            |  7 ++++---
 migration/trace-events         |  2 +-
 5 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.41.0.28.gd7d8841f67


