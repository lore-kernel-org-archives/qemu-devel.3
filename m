Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0989BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrH-0003e1-8P; Tue, 11 Mar 2025 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-00034x-RL
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpu-0006Q9-HL
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sxO2amssh2/lVjF6QZwbW42lYwmzNOpDcvsWQ/f4MQo=;
 b=Gu1X+ripAunFvcSTpi3zosG5CM5GswfCM8CEF5PK15z2Gs5z+Nq2WaO4uyyMch34p2+h9s
 JsJ+VxdzotnQIF6wvGmIclC71zLdbKsK/rC9LCdaTAW/bJbpwOPcsL9oCpGPSvO23Zu1Yi
 AF2KMNvJ254e1xPHf8G9NTCxQNaDj0Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-42z4ww7XOwyTuSwKtdyggw-1; Tue,
 11 Mar 2025 07:31:43 -0400
X-MC-Unique: 42z4ww7XOwyTuSwKtdyggw-1
X-Mimecast-MFC-AGG-ID: 42z4ww7XOwyTuSwKtdyggw_1741692703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2397A180025A
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 492611828A9C
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2F0421E66C1; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/61] QAPI patches patches for 2025-03-11
Date: Tue, 11 Mar 2025 12:30:36 +0100
Message-ID: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:

  Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-03-11

for you to fetch changes up to 93db9c84fc40b82d6bc3a944cb8eb8443980824c:

  scripts/qapi/backend: Clean up create_backend()'s failure mode (2025-03-11 10:26:52 +0100)

----------------------------------------------------------------
QAPI patches patches for 2025-03-11

----------------------------------------------------------------
John Snow (60):
      docs/sphinx: create QAPI domain extension stub
      docs/sphinx: add compat.py module and nested_parse helper
      docs/qapi-domain: add QAPI domain object registry
      docs/qapi-domain: add QAPI index
      docs/qapi-domain: add resolve_any_xref()
      docs/qapi-domain: add QAPI xref roles
      docs/qapi-domain: add compatibility node classes
      docs/qapi-domain: Add QAPIDescription abstract class
      docs/qapi-domain: add qapi:module directive
      docs/qapi-domain: add QAPIObject class
      docs/qapi-domain: add qapi:command directive
      docs/qapi-domain: add :since: directive option
      docs/qapi-domain: add "Arguments:" field lists
      docs/qapi-domain: add "Features:" field lists
      docs/qapi-domain: add "Errors:" field lists
      docs/qapi-domain: add "Return:" field lists
      docs/qapi-domain: add qapi:enum directive
      docs/qapi-domain: add qapi:alternate directive
      docs/qapi-domain: add qapi:event directive
      docs/qapi-domain: add qapi:object directive
      docs/qapi-domain: add :deprecated: directive option
      docs/qapi-domain: add :unstable: directive option
      docs/qapi-domain: add :ifcond: directive option
      docs/qapi-domain: add warnings for malformed field lists
      docs/qapi-domain: add type cross-refs to field lists
      docs/qapi-domain: add CSS styling
      docs/qapi-domain: add XREF compatibility goop for Sphinx < 4.1
      docs/qapi-domain: warn when QAPI domain xrefs fail to resolve
      docs/qapi-domain: Fix error context reporting in Sphinx 5.x and 6.x
      qapi/parser: adjust info location for doc body section
      qapi: clean up encoding of section kinds
      qapi/schema: add __repr__ to QAPIDoc.Section
      docs/qapidoc: add transmogrifier stub
      docs/qapidoc: split old implementation into qapidoc_legacy.py
      docs/qapidoc: Fix static typing on qapidoc.py
      docs/qapidoc: add transmogrifier class stub
      docs/qapidoc: add visit_module() method
      qapi/source: allow multi-line QAPISourceInfo advancing
      docs/qapidoc: add visit_freeform() method
      docs/qapidoc: add preamble() method
      docs/qapidoc: add visit_paragraph() method
      docs/qapidoc: add visit_errors() method
      docs/qapidoc: add format_type() method
      docs/qapidoc: add add_field() and generate_field() helper methods
      docs/qapidoc: add visit_feature() method
      docs/qapidoc: prepare to record entity being transmogrified
      docs/qapidoc: add visit_returns() method
      docs/qapidoc: add visit_member() method
      docs/qapidoc: add visit_sections() method
      docs/qapidoc: add visit_entity()
      docs/qapidoc: implement transmogrify() method
      docs/qapidoc: process @foo into ``foo``
      docs/qapidoc: add intermediate output debugger
      docs/qapidoc: Add "the members of" pointers
      docs/qapidoc: generate entries for undocumented members
      qapi/parser: add undocumented stub members to all_sections
      docs: disambiguate cross-references
      docs: enable qapidoc transmogrifier for QEMU QMP Reference
      docs: add qapi-domain syntax documentation
      MAINTAINERS: Add jsnow as maintainer for Sphinx documentation

Markus Armbruster (1):
      scripts/qapi/backend: Clean up create_backend()'s failure mode

 MAINTAINERS                            |   1 +
 docs/conf.py                           |  18 +-
 docs/devel/codebase.rst                |   6 +-
 docs/devel/index-build.rst             |   1 +
 docs/devel/qapi-domain.rst             | 670 ++++++++++++++++++++++++
 docs/glossary.rst                      |  10 +-
 docs/interop/qemu-qmp-ref.rst          |   1 +
 docs/sphinx-static/theme_overrides.css |  98 +++-
 docs/sphinx/compat.py                  | 230 ++++++++
 docs/sphinx/qapi_domain.py             | 931 +++++++++++++++++++++++++++++++++
 docs/sphinx/qapidoc.py                 | 907 +++++++++++++++++---------------
 docs/sphinx/qapidoc_legacy.py          | 440 ++++++++++++++++
 qapi/qapi-schema.json                  |   2 +
 scripts/qapi/main.py                   |  24 +-
 scripts/qapi/parser.py                 | 123 ++++-
 scripts/qapi/source.py                 |   4 +-
 tests/qapi-schema/doc-good.out         |  10 +-
 tests/qapi-schema/test-qapi.py         |   2 +-
 18 files changed, 3000 insertions(+), 478 deletions(-)
 create mode 100644 docs/devel/qapi-domain.rst
 create mode 100644 docs/sphinx/compat.py
 create mode 100644 docs/sphinx/qapi_domain.py
 create mode 100644 docs/sphinx/qapidoc_legacy.py

-- 
2.48.1


