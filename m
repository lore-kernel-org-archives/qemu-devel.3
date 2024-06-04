Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DE9C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9a-0006ZG-M8; Tue, 04 Jun 2024 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9Z-0006Yp-Iz
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9X-0001Gp-Jr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uVQTtXIyPfCyaDBWQZoMDoZHGMmp1kxNuaC2u8SUcHg=;
 b=UL0xvaYxqdBlUjYi9QmbqiMQp5iXIauB4/F83P4qEFC6f2b7MTfPrHrkddGZTTctZcpXps
 NTGRga5dp0+R2nzQt/0V2rcp4y38QEIPh0W023diIIpxKAyByEZmHjRJ+Xb+WG/tSGBoVB
 TaNot+XkoYi4HKVm5VJnb3CMfsyQfKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-AN9uB7c9N72SJmfKRHpmmg-1; Tue, 04 Jun 2024 11:32:45 -0400
X-MC-Unique: AN9uB7c9N72SJmfKRHpmmg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED5CD101A520;
 Tue,  4 Jun 2024 15:32:44 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6EE492BCE;
 Tue,  4 Jun 2024 15:32:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/14] Improve mechanism for configuring allowed commands
Date: Tue,  4 Jun 2024 16:32:28 +0100
Message-ID: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The QGA supports dynamically filtering what commands are enabled via a
combination of allow lists and deny lists. This is very flexible, but
at the same time very fragile.

Consider that a user wants to block all commands that allow unrestricted
file access/command execution, so they set the deny list when starting
QGA. Now their OS vendor issues a software update which includes a new
version of QGA. This new QGA version is liable to contain new commands,
some of which might undermine the intent of the user's configured deny
list.

IOW, the generic deny list functionality is inherently dangerous as a
mechanism for limiting risk exposure.

Using an allow list is much safer, but means on every update the user
should check the list of new commands to decide which are safe or not,
putting a burden on every user.

In the context of RHEL, there has been a long term deny list that blocks
use of guest-file and guest-exec commands, since they give unrestricted
access to the guest.

With the advent of confidential computing, a far greater number of QGA
commands are very unsafe to permit, and it is unreasonable to expect
each user and/or downstream vendor to repeat the work to figure out
what commands are OK.

This is a similar problem seen in the "seccomp" world where new syscalls
appear frequently and users can't be expected to understand all of them.
Systemd pioneered the approach of defining "profiles"  which group
together sets of syscalls, which we subsequently copied in QEMU.

This series applies this same conceptual idea to QGA command filtering,
making use of the QAPI "features" facility to associate commands into
one or more groups.

This grouping is then exposed via some new higher level command line
arguments.

* --no-unrestricted / -u

  A flag to block all the guest-file and guest-exec commands

  This replicates the policy RHEL currently defines via a deny list.

* --no-user-auth / -e

  A flag to block all the commands for manipulating user account
  authentication credentials.

* --confidential / -i

  A flag to block all commands, except for those which have been
  explicitly marked as not violating guest owner data privacy

This feature mechanism is further utilized internally to track the
commands which are safe to use while FS are frozen.

A key benefit of using the QAPI "features" facility is that these
groupings are visible in the documentation of the QGA commands.

By using these high level command lines arguments, deployments will
be safe wrt software upgrades, as long as QEMU maintainers apply
appropriate tags to any new commands.

The allow/deny list command line flags can still be used to further
refine the command lines, but ideally that would be rare.

A missing piece in this series is getting the --confidential flag to
be automatically passed to QGA when running in a confidential VM. This
is something that will likely be done via systemd unit files. My thought
is that the existing 'qemu-guest-agent.service' would get a parameter

   ConditionSecurity=!cvm

while a new qemu-guest-agent-confidential.service' would have the same
content but with ConditionSecurity=cvm instead, and would pass the
--confidential flag.

This series depends on the one I sent earlier:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg00743.html

Daniel P. Berrangé (14):
  qapi: use "QAPI_FEATURE" as namespace for special features
  qapi: add helper for checking if a command feature is set
  qapi: cope with special feature names containing a '-'
  qapi: add a 'command-features' pragma
  qapi: stop hardcoding list of special features
  qapi: define enum for custom special features on commands
  qga: use special feature to mark those that can run when FS are frozen
  qga: add command line to limit commands for confidential guests
  qga: define commands which can be run in confidential mode
  qga: add command line to block unrestricted command/file access
  qga: mark guest-file-* commands with 'unrestricted' flag
  qga: mark guest-exec-* commands with 'unrestricted' flag
  qga: add command line to block user authentication commands
  qga: mark guest-ssh-* / guest-*-password commands with 'unrestricted'
    flag

 include/qapi/qmp/dispatch.h   |   1 +
 include/qapi/util.h           |   6 +-
 qapi/qapi-util.c              |   4 +-
 qapi/qmp-registry.c           |   5 +
 qapi/qobject-output-visitor.c |   4 +-
 qga/main.c                    |  66 ++++++---
 qga/qapi-schema.json          | 248 +++++++++++++++++++++++++++++++---
 scripts/qapi/commands.py      |  20 +++
 scripts/qapi/gen.py           |   2 +-
 scripts/qapi/parser.py        |   2 +
 scripts/qapi/schema.py        |  33 ++++-
 scripts/qapi/source.py        |   2 +
 12 files changed, 341 insertions(+), 52 deletions(-)

-- 
2.45.1


