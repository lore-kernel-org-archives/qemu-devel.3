Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E15AC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua62Z-00087x-6d; Fri, 11 Jul 2025 01:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua62V-00082U-K3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua62S-0000CM-KU
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752210670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EhcMnZAirSUGw5gILWujayoojGThlXNXL0JKUPFWwiI=;
 b=SEdcFCQ2RiPFLTr8VaW6UEJNPDVbxevQM78SmJimYAB1TEocnhYjW1Kqca1wW5h7LHcDMz
 QXLyNv/s9+r8vqtdCHWqI3jERu5t8XZRZGculTemVofOLMkAVqntpDZpf6hiZsNcUCKzvR
 JG9hPAiQRJyFs0Knl0e7mxUWUfRL7tY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-5xLj_WuHO728-TECIwtQAA-1; Fri,
 11 Jul 2025 01:11:05 -0400
X-MC-Unique: 5xLj_WuHO728-TECIwtQAA-1
X-Mimecast-MFC-AGG-ID: 5xLj_WuHO728-TECIwtQAA_1752210662
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 652F6195608C; Fri, 11 Jul 2025 05:11:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12B5C30001A1; Fri, 11 Jul 2025 05:10:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v6 0/4] qapi: add auto-generated return docs
Date: Fri, 11 Jul 2025 01:10:41 -0400
Message-ID: <20250711051045.51110-1-jsnow@redhat.com>
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

This series adds the ability for the new QAPIDoc system to generate=0D
"Returns:" documentation based on the return type declared in the Schema=0D
even when no explicit documentation is found in the QAPI source. As a=0D
result and as an immediate cleanup, trivial return statements are=0D
removed and remaining Return documentation is revised to avoid=0D
re-stating the return type, which is always generated automatically.=0D
=0D
v6: ... actually read Markus' algorithm and then did that.=0D
    Added a few TODO: separators to improve placement=0D
=0D
    Still kind of wonky: The reason x-debug-block-dirty-bitmap-sha256=0D
    appears to generate oddly is because the "Arguments:" section is=0D
    *also* being generated, and it occurs *after* parsing and schema=0D
    generation, entirely within the doc generator. Mea Culpa: can we=0D
    address this later?=0D
=0D
v5: rebased, implemented Markus' preferred insertion algorithm=0D
=0D
v4: rebased on origin/master (2025-06-12)=0D
=0D
v3: rebased on top of python-qapi-linting (v4) pull request;=0D
    removed commits that are no longer needed.=0D
=0D
v2: fix multi-return-sections bug :(=0D
=0D
John Snow (4):=0D
  docs/qapi-domain: add return-nodesc=0D
  docs, qapi: generate undocumented return sections=0D
  qapi: remove trivial "Returns:" sections=0D
  qapi: rephrase return docs to avoid type name=0D
=0D
 docs/devel/qapi-domain.rst | 30 ++++++++++++++++++++++++++++++=0D
 docs/sphinx/qapi_domain.py |  8 ++++++++=0D
 docs/sphinx/qapidoc.py     | 14 ++++++++------=0D
 qapi/audio.json            |  2 --=0D
 qapi/block-core.json       | 14 +++-----------=0D
 qapi/block-export.json     |  2 +-=0D
 qapi/block.json            |  2 +-=0D
 qapi/char.json             |  8 --------=0D
 qapi/control.json          |  5 ++---=0D
 qapi/cryptodev.json        |  2 --=0D
 qapi/dump.json             |  5 ++---=0D
 qapi/introspect.json       |  6 +++---=0D
 qapi/job.json              |  2 +-=0D
 qapi/machine.json          | 24 ++----------------------=0D
 qapi/migration.json        | 12 ++----------=0D
 qapi/misc-i386.json        | 12 +-----------=0D
 qapi/misc.json             | 12 ++----------=0D
 qapi/net.json              |  2 +-=0D
 qapi/pci.json              |  2 +-=0D
 qapi/qdev.json             |  3 +--=0D
 qapi/qom.json              |  8 +++-----=0D
 qapi/rocker.json           |  4 ----=0D
 qapi/run-state.json        |  2 --=0D
 qapi/stats.json            |  2 +-=0D
 qapi/tpm.json              |  4 ----=0D
 qapi/trace.json            |  2 +-=0D
 qapi/ui.json               | 10 +---------=0D
 qapi/virtio.json           |  8 +++-----=0D
 qapi/yank.json             |  2 +-=0D
 scripts/qapi/parser.py     | 35 +++++++++++++++++++++++++++++++++++=0D
 scripts/qapi/schema.py     |  3 +++=0D
 31 files changed, 117 insertions(+), 130 deletions(-)=0D
=0D
-- =0D
2.50.0=0D
=0D


