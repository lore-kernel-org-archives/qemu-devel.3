Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C06CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 23:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKltW-0005G7-JE; Wed, 06 May 2026 19:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKltU-0005Fp-RX
 for qemu-devel@nongnu.org; Wed, 06 May 2026 19:43:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKltT-0004ug-Gq
 for qemu-devel@nongnu.org; Wed, 06 May 2026 19:43:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso110801b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778110986; x=1778715786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7+I4brrImKbjhItxDSOImSnMim09TCY2AtYpXoj4pg=;
 b=sTm6YNitOQGBTZsg9j5WFTGkgbOt4trgy/EgGANOD4GkqqCN2ZSC9zOXYE4xYAf8if
 XYH/ylotda6vXzf+3ZjD1m95tL3mFHReyRn/k4oMTY3MgR6FBJop4cGQqHl/GNdnCasL
 MXXHarcrdhlJod1mkSI9QOZt0Bf1+aheqg+LscbPpnInDY4vqRapx8Tc7QY0vNimxTVX
 tjAnBhAsLGTK7+aSvilnQnyQ2TYu0ACzKDVh6CA7rcdvQvyXMh18RtZGxhDr9FfnO4PE
 C7bui/RzG7BCxQ1+JH7kVPkPFKTM/h7CP6nBtdqHjJGrws/6b+YepRqp1vvEx9hWl51c
 BXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778110986; x=1778715786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7+I4brrImKbjhItxDSOImSnMim09TCY2AtYpXoj4pg=;
 b=HFywv+TWx9J60ohD5RlRo60peDFYb29Gxb8x5iBRaxsC5JpmVQ/lxWykLpv485I/bh
 zgIZ9QnyzVo8TbSI5gTtWWS89yJWj+fwL5pcr3zeE0pqRDQ2xxoGl/IgUwIk4BYINohp
 15XWpTgD9SgmV7vEuQASBjS4ZmC+nJbf9qSnKMYTdeIJ1LevlZ1sOOJWO1NgNTStam6o
 cBY5cPO5ESlmhAYMNiLfEl2Ar+kKBObyl5PEqjmKi+ogeE2e7+ZLopkPlBmgp+Giju7P
 rTEeR1xkg8igXtMYMPeyNSvsmT0Du2GBZgzEOqVn54qfdLH2JMbXWxVDSYu96vhS0n98
 nv0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DWP6WIdVsHu69Nxh1g5wD8bl81Ly5NUxytOcjDMO8VQ/0GnrZzy1Whpdx3RFqnfoWRCWh/iOWiuwz@nongnu.org
X-Gm-Message-State: AOJu0YxEVrROmPMbvZ51QP0+egzszes2/uVdx3kUKEiTvSdRUVIoq+xn
 3FsP/epicNq442SpEobCfM2QAPaZcwf627TO10OaYZngmtj7iTVQfeEm
X-Gm-Gg: AeBDiet0nWBskKsQ9dvA51IVKk0XwaDl6nQCQ2KhjYES7bl7FR61dtq4VDnUH3AvGv/
 Rec4vjmYkoE4IcTrJQmP1BD/X/MYY4/ddJ6tQKPD4CXQE0qHuiocFCSTZuuAidr5SqCYsZIC1hJ
 mVwydFPuO4c7MIs9aXyDWfeNo1+ApdIhH0wuj2x01mVENr+yvB7Fq8mXzeIz5617ApenQDhCes5
 kzvMNYos211RznfUrLINc8zT+oPsURhdmgUVcH3OffSFZCTdXWWofgC0w9LIFJN+oUe8sd6YSbg
 nBUneYBACk3JPJCKwdXHMxTQH0PGGjhvPr4brRebynFUpA8sM/beLcEHZnOP5L6dXiy5j89ceuC
 6uBwRcZUVOFbThfUb+8W4z56lrcChv+igriuYuy6Y9FB89CQwhAOxQCjueCqHGy1I4RV+5cg7eG
 4K9K+6jFxWIjV9xp1WCyIlYSOzAiKhC3de2ji/RNbsyxSRGu4tIU4xdvslBLcLP5Lq9RR4dRjK
X-Received: by 2002:a05:6a00:21c5:b0:835:cc47:6fff with SMTP id
 d2e1a72fcca58-83a5badbcecmr5247161b3a.7.1778110985732; 
 Wed, 06 May 2026 16:43:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839659487afsm6288164b3a.18.2026.05.06.16.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 16:43:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] MAINTAINERS: Maintain OpenSBI Firmware
Date: Thu,  7 May 2026 09:42:43 +1000
Message-ID: <20260506234243.1873782-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

Mark the OpenSBI Firmware as maintained by me (Alistair Francis) and add
Daniel Henrique Barboza as a reviewer.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..cf91b9f9f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4044,6 +4044,8 @@ S: Supported
 F: hw/i386/amd_iommu*
 
 OpenSBI Firmware
+M: Alistair Francis <Alistair.Francis@wdc.com>
+R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
-- 
2.53.0


