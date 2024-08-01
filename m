Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017D0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5F-0001NP-NC; Thu, 01 Aug 2024 13:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5E-0001Mk-Rg
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5C-0005sl-Cf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21oZiG7UfvUIF54RYJhgGL2b1LYGr/5IDeQkcassiBI=;
 b=Uq6x2zA3L+ZVN0y5UvrSRK+rSSpbS8lviTUmMvKuVLYfNxebgitl9zxU8TSijE+FAuMm1H
 xWcDH/lJmhBhVZXqctx4Cb6dWOjxxBOVYk2qKFQ6AmzDDhdkB93KAlthfPxGn4lK99s/gR
 W0BbxyENllHkHC7us0qOZbdU2SSrLIo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-5mLhp9kgOkqxrzyxWMdLXA-1; Thu,
 01 Aug 2024 13:59:18 -0400
X-MC-Unique: 5mLhp9kgOkqxrzyxWMdLXA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C57BF1955D53; Thu,  1 Aug 2024 17:59:17 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8F1619560AA; Thu,  1 Aug 2024 17:59:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] qapi: generalize special features
Date: Thu,  1 Aug 2024 18:59:07 +0100
Message-ID: <20240801175913.669013-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series is a spin-off from

  https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg00807.html

That series introduced a pragma allowing a schema to declare extra
features that would be exposed to code.

Following Markus' suggestion:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg03765.html

I've changed impl such that we expose all features to the code
regardless of whether they are special, and don't require any pragma.

I've split it from the QGA patches since it makes more sense to work
on this bit in isolation.

Daniel P. Berrangé (6):
  qapi: change 'unsigned special_features' to 'uint64_t features'
  scripts/qapi: rename 'special_features' to 'features'
  qapi: use "QAPI_FEATURE" as namespace for features
  qapi: cope with  feature names containing a '-'
  qapi: apply schema prefix to QAPI feature enum constants
  qapi: expose all schema features to code

 include/qapi/compat-policy.h  |   2 +-
 include/qapi/qmp/dispatch.h   |   4 +-
 include/qapi/util.h           |   7 +-
 include/qapi/visitor-impl.h   |   4 +-
 include/qapi/visitor.h        |  12 +--
 meson.build                   |   1 +
 qapi/qapi-forward-visitor.c   |   8 +-
 qapi/qapi-util.c              |   6 +-
 qapi/qapi-visit-core.c        |  12 +--
 qapi/qmp-dispatch.c           |   2 +-
 qapi/qmp-registry.c           |   4 +-
 qapi/qobject-input-visitor.c  |   4 +-
 qapi/qobject-output-visitor.c |   6 +-
 scripts/qapi/commands.py      |   9 ++-
 scripts/qapi/events.py        |   3 +-
 scripts/qapi/features.py      | 134 ++++++++++++++++++++++++++++++++++
 scripts/qapi/gen.py           |   9 ++-
 scripts/qapi/main.py          |   2 +
 scripts/qapi/schema.py        |   5 +-
 scripts/qapi/types.py         |  19 +++--
 scripts/qapi/visit.py         |  17 +++--
 21 files changed, 206 insertions(+), 64 deletions(-)
 create mode 100644 scripts/qapi/features.py

-- 
2.45.2


