Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE04CC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIq-0002lD-SC; Fri, 15 Mar 2024 21:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIj-0002kJ-LK
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJId-0000hU-DD
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ddbad11823so25693925ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554245; x=1711159045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JG6tKMkxxOXY60ERmQDKbPNxZExc4jAIDV0BFIBUHCA=;
 b=aJF9QSO10/s889SMILpSxJlgK9NcXGf4PMq/Ixq2Gm3uSQOtr3EiU6h6AF2NVYp18F
 7zZlMrzt2+xn6u02PorEZMwvSKMJplu8aT+brPZzS6ZjEcGpEHwr7qvtxxutgOZzuT67
 qFKDdMM265qESCzIj4oRnjDxIrNUfY9Ez1xqMFivZBK7FQ7/iVbZsnolNDhJNzojAfCE
 AmDNY3kQ4sTrdCovky/RL5iWuFyLvDAQFUnkjD+rkO4u//mMmPqPuGWwvvnKPoAHg4Sp
 U7pdmlnqxt7VvZ/r9RPXW4ZckxRySe1CpKOP8+7ifvOrt7xU8GPBU65hgTHVgYb7U/Gn
 hYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554245; x=1711159045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JG6tKMkxxOXY60ERmQDKbPNxZExc4jAIDV0BFIBUHCA=;
 b=izDsvMM7ulou6wkRInq2gX7DMdF+LJBLM52WmUoPHmtHS8ZG9xcFbziWW+H+OrK9IE
 76UyZ1GxACLLOkpAunmDtROwXPDFIKeNp/gDK/itcirop1J/KJT/cpllDpiaLV60rFhA
 XlvmRKaNxN65+QSxObL0VMv4xMe4xI3OxTYAK43b7xeksk8GIMVeQlxJcA7ShWr33OXa
 Ox/8dw6k7DAkgLMedIO6YM/P/GF5sz6LpVxxXXN9Ie9YfPz5T+45IuN2U88z8DMsUUNz
 VwK9Vcu/LnZZopvxLcicjrKgMnOmk0eBOwFk1mXDYq2NZAXSZgefbHrU0n49p8QNxOXw
 pZxQ==
X-Gm-Message-State: AOJu0Yx6F65v7OKJXjzbLOdxFPIvkAFlAJO0DZDmE0eg7SqwoXOsOBFg
 xembE7Lr3bvM5t2wwExd1ah0as3XMW19hWQBl+61+FRGtpkk5PTzmvqYTbgSgg3uRnEY/4q4zeS
 2
X-Google-Smtp-Source: AGHT+IHeUkmLxVSvvXmcbVZHgeCPSYm53hzH3JLDc2eirnrsPXAmUYA9QNfTunlsfcijob/XHZgBxQ==
X-Received: by 2002:a17:903:2644:b0:1dc:3e49:677d with SMTP id
 je4-20020a170903264400b001dc3e49677dmr6562892plb.26.1710554244724; 
 Fri, 15 Mar 2024 18:57:24 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 00/22] plugins: Rewrite plugin code generation
Date: Fri, 15 Mar 2024 15:56:58 -1000
Message-Id: <20240316015720.3661236-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As I mooted with Pierrick earlier this week:

(1) Add a (trivial) mechanism for emitting code into
the middle of the opcode sequence: tcg_ctx->emit_before_op.

(2) Rip out all of the "empty" generation and "copy"
to modify those sequences.  Replace with regular code
generation once we know what values to place.

There's probably still more cleanup that could be done:

There seems to be a lot of artificial separation between
plugins and the rest of the code base, even between
plugins/api.c and plugins/core.c.

I suspect that all of plugins could be moved into the
build-once buckets.


r~


Richard Henderson (22):
  tcg: Add TCGContext.emit_before_op
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
  plugins: Move qemu_plugin_insn_cleanup_fn to tcg.c
  plugins: Inline plugin_gen_empty_callback
  plugins: Update the documentation block for plugin-gen.c

 accel/tcg/plugin-helpers.h         |    5 -
 include/exec/helper-gen-common.h   |    4 -
 include/exec/helper-proto-common.h |    4 -
 include/exec/plugin-gen.h          |    4 -
 include/qemu/log.h                 |    1 +
 include/qemu/plugin.h              |   79 +--
 include/tcg/helper-info.h          |    3 +
 include/tcg/tcg-op-common.h        |    4 +-
 include/tcg/tcg-opc.h              |    4 +-
 include/tcg/tcg.h                  |   27 +-
 include/exec/helper-gen.h.inc      |   24 +-
 accel/tcg/plugin-gen.c             | 1008 +++++++---------------------
 plugins/api.c                      |   26 +-
 plugins/core.c                     |   61 +-
 tcg/tcg-op-ldst.c                  |    6 +-
 tcg/tcg-op.c                       |    8 +-
 tcg/tcg.c                          |  104 ++-
 util/log.c                         |    4 +
 18 files changed, 424 insertions(+), 952 deletions(-)
 delete mode 100644 accel/tcg/plugin-helpers.h

-- 
2.34.1


