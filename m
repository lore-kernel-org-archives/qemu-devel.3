Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BA2E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYZ-0008Kj-Hd; Mon, 09 Dec 2024 22:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYY-0008K1-PL; Mon, 09 Dec 2024 22:05:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYW-00031X-Vi; Mon, 09 Dec 2024 22:05:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso26571515ad.3; 
 Mon, 09 Dec 2024 19:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799898; x=1734404698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u284kCOMoPlAoA7B8bHhGWA6+enp/xzmSzILperXlyc=;
 b=BowTHvYHOERRQ/dG15RbWJcV3wcNtKjGaeOBt0Mte21BoAbirsW9LOBvLWbiRn7Fci
 UFs8nm61dHvyKWT6WW/EoF8Dla1XENigKLjuHTl9MjZ7r7vWQUn4Ru5fu3EVNO3Z62Hc
 AsNbnq695z/fyORamvxeHuGH/m8CMO/NFJDdCvUM4W8oTEZj+hwcFEFh6DY2k93ZAbC1
 K83EvmAP1LdSe2FCFp6figvb891yqd7ezM4Id3U+qsLwyu6gAL5ccSx0v3LtHyJU7JZw
 dFlArECEa6cMBx5SB4wJ+q1pQYEu2O8ApbWm9wmOsjcQUkLEHIaQ9RfFGnIMmn+JqBlj
 CINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799898; x=1734404698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u284kCOMoPlAoA7B8bHhGWA6+enp/xzmSzILperXlyc=;
 b=Q1mMThvK2LCJS5rswhtH1hdi4r847crAtmiiEUGXPBk30qae/xxxg2gER9sH1a/J3B
 ES0eeMDzlgo0H3jdF8pNOV4JoMuS2Tzx16sB0nZA1JBDe/NXiNUgCU364Gd1dXIltUGI
 uKOyzTy9RzepRws1tJYu1jMz+iooLYvrAjxHoy6g0q3OKqpvPYTUTfJKuMvln69OUSU/
 y74CvwuCy698mKPboeaWSdzqzHKsa9TbDl3rRg0vTfNZWdwIVTqM1pfn/mFnyEj1y59T
 bOXXYr8iS3iiwv95Y4wwRTBTfrO1D1Bei3jKvQsueTzR7zrIY41dgGd9BWixJgD0vrP6
 J7OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoLfIFbr14Z+Ve5wltJq2P4PTEq2zCwJkVvJ6lIr7a1wL2gawoaYACEazG778ofC2p9XeuFcwYWHqT@nongnu.org
X-Gm-Message-State: AOJu0YxXQACsXgqBU838FvVwPT364nxmt4ZoaVuFBf0TyYWSGq9Mbe11
 ks6mpqDo1YIwsxEUIyBecpArBL5S6hq7l1hBJ/Tv82hwgJ2/2b1dsu2AvA==
X-Gm-Gg: ASbGncsgpHQluA2S7orpFlHMhCg29+OK1g1WX6BhJKveWrJs+jGslubBurELhXY6DBD
 WlI+sZf7mSgJ8N0WMxpL/hejEAasjM+Kx0rfRnvmh0i74siQfO70zUyTFgLt8UZ5AXQkCbdZJiR
 hshicX27pBEwuUGENeNccS87g04vXqlVD6SQeHqIewiyPWMBQH5l726HJXMtJMYMl4qBXMYJ0wu
 Xd384AVAGyRKwzbwf4veLEFBE6Pl5IpZMozK2efR5CiRA6G9n9jF08YrhxV
X-Google-Smtp-Source: AGHT+IEpdtqFahM63X5cbfHYtgpSHBzqz3YmpjMmzdTpA54GL7Lp9CjCXUx73SbsWBMIx4yacuZu5w==
X-Received: by 2002:a17:903:24e:b0:215:b5c6:9ee8 with SMTP id
 d9443c01a7336-21614d1d3e3mr185030955ad.7.1733799898401; 
 Mon, 09 Dec 2024 19:04:58 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:04:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 0/9] ppc/pnv: HOMER and OCC fixes and improvements
Date: Tue, 10 Dec 2024 13:04:40 +1000
Message-ID: <20241210030451.1306608-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series makes a bunch of fixes and improvements to the HOMER and
OCC unit models for powernv. It gets OPAL OCC code happier again,
but requires this series of skiboot fixes (which I will hope to get
upstream and then into QEMU in the same release as this series is
merged.

https://lists.ozlabs.org/pipermail/skiboot/2024-November/019013.html

Big changes is moving HOMER from mmio register implementation to a
RAM memory region which better maches hardware and is much easier to
work with; and the addition of some dynamic OCC behaviour to the
device model.

I wouldn't expect any review of OCC details. It's neglected and this
series gets it in better shape than before. But anything on the
basic structure and QEMU details is welcome. I will add some test
cases to help ensure it doesn't regress in future, I will have to
juggle the skiboot fixes as well though, so will do that later.

Thanks,
Nick

Nicholas Piggin (9):
  ppc/pnv/homer: Fix OCC registers
  ppc/pnv/homer: Make dummy reads return 0
  ppc/pnv/occ: Fix common area sensor offsets
  ppc/pnv/homer: class-based base and size
  ppc/pnv/occ: Better document OCCMISC bits
  ppc/pnv: Make HOMER memory a RAM region
  ppc/pnv/occ: Update pstate frequency tables
  ppc/pnv/occ: Add POWER10 OCC-OPAL data format
  ppc/pnv/occ: Implement a basic dynamic OCC model

 include/hw/ppc/pnv.h       |   6 +-
 include/hw/ppc/pnv_homer.h |  12 +-
 include/hw/ppc/pnv_occ.h   |   9 +
 hw/ppc/pnv.c               |  87 +++--
 hw/ppc/pnv_homer.c         | 230 +++----------
 hw/ppc/pnv_occ.c           | 668 +++++++++++++++++++++++++++++++++++--
 6 files changed, 742 insertions(+), 270 deletions(-)

-- 
2.45.2


