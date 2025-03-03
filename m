Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14750C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6rZ-0006az-Fp; Mon, 03 Mar 2025 09:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tp6rT-0006PJ-0q
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tp6rQ-0003Cu-Fe
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741012413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z0T5gzlxSv4M5XY3yo+yhtFBXH+jjN3knBJvj6stX/U=;
 b=Ne1dlqc5xna/oTGuXYWD/QEIOwHXzm6efoEq+KpiIOusocYwSHfjpv9gRdYUCtXuQSUCZG
 vgjbj0yIZipsJrUUdcYIGsCsgwuoH4NeAX2ruL91y7MZKx2EZLpWPVcTTCNqfCZl7inGh1
 /csciNA1Sc5aEgdR6WOrIEoDHINFqpc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-_m6Gw4RTOXCGWyNB4baSaw-1; Mon,
 03 Mar 2025 09:33:30 -0500
X-MC-Unique: _m6Gw4RTOXCGWyNB4baSaw-1
X-Mimecast-MFC-AGG-ID: _m6Gw4RTOXCGWyNB4baSaw_1741012409
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 827711800988; Mon,  3 Mar 2025 14:33:29 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.124])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 714211956094; Mon,  3 Mar 2025 14:33:27 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] util/qemu-sockets: Introduce configurable TCP keep-alive
 idle period
Date: Mon,  3 Mar 2025 15:33:04 +0100
Message-ID: <20250303143312.640909-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

This series extends the work introduced by commit aec21d3175 ("qapi: Add
InetSocketAddress member keep-alive") [1]

First, it allows the use of the keep-alive flag for server-side sockets.
Then it introduces a new keep-alive-idle-period setting, which changes
the TCP_KEEPIDLE socket option on platforms that support it (this option
is found in Linux, BSD, and Win32 documentations).

By default, the value of keep-alive-idle-period is 0, which means no
custom socket option value is set.

This is useful, for example, for live migration. In case there is no
traffic from the destination to the source machine during postcopy, the
destination cannot detect a failed connection due to a lack of
non-acknowledged packets and stays in the postcopy-active state until
paused by the management of the QEMU instance.

[1]: https://lore.kernel.org/all/20190725094937.32454-1-vsementsov@virtuozzo.com/

Juraj Marcin (2):
  util/qemu-sockets: Add support for keep-alive flag to passive sockets
  utils/qemu-sockets: Introduce keep-alive-idle-period inet socket
    option

 io/dns-resolver.c   |  6 +++++
 meson.build         |  2 ++
 qapi/sockets.json   |  9 +++++--
 util/qemu-sockets.c | 58 ++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 67 insertions(+), 8 deletions(-)

-- 
2.48.1


