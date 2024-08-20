Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0B6C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCeu-0005OV-BT; Mon, 19 Aug 2024 20:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCep-00057C-8v
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCen-0003rZ-I8
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OuDJkMhHuCgcnHmNZFENryVqxcdAYdISC4v9oMZOSXw=;
 b=jLgF7diWQZ9mH8OqjIGYc2smOBgXnAod01OD/c2WGugNP7dmoRHOMioqFVPWTmnb2ZoIfJ
 UiiYT1WDIprU6DkqnKApJHfnStVGh3M5wypfeAiRGKdOCSPZQCQMn6HOkMqrq1uysmYiHh
 Xjf8LwOTUfO8fvkVKoojZYepN29/itg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-8mH3ukWgM2Wq6OAr-ifeOw-1; Mon,
 19 Aug 2024 20:23:23 -0400
X-MC-Unique: 8mH3ukWgM2Wq6OAr-ifeOw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 016A21955BEF; Tue, 20 Aug 2024 00:23:22 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2345A1956053; Tue, 20 Aug 2024 00:23:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] move qapi under python/qemu/
Date: Mon, 19 Aug 2024 20:23:09 -0400
Message-ID: <20240820002318.1380276-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
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

Move the QAPI generator module to python/qemu/qapi so that it's checked=0D
by the same standard linter/static analysis regime as the other python=0D
code.=0D
=0D
This has the additional side-effect of marking me as a co-maintainer of=0D
the QAPI generator.=0D
=0D
John Snow (8):=0D
  python/qapi: correct re.Match type hints for 3.13=0D
  python/qapi: change "FIXME" to "TODO"=0D
  python/qapi: add pylint pragmas=0D
  python/qapi: remove outdated pragmas=0D
  python/qapi: ignore missing docstrings in pylint=0D
  python: allow short names for variables on older pylint=0D
  python/qapi: move scripts/qapi to python/qemu/qapi=0D
  python/qapi: remove redundant linter configuration=0D
=0D
 MAINTAINERS                                 |  2 +-=0D
 docs/conf.py                                |  2 +-=0D
 docs/sphinx/qapidoc.py                      |  6 +-=0D
 meson.build                                 | 28 +++++-----=0D
 {scripts =3D> python/qemu}/qapi/__init__.py   |  0=0D
 {scripts =3D> python/qemu}/qapi/commands.py   |  4 +-=0D
 {scripts =3D> python/qemu}/qapi/common.py     | 12 +++-=0D
 {scripts =3D> python/qemu}/qapi/error.py      |  0=0D
 {scripts =3D> python/qemu}/qapi/events.py     |  4 +-=0D
 {scripts =3D> python/qemu}/qapi/expr.py       |  3 +=0D
 {scripts =3D> python/qemu}/qapi/gen.py        |  4 +-=0D
 {scripts =3D> python/qemu}/qapi/introspect.py |  3 +=0D
 {scripts =3D> python/qemu}/qapi/main.py       |  2 +=0D
 {scripts =3D> python/qemu}/qapi/parser.py     |  9 ++-=0D
 {scripts =3D> python/qemu}/qapi/schema.py     |  2 +-=0D
 {scripts =3D> python/qemu}/qapi/source.py     |  2 +=0D
 {scripts =3D> python/qemu}/qapi/types.py      |  2 +=0D
 {scripts =3D> python/qemu}/qapi/visit.py      |  3 +=0D
 python/setup.cfg                            | 22 ++++----=0D
 scripts/qapi-gen.py                         |  4 +-=0D
 scripts/qapi/.flake8                        |  3 -=0D
 scripts/qapi/.isort.cfg                     |  7 ---=0D
 scripts/qapi/mypy.ini                       |  4 --=0D
 scripts/qapi/pylintrc                       | 61 ---------------------=0D
 tests/qapi-schema/meson.build               |  2 +-=0D
 tests/qapi-schema/test-qapi.py              |  4 +-=0D
 26 files changed, 78 insertions(+), 117 deletions(-)=0D
 rename {scripts =3D> python/qemu}/qapi/__init__.py (100%)=0D
 rename {scripts =3D> python/qemu}/qapi/commands.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/common.py (96%)=0D
 rename {scripts =3D> python/qemu}/qapi/error.py (100%)=0D
 rename {scripts =3D> python/qemu}/qapi/events.py (98%)=0D
 rename {scripts =3D> python/qemu}/qapi/expr.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/gen.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/introspect.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/main.py (98%)=0D
 rename {scripts =3D> python/qemu}/qapi/parser.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/schema.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/source.py (98%)=0D
 rename {scripts =3D> python/qemu}/qapi/types.py (99%)=0D
 rename {scripts =3D> python/qemu}/qapi/visit.py (99%)=0D
 delete mode 100644 scripts/qapi/.flake8=0D
 delete mode 100644 scripts/qapi/.isort.cfg=0D
 delete mode 100644 scripts/qapi/mypy.ini=0D
 delete mode 100644 scripts/qapi/pylintrc=0D
=0D
-- =0D
2.45.0=0D
=0D


