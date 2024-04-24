Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176A9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldK-0003fg-2i; Wed, 24 Apr 2024 19:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldF-0003fE-BK
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldD-0002c7-PJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso425307b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999746; x=1714604546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bxzymTeq9MJH9X+xVPTgvnNpZIp6J8+/r/qnwzsJCNo=;
 b=b/k4cIp0kdElxxxn9Pxl172SZz0woDOZDkLmn8KVcZ/x8NJpoCojW4rJ+DKF/RhfHT
 bmSSVF+eXuS7EAENLaCGhucyKte+HUW+Sv689XCfr+1aoSaGqHZQLy5dyWtakaJBaXCw
 fmBQlE2EznZYflzv3i0in8SdRgUyrxgKub1b47fB89fxKJE76SsJY9PiwNAE6ka4zOl8
 yRjH4qFPsR1uJtZlAWCy7KhvS3RMUM6n8KiVdFq58+57KCPTXxCOspHwHzq1e0psjmCJ
 AnmnRKJYO3UevBufwx01tCTT9Uo4ShDC+OdjR3/8eHrqQp0nX7EAl7Ia3XCjH2oLEkXw
 DWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999746; x=1714604546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxzymTeq9MJH9X+xVPTgvnNpZIp6J8+/r/qnwzsJCNo=;
 b=G+7Ub1meNXuYb9Lf+xvJ/doKXpDBmyqhVMlmYtHGwVFk99jd6+uedpT4fqvx/UtN0X
 8K6V858vmB8VvVR1FMOcsp0RZd0Yf6j0QINFey762cYC9BkfANdlAaoU0OSGhoVkOOzH
 3VKWeACzyFT8Kw71L7WAFItKNrvIVSAFeT4HQzIPVahLN0yIKWkpf9+YRidpT7wAigGM
 9mkgoJ/aCOdFdjxGm9xJ2YA+BM3W0dEe0g+EsXLo9S3MQvvy45WvTgz4NZZipQnzbcgV
 nHqvGhBmQHQz04rZotD3XjR3tgLywK3g3NSLa7gdFyosKwDZEh6SZJxCp929WfheLKtO
 vtgQ==
X-Gm-Message-State: AOJu0YwvJdHuw3AscFBIwcA0j3ULNyEMLoW0EzBdIcAM0HWmUWSnACqN
 JJYcjysa6Zhnn1KA62dGMrnu6FojZugk6UETEKZKUh5Pz9EVPbwUdBuWztBDPqK4eEDpeAeUDNd
 P
X-Google-Smtp-Source: AGHT+IEMWq/8bumPjZWakAjmvSAdV5CV0ALTLmhX8ch//NtId5Smi5zqrBjpQZa0JHN2ZrOvcuaxEg==
X-Received: by 2002:a05:6a00:2d96:b0:6ec:f5cf:2bb1 with SMTP id
 fb22-20020a056a002d9600b006ecf5cf2bb1mr4336483pfb.6.1713999746161; 
 Wed, 24 Apr 2024 16:02:26 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/20] Rewrite plugin code generation
Date: Wed, 24 Apr 2024 16:02:04 -0700
Message-Id: <20240424230224.941028-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patches 6 & 7 still lack review.
Changes for v3:
  - Rebase.

r~


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
 include/qemu/plugin.h              |   67 +-
 include/tcg/helper-info.h          |    3 +
 include/tcg/tcg-op-common.h        |    4 +-
 include/tcg/tcg-opc.h              |    4 +-
 include/tcg/tcg.h                  |   26 +-
 include/exec/helper-gen.h.inc      |   24 +-
 accel/tcg/plugin-gen.c             | 1007 +++++++---------------------
 plugins/api.c                      |   26 +-
 plugins/core.c                     |   61 +-
 tcg/tcg-op-ldst.c                  |    6 +-
 tcg/tcg-op.c                       |    8 +-
 tcg/tcg.c                          |   78 ++-
 tcg/tci.c                          |    1 +
 util/log.c                         |    4 +
 19 files changed, 399 insertions(+), 938 deletions(-)
 delete mode 100644 accel/tcg/plugin-helpers.h

-- 
2.34.1


