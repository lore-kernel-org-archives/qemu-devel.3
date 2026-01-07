Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD56CFD65B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdW9q-0006cH-Lb; Wed, 07 Jan 2026 11:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdW9j-0006Is-0J
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdW9h-0005K7-9J
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767802384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n3n5CCAFAvCTgE3Nhql9s/M1ERL8Zb44i+LC2qs21NQ=;
 b=h1e3NSshWEbUFlHNbVfn1DzaB6Ns4Jay9ChiQ3DG3yQXLqTQxKoRy8od96a3LQ8vO1VVF9
 EuQuQ+JoM9ycAGjhQNwJcKhxwtq7lPPvaWmLh6sJShwBA0WYoYCaZ5YF3kr7f8SAyeCvt5
 GxHVkjPepUI67Po3VUitkDV+A0vFGJ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-MYN3dG77M_-eh6u9U8a-DQ-1; Wed,
 07 Jan 2026 11:13:00 -0500
X-MC-Unique: MYN3dG77M_-eh6u9U8a-DQ-1
X-Mimecast-MFC-AGG-ID: MYN3dG77M_-eh6u9U8a-DQ_1767802380
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D607C19560AA; Wed,  7 Jan 2026 16:12:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8787D1956048; Wed,  7 Jan 2026 16:12:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB56121E6937; Wed, 07 Jan 2026 17:12:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/4] Monitor patches for 2026-01-07
Date: Wed,  7 Jan 2026 17:12:52 +0100
Message-ID: <20260107161256.1321694-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0:

  Merge tag 'pull-aspeed-20260105' of https://github.com/legoater/qemu into staging (2026-01-06 06:52:47 +1100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-01-07

for you to fetch changes up to e714f1a3d4d1e66b9a3ff4be1ff999c32bbef29e:

  monitor/qmp: cleanup SocketChardev listener sources early to avoid fd handling race (2026-01-07 17:05:25 +0100)

----------------------------------------------------------------
Monitor patches for 2026-01-07

----------------------------------------------------------------
Jie Song (1):
      monitor/qmp: cleanup SocketChardev listener sources early to avoid fd handling race

Markus Armbruster (3):
      qdev: Fix "info qtree" to show links
      qdev: Legacy properties are now unused internally, drop
      scripts/device-crash-test: ERROR_RULE_LIST garbage collection

 include/chardev/char-io.h |  2 ++
 include/chardev/char.h    |  2 ++
 chardev/char-io.c         |  8 ++++++++
 chardev/char-socket.c     | 10 ++++++++++
 hw/core/qdev-properties.c | 46 ----------------------------------------------
 monitor/qmp.c             |  5 +++++
 system/qdev-monitor.c     |  7 +++----
 scripts/device-crash-test |  7 -------
 8 files changed, 30 insertions(+), 57 deletions(-)

-- 
2.52.0


