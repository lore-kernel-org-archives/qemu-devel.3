Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C124C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2t7-0000Uo-4j; Tue, 12 Mar 2024 10:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t4-0000SY-Lu
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t2-000299-Mh
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RAVCMyqNfzJes3QALpyL/fS1d46jiltFvhj2ojqru+8=;
 b=PO34LT5LmO5p6FWb47ZCvjLwPT0RVNFv03C8EgJ1CqLmYoIRLf78oATEu6u6aHlCrIxMvs
 h61zbbixY+hnfJX6pQNC1b8Lo2vMHkuftyUt1yaFT8TH9Qi1gkONW97om+zOYNsanX62eX
 vBXBwVbq5DlZdSGnPcwGpD1d9q3RnBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-RIKKU0sOMGi3nopdcz2L6g-1; Tue, 12 Mar 2024 10:13:44 -0400
X-MC-Unique: RIKKU0sOMGi3nopdcz2L6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 712D5803F81;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C7EA492BC6;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2693221E6A24; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH 00/10] Reduce usage of QERR_ macros further
Date: Tue, 12 Mar 2024 15:13:33 +0100
Message-ID: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Philippe posted "[PATCH v2 00/22] qapi: Kill 'qapi/qmp/qerror.h' for
good" a couple of months ago.  I cherry-picked just its simplest parts
for now.

Markus Armbruster (1):
  error: Drop superfluous #include "qapi/qmp/qerror.h"

Philippe Mathieu-Daudé (9):
  qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
  qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM definition
  qapi: Inline and remove QERR_DEVICE_NO_HOTPLUG definition
  qapi: Inline and remove QERR_INVALID_PARAMETER definition
  qapi: Inline QERR_INVALID_PARAMETER_TYPE definition (constant value)
  qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE definition
  qapi: Correct error message for 'vcpu_dirty_limit' parameter
  qapi: Inline and remove QERR_MIGRATION_ACTIVE definition
  qapi: Inline and remove QERR_PROPERTY_VALUE_BAD definition

 include/qapi/qmp/qerror.h    | 21 ---------------------
 backends/iommufd.c           |  1 -
 block/snapshot.c             |  7 ++++---
 blockdev.c                   |  2 +-
 chardev/char-fe.c            |  1 -
 hw/core/qdev-properties.c    |  3 +--
 hw/core/qdev.c               |  4 ++--
 hw/ppc/spapr_pci.c           |  5 ++---
 migration/migration.c        |  2 +-
 migration/options.c          |  9 ++++-----
 migration/savevm.c           |  2 +-
 qapi/opts-visitor.c          |  2 +-
 qapi/qobject-input-visitor.c | 32 ++++++++++++++++----------------
 qapi/string-input-visitor.c  |  8 ++++----
 qom/object.c                 | 16 ++++++++++------
 system/qdev-monitor.c        | 10 ++++++----
 system/rtc.c                 |  1 -
 util/qemu-option.c           | 10 +++++-----
 scripts/qapi/visit.py        |  5 ++---
 19 files changed, 60 insertions(+), 81 deletions(-)

-- 
2.44.0


