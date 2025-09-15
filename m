Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8152CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7sF-000444-Av; Mon, 15 Sep 2025 07:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7sD-00043r-20
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7s1-0004XN-7G
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757937574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YKxxr1aAGMcwsDzcJcO34DISHVtV7lfdxHN3ORGIM6g=;
 b=WJfHKaZJvGUPAVrz2/4qz4CiVMOBp0qAWxNz93QsIBkVtqvwkCKsLuE+7qUyiPpTLpO3xr
 vv1NgvMzI7w5V9Er3WIFu+dSbTLW6wBScvKjBxGvVEzvbd1zFTshVPRs927qTVxwC4uD70
 0hd22cF2z32dW0m+Q6A1fMVIUAdFuB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-XF9gFwKdPmaFvYgqVDh6bQ-1; Mon,
 15 Sep 2025 07:59:30 -0400
X-MC-Unique: XF9gFwKdPmaFvYgqVDh6bQ-1
X-Mimecast-MFC-AGG-ID: XF9gFwKdPmaFvYgqVDh6bQ_1757937569
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 721341955EAC; Mon, 15 Sep 2025 11:59:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.193])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4A771954126; Mon, 15 Sep 2025 11:59:26 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/4] migration: Introduce POSTCOPY_DEVICE state
Date: Mon, 15 Sep 2025 13:59:11 +0200
Message-ID: <20250915115918.3520735-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series is a continuation of the following RFC series and its
discussion [1].

[1]: https://lore.kernel.org/all/20250807114922.1013286-1-jmarcin@redhat.com/

This series takes a different approach to source side recoverability
than the original RFC series, it uses existing PING/PONG message types.
Although, such approach has some theoretical race conditions, when
discussed we came to a conclusion that in practice there is a very, very
slim chance if any for it to happen. On the other hand, this approach
doesn't require any changes in the migration protocol nor the
destination side QEMU instance to be functional.

In preparation for the state introduction, this series contains few
changes.

First, it includes a patch suggested by Peter, which adds a check to
block device activation when the source side tries to resume after a
failed migration.

Next, it refactors cleanup and error handling on the destination side.
This change is not strictly necessary for the feature to work. Without
this patch, if device state load failed, the destination QEMU would
either exit with an error exit code from the listen thread, or it might
crash if the main thread does some cleanup before the listen thread
exits the process. However, the source side can recover regardless of
how the destination side fails.

Finally, the last patch contains the main feature, the POSTCOPY_DEVICE
state. Compared to the approach discussed in the RFC, it uses a new PING
message with custom PING number. The reason behind that is, that the
PING 3 message is now sent only when postcopy-ram is active, but there
might be postcopy scenarios when this isn't true. The destination side
can respond to this new PING message without any changes required.

As this change introduces a new migration state, I have also tested it
with libvirt. Apart from a warning about an unknown migration state
received in an event, migration finishes without any issues.

Juraj Marcin (3):
  migration: Accept MigrationStatus in migration_has_failed()
  migration: Refactor incoming cleanup into migration_incoming_finish()
  migration: Introduce POSTCOPY_DEVICE state

Peter Xu (1):
  migration: Do not try to start VM if disk activation fails

 migration/migration.c                 | 124 +++++++++++++++++---------
 migration/migration.h                 |   3 +-
 migration/multifd.c                   |   2 +-
 migration/savevm.c                    |  48 ++++------
 migration/savevm.h                    |   2 +
 migration/trace-events                |   1 +
 qapi/migration.json                   |   8 +-
 tests/qtest/migration/precopy-tests.c |   3 +-
 8 files changed, 112 insertions(+), 79 deletions(-)

-- 
2.51.0


