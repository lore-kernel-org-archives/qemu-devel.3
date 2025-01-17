Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C714FC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkM8-0004D5-3t; Fri, 17 Jan 2025 06:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYkLr-0003zb-1Y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYkLm-0002kr-94
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737112634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ct9/h8toHmrtR+AssX66a4eJxqZYBwxEz5hJlc+u/r8=;
 b=Ba5DsqVY+BnAwCCVWe5V7e4kTc1Qx5n8dsBm5dJTF61dA95HADIc6NcmeHZQBYLqTwYrYt
 IYnx+wnv3CefkizeqAk/K7g/A6VzWmJD/Dj607kDUYnEigcIwy+3vKkazeYv2U3iLbcneF
 3g4w/4XWkcvz+oM4p05HxxRVxAuEkrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-Q5jZe8IfMZagFRqmUZMQlw-1; Fri,
 17 Jan 2025 06:17:13 -0500
X-MC-Unique: Q5jZe8IfMZagFRqmUZMQlw-1
X-Mimecast-MFC-AGG-ID: Q5jZe8IfMZagFRqmUZMQlw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF6221953947
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:17:11 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.193.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5F15195608A; Fri, 17 Jan 2025 11:17:10 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/2] net: Fix announce_self with vhost
Date: Fri, 17 Jan 2025 12:17:07 +0100
Message-ID: <20250117111709.970789-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

announce_self that sends a RARP packet after migration=0D
or with announce_self QMP/HMP command doesn't work with=0D
vhost because of the vnet headers.=0D
=0D
announce_self is the only user of QEMU_NET_PACKET_FLAG_RAW and=0D
this flag is not correctly managed.=0D
=0D
This series fix a problem with this flag in filter-dump and in=0D
qemu_deliver_packet_iov().=0D
=0D
Laurent Vivier (2):=0D
  net: Fix announce_self=0D
  net/dump: Correctly compute Ethernet packet offset=0D
=0D
 net/dump.c | 3 ++-=0D
 net/net.c  | 1 +=0D
 2 files changed, 3 insertions(+), 1 deletion(-)=0D
=0D
-- =0D
2.47.1=0D
=0D


