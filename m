Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6000C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjHkD-0007hW-M9; Sun, 10 Mar 2024 07:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHk5-0007fc-Qz
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:26 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHk3-0003zp-VX
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:25 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c1a2f7e1d2so1518558b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710071602; x=1710676402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PJK7zmRK0isVONsw2EtFl149ztLVuN2NCZzyZby+04I=;
 b=HVxrOSzvFWjf0efj/7txLNRtXESAUsusxkUa0NWxhT3ZRimp9v8rUAicLvYwDnmcag
 Nw+IrvnmTg83Gm16vRlhsTlWRcV9syGR0Ic6YmXiKwPsMINmiGF9k5yw35TPhXnwboJw
 1/dBynX17Ys6OuLIgH9tBu17FzF5Y7utfiZbSDwC0fWgiqSEk6nOuyeuTqGnISixsDXG
 XDN6zsPuKdNRxdEOhjau/2jDbAS6Q6rBeXy1D5WCWqDsoPFzIzerArIcpyJHd4SMPsZq
 riw8FXEUEm0SaHJ2m2w8fA9z27aaLe1Zx/JEMjHgkMr6FDowx52FgKDNR8HrApWW9VYd
 wARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710071602; x=1710676402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJK7zmRK0isVONsw2EtFl149ztLVuN2NCZzyZby+04I=;
 b=h19nUwCK5GwiAM0lhlJJA0y92+rNfcf47BpdJjsAexorsbeh72ZWOdJ9bI3hmn+n0Y
 /Kf4fjXn/mFfosUqtC/LCJLWNpNeAt/NtxJBTljSrl32Fw1I6mPdM7f5+5rwnW4uS4Ru
 Ug5IGlSR32a84MiIUUANZlQbeK7LkkOFVRaH3dI/0pLJQv2kUAh5tQi1HErMolw7hAjd
 iyXzAiIfee6TDhjAowVpMLK3IGTtJHYqCksglAkMH4xTq2SUaFQdZygLw2ofLpp4kSso
 +Qy8grI4zzn83G0epHn5qGO2lLrA2ULFjrTjXFlGD+tHWuB9EEZaDbBjnE/RSXcvD2Jq
 ubTQ==
X-Gm-Message-State: AOJu0YxkfpoePHJlHh6IMDecF2Am4P/PRHxv9FKX5g1SmKv+pHun/sYZ
 i4GmVg+Xd9N7+t9GP6jfDsdzFSR78dREkT3d+ZySSALPLxxdNjyG+SLDe2V/x4vgaIyuUFsOhtG
 +
X-Google-Smtp-Source: AGHT+IFY5xa65U3IjrZKT6Lofh+OR8YsjQ9SskIwjFL4KQm8uBa2zIvJB/Z83UYLzuv+cDHKuX1lBA==
X-Received: by 2002:a05:6808:96:b0:3c2:1f28:2482 with SMTP id
 s22-20020a056808009600b003c21f282482mr4196828oic.29.1710071601840; 
 Sun, 10 Mar 2024 04:53:21 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 g22-20020aa78196000000b006e647059cccsm2449253pfi.33.2024.03.10.04.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 04:53:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 00/10] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Sun, 10 Mar 2024 08:53:04 -0300
Message-ID: <20240310115315.187283-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
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

This version has changes in the wording on patch 9 subject and commit
msg. The previous subject, "target/riscv: Clear vstart_qe_zero flag",
isn't accurate. We're not clearing (i.e. setting to false/zero) the
flag, we're setting the flag to 'true' in the end of each insns.

The first paragraph of the commit msg was changed a bit for more clarity
too.

No other changes made.

Series based on master since RISC-V latest PR was merged.

All patches acked/reviewed.

Changes from v9:
- patch 9:
  - changed subject to
    "enable 'vstart_qe_zero' in the end of insns"
  - changed first line of the commit msg from:
    "The vstart_qe_zero flag is set at the beginning of the translation"
     to:
    "The vstart_qe_zero flag is updated at the beginning of the translation"
- v9 link: https://lore.kernel.org/qemu-riscv/20240309204347.174251-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (9):
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  target/riscv: handle vstart >= vl in vext_set_tail_elems_1s()
  target/riscv/vector_helper.c: do vstart=0 after updating tail
  target/riscv/vector_helper.c: update tail with
    vext_set_tail_elems_1s()
  target/riscv: use vext_set_tail_elems_1s() in vcrypto insns
  trans_rvv.c.inc: set vstart = 0 in int scalar move insns
  target/riscv: remove 'over' brconds from vector trans
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/vector_helper.c: optimize loops in ldst helpers

Ivan Klokov (1):
  target/riscv: enable 'vstart_qe_zero' in the end of insns

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 198 +++++----------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +---
 target/riscv/translate.c                   |   6 +
 target/riscv/vcrypto_helper.c              |  63 +++----
 target/riscv/vector_helper.c               | 192 +++++++++-----------
 target/riscv/vector_internals.c            |  29 +++
 target/riscv/vector_internals.h            |   4 +
 8 files changed, 207 insertions(+), 333 deletions(-)

-- 
2.43.2


