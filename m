Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8982CF11FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 15:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syuft-0000Qr-03; Thu, 10 Oct 2024 11:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syufq-0000MA-Ax
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syufo-0003FY-Tc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728572512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=92PoynvRG7djx29s+xhSGUZS1Z6GrPCHy82qSzUpVrE=;
 b=JMPkr7alB7dhqULq+1NQqYCnR2LdPjS4H4grIG04B4U6M/yaUv7uW1s6rfuEjc3ff5yZrB
 OfNxfGosBI/SHznN/nSgb1MHReI3L71wFb/Fg2oawXb7zpaRKD7nTTjVACsRh+3syfsPU0
 1owhFW1b9nfyBWkctlMGD4hyTMMJNcQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-yTi0Hc8vPCadPny8HgE9Ng-1; Thu,
 10 Oct 2024 11:01:49 -0400
X-MC-Unique: yTi0Hc8vPCadPny8HgE9Ng-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37B7C195604F; Thu, 10 Oct 2024 15:01:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A76CB19560A2; Thu, 10 Oct 2024 15:01:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17E2A21E6A28; Thu, 10 Oct 2024 17:01:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 0/7] error: Eliminate QERR_PROPERTY_VALUE_OUT_OF_RANGE
Date: Thu, 10 Oct 2024 17:01:37 +0200
Message-ID: <20241010150144.986655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster (7):
  error: Drop superfluous #include "qapi/qmp/qerror.h"
  block: Improve errors about block sizes
  block: Adjust check_block_size() signature
  target/i386/cpu: Avoid mixing signed and unsigned in property setters
  target/i386/cpu: Improve errors for out of bounds property values
  hw/intc/openpic: Improve errors for out of bounds property values
  qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no longer used, drop

 include/qapi/qmp/qerror.h            |  3 --
 util/block-helpers.h                 |  3 +-
 block/export/vduse-blk.c             |  7 +---
 block/export/vhost-user-blk-server.c |  6 +--
 hw/core/qdev-properties-system.c     |  6 +--
 hw/intc/openpic.c                    |  5 +--
 qga/commands-bsd.c                   |  1 -
 qga/commands-linux.c                 |  1 -
 qga/commands-posix.c                 |  1 -
 target/i386/cpu.c                    | 59 +++++++++++++---------------
 util/block-helpers.c                 | 28 ++++++-------
 11 files changed, 46 insertions(+), 74 deletions(-)

-- 
2.46.0


