Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A16ACCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 22:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDrnN-0005IR-Kf; Tue, 28 Oct 2025 18:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnM-0005IG-BS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnG-0000oR-OL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761689028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/BHXZtoKgcFdnXdzf3o9ojk9zpEFOUtFCsNLPaM6lIc=;
 b=XLF1Ko+J244sEnKQsyN8QmvQLoylnx2PKIi6ed3E2jEizACuFrO1h4kg/NPxfBE3vxJrdL
 uKHTOeyga8OV/3tJncq1gG+GlWezLwDAY+Dlj/kAopJJCZHniveG9n3rJvaJcsICs/zGcw
 QRLsTMGOHoiAFVSbxs4r9iRWXZWUvlw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-oYpZ1L_YMNSEULOHsD3I1A-1; Tue,
 28 Oct 2025 18:03:47 -0400
X-MC-Unique: oYpZ1L_YMNSEULOHsD3I1A-1
X-Mimecast-MFC-AGG-ID: oYpZ1L_YMNSEULOHsD3I1A_1761689026
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90C9195420D; Tue, 28 Oct 2025 22:03:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95BCD30001A2; Tue, 28 Oct 2025 22:03:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH RFC 00/10] RFC: Drop qemu.qmp from qemu.git
Date: Tue, 28 Oct 2025 18:03:30 -0400
Message-ID: <20251028220342.1407883-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an RFC, there's definitely a ton of nits here to smooth over,=0D
but I need help.=0D
=0D
1) The custom target I added to invoke the mkvenv ensure_group command=0D
to install test deps uses a junk output target that isn't actually=0D
pointed at the blank group file that mkvenv creates, because it's in=0D
another directory and meson doesn't like allowing you to specify targets=0D
in other directories. I'm not sure what the best way to fix this is...=0D
=0D
2) I only made iotests depend on this new custom target, because it was=0D
easy to do. I was not immediately sure what the correct way to make the=0D
functests depend on this new target was, so that needs adjusted.=0D
=0D
3) I did not remove the legacy "check-venv" target yet as with this=0D
patchset I have split apart the testing dependencies into the core=0D
dependencies and the functional dependencies. Ideally, "check-venv" is=0D
removed and we add a second custom target to meson that replaces this=0D
legacy target.=0D
=0D
4) I have so far not made any provisions to allow running iotest's check=0D
script from outside of the build system, but I am hoping it won't be too=0D
difficult to achieve ...=0D
=0D
5) There's likely a bunch of python tests that are now yapping and=0D
yelping after I so cruelly removed one of our libraries from out of the=0D
tree, I will smooth those over before the final push, but I can work on=0D
this in parallel while I wait for feedback and advice on the above=0D
items.=0D
=0D
John Snow (10):=0D
  python/mkvenv: ensure HAVE_LIB variables are actually constants=0D
  python/qapi: Add an ignore for Pylint 4.x=0D
  python/mkvenv: create timestamp file for each group "ensured"=0D
  python/mkvenv: bump 'qemu.qmp' dependency for testdeps=0D
  python/mkvenv: rename 'testdeps' to 'functests'=0D
  python/mkvenv: add "tests" dependency group=0D
  meson: create meson custom target for python test dependencies=0D
  meson: make iotests depend on pyvent_test_deps=0D
  python: quote dotted dependency keys=0D
  python: delete qemu.qmp=0D
=0D
 .gitlab-ci.d/buildtest.yml                    |    1 +=0D
 python/qemu/qmp/__init__.py                   |   60 -=0D
 python/qemu/qmp/error.py                      |   53 -=0D
 python/qemu/qmp/events.py                     |  751 -----------=0D
 python/qemu/qmp/legacy.py                     |  339 -----=0D
 python/qemu/qmp/message.py                    |  217 ----=0D
 python/qemu/qmp/models.py                     |  146 ---=0D
 python/qemu/qmp/protocol.py                   | 1101 -----------------=0D
 python/qemu/qmp/py.typed                      |    0=0D
 python/qemu/qmp/qmp_client.py                 |  732 -----------=0D
 python/qemu/qmp/qmp_shell.py                  |  689 -----------=0D
 python/qemu/qmp/qmp_tui.py                    |  665 ----------=0D
 python/qemu/qmp/util.py                       |  150 ---=0D
 python/qemu/utils/qom_fuse.py                 |    1 -=0D
 python/scripts/mkvenv.py                      |   30 +-=0D
 python/scripts/vendor.py                      |    2 +=0D
 python/setup.cfg                              |   32 +-=0D
 python/tests/minreqs.txt                      |    8 +-=0D
 python/tests/protocol.py                      |  596 ---------=0D
 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl |  Bin 0 -> 72263 bytes=0D
 pythondeps.toml                               |    7 +-=0D
 scripts/qapi/introspect.py                    |    2 +-=0D
 tests/Makefile.include                        |    2 +-=0D
 tests/meson.build                             |   15 +=0D
 tests/qemu-iotests/meson.build                |    2 +-=0D
 25 files changed, 55 insertions(+), 5546 deletions(-)=0D
 delete mode 100644 python/qemu/qmp/__init__.py=0D
 delete mode 100644 python/qemu/qmp/error.py=0D
 delete mode 100644 python/qemu/qmp/events.py=0D
 delete mode 100644 python/qemu/qmp/legacy.py=0D
 delete mode 100644 python/qemu/qmp/message.py=0D
 delete mode 100644 python/qemu/qmp/models.py=0D
 delete mode 100644 python/qemu/qmp/protocol.py=0D
 delete mode 100644 python/qemu/qmp/py.typed=0D
 delete mode 100644 python/qemu/qmp/qmp_client.py=0D
 delete mode 100644 python/qemu/qmp/qmp_shell.py=0D
 delete mode 100644 python/qemu/qmp/qmp_tui.py=0D
 delete mode 100644 python/qemu/qmp/util.py=0D
 delete mode 100644 python/tests/protocol.py=0D
 create mode 100644 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl=0D
=0D
-- =0D
2.51.0=0D
=0D


