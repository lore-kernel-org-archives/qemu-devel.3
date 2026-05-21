Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FDFCD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Z4-0004aS-Vf; Thu, 21 May 2026 07:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wQ1Yw-0004Vd-2c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wQ1Yu-0003Tw-H2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779362854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VNeSXasEeHVXwvsst1r1BmMeNA9A1woC8jHGGfDidEM=;
 b=IssjUv1yegagGjfDZF0FoA4SNHwjLi2QOom1UVQUUIQfmlFDfI3fxIdMFONPi19z2nl3Pl
 33eX1x1vbDEd2RTAzl87EVzIb24pgzsPqxDpPbmheHC3t8dwyzscJY+D0UP2sVHZTzA5+5
 z0cGfoGXGj4l1QJXkxw2O84WM3uijWg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-05lE2vWgOuadH1mXvwM39g-1; Thu,
 21 May 2026 07:27:32 -0400
X-MC-Unique: 05lE2vWgOuadH1mXvwM39g-1
X-Mimecast-MFC-AGG-ID: 05lE2vWgOuadH1mXvwM39g_1779362852
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12EF419560B1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:27:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C37AA1685
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:27:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 408D421E6A01; Thu, 21 May 2026 13:27:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/4] QAPI patches for 2026-05-21
Date: Thu, 21 May 2026 13:27:25 +0200
Message-ID: <20260521112729.1287282-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 3f129ea545f16e82b5e43fcc3866b134b7cc4dfc:

  Merge tag 'pull-vfio-20260520' of https://github.com/legoater/qemu into staging (2026-05-20 16:53:28 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-05-21

for you to fetch changes up to 11a19ad20e2f8bf636c6c94f5437235f34f20481:

  qapi/net: Drop unused type String (2026-05-21 13:11:05 +0200)

----------------------------------------------------------------
QAPI patches for 2026-05-21

----------------------------------------------------------------
Markus Armbruster (4):
      qapi/net: Rename NetDevPasstOptions to NetdevPasstOptions
      qapi/net: Wean passt off QAPI type String to improve documentation
      qapi/net: Wean SLIRP off QAPI type String to improve documentation
      qapi/net: Drop unused type String

 qapi/net.json | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 net/passt.c   | 10 +++---
 net/slirp.c   | 27 ++++++++++++----
 3 files changed, 110 insertions(+), 25 deletions(-)

-- 
2.54.0


