Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44293C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6N2-0007Wh-3v; Wed, 15 Jan 2025 11:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tY6Mw-0007Sg-V0; Wed, 15 Jan 2025 11:35:50 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tY6Mu-0001e9-P7; Wed, 15 Jan 2025 11:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=rrBZA8lyQEOQWQ/8jP8VTP1JvBxjDjQmwbWIQpBZfxo=; b=bNgCieMNDffHCdWjm/68OAkXTG
 d5w+ofW/5y5gRlSK97lAC1R66Sg+L2TSKt30Vt0HN8TGF8l8ThTmrOYOR5YdWa8FJLXSwEx/p7+p1
 mdJUyZaRDzrbtOj01paIYHTzyYiqftFNDGQZie3ihQvnI8v8BEv+sb7c1JME9/etOAgBvD1lO1y7d
 +CxQKnbgM6P5aRh+Gl7jzfnnWkIUHpDOg8FYO1ySbUU2+sOd4YmD3otlB7IuxlIevQ+Z39rjP1LKP
 S5phfA9zv3PP2u+MrYdadmzCGy35rL1VR2fvUvulJxgUz2qYu4ah8uc6cIdzD/yh0iUix+aI38HXa
 j/my6YBQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tY6Mq-0000000GF6F-0HXR; Wed, 15 Jan 2025 16:35:44 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tY6Mp-00000001HhI-3F67; Wed, 15 Jan 2025 16:35:43 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Subject: [PATCH v3 1/7] xen: error handling and FreeBSD compatibility fixes
Date: Wed, 15 Jan 2025 16:27:18 +0000
Message-ID: <20250115163542.291424-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a new xs_node_read() helper function which constructs the node path 
using a printf format string, and use it where appropriate.

In particular, use it to eliminate the use of the %ms format specifier 
for scanf(), which doesn't exist in FreeBSD.

v3:
 • Further cleanups using xs_node_read().
 • Clean up errp handling for xen-console 'output' node.
 • Improve comment for xs_node_read().

v2:
 • Add xs_node_read() helper.
 • Also fix usage of %ms in xen-block.c

David Woodhouse (6):
      hw/xen: Add xs_node_read() helper function
      hw/xen: Use xs_node_read() from xs_node_vscanf()
      hw/xen: Use xs_node_read() from xen_console_get_name()
      hw/xen: Use xs_node_read() from xen_netdev_get_name()
      hw/xen: Use xs_node_read() from xenstore_read_str() instead of open-coding it
      hw/xen: Fix errp handling in xen_console

Roger Pau Monné (1):
      xen: do not use '%ms' scanf specifier

 hw/block/xen-block.c            |  3 ++-
 hw/char/xen_console.c           | 56 ++++++++++++++++++++++++-----------------
 hw/net/xen_nic.c                | 13 +++++-----
 hw/xen/trace-events             |  2 +-
 hw/xen/xen-bus-helper.c         | 37 ++++++++++++++++++++-------
 hw/xen/xen-bus.c                | 14 +++++++++--
 hw/xen/xen_pvdev.c              |  6 ++---
 include/hw/xen/xen-bus-helper.h |  9 +++++++
 include/hw/xen/xen-bus.h        |  1 +
 9 files changed, 94 insertions(+), 47 deletions(-)


