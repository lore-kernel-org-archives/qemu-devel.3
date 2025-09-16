Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41207CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYTw-0003eO-C7; Tue, 16 Sep 2025 12:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYTa-0003aP-UV
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYTX-0002gW-Am
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=okVc3FLS2Ebfb/NNRGl9e5wUouDkitrDbhftqB9okxY=;
 b=dH2Az9tDFKZG7nr7ZMDlJM5c6pCRIRAOPEP3/ICyWSSbtMD53nAgSi2h9F4lHrA5hijRvo
 4PWgR3brldZcbcwsI0eKMCurICFqGx4/c32aSvftLyACqKNXhE8SeVobKWHDK4NCKewZcz
 4WfoBBEGPCMESfL/4rf3cXWql6skFYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-1doPol0nNiew-pfIN9pizg-1; Tue,
 16 Sep 2025 12:24:10 -0400
X-MC-Unique: 1doPol0nNiew-pfIN9pizg-1
X-Mimecast-MFC-AGG-ID: 1doPol0nNiew-pfIN9pizg_1758039849
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE82818004D4; Tue, 16 Sep 2025 16:24:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86D0919560B8; Tue, 16 Sep 2025 16:24:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 00/19] Python patches
Date: Tue, 16 Sep 2025 12:23:45 -0400
Message-ID: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d=
:=0D
=0D
  Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into=
 staging (2025-09-11 12:41:01 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 9a494d83538680651197651031375c2b6fa2490b:=0D
=0D
  iotests/check: always enable all python warnings (2025-09-15 14:36:02 -04=
00)=0D
=0D
----------------------------------------------------------------=0D
Python Pull Request=0D
=0D
Python 3.14 support & synchronize with python-qemu-qmp repo=0D
=0D
----------------------------------------------------------------=0D
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
2.51.0=0D
=0D


