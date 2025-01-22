Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13481C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 18:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tafAN-0001EQ-33; Wed, 22 Jan 2025 13:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tafAH-0001Ds-MW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:09:21 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tafAG-0001HR-5I
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:09:21 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5A8D2A42706;
 Wed, 22 Jan 2025 18:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9604EC4CED2;
 Wed, 22 Jan 2025 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737569356;
 bh=S+5Ol0DyFYfPTaUmvf6Hqjx1DVFd22rk3XN4aN2CnZM=;
 h=From:To:Cc:Subject:Date:From;
 b=Hnts4ORXSSPIomTgsFJP221wtqWZ2IUC0PSAdgUj1w5vhbXWajd/Gp/j7i3P79mFq
 xb/PBW8sgp/7xshAqZ5CzJau903BAAvYmeyBfyhOG9nnQqnHB97sjw6cmsUdGBmfmE
 idB+eDMLJKFv3jGdkyxO/sOaXSVN0GtHl3wa7ajZZ7dIN7YvPdajXtcdPV+e+fhrp8
 aS79ortqz7YvhWFkxWuJhomjjJ5hQHbNa194inxtsCDA7HalNNtMV4+2x8a8IVJIgt
 XEZfIqpBghDQ6MuQHfWOs72RI9jdfbcn3Fo/mMIg67j7JqUq0CiG/6CZbJXfi9SrBb
 8xKoKWElpGrNg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/2] hppa updates
Date: Wed, 22 Jan 2025 19:09:11 +0100
Message-ID: <20250122180913.18667-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Two patches: The first fixes booting a Linux kernel which
is provided on the command line.
The second patch adds support for more than 4GB RAM on 64-bit boxes
(requires additional patch for SeaBIOS-hppa which will be pushed
before qemu v10).

Helge Deller (2):
  hw/hppa: Support up to 256 GiB RAM on 64-bit machines
  hw/hppa: Fix booting Linux kernel with initrd

 hw/hppa/hppa_hardware.h |  2 ++
 hw/hppa/machine.c       | 74 +++++++++++++++++++++--------------------
 target/hppa/cpu.h       |  4 +++
 3 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.47.0


