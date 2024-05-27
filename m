Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7FDC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYZp-0004sm-Ro; Mon, 27 May 2024 07:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZm-0004rR-2V
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZk-0001OR-0w
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=59Wr6DHmipzb1jiF71zs4A412vur585ni9AcaQwTaGk=;
 b=fRfwJKJ1b+6dOtExDSfSvOgBEpIwNgyQocuujm8BvYnjodLFuE6KJ321jl4NRWUOl/sFSY
 6mnYQo6sFTTfO+YTK2L5+/TU2iEX53Bezp6gyf69L91f9mTa20C8rpxvLnNyLLizCopsHH
 gSUP4Au5GfmWY7aQjkZRfbdtecLJ18c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-XNAB6fYfMXGWMCubDniCbw-1; Mon, 27 May 2024 07:31:33 -0400
X-MC-Unique: XNAB6fYfMXGWMCubDniCbw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BCD7185A780;
 Mon, 27 May 2024 11:31:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C9C492BC6;
 Mon, 27 May 2024 11:31:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E23FA21E681D; Mon, 27 May 2024 13:31:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/9] Error reporting patches for 2024-05-27
Date: Mon, 27 May 2024 13:31:22 +0200
Message-ID: <20240527113131.2054486-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 60b54b67c63d8f076152e0f7dccf39854dfc6a77:

  Merge tag 'pull-lu-20240526' of https://gitlab.com/rth7680/qemu into staging (2024-05-26 17:51:00 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2024-05-27

for you to fetch changes up to 2020337239b054447d0756ea75e970b35f7a541b:

  qerror: QERR_QGA_COMMAND_FAILED is no longer used, drop (2024-05-27 13:00:12 +0200)

----------------------------------------------------------------
Error reporting patches for 2024-05-27

----------------------------------------------------------------
Markus Armbruster (9):
      block: Improve error message when external snapshot can't flush
      dump/win_dump: Improve error messages on write error
      block/vmdk: Improve error messages on extent write error
      cpus: Improve error messages on memsave, pmemsave write error
      migration: Rephrase message on failure to save / load Xen device state
      qerror: QERR_IO_ERROR is no longer used, drop
      qga-win32: Improve guest-set-user-password, guest-file-open errors
      qga: Shorten several error messages
      qerror: QERR_QGA_COMMAND_FAILED is no longer used, drop

 include/qapi/qmp/qerror.h |  6 ------
 block/vmdk.c              | 10 +++++-----
 blockdev.c                |  6 ++++--
 dump/win_dump.c           |  7 ++++---
 migration/savevm.c        |  5 ++---
 qga/commands-win32.c      | 41 +++++++++++++++++------------------------
 qga/commands.c            |  6 ++----
 system/cpus.c             |  6 ++++--
 8 files changed, 38 insertions(+), 49 deletions(-)

-- 
2.45.0


