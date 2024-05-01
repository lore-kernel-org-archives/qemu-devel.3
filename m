Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C48C25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5e-0002eb-OH; Wed, 01 May 2024 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5c-0002dq-W0
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5b-000263-61
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e86d56b3bcso62718995ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574261; x=1715179061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=furAQd7XvwfV8SmRUgHo1DaisvSn979/g0ik4ge2VWo=;
 b=mtJtf8CPdCJ1I1G0wQU/fjmfJY/ga96YH8lGeAqFkAwbLIbK8TgKktDy1R+ulrMOLT
 qp7KdfBE/R5eykihyR/d0OxF21Dc/T03NbyoiSJxgVbRS1WJ50dMEBdMJLGCX6jd3s+A
 py7wiIXs2MwWLupFU9SxArJH9ac6Ef6Egkc7lMjUsZdUVMOJnSDa7E8JoMNBSoyTQW2S
 27GE/749nnbc5aZ0FWx6AV2l1K+bwlhgfrdI5S1KtSK85cGdkT6Da+Zznki3x671tHjZ
 yH8H8Ml7tzkMMhSnXetNnbMT9gmrUO3r4aJDe0oyIBsaBKj5ERfMO4xTXEiHA7wznogK
 C6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574261; x=1715179061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=furAQd7XvwfV8SmRUgHo1DaisvSn979/g0ik4ge2VWo=;
 b=rUq+3dkxscvUbMJehzK7pufP0iQIGS5/fh7qDpd0IdNCDTtvmPlPBjK20+QeawRAj7
 qTBDqZs+esxh/V1Iz/DfNSTfhumEd1CIpZRUEsPkqWmulmNpOA7RPOa3Zo3gLwlqdaiY
 4Es/A+9MB5/zAkySrkQPDTdofP3+v+Uv+IQpjfPA58XObvHW77trQG4sK/68pCxabu9O
 ghbZ2pqOdnZN+HmY5zhuKz0QgaQP2DF55DRanENxIrfiivN0rDPAvg7Zbrd2qPWaooHA
 BVSux8X3n+08FggIa6bZaPOUiOPdSsdXl+YH9YGbZf3R4tgXa/LOBYOawinU4PPOftjp
 kEQA==
X-Gm-Message-State: AOJu0Yz2MHjXooOsstxSp0l4ihj42rQzN9zqjGVP/1z5nBWOT+FS/ZdH
 Kfv8rFd/lIreiQCK7427w2627BfTgPDr95Z48EvdowBLOpqK6Orwxri9/bU26GaNoCX1la5CG1h
 B
X-Google-Smtp-Source: AGHT+IE03E/2ipB/fDznNSm6g+0TpYntAEvrgqVBcA6SIQJKN8BGNmggVz5TshMmpUHKvaiUfH9OUw==
X-Received: by 2002:a17:902:f7cc:b0:1e7:b7a7:9f20 with SMTP id
 h12-20020a170902f7cc00b001e7b7a79f20mr2313764plw.59.1714574261215; 
 Wed, 01 May 2024 07:37:41 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] tcg patch queue
Date: Wed,  1 May 2024 07:37:19 -0700
Message-Id: <20240501143739.10541-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The following changes since commit 9c6c079bc6723da8061ccfb44361d67b1dd785dd:

  Merge tag 'pull-target-arm-20240430' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-04-30 09:58:54 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240501

for you to fetch changes up to 917d7f8d948d706e275c9f33169b9dd0149ded1e:

  plugins: Update the documentation block for plugin-gen.c (2024-04-30 16:12:05 -0700)

----------------------------------------------------------------
plugins: Rewrite plugin tcg expansion

----------------------------------------------------------------
Richard Henderson (20):
      tcg: Make tcg/helper-info.h self-contained
      tcg: Pass function pointer to tcg_gen_call*
      plugins: Zero new qemu_plugin_dyn_cb entries
      plugins: Move function pointer in qemu_plugin_dyn_cb
      plugins: Create TCGHelperInfo for all out-of-line callbacks
      plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
      plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
      plugins: Add PLUGIN_GEN_AFTER_TB
      plugins: Use emit_before_op for PLUGIN_GEN_FROM_INSN
      plugins: Use emit_before_op for PLUGIN_GEN_FROM_MEM
      plugins: Remove plugin helpers
      tcg: Remove TCG_CALL_PLUGIN
      tcg: Remove INDEX_op_plugin_cb_{start,end}
      plugins: Simplify callback queues
      plugins: Introduce PLUGIN_CB_MEM_REGULAR
      plugins: Replace pr_ops with a proper debug dump flag
      plugins: Split out common cb expanders
      plugins: Merge qemu_plugin_tb_insn_get to plugin-gen.c
      plugins: Inline plugin_gen_empty_callback
      plugins: Update the documentation block for plugin-gen.c

 accel/tcg/plugin-helpers.h         |    5 -
 include/exec/helper-gen-common.h   |    4 -
 include/exec/helper-proto-common.h |    4 -
 include/exec/plugin-gen.h          |    4 -
 include/qemu/log.h                 |    1 +
 include/qemu/plugin.h              |   67 +--
 include/tcg/helper-info.h          |    3 +
 include/tcg/tcg-op-common.h        |    4 +-
 include/tcg/tcg-opc.h              |    4 +-
 include/tcg/tcg.h                  |   26 +-
 include/exec/helper-gen.h.inc      |   24 +-
 accel/tcg/plugin-gen.c             | 1007 +++++++++---------------------------
 plugins/api.c                      |   26 +-
 plugins/core.c                     |   61 ++-
 tcg/tcg-op-ldst.c                  |    6 +-
 tcg/tcg-op.c                       |    8 +-
 tcg/tcg.c                          |   78 ++-
 tcg/tci.c                          |    1 +
 util/log.c                         |    4 +
 19 files changed, 399 insertions(+), 938 deletions(-)
 delete mode 100644 accel/tcg/plugin-helpers.h

