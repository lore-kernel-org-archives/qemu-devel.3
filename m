Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25675CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 12:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJTt-00061B-C1; Wed, 10 Sep 2025 07:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uwJTW-0005rh-5T
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:59:00 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uwJT4-0001wd-0m
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:58:55 -0400
Received: from localhost.localdomain (unknown [10.101.192.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8FB323F4BC
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1757505504;
 bh=zUWhMoQjR8jSieQ2e6nnxVq9Tr74de30lwSWicVIlCI=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gAXpNLkzVZKeXlzxOTBtihlpJCRZ+OEQ+aGAEMnYwbEANKObLGJe+x7WpK5IETd1g
 os7JRxYqUsSEyxLwJlFVXhJ+VgN5vs3hU9CKPyV3gph07miV1CN38ercL/pj5iLpBT
 bVLcF/KsmKvOVd47Qk7C3SW24QjhNQv8xgIGrz7TkuDdjfIdT7iVTCJ021Odx5YMih
 b9L7ztzPK1SYGuWQ0M4df1Ny4QgnTV9S3sGdhkFg4JiIFLMR3s8r1Kqo35vccFTV+Z
 5XK6thtHViupulTWOt7KmS6H+oLvve/h+gOKckw/4hMY/5Vdw6kqpUQ8n2S9wab33Z
 i1EURSd48AnHg==
From: Hector Cao <hector.cao@canonical.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/2] Fix cross migration issue with missing features: pdcm,
 arch-capabilities
Date: Wed, 10 Sep 2025 13:57:31 +0200
Message-ID: <20250910115733.21149-1-hector.cao@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

Since it is a blocking issue for us, we went further and ended up with a solution along [1]
that allows us to get out of this situation.

The idea is to add compatibility properties to restore legacy behaviors for machine types
with older versions of QEMU (<10.1). 2 compatiblity properties have been added to address
respectively the 2 missing features, each one is done in a separate patch.

We know that 10.1 has been released and it's final, but working on a solution towards 11.0
would allow everyone to settle on the fix and even consider backporting where not yet released
like Ubuntu 25.10 for us.

It is important to have upstream support going forward in this or any other way
and therefore reach out with this RFC to ask you to think about it with us.

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migration/compatibility.rst

Hector Cao (2):
  target/i386: add compatibility property for arch_capabilities
  target/i386: add compatibility property for pdcm feature

 hw/core/machine.c     |  2 ++
 migration/migration.h | 23 +++++++++++++++++++++++
 migration/options.c   |  6 ++++++
 target/i386/cpu.c     | 17 ++++++++++++++---
 target/i386/kvm/kvm.c |  5 ++++-
 5 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.45.2


