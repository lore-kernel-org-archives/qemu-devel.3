Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B9ACFD649
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVYm-00048h-JV; Wed, 07 Jan 2026 10:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdVYi-00047Z-Vj
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdVYh-0002tw-DE
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767800090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ditq7sjo3TbiO5/KraCLd1Y5EBOnv+Tjoh8lbfO/okI=;
 b=PZIJ5+WRMsCXIb1BqIB16uoPxlf9xGnw40I/Q/W5zpAi8P92USf4UaZ1gS+G2tCP7a9TZ4
 dfgpRlukkxzV8dDkdMhBoIxfQ30jO/nmp/nLo2hunAjSNf6hnYx6hqJT/+zuN+wazp/ug9
 2xKcmkw9P2AB0swYu1hR+qzkFM/asLo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-aw-fQ5klNvmnz6JSkX5xMA-1; Wed,
 07 Jan 2026 10:34:46 -0500
X-MC-Unique: aw-fQ5klNvmnz6JSkX5xMA-1
X-Mimecast-MFC-AGG-ID: aw-fQ5klNvmnz6JSkX5xMA_1767800086
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B43E1956058; Wed,  7 Jan 2026 15:34:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.169])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F694180066A; Wed,  7 Jan 2026 15:34:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 zoudongjie@huawei.com
Subject: [PATCH 0/3] io: fix mem leak when using QIOTask in TLS and websock
 channels
Date: Wed,  7 Jan 2026 15:34:39 +0000
Message-ID: <20260107153442.1832957-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The handshake functions in the TLS and websock channels could leak
a QIOTask and some related data if the underlying channel was torn
down before the handshake completed. This also applies to the async
TLS "bye" tasks.

Fixing this required refactoring the QIOTask cleanup paradigm
slightly.

This is a followup to a proposed fix at

  https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02984.html

and also reported at

  https://gitlab.com/qemu-project/qemu/-/issues/3114

Daniel P. Berrangé (3):
  io: separate freeing of tasks from marking them as complete
  io: fix cleanup for TLS I/O source data on cancellation
  io: fix cleanup for websock I/O source data on cancellation

 include/io/task.h         | 29 +++++++++++++------
 io/channel-tls.c          | 60 ++++++++++++++++++++++++++-------------
 io/channel-websock.c      |  2 +-
 io/task.c                 |  8 ++++--
 tests/unit/test-io-task.c | 26 +++++++++++++++++
 5 files changed, 94 insertions(+), 31 deletions(-)

-- 
2.52.0


