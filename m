Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77193606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cX0vrnbG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWrE7-0005Wy-Ds; Fri, 27 Nov 2026 03:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWrE5-0005VL-JE
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWrE3-0004TQ-Vx
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795767756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cx2E0zrQ/AbNQ7pR03iowTQZU0+AX37njX2a+PAGHvY=;
 b=cX0vrnbGwXSiCPdy7lfgxrqNVFgUWGDKnW20dmsqUgnzkKaMItjcjLkrV9FD7PK/weTqaw
 7gauA+xXO1c1i7oM4jz05EMOCZUgV902zrB5KKv1yUlzuHy8ztQEurxO6Wkmx8p9MGDoy2
 5kqz4H1RSSnt69JgtaD2sAB9eb+Fdbo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-3ucApVzPPD-Sk8d3I96npQ-1; Fri,
 27 Nov 2026 08:22:32 +0000
X-MC-Unique: 3ucApVzPPD-Sk8d3I96npQ-1
X-Mimecast-MFC-AGG-ID: 3ucApVzPPD-Sk8d3I96npQ_1795767751
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90F111800592; Fri, 27 Nov 2026 08:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 521AA30000D3; Fri, 27 Nov 2026 08:22:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A29BB21E6A04; Fri, 27 Nov 2026 09:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/4] QAPI patches for 2026-11-27
Date: Fri, 27 Nov 2026 09:22:24 +0100
Message-ID: <20261127082228.3907768-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 9751c62358073580cbf330a4df22077a7c6a407c:

  Update version for v11.2.0-rc2 release (2026-11-25 21:39:27 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-11-27

for you to fetch changes up to e71c246816ebb43a0994b472155d99e0bd472927:

  qom: Really add 'confidential-guest-reset' feature (2026-11-27 09:03:00 +0100)

----------------------------------------------------------------
QAPI patches for 2026-11-27

----------------------------------------------------------------
Markus Armbruster (4):
      tests/qmp-cmd-test: Simplify @qapi-type test
      python/qemu: Don't choke on unknown members in QMP replies
      file-posix: Fix loss of QAPI feature 'dynamic-auto-read-only'
      qom: Really add 'confidential-guest-reset' feature

 qapi/block-core.json            | 14 +++++++++++++-
 qapi/qom.json                   | 24 +++++++++++++++---------
 tests/qtest/qmp-cmd-test.c      |  3 +--
 python/qemu/utils/qom_common.py |  4 +---
 4 files changed, 30 insertions(+), 15 deletions(-)

Markus Armbruster (4):
  tests/qmp-cmd-test: Simplify @qapi-type test
  python/qemu: Don't choke on unknown members in QMP replies
  file-posix: Fix loss of QAPI feature 'dynamic-auto-read-only'
  qom: Really add 'confidential-guest-reset' feature

 qapi/block-core.json            | 14 +++++++++++++-
 qapi/qom.json                   | 24 +++++++++++++++---------
 tests/qtest/qmp-cmd-test.c      |  3 +--
 python/qemu/utils/qom_common.py |  4 +---
 4 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.55.0


