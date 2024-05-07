Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C291C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IrF-0005ct-Kt; Tue, 07 May 2024 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrA-0005Zo-F2
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4Ir8-0004b1-F2
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715080772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f6OuYjBZrv88ojVjhaTMeYTflAUOFWIhb7MzDrZLKuw=;
 b=Wg4Wrc09WEWowXwUtOObcCkL0TJOOPYrmaXglfdiuvb0q6S8k9CHDHbTBVRcNZ36Llufb6
 vwZ1K79ygY9++OMXkeqJ4TDCNzshsEdvbMjUB5jMOTvEFnmYsMynV++mNOw+sU4OeNXUE8
 O0d/DhuwPsVYvV9b+2JUSlTxTMfVmgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-lIce3OWHOI2c4Cn3cdf7GQ-1; Tue,
 07 May 2024 07:19:26 -0400
X-MC-Unique: lIce3OWHOI2c4Cn3cdf7GQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB27538012C6;
 Tue,  7 May 2024 11:19:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4837710000AD;
 Tue,  7 May 2024 11:19:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?unknown-8bit?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PATCH 0/4] Fix "virtio-gpu: fix scanout migration post-load"
Date: Tue,  7 May 2024 15:19:16 +0400
Message-ID: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

To resolve this, we need to propagate the `vmstate` `version_id` through the
nested structures. Additionally, we should tie specific machine version to a
corresponding `version_id` to maintain migration compatibility.

`VMS_VSTRUCT` allows specifying the appropriate version of the nested structure
to use.

Marc-André Lureau (4):
  migration: add "exists" info to load-state-field trace
  include/migration: add VMSTATE_VSTRUCT_TEST_VARRAY_UINT32
  virtio-gpu: use a VMState variant for the scanout field
  virtio-gpu: add x-vmstate-version

 include/hw/virtio/virtio-gpu.h |  1 +
 include/migration/vmstate.h    | 12 ++++++++++++
 hw/core/machine.c              |  1 +
 hw/display/virtio-gpu.c        | 28 +++++++++++++++++++++-------
 migration/vmstate.c            |  5 +++--
 migration/trace-events         |  2 +-
 6 files changed, 39 insertions(+), 10 deletions(-)

-- 
2.41.0.28.gd7d8841f67


