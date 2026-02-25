Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D8FD45E3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKYX-0003wP-7f; Wed, 25 Feb 2026 14:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKYV-0003tk-00
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKYT-0008En-El
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772047696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KwABYNi84QDm6KX4bO/d9lYxf/oCNoY3olvh+Na75UQ=;
 b=USgJCfevGAybWs4AOAQcyqG6J5ivwAt1o0CEQg7O4nEl1Kb3z7z38TYp1SJQZcdaGFJzsv
 eaIFTuNh2Nwj9nrcagRTPOzhXwNbMAmVTcjDoLRqYobI5JbrworgAD1Bb/9aZ/NTHJLCIY
 aBZEKt/UpvyMuIiq+JAcE5DNIpQL/a8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-msOG4mmvOpC3eXlJB2sXpQ-1; Wed,
 25 Feb 2026 14:28:12 -0500
X-MC-Unique: msOG4mmvOpC3eXlJB2sXpQ-1
X-Mimecast-MFC-AGG-ID: msOG4mmvOpC3eXlJB2sXpQ_1772047691
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1D0B1956080; Wed, 25 Feb 2026 19:28:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDEF41800666; Wed, 25 Feb 2026 19:28:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 0/4] Python: drop avocado, formally support python3.14
Date: Wed, 25 Feb 2026 14:28:04 -0500
Message-ID: <20260225192808.957477-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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
 python/avocado.cfg             | 13 -----=0D
 python/setup.cfg               |  5 +-=0D
 python/tests/flake8.sh         |  3 --=0D
 python/tests/iotests-mypy.sh   |  4 --=0D
 python/tests/iotests-pylint.sh |  5 --=0D
 python/tests/isort.sh          |  3 --=0D
 python/tests/linters.py        | 89 ++++++++++++++++++++++++++++++++++=0D
 python/tests/minreqs.txt       |  3 +-=0D
 python/tests/mypy.sh           |  3 --=0D
 python/tests/pylint.sh         |  4 --=0D
 python/tests/qapi-flake8.sh    |  6 ---=0D
 python/tests/qapi-isort.sh     |  8 ---=0D
 python/tests/qapi-mypy.sh      |  4 --=0D
 python/tests/qapi-pylint.sh    |  8 ---=0D
 17 files changed, 98 insertions(+), 72 deletions(-)=0D
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


