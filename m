Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C5BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfiM-0005La-RO; Tue, 04 Mar 2025 22:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiL-0005LG-3c
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiJ-00060w-9Z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CWk3yC1w5n72ExiZU5LVQxOpQckQZ7AqpVBmWIYqQG0=;
 b=R9r0yKELiwSViMTYAoMqefOgQWRzlW9L47P2gSRlc3XZxLbMWipapLc8tvMAVXhfAjxvMC
 PKvz4kFroCtehAVeb9eUGsQ8jT6+BWvHd16tWE0OWbRyyOIE3TQz/5PXIpPlsCp9k7780f
 Xdd3NF5EJOD9UZh3kwDmlcVSinvQ4aw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-wK54SZjeMZOZ4Bw11br4hQ-1; Tue,
 04 Mar 2025 22:46:17 -0500
X-MC-Unique: wK54SZjeMZOZ4Bw11br4hQ-1
X-Mimecast-MFC-AGG-ID: wK54SZjeMZOZ4Bw11br4hQ_1741146376
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FDE918001CF; Wed,  5 Mar 2025 03:46:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C69BF1956095; Wed,  5 Mar 2025 03:46:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/57] docs: Add new QAPI transmogrifier
Date: Tue,  4 Mar 2025 22:45:09 -0500
Message-ID: <20250305034610.960147-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi! This series is based on armbru/pull-qapi-2025-02-26.=0D
=0D
This series is a "minimum viable" version of the new QAPI documentation=0D
system. It does the bare minimum under the new framework, saving nice=0D
features for later.=0D
=0D
Patches 3-29 implement the qapi_domain extension.=0D
Patches 30-57 implement the qapidoc "Transmogrifier".=0D
=0D
This series is still "RFC" quality, though it's quite nearly actually=0D
ready for inclusion. The "add transmogrifier test document" patch is not=0D
intended for actual merge, it's just there to demonstrate the new=0D
document generator by producing output in docs/manual/qapi/index.html.=0D
=0D
Known shortcomings in this series:=0D
=0D
- Still no new QAPI unit tests. I'll add those for next go-around.=0D
- No new documentation. Also for next revision. I'll document the QAPI=0D
  domain syntax and give a brief overview of how the transmogrifier=0D
  functions, and a quick rundown of any new rST syntax that may be=0D
  pertinent to QAPI documentation writers.=0D
- IFCOND information is still rendered in two places, we'll need to=0D
  decide where and how we want to render it.=0D
- No QAPI namespace support ... yet. So we can't enable it for QMP, QGA=0D
  and QSD simultaneously just yet. I don't think it will be difficult.=0D
