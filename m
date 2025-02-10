Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C70C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPKe-0000fn-DM; Mon, 10 Feb 2025 03:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPKc-0000fP-KM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPKa-0003Dj-TP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739176792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ucaoTy/UjG5JFULP/oJaS48DvOwwqhCr2WZi3Dr4Gzk=;
 b=MLbAIGEC9UwvxKhpXCf+ynZv4GzQcXOxdYwA/28ratbbNYW8r/7WU3GVBUF9EC9XEq3nSK
 DRsZpK5robecPADQnl1EkpARzWYZ03pmL2oUnsMLNBnDKBQ6WIoKzo1RSXOeTQt8Xk+3Xg
 C7qTr/tPg4HLS/ZJ7M9JJNr8jgdJCPQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-34oZybWnN9aG3_fgZRoa1w-1; Mon,
 10 Feb 2025 03:39:50 -0500
X-MC-Unique: 34oZybWnN9aG3_fgZRoa1w-1
X-Mimecast-MFC-AGG-ID: 34oZybWnN9aG3_fgZRoa1w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69BBB1956086
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:39:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FD031800873
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:39:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A22AC21E6A28; Mon, 10 Feb 2025 09:39:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/6] QAPI patches patches for 2025-02-10
Date: Mon, 10 Feb 2025 09:39:40 +0100
Message-ID: <20250210083946.3553415-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

The following changes since commit 04d3d0e9f54d4c42759f3810aa135ce314d98dc4:

  Merge tag 'hppa-system-for-v10-diva-artist-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2025-02-08 09:00:57 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-02-10

for you to fetch changes up to 9c339601b652edf91d74a626999285e3245b2589:

  qapi: expose all schema features to code (2025-02-10 09:14:14 +0100)

----------------------------------------------------------------
QAPI patches patches for 2025-02-10

----------------------------------------------------------------
Daniel P. Berrangé (4):
      qapi: cope with feature names containing a '-'
      qapi: change 'unsigned special_features' to 'uint64_t features'
      qapi: rename 'special_features' to 'features'
      qapi: expose all schema features to code

Victor Toso (1):
      qapi: fix colon in Since tag section

Zhang Boyang (1):
      qapi/ui: Fix documentation of upper bound value in InputMoveEvent

 meson.build                              |  1 +
 qapi/cxl.json                            |  4 +--
 qapi/ui.json                             |  2 +-
 include/qapi/compat-policy.h             |  2 +-
 include/qapi/qmp/dispatch.h              |  4 +--
 include/qapi/util.h                      |  2 +-
 include/qapi/visitor-impl.h              |  4 +--
 include/qapi/visitor.h                   | 12 ++++----
 qapi/qapi-forward-visitor.c              |  8 +++---
 qapi/qapi-util.c                         |  6 ++--
 qapi/qapi-visit-core.c                   | 12 ++++----
 qapi/qmp-dispatch.c                      |  2 +-
 qapi/qmp-registry.c                      |  4 +--
 qapi/qobject-input-visitor.c             |  4 +--
 qapi/qobject-output-visitor.c            |  6 ++--
 scripts/qapi/commands.py                 |  5 ++--
 scripts/qapi/features.py                 | 48 ++++++++++++++++++++++++++++++++
 scripts/qapi/gen.py                      |  9 +++---
 scripts/qapi/main.py                     |  2 ++
 scripts/qapi/schema.py                   | 31 ++++++++++++++++++++-
 scripts/qapi/types.py                    | 23 ++++++++-------
 scripts/qapi/visit.py                    | 21 ++++++--------
 tests/meson.build                        |  2 ++
 tests/qapi-schema/features-too-many.err  |  2 ++
 tests/qapi-schema/features-too-many.json | 13 +++++++++
 tests/qapi-schema/features-too-many.out  |  0
 tests/qapi-schema/meson.build            |  1 +
 27 files changed, 163 insertions(+), 67 deletions(-)
 create mode 100644 scripts/qapi/features.py
 create mode 100644 tests/qapi-schema/features-too-many.err
 create mode 100644 tests/qapi-schema/features-too-many.json
 create mode 100644 tests/qapi-schema/features-too-many.out

-- 
2.48.1


