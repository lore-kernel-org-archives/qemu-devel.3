Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E66C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6Um-0003NY-VU; Fri, 11 Jul 2025 01:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Uk-0003LR-Pm
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Ug-0008CK-7E
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TeZiXk83RvJnI2EXSwZy4TDhN4XGPTpcILuWerJcAKQ=;
 b=akvJekoLdBpUF1tPxDZuE5vjSqSCB+Dwrsmhy9sUjUkRbqzWnZPXXUZErZt4MnaqWLxsWh
 8dlg2jWtsG4UPWLmP78yby9v9hACQcP9OJfxOT3pI2ecEHFuPomDAMGdZ0mwG9WpcYfJmm
 h1hF95L4TtGYzkQ5kx8E+x4ae+lA+6o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-gI4p3kaDMU-WDnzkb_35hg-1; Fri,
 11 Jul 2025 01:40:17 -0400
X-MC-Unique: gI4p3kaDMU-WDnzkb_35hg-1
X-Mimecast-MFC-AGG-ID: gI4p3kaDMU-WDnzkb_35hg_1752212415
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28FA9195608B; Fri, 11 Jul 2025 05:40:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B5D91800285; Fri, 11 Jul 2025 05:40:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 00/18] QAPI: add cross-references to qapi docs
Date: Fri, 11 Jul 2025 01:39:47 -0400
Message-ID: <20250711054005.60969-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Based-on: 20250711051045.51110-1-jsnow@redhat.com=0D
    [PATCH v6 0/4] qapi: add auto-generated return docs=0D
=0D
v2:=0D
 - Applied a few new transformations I had missed.=0D
 - Manually excluded those Markus pointed out as being unhelpful.=0D
=0D
Hi, this patch series is a *mostly* mechanical application of QAPI=0D
cross-references to the QAPI/QMP documentation. I exported all=0D
cross-referenceable symbols from the QMP QAPI schema and ran them=0D
through a script that converted any matching words to a cross-reference.=0D
=0D
I then used `git add -p` and only added changes that looked reasonable,=0D
omitting many cases of converting common words like "stop",=0D
"transaction", "eject", "String" etc when it wasn't immediately clear=0D
that it was appropriate. I probably missed a few ... in either=0D
direction.=0D
=0D
I'd like to ask maintainers for each subsystem to review the changes and=0D
confirm that they make sense. To make it easy for you, here's a link to=0D
each module that was changed, in order:=0D
=0D
1/18 acpi=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#acpi=0D
2/18 authz=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#user-authorizati=
on=0D
3/18 block=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#block-devices=0D
4/18 crypto=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#cryptography-dev=
ices=0D
5/18 dump=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#dump-guest-memor=
y=0D
6/18 job=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#background-jobs=
=0D
7/18 machine=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#machines=0D
8/18 migration=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#migration=0D
9/18 net=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#net-devices=0D
10/18 pci=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#pci=0D
11/18 QOM=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#qemu-object-mode=
l-qom=0D
12/18 replay=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#record-replay=0D
13/18 run-state=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#vm-run-state=0D
14/18 sockets=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#socket-data-type=
s=0D
15/18 ui=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#remote-desktop=0D
16/18 virtio=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#virtio-devices=0D
17/18 yank=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#yank-feature=0D
18/18 misc=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#qmp-monitor-cont=
rol=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#ebpf-objects=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#qmp-introspectio=
n=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#module-QMP-misc-=
arm=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#module-QMP-misc-=
i386=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#module-QMP-misc=
=0D
    https://jsnow.gitlab.io/qemu/interop/qemu-qmp-ref.html#module-QMP-stats=
=0D
=0D
A few benefits of doing this:=0D
=0D
(1) It makes the docs easier to navigate for users, being able to just=0D
    click to the referred data type / enum / event / command / etc.=0D
=0D
(2) It helps prevent bitrot: if the name of a command / event / data=0D
    type / etc changes, the cross-reference will cause the build to=0D
    fail, giving a needed hint that documentation elsewhere needs to be=0D
    updated.=0D
