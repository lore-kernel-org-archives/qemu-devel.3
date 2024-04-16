Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD307C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa4p-0007ir-AA; Tue, 16 Apr 2024 00:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa4m-0007iQ-LF
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:05:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa4k-00078Q-Mr
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:05:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6eaf9565e6bso2428421b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240340; x=1713845140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PR3CJUUo2/VGKB2RGbMarxktvJK4SxiTMKyT7dvFViA=;
 b=MFJilO/pDyBx6Vb5Ss3KcK7DLYfPtb0+g9HMdLjWqBEo6dLeukXt6s0C+ndZ0AQNia
 S75RLzc/f3FcyrRwaTFHn/eGzpjbc6xCxRfJqPwLeSsvvcSL/qx+VDxAG7UdTFtuJvlV
 DVd5CPVtLiBfFOaTcQEWMDqa9p1Ek1GYNPVvAS+8EaejGRdT1Rqfres/WJIewMrZBOjw
 iixeKhv23NQ7otdHn3AcX8GuAcwfi8iyBMt/wp6xS6fYwSkknA96VCLWXQysFDBajvJD
 GRlUZDUzTqnIdS2TqBgkpyAoCJgSYqLQGY1WnctKICaxhJoFwCJIt/YLblOigXRO55kb
 C76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240340; x=1713845140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PR3CJUUo2/VGKB2RGbMarxktvJK4SxiTMKyT7dvFViA=;
 b=ihpa+sz3oY6m49QAr8MOfUF6oDv42c8UyM7SM96KcwQ9Gud1IAG3R+9+Kr0Zs3nzYJ
 V/4stRhGsIJ+EJgN2v4Ga1EDEV4zgQlCZTVuL39ErmmIQWGUHwl3EGQBgXXonZeCdn2D
 0ArpKcogfJ7w5Nd4+Ki/op/OfyTgh6aUI3YdsMyBswxmVkoqTEKl+e5Fbf3qGfn2l/QM
 tRxQek6M79uUc1mYbHUNo7vKzoDlMBNdM0DxRnLjpErHQBGxN6vlrngVOqyVjRmvWaPz
 /Geefhrb+PHo/GPCsU/OaOOZQqCHnlvOqkvxi7b+RsCf6mun02V4d7QXsAa+MkVinw+Z
 9CEg==
X-Gm-Message-State: AOJu0YwljqSI07JUPTtOy6M6pteC8b5BeyJrFFgzygmYQMacE32L1Rr8
 Wp91g5B0xqyO8jtfa5nUdrP7+Ar9AxtH0ATtnhFmnXO1Q5YglVqXHxsNczwhqn01PoLYJU0ELnD
 E
X-Google-Smtp-Source: AGHT+IF/At63aucah0unUDUygfnW/OSDiHUfD59mJz1mAW2emb6NFjkaFzBIcGKuGkM4Z1WtYf5kxQ==
X-Received: by 2002:a05:6a20:2451:b0:1a8:4243:7553 with SMTP id
 t17-20020a056a20245100b001a842437553mr11463800pzc.12.1713240340421; 
 Mon, 15 Apr 2024 21:05:40 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 cm6-20020a17090afa0600b002a2c905158asm7880202pjb.46.2024.04.15.21.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:05:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 0/7] plugins: Use unwind info for special gdb registers
Date: Mon, 15 Apr 2024 21:05:26 -0700
Message-Id: <20240416040539.1313535-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Based-on: 20240404230611.21231-1-richard.henderson@linaro.org
("[PATCH v2 00/21] Rewrite plugin code generation")

This is an attempt to fix
https://gitlab.com/qemu-project/qemu/-/issues/2208
("PC is not updated for each instruction in TCG plugins")

I have only updated target/i386 so far, but basically all targets
need updating for the new callbacks.  Extra points to anyone who
sees how to avoid the extra code duplication.  :-)


r~


Richard Henderson (7):
  tcg: Introduce INDEX_op_plugin_pc
  accel/tcg: Set CPUState.plugin_ra before all plugin callbacks
  accel/tcg: Return the TranslationBlock from cpu_unwind_state_data
  plugins: Introduce TCGCPUOps callbacks for mid-tb register reads
  target/i386: Split out gdb-internal.h
  target/i386: Introduce cpu_compute_eflags_ccop
  target/i386: Implement TCGCPUOps for plugin register reads

 include/exec/cpu-common.h     |  9 +++--
 include/hw/core/cpu.h         |  1 +
 include/hw/core/tcg-cpu-ops.h | 13 +++++++
 include/tcg/tcg-op-common.h   |  1 +
 include/tcg/tcg-opc.h         |  1 +
 target/i386/cpu.h             |  2 +
 target/i386/gdb-internal.h    | 65 +++++++++++++++++++++++++++++++
 accel/tcg/plugin-gen.c        | 50 +++++++++++++++++++++---
 accel/tcg/translate-all.c     |  9 +++--
 plugins/api.c                 | 36 +++++++++++++++++-
 target/i386/gdbstub.c         |  1 +
 target/i386/helper.c          |  6 ++-
 target/i386/tcg/cc_helper.c   | 10 +++++
 target/i386/tcg/tcg-cpu.c     | 72 +++++++++++++++++++++++++++--------
 tcg/tcg-op.c                  |  5 +++
 tcg/tcg.c                     | 10 +++++
 16 files changed, 258 insertions(+), 33 deletions(-)
 create mode 100644 target/i386/gdb-internal.h

-- 
2.34.1


