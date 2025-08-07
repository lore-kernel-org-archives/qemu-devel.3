Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45458C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 11:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujz8W-0008Ay-GW; Thu, 07 Aug 2025 07:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8T-000838-9Y
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8Q-00028c-QW
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754567412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zo+wC25YBWMitf2bIY77Zy3nIGahnoOZYXrBVF79dak=;
 b=ZDAxPzddjDWnQ5x2cYsIPWE4nd90NeIygsSC9AzRpPCpOkHu7p7Z9vS6SIGiiUj7+X38SY
 bHso1Gp9GL4iGEiqnuFUcS0ct8MO4dv+QYbHnSSb4mJZ74q6DRBm+R8jiTNU57RBfCyI7B
 K4ynh2y33Bwlb+RYpDS2CiWyTOTN7Yk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-bY6efB1RNPakikI365UOAw-1; Thu,
 07 Aug 2025 07:50:11 -0400
X-MC-Unique: bY6efB1RNPakikI365UOAw-1
X-Mimecast-MFC-AGG-ID: bY6efB1RNPakikI365UOAw_1754567410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC1DA19560B4; Thu,  7 Aug 2025 11:50:09 +0000 (UTC)
Received: from fedora (unknown [10.43.3.128])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CF0019560AD; Thu,  7 Aug 2025 11:50:07 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability and
 state
Date: Thu,  7 Aug 2025 13:49:08 +0200
Message-ID: <20250807114922.1013286-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When postcopy migration starts, the source side sends all
non-postcopiable device data in one package command and immediately
transitions to a "postcopy-active" state. However, if the destination
side fails to load the device data or crashes during it, the source side
stays paused indefinitely with no way of recovery.

This series introduces a new "postcopy-setup" state during which the
destination side is guaranteed to not been started yet and, the source
side can recover and resume and the destination side gracefully exit.

Key element of this feature is isolating the postcopy-run command from
non-postcopiable data and sending it only after the destination side
acknowledges, that it has loaded all devices and is ready to be started.
This is necessary, as once the postcopy-run command is sent, the source
side cannot be sure if the destination is running or not and if it can
safely resume in case of a failure.

Reusing existing ping/pong messages was also considered, PING 3 is right
before the postcopy-run command, but there are two reasons why the PING
3 message might not be delivered to the source side:

1. destination machine failed, it is not running, and the source side
   can resume,
2. there is a network failure, so PING 3 delivery fails, but until until
   TCP or other transport times out, the destination could process the
   postcopy-run command and start, in which case the source side cannot
   resume.

Furthermore, this series contains two more patches required for the
implementation of this feature, that make the listen thread joinable for
graceful cleanup and detach it explicitly otherwise, and one patch
fixing state transitions inside postcopy_start().

Such (or similar) feature could be potentially useful also for normal
(only precopy) migration with return-path, to prevent issues when
network failure happens just as the destination side shuts the
return-path. When I tested such scenario (by filtering out the SHUT
command), the destination started and reported successful migration,
while the source side reported failed migration and tried to resume, but
exited as it failed to gain disk image file lock.

Another suggestion from Peter, that I would like to discuss, is that
instead of introducing a new state, we could move the boundary between
"device" and "postcopy-active" states to when the postcopy-run command
is actually sent (in this series boundary of "postcopy-setup" and
"postcopy-active"), however, I am not sure if such change would not have
any unwanted implications.

Juraj Marcin (4):
  qemu-thread: Introduce qemu_thread_detach()
  migration: Fix state transition in postcopy_start() error handling
  migration: Make listen thread joinable
  migration: Introduce postcopy-setup capability and state

 include/qemu/thread.h                  |  1 +
 migration/migration.c                  | 77 +++++++++++++++++++++++---
 migration/migration.h                  |  7 +++
 migration/options.c                    | 16 ++++++
 migration/options.h                    |  1 +
 migration/postcopy-ram.c               |  7 +++
 migration/savevm.c                     | 53 ++++++++++++++++--
 qapi/migration.json                    | 19 ++++++-
 tests/qtest/migration/postcopy-tests.c | 55 ++++++++++++++++++
 tests/qtest/migration/precopy-tests.c  |  3 +-
 util/qemu-thread-posix.c               |  8 +++
 util/qemu-thread-win32.c               | 10 ++++
 12 files changed, 241 insertions(+), 16 deletions(-)

-- 
2.50.1


