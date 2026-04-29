Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB21CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAYH-0006IB-9F; Wed, 29 Apr 2026 15:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYE-0006Bg-J2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYC-0007dk-Tu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777490782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gE7lnCa/yZ2FWSaG/fHh3KUOFynL2xQEVw/BkW7oA90=;
 b=OGLFFZaX2uiFtCaZD+gUnwUc2Btu+uzeiTN12Ek3yFqfQXLmX5M8qoEF/SiXZc6z1dO2rW
 wKje3VFy+SPokWizPh3RkQOIHxO9jZ+jrPCAfzi+ViCyAxWfgPnLYEesxLLec+t2Sjg8+2
 O1WQXVErDa+zx8Jw4O20GJ69z0op8RI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-xHU29jW2PUOFt8HqY24IHw-1; Wed,
 29 Apr 2026 15:26:19 -0400
X-MC-Unique: xHU29jW2PUOFt8HqY24IHw-1
X-Mimecast-MFC-AGG-ID: xHU29jW2PUOFt8HqY24IHw_1777490777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 863411800578; Wed, 29 Apr 2026 19:26:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8755F180045E; Wed, 29 Apr 2026 19:26:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 00/13] qapi: add formal "intro" section
Date: Wed, 29 Apr 2026 15:25:58 -0400
Message-ID: <20260429192611.1581223-1-jsnow@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hiya, this is a series that explores a potential syntax for a=0D
designated "Intro" section. Markus knows why I want this, but for=0D
everyone else: a designated "Introduction" section is useful for the=0D
desired "inliner" feature for the new QAPI doc system. Commits explain=0D
a bit more. This is prep work and doesn't really change anything=0D
tangibly except source code syntax for the QAPI docs.=0D
=0D
It is designed so that this conversion can happen incrementally with=0D
no actual difference to the rendered manuals, so each QAPI module can=0D
be converted one at a time for easier review and merging in an=0D
arbitrary order.=0D
=0D
This series demonstrates conversion of just four modules; if I'm given=0D
a thumbs up, I will convert the rest of QAPI, one module (or=0D
maintainer stanza) per patch like how I handled adding=0D
cross-references.=0D
=0D
**=0D
=0D
V2: punt intro sections to the subsequent line and adjust the parser=0D
accordingly. Left as an RFC patch that undoes some things this series=0D
does instead of properly factoring into the series.=0D
=0D
John Snow (13):=0D
  tests/qapi: generate output in source order=0D
  qapi/docs: remove unused QAPIDoc subsection members=0D
  qapi/docs: make remaining subsection members "private"=0D
  qapi/docs: add "Intro" section=0D
  qapi/docs: adjust stub member insertion algorithm=0D
  qapi/docs: remove implicit Plain section=0D
  qapi/docs: add "Intro" section parsing=0D
  qapi/docs: Add rendering for INTRO sections=0D
  qapi: convert intro sections for accelerator.json=0D
  qapi: convert intro sections for acpi-hest.json=0D
  qapi: convert intro sections for acpi.json=0D
  qapi: convert intro sections for audio.json=0D
  rfc: intro starts on next line=0D
=0D
 docs/devel/qapi-code-gen.rst   |  17 ++-=0D
 docs/sphinx/qapidoc.py         |  53 +++++----=0D
 qapi/accelerator.json          |  18 +--=0D
 qapi/acpi-hest.json            |   4 +-=0D
 qapi/acpi.json                 |  18 ++-=0D
 qapi/audio.json                |  88 ++++++---------=0D
 scripts/qapi/parser.py         | 198 ++++++++++++++++++++-------------=0D
 tests/qapi-schema/doc-good.out |  30 ++---=0D
 tests/qapi-schema/test-qapi.py |  15 +--=0D
 9 files changed, 231 insertions(+), 210 deletions(-)=0D
=0D
-- =0D
2.54.0=0D
=0D


