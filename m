Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B5AC71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDWY-0003UL-5Z; Mon, 16 Jun 2025 13:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRDWU-0003SU-LZ
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRDWP-0001pD-54
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750094480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i3YG34OwSmdTbAi3CoctFDyw1Z9YTSyzMCOVL+GB2cg=;
 b=ftEMmK8u+1H/uklyBpYvB3lkq6hsTrLesm2n+6jEahtirdfSioKQkHWaD/k1c3IyI0PkZP
 6UytnwIkLwOVLebMMdw4U9fqC3SYF0wZHQP4IXhRSMEAr6+rFZNsecVME7P8Y402nps/U/
 Zr5TIgM72qXrFI0eNBEZnFNoUXzCce0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-9-t2lZ0POSSzJ1t9urQgHQ-1; Mon,
 16 Jun 2025 13:21:16 -0400
X-MC-Unique: 9-t2lZ0POSSzJ1t9urQgHQ-1
X-Mimecast-MFC-AGG-ID: 9-t2lZ0POSSzJ1t9urQgHQ_1750094475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DA3D1956086; Mon, 16 Jun 2025 17:21:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9C8D180045B; Mon, 16 Jun 2025 17:21:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v3 0/1] Tracing patches
Date: Mon, 16 Jun 2025 13:21:11 -0400
Message-ID: <20250616172112.428142-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

The following changes since commit a6f02277595136832c9e9bcaf447ab574f7b1128:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-06-12 14:16:11 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 9761ad5f65d23f080b5a3479e52196fbce2e1506:

  meson: fix Windows build (2025-06-16 13:16:27 -0400)

----------------------------------------------------------------
Pull request

Oleg's v4 Windows build fix.

----------------------------------------------------------------

oltolm (1):
  meson: fix Windows build

 contrib/plugins/meson.build         |  2 +-
 plugins/meson.build                 |  2 +-
 scripts/tracetool/__init__.py       | 15 ++++++++++++---
 scripts/tracetool/backend/ftrace.py |  4 +---
 scripts/tracetool/backend/log.py    |  4 +---
 scripts/tracetool/backend/syslog.py |  4 +---
 tests/functional/meson.build        |  2 +-
 tests/include/meson.build           |  2 +-
 tests/tcg/plugins/meson.build       |  2 +-
 trace/meson.build                   |  5 +++--
 10 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.49.0


