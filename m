Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18000C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPZQ-0003ST-KX; Mon, 15 Jul 2024 13:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTPZP-0003QQ-3h
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTPZN-0002Tf-90
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721064778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hAvh22Zdw4wu95Be5PIC3lsJUebu8ON8TPVZflTCXws=;
 b=SP6qSh+Im+E8Nna7pNYnMUzXozQUkoiUEW9aIPAk6eBWFyo2eejiM4C4h1gaEN7urxJgbI
 lm4VkeE64hDo9u42bUMatAxJ2t2M5aZ9NKQQS2ALZ/M8nmkGMEM9G3YM2DdFdShWssLPtb
 6PWJay08i7kapbPq1t6LiuTttgckho0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-WGLn17MGNXmd4VGJWn4O3w-1; Mon,
 15 Jul 2024 13:32:55 -0400
X-MC-Unique: WGLn17MGNXmd4VGJWn4O3w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 328011955D5C; Mon, 15 Jul 2024 17:32:51 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FE131955D42; Mon, 15 Jul 2024 17:32:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Leonardo Bras <leobras@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Roth <michael.roth@amd.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Andrew Jeffery <andrew@aj.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 0/6] Python patches
Date: Mon, 15 Jul 2024 13:32:35 -0400
Message-ID: <20240715173241.572048-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 4469bee2c529832d762af4a2f89468c926f02fe4=
:=0D
=0D
  Merge tag 'nvme-next-pull-request' of https://gitlab.com/birkelund/qemu i=
nto staging (2024-07-11 14:32:51 -0700)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to dd23f9ec519db9c424223cff8767715de5532718:=0D
=0D
  docs: remove Sphinx 1.x compatibility code (2024-07-12 16:46:21 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python: 3.13 compat & sphinx minver bump=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (6):=0D
  python: linter changes for pylint 3.x=0D
  python: Do not use pylint 3.2.4 with python 3.8=0D
  iotests: Change imports for Python 3.13=0D
  python: enable testing for 3.13=0D
  Python: bump minimum sphinx version to 3.4.3=0D
  docs: remove Sphinx 1.x compatibility code=0D
=0D
 docs/conf.py                           |  7 ++---=0D
 docs/sphinx/hxtool.py                  | 21 +++-----------=0D
 docs/sphinx/kerneldoc.py               | 38 ++++++++------------------=0D
 docs/sphinx/kernellog.py               | 28 -------------------=0D
 docs/sphinx/qapidoc.py                 | 33 ++--------------------=0D
 python/qemu/machine/machine.py         |  1 +=0D
 python/qemu/utils/qemu_ga_client.py    |  2 +-=0D
 python/setup.cfg                       |  4 ++-=0D
 pythondeps.toml                        |  2 +-=0D
 tests/docker/dockerfiles/python.docker |  1 +=0D
 tests/qemu-iotests/testenv.py          |  7 ++++-=0D
 tests/qemu-iotests/testrunner.py       |  9 ++++--=0D
 12 files changed, 41 insertions(+), 112 deletions(-)=0D
 delete mode 100644 docs/sphinx/kernellog.py=0D
=0D
-- =0D
2.45.0=0D
=0D


