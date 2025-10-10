Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B4CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Bny-0002Gd-Kh; Fri, 10 Oct 2025 08:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v7Bnm-0002BB-6Z
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:00:54 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v7BnW-0008WI-KO
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1760097635; x=1791633635;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+sSdTbAxvnmgcVJEEc943DCxx6JpFN/9tOlGdF/eAj8=;
 b=YurqH+xg+rKjjAQe5295K63jcadDsZAs41ZmZop4tSAB78hNvFvDG3tb
 rXeSYRiSCbQse5KfBMROmK9juu8Z6GEqU5R02/ihg+aoNStfhnPEhiiAx
 pz4sowbu3HPTnePzMu/05GBW68IcPJpawqVQxumPcLIYhJWn7eo2QuNR9 k=;
X-CSE-ConnectionGUID: bBmFwlBtSZaYCNHBL8++/g==
X-CSE-MsgGUID: m/lHSVyqS3qSiqdnzmuk1g==
X-IronPort-AV: E=Sophos;i="6.19,218,1754949600"; 
   d="scan'208";a="3223568"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 10 Oct 2025 14:00:23 +0200
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id DDB622C51;
 Fri, 10 Oct 2025 14:00:22 +0200 (CEST)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, jmarcin@redhat.com,
 berrange@redhat.com, Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH v2 0/2] migration: Add support for mapped-ram with snapshots
Date: Fri, 10 Oct 2025 13:59:52 +0200
Message-ID: <20251010115954.1995298-1-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add support for mapped-ram capability in combination with savevm/loadvm
snapshots.

v2:
- Remove unnecessary CONFIG_PREADV ifdef macros
- Remove trivial doc fix since already queued
- Fix swapped parameters in handle_zero_mapped_ram calls
- Check for RUN_STATE_RESTORE_VM before zeoring instead of checking for
run_state not in [RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE]
- Check for from >= to instead of from == to in handle_zero_mapped_ram
- Remove mapped_ram from snapshots incompatible options
- Rebase on top of 
Based-on: <20251007184213.5990-1-farosas@suse.de>
([RESEND] migration/savevm: Add a compatibility check for capabilities)

v1:
https://lore.kernel.org/qemu-devel/20251001161823.2032399-1-Marco.Cavenati@eurecom.fr/

Thanks for the reviews on v1


Marco Cavenati (2):
  migration: add FEATURE_SEEKABLE to QIOChannelBlock
  migration: mapped-ram: handle zero pages

 migration/channel-block.c | 44 +++++++++++++++++++++++++++++
 migration/options.c       |  1 -
 migration/ram.c           | 59 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.48.1


