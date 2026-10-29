Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F1606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRMDaesd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTGH-0003fJ-Ma; Thu, 29 Oct 2026 12:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMTFz-0003dM-Qj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMTFy-00049D-0t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793292336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ODKuqU6Zpxo63dkzeMgC0YQBL59VRxYj8Q0j7MlLE7w=;
 b=PRMDaesd8FQXZ7iamnVbzTUu0xHQSQUSYeJKIW81egHj2j87AbHHzzxuv8IQvesKzRw8YM
 bL701KVu/7Ha5uoCnmHweF7iUwgdC6HByMHW/ZNA0TZpgTgBSGbpysIVvU4N2/HfvbD46+
 EwhFCai9/G+Hl5ZG4vkRO4J3nXzhKL4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-guKuL6-QNaytKjY0hgEdZQ-1; Thu,
 29 Oct 2026 12:45:33 -0400
X-MC-Unique: guKuL6-QNaytKjY0hgEdZQ-1
X-Mimecast-MFC-AGG-ID: guKuL6-QNaytKjY0hgEdZQ_1793292332
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B4B719560A3; Thu, 29 Oct 2026 16:45:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.61])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1482B1800257; Thu, 29 Oct 2026 16:45:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, afaria@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] file-posix: Add 'accept-read-only-device' option
Date: Thu, 29 Oct 2026 17:45:20 +0100
Message-ID: <20261029164522.103918-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

v2:
- Fix the test case to filter the loop device name [Eric]
- Use printf instead of echo -e [Eric]

Kevin Wolf (2):
  file-posix: Add 'accept-read-only-device' option
  iotests: Add loop-accept-ro-dev test

 qapi/block-core.json                          | 19 +++-
 block/file-posix.c                            | 23 ++++-
 tests/qemu-iotests/tests/loop-accept-ro-dev   | 88 +++++++++++++++++++
 .../qemu-iotests/tests/loop-accept-ro-dev.out | 19 ++++
 4 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/loop-accept-ro-dev
 create mode 100644 tests/qemu-iotests/tests/loop-accept-ro-dev.out

-- 
2.56.0


