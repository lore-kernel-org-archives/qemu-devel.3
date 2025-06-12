Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37762C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPpgu-0001ZY-H6; Thu, 12 Jun 2025 17:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPpgo-0001X1-9X
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPpgl-0007PG-Hn
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749764542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aWS99UWLXj4sQrahG4E3anvU4lEAGcXR3CIr/MixifA=;
 b=WhGb0hPzE+MzPJeXUS3NpXqdiREBBl/oMTc9mfEnTgpF45VMmuoMHeibt45StBi0qN6Rkr
 5WDJwVZR8ZA8y8C7GC+VBDIklRpP6mLVKbf7Wfr4tlkChSUrZacCXuOr9oVPxcQo6V3zAh
 nt5RiOLlJHjXMZHr3CiiMjqHyJJ9k+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-Smo1Q3kWPaKwcJTJIIf6IQ-1; Thu,
 12 Jun 2025 17:42:20 -0400
X-MC-Unique: Smo1Q3kWPaKwcJTJIIf6IQ-1
X-Mimecast-MFC-AGG-ID: Smo1Q3kWPaKwcJTJIIf6IQ_1749764533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A569D180028D; Thu, 12 Jun 2025 21:42:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A34118003FC; Thu, 12 Jun 2025 21:42:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v4 0/4] qapi: add auto-generated return docs
Date: Thu, 12 Jun 2025 17:41:56 -0400
Message-ID: <20250612214200.1208340-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series adds the ability for the new QAPIDoc system to generate=0D
"Returns:" documentation based on the return type declared in the Schema=0D
even when no explicit documentation is found in the QAPI source. As a=0D
result and as an immediate cleanup, trivial return statements are=0D
removed and remaining Return documentation is revised to avoid=0D
re-stating the return type, which is always generated automatically.=0D
=0D
For non-QAPI maintainers: You're likely being CC'd because of patches 3=0D
& 4, which touches nearly every subsystem's QAPI documentation. Let me=0D
know if you see any obvious issues. Don't worry about patches 1 & 2=0D
unless you're particularly bored.=0D
=0D
v4: rebased on origin/master (2025-06-12)=0D
=0D
Review comments:=0D
=0D
    Markus: From what I recall, you had questions concerning the=0D
    insertion position of the "Returns:" stub in patch 2. I picked=0D
    something somewhat arbitrarily, and you were uneasy with the=0D
    laissez-faire approach. I'm more than happy to change it, but=0D
    request that you decide on the order/algorithm for insertion.=0D
=0D
    From memory, I chose an insertion position that favors putting=0D
    "Returns:" as the last info field; i.e. if any other info fields are=0D
    present, we put ours immediately after the last one. If there are=0D
    none at all, we just put it last. This may or may not cause ordering=0D
    issues depending on your taste.=0D
=0D
    (I am also content to change *where* the insertion occurs, but I=0D
    think inserting it in the parser makes enough sense to leave it=0D
    alone, unless you have concerns.)=0D
=0D
    Patch 3 should be fine, though possibly incomplete depending on taste.=
=0D
=0D
    Patch 4 is the likeliest to be subject to copyediting nits, and on=0D
    this patch I heavily encourage you to write your own fixup patch=0D
    which I will *happily and with glee* merge into this patch. Whatever=0D
    phrasing you prefer here I am more than happy to take. You did in=0D
    fact have a number of nits in response to v1/v2, but I admit I did=0D
    not apply them - in favor of nudging you to do the copy-editing=0D
    you'd like to see directly instead. (Sorry!)=0D
=0D
    This patch is also possibly incomplete depending on taste.=0D
=0D
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
 scripts/qapi/parser.py     | 15 +++++++++++++++=0D
 scripts/qapi/schema.py     |  3 +++=0D
 31 files changed, 92 insertions(+), 132 deletions(-)=0D
=0D
-- =0D
2.48.1=0D
=0D