=0D
Unknown shortcomings in this series:=0D
=0D
- ???=0D
=0D
New stuff overall from the last iteration of this series:=0D
=0D
- @foo is processed into ``foo`=0D
- "The members of ..." messages have been temporarily re-added until we=0D
  can smooth over the inliner.=0D
- This series runs under Sphinx 3.4.3 to Sphinx 8.2.0 inclusive. It=0D
  truly is a Christmas miracle. (please clap)=0D
- This series now fully type checks and lint checks under Sphinx 8.2.0,=0D
  but may not type check under earlier Sphinx versions. Achieving this=0D
  alone, nevermind in conjunction with the above, was a literal=0D
  herculean labor.=0D
=0D
I really must stress again how frustratingly difficult it was to achieve=0D
the prior two bullet points. I *do* in fact want a cookie and/or an=0D
award ribbon.=0D
=0D
--js=0D
=0D
John Snow (57):=0D
  do-not-merge=0D
  qapi: shush pylint up=0D
  docs/sphinx: create QAPI domain extension stub=0D
  docs/sphinx: add compat.py module and nested_parse helper=0D
  docs/qapi-domain: add qapi:module directive=0D
  docs/qapi-domain: add QAPI domain object registry=0D
  docs/qapi-domain: add QAPI index=0D
  docs/qapi-domain: add resolve_any_xref()=0D
  docs/qapi-domain: add QAPI xref roles=0D
  docs/qapi-domain: add compatibility node classes=0D
  docs/qapi-domain: add qapi:command directive=0D
  docs/qapi-domain: add :since: directive option=0D
  docs/qapi-domain: add "Arguments:" field lists=0D
  docs/qapi-domain: add "Features:" field lists=0D
  docs/qapi-domain: add "Errors:" field lists=0D
  docs/qapi-domain: add "Returns:" field lists=0D
  docs/qapi-domain: add qapi:enum directive=0D
  docs/qapi-domain: add qapi:alternate directive=0D
  docs/qapi-domain: add qapi:event directive=0D
  docs/qapi-domain: add qapi:object directive=0D
  docs/qapi-domain: add :deprecated: directive option=0D
  docs/qapi-domain: add :unstable: directive option=0D
  docs/qapi-domain: add :ifcond: directive option=0D
  docs/qapi-domain: add warnings for malformed field lists=0D
  docs/qapi-domain: add type cross-refs to field lists=0D
  docs/qapi-domain: add CSS styling=0D
  docs/qapi-domain: add XREF compatibility goop for Sphinx < 4.1=0D
  docs/qapi-domain: warn when QAPI domain xrefs fail to resolve=0D
  docs/qapi-domain: Fix error context reporting in Sphinx 5.x and 6.x=0D
  qapi/parser: adjust info location for doc body section=0D
  qapi: expand tags to all doc sections=0D
  qapi/schema: add __repr__ to QAPIDoc.Section=0D
  docs/qapidoc: add transmogrifier stub=0D
  docs/qapidoc: split old implementation into qapidoc_legacy.py=0D
  docs/qapidoc: Fix static typing on qapidoc.py=0D
  do-not-merge=0D
  docs/qapidoc: add transmogrifier class stub=0D
  docs/qapidoc: add visit_module() method=0D
  qapi/source: allow multi-line QAPISourceInfo advancing=0D
  docs/qapidoc: add visit_freeform() method=0D
  docs/qapidoc: add preamble() method=0D
  docs/qapidoc: add visit_paragraph() method=0D
  docs/qapidoc: add visit_errors() method=0D
  docs/qapidoc: add format_type() method=0D
  docs/qapidoc: add add_field() and generate_field() helper methods=0D
  docs/qapidoc: add visit_feature() method=0D
  docs/qapidoc: prepare to record entity being transmogrified=0D
  docs/qapidoc: add visit_returns() method=0D
  docs/qapidoc: add visit_member() method=0D
  docs/qapidoc: add visit_sections() method=0D
  docs/qapidoc: add visit_entity()=0D
  docs/qapidoc: implement transmogrify() method=0D
  docs: disambiguate cross-references=0D
  docs/qapidoc: add transmogrifier test document=0D
  docs/qapidoc: process @foo into ``foo``=0D
  docs/qapidoc: add intermediate output debugger=0D
  docs/qapidoc: Add "the members of" pointers=0D
=0D
 docs/conf.py                           |  18 +-=0D
 docs/devel/codebase.rst                |   6 +-=0D
 docs/glossary.rst                      |  10 +-=0D
 docs/index.rst                         |   1 +=0D
 docs/qapi/index.rst                    |  53 ++=0D
 docs/sphinx-static/theme_overrides.css |  98 ++-=0D
 docs/sphinx/compat.py                  | 229 ++++++=0D
 docs/sphinx/qapi_domain.py             | 981 +++++++++++++++++++++++++=0D
 docs/sphinx/qapidoc.py                 | 948 +++++++++++++-----------=0D
 docs/sphinx/qapidoc_legacy.py          | 440 +++++++++++=0D
 scripts/qapi-lint.sh                   |  55 ++=0D
 scripts/qapi/backend.py                |   2 +=0D
 scripts/qapi/main.py                   |  10 +-=0D
 scripts/qapi/parser.py                 | 118 ++-=0D
 scripts/qapi/source.py                 |   4 +-=0D
 tests/qapi-schema/doc-good.out         |  10 +-=0D
 tests/qapi-schema/test-qapi.py         |   2 +-=0D
 17 files changed, 2498 insertions(+), 487 deletions(-)=0D
 create mode 100644 docs/qapi/index.rst=0D
 create mode 100644 docs/sphinx/compat.py=0D
 create mode 100644 docs/sphinx/qapi_domain.py=0D
 create mode 100644 docs/sphinx/qapidoc_legacy.py=0D
 create mode 100755 scripts/qapi-lint.sh=0D
=0D
-- =0D
2.48.1=0D
=0D


