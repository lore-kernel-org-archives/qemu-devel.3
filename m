Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C822BC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLTu-0006uX-PM; Thu, 16 Jan 2025 03:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYLTn-0006pX-2v; Thu, 16 Jan 2025 03:43:55 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYLTk-0006oc-7W; Thu, 16 Jan 2025 03:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=cRHcaJ8qr8tMPnLKEmxRjL10dz3nijScrW9hqSSprGI=; b=a0JdykAwXTVMSDZdFhhN4Z7cfQ
 +hkqZYOFUzj70KfuL/shYChBrPpS9OMTKdQKym7SM9hE75EgIt1beZsZ0VBiTWMBI1q73n2/jeldh
 vAyBP6Ntre/VpAlcAU3eiPuyy5qA+jQDwXdNq9JuAEyohhdwg3ByFzsHqoGk9rO54aFoxmtz2SyuI
 u871I5zV6ZqIPcS/EyGJfbpuJvQy+1ZQOdWvTJ9iELFBkqicl4xAcN3C2b9ooQu696jWtHhpgL56+
 xGUEtMxgXnjleq3ScpuIxnmoVy21iSD4zLs19jrJgW9gRgdLYTZj9x6/4z7LYj1Lhz0ANBOHl2keZ
 915QaGmQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYLTe-0000000B1PZ-02zV; Thu, 16 Jan 2025 08:43:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYLTc-00000007pHU-1vM7; Thu, 16 Jan 2025 08:43:44 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PULL 0/8] Xen regression fixes and cleanups
Date: Thu, 16 Jan 2025 08:43:24 +0000
Message-ID: <20250116084332.1864967-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

From: David Woodhouse <dwmw@amazon.co.uk>

The following changes since commit 7433709a147706ad7d1956b15669279933d0f82b:

  Merge tag 'hw-misc-20250113' of https://github.com/philmd/qemu into staging (2025-01-14 12:46:56 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/dwmw2/qemu.git tags/pull-xenfv-20250116

for you to fetch changes up to e7bc0204e57836b3df611b73d2decc56ed698c4a:

  system/runstate: Fix regression, clarify BQL status of exit notifiers (2025-01-15 18:05:19 +0000)

----------------------------------------------------------------
Xen regression fixes and cleanups

----------------------------------------------------------------
David Woodhouse (6):
      hw/xen: Add xs_node_read() helper function
      hw/xen: Use xs_node_read() from xs_node_vscanf()
      hw/xen: Use xs_node_read() from xen_console_get_name()
      hw/xen: Use xs_node_read() from xen_netdev_get_name()
      hw/xen: Use xs_node_read() from xenstore_read_str() instead of open-coding it
      hw/xen: Fix errp handling in xen_console

Phil Dennis-Jordan (1):
      system/runstate: Fix regression, clarify BQL status of exit notifiers

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
 include/system/system.h         |  1 +
 system/runstate.c               |  1 +
 11 files changed, 96 insertions(+), 47 deletions(-)

