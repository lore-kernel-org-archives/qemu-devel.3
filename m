Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE42CA0EF5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 04:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoauA-0002Ed-1L; Wed, 20 Aug 2025 00:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoau7-0002Dr-17
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 00:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoau4-0007rc-LD
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 00:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755665906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BUbQ6Sv9Q+F//GWNkFhhOKbSVT4vRjeQX5IdXIiV4eE=;
 b=MLV+b5BFQeJXvFX/v08PFAhY+8e6/lmo4tZMxe69fj7kcI7aloLbY1m50A2l4MUmb5zVwl
 GrQ/dSz4z2909pATNIbq76R6ZMDPsB8NThupID7a1UncqAQy7CSivzW7PQqeHwZ8nks2Wl
 MX8Zn8L3kyCdEOSybUTWdFtZT1jcF9U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-8RVPxwpoOXu0_jh1W3NBLw-1; Wed,
 20 Aug 2025 00:58:22 -0400
X-MC-Unique: 8RVPxwpoOXu0_jh1W3NBLw-1
X-Mimecast-MFC-AGG-ID: 8RVPxwpoOXu0_jh1W3NBLw_1755665901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95F21955D48; Wed, 20 Aug 2025 04:58:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E3CA1800447; Wed, 20 Aug 2025 04:58:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 0/2] Python patches
Date: Wed, 20 Aug 2025 00:58:14 -0400
Message-ID: <20250820045816.1142190-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 5836af0783213b9355a6bbf85d9e6bc4c9c9363f=
:=0D
=0D
  Merge tag 'uefi-20250812-pull-request' of https://gitlab.com/kraxel/qemu =
into staging (2025-08-13 15:19:29 -0400)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 16398e73cd13c7d9f284d8ec4a440778fc2e3f9a:=0D
=0D
  python: avoid deprecation warning with get_event_loop (2025-08-20 00:55:2=
7 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python pull request=0D
=0D
Necessary for Python 3.14 support for iotests, releasing October 7th=0D
=0D
----------------------------------------------------------------=0D
=0D
Daniel P. Berrang=C3=A9 (1):=0D
  python: avoid deprecation warning with get_event_loop=0D
=0D
Richard W.M. Jones (1):=0D
  python: Replace asyncio.get_event_loop for Python 3.14=0D
=0D
 python/qemu/qmp/legacy.py  | 10 +++++++++-=0D
 python/qemu/qmp/qmp_tui.py |  2 +-=0D
 python/tests/protocol.py   |  2 +-=0D
 3 files changed, 11 insertions(+), 3 deletions(-)=0D
=0D
-- =0D
2.50.1=0D
=0D


