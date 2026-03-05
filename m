Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D165DF33A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9Kf-0002PC-AK; Thu, 05 Mar 2026 09:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KN-0002NX-Rq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KJ-0007qV-Nl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772719518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xlr+uzY4HBmnkdOKg7uUY3lZ/s3hH57O/WC32TVvGlg=;
 b=RCI9xoRElA7SqaC9xF0hOOAFqzGaYr66GjZZs7emitcVJgLP6DinxGvqiG0sH6KQgcySvY
 4qDfyaqjWZhiqhjYDcrvQQf58/R+zLbRoKTp1oYjphvf592i8sYLPwknHjVS2l40ZHpRqj
 qtT9HRm9jP3guiN/c8yryj0Rf4kuD0w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-nbzPZejFO8-oFuqKJsTNwg-1; Thu,
 05 Mar 2026 09:05:12 -0500
X-MC-Unique: nbzPZejFO8-oFuqKJsTNwg-1
X-Mimecast-MFC-AGG-ID: nbzPZejFO8-oFuqKJsTNwg_1772719511
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7062818002FC; Thu,  5 Mar 2026 14:05:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0E901955D71; Thu,  5 Mar 2026 14:05:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9517221E6A04; Thu, 05 Mar 2026 15:05:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/6] Miscellaneous patches for 2026-03-05
Date: Thu,  5 Mar 2026 15:05:02 +0100
Message-ID: <20260305140508.218316-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:

  Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-03-05

for you to fetch changes up to a1aca41ed08fba3120878fceb7f74af97c6fad93:

  qdev-monitor: Fix qdev ID validation regression (2026-03-05 14:34:11 +0100)

----------------------------------------------------------------
Miscellaneous patches for 2026-03-05

----------------------------------------------------------------
Markus Armbruster (6):
      hw/core: Deprecate query-kvm
      scripts/checkpatch: Fix MAINTAINERS update warning with --terse
      error: Fix "to current monitor if we have one" comments
      error: Restore error_printf()'s function comment
      qemu-print: Document qemu_fprintf(), qemu_vfprintf() failure
      qdev-monitor: Fix qdev ID validation regression

 docs/about/deprecated.rst |  5 +++++
 qapi/accelerator.json     |  8 +++++++-
 include/qapi/error.h      |  3 ++-
 monitor/monitor.c         |  2 +-
 system/qdev-monitor.c     | 12 ++++++++++--
 util/error-report.c       | 29 +++++++++++++++++++----------
 util/qemu-print.c         | 14 ++++++++++----
 scripts/checkpatch.pl     |  6 +++---
 8 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.53.0


