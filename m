Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9978CCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 07:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9elT-0001Qb-3A; Fri, 17 Oct 2025 03:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9elP-0001PX-U6
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9elI-0000KQ-25
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760685619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+soZVExHC9gPB3wuLE6WzPXTmAf7YwpLLyyUcWDY5eo=;
 b=gwrWWNX9G5rxF5s1iV2AEQaiZZeie8h9KCAXmSJzUxdFHWs+Wk/iGV32PqxwYiXjsyq9T8
 O6DHwWo1gwspdywL3pBqp8saE0d/aamHUOkNPEWvH+/y9e2VjzzE09Uve8gkyckylzwxwx
 5KBc19e55tYLmXyRYCrnShuqEeR6MWo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-Nb5DZWkGO4i6TbhF9zLumg-1; Fri,
 17 Oct 2025 03:20:16 -0400
X-MC-Unique: Nb5DZWkGO4i6TbhF9zLumg-1
X-Mimecast-MFC-AGG-ID: Nb5DZWkGO4i6TbhF9zLumg_1760685616
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8BAA19560AD
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:20:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A5061956056; Fri, 17 Oct 2025 07:20:12 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 0/1] vhost-user: fix shared object lookup handler logic
Date: Fri, 17 Oct 2025 09:20:10 +0200
Message-ID: <20251017072011.1874874-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

v3->v4:
- Base the branch on [PATCH v10 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
- Add `reply_ack = false;` for SHMEM_MAP/UNMAP handlers.

v4 is based on:
[PATCH v10 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests

Based-on: <20251016143827.1850397-1-aesteve@redhat.com>

Refactor backend_read() function and add a reply_ack variable
to have the option for handlers to force tweak whether they should
send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
flag.

This fixes an issue with
vhost_user_backend_handle_shared_object_lookup() logic, as the
error path was not closing the backend channel correctly. So,
we can remove the reply call from within the handler, make
sure it returns early on errors as other handlers do and
set the reply_ack variable on backend_read() to true to ensure
that it will send a response, thus keeping the original intent.

Albert Esteve (1):
  vhost-user: fix shared object lookup handler logic

 hw/virtio/vhost-user.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

-- 
2.49.0


