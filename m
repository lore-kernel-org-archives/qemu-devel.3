Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09491C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QP6-0002iZ-NH; Mon, 13 May 2024 03:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP4-0002hG-Hp
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP2-0001JO-Oo
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41fd5dc03easo24073315e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586439; x=1716191239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnzePE6mX3Rhi62SecPeEdqHkyCsEzt2r4MnnIgljlQ=;
 b=t6PX7uM6xxnNkb1n9AAqCGKDHgCCSHB4i9APwzZwhHQWLqjIjygWZJ4asZgXzptD9k
 z+cKDp2CNUJHC6WVQHA7aVhSfCAeDXLGYen6Rjk2fj4J1lkwKYJhw/JQ6o/ARHf2CDWa
 KHiDpyqw35OpOikvHTqinzpyd39c2KOnTaC7KRr8X0r4H9uiB00CKVb0G7kBqV7Ulqgk
 PHZGoQSre5Doh5rzfgCtvX9WbNYmCDfhvjW78Hjpl29chDQ5FepMiIALYlaoav95X2Cl
 yr0aZm2oq1qXH5uAD8hZLFkeIXf6DaxadeIMUmqsHffRs0SyOdeOxPmOgu3l61kp4/Nc
 DE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586439; x=1716191239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnzePE6mX3Rhi62SecPeEdqHkyCsEzt2r4MnnIgljlQ=;
 b=F3yjzTzBYnMsiawJtb1NrlRrkmJWMgTa/bX9iv4oJY7BpZHZgW6ew5uOymd9uJuc02
 pdTQr7aoN4/BiCDiAbaK/UXmfgIygIEQI02l5u9FVzF/P11tD6x3EGSlBPCHjeJXgrxq
 bzNE3utUHP8ePaAUtAvBNNdIYx/uRmLeYFH95owqy+55uL90d96oUjcMkosRb+aIpseH
 7TATjJm0JtEesnW4a1q1rF2UYoe0okB0SHY5zG4ebnPuOKygpFRjY06J1BgSSB0k4eKA
 gF8eB54/FJaB3xCfZvuZumLfo43/2vHLtdmTQyT4Ry4Z64VIX7tgqc3FlxcWlEsOth/J
 wKUQ==
X-Gm-Message-State: AOJu0YyVDhT4O0RShxgUQMsZBP570L71bayAxRL1V5GSJFN8dLJYSBJe
 4dCv50nBZCzbK9sKFcuhe2i5NrILXNO/VgXh0p3Lm2vrYmWbgkBb+vjiyL4TXNedOM2YkQOMXJR
 4/sc=
X-Google-Smtp-Source: AGHT+IGpPVPSw4LFlEFA0pi9PFgjwl9D0zPgM2GUL9shWyJjjzrVoehtjVgprdnwXweWmuzn+ZzzZA==
X-Received: by 2002:a05:600c:3503:b0:41f:ef1e:7312 with SMTP id
 5b1f17b1804b1-41fef1e750amr64448525e9.14.1715586438905; 
 Mon, 13 May 2024 00:47:18 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 00/45] target/hppa: Misc improvements
Date: Mon, 13 May 2024 09:46:32 +0200
Message-Id: <20240513074717.130949-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

Most of the patches lead up to implementing CF_PCREL.
Along the way there is a grab bag of code updates (TCG_COND_TST*),
bug fixes (space changes during branch-in-branch-delay-slot),
and implementation of features (PSW bits B, X, T, H, L).

Sven reported that PSW L tripped up HP/UX, so possibly there's
something wrong there, but that's right at the end of the patch set.
So I'd like some feedback on the rest leading up to that too.

Changes for v2:
  - Rebase and update for tcg_cflags_set.


r~


Richard Henderson (45):
  target/hppa: Move cpu_get_tb_cpu_state out of line
  target/hppa: Use hppa_form_gva_psw in hppa_cpu_get_pc
  target/hppa: Move constant destination check into use_goto_tb
  target/hppa: Pass displacement to do_dbranch
  target/hppa: Allow prior nullification in do_ibranch
  target/hppa: Use CF_BP_PAGE instead of cpu_breakpoint_test
  target/hppa: Add install_iaq_entries
  target/hppa: Add install_link
  target/hppa: Delay computation of IAQ_Next
  target/hppa: Skip nullified insns in unconditional dbranch path
  target/hppa: Simplify TB end
  target/hppa: Add IASQ entries to DisasContext
  target/hppa: Add space arguments to install_iaq_entries
  target/hppa: Add space argument to do_ibranch
  target/hppa: Use umax in do_ibranch_priv
  target/hppa: Always make a copy in do_ibranch_priv
  target/hppa: Introduce and use DisasIAQE for branch management
  target/hppa: Use displacements in DisasIAQE
  target/hppa: Rename cond_make_* helpers
  target/hppa: Use TCG_COND_TST* in do_cond
  target/hppa: Use TCG_COND_TST* in do_log_cond
  target/hppa: Use TCG_COND_TST* in do_unit_zero_cond
  target/hppa: Use TCG_COND_TST* in do_unit_addsub
  target/hppa: Use TCG_COND_TST* in trans_bb_imm
  target/hppa: Use registerfields.h for FPSR
  target/hppa: Use TCG_COND_TST* in trans_ftest
  target/hppa: Remove cond_free
  target/hppa: Introduce DisasDelayException
  target/hppa: Use delay_excp for conditional traps
  target/hppa: Use delay_excp for conditional trap on overflow
  linux-user/hppa: Force all code addresses to PRIV_USER
  target/hppa: Store full iaoq_f and page offset of iaoq_b in TB
  target/hppa: Do not mask in copy_iaoq_entry
  target/hppa: Improve hppa_cpu_dump_state
  target/hppa: Split PSW X and B into their own field
  target/hppa: Manage PSW_X and PSW_B in translator
  target/hppa: Implement PSW_B
  target/hppa: Implement PSW_X
  target/hppa: Drop tlb_entry return from hppa_get_physical_address
  target/hppa: Adjust priv for B,GATE at runtime
  target/hppa: Implement CF_PCREL
  target/hppa: Implement PSW_T
  target/hppa: Implement PSW_H, PSW_L
  target/hppa: Log cpu state at interrupt
  target/hppa: Log cpu state on return-from-interrupt

 linux-user/hppa/target_cpu.h |    4 +-
 target/hppa/cpu.h            |   80 +--
 target/hppa/helper.h         |    3 +-
 linux-user/elfload.c         |    4 +-
 linux-user/hppa/cpu_loop.c   |   14 +-
 linux-user/hppa/signal.c     |    6 +-
 target/hppa/cpu.c            |   92 ++-
 target/hppa/fpu_helper.c     |   26 +-
 target/hppa/gdbstub.c        |    6 +
 target/hppa/helper.c         |   66 +-
 target/hppa/int_helper.c     |   33 +-
 target/hppa/mem_helper.c     |   99 +--
 target/hppa/op_helper.c      |   17 +-
 target/hppa/sys_helper.c     |   12 +
 target/hppa/translate.c      | 1232 ++++++++++++++++++----------------
 15 files changed, 947 insertions(+), 747 deletions(-)

-- 
2.34.1


