Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF98CF11F5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syuas-0002wm-Kv; Thu, 10 Oct 2024 10:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syuaq-0002va-VR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 10:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syuap-0002jx-3k
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 10:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728572202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=92PoynvRG7djx29s+xhSGUZS1Z6GrPCHy82qSzUpVrE=;
 b=LhjLBzAUysF/f1O0+k0bj87DLGZqoR7rzTuiQ8xZzXDXmLxjTd18/MU+NGbXOBHvUqiIyG
 wYZMYCaGcYJQfjRzat8ov0NbGtBTgZDyxTOWBLVHj8KmG/rAJb8EFTgodj7dl8uNgM2A+V
 jfSNu6sRUk/QElG/2M4kIxdP+aadVho=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-6XtXEJ1zM5SjMzISAHNGdQ-1; Thu,
 10 Oct 2024 10:56:36 -0400
X-MC-Unique: 6XtXEJ1zM5SjMzISAHNGdQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93DD219560B4; Thu, 10 Oct 2024 14:56:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFB071956089; Thu, 10 Oct 2024 14:56:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B19321E6A28; Thu, 10 Oct 2024 16:56:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: [PATCH 0/7] error: Eliminate QERR_PROPERTY_VALUE_OUT_OF_RANGE
Date: Thu, 10 Oct 2024 16:56:23 +0200
Message-ID: <20241010145630.985335-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