=0D
(3) Prompting the maintainers to review the generated HTML documentation=0D
    O:-)=0D
=0D
A few hints for maintainers should they wish to try their own hand at=0D
improving the documentation for their subsystems:=0D
=0D
 *  Try building docs from your build directory like this:=0D
    > DEBUG=3D1 pyvenv/bin/sphinx-build -v -j 1 -b html -d docs/manual.p/ .=
./docs/ docs/manual/;=0D
=0D
    Limiting to one thread makes sphinx errors more verbose (and=0D
    helpful), and if you run into rST formatting errors, you can view=0D
    the 'qapi_qapi-schema.ir' artifact in the build directory (DEBUG=3D1=0D
    causes this to exist) to examine the intermediate rST source code so=0D
    you don't have to fight with the QAPI parsing subsystem to=0D
    understand what happened.=0D
=0D
 *  html docs of interest will be in=0D
    docs/manual/interop/qemu-qmp-ref.html=0D
=0D
 *  QMP reference index will be at docs/manual/qapi-qmp-index.html=0D
=0D
 *  QAPI-specific cross-referencing syntax is documented at=0D
    https://www.qemu.org/docs/master/devel/qapi-domain.html#cross-reference=
s=0D
=0D
 *  QMP Example syntax is documented towards the bottom of this QAPI=0D
    codegen section:=0D
    https://www.qemu.org/docs/master/devel/qapi-code-gen.html#definition-do=
cumentation=0D
=0D
John Snow (18):=0D
  qapi: add cross-references to acpi.json=0D
  qapi: add cross-references to authz.json=0D
  qapi: add cross-references to block layer=0D
  qapi: add cross-references to crypto.json=0D
  qapi: add cross-references to dump.json=0D
  qapi: add cross-references to job.json=0D
  qapi: add cross-references to Machine core=0D
  qapi: add cross-references to migration.json=0D
  qapi: add cross-references to net.json=0D
  qapi: add cross-references to pci.json=0D
  qapi: add cross-references to QOM=0D
  qapi: add cross-references to replay.json=0D
  qapi: add cross-references to run-state.json=0D
  qapi: add cross-references to sockets.json=0D
  qapi: add cross-references to ui.json=0D
  qapi: add cross-references to virtio.json=0D
  qapi: add cross-references to yank.json=0D
  qapi: add cross-references to misc modules=0D
=0D
 qapi/acpi.json           |   2 +-=0D
 qapi/authz.json          |   2 +-=0D
 qapi/block-core.json     | 188 +++++++++++++++++++--------------------=0D
 qapi/block-export.json   |  36 ++++----=0D
 qapi/block.json          |  14 +--=0D
 qapi/control.json        |   2 +-=0D
 qapi/crypto.json         |   4 +-=0D
 qapi/dump.json           |  12 +--=0D
 qapi/ebpf.json           |   2 +-=0D
 qapi/introspect.json     |  24 ++---=0D
 qapi/job.json            |  71 +++++++--------=0D
 qapi/machine-common.json |  20 ++---=0D
 qapi/machine.json        |  82 ++++++++---------=0D
 qapi/migration.json      |  68 +++++++-------=0D
 qapi/misc-arm.json       |   4 +-=0D
 qapi/misc-i386.json      |   2 +-=0D
 qapi/misc.json           |  12 +--=0D
 qapi/net.json            |   6 +-=0D
 qapi/pci.json            |   2 +-=0D
 qapi/qdev.json           |   4 +-=0D
 qapi/qom.json            |  13 +--=0D
 qapi/replay.json         |  10 +--=0D
 qapi/run-state.json      |  46 +++++-----=0D
 qapi/sockets.json        |   6 +-=0D
 qapi/stats.json          |   8 +-=0D
 qapi/transaction.json    |  12 +--=0D
 qapi/ui.json             |  34 +++----=0D
 qapi/virtio.json         |   8 +-=0D
 qapi/yank.json           |  16 ++--=0D
 29 files changed, 356 insertions(+), 354 deletions(-)=0D
=0D
-- =0D
2.50.0=0D
=0D


