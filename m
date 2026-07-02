Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F0CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGiH-0004gj-9X; Thu, 02 Jul 2026 08:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi4-0004c2-Si
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi1-0000ZD-86
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782996000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WFXpZmWZivHn/mnnlm8BZ9KEjuFoeFExb49p1aFD4o8=;
 b=VbgIJDIId98qwPfcFS4wxB8G0HDF5Oewe2vsarIuWCpAPjZBZ5FB/erP21omftjrAlZ93Z
 MGQDE+kKd2VpVnqUMHPXm2ocn5kHZFoFrPiLilSybt7DIzX4l9Tbf4vQa3HA3OE6f/rgSt
 6t/v1rJA/IEVxAJGnoqC7VGMAkQfEU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-v4LiRNhtMU2vWtQzEiOOTw-1; Thu,
 02 Jul 2026 08:39:58 -0400
X-MC-Unique: v4LiRNhtMU2vWtQzEiOOTw-1
X-Mimecast-MFC-AGG-ID: v4LiRNhtMU2vWtQzEiOOTw_1782995998
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E43CB187959E
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 12:39:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A23401966676
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 12:39:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 007C121E6920; Thu, 02 Jul 2026 14:39:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/7] QObject patches for 2026-07-02
Date: Thu,  2 Jul 2026 14:39:47 +0200
Message-ID: <20260702123954.1284221-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit a59157f98f0b69b0bbdb26bc15fbc4d6c8060799:

  Merge tag 'pull-riscv-to-apply-20260701' of https://github.com/alistair23/qemu into staging (2026-07-02 10:44:50 +0200)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qobject-2026-07-02

for you to fetch changes up to b6368e7c77aad190f44570f589ccaa4b5cb4818d:

  json-parser: add location to JSON parsing errors (2026-07-02 13:56:35 +0200)

----------------------------------------------------------------
QObject patches for 2026-07-02

----------------------------------------------------------------
Bin Guo (1):
      qobject/json-writer: preallocate output buffer

Paolo Bonzini (6):
      json-parser: replace with a push parser
      json-streamer: reuse parser
      json-streamer: make brace/bracket count unsigned
      json-streamer: remove token queue
      json-streamer: do not heap-allocate JSONToken
      json-parser: add location to JSON parsing errors

 include/qobject/json-parser.h |  16 +-
 qobject/json-parser-int.h     |  13 +-
 qobject/json-lexer.c          |  11 +-
 qobject/json-parser.c         | 591 ++++++++++++++++++++++++------------------
 qobject/json-streamer.c       | 121 +++++----
 qobject/json-writer.c         |   5 +-
 6 files changed, 433 insertions(+), 324 deletions(-)

-- 
2.54.0


