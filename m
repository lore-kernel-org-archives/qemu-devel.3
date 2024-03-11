Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E15C54E60
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgBP-0005Ao-Ga; Mon, 11 Mar 2024 09:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgBJ-00059g-Ko
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:59:09 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgBH-0003ax-BA
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:59:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29baec5f751so2026991a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710165545; x=1710770345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nG1z1j5EYE/lIKY0fj2u8vHOJM10LttW3eQfJYDOipw=;
 b=YN4jeHHG7VgVjMWSBDNpV2rhvWfG/490KXOVjF+uLzHuhvdDP60jn6eLDF44Ek+sBF
 hR7VusBXD9VQ9jHxrCELkft4Hz++M8XmZOxIP6jK4jU0iQ3163Sjeg35jHpSVh4fQT39
 Rdg50Jgw34hziS1Ip8e5IIvp/2LGTFHtc9s5yC7rB72GZgm/MEkw0nEfYCANqQhjqP+F
 bMFe8PcxUPUaRWFl/GdlNug3/hvaxZiW9YOqN4k7QFqUYN/xAdAPlp+oHdsa0Rjuydbv
 ORKH72NdQBeVIQZ85D1e9d4Dh+HGkRXNj9c+sITaUK+dXaCOxOWhTHFK4z+vz3qvUC6l
 YdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710165545; x=1710770345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nG1z1j5EYE/lIKY0fj2u8vHOJM10LttW3eQfJYDOipw=;
 b=Cv47fZmFS1FTw2Yp0p/rnNpuqW8PxWm0KD6f/1sHfO+915j5KhVQLAS4gjllPqTyt4
 cXAflbPlWQIhB59cukMAW0/offq6Y5DcpvzCuOPNyjcM05hvqfSJWXHQbMQbFl98vqyU
 DQ7v1YkUlwJ4zFS91QKT5RLAQdNNRZf09eIjEoWs1b47sE1hAFCcLaQBK4du8xWSTXne
 wI8C7DwCYavCNN2NtoScN0berOxUMzBRiYjf3LRm02oH03Kem6LJ9XCwZTXh22wBwq3C
 veJs7hrntIKefHeTv290yBgceySSHKjmnW/cM0qgri+mvN1MV+5bWiJf0ZlKhmiEZl7r
 /JUQ==
X-Gm-Message-State: AOJu0Yy9h5Ewc1bvphBJnvgfzkRJglKrbemxc/CW5sQJAzvwGoaDzFPU
 rumrdN6EOCb/rvwRlxAQz1DqjYizLNAlFgwbip46dZI7TAeh8+Do9jTbTtPUSvvEibil3sWQIXy
 n
X-Google-Smtp-Source: AGHT+IGDyHCFL6uZDrLc8TS+ZG+Sdfhl4AhYsTR1Okv7JTsZb50nPgbjoF1obUKxMqDyGJcnsAXDoQ==
X-Received: by 2002:a17:90a:578c:b0:29b:fb23:863e with SMTP id
 g12-20020a17090a578c00b0029bfb23863emr4403697pji.17.1710165544785; 
 Mon, 11 Mar 2024 06:59:04 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 nm3-20020a17090b19c300b0029c12fa64b9sm1324920pjb.4.2024.03.11.06.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:59:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v11 0/7] riscv: set vstart_eq_zero on vector insns
Date: Mon, 11 Mar 2024 10:58:48 -0300
Message-ID: <20240311135855.225578-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In this new version, after the comments from LIU Zhiwei in v9 [1], I
decided to ditch all the patches that were trying to integrate the tail
update process in a single function. Handling the right value for NF for
every single function is out of the scope for this bug fix. The patches
might be useful in the future if we decide that such integration adds
value, but for now it's too much.

For this bug fix I decided to bring a sledgehammer and inserted an early
exist in every vector helper if vstart >= vl. This will make the whole
helper a no-op if vstart is out of bounds, and make it trivial for us to
proceed with removing brconds and so on.

I also took the opportunity to fix the flag name in patch 9 from v10,
now patch 6.

Series based on master. 

Patches missing review: patch 3

Changes from v10:
- patches 2, 3, 4, 5 from v10: dropped
- patch 3 (new):
  - do an early exit in vector helpers if vstart >= vl
- patch 6 (former patch 9):
  - fix 'vstart_qe_zero' commit msg references to 'vstart_eq_zero' 
- v10 link: https://lore.kernel.org/qemu-riscv/20240310115315.187283-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (6):
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: set vstart = 0 in int scalar move insns
  target/riscv/vector_helpers: do early exit when vstart >= vl
  target/riscv: remove 'over' brconds from vector trans
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/vector_helper.c: optimize loops in ldst helpers

Ivan Klokov (1):
  target/riscv: enable 'vstart_eq_zero' in the end of insns

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 198 +++++----------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +---
 target/riscv/translate.c                   |   6 +
 target/riscv/vcrypto_helper.c              |  32 ++++
 target/riscv/vector_helper.c               |  97 +++++++++-
 target/riscv/vector_internals.c            |   4 +
 target/riscv/vector_internals.h            |   9 +
 8 files changed, 202 insertions(+), 192 deletions(-)

-- 
2.43.2


