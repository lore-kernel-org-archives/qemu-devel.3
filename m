Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D562FC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4HzV-0008BQ-Ay; Wed, 09 Sep 2026 09:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4HwG-0007Sk-Tw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4HwC-0000xB-0C
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788958922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fG/VZT9CKqIlbY1q7dW+5I9tUbZVNc+jlNU+M6BEZZ0=;
 b=it3z4HM0TSARp6GcGVoqkt+5lEeGladVQgT1qieJnPwqkCi6hS36hAx8AwYe2mY+gxB7hh
 efddHza/OZMhJyampNC4KDwd/l40ZpHlO0kNOpDtGBuo+BfZn4eGMocNVRXXjOcdWpt36/
 Ht1VfJ122YTfsdgWItLvHWQKWHKAyZg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-zQkv2Xj-ODWYH7KBUrYBZg-1; Wed,
 09 Sep 2026 08:59:53 -0400
X-MC-Unique: zQkv2Xj-ODWYH7KBUrYBZg-1
X-Mimecast-MFC-AGG-ID: zQkv2Xj-ODWYH7KBUrYBZg_1788958792
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59071800848; Wed,  9 Sep 2026 12:59:52 +0000 (UTC)
Received: from Alexs-MacBook-Air.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACC713000218; Wed,  9 Sep 2026 12:59:49 +0000 (UTC)
From: Alex Fishman <afishman@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, Alex Fishman <afishman@redhat.com>
Subject: [PATCH v1 0/2] vhost: Handle vrings crossing virtio-mem slots
Date: Wed,  9 Sep 2026 15:59:21 +0300
Message-ID: <20260909125923.75340-1-afishman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afishman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Sep 2026 09:05:26 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Virtio-mem dynamic memslots are intentionally exposed as separate memory
regions. If a guest places a vring part across two adjacent slots, a later
memory update fails vhost ring verification because the complete ring part
is not contained in one vhost memory region.

Coalesce coherent adjacent sections only when a descriptor table,
available ring, or used ring crosses their boundary. Unrelated
unmergeable sections remain separate so they can still be updated
independently.

Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user
backend and virtio-mem dynamic memslots. It also verifies that a newly
activated slot is not folded into the merge required by the crossing
vring.

Tested with the vhost-user/mem-slots/boundary qtest.

Buglink: https://redhat.atlassian.net/browse/RHEL-146583

Alex Fishman (2):
  vhost: coalesce unmergeable sections across vring boundaries
  tests/qtest: Add vhost-user memslot boundary test

 hw/virtio/vhost.c             |  72 ++++++-
 tests/qtest/vhost-user-test.c | 395 +++++++++++++++++++++++++++++++++-
 2 files changed, 452 insertions(+), 15 deletions(-)


base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
-- 
2.52.0


