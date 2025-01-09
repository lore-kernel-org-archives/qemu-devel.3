Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D88E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVq5s-0005bZ-0p; Thu, 09 Jan 2025 05:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2ecee9f010fd6b9329bb+7809+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tVq5p-0005YD-8q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:48:49 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2ecee9f010fd6b9329bb+7809+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tVq5n-0007D8-6f
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=z4x1H6xjja6RODmOND3tieoUmn/C9w3hi8f31PApUYM=; b=IRqwKXK6wi2G42bt9zDvhElRvk
 PWBZABcnP10FQyiHhQnDVYRMUmx0aQIVbvqIPbi39INfa4lnEIKjF6knvsBYl/cvWyVpyrcE+1OXz
 9hS14dZ41X2mvTaE8ANYzZpbJLXp7MhqE5gabv41obzczA3KAKOKuUwZLhFxB/Uy1g+BrNm9CnFeW
 t1gHaWuLeJNEqcsY7MhAmRJD864aLMZMZGnA4D5coTMptDjFvHySyS5YZvm1OwKLyQGZ0n5FKxqLV
 SisjvX4vfEKKrUFvxCQFUObNQyN24FkG/sQB5jCvPZdqYmYTxbV365Xj9ENNeuobcQWLm/TES0Irc
 xznEPqtQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVq5f-00000009Y3v-3Bf8; Thu, 09 Jan 2025 10:48:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tVq5d-0000000Acl0-4BB1; Thu, 09 Jan 2025 10:48:37 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 0/2] xenfv queue
Date: Thu,  9 Jan 2025 10:48:35 +0000
Message-ID: <20250109104837.2532259-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+2ecee9f010fd6b9329bb+7809+infradead.org+dwmw2@desiato.srs.infradead.org;
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

The following changes since commit 3f8bcbba3b320c610689576fc47595f1076198dd:

  Merge tag 'pull-request-2025-01-08' of https://gitlab.com/thuth/qemu into staging (2025-01-08 11:38:21 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/dwmw2/qemu.git tags/pull-xenfv-20250109-1

for you to fetch changes up to b6014c5089a313ac84fe74970eee56e3fc87b49b:

  hw/xen: Check if len is 0 before memcpy() (2025-01-09 10:43:13 +0000)

----------------------------------------------------------------
Xen emulation fixes

----------------------------------------------------------------
Akihiko Odaki (1):
      hw/xen: Check if len is 0 before memcpy()

David Woodhouse (1):
      hw/i386/pc: Fix level interrupt sharing for Xen event channel GSI

 hw/i386/kvm/xen_evtchn.c   | 60 ++++++++++++++++++++++++++++++++++++----------
 hw/i386/kvm/xen_evtchn.h   |  2 +-
 hw/i386/kvm/xen_xenstore.c |  4 ++++
 hw/i386/x86-common.c       | 32 ++++++++++++++++---------
 4 files changed, 73 insertions(+), 25 deletions(-)

