Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1D0FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Aw-0005NV-An; Fri, 24 Apr 2026 00:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8Au-0005Mj-4R
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:29:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8As-00027d-Q6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:29:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f431c0ab6so3405887b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777004992; x=1777609792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ygTqUqIU3Sp7S5m2aGNidjIoDY/viFOfPzdcOpmwq/0=;
 b=HNudUKt9t/fECzzC5OK+2jcssOdJ9f0T+bxBHY+JkTYkS7x8zgvN8QcVR/UTwphUeL
 fZYI1ULNp0lpjd9sIheN43YHjKB2qQUGbhLTEPvVoEwwJNFii5qGa5q9y+YhS1QkzWpw
 KXGqDpWjxBdmTqdnDkEWtHGgUGBGUvgrYr9/pZajHejeiY5rgHgMO6oSA9WGnvfoJ0z3
 bj4FpZd7upL0ojTQG0wM1cUJ421lVfSLq4WwMjyaqE7+JLvqdrRtdsEv/YZvsZ2CpLgd
 P43GV/FuPO5deJNyqJXAAvu6/lcpBCA7mcTp+mboEkWbycowQ3r+Sqc3QAL1Hwdyc9ua
 YoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777004992; x=1777609792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygTqUqIU3Sp7S5m2aGNidjIoDY/viFOfPzdcOpmwq/0=;
 b=RRawXYuYeKDG7iDHEwNrdAPJd1XMLlQgHK/yzbrA2kKYkLTv0NrOw2HNBfo25YB0uH
 1NI8tKBE1S+9gUypVTK2m96j4LGOuklJG5BFXb9DvyahNHjnrncyoGTwj2hdvbpS6tXN
 tW0bTAGYGJuJ8wgcXdQg1vFJu/McEuUIG4bDnl3oxy7EnX0ShowDwvVsoRD/FUq6o+Pu
 lK+dc3Llq3aYb7KWYFX1LCrqU5H8IEKyOOhRefnXlzklmgDtS4oogN1v4Kho71NPB20l
 7op1hp+RJEEm6VCCGxGOFJ+j10U887yCM25T/eV99HyX8Cp1Om9TfjvDkWHoVkqLuZn5
 w77A==
X-Gm-Message-State: AOJu0YyLe4nZnDzuIzKm631MMbcTzV2Gq5bJeHfMF38JtrRbjng+UT7r
 cJnbK7aqu92u1xTg8vLOhc0OCUPbQ0Hl14lzp40VV8LepqX9JP+33EmDUn3AXt02WODJayOmozu
 Q9NAplOoq7FHdRtZ8nhC6v86jhKcDn6+t1JSv9R09PNxfhgdS7ImoTFC/4vapacMA6+iVFF/IsT
 fZiOH7AZF4QK3Xz1MjF0cc1TkSyuJhSmUjOFR+VXSmb493sd6k
X-Gm-Gg: AeBDievA5t+uE7eZ3ay+df65i9nNBsq4WsvNDNcrUm6pU//sF7KLIsB1GaNB9RS/CMc
 F890lDcLlZLb6zBGP+xQsOWe9tEWsJ5+9igN7Qt7li48NF927VH09vt7ajNSxk1GvoDuR7HVErF
 kJLNyKx4KSULO/mqW1jCaf37E4bKQ3Kg3Fe8a5pUZlrdHt+YeGTPMenbtM3j6vl/mvXWgiJlaeq
 /3PhfgHVOTSgul1FxUUGeMTx/uoyxVydrxkPDfk7TpSbSqSIdRV7Y1RagXrGBl9h/OrfSpfj3LR
 ouWzG0JMn1cLecDPut9e/ncLLILWavBSJjcb3EYCRRnJjNhSIJg/AzYhBH/tXyquwbZVbC+VJ9Z
 a8HpZjazOtheKnlY0WCYYhZRzsogZ5XXgT/v0K9UbyGbtgubqbMMo/mh1ywCjr3vbWmqGKz3jvY
 kTzTru+oIpNrDsy9T3bJmdIOUiFvqB97X9iHB4ld98r6xct+sDZo1SjyPu/oUP
X-Received: by 2002:a05:6a00:3cd1:b0:82f:6b3a:8281 with SMTP id
 d2e1a72fcca58-82f8c84dfa1mr31576803b3a.7.1777004992363; 
 Thu, 23 Apr 2026 21:29:52 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe92desm21712867b3a.44.2026.04.23.21.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:29:51 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 0/2] Add the implied rules for G and B extensions
Date: Fri, 24 Apr 2026 12:29:44 +0800
Message-ID: <20260424042946.3875690-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frank Chang <frank.chang@sifive.com>

Add the implied rules for G and B extensions to enable the implied
extensions.

Changelog:
  v3: Keep riscv_cpu_validate_g() and riscv_cpu_validate_b() but remove
      the auto-enables as the implied extensions can be enabled by the
      implied rules.

  v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
      implied extensions can be enabled by the implied rules.

Frank Chang (1):
  target/riscv: Add standard B extension implied rule

Jim Shu (1):
  target/riscv: Add the implied rule for G extension

 target/riscv/cpu.c         | 26 ++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 39 +++++++-------------------------------
 2 files changed, 32 insertions(+), 33 deletions(-)

--
2.43.0


