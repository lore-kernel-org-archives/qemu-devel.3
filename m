Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD6BFCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzezw-0003nN-8K; Mon, 09 Mar 2026 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vzezk-0003cj-KH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vzezi-0006en-RP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773079577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oET7X5fB6asO2JXUHdT2FZurLX6tLZxUiAchPPj9k3Q=;
 b=HD6X10fu7JOnBowtymBFL3r8br/aOAnUPEYi/MgupOQzXxS3Yfq8A68dCtsNdwr5AHMMMQ
 H+uTe910i01vGty7dPbr3QxpyMSYkvcVv3wLgb2YJjFUtnzyj7trBxxXejyYs+dpqTTbh/
 W5mPx7aoZmqGByB3iHfEVnleKVEVw+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-qwhoFRNPMZ21c6nw5oQeZQ-1; Mon,
 09 Mar 2026 14:06:14 -0400
X-MC-Unique: qwhoFRNPMZ21c6nw5oQeZQ-1
X-Mimecast-MFC-AGG-ID: qwhoFRNPMZ21c6nw5oQeZQ_1773079571
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFD1E18005B4; Mon,  9 Mar 2026 18:06:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.1])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05C5218001FE; Mon,  9 Mar 2026 18:06:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 0/4] Python patches
Date: Mon,  9 Mar 2026 14:05:57 -0400
Message-ID: <20260309180601.164435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24=
:=0D
=0D
  Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller=
/qemu-hppa into staging (2026-03-09 14:53:42 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 191d4ceb40f8c80ae402a365a41300dcf1344125:=0D
=0D
  python: add formal python3.14 support and testing (2026-03-09 14:04:25 -0=
400)=0D
=0D
----------------------------------------------------------------=0D
Python pullreq=0D
=0D
Drop avocado, support Python3.14. Fixes optional check-python-tox GitLab=0D
CI test.=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (4):=0D
  python: pin 'wheel' version in minreqs test=0D
  python: replace avocado tests with pytest=0D
  python: drop avocado=0D
  python: add formal python3.14 support and testing=0D
=0D
 python/README.rst              |   2 -=0D
 configure                      |   4 +-=0D
 python/Makefile                |   6 +-=0D
 python/avocado.cfg             |  13 ----=0D
 python/setup.cfg               |   5 +-=0D
 python/tests/flake8.sh         |   3 -=0D
 python/tests/iotests-mypy.sh   |   4 --=0D
 python/tests/iotests-pylint.sh |   5 --=0D
 python/tests/isort.sh          |   3 -=0D
 python/tests/linters.py        | 114 +++++++++++++++++++++++++++++++++=0D
 python/tests/minreqs.txt       |   3 +-=0D
 python/tests/mypy.sh           |   3 -=0D
 python/tests/pylint.sh         |   4 --=0D
 python/tests/qapi-flake8.sh    |   6 --=0D
 python/tests/qapi-isort.sh     |   8 ---=0D
 python/tests/qapi-mypy.sh      |   4 --=0D
 python/tests/qapi-pylint.sh    |   8 ---=0D
 17 files changed, 123 insertions(+), 72 deletions(-)=0D
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


