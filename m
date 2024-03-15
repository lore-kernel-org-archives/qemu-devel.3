Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D0AC54E6E
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9Op-0006yJ-RK; Fri, 15 Mar 2024 11:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Oo-0006xg-7J
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Om-0001zJ-Lh
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bj4DiZ7JUIsxcANACMuy2TGchukT6F4mCPxP/jTWjoU=;
 b=JKxr2Dgj4SlzIIH73G1L30la8AKYLjidi97TY88HEzqwwp0DCiE6rkAFZvcXtNFdtala1c
 bFo4gdfnS3tuCu3kjTO3U1ULb0ac4IdsEJBE326U8WQ6hLje3tRxCJwSQQUymxbFIk+lWZ
 B3R/sJNWwqeTd/D4iO5XgT/erOCpmsc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-sDsJkMhENvKisuHeW6xzuQ-1; Fri, 15 Mar 2024 11:23:04 -0400
X-MC-Unique: sDsJkMhENvKisuHeW6xzuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C1D01869DE6;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F018C111E3F3;
 Fri, 15 Mar 2024 15:23:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D226921E6A24; Fri, 15 Mar 2024 16:23:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 00/25] qapi: statically type schema.py
Date: Fri, 15 Mar 2024 16:22:36 +0100
Message-ID: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

v5:
* PATCH 05: Move QAPISchemaDefinition.check()'s
  super().check() back to where it was in v3
* PATCH 12: Replaced, necessitating minor adjustments in PATCH 17+22
* PATCH 16: Tweak comment
* PATCH 22: Tighten QAPISchema.lookup_entity()'s type hint
* PATCH 24+25: New

John Snow (22):
  qapi/parser: fix typo - self.returns.info => self.errors.info
  qapi/parser: shush up pylint
  qapi: sort pylint suppressions
  qapi/schema: add pylint suppressions
  qapi: create QAPISchemaDefinition
  qapi/schema: declare type for QAPISchemaObjectTypeMember.type
  qapi/schema: declare type for QAPISchemaArrayType.element_type
  qapi/schema: make c_type() and json_type() abstract methods
  qapi/schema: adjust type narrowing for mypy's benefit
  qapi/schema: add type narrowing to lookup_type()
  qapi/schema: assert resolve_type has 'info' and 'what' args on error
  qapi/schema: fix QAPISchemaArrayType.check's call to resolve_type
  qapi/schema: assert info is present when necessary
  qapi/schema: add _check_complete flag
  qapi/schema: Don't initialize "members" with `None`
  qapi/schema: fix typing for QAPISchemaVariants.tag_member
  qapi/schema: assert inner type of QAPISchemaVariants in check_clash()
  qapi/parser: demote QAPIExpression to Dict[str, Any]
  qapi/parser.py: assert member.info is present in connect_member
  qapi/schema: add type hints
  qapi/schema: turn on mypy strictness
  qapi/schema: remove unnecessary asserts

Markus Armbruster (3):
  qapi: Assert built-in types exist
  qapi: Tighten check whether implicit object type already exists
  qapi: Dumb down QAPISchema.lookup_entity()

 scripts/qapi/introspect.py |   8 +-
 scripts/qapi/mypy.ini      |   5 -
 scripts/qapi/parser.py     |   7 +-
 scripts/qapi/pylintrc      |  11 +-
 scripts/qapi/schema.py     | 794 ++++++++++++++++++++++++-------------
 5 files changed, 537 insertions(+), 288 deletions(-)

-- 
2.44.0


