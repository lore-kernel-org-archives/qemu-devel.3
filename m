Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3403C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhG8-0004eT-K3; Tue, 15 Jul 2025 11:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubggQ-0003Mh-Lc
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubggH-0006Ro-FY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752589845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iyNyrnSHbk4/7fyJOstUqLI1vVB3c8BGLCeHWEkS/x8=;
 b=iXqFH5mRAHbdcF6YEfO+CxFDN1ekKCdz3vVMXmo1hTQVl2KYckGDbVmbPyyZOsQ44gX5xk
 QiUekh9SMD2PMB+daYJZl/ss/Od1qk5TxjnBmzmvXFY0TKwLWHZSMEmZ7Onxj2syUiUEcw
 iIJjqQAuzpA+QDbutR+zN3FJ4z2t81k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-EFAsHS8jOiii1k3w8bRKpQ-1; Tue,
 15 Jul 2025 10:30:35 -0400
X-MC-Unique: EFAsHS8jOiii1k3w8bRKpQ-1
X-Mimecast-MFC-AGG-ID: EFAsHS8jOiii1k3w8bRKpQ_1752589834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AB5E19560A2; Tue, 15 Jul 2025 14:30:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC9F7180045B; Tue, 15 Jul 2025 14:30:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/14] python: misc cleanups for python code
Date: Tue, 15 Jul 2025 15:30:09 +0100
Message-ID: <20250715143023.1851000-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

This spun out of understanding why we didn't get prior warning
about our use of the deprecated 'asyncio.get_event_loop' feature.
The answer is that python doesn't print any deprecation messages
by default unless directly triggered by the __main__ module.

So here I wanted to get all python warning messages enabled for
the iotests and functional tests, so we get a heads up of any
other failures coming out way.

In doing this it uncovered numerous places where we failed to
cleanup with dangling file handles.

I further uncovered lots of old compat code for py3.6 which
we stopped needing a long while ago.

I'm in two minds over whether the very last commit is suitable
or not though.  The iotests do strict comparison of stdout /
stderr, so if we allow python warnings to appear that will
break the iotests. At the same time though we do really want
to see these warnings, especially when developers run the
iotests manually, so just turning them on in CI is not very
desirable. So wondering how to get the warnings for devs but
not for users running from released tarballs?

Also note that I ran 'check', 'check -qcow' and 'check -nbd'
but this doesn't cover all possible iotest usage. So there
might still be some resource leaks hiding in there which will
cause failures for devs running tests with unusual config
scenarios.


Daniel P. Berrangé (13):
  python: avoid deprecation warning with get_event_loop
  python: drop 'is_closing' back compat helper
  python: drop 'wait_closed' back compat helper
  python: drop 'asyncio_run' back compat helper
  python: drop 'create_task' back compat helper
  iotests: drop compat for old version context manager
  functional: ensure log handlers are closed
  functional: ensure sockets and files are closed
  functional: always enable all python warnings
  python: ensure QEMUQtestProtocol closes its socket
  iotests/147: ensure temporary sockets are closed before exiting
  iotests/151: ensure subprocesses are cleaned up
  iotests/check: always enable all python warnings

Richard W.M. Jones (1):
  python: Replace asyncio.get_event_loop for Python 3.14

 python/qemu/machine/qtest.py           |  2 +
 python/qemu/qmp/legacy.py              | 10 ++-
 python/qemu/qmp/protocol.py            | 13 ++--
 python/qemu/qmp/qmp_tui.py             | 10 +--
 python/qemu/qmp/util.py                | 97 +-------------------------
 python/tests/protocol.py               |  9 ++-
 tests/functional/qemu_test/testcase.py |  6 ++
 tests/functional/test_multiprocess.py  |  3 +
 tests/functional/test_virtio_gpu.py    |  2 +
 tests/qemu-iotests/147                 |  1 +
 tests/qemu-iotests/151                 |  5 ++
 tests/qemu-iotests/check               |  4 ++
 tests/qemu-iotests/testenv.py          |  7 +-
 tests/qemu-iotests/testrunner.py       |  9 +--
 14 files changed, 51 insertions(+), 127 deletions(-)

-- 
2.49.0


