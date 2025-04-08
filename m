Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684F8C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u275X-0007Vi-Nn; Tue, 08 Apr 2025 07:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275S-0007VH-H7
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275Q-0006Mm-HR
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744111545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WjFPABZXILeJ78Wq6M5oMzhIXnSZu3uoZGgbnQQdzUM=;
 b=d8aW2MOZojHcYvNGklkBfRQnCwryVtWFVw2KhtqHoPmX5pxkeFHPeeL/cOdTrr33xVUpfB
 7JHRmkHJEXKv+1/JDQ2+iMYjNBMN9ecKM+8csus+Cdlck6wZ8fJA+KCfkG4nt08FaOEz4a
 owcBdpn9gnCVgEYhSQm2KnE/D64Ww5g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-xueCR_dNPUGfeXrYIEEjwA-1; Tue,
 08 Apr 2025 07:25:41 -0400
X-MC-Unique: xueCR_dNPUGfeXrYIEEjwA-1
X-Mimecast-MFC-AGG-ID: xueCR_dNPUGfeXrYIEEjwA_1744111540
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5204195608A; Tue,  8 Apr 2025 11:25:40 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6516B195DF82; Tue,  8 Apr 2025 11:25:37 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 0/5] util/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Date: Tue,  8 Apr 2025 13:24:59 +0200
Message-ID: <20250408112508.1638722-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
InetSocketAddress member keep-alive"). [1]

First, the series fixes an issue in qio_dns_resolver_lookup_sync_inet(),
where the InetSocketAddress structure is only partially copied. Next, it
refactors setting client socket options into a separate function and the
success and failure paths in inet_listen_saddr() in preparation for
keep-alive support on server sockets and the addition of new TCP
keep-alive options.

Then, the series adds support for keep-alive on server sockets and adds
three new InetSocketAddress options for control of TCP keep-alive
settings. By default, the value of all new settings is 0, which means no
custom socket option value is set.

This is useful, for example, for live migration. In case there is no
traffic from the destination to the source machine during postcopy, the
destination cannot detect a failed connection due to a lack of
non-acknowledged packets and stays in the postcopy-active state until
paused by the management of the QEMU instance.

[1]: https://lore.kernel.org/all/20190725094937.32454-1-vsementsov@virtuozzo.com/

---
V3:
- moved the InetSocketAddress struct copy fix and the common function
  setting socket options into a separate commit
- refactored inet_listen_saddr()

V2:
- moved socket options setting into a common function for both server
  and client sockets (suggested by Vladimir)

Juraj Marcin (5):
  io: Fix partial struct copy in qio_dns_resolver_lookup_sync_inet()
  util/qemu-sockets: Refactor setting client sockopts into a separate
    function
  util/qemu-sockets: Refactor success and failure paths in
    inet_listen_saddr()
  util/qemu-sockets: Add support for keep-alive flag to passive sockets
  utils/qemu-sockets: Introduce inet socket options controlling TCP
    keep-alive

 io/dns-resolver.c   |  21 ++----
 meson.build         |   6 ++
 qapi/sockets.json   |  19 ++++-
 util/qemu-sockets.c | 177 ++++++++++++++++++++++++++++++++++----------
 4 files changed, 165 insertions(+), 58 deletions(-)

-- 
2.48.1


