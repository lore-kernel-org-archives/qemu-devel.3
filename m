Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2021ED5E374
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVW2t-0005R6-8Q; Tue, 16 Dec 2025 09:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVW2n-0005Pb-AX
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVW2l-0002vq-S2
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765895330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xmjzHprwtvq0g0JWLgbSX1NXuEK5SyNhmLE172M/VIY=;
 b=KFIZo4rlPncbEzybM6o9zX8LtOCvXPdy+llofYfzMEXzpyWHdUzCdNr8V1PUCistTD6o0t
 Vu2l6juSbCxv3CeMjTfQb3g6xnI4lNmWttW8QOAoSdWvQ9AnICTwcV1GBPHT3+BBFpZUx8
 ZQjLiz7v7NRXC/zJhFLtNce040pYPNI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-lXkggbofPlCFTGXf4AYI4w-1; Tue,
 16 Dec 2025 09:28:48 -0500
X-MC-Unique: lXkggbofPlCFTGXf4AYI4w-1
X-Mimecast-MFC-AGG-ID: lXkggbofPlCFTGXf4AYI4w_1765895327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 288C31801218; Tue, 16 Dec 2025 14:28:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5AC019560A7; Tue, 16 Dec 2025 14:28:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/4] glibc queue
Date: Tue, 16 Dec 2025 15:28:39 +0100
Message-ID: <20251216142843.519084-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Richard,

In case there is still time, 

Thanks,

C. 



The following changes since commit 9c23f2a7b0b45277693a14074b1aaa827eecdb92:

  Update version for v10.2.0-rc3 release (2025-12-09 16:44:49 -0600)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-glibc-20251216

for you to fetch changes up to d7e1df769910da9d832dda86b01fe1363e4f4a3c:

  gdbstub: Fix const qualifier build errors with recent glibc (2025-12-16 14:28:30 +0100)

----------------------------------------------------------------
Fix const qualifier build errors with recent glibc

----------------------------------------------------------------
Cédric Le Goater (4):
      i386: Fix const qualifier build errors with recent glibc
      tests/vhost-user-bridge.c: Fix const qualifier build errors with recent glibc
      monitor: Fix const qualifier build errors with recent glibc
      gdbstub: Fix const qualifier build errors with recent glibc

 gdbstub/user.c            |  2 +-
 hw/i386/x86-common.c      |  2 +-
 monitor/hmp.c             |  5 +++--
 tests/vhost-user-bridge.c | 10 ++++------
 4 files changed, 9 insertions(+), 10 deletions(-)


