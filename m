Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD86C7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 22:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPq8l-00044n-ME; Thu, 12 Jun 2025 18:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPq8j-000442-Gm
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPq8h-0002wA-QM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749766273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JjwJ+gnqJF2GY4dH2XDgjqiBjMl6rUAWixECp9uYfqg=;
 b=J+jS1W6l3M4FtHGnsJGHr0DE8PvCjNN6U8CN/yCv4LLUPBoKMh0oHwIn9BdLXhmg6y/I4C
 uQUSMGHrJaFbpDL4F6msaY8datkZfVZ9p9t6lNZyDn+iUjaUKlCzUrLAVvk6BWGhZPEpXy
 09ZE7TAp1CK26B1TXpaOzj0OeVnQil0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-xkeE8O3mNE-_Kcz5MN0qBA-1; Thu,
 12 Jun 2025 18:11:09 -0400
X-MC-Unique: xkeE8O3mNE-_Kcz5MN0qBA-1
X-Mimecast-MFC-AGG-ID: xkeE8O3mNE-_Kcz5MN0qBA_1749766267
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01D04195608C; Thu, 12 Jun 2025 22:11:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1553119560A3; Thu, 12 Jun 2025 22:10:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Jiri Pirko <jiri@resnulli.us>,
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/3] docs: remove legacy qapidoc
Date: Thu, 12 Jun 2025 18:10:48 -0400
Message-ID: <20250612221051.1224565-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Remove docs/sphinx/qapidoc_legacy.py, and remove special parsing of=0D
freeform QAPI documentation block sections in favor of using standard=0D
rST syntax that is included in the final document with no special=0D
parsing or post-processing.=0D
=0D
v2:=0D
 - rebased on origin/master (2025-06-12)=0D
 - Revised commit messages with increased detail=0D
=0D
Markus: this one should be pretty short and sweet with good=0D
payoff. Makes a good candidate for your first post-vacation review ;)=0D
=0D
John Snow (3):=0D
  docs: fix errors formatting in tests/qapi-schema/doc-good=0D
  docs: remove legacy QAPI manual generator=0D
  docs: remove special parsing for freeform sections=0D
=0D
 docs/devel/qapi-code-gen.rst                 |  28 +-=0D
 docs/interop/firmware.json                   |   4 +-=0D
 docs/interop/qemu-ga-ref.rst                 |   1 -=0D
 docs/interop/qemu-qmp-ref.rst                |   1 -=0D
 docs/interop/qemu-storage-daemon-qmp-ref.rst |   1 -=0D
 docs/interop/vhost-user.json                 |   4 +-=0D
 docs/sphinx/qapidoc.py                       |  62 +--=0D
 docs/sphinx/qapidoc_legacy.py                | 440 -------------------=0D
 qapi/acpi.json                               |   4 +-=0D
 qapi/audio.json                              |   4 +-=0D
 qapi/authz.json                              |   4 +-=0D
 qapi/block-core.json                         |   3 +-=0D
 qapi/block-export.json                       |   3 +-=0D
 qapi/block.json                              |   7 +-=0D
 qapi/char.json                               |   4 +-=0D
 qapi/common.json                             |   4 +-=0D
 qapi/compat.json                             |   4 +-=0D
 qapi/control.json                            |   4 +-=0D
 qapi/crypto.json                             |   4 +-=0D
 qapi/cryptodev.json                          |   4 +-=0D
 qapi/cxl.json                                |   4 +-=0D
 qapi/dump.json                               |   4 +-=0D
 qapi/ebpf.json                               |   4 +-=0D
 qapi/error.json                              |   4 +-=0D
 qapi/introspect.json                         |   4 +-=0D
 qapi/job.json                                |   4 +-=0D
 qapi/machine-common.json                     |   4 +-=0D
 qapi/machine.json                            |   4 +-=0D
 qapi/migration.json                          |   4 +-=0D
 qapi/misc.json                               |   4 +-=0D
 qapi/net.json                                |   4 +-=0D
 qapi/pci.json                                |   4 +-=0D
 qapi/qapi-schema.json                        |   4 +-=0D
 qapi/qdev.json                               |   4 +-=0D
 qapi/qom.json                                |   4 +-=0D
 qapi/replay.json                             |   4 +-=0D
 qapi/rocker.json                             |   4 +-=0D
 qapi/run-state.json                          |   4 +-=0D
 qapi/sockets.json                            |   4 +-=0D
 qapi/stats.json                              |   4 +-=0D
 qapi/tpm.json                                |   4 +-=0D
 qapi/trace.json                              |   4 +-=0D
 qapi/transaction.json                        |   4 +-=0D
 qapi/uefi.json                               |   4 +-=0D
 qapi/ui.json                                 |  14 +-=0D
 qapi/vfio.json                               |   4 +-=0D
 qapi/virtio.json                             |   4 +-=0D
 qapi/yank.json                               |   4 +-=0D
 python/tests/qapi-isort.sh                   |   2 +-=0D
 scripts/qapi/parser.py                       |   7 -=0D
 storage-daemon/qapi/qapi-schema.json         |   8 +-=0D
 tests/qapi-schema/doc-good.json              |  13 +-=0D
 52 files changed, 170 insertions(+), 572 deletions(-)=0D
 delete mode 100644 docs/sphinx/qapidoc_legacy.py=0D
=0D
-- =0D
2.48.1=0D
=0D


