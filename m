Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CA9E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCWQ-0004m9-Kn; Tue, 07 Jan 2025 11:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tVCWO-0004lu-Gd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tVCWM-0003vZ-O0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736267613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8La18x65SlhSXGi7lq01HsPtiMQ1AyW0BRa7SBRXjhM=;
 b=aceIlarwiQEkLwfSFXcaLcg1V5JemLIKWzLIhfzDbBHhZ71U+HeEaq5LyyHOadb4waLsxl
 9iIXIn1ZVc62/Rrh7tYQ1qC5vJogwBzLt6c4maSeP//Mnjeu/UJddQ03FAtCe8Mbln+DIr
 JJdTLlSMvQPfrsho2lWh3F9W8+eQk0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-h-gGuYAaPRq6Nb8vr-AjHA-1; Tue,
 07 Jan 2025 11:32:25 -0500
X-MC-Unique: h-gGuYAaPRq6Nb8vr-AjHA-1
X-Mimecast-MFC-AGG-ID: h-gGuYAaPRq6Nb8vr-AjHA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADA4D1955F06; Tue,  7 Jan 2025 16:32:23 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.131])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCFAB195606B; Tue,  7 Jan 2025 16:32:21 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/2] test/qtest/migration: Use out-of-band execution for
 migrate-recover
Date: Tue,  7 Jan 2025 17:31:52 +0100
Message-ID: <20250107163156.310226-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In real use cases, the migrate-recover command requires out-of-band
execution, because the main thread processing normal commands is blocked
by a page fault in the guest memory. Tests, however, do not reflect this
which might result in some bugs not being caught with tests.

The first patch in the series, adds a new qtest initialization function
which accepts capabilities the test wants to enable. This allows a test
to enable the oob capability.

The second patch then enables the oob capability in migration tests and
changes the execution of the migrate-recover command.

Juraj Marcin (2):
  tests/qtest: Introduce qtest_init_with_env_and_capabilities()
  tests/qtest/migration: Use out-of-band execution for migrate-recover

 tests/qtest/libqtest.c                | 18 ++++++++++++++++--
 tests/qtest/libqtest.h                | 17 +++++++++++++++++
 tests/qtest/migration/framework.c     | 23 +++++++++++++++++++++--
 tests/qtest/migration/framework.h     |  2 ++
 tests/qtest/migration/migration-qmp.c |  2 +-
 5 files changed, 57 insertions(+), 5 deletions(-)

-- 
2.47.1


