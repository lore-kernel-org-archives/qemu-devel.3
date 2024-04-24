Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5D6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXk-0008Aj-1W; Wed, 24 Apr 2024 20:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXO-00088I-PG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXM-00068T-Jn
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed5109d924so440810b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003227; x=1714608027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AFDAMBsOqP15KyZoIrMT4zuMcfapYJQz+ty1Lh5NUtM=;
 b=lOoNb1GLVAlbP/fAz7HWGu36KueW8ZYfwlRLR6TojITqbg1THMnN9rNk/XTQREK1YM
 2Wf3hS9hkqMzioUDSzeZu5lqrFzMJKp6fPpdwbxydiOqHqnAxnnFMLW3MV6P+yscrQpk
 miqv7jvPEzb+EyYWUhWkxUnUFZ+Q+x1UBrHrppjPywH3S29y1FV5K4C7pIuh5d58N/Ww
 NwjIYqtYXQrRMhEwiBfAa0tlZWfgyis+vLdYMeuBX2wKYudvgV+OapfLERoajXkE6I8o
 itdlUC04V+H6mZJ+R4dc5ARNxn9G6iSPpP7LAfFjyl8kmn4HLyl4ImfgCi0fmNMXDKuK
 +OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003227; x=1714608027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AFDAMBsOqP15KyZoIrMT4zuMcfapYJQz+ty1Lh5NUtM=;
 b=mq0eE2LFBNWqVvTOOahl4W5BQS4Lqj//20Pt+H7LMLEgoitsnw9pPkaYT8IMqQ/mog
 VxM4QTTXF8HRoc8MQ882eFnNKEXS2z1ZzFgLD9c83OzlnyBwUFZo4CJfIhFIeqTP46Vu
 PFUrf4Z37T2cW3SCCorsCq8vcwWWz015atLJcXwDtCL5Ah3IgG0mgqd/cbB42qrVnd8o
 3ucY6fuK9MPnJvilPkw47qZD9qq1pATJknjDE9P9og2Ig1wNB/oTOYNYCehOqvBVViHW
 WXIhTJYT1zewFam9rxsdK0UAw1GMEL3WEt2/vmZcGC3YEAqSH2SGPRSE+ipRs0HqZBX/
 AbYw==
X-Gm-Message-State: AOJu0Yw1kkW+6/0DH9zjzO/sPAe0Z77y5MitQ9TfPMxQ4HUy3QEEu3HN
 DUetY4Y0N2qXYEOIL0Sjafc/wUbLCV7dGq84TCNjiNSDN+8D7BzImPQUzTA8y+xD71Vb55qdJOF
 c
X-Google-Smtp-Source: AGHT+IF702TnHIlM/eCUTNdjU5LcSWFEPhHHOgMBpEOxC1ieySDkFecSv+HQzRGQivfkKGFEu1jUqw==
X-Received: by 2002:a05:6a21:6da1:b0:1aa:5b16:1ed with SMTP id
 wl33-20020a056a216da100b001aa5b1601edmr4968747pzb.10.1714003226727; 
 Wed, 24 Apr 2024 17:00:26 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/45] target/hppa: Misc improvements
Date: Wed, 24 Apr 2024 16:59:38 -0700
Message-Id: <20240425000023.1002026-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
  target/hppa: Store full iaoq_f and page bits of iaoq_d in TB
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


