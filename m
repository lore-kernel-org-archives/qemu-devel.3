Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EDCC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkl3-0004ws-Bo; Mon, 11 Mar 2024 14:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkku-0004m6-7c; Mon, 11 Mar 2024 14:52:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkks-0004yS-EV; Mon, 11 Mar 2024 14:52:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso25423635ad.3; 
 Mon, 11 Mar 2024 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183128; x=1710787928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LFs81MFRDaIe8DzVKcIiiltsydhlBAYDpj9IfLrHQuQ=;
 b=eqyRNnWmaq3SuNpq844ZHf2o67HxqtXFAPFY9Gehi3ZveaG4y2cpjRqh9d41ukNMvy
 pUC9xlmDJCkbmZ21Bzwk51B3/8D9Pjmn3J653thBC37T6dDhc448X7zohkasW5veen31
 8waAOGGYJToobUjpnhjW8ifBgP1BMYfKpV/MiD9nye2TzuAj62ojJqHOr0wkfuKX2YiD
 OO+6Q8/hnvOERtchg/nTmkEEH1673uMGqOnesVsLbZCnbOWgZgBvxzq1Xvq4tZtjuUgi
 8pAWBCQPme084hEH6hNOZ8RkZJtHPSzqNs37z9g6PzBcsuDtlUxU3ViOPDstolT7PgVh
 1kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183128; x=1710787928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFs81MFRDaIe8DzVKcIiiltsydhlBAYDpj9IfLrHQuQ=;
 b=v+LVYx9Ny3hW/f8VDgQouuPHgu0LdJz++rbVT1TwuaKWAwLaGzhieQAdK8RsjVyoAD
 kSAwSJ2JuvIcBHUPqVYRneZJ5Z76giltx0yUWujAtbs6dAWu2EBSoH+LofeHOcbIah7h
 /6WCJrlcm9RYZwtYnJHQyyugBiDQM7SCfiLOfFJbQX9s8bPGfuPb05LMLU4Zl1PwVXyX
 pFKtQm+ftvqQfX9OB0XpBbPOy07Q4yl16xr6N6mb/sEVhr2eOKTiHQWkQDfqGbbLvlSc
 8Gyt4sQgQnSsBxZvb4JuAEHzMoRCByocm87trb2Xx4uiLxs+AX/J54wsveAOrEQwKir+
 RmbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxE+plkK67U2OuLhj7e1pIba3v2+FfbaY/3swZPu6Wmie7X37fHg0z9O0dIDO4uuYqBqUmKHyExc6u7IOf+MHAVvryoZY=
X-Gm-Message-State: AOJu0YxDlClaKU/S76YX5pnzc91l6O8XtvmqYj4iI+EVJPrrDUcG7xMv
 5Cx1x8PDn3wsJCJEBDHv2mWa7qwskVCDRuwsZQaf1epYRVWjKzHu2lROZx15pXs=
X-Google-Smtp-Source: AGHT+IFkGs0DE4Vnt1xphcpU1EDslehEriSAgtNps2iJU/yP09gtezo+/NldCHDU0g3f8MmOATqTbQ==
X-Received: by 2002:a17:903:25c1:b0:1dd:6781:49ab with SMTP id
 jc1-20020a17090325c100b001dd678149abmr6491007plb.59.1710183128143; 
 Mon, 11 Mar 2024 11:52:08 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 00/13] misc ppc patches
Date: Tue, 12 Mar 2024 04:51:42 +1000
Message-ID: <20240311185200.2185753-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Here's a bunch of patches that have been on the list in various
forms, but haven't made it upstream yet. I would like to get
them merged for 9.0 if possible. The checkstop and attn ones are
bigger but they're not so important so I could defer them.

Main change is merging Ben's DEXCR patch from last year with my
POWER10 pa-features patch -- his was posted first and added a
POWER10 entry so I took his but updated title and changelog.

And changing the SAO and copy-paste patches to always cease
advertising them, rather than depending on the host, as per
discussion with David.

Thanks,
Nick

Benjamin Gray (1):
  ppc/spapr: Add pa-features for POWER10 machines

Nicholas Piggin (12):
  ppc: Drop support for POWER9 and POWER10 DD1 chips
  target/ppc: POWER10 does not have transactional memory
  ppc/spapr|pnv: Remove SAO from pa-features
  ppc/spapr: Remove copy-paste from pa-features
  ppc/spapr: Adjust ibm,pa-features for POWER9
  ppc/pnv: Permit ibm,pa-features set per machine variant
  ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
  target/ppc: Prevent supervisor from modifying MSR[ME]
  spapr: set MSR[ME] and MSR[FP] on client entry
  target/ppc: Make checkstop actually stop the system
  target/ppc: improve checkstop logging
  target/ppc: Implement attn instruction on BookS 64-bit processors

 target/ppc/cpu.h         |  16 +++++-
 target/ppc/helper.h      |   4 ++
 hw/ppc/pnv.c             | 104 ++++++++++++++++++++++++++++++++++-----
 hw/ppc/spapr.c           |  63 ++++++++++++++++++++----
 hw/ppc/spapr_cpu_core.c  |   4 +-
 target/ppc/cpu-models.c  |   4 --
 target/ppc/cpu_init.c    |  93 +++++++++++++++++++++++++++++-----
 target/ppc/excp_helper.c |  52 +++++++++++++++-----
 target/ppc/helper_regs.c |   5 ++
 target/ppc/kvm.c         |  11 -----
 target/ppc/translate.c   |  11 +++++
 11 files changed, 304 insertions(+), 63 deletions(-)

-- 
2.42.0


