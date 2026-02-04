Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638A5E9539B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncjb-0007eg-W5; Wed, 04 Feb 2026 08:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vncja-0007cI-GX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vncjY-00015b-7J
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GGk0mTdNsiXzXdTsnv2+zVTx31ANWxYPzgHEuu4AppU=;
 b=bXldSUnfnnhvo3WDWD83CVprBJM3+h4pa6R+UriqOlavYacxSmdcyg0yk+EIFzmf+rnJCf
 RjPMuZqqjuLnlBAnVwPiMiQnYgyoE5ZmP9ucNoqOU4Jtmd06ceUrEIiRYaKyDUQr13PKHf
 zvLabxWwMKQY8M3fCRim6CGph2u1yyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-PfEC_D5kNniQj1QGibEkDw-1; Wed,
 04 Feb 2026 08:15:49 -0500
X-MC-Unique: PfEC_D5kNniQj1QGibEkDw-1
X-Mimecast-MFC-AGG-ID: PfEC_D5kNniQj1QGibEkDw_1770210948
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27A1E1956094; Wed,  4 Feb 2026 13:15:48 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.45.242.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D8E430001B9; Wed,  4 Feb 2026 13:15:45 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 0/2] block: Wire up 'flat' mode also for 'query-block'
Date: Wed,  4 Feb 2026 14:15:42 +0100
Message-ID: <cover.1770210044.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v4:
 - No need to check 'has_flat', as qemu doesn't have warnings about
   unused variables active (Markus)
 - Doc wording tweak (Markus)

v3:
 - Doc wording tweak (Eric)

v2:
 - More descriptive docs text for the new QAPI option (Markus; new
   wording not approved)
 - use new options in hmp_nbd_server_start to avoid fetching unused
   backing image info, impossible in 'info block' worker (Markus)

Peter Krempa (2):
  block: Wire up 'flat' mode also for 'query-block'
  hmp_nbd_server_start: Don't ask for backing image data

 block/monitor/block-hmp-cmds.c | 4 ++--
 block/qapi.c                   | 8 ++++----
 qapi/block-core.json           | 5 +++++
 ui/cocoa.m                     | 2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.52.0


