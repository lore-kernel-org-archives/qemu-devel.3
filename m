Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92F606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rwjr6cco
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7BL-00030J-4u; Wed, 28 Oct 2026 13:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xM7BJ-0002zX-DC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xM7BI-0003F6-3V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3kDkC7Bh7WpXC3NaseDagpbQ9cCEu5wJZ9dwN2/CCi0=;
 b=Rwjr6ccomSw6oG3DdZC9udU6Bpw5fEmXADDy6LjaJ3QyfuW0ZCwdfWgUHOgicWkJae8Nm5
 CEriOkYTs4bPFoXyeHaInlLKHmKqoYEJYwcp5mPgjnl5tZwEHXC/leOlLSIgMNImj01KHB
 h0Z9XaiW+YTuxIh5+oRhxpvNBAifelk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-G381-b8IMBelJcZ1kzIwVA-1; Wed,
 28 Oct 2026 13:11:12 -0400
X-MC-Unique: G381-b8IMBelJcZ1kzIwVA-1
X-Mimecast-MFC-AGG-ID: G381-b8IMBelJcZ1kzIwVA_1793207471
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCAC318052FD; Wed, 28 Oct 2026 17:11:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDE9C1800446; Wed, 28 Oct 2026 17:11:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, afaria@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] file-posix: Add 'accept-read-only-device' option
Date: Wed, 28 Oct 2026 18:10:55 +0100
Message-ID: <20261028171057.139326-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf (2):
  file-posix: Add 'accept-read-only-device' option
  iotests: Add loop-accept-ro-dev test

 qapi/block-core.json                          | 19 +++-
 block/file-posix.c                            | 23 ++++-
 tests/qemu-iotests/tests/loop-accept-ro-dev   | 87 +++++++++++++++++++
 .../qemu-iotests/tests/loop-accept-ro-dev.out | 19 ++++
 4 files changed, 144 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/loop-accept-ro-dev
 create mode 100644 tests/qemu-iotests/tests/loop-accept-ro-dev.out

-- 
2.56.0


