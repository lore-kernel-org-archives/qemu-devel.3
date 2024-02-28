Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24396C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIyD-0005Uk-C3; Wed, 28 Feb 2024 07:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rfIyB-0005To-JO
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:23:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rfIyA-0004y7-A1
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709123009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=smECvae9X7jd3ZBDwEGX59p3kzegbqRLc2g4I7BovlU=;
 b=My1/ARcWNjlBLhzuNrdr2T2VZPPTGm5o+skMwiIh2LFk3J+Xs2t+32YOUFchy6dSG/9x0F
 v1LoPJXNZdMHG8vdwDT0OAiNZVNVR/RSVyaDCmF9Fn9An1/nJoM7SkA3mqUqtZK7OjuD8k
 Jue7gjPxnQLaA/FlRJ+8Dio/+/X0Sck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-a0DSakEEPDe3QSPs_e5u8A-1; Wed, 28 Feb 2024 07:23:27 -0500
X-MC-Unique: a0DSakEEPDe3QSPs_e5u8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92EB2885623
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:23:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDCE6492BC8;
 Wed, 28 Feb 2024 12:23:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, sebott@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/2] virtio-gpu: fix blob scanout post-load
Date: Wed, 28 Feb 2024 16:23:21 +0400
Message-ID: <20240228122323.962826-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

The current post-loading code for scanout has a FIXME: it doesn't take the
resource region/rect into account. But there is more, when adding blob migration
support in commit f66767f75c9, I didn't realize that blob resources could be
used for scanouts. This situationn leads to a crash during post-load, as they
don't have an associated res->image.

virtio_gpu_do_set_scanout() handle all cases, but requires the associated
virtio_gpu_framebuffer, which is currently not saved during migration.

Add a v2 of "virtio-gpu-one-scanout" with the framebuffer fields, so we can
restore blob scanouts, as well as fixing the existing FIXME.

v2:
- modify first patch to get rid of another needless check (Sebastian Ott)

Marc-André Lureau (2):
  virtio-gpu: remove needless condition
  virtio-gpu: fix scanout migration post-load

 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu.c        | 58 ++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.43.2


