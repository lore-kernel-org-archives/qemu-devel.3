Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD60C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlE-0006SR-Oe; Tue, 20 Feb 2024 14:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVkz-0006OV-Gk
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:21 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVkt-0006Th-Qo
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:19 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7c745af8f1cso117593839f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708457174; x=1709061974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KH6FwagXPISB5V5N/gfnHCV4noWWen5LvAfwzlCmLdM=;
 b=ijlbBgokLvaFJ5y78vi0gCJI75eLJuEwX54tCN/sI+c/nHeMeC+RyhrJywWlXRSk2R
 m/IhsZnYAI12hGQq0x/BrZgMcHR9LTroGSzw916Kveo7Skr98nR+4DhP9+C3hPhIOKBt
 Awl48J/o/ExaCN4WWkzNE2RgYukrS9WDMIuX8cUWi/OQJfAICpFTsWDl4Gdf22J5eciP
 ygi0b7kpzqzRIeyyt8j73HcRaC5cDpUI+nvqwfpSKyfBk64894UhA/u3dMd17VvVTwew
 0p0oCKKBj7la4pcjAQYmPxbvflZa53Ielqj5bCJKqBn7FUS/xVyAXfk1iHOpN7EiAcER
 flmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457174; x=1709061974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KH6FwagXPISB5V5N/gfnHCV4noWWen5LvAfwzlCmLdM=;
 b=ZglwS5OzVXpWViFCxKJmJbW7d5FGqBpNMz7Ocwcrlahj8jsZWp/OfU1wVlSA6WV/gj
 X31AoRSC03qftF9JEQmjPHXozvQgebVrRBEQ8MPJsAoxan8qnbkDf51doZIRvnp0axMS
 b4ROGYPPql5BbaM+3TnXx+wpO7VT+aIdFS74g2gi7AL16fCaapvoQeU8/LeD+3/GFOzV
 JF/GC+XTZ3ExdR1Y4K57h8HJtMdmLXQd/mT38/VERpjUzh1GCxUG08/AjkUPsxWscAJC
 TAugfN/ncHwOXV0rhymUpcF+tjploE6tnMkA9O35+EMvZbw7QiJ7JagYvoKc3KEkPWVq
 y8jw==
X-Gm-Message-State: AOJu0YzElWXcouxBUJRrgWXn+iHLHmnqoqjJSVrr/PJ8pI6oj7KnfgDt
 g627RBdLMby8Ljt2sWOpS+rio4zBZZQmv4f4gu+JE/1sB5d1/xaR7KsqDILe3qzleDPYcymV/5U
 Y
X-Google-Smtp-Source: AGHT+IG9RGtEO0wcMKxnhVfiU842/235wgZqlM+NbTTko1+lE/d/dhTOx31FFTd2n7p1QUaGIvjWgQ==
X-Received: by 2002:a05:6e02:1d8f:b0:365:858:d6d1 with SMTP id
 h15-20020a056e021d8f00b003650858d6d1mr19938040ila.1.1708457173950; 
 Tue, 20 Feb 2024 11:26:13 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i73-20020a636d4c000000b005b458aa0541sm6943005pgc.15.2024.02.20.11.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:26:13 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/5] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Tue, 20 Feb 2024 16:26:02 -0300
Message-ID: <20240220192607.141880-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-io1-xd2c.google.com
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

In this new version I decided to scrap patch 3 from v2 and added a patch
that Ivan Klokov sent back in December [1]. In that patch Ivan was
already doing things that Richard suggested to be done in patch 3 of v2.
This is done in patch 5.

Patches 1 and 2 were suggestions from Richard that I'm adding as
cleanup. Patch 2 in particular helped to clean up quite a bit of code.

Patch 3 is a fix in GEN_VEXT_VSLIDEUP_VX() that I caught while doing
code inspection to assert that all helpers were setting env->vstart = 0
in the end.

Patch 4 is patch 2 from v2 without any changes.

Patches based on alistair/riscv-to-apply.next.

Changes from v2:
- patches 1 and 3 from v2 were dropped, patch 2 from v2 is now patch 4
- patch 1: new
  - dirty vs state before stores
- patch 2: new
  - remove redundant conditionals
- patch 3: new
  - assign env->vstart = 0 in GEN_VEXT_VSLIDEUP_VX() 
- patch 5: taken from [1] with the following changes:
  - fixed conflicts with alistair/riscv-to-apply.next
  - changed "finalize_rrv_inst" instances to "finalize_rvv_inst" to fix
    trans_rvvk.c.inc build
  - set_vstart_eq_zero() removed; finalize_rvv_inst() will do a direct
    ctx->vstart_eq_zero = true instead;
  - finalize_rvv_inst() is removed from the #ifdef block since it's now
    relevant to linux-user
- v2 link: https://lore.kernel.org/qemu-riscv/20240216135719.1034289-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (4):
  trans_rvv.c.inc: mark_vs_dirty() before stores
  target/riscv: remove 'over' brconds from vector trans
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls

Ivan Klokov (1):
  target/riscv: Clear vstart_qe_zero flag

 target/riscv/insn_trans/trans_rvbf16.c.inc |   6 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 224 +++++----------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
 target/riscv/translate.c                   |   6 +
 target/riscv/vector_helper.c               |   1 +
 5 files changed, 70 insertions(+), 197 deletions(-)

-- 
2.43.2


