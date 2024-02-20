Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B644FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYYl-0002UV-5f; Tue, 20 Feb 2024 17:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYL-0002Ot-AJ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:30 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYB-0003T8-UF
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:27 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d731314e67so42911725ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708467917; x=1709072717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SpkN0ilkIdZABSfxaQ1WQMJCJ39fGGQfiBR1AGMRMMM=;
 b=RggGo0JP90qYWj6HKQKcA2xJdc5gZjBXKPLL/Snrk+cUNj+sD1S95n3wULByN/m7Pv
 ut74vzFb73ADO0iWxFZRMvdkg2nQ+ONaRRynAulaxrWJnB1qh/vUc8VswQ+H/6Brchx3
 HQyXSNsQQ0hCdNEq78vb3RSfEMFT+hV/1sXql0CWNvXJH/z+uSPT1uoHtoYt7hq4vzIT
 MM2+0RdOohMHQxn0fq3DXL03XcW4Ft/Ti5fkUojlJ1jC/dWE1jYcoOVUnq9nQVd3UPHZ
 s789+za3eOG36/F1RcThX/ZMKOCYdMe9eiQzxJ0ZvHVJjMpiIF8nSWktbdzN0/3IGXA+
 J/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467917; x=1709072717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpkN0ilkIdZABSfxaQ1WQMJCJ39fGGQfiBR1AGMRMMM=;
 b=nBNR6QgZnWKPIPrtN71faHbZ5GqfgMSyDxvF3KkGBj+dS/ThQBH4CzxEoBeHbNxq/e
 8PBo5NEeMEDj+ZL2CJkIcYJiDwTO9Cb+ELJALQQ46B/qwVZibP25Z/L1jGcTvwkmdIPf
 9b6nV43yno4Q4tBCvQA3s9NZO8ld7s19xKx64pdTeusECpXJGXHZivW2Y/jLeseR0sh4
 k2RCOymolKBQjdMn+EyMMeQrNi8IPGo+3W0Qrlt7YdA5QkOEechsMCxmOMGFTFw0zIf1
 iPlY5mIR6Y6llCKVV1SIOcEKZLMkovvEgv0XJ3rIGMXvhIZr55qpKduJpS5sqJt0F6fz
 PpRw==
X-Gm-Message-State: AOJu0YwLmJMefIhkZiimBVzO7nFxrzHJr/sz/b0/KuJGElyNVIioPTb0
 zg15TCcbMcoDDTMPdWRon97NHjJzNbVnt8ZJos6Ce1BwctDyChvAkrjFZiLEnkHZ5KomnzFEiWe
 p
X-Google-Smtp-Source: AGHT+IFdVKTBKq0Xy4kIAQ0xipS1se2tW1pzFseFawjHx8qIFiIl+wSk7mVcDwS3O5Zyp/RCh39bsg==
X-Received: by 2002:a17:902:e952:b0:1db:cf8c:d462 with SMTP id
 b18-20020a170902e95200b001dbcf8cd462mr10395944pll.63.1708467917667; 
 Tue, 20 Feb 2024 14:25:17 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001dbb86b88e5sm6761044plb.124.2024.02.20.14.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 14:25:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 0/6] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Tue, 20 Feb 2024 19:25:04 -0300
Message-ID: <20240220222510.209448-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

In this v4 we changed patch 1 to do mark_vs_dirty() after both loads and
stores, not just stores.

A new patch, patch 2, was added to clean-up the now unused 'is_store'
argument from these functions. 

All other patches unchanged. 

Patches missing reviews/acks: patches 1 and 2.

Changes from v3:
- patch 1: do mark_vs_dirty() for both loads and stores
- patch 2 (new): remove the now unused 'is_store' arg from load/store
  functions
- v3 link: https://lore.kernel.org/qemu-riscv/20240220192607.141880-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (5):
  trans_rvv.c.inc: mark_vs_dirty() before loads and stores
  trans_rvv.c.inc: remove 'is_store' bool from load/store fns
  target/riscv: remove 'over' brconds from vector trans
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls

Ivan Klokov (1):
  target/riscv: Clear vstart_qe_zero flag

 target/riscv/insn_trans/trans_rvbf16.c.inc |   6 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 292 ++++++---------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
 target/riscv/translate.c                   |   6 +
 target/riscv/vector_helper.c               |   1 +
 5 files changed, 99 insertions(+), 236 deletions(-)

-- 
2.43.2


