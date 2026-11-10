Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFE606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M6xt6bk6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnq4-0000ZY-Eb; Tue, 10 Nov 2026 10:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQnot-0000KP-3P
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQnop-0004MZ-H7
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794324689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NFAYp6H+1eT7IXkoCM/UsMFHZ0N4vkEeB9u6PbTrSq0=;
 b=M6xt6bk6GhkDNuxqSQptx7lSW4RDCnwYYbyG6pckPExJHsqXkAGBzrlc8KekWG8t+16uQ2
 tyQxLR/3IA+2k/L0pHHYoXSXGVnLL59j318ng9Fz6lB8cFlYtgV0V/hxI1SGSSUjVmVn8P
 F5Ggx/ypdW7D3HRmDKwBSus/BS8049c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-a8ACEbYwNGWgL0JyEOseiQ-1; Tue,
 10 Nov 2026 10:31:26 -0500
X-MC-Unique: a8ACEbYwNGWgL0JyEOseiQ-1
X-Mimecast-MFC-AGG-ID: a8ACEbYwNGWgL0JyEOseiQ_1794324685
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D200D195606B; Tue, 10 Nov 2026 15:31:24 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 532E53001DA9; Tue, 10 Nov 2026 15:31:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, berrange@redhat.com,
 stefanha@redhat.com
Subject: [PATCH for-11.2 v3 0/6] Fix some low-severity NBD CVEs
Date: Tue, 10 Nov 2026 09:30:00 -0600
Message-ID: <20261110153121.1516536-8-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since v2 (https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg01673.htm\
l):
- Tweak the documentation in patch 1 again [Stefan, Dan]
- Improve unit tests, and pass pylint iotest 297 (new patch 2, also patch 4, 6)
- Retain assertion at safer point for first bug (patch 3)
- Second CVE addressed as well (patch 5, 6)

Eric Blake (6):
  docs: Mention security considerations for NBD
  iotests: Refactor python NBD server setup
  nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
  iotests: Add new nbd-robustness test
  nbd/server: Reject rather than assert on non-compliant
    NBD_OPT_SET_META_CONTEXT
  iotests: Add another nbd-robustness test

 docs/system/security.rst                    |  23 +++
 nbd/server.c                                |  10 +-
 tests/qemu-iotests/iotests.py               |  30 +++
 tests/qemu-iotests/tests/nbd-multiconn      |  44 +----
 tests/qemu-iotests/tests/nbd-robustness     | 205 ++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-robustness.out |   5 +
 6 files changed, 279 insertions(+), 38 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-robustness
 create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out

-- 
2.56.0


