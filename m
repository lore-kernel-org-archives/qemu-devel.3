Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A145606A882
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R0lExoI8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsKT-0000Cq-8B; Fri, 13 Nov 2026 09:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRsJa-00082D-G6
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRsJY-0007GU-Q1
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LDcSC9dxlyZYVq5EgJWC/JtT2uC01T/e+UsVobUUADA=;
 b=R0lExoI81dCcJHRPP3Nz8tvCHjCrkixNDAAgsgZLIAMIhps9Ax6QqRDu03zYsisRBYjbEw
 AdPfZYtxzKp3YtKpl3g2WShuBuBnPHBErVLY1pu9cQ31wSb2ROsmGkJo4gsUeg4S7M++13
 NcHp3rSruCO+IBksZRPbqG4S9wht+AA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-7fHTTeSvNKqOVt9EJT9U_w-1; Fri,
 13 Nov 2026 09:31:38 -0500
X-MC-Unique: 7fHTTeSvNKqOVt9EJT9U_w-1
X-Mimecast-MFC-AGG-ID: 7fHTTeSvNKqOVt9EJT9U_w_1794580298
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBA1E1955F30
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 14:31:37 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67C6544B
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 14:31:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/6] NBD patches through 2026-11-10
Date: Fri, 13 Nov 2026 08:30:28 -0600
Message-ID: <20261113143132.2414774-8-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4bcd55a1f4b926ae86872087f7f3bc9f9e1d065e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-11-12 21:14:41 -0700)

are available in the Git repository at:

  https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-10-v2

for you to fetch changes up to e682c0e570179bd7fa01ea896358a8cdad196a3b:

  iotests: Add another nbd-robustness test (2026-11-13 08:02:09 -0600)

In v2, defer Guillame's patches (the bug was minor, and the unit test
to verify the bug fix was flaky) to a later date

----------------------------------------------------------------
NBD patches through 2026-11-10

A few bug fixes:
- Eric Blake: fix two low-severity CVEs with non-compliant NBD clients

----------------------------------------------------------------
Eric Blake (6):
      docs: Mention security considerations for NBD
      iotests: Refactor python NBD server setup
      nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
      iotests: Add new nbd-robustness test
      nbd/server: Reject rather than assert on non-compliant NBD_OPT_SET_META_CONTEXT
      iotests: Add another nbd-robustness test

 docs/system/security.rst                    |  23 ++++
 nbd/server.c                                |  10 +-
 tests/qemu-iotests/iotests.py               |  30 ++++
 tests/qemu-iotests/tests/nbd-multiconn      |  44 ++----
 tests/qemu-iotests/tests/nbd-robustness     | 205 ++++++++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-robustness.out |   5 +
 6 files changed, 279 insertions(+), 38 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-robustness
 create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out

-- 
2.56.0


