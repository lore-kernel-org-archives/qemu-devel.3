Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B957C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWfZ-0007Lm-UV; Wed, 13 Mar 2024 18:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfY-0007LO-Rf
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:01:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfX-0004Hj-8z
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:01:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e62c65865cso309907b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710367308; x=1710972108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TFSTxgYADHLh8+V+Iz9O32AiQ4sAxnyxrW0wt9c8bw0=;
 b=jwRUyFV2ds/2nqY84aGKXh+UVwifRJt73hSmD/ShQSIE6wPPnSrGYdBVz6OF7RXN0e
 JcNWIjE+clHX0orACYf/gcq31LbdN8gqzdl6wbT+On35I8Pm4IZA7ah1VCNR6AfoGxlf
 nznaVNjdh4v0Lkt7M5g3mv8XuZQUkvcTfQpepm9ruGrmErx9vhj9RoG+KUOF8yg8xGKD
 2rBK/1YiiQEBtYb1MHbvLj/8PjFfjwLVTKV0L1SqjvnkyJ2NWHs5puagUp3U0JDv7/kF
 E+UkLm/mGyKM3xpnuJgYpkzAUL2rQmmNaJqFHC0bA7I7phIu6cFhDAqMl+h7QuspwvL+
 A1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710367308; x=1710972108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TFSTxgYADHLh8+V+Iz9O32AiQ4sAxnyxrW0wt9c8bw0=;
 b=rSDbWiqJOMUvebzrMMcYN5AxB6w+GIXx375Vu3wjBRLuWwSlDs+6fIFQo1FZ9YYmSP
 irRlz9JLjadW94aKDAYPbfGTt8d5a6PU64h+HlTfb5ckN+bRxCsy2miK++aPU3Ts4VAP
 k/8/iMNCboEGtuEscfRP/h2JBxWHxCYlQCFyhepvIJyBF665A0ZB62e5PBtJRh2dOsL6
 OCquivJHxDI93c2EnaIdzY2oR0FJseFJy0Owx/8xm64Z1hzECNMU34Y5GZoWy/zEiZrq
 TsjxV25Bro55pDDaXp8CFX2BOMYw7wGxU5lyko87f+vmJhJ43TVpOfSg5JnakE7/M7tH
 CEnQ==
X-Gm-Message-State: AOJu0YzH04rqFnNVje8v0II1r3zkO0xbLLXZdNFTd3hLZvzXLaDmeHqX
 djDEBCjXbP0nu3h1Ljo9UQUuwoILRYOHMN549+0O735DN/19ZAdhZuIx5040fTjTqJO9DC2wS/B
 m
X-Google-Smtp-Source: AGHT+IHPRM2HWffacRomXtzzdOOyiLwLjAVVEWcc/6cmVH4TG/9keS9jLb+76tR297BytnCu6wg2CA==
X-Received: by 2002:a05:6a00:1790:b0:6e6:4dfe:4c7 with SMTP id
 s16-20020a056a00179000b006e64dfe04c7mr26127pfg.6.1710367308430; 
 Wed, 13 Mar 2024 15:01:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ln17-20020a056a003cd100b006e6bcbea9e0sm95812pfb.88.2024.03.13.15.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:01:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v14 0/8] riscv: set vstart_eq_zero on vector insns
Date: Wed, 13 Mar 2024 19:01:33 -0300
Message-ID: <20240313220141.427730-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

In this version we're fixing a redundant check in the vmvr_v helper that
was pointed out by in v13.

To make this change easier patches 3 and 4 switched places. A trivial
change was made in patch 4 that don't warrant another review.

We're missing acks in patch 3 only.  

Series based on master. 

Changes from v13:
- patches 3 and 4: switched places
- patch 3:
  - fixed commit msg: from
    "(...) now sure that vstart is being clearer"
    to
    "(...) now sure that vstart is being cleared"
- patch 4:
  - do not check for vstart >= vl (i.e. add VSTART_CHECK_EARLY_EXIT())
    in the 'vmvr_v' helper
- v13 link: https://lore.kernel.org/qemu-riscv/20240313193059.405329-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (7):
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: set vstart = 0 in int scalar move insns
  target/riscv: always clear vstart in whole vec move insns
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
 target/riscv/vector_helper.c               | 100 ++++++++++-
 target/riscv/vector_internals.c            |   4 +
 target/riscv/vector_internals.h            |   9 +
 8 files changed, 205 insertions(+), 192 deletions(-)

-- 
2.43.2


