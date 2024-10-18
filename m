Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA520D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n1w-0005hx-PH; Fri, 18 Oct 2024 09:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1v-0005hM-9H
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1t-0007Nj-Ac
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1FC2jC+761e7WwP8qHWQhXxFHLAGdqP3ZXmkxzWQ2rc=;
 b=EUnkJRIILH5HqI37o2LJJceTmtVx3B5PalOib6Dieh6zemswgLjmAaHqkcyVAffU0rmUKr
 MKu1x8qsJYxvnCs4zcJ51hmlT1E7SZvZYloOkggRCtt+AC6NpIFt8Y0EKOZAs2xhHywzv2
 WQK3ksIDeptAYpCO8hrOnjAGM2sdXWw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-og4D-iPbNSa0KiofE1LmZg-1; Fri,
 18 Oct 2024 09:28:28 -0400
X-MC-Unique: og4D-iPbNSa0KiofE1LmZg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB70319560AB; Fri, 18 Oct 2024 13:28:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 942171956086; Fri, 18 Oct 2024 13:28:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47D4821E6A28; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/9] Error reporting patches for 2024-10-18
Date: Fri, 18 Oct 2024 15:28:15 +0200
Message-ID: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

The following changes since commit 95a16ee753d6da651fce8df876333bf7fcf134d9:

  Merge tag 'pull-loongarch-20241016' of https://gitlab.com/gaosong/qemu into staging (2024-10-17 12:42:23 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2024-10-18

for you to fetch changes up to 1824e9fc646c68e42e3f823b208382563ce5dc83:

  qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no longer used, drop (2024-10-18 15:03:35 +0200)

----------------------------------------------------------------
Error reporting patches for 2024-10-18

----------------------------------------------------------------
Markus Armbruster (9):
      qga/qapi-schema: Drop obsolete note on "unsupported" errors
      qga: Improve error for guest-set-user-password parameter @crypted
      error: Drop superfluous #include "qapi/qmp/qerror.h"
      block: Improve errors about block sizes
      block: Adjust check_block_size() signature
      target/i386/cpu: Avoid mixing signed and unsigned in property setters
      target/i386/cpu: Improve errors for out of bounds property values
      hw/intc/openpic: Improve errors for out of bounds property values
      qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no longer used, drop

 qga/qapi-schema.json                 |  9 ------
 include/qapi/qmp/qerror.h            |  6 ----
 util/block-helpers.h                 |  3 +-
 block/export/vduse-blk.c             |  7 ++---
 block/export/vhost-user-blk-server.c |  6 +---
 hw/core/qdev-properties-system.c     |  6 +---
 hw/intc/openpic.c                    |  5 +--
 qga/commands-bsd.c                   |  1 -
 qga/commands-linux.c                 |  1 -
 qga/commands-posix.c                 |  1 -
 qga/commands-win32.c                 |  2 +-
 target/i386/cpu.c                    | 59 +++++++++++++++++-------------------
 util/block-helpers.c                 | 28 ++++++++---------
 13 files changed, 47 insertions(+), 87 deletions(-)

-- 
2.46.0


