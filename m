Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30730C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23GW-0007NW-AH; Tue, 08 Apr 2025 03:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fr-0007Dt-Px
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fj-0001YG-7H
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744096807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FsLkO88DmmBbj1+5XTKkba84TFNMAbsSAq5J3gLg2vU=;
 b=eIInTyUN1JqzLb+uEbKMZSW0kL1wxG5WAkCE1efQZXabpVU0wrUIUYMPy4u6bNnlqAWpML
 +zmKmImj1QV8Kk5ECLBvhYiW6CAB6ESM2n79txLQ7/L2NCYh1hAFtFxLUsbmShAEQxeQL+
 10fl1aytXty5HQJw/ekpcROFvB6KN8s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-qF7ePHLROIiX7UYSbGfl7A-1; Tue,
 08 Apr 2025 03:20:05 -0400
X-MC-Unique: qF7ePHLROIiX7UYSbGfl7A-1
X-Mimecast-MFC-AGG-ID: qF7ePHLROIiX7UYSbGfl7A_1744096804
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B259018007E1
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6869B18009BC
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E469621E6757; Tue, 08 Apr 2025 09:20:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/11] QAPI patches patches for 2025-04-08
Date: Tue,  8 Apr 2025 09:19:50 +0200
Message-ID: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed:

  Merge tag 'pull-riscv-to-apply-20250407-1' of https://github.com/alistair23/qemu into staging (2025-04-07 09:18:33 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-04-08

for you to fetch changes up to 8d41a7dfc2a8f21228b7f29314dd68ad0aa96d10:

  qga/qapi-schema: Add a proper introduction (2025-04-08 09:04:34 +0200)

----------------------------------------------------------------
QAPI patches patches for 2025-04-08

----------------------------------------------------------------
Markus Armbruster (11):
      docs/devel/qapi-code-gen: Tidy up whitespace
      qapi/rocker: Tidy up query-rocker-of-dpa-flows example
      docs/interop: Delete "QEMU Guest Agent Protocol Reference" TOC
      docs/interop: Sanitize QMP reference manuals TOC
      docs/devel/qapi-code-gen: Improve the part on qmp-example directive
      docs/sphinx/qmp_lexer: Generalize elision syntax
      docs/sphinx/qmp_lexer: Highlight elisions like comments, not prompts
      qapi/qapi-schema: Update introduction for example notation
      qapi/qapi-schema: Address the introduction's bit rot
      storage-daemon/qapi/qapi-schema: Add a proper introduction
      qga/qapi-schema: Add a proper introduction

 docs/devel/qapi-code-gen.rst                 | 53 ++++++++++++++++------------
 docs/interop/qemu-ga-ref.rst                 |  3 --
 docs/interop/qemu-qmp-ref.rst                |  2 +-
 docs/interop/qemu-storage-daemon-qmp-ref.rst |  2 +-
 docs/sphinx/qmp_lexer.py                     |  2 +-
 qapi/qapi-schema.json                        | 31 +++++-----------
 qapi/rocker.json                             |  2 +-
 qga/qapi-schema.json                         | 20 +++++++++--
 storage-daemon/qapi/qapi-schema.json         | 22 ++++++++++--
 tests/qapi-schema/doc-good.json              |  2 +-
 tests/qapi-schema/doc-good.out               |  2 +-
 tests/qapi-schema/doc-good.txt               |  2 +-
 12 files changed, 83 insertions(+), 60 deletions(-)

-- 
2.48.1


