Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD409C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8B-0005nT-7x; Wed, 15 May 2024 05:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7w-0005fA-BA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7u-0001bW-8c
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41ffad242c8so35179385e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766044; x=1716370844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SyuoXfYsAb9M8fKmTegh01pw/QCKaCr2mxTEZx1QJ6M=;
 b=IMmHab5UR5kMwy21IWTvrEpmmHWDncOsZHzSIs7KYgoDz1wdeidRrBnHiLH2rJlvJc
 ZfWk7+2XdQfeiEXgQBHPrwDAOrGRabUjB/H038AuC/E85NGpEFAYS5v+xk9vIboBKPOe
 rqQC3OmfVcyP74yrdtRWenEB430nVtmM9TDlwcBvAfzySOZ9Vrjj9lR/8Apv1XxpOx7F
 tF2eIHw/Whc/glune6AtyZaRbCfUM0uclJNV26Lxmgu3QZOln3LzD2KHJvIUGQG1ku+h
 gSKqr6PAKYH593FmcBxbzJ93uLxCiKr6ALg1oDN2CI/wtm656QVjMjDmJl7P8y70mTQV
 kBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766044; x=1716370844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SyuoXfYsAb9M8fKmTegh01pw/QCKaCr2mxTEZx1QJ6M=;
 b=FBhTppMzYaoE26AWeGQXxuZan0PoqCqKd3CFhfv+DsT/TLTr+aNo2y7mtphlYi1E33
 6ZBvnKfgRl6wEtN47mMmd2G14a4SxISAEyGk0d+pJULZT5zfoMnsd43qoJktBi4suA82
 Wroj8Q5rjeueKdpbAUuODgxA+Glt1KSwEmBMJyihkUirSSxD/23KWXp34qRE6FLtJfg3
 HfDrHDsI1qx4iyf29KkiTzcCwzpoxBO7ufXDkkb19YAoBMpCO0huQJMS4zPbvY4stv4e
 5lUSLdJiWCJ/2jCb7hfLe5nN/qPl+v3pBfaO2Hszk4shsaixujzYIZeHKFLsiMpRNWT9
 wxVA==
X-Gm-Message-State: AOJu0Yx9ZGiZly0vE10WCASCRGMVmQfyXsd1AqzCfoPg7aveSz6A009H
 9aEgCIqOOJP5DBX+p/UyKz8YN/PcruDpB7aaHk9/OxpMFQRgClgVBcvsiy+CN6TOzzbW7/e2hmI
 gJqk=
X-Google-Smtp-Source: AGHT+IEr8fEMDrr4qxUeVLbF5MtVj3zn7Q7SQuhNgSSjKlbrttv7dJIaSiebqGHgbEz/g4tT4pcrsg==
X-Received: by 2002:adf:e8cc:0:b0:34d:b03c:9a97 with SMTP id
 ffacd0b85a97d-3504a95606cmr16945079f8f.48.1715766044449; 
 Wed, 15 May 2024 02:40:44 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target/hppa: Misc improvements
Date: Wed, 15 May 2024 11:40:00 +0200
Message-Id: <20240515094043.82850-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

The following changes since commit 3d48b6b687c558a042d91370633b91c6e29e0e05:

  Merge tag 'pull-request-2024-05-14' of https://gitlab.com/thuth/qemu into staging (2024-05-14 17:24:04 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-hppa-20240515

for you to fetch changes up to 9e035f00788c52a6f51529c54371a611d9f8b089:

  target/hppa: Log cpu state on return-from-interrupt (2024-05-15 10:03:45 +0200)

----------------------------------------------------------------
target/hppa:
  - Use TCG_COND_TST where applicable.
  - Use CF_BP_PAGE instead of a local breakpoint search.
  - Clean up IAOQ handling during translation.
  - Implement CF_PCREL.
  - Implement PSW.B.
  - Implement PSW.X.
  - Log cpu state on interrupt and rfi.

----------------------------------------------------------------
Richard Henderson (43):
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
      target/hppa: Log cpu state at interrupt
      target/hppa: Log cpu state on return-from-interrupt

 linux-user/hppa/target_cpu.h |    4 +-
 target/hppa/cpu.h            |   80 ++-
 target/hppa/helper.h         |    3 +-
 linux-user/elfload.c         |    4 +-
 linux-user/hppa/cpu_loop.c   |   14 +-
 linux-user/hppa/signal.c     |    6 +-
 target/hppa/cpu.c            |   92 +++-
 target/hppa/fpu_helper.c     |   26 +-
 target/hppa/gdbstub.c        |    6 +
 target/hppa/helper.c         |   66 ++-
 target/hppa/int_helper.c     |   33 +-
 target/hppa/mem_helper.c     |   99 ++--
 target/hppa/op_helper.c      |   17 +-
 target/hppa/sys_helper.c     |   12 +
 target/hppa/translate.c      | 1158 +++++++++++++++++++++---------------------
 15 files changed, 868 insertions(+), 752 deletions(-)

