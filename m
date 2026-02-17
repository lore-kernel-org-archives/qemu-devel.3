Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE3FE8384C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDMp-0006ir-PV; Tue, 17 Feb 2026 00:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsDMn-0006iY-Tm
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsDMl-0002J3-Rh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771305078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VfY5g94Yzc6wjq2gbaAH5Oj1j29JaNgvQqfkyrIMhdM=;
 b=MbvULPqxO4VnFiHN17iESDDcBvl5IJhwj5xzOKYPYzVWdd/1t1kmd7RPIgOfXp7GQMfmyd
 azq12MzXZZJnX6LChdwbKAaq8E4f8t5vJQ2CJxD9qzC7B/hcPNYZz75ZBPpmdvuSGs/8ct
 M56mRMfCaUAMmtXBARCjG/ZoAxcgHTU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-PlMKobg6ObS9vpAhwMiFjg-1; Tue,
 17 Feb 2026 00:11:15 -0500
X-MC-Unique: PlMKobg6ObS9vpAhwMiFjg-1
X-Mimecast-MFC-AGG-ID: PlMKobg6ObS9vpAhwMiFjg_1771305074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF8F11956046
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 05:11:14 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C9E81800464; Tue, 17 Feb 2026 05:11:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 0/4] Python: drop avocado, misc test fixes
Date: Tue, 17 Feb 2026 00:11:08 -0500
Message-ID: <20260217051112.446957-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Based-on: <20260216212952.420120-1-jsnow@redhat.com>=0D
          https://patchew.org/QEMU/20260216212952.420120-1-jsnow@redhat.com=
/=0D
CI: https://gitlab.com/jsnow/qemu/-/pipelines/2329936379=0D
=0D
This patchset is based on top of my drop qemu.qmp series, and drops=0D
avocado and adds python3.14 to the test suite. This gets the test suite=0D
fully green as far as Python is concerned; with a lingering issue in=0D
check-rust-tools-nightly that cropped up with the upgrade to Fedora 43.=0D
=0D
John Snow (4):=0D
  python: add pinned 'wheel' version=0D
  python: replace avocado tests with pytest=0D
  python: drop avocado=0D
  python: add formal python3.14 support and testing=0D
=0D
 python/README.rst              |  2 -=0D
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
 16 files changed, 96 insertions(+), 70 deletions(-)=0D
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


