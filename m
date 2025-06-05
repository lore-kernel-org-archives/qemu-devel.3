Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12EDC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFCY-0008U5-49; Thu, 05 Jun 2025 14:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCV-0008Ti-JK
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCT-0001W5-0v
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749147623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3oQYx7HzngLsdNVp79WAakEHMn9aGQlLi1rSKKNe4uk=;
 b=DXjT0joBD8BSpHRDhlHYVKZs/LUzUkCjuCk9+znL3U08smzvwMUsvDgBaCoLsHfEJzs+km
 uAhAS7krDkyFmKttL6ewk4znAdtfHet2bnArQ8jCG0BFLwecLYHCapG/otB334u+GC/XUl
 A5sms/FHZ4v0BAYAXiaIJHWun8NuGxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-I_NPZuJ-PCagVI4YjuRvJw-1; Thu,
 05 Jun 2025 14:20:19 -0400
X-MC-Unique: I_NPZuJ-PCagVI4YjuRvJw-1
X-Mimecast-MFC-AGG-ID: I_NPZuJ-PCagVI4YjuRvJw_1749147619
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2E0A18004A3; Thu,  5 Jun 2025 18:20:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA9581956048; Thu,  5 Jun 2025 18:20:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v2 0/6] Python patches
Date: Thu,  5 Jun 2025 14:20:08 -0400
Message-ID: <20250605182014.561172-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

The following changes since commit f8a113701dd2d28f3bedb216e59125ddcb77fd05=
:=0D
=0D
  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging =
(2025-06-04 11:43:31 -0400)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 678868eee3947fa25e13ccf3abb004c9c418e8a2:=0D
=0D
  qapi: delete un-needed python static analysis configs (2025-06-05 12:10:0=
7 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python Pull Request=0D
=0D
Add QAPI and QAPI doc files to python static analysis testing regime,=0D
this time for real, probably=0D
=0D
----------------------------------------------------------------=0D
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
 python/tests/minreqs.txt    | 31 +++++++++++++++++++++++++++++++=0D
 python/tests/qapi-flake8.sh |  6 ++++++=0D
 python/tests/qapi-isort.sh  |  8 ++++++++=0D
 python/tests/qapi-mypy.sh   |  4 ++++=0D
 python/tests/qapi-pylint.sh |  8 ++++++++=0D
 scripts/qapi/.flake8        |  3 ---=0D
 scripts/qapi/.isort.cfg     |  7 -------=0D
 scripts/qapi/backend.py     |  2 ++=0D
 scripts/qapi/mypy.ini       |  4 ----=0D
 scripts/qapi/pylintrc       |  1 +=0D
 13 files changed, 78 insertions(+), 28 deletions(-)=0D
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


