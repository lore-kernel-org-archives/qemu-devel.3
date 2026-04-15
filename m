Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBB7F433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9o7-00035r-9g; Wed, 15 Apr 2026 19:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9o5-00035W-Tt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9o4-0003VF-3I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso26155015ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776296282; x=1776901082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o1WD8bko4bKhlZxIRJWO1zXeUuLtkAb75CPCAzggKxg=;
 b=XbrMwsRMW8j5ioK3j97DBupxKa2u4at9NcQ5D342tr3rNQps0xFIhd+alPtKS0L92w
 LHbZqZj2UsKwtLTcwFEvQ8KUTAMu0z/9smex02aAIaGsUvrG9RFxrnMaaZWPoojz5w98
 nmhx3NEJJ3PogFRMw/GJMcf7bqlIi2EEXR3EFxE4PPwuHSb3uQq3lFiVcf8mJHHqwVJA
 qi7kShrHaoBwZlHmbKpHbgUyal2FNLaqNSPHm/zCztz9DkbcnYL+PpZHUhvab+AB8p4I
 ep3+M4bbzt8Bi6DG4PO+wQlgD1JI5ISnTiRUKxZL16SR2WFqTGZRpPrahEWJAG6nKD2W
 /5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776296282; x=1776901082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1WD8bko4bKhlZxIRJWO1zXeUuLtkAb75CPCAzggKxg=;
 b=B7v42Vh2W9MtGgh3LqOYxPXQPlucOu7sdziZGElTVJH3+TpznnC7QC8xnAfq05koh0
 tkHqWrH7O4icWPmoudq8GyVaQ1g0m68S7nOEzQIaU22u33RhbytHDWgYgnwjE8TAYiyp
 ZwX5VQ0J8wHL45xMArN6g3M6Z4kfppxNkhjNH5kvGRcCIvWOCc5LHHf2ipwpwXJlFFvi
 CVvje8brOiSx7it9JKnYuBMc8atzo+NQVP9xWDwYwgQqz7xcka3ZXvYEPLQ0+kdI2ERn
 xG7in/bYZYPpILFFVgZCpPTLVb40cDn8ZEp35i66cPhCWLcRBwUPcxiTmDEvcIwAvoeh
 mS4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UtUhZlLIomKJXV+EFvY5egq2etLgk8TYPQ1FVpdSrHRE+mOM9pz3ADQ00SzqHvZpR3JQgQr3ekfrK@nongnu.org
X-Gm-Message-State: AOJu0YyPyVTkJ0IJ+DwGfsyaJIcgpsXWi/75FV2IztOSMzbhN2Od45re
 zmDd4nG89DsdC0aPCG7kHzJ1EnYtL+Z+lqdMBrttdsMPEOdm1yCesolG
X-Gm-Gg: AeBDietjXYKF24McQMQL7ScQsF2GKN7IwvnfAAA2X5soz/3mxMoWhQ0WsTk9tXAZ8Xv
 MgYg+Z+H51jKssFN9/sA/P/So3kCwbiDUdgZavw0pY5AZxGH7dkaORUgtRl+gp009GGfOz2endh
 0tcM3wji+0mUq6kVFTGMnmid6QAvh3WF5/pCXRHw8TaOMX21JkO77kFMBWWF8J8kIyWv8JjiOGn
 8V9u3MXxqA/FbXgIQHLdWcfwAjHV6rEuudRpagkSNiLyXnsXidnNV/1FdHv2kiy2CAzrv0ac8xO
 26n3B4GdBWTltUXJ/yxe+p/1WUN2dvZwlxyX4v6vQVdzaEyo2ch6xvpVW4Tm6om1FU7GpLy4uUA
 s5dIZaNo606luNTwaiU7uuPiYzU4EMY4cbfsnJB/Ld3MnoVE5ydw+Egepf5aeFJG9/kBJb+FX1E
 VfgarzYKiDbErcugb+EAVWKeM6YPLYOZIcg7aABVh7
X-Received: by 2002:a17:903:25cc:b0:2b2:42b1:adac with SMTP id
 d9443c01a7336-2b2d591cc4fmr176357265ad.3.1776296282171; 
 Wed, 15 Apr 2026 16:38:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826ea53sm32341675ad.52.2026.04.15.16.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:38:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 0/4] target/riscv: A collection of bug fixes
Date: Thu, 16 Apr 2026 09:37:36 +1000
Message-ID: <20260415233740.3027321-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a collection of patches to fix a few of the open RISC-V bugs [1].

1: https://gitlab.com/qemu-project/qemu/-/work_items?first_page_size=20&label_name%5B%5D=target%3A%20riscv&sort=created_date&state=opened

v2:
 - Drop merged patches
 - Fixup typos
 - Removed read/write syscall print functions and use %p instead
 - Rework "Don't OR mip.SEIP when mvien is one" patch

Alistair Francis (4):
  target/riscv: Generate access fault if sc comparison fails
  linux-user/strace: Use pointer type for read and write values
  target/riscv: Don't OR mip.SEIP when mvien is one
  target/riscv: Use ELEN for Fractional LMUL check

 target/riscv/helper.h                   |  3 +++
 target/riscv/csr.c                      |  8 ++++++++
 target/riscv/op_helper.c                | 14 ++++++++++++++
 target/riscv/vector_helper.c            |  9 ++++-----
 target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
 linux-user/strace.list                  |  4 ++--
 6 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.53.0


