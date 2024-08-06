Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C47C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 02:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb9ta-0008HT-MN; Mon, 05 Aug 2024 22:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb9tZ-0008GU-AX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb9tX-0007Uc-KO
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722911150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BqrUNzKQi8NV3ujekz5tD55XxDDT5t6TvCaNRrh2kEY=;
 b=Ty0xEP8kgXecYG0buGuw3xOnhOrmSpCpN2gGLhH7mPdK8L2BZK8SKTSEwRfodtmrYoKOBq
 5UXFj/UDvdx7r6ZgVuOmvebGEG2wjzQtZJgxiEQGiwa7ZkbAGvfxTj650jHliALWFEBvKI
 +Ge16aO15b7/hZ7e2KO8Hk5pIaHJVU0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-sNNXcNS8PNKmlFMRAQJIBQ-1; Mon,
 05 Aug 2024 22:25:48 -0400
X-MC-Unique: sNNXcNS8PNKmlFMRAQJIBQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEBC119560B4; Tue,  6 Aug 2024 02:25:46 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5021F1955E7E; Tue,  6 Aug 2024 02:25:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH for-9.1 v3 0/2] NBD CVE-2024-7409
Date: Mon,  5 Aug 2024 21:21:34 -0500
Message-ID: <20240806022542.381883-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00253.html

Since then:
 - CVE number assigned
 - drop old patch 1. Instead of tracking nbd_server generation, the
   code now ensures that nbd_server can't be set to NULL until all
   clients have disconnected
 - rewrite to force qio shutdown coupled with AIO_WAIT to ensure all
   clients actually disconnect quickly (from the server's
   perspective. A client may still hold its socket open longer, but
   will eventually see EPIPE or EOF when finally using it)
 - patch 2 is optional, although I like the notion of a doubly-linked
   list (where the client has to remember an opaque pointer) over a
   singly-linked one (where the client is unchanged, but a lot of
   repeated client connect/disconnect over a long-lived server can
   chew up memory and slow down the eventual nbd-server-stop)

Eric Blake (2):
  nbd: CVE-2024-7409: Close stray client sockets at server shutdown
  nbd: Clean up clients more efficiently

 include/block/nbd.h |  4 +++-
 blockdev-nbd.c      | 39 +++++++++++++++++++++++++++++++++++++--
 nbd/server.c        | 15 ++++++++++++---
 qemu-nbd.c          |  2 +-
 4 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.45.2


