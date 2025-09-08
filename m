Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11469CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvh9g-00069a-Az; Mon, 08 Sep 2025 15:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvh9Z-00068q-SU
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvh9M-0007qW-Jq
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757358207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qV0+I3MdC02Rdi6nC+wNGWpeinGZd7wDsOrzmLwX3LE=;
 b=G1nvQbhfZdON4Ukkdk7Lny/ioafbRWQ5FqNlBKelbUAAqezA5uc5iJPMdsQViu8+1wnIqt
 UqMW/SbtoCOd9axcDfEnhLWS1gTx/Vz220KAeGTDO47PoxEsvTmul7L/zjZ1IV1Zad8IU5
 1yG8dJO8RQyadAcfI5eqRVjKZzSeJ3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-OERoKNrEP1GR8knZLzNuUQ-1; Mon,
 08 Sep 2025 15:03:26 -0400
X-MC-Unique: OERoKNrEP1GR8knZLzNuUQ-1
X-Mimecast-MFC-AGG-ID: OERoKNrEP1GR8knZLzNuUQ_1757358205
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A61180059D; Mon,  8 Sep 2025 19:03:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C4B11955F24; Mon,  8 Sep 2025 19:03:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 00/19] python: 3.14 compatibility and python-qemu-qmp
 synchronization
Date: Mon,  8 Sep 2025 15:02:59 -0400
Message-ID: <20250908190318.3331728-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, this series aims to support Python 3.14; a large part of how it=0D
achieves this is by backporting various changes that have been made to=0D
the python-qemu-qmp standalone library to ensure that our in-tree=0D
version is very nearly byte identical to the standalone version.=0D
=0D
Several of Dan's patches are appended here which remove all deprecated=0D
behavior from our test suite and enables printing warnings whenever=0D
deprecated behavior is used so we will be able to catch it more readily=0D
in the future.=0D
=0D
Following this series, I intend to drop the QMP library from the qemu=0D
tree once and for all so that they do not desynchronize again. The=0D
standalone library needs to drop avocado-framework and cut a v0.0.4=0D
release first, but it's currently my top priority to end this=0D
embarrassing patch of duplicated code and maintenance.=0D
=0D
Reviewers: try applying this series and using diff to compare the=0D
qemu.git/python/qemu/qmp and python-qemu-qmp.git/qemu/qmp directories;=0D
you should find only five differences: three instances of LICENSE text=0D
being slightly different (pointing to LICENSE vs COPYING) and two=0D
instances of a pylint ignore that are not needed in qemu.git due to=0D
slightly different linter configuration in qemu.git/python/setup.cfg.=0D
=0D
If further changes are warranted, it is my preference to try to=0D
"upstream" them first before backporting them here instead of trying to=0D
amend this series.=0D
=0D
V2: Squashed two commits in order to prevent regressions in qemu.git.=0D
=0D
V3: Unsquashed a backport into individual backports,=0D
    Amended commit messages to specify where the cherry-picks are from=0D
    Added R-B and S-o-B by Dan to various patches=0D
=0D
--js=0D
=0D
Adam Dorsey (1):=0D
  python: backport 'feat: allow setting read buffer limit'=0D
=0D
Daniel P. Berrang=C3=A9 (5):=0D
  iotests: drop compat for old version context manager=0D
  python: ensure QEMUQtestProtocol closes its socket=0D
  iotests/147: ensure temporary sockets are closed before exiting=0D
  iotests/151: ensure subprocesses are cleaned up=0D
  iotests/check: always enable all python warnings=0D
=0D
John Snow (13):=0D
  python: backport 'Change error classes to have better repr methods'=0D
  python: backport 'EventListener: add __repr__ method'=0D
  python: backport 'kick event queue on legacy event_pull()'=0D
  python: backport 'protocol: adjust logging name when changing client=0D
    name'=0D
  python: backport 'drop Python3.6 workarounds'=0D
  python: backport 'Use @asynciocontextmanager'=0D
  python: backport 'qmp-shell: add common_parser()'=0D
  python: backport 'make require() preserve async-ness'=0D
  python: backport 'qmp-shell-wrap: handle missing binary gracefully'=0D
  python: backport 'qmp-tui: Do not crash if optional dependencies are=0D
    not met'=0D
  python: backport 'Remove deprecated get_event_loop calls'=0D
  python: backport 'avoid creating additional event loops per thread'=0D
  python: synchronize qemu.qmp documentation=0D
=0D
 python/qemu/machine/qtest.py     |   2 +=0D
 python/qemu/qmp/__init__.py      |   3 +-=0D
 python/qemu/qmp/error.py         |   7 +-=0D
 python/qemu/qmp/events.py        |  50 ++++++--=0D
 python/qemu/qmp/legacy.py        |  46 +++++---=0D
 python/qemu/qmp/message.py       |  22 ++--=0D
 python/qemu/qmp/models.py        |   8 +-=0D
 python/qemu/qmp/protocol.py      | 194 +++++++++++++++++++------------=0D
 python/qemu/qmp/qmp_client.py    | 155 +++++++++++++++++-------=0D
 python/qemu/qmp/qmp_shell.py     | 165 ++++++++++++++++++--------=0D
 python/qemu/qmp/qmp_tui.py       |  30 +++--=0D
 python/qemu/qmp/util.py          | 143 ++++++-----------------=0D
 python/tests/protocol.py         |  10 +-=0D
 tests/qemu-iotests/147           |   1 +=0D
 tests/qemu-iotests/151           |   5 +=0D
 tests/qemu-iotests/check         |   4 +=0D
 tests/qemu-iotests/testenv.py    |   7 +-=0D
 tests/qemu-iotests/testrunner.py |   9 +-=0D
 18 files changed, 532 insertions(+), 329 deletions(-)=0D
=0D
-- =0D
2.50.1=0D
=0D


