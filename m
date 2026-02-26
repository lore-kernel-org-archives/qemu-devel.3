Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89800FD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvizx-0004Em-LH; Thu, 26 Feb 2026 16:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvizw-0004EA-Dz
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvizu-0004Hk-De
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772141652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZywNFdvhDL9ZPY9px2GhUCVem9pTDweFJaT8/Smsk4Y=;
 b=XQj6BznjBGzLUF9EXM1+wJmzDwtGUxnMSY58nopqDbCtKS/wn2feYH7POxpPFCQxjfRq+N
 e135DAWhLT6mJJi6dvFdUIM2TfFkf2Dhs+CuqYDIXSxfrgBU+vsxLceWJylVtfWMaHlgC9
 c3ussTdIsVv5RnHDw801F1CtQeB+d/I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-xYMUZNy1PxWG7r0BaL3nSg-1; Thu,
 26 Feb 2026 16:34:05 -0500
X-MC-Unique: xYMUZNy1PxWG7r0BaL3nSg-1
X-Mimecast-MFC-AGG-ID: xYMUZNy1PxWG7r0BaL3nSg_1772141644
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DBA81800366; Thu, 26 Feb 2026 21:34:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D90A01956053; Thu, 26 Feb 2026 21:34:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 0/4] Python: drop avocado, formally support python3.14
Date: Thu, 26 Feb 2026 16:33:56 -0500
Message-ID: <20260226213400.1254014-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset drops avocado for the python tests, which fixes the=0D
optional python-check-tox GitLab CI test, and adds formal testing and=0D
support for Python3.14 to QEMU.=0D
=0D
v4:=0D
 - Rebased=0D
 - Adjusted phrasing in 2/4 to reflect that this is a stopgap on the=0D
   road to meson test=0D
 - Simplified subprocess calls in linters.py=0D
=0D
v3:=0D
 - Fixed typo in patch 4 ("python 3.14" =3D> "python3.14")=0D
=0D
v2:=0D
 - Also search for Python3.14 during configure=0D
 - Rebase on top of master now that qemu.qmp is dropped=0D
=0D
John Snow (4):=0D
  python: pin 'wheel' version in minreqs test=0D
  python: replace avocado tests with pytest=0D
  python: drop avocado=0D
  python: add formal python3.14 support and testing=0D
=0D
 python/README.rst              |  2 -=0D
 configure                      |  4 +-=0D
 python/Makefile                |  6 +--=0D
 python/avocado.cfg             | 13 ------=0D
 python/setup.cfg               |  5 ++-=0D
 python/tests/flake8.sh         |  3 --=0D
 python/tests/iotests-mypy.sh   |  4 --=0D
 python/tests/iotests-pylint.sh |  5 ---=0D
 python/tests/isort.sh          |  3 --=0D
 python/tests/linters.py        | 79 ++++++++++++++++++++++++++++++++++=0D
 python/tests/minreqs.txt       |  3 +-=0D
 python/tests/mypy.sh           |  3 --=0D
 python/tests/pylint.sh         |  4 --=0D
 python/tests/qapi-flake8.sh    |  6 ---=0D
 python/tests/qapi-isort.sh     |  8 ----=0D
 python/tests/qapi-mypy.sh      |  4 --=0D
 python/tests/qapi-pylint.sh    |  8 ----=0D
 17 files changed, 88 insertions(+), 72 deletions(-)=0D
 delete mode 100644 python/avocado.cfg=0D
 delete mode 100755 python/tests/flake8.sh=0D
 delete mode 100755 python/tests/iotests-mypy.sh=0D
 delete mode 100755 python/tests/iotests-pylint.sh=0D
 delete mode 100755 python/tests/isort.sh=0D
 create mode 100644 python/tests/linters.py=0D
 delete mode 100755 python/tests/mypy.sh=0D
 delete mode 100755 python/tests/pylint.sh=0D
 delete mode 100755 python/tests/qapi-flake8.sh=0D
 delete mode 100755 python/tests/qapi-isort.sh=0D
 delete mode 100755 python/tests/qapi-mypy.sh=0D
 delete mode 100755 python/tests/qapi-pylint.sh=0D
=0D
-- =0D
2.53.0=0D
=0D


