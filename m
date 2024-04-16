Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A87C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwogb-0003HU-Hn; Tue, 16 Apr 2024 15:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwogX-0003GR-UW
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:41:42 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwogW-00044Z-6J
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:41:41 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so3699184a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713296498; x=1713901298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sWe0xGQAzLFs6qcsuly0iwDcWHfMJGE1xVTMwHI5cEI=;
 b=S6LHlUdASFmoPTcL80550tXJ4PoHZFmUZWo9tk4N+bpMojyuKhd3x+dAO1GamEyLPV
 BOXOoh10U+HF+mohKC8Tqb24NaPBgHdT2CL5Y+Y2RsdYgXgBEzuvjoVN7HYlGtERUuhp
 AyTa/wdc12IPgZjSgiejMu7E5QZBn85zWZXv0xZgGdx3z1FcFVDt+yRzYS0EnwuGv5V1
 R4zyJJWNcOGU9r08IaOpLwLFsVViz5w1ySQxWSuh1/5CskVRr3OThiKzLFIaGZJbXoi3
 5RlTv/GWfv1CR4hcomzlqveqHE8zyALEOOTyePuwnpWwsoGPjDazOlRWiiP2L4a/8dDu
 +zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713296498; x=1713901298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWe0xGQAzLFs6qcsuly0iwDcWHfMJGE1xVTMwHI5cEI=;
 b=RxgJRGdAva/KEYmjMJPGk3cKkoIriAABJaG9Xz/KYiykvbiCknbDae8rFd3K6NZiu8
 VBgnkrQ0ENC9KnoiNS+P8vaaP2fh1yqQ2ugU3QJkcp4NIViLIOgG6odp3IowTSOTzbDt
 0dM1bigcbSBzY5yH+is3P0XL77AWpG/zlI3cBEcBThqe7yuHd8ppiBC4uEDTuHRsWVNz
 HmDI0htivbGYldBGrlUW956skit2zcxbRskrac1f6XnPqRLmcMZ5DXRAJ+VXTteXTR7c
 La1y6ImTBaUnT0PwmU0+TJ7sQenUNXp+BCcOeqQoECPTa3MZQnVexhE5NRtA8IYcSu+N
 l+vg==
X-Gm-Message-State: AOJu0Yy7ge0v1rJOHoIPEDL71WFMx6FsReKaCtdbjBv6k/5ZmoTkHomW
 2q+rfWJpQyFXMImWhz5Hbjei5hNm+nMm4H6VQPI3bIAS84L8fH7SdZhVqkklIsml7n0zyyiZX4N
 1
X-Google-Smtp-Source: AGHT+IEJZd2rXXHUftD19FIYBBl2kFF9RqrndLtpBVdiBi8JlCerOZzp6wY5IaHH+D+DfvZCTiB4Pw==
X-Received: by 2002:a17:902:ce92:b0:1e3:f27c:4577 with SMTP id
 f18-20020a170902ce9200b001e3f27c4577mr17237121plg.44.1713296498179; 
 Tue, 16 Apr 2024 12:41:38 -0700 (PDT)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902704500b001e3c972c83bsm10160586plt.76.2024.04.16.12.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:41:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 v2 0/2] target/riscv: set (m|s)tval on
Date: Tue, 16 Apr 2024 16:41:30 -0300
Message-ID: <20240416194132.1843699-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

This is a re-send of the patch sent as a 9.0 bugfix in [1], now reframed
as a non-bug fix chabge,

A new patch (2) was added to handle a similar scenario with ebreak and tval.

Changes from v1:
- patch 1:
  - rewrite commit msg to make it clear that this is a non-bug
    fix change
- new patch (2):
  -  set mtval/stval during ebreak
- v1 link: https://lore.kernel.org/qemu-riscv/20240320093221.220854-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (2):
  target/riscv/debug: set tval=pc in breakpoint exceptions
  trans_privileged.c.inc: set (m|s)tval on ebreak breakpoint

 target/riscv/cpu_helper.c                      | 1 +
 target/riscv/debug.c                           | 3 +++
 target/riscv/insn_trans/trans_privileged.c.inc | 4 ++++
 3 files changed, 8 insertions(+)

-- 
2.44.0


