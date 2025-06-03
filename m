Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BCC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLHC-00080r-CT; Tue, 03 Jun 2025 02:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGa-0007jN-Fm
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGY-0003Qo-Cl
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gpg3vdZ3PvS7+R/IUoijCuTXscOnZ1Hsev+Bz8St4b8=;
 b=L/M4gohsX3tz7ylr/8fWEkQmaIP9ayfbp8mpp52Z4GoB19EAC9fHCErTRC5nKtikD7YuVI
 ayaCqRHUz/3W4/zCvR4u+VLkOGuUVVfV3qusa6nSXUa7Yoho2AmcobpvCXcolXlr798kWn
 STIo3o5xMV9SwGgoxU7Ab10sj+Xe15U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-dPsM8nTyNGqDsnIIycv9DQ-1; Tue,
 03 Jun 2025 02:36:49 -0400
X-MC-Unique: dPsM8nTyNGqDsnIIycv9DQ-1
X-Mimecast-MFC-AGG-ID: dPsM8nTyNGqDsnIIycv9DQ_1748932608
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 430CF18004A7
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9AA430002C4
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF96A21E6766; Tue, 03 Jun 2025 08:36:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/13] QAPI patches patches for 2025-06-03
Date: Tue,  3 Jun 2025 08:36:31 +0200
Message-ID: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6322b753f798337835e205b6d805356bea582c86:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-06-02 14:52:45 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-06-03

for you to fetch changes up to 8fa2020647041e9f01bc308589bb7fa00355ac9b:

  qapi: Improve documentation around job state @concluded (2025-06-03 08:34:57 +0200)

----------------------------------------------------------------
QAPI patches patches for 2025-06-03

----------------------------------------------------------------
Markus Armbruster (13):
      qapi: Tidy up run-together sentences in doc comments
      qapi: Tidy up whitespace in doc comments
      qapi: Move (since X.Y) to end of description
      qapi: Avoid breaking lines within (since X.Y)
      qapi: Drop a problematic (Since: 2.11) from query-hotpluggable-cpus
      qapi: Correct spelling of QEMU in doc comments
      qapi: Fix capitalization in doc comments
      qapi: Use proper markup instead of CAPS for emphasis in doc comments
      qapi: Spell JSON null correctly in blockdev-reopen documentation
      qapi: Refer to job-FOO instead of deprecated block-job-FOO in docs
      qapi: Mention both job-cancel and block-job-cancel in doc comments
      qapi: Tidy up references to job state CONCLUDED
      qapi: Improve documentation around job state @concluded

 qapi/acpi.json         |   2 +-
 qapi/audio.json        |   8 +--
 qapi/block-core.json   | 184 ++++++++++++++++++++++++-------------------------
 qapi/block-export.json |   6 +-
 qapi/block.json        |   2 +-
 qapi/char.json         |   8 +--
 qapi/crypto.json       |  21 +++---
 qapi/cryptodev.json    |   2 +-
 qapi/cxl.json          |   2 +-
 qapi/dump.json         |   6 +-
 qapi/introspect.json   |   8 +--
 qapi/job.json          |  28 ++++----
 qapi/machine.json      |  14 ++--
 qapi/migration.json    | 100 +++++++++++++--------------
 qapi/misc-i386.json    |   2 +-
 qapi/misc.json         |   4 +-
 qapi/net.json          |  18 ++---
 qapi/qom.json          |   2 +-
 qapi/run-state.json    |  12 ++--
 qapi/transaction.json  |   4 +-
 qapi/uefi.json         |   2 +-
 qapi/ui.json           |   8 +--
 22 files changed, 219 insertions(+), 224 deletions(-)

-- 
2.48.1


