Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB30C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP777-0000d6-6p; Wed, 03 Jul 2024 17:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP775-0000cu-DR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP773-00088E-H2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720040519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jPl2Libghn/zK5iVAyW17gBHT+3bCBjv9cgXjDBY2vk=;
 b=WgC/Zm6odKNLXaYZ2j7fE4crRv3MOQC5cYvHfsBhrb+by9nEgIroLEMVQgRAF9WHpFyYae
 Q7OZh7TQhhPZk3jpkr6YQ20PIOV1xVidWkVB+IWxY9nMVaUeJCRWr67DujG7fpnKExw9/h
 Su6/qXTUzXSaUAj8dnaWyNEGeP9khGg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-XRuf3J2RMsiNOwUBt60DGg-1; Wed,
 03 Jul 2024 17:01:56 -0400
X-MC-Unique: XRuf3J2RMsiNOwUBt60DGg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4CC219560B2; Wed,  3 Jul 2024 21:01:53 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C0271955F21; Wed,  3 Jul 2024 21:01:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 0/8] qapi: convert example sections to qmp-example rST
 directives
Date: Wed,  3 Jul 2024 17:01:35 -0400
Message-ID: <20240703210144.339530-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

GitLab: https://gitlab.com/jsnow/qemu/-/pipelines/1359714660=0D
=0D
This patchset focuses on converting example sections to rST directives=0D
using a new `.. qmp-example::` directive.=0D
=0D
It is based on what I *assume* will be Markus' next pull request that=0D
covers note conversion. Pull these patches from GitLab directly if=0D
that's too annoying:=0D
https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-prereqs-examples=0D
=0D
It is also annoyingly the case that both Markus' next pull request and=0D
this series conflicts with a separate series I sent out, "docs/python:=0D
bump minimum Sphinx version" - so it's extremely likely I'll need to=0D
rebase and respin this series depending on what goes in and in what=0D
order. Ah well...=0D
=0D
Changes since this was split out from the prior series:=0D
=0D
- Harmonie updated the CSS for the example block section.=0D
  I think it's really tidy now! Thanks Harmonie!=0D
- Dependence on SphinxDirective was removed, but it will likely=0D
  re-appear in the next series anyway.=0D
- qapi-code-gen.rst was updated with a section on how to write examples.=0D
- Various minor tweaks to comments, commit messages, docs, etc.=0D
=0D
Harmonie Snow (1):=0D
  docs/sphinx: add CSS styling for qmp-example directive=0D
=0D
John Snow (7):=0D
  docs/qapidoc: factor out do_parse()=0D
  docs/qapidoc: create qmp-example directive=0D
  docs/qapidoc: add QMP highlighting to annotated qmp-example blocks=0D
  qapi: convert "Example" sections without titles=0D
  qapi: convert "Example" sections with titles=0D
  qapi: convert "Example" sections with longer prose=0D
  qapi: remove "Example" doc section=0D
=0D
 docs/devel/qapi-code-gen.rst           |  58 +++++++--=0D
 docs/sphinx-static/theme_overrides.css |  49 ++++++++=0D
 docs/sphinx/qapidoc.py                 | 156 +++++++++++++++++++++----=0D
 qapi/acpi.json                         |   4 +-=0D
 qapi/block-core.json                   |  88 +++++++-------=0D
 qapi/block.json                        |  57 +++++----=0D
 qapi/char.json                         |  24 ++--=0D
 qapi/control.json                      |   8 +-=0D
 qapi/dump.json                         |   8 +-=0D
 qapi/machine-target.json               |   2 +-=0D
 qapi/machine.json                      |  68 ++++++-----=0D
 qapi/migration.json                    |  90 +++++++-------=0D
 qapi/misc-target.json                  |  22 ++--=0D
 qapi/misc.json                         |  32 ++---=0D
 qapi/net.json                          |  20 ++--=0D
 qapi/pci.json                          |   2 +-=0D
 qapi/qdev.json                         |  10 +-=0D
 qapi/qom.json                          |  16 +--=0D
 qapi/replay.json                       |   8 +-=0D
 qapi/rocker.json                       |   8 +-=0D
 qapi/run-state.json                    |  30 ++---=0D
 qapi/tpm.json                          |   6 +-=0D
 qapi/trace.json                        |   4 +-=0D
 qapi/transaction.json                  |   2 +-=0D
 qapi/ui.json                           |  45 +++----=0D
 qapi/vfio.json                         |   2 +-=0D
 qapi/virtio.json                       |  45 ++++---=0D
 qapi/yank.json                         |   4 +-=0D
 scripts/qapi/parser.py                 |  10 +-=0D
 tests/qapi-schema/doc-good.json        |  19 +--=0D
 tests/qapi-schema/doc-good.out         |  26 +++--=0D
 tests/qapi-schema/doc-good.txt         |  23 ++--=0D
 32 files changed, 605 insertions(+), 341 deletions(-)=0D
=0D
-- =0D
2.45.0=0D
=0D


