Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C10CC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uev9j-0000jb-8i; Thu, 24 Jul 2025 08:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1uev9h-0000g6-4w; Thu, 24 Jul 2025 08:34:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1uev9b-0007dH-QM; Thu, 24 Jul 2025 08:34:36 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23f8d27eeeaso8168045ad.2; 
 Thu, 24 Jul 2025 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753360468; x=1753965268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sv7TuTTulTpQhb+LyN9VrSVbtD9Mj8UZkIFdY0nNhwU=;
 b=SYqqmBskl/N7RkAnTOax1rQlgsnf9AZG2X34/EY6+FUHHuj4RVGMr/T7oRuj9BHywb
 Fg+k4StjH5hyLYzNAwKamiUK9nC/oezEpOJ0BKgxU2009/Nu/NO3Tvo3fSCgQ3ggX4QN
 M7tITc+hJk81TVI/4HFsxSRHQtVFmMgiz3Mv8LrCnv81cuWb7kwo96chG3kulS0HRMv5
 TeDFqBNDCNU8yOInBH08AFY2uyDIdSh1EGwM8iqb22e/pgyLLzBYzAeLpv9H+EO+O7g8
 oKLugwmhYy+WZN3R4Ky+gIfSBI7+3KIYQz1oSfBKHgOBeB8wD7jZ+ihC2XwOksv1WyMO
 nB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753360468; x=1753965268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sv7TuTTulTpQhb+LyN9VrSVbtD9Mj8UZkIFdY0nNhwU=;
 b=doGy8CviCB9tEgicDFc1adFdAzmMGnTyv/1zlGsCavCFt+cSiLG5WsMyMX9KmnrvQc
 mEalvzyO0W+LCDk3dgkuJJCeYHK7OJdIZRl/BVpBWHa1ZmW91RDnT+nMC1ilpb9350x8
 t+cWewS/Gh7syMcXpyDjpzYAzhPY2LrY2vcfDxNBo5z13Tp7aOzkRGhZ6FKBNBorQACd
 U+hhCUl13yzymPviL6SlWBPV+0DJGFmGL1sWqEJxpfTsllHHaa4qCnK38iamZ4asZn4A
 xY2Q/OXJG4mBQZ2ZWivlZbDgBtio5GTTn/wQnoHVLc1xbYFpxKEdWozDTK4z4zzq16/3
 Zv5g==
X-Gm-Message-State: AOJu0YwK0teOnmPsLm+NsL5NmhkJS6dNSF7jNcwXaWlbUzwOsxQjOUQE
 1t3mLtB3vx+P36RL9aSa1eb90A1XqQ6tOv2t8wZ+W/kiiCKBEMSiduIeKMMVrg==
X-Gm-Gg: ASbGncvF4WGE1ZIZza7b8iWXMpPyQqofNRXDowXdz6TE9S/6kAATvk00tjvszQaV9Mk
 OqoSwHHJWPvFfT+YXpi9XGjl0/9fH+wX3YpeIoZPLEoQOhoZfdRNBHHOAnshbtY/w/pyCT2A0G2
 YQKqIMBEavaX0e5XxLZHCuD3tkyu1WTJ4tTSYoyX/nMtQ6Z9lGVFhTAOnhUB5CmNDHKOKxupgWq
 VbbrhnICoZnfDU+SPvx8a+qVswE53X+xryq6ZQXr4zmT9/do+6RZ/ayuA/z3bGN++oaETjvgyOT
 Uo+3oX1CGVewPFVo8VygCsJaxMon0UEEFqGvxLIDZw9ajCu1MAIh5kPEYah8AeF5c5IVqc4QJ+n
 kxEiS+Lrnc3f6QyJL7g==
X-Google-Smtp-Source: AGHT+IFx0qTletkz5WsZXiHS7VW3HdROzMD7YLy55H+selBrGQBMLEXBr4afEVPPdYPzoKJHZ1Ve3A==
X-Received: by 2002:a17:902:f788:b0:23f:8d56:b75b with SMTP id
 d9443c01a7336-23f981b18d7mr93353265ad.41.1753360467735; 
 Thu, 24 Jul 2025 05:34:27 -0700 (PDT)
Received: from grind ([177.170.118.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa48bc6c8sm14874925ad.81.2025.07.24.05.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:34:27 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH] MAINTAINERS: remove myself as ppc maintainer/reviewer
Date: Thu, 24 Jul 2025 09:34:16 -0300
Message-ID: <20250724123416.3115941-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It has been awhile since I actively did anything for qemu-ppc aside from
reading the qemu-ppc inbox a couple of times each month. It's not enough
to justify a reviewer role, let alone being a maintainer.

Given that we're doing qemu-ppc maintainership changes across the board
I'll take the opportunity and remove myself from the premises too. Feel
free to reach out with questions about code I did in the past, but at
this moment I'm no longer able to keep up with qemu-ppc activities.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a462345618..088b561aa0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -295,7 +295,6 @@ F: tests/tcg/openrisc/
 
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
-M: Daniel Henrique Barboza <danielhb413@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
@@ -452,7 +451,6 @@ F: target/mips/system/
 
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Daniel Henrique Barboza <danielhb413@gmail.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
 
@@ -1550,7 +1548,6 @@ F: tests/functional/test_ppc_40p.py
 
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
-- 
2.50.1


