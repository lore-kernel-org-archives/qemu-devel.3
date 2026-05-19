Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE1CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 19:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPPvJ-0004zq-0B; Tue, 19 May 2026 15:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPv9-0004sy-92
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPv6-0005tR-2c
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779218155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z/dydJwiQmKYgs7y/lkpJKmjgQZhk+6GtLd8TqFBLMc=;
 b=Tq62ItA4eIL3FC0ktr39IySpSxW4Y6DY5RZCyHfMlp6v7rm1wFzLUFYVcCFfTm8VOXIMe6
 CK3lt3QscO61F4nWZuHRnPCD2rGI1P5veNrMiWFuGwlpoTiVizpq9FzGjO4figNqTJr+D0
 W9IgDRBgkFPO7aBEV50DclpXCW8uAKw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-Jd_h82LCM5yvko2yNtczrQ-1; Tue,
 19 May 2026 15:15:51 -0400
X-MC-Unique: Jd_h82LCM5yvko2yNtczrQ-1
X-Mimecast-MFC-AGG-ID: Jd_h82LCM5yvko2yNtczrQ_1779218150
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 791CB18005BB; Tue, 19 May 2026 19:15:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 820501686; Tue, 19 May 2026 19:15:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, hreitz@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, gmaglione@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/3] vhost-user.rst: clarify when rings are started
Date: Tue, 19 May 2026 15:15:45 -0400
Message-ID: <20260519191548.335082-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jorge Moreira <jemoreira@google.com> pointed out that the ring state machine is
underspecified. This patch series updates the spec to clarify how the ring
state machine works, makes libvhost-user spec-compliant, and improves the
compatibility of QEMU's vhost-user front-end.

Stefan Hajnoczi (3):
  vhost-user.rst: clarify when rings are started
  libvhost-user: look for available vq buffers upon SET_VRING_KICK
  vhost-user: inject kick after SET_VRING_KICK

 docs/interop/vhost-user.rst               | 26 +++++++++++++++++------
 hw/virtio/vhost-user.c                    | 24 ++++++++++++++++++++-
 subprojects/libvhost-user/libvhost-user.c | 10 ++++-----
 3 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.54.0


