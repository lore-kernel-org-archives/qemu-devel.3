Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401CBC87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 05:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukcTX-0001tr-Ro; Sat, 09 Aug 2025 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTU-0001sY-Oz
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTS-0002Hc-OB
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754718633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b+XtEW6a+uvMAeiTCwif7B3pbtKpCw6If5PGOYykHkE=;
 b=Pf/DX4SoYiTy6Yq8TbJd/n4yRC+zgHbl4SZRrd3VyAmPonWERgutKqn6La1qVa+MKHZ/91
 nIGj+Fz/UrPalFLuyodJNjz3V7mVuHdwQz2u0HmLMHiLwZ7WUe3XlsDXW4lhqPUCaezwhV
 wdyKF3r9NBdTmJbYusKf4VfZQOXEw9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-JOgAo1Z_P0STedTsMchHTA-1; Sat,
 09 Aug 2025 01:50:31 -0400
X-MC-Unique: JOgAo1Z_P0STedTsMchHTA-1
X-Mimecast-MFC-AGG-ID: JOgAo1Z_P0STedTsMchHTA_1754718630
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 370B91956089
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF93E195419C
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E746721E6A27; Sat, 09 Aug 2025 07:50:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/3] QAPI patches for 2025-08-09
Date: Sat,  9 Aug 2025 07:50:23 +0200
Message-ID: <20250809055026.2944835-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit a74434580e1051bff12ab5eee5586058295c497f:

  Merge tag 'pull-loongarch-20250808' of https://github.com/gaosong715/qemu into staging (2025-08-08 09:49:06 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-08-09

for you to fetch changes up to 79f57adce686d0027608af4be363cde2409e5740:

  docs/devel/qapi-code-gen: Update cross-reference syntax (2025-08-09 07:20:24 +0200)

----------------------------------------------------------------
QAPI patches for 2025-08-09

----------------------------------------------------------------
Markus Armbruster (3):
      docs/devel/qapi-code-gen: Add two cross-references we missed
      docs/devel/qapi-code-gen: Fix typos in QAPI schema language grammar
      docs/devel/qapi-code-gen: Update cross-reference syntax

 docs/devel/qapi-code-gen.rst | 19 ++++++++++++-------
 docs/devel/qapi-domain.rst   |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.49.0


