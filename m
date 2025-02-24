Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E74EC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPI6-0001Mj-12; Sun, 23 Feb 2025 22:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPI4-0001MO-8E
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:37:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPI2-0005QL-2m
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740368272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/QaQvvkANl4CxJcoZXAetNsesoYPFAQysyASef0azrE=;
 b=KoE69lpQcV7MsyYHrXA7pv2pwSUJVfYYTjqZdVhoYGsRR1uVIw7BuDhphg2nfLI9FspwNg
 r5q30yVM4Ud4Ebe/zS37dbxV100scPam8V3luzlZz3x8ziYc1A10jcCMkIwLQxpdh2U65Q
 FeNZer8E+wepfmxc+LM8p7CilA37xRU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-lfUsNUkQN_qsYEyFBMsC5A-1; Sun,
 23 Feb 2025 22:37:45 -0500
X-MC-Unique: lfUsNUkQN_qsYEyFBMsC5A-1
X-Mimecast-MFC-AGG-ID: lfUsNUkQN_qsYEyFBMsC5A_1740368264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7688A196E078; Mon, 24 Feb 2025 03:37:44 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8407119560A3; Mon, 24 Feb 2025 03:37:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/10] qapi: misc testing and doc patches
Date: Sun, 23 Feb 2025 22:37:31 -0500
Message-ID: <20250224033741.222749-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

GitLab: https://gitlab.com/jsnow/qemu/-/pipelines/1684045409=0D
=0D
This is a series of random qapi and documentation patches;=0D
=0D
Patches 1-3: Formalize QAPI python testing (finally ...)=0D
Patches 4-10: Miscellaneous patches and fixes related to the=0D
documentation overhaul project; but were standalone enough that they=0D
could be excised from a fairly lengthy series ...=0D
=0D
Markus: I think everything here is suitable for merging, even though=0D
some of it might lack a little context. The more I pull out of that big=0D
series, the easier that series will be to review :)=0D
=0D
Please stage as much as you feel comfortable doing, you can skip any=0D
individual patch at your discretion.=0D
=0D
John Snow (10):=0D
  qapi: update pylintrc config=0D
  python: add qapi static analysis tests=0D
  qapi: delete un-needed python static analysis configs=0D
  docs/qapidoc: support header-less freeform sections=0D
  qapi/parser: adjust info location for doc body section=0D
  docs/qapidoc: remove example section support=0D
  qapi: expand tags to all doc sections=0D
  qapi/schema: add __repr__ to QAPIDoc.Section=0D
  qapi/source: allow multi-line QAPISourceInfo advancing=0D
  docs: disambiguate cross-references=0D
=0D
 docs/devel/codebase.rst        |   6 +-=0D
 docs/glossary.rst              |  10 +--=0D
 docs/sphinx/qapidoc.py         |  18 ++---=0D
 python/tests/qapi-flake8.sh    |   2 +=0D
 python/tests/qapi-isort.sh     |   2 +=0D
 python/tests/qapi-mypy.sh      |   2 +=0D
 python/tests/qapi-pylint.sh    |   4 ++=0D
 scripts/qapi/.flake8           |   3 -=0D
 scripts/qapi/.isort.cfg        |   7 --=0D
 scripts/qapi/mypy.ini          |   4 --=0D
 scripts/qapi/parser.py         | 124 +++++++++++++++++++++++++--------=0D
 scripts/qapi/pylintrc          |   1 +=0D
 scripts/qapi/source.py         |   4 +-=0D
 tests/qapi-schema/doc-good.out |  10 +--=0D
 tests/qapi-schema/test-qapi.py |   2 +-=0D
 15 files changed, 128 insertions(+), 71 deletions(-)=0D
 create mode 100755 python/tests/qapi-flake8.sh=0D
 create mode 100755 python/tests/qapi-isort.sh=0D
 create mode 100755 python/tests/qapi-mypy.sh=0D
 create mode 100755 python/tests/qapi-pylint.sh=0D
 delete mode 100644 scripts/qapi/.flake8=0D
 delete mode 100644 scripts/qapi/.isort.cfg=0D
 delete mode 100644 scripts/qapi/mypy.ini=0D
=0D
-- =0D
2.48.1=0D
=0D


