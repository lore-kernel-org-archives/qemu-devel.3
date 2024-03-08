Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19541C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAa-0007Sj-TO; Fri, 08 Mar 2024 16:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAU-0007Re-AW
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:18 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAS-0001jU-8S
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:18 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e5eaf5bb3eso2290281b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934853; x=1710539653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2FWd3NR8qEeKeoNTFFoRKGVbONwFQY61OESTh2K8iJo=;
 b=elBLNtIsuy+bJxp7Sd1FNW5wWqItfWmiz5Yb8fkx0BEyr9s/9/DIXkEMBV6sYx7GT/
 zIvGrBOdpCaMvbYczvqp02+58UFmayxTi1PHgIMBDSi4bgqu3KwJIk8kbb8B+YZKsZAh
 GgzVqggIcA8nCpIflWW5GCZidbilxkt/whTCJ0UTxIcxy8Oj9RmRb0d7M5UXE7XPujBQ
 aDPj6WdqwE2RPvEwD7UBTLF3qMvGLPjUfYh2+hLDChWwAW/77FZ5+WnRheqOSo9XI4XD
 T1goFPd8IhFR/5fa1i9n5nTgnRePe5461n/WahG4h51lJlSzmIYxu0OmgpoPQGzNhPtd
 CLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934853; x=1710539653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FWd3NR8qEeKeoNTFFoRKGVbONwFQY61OESTh2K8iJo=;
 b=kQcEBWsnT12TRl9QdubxBZBNjiTK+GNw24isOoyy9HEl0D6JJhsD0xTJJ8I8eIlVR0
 9nV5y2r3QGSSK9vU+z4OQSaj1g007EekiqUSRZGbP4oWTYoZ5uz/SjmCRZ23aYXzLRGa
 Vv2BcRJGM/e0oAa3YTkJTLV60GFWIoCXOY1qw6cyVxXePZXvZhkd01/MvaHC96Yj2OI4
 NIwzAY/eE2m7Hb3Ilt/t0dY5x20QTZOS+RTOWfCij77nnZT5w2i8bs1O/8DCa/ojDrRi
 8CkCA8DylLeqBGH6HPmbk/atONldTGJPkar00C4B7OxsaVVc52cvT+AOShGwdzvpXwe7
 lx3Q==
X-Gm-Message-State: AOJu0YwuhwDmTogoqGp6VME3j2nd8AHluHwqlY3FowiMxmJMp3htUEAH
 gRoXmVbcKw20s4wwDZiLXiEG/7fy96/tXbUFvhgQYiZDQk0FzgUHrEmL159jzxSJtJN0X3MkReN
 Z
X-Google-Smtp-Source: AGHT+IFHnOpZEPUu8hvxAxTLNog2+z+C54r5kbuWjbxNmSwnr5rhAYKkCKXGUl9t8g6MkegWWU58Vw==
X-Received: by 2002:a05:6a20:8baf:b0:1a1:5108:ab57 with SMTP id
 m47-20020a056a208baf00b001a15108ab57mr261485pzh.60.1709934853193; 
 Fri, 08 Mar 2024 13:54:13 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 00/10] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Fri,  8 Mar 2024 18:53:40 -0300
Message-ID: <20240308215402.117405-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

In this new version we addressed the points rose by LIU Zhiwei in the v7
version. Some patches had to go, additional patches were added:

- patches 1 and 2 from v7: already queued and sent in the last PR.

- patch 6 from v7: moved to patch 1

- patches 2, 3, 4 and 5 (all new): rework how we update tail elements

  Version 7 has a problem with tail elements being updated regardless of
  vstart >= vl because there's no guard for it. To fix that, and be able
  to remove the the vstart >= vl brconds from the translation code (most
  of them - more on that later), we changed vext_set_tail_elems_1s() to
  be a no-op if vstart >= vl. After that we went through all the code
  that was setting tail elems with vext_set_elems_1s() and converted it
  to use vext_set_tail_elems_1s(). We'll not update tail elements if
  vstart >= vl even without a brcond guard in the translation code.

- patch 6 (new): fix scalar move insns. They weren't setting vstart = 0.

- patch 7 (patch 3 from v7): do not remove brconds from scalar move
  insns

  trans_vmv_s_x() and trans_vfmv_s_f() does not have a helper that will
  handle vstart >= vl for them, so they need their brcond. 

- patches 4 and 5 from v7: dropped. We're not removing all brconds, so
  we can't get rid of cpu_vstart and cpu_vl.

Series based on alistair/riscv-to-apply.next. 

Patches missing review: 2, 3, 4, 5, 6.

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
  target/riscv: Clear vstart_qe_zero flag

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 205 ++++++---------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
 target/riscv/translate.c                   |   6 +
 target/riscv/vcrypto_helper.c              |  63 +++----
 target/riscv/vector_helper.c               | 168 ++++++-----------
 target/riscv/vector_internals.c            |  28 +++
 target/riscv/vector_internals.h            |   4 +
 8 files changed, 186 insertions(+), 336 deletions(-)

-- 
2.43.2


