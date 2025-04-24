Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C4EC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83op-0005uP-Nk; Thu, 24 Apr 2025 17:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u83oo-0005u4-Az
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u83om-0001JU-8b
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745528950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MxZ9FyOe7rfygB/wxEgtbSDiwTekgP4auzau0fDN3QU=;
 b=ZZFI6W2pJkhQ4RLCqMS6nhEIZil7M+LR5Ts7k+aDy6KfX2jPl6+mZqB90XDTCP2UBCnjFA
 Ns8xSNdX0M8aNIWRW9M3jt80Vx3ia2GB7uU9KFXGeh4q40i8TiqAAm96wu0yNf6G6Zy9dd
 EaSIqGfuaGO0gkGpKmsU+hon/MYSOT4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-_hJmMjMvP-27A0NQ1XL6Rg-1; Thu,
 24 Apr 2025 17:09:08 -0400
X-MC-Unique: _hJmMjMvP-27A0NQ1XL6Rg-1
X-Mimecast-MFC-AGG-ID: _hJmMjMvP-27A0NQ1XL6Rg_1745528947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F9B31800374; Thu, 24 Apr 2025 21:09:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEFBC30001A2; Thu, 24 Apr 2025 21:09:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/6] python: add QAPI and qapidoc et al to python linter
 tests
Date: Thu, 24 Apr 2025 17:08:58 -0400
Message-ID: <20250424210904.2505114-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

Hiya, this series turns on automated linting for scripts/qapi,=0D
docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py.=0D
=0D
This includes flake8/isort/pylint/mypy for scripts/qapi, but omits mypy=0D
from the Sphinx plugins owing to my inability to strictly type the=0D
extensions given the wide versions of Sphinx we actually support.=0D
=0D
Though I have been using black in my own development, I have not yet=0D
enabled it anywhere automatically. Maybe soon.=0D
=0D
NOTE: the latest Fedora image doesn't have Python38 anymore; this series=0D
does not address that. A more substantial fix for testing will be=0D
forthcoming.=0D
=0D
V3:=0D
 - Folded in Markus's commit to clean up setup.cfg.=0D
=0D
V2:=0D
 - Mostly commit message updates based on Markus's's's review.=0D
=0D
John Snow (5):=0D
  qapi: Add some pylint ignores=0D
  docs/qapidoc: linting fixes=0D
  python: update missing dependencies from minreqs=0D
  python: add qapi static analysis tests=0D
  qapi: delete un-needed python static analysis configs=0D
=0D
Markus Armbruster (1):=0D
  python: Drop redundant warn_unused_configs =3D True=0D
=0D
 docs/sphinx/qapi_domain.py  | 25 ++++++++++++++-----------=0D
 docs/sphinx/qapidoc.py      |  5 +++--=0D
 python/setup.cfg            |  2 +-=0D
 python/tests/minreqs.txt    | 25 +++++++++++++++++++++++++=0D
 python/tests/qapi-flake8.sh |  4 ++++=0D
 python/tests/qapi-isort.sh  |  6 ++++++=0D
 python/tests/qapi-mypy.sh   |  2 ++=0D
 python/tests/qapi-pylint.sh |  6 ++++++=0D
 scripts/qapi/.flake8        |  3 ---=0D
 scripts/qapi/.isort.cfg     |  7 -------=0D
 scripts/qapi/backend.py     |  2 ++=0D
 scripts/qapi/mypy.ini       |  4 ----=0D
 scripts/qapi/pylintrc       |  1 +=0D
 13 files changed, 64 insertions(+), 28 deletions(-)=0D
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


