Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA53C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 18:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIX52-0000bE-Vq; Fri, 23 May 2025 14:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIX4y-0000XW-9s
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIX4w-00036Y-O6
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748024710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MowPuyafokaa+aumB5Q/UtEV3bsIZFGBtc/UrpEe/8c=;
 b=XyAAzElj84c8+7TSmgYeEhEPkGMc6mG1p3KR5jCPe7jtfLizdHHj5S5UjdcT7QNqYxnczs
 Lr2SvgTm8UdY2zS2LuUkXNOp3IJvUSNyTbifT0eEZYFEzqV1MZMsgde8kAuLtn3dll39xt
 NBPPYs/j7aca/II8iHHHa4XJrTstP+Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-MqYExDCqNLu2jwXVtATxbw-1; Fri,
 23 May 2025 14:25:06 -0400
X-MC-Unique: MqYExDCqNLu2jwXVtATxbw-1
X-Mimecast-MFC-AGG-ID: MqYExDCqNLu2jwXVtATxbw_1748024704
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5995E195608C; Fri, 23 May 2025 18:25:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.78])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01B0F1944A89; Fri, 23 May 2025 18:24:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 0/4] qapi: add auto-generated return docs
Date: Fri, 23 May 2025 14:24:38 -0400
Message-ID: <20250523182442.54469-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

v3: rebased on top of python-qapi-linting (v4) pull request;=0D
    removed commits that are no longer needed.=0D
    Markus: I forget where we left off... shall we refresh?=0D
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
 qapi/machine-target.json   |  9 +++------=0D
 qapi/machine.json          | 22 ----------------------=0D
 qapi/migration.json        | 12 ------------=0D
 qapi/misc-target.json      | 14 +-------------=0D
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
 qapi/yank.json             |  1 -=0D
 scripts/qapi/parser.py     | 15 +++++++++++++++=0D
 scripts/qapi/schema.py     |  3 +++=0D
 32 files changed, 95 insertions(+), 140 deletions(-)=0D
=0D
-- =0D
2.48.1=0D
=0D


