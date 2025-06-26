Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1241BC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 19:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUsfj-0000RA-Oc; Thu, 26 Jun 2025 15:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUsfh-0000Ql-7J
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUsfa-0004yR-8P
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750967639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2Acdmgqx3JlB6C7vyrkWlKGIncyEECmo5kGK6ydG8qI=;
 b=XKER2rktsAue5gzR+kn8kVw+4TminfvyPmQ5DVmDC8VYML6pa9HhODNIAN27lgdNrSbV4p
 HXcKUebMLidhx4ONbzfak/YUKWqm6iGIdPsKz258ESVw/j3OJIZpU9t2rexEckB+G1BQ06
 0U9w9tnKU+d3URZAu0ZuUSZRGBy4RzQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-1_WkTurZMNCTVtJCfzQMVQ-1; Thu,
 26 Jun 2025 15:53:55 -0400
X-MC-Unique: 1_WkTurZMNCTVtJCfzQMVQ-1
X-Mimecast-MFC-AGG-ID: 1_WkTurZMNCTVtJCfzQMVQ_1750967633
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2967B1944A83; Thu, 26 Jun 2025 19:53:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0458C30002C0; Thu, 26 Jun 2025 19:53:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Jiri Pirko <jiri@resnulli.us>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Lukas Straub <lukasstraub2@web.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 0/4] qapi: add auto-generated return docs
Date: Thu, 26 Jun 2025 15:53:33 -0400
Message-ID: <20250626195337.2158250-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

This series adds the ability for the new QAPIDoc system to generate=0D
"Returns:" documentation based on the return type declared in the Schema=0D
even when no explicit documentation is found in the QAPI source. As a=0D
result and as an immediate cleanup, trivial return statements are=0D
removed and remaining Return documentation is revised to avoid=0D
re-stating the return type, which is always generated automatically.=0D
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
 qapi/machine.json          | 22 ----------------------=0D
 qapi/migration.json        | 12 ------------=0D
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
 qapi/yank.json             |  1 -=0D
 scripts/qapi/parser.py     | 34 ++++++++++++++++++++++++++++++++++=0D
 scripts/qapi/schema.py     |  3 +++=0D
 31 files changed, 111 insertions(+), 132 deletions(-)=0D
=0D
-- =0D
2.48.1=0D
=0D


