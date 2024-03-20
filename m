Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEBAC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqbr-0003fH-GZ; Wed, 20 Mar 2024 03:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbq-0003es-45
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbe-0007dx-Gz
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710920605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=viy/lnJO1Y/zGg7lkH2h/07XOu8sAq27+f9Bq4tQhrY=;
 b=WLrFilmy8G5+B6yATDDfBhavWFsnl3PY5LiKc4SPXfW8RW28BtzSk+r1OZOdFqFHXeK4vz
 ldKkEo9HaKQ4nF97GQmPsplSPs4+3iLMoMQmDWdtziS0HelUjhYaN/AOO3yHjfdviva66w
 vmRy4Nr8MGebkchbPK3hHKFvJlp6yLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-DmAzt-b_MfSsA4CF_CZ97g-1; Wed, 20 Mar 2024 03:43:22 -0400
X-MC-Unique: DmAzt-b_MfSsA4CF_CZ97g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEAAE8007A1;
 Wed, 20 Mar 2024 07:43:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF7D492BD6;
 Wed, 20 Mar 2024 07:43:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96D4A21E6A28; Wed, 20 Mar 2024 08:43:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH 0/7] qapi: Refactor QAPISchemaVariants
Date: Wed, 20 Mar 2024 08:43:08 +0100
Message-ID: <20240320074315.23167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

QAPISchemaVariants represents either a union type's branches, or an
alternate type's alternatives.  Much of its code is conditional on
which one it actually is.

This series moves the conditional code to new subtypes
QAPISchemaBranches and QAPISchemaAlternatives.

This also lets us treat QAPISchemaVariants.tag_member like the other
attribute that become known only in .check().

Markus Armbruster (7):
  qapi: New QAPISchemaBranches, QAPISchemaAlternatives
  qapi: Rename visitor parameter @variants to @branches
  qapi: Rename visitor parameter @variants to @alternatives
  qapi: Rename QAPISchemaObjectType.variants to .branches
  qapi: Rename QAPISchemaAlternateType.variants to .alternatives
  qapi: Move conditional code from QAPISchemaVariants to its subtypes
  qapi: Simplify QAPISchemaVariants @tag_member

 docs/sphinx/qapidoc.py         |  21 ++--
 scripts/qapi/commands.py       |   2 +-
 scripts/qapi/events.py         |   2 +-
 scripts/qapi/gen.py            |   2 +-
 scripts/qapi/introspect.py     |  15 +--
 scripts/qapi/schema.py         | 223 +++++++++++++++++----------------
 scripts/qapi/types.py          |  12 +-
 scripts/qapi/visit.py          |  24 ++--
 tests/qapi-schema/test-qapi.py |   9 +-
 9 files changed, 163 insertions(+), 147 deletions(-)

-- 
2.44.0


