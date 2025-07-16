Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A2C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5t7-00032d-JW; Wed, 16 Jul 2025 13:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t4-0002wE-GF
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t0-00086a-Bh
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752686740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fYeyK+VEqr0Q20rlyP50lsboJzuwGFKgqxwOYjNj9Lc=;
 b=UJ2c9ha4vpZSOxcJaVXjqo+XEDZeHqH/x0QyHhhuW11krjc0w9EdJ653ptgRtrWh74+Anf
 XO82ssVY32Q19EuE9iSWxUlSuIb64P4e+tpH0F7J70Em6zIZcSM0yB/W3218GrLaW19C3f
 I3WHhsJmu1EW8P0OYIL0vchl33hUQZ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-9D9OqbEWN0CHLjYOp1rqxg-1; Wed,
 16 Jul 2025 13:25:39 -0400
X-MC-Unique: 9D9OqbEWN0CHLjYOp1rqxg-1
X-Mimecast-MFC-AGG-ID: 9D9OqbEWN0CHLjYOp1rqxg_1752686738
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 774C8195608C
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:25:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22B2919560AB
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:25:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E30E21E6A27; Wed, 16 Jul 2025 19:25:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/6] QAPI patches patches for 2025-07-16
Date: Wed, 16 Jul 2025 19:25:29 +0200
Message-ID: <20250716172535.3520175-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f96b157ebb93f94cd56ebbc99bc20982b8fd86ef:

  Merge tag 'accel-20250715' of https://github.com/philmd/qemu into staging (2025-07-16 07:13:40 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-07-16

for you to fetch changes up to 64e4375b2b1efb634876a119a7378c50be5d195b:

  python: fix editable installs for modern pip/setuptools (2025-07-16 19:04:02 +0200)

----------------------------------------------------------------
QAPI patches patches for 2025-07-16

----------------------------------------------------------------
Akihiko Odaki (2):
      docs: Bump sphinx to 6.2.1
      MAINTAINERS: Add docs/requirements.txt

John Snow (1):
      python: fix editable installs for modern pip/setuptools

Steve Sistare (3):
      qom: qom-list-get
      python: use qom-list-get
      tests/qtest/qom-test: unit test for qom-list-get

 MAINTAINERS                     |   1 +
 docs/requirements.txt           |   4 +-
 qapi/qom.json                   |  50 +++++++++++++++++
 qom/qom-qmp-cmds.c              |  53 ++++++++++++++++++
 tests/qtest/qom-test.c          | 116 +++++++++++++++++++++++++++++++++++++++-
 python/Makefile                 |   4 +-
 python/qemu/utils/qom.py        |  45 +++++++++-------
 python/qemu/utils/qom_common.py |  55 +++++++++++++++++++
 pythondeps.toml                 |   4 +-
 9 files changed, 305 insertions(+), 27 deletions(-)

-- 
2.49.0


