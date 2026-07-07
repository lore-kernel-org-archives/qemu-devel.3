Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E6C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1pN-0003WG-EK; Tue, 07 Jul 2026 05:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wh1pL-0003Vi-Hf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:10:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wh1pJ-0002F6-W7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:10:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493bab44440so2538355e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783415448; x=1784020248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YgcYbSmE1WSQgn9Ir35dqnNelarFHzO6B8Lh8ECIcEo=;
 b=L+y3veuNPdUaDwpIVfId9x875HiskJGakg5V0zBhd0WnXwiLKbtPQH+ajSkN4q/TsG
 R/tcb2PsfKLx+8gyC6A7SE9Yf1zJH/cazZNCSwDogaOm4bk/Hn5CdNKGLL+aNMxKiILh
 kU8Sl9dTe1sSui0mn8U+Pdv8jTcgoIExMl/zWpB3STUXVxVpiIk0rWWfqr0UF33TwsA2
 +NkIa2atjTST/TimV1pTj/zWugZhf3DzdlX3FXhEna2P3CF40l4zFPKxoC61w/E0sRA0
 lWYJgst+N9cAWgwU+UnpdQ9/ki4H/MWsQIlNhmqh2saxo+tHdW+Mlz3EM62xQ4nDAbo9
 /GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783415448; x=1784020248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgcYbSmE1WSQgn9Ir35dqnNelarFHzO6B8Lh8ECIcEo=;
 b=H4JxMFFCTi/foR+n0IDczZx+VFPc/01Loz0Bh8et7u2TnXKWl8Rfzq7Gmx1eWfOp6d
 +fVkJXjJbO9yiA3KZAbprxP9cTF/OqwOlvUImM6QmD5qTqb2ecX9qwUdKFxkwPRzUJdz
 cWBYp9llf+ImMjTw70ooGzAbNI6XTYbWoZK/zQ/+jOen/LWqechhBGc93zb0aq8BItcm
 gezjy5VQqxbjC7XHR5GLgKXoUJkMnR8wtg13bN3C9VK9xCwDpDug8bNKBx5AD/9ZE8Y+
 AYQafE1aDzYgyb29dJrpdqQOOCr29mBhGRA8KhounWqH7kW7xTa4sK/s2TNz/tBm7jkh
 3S7w==
X-Gm-Message-State: AOJu0YwofoheRHF6HmwYFevjkFlRQsq6usZ/gyvVfNiORL27yl+UopOw
 mohmBViBL5vhyZtZvNT8ArTlZqn/57d+8afXalwGb+8XB+ARyZNV+EyCgb34VGh8CgjpzrN6ueJ
 Hve9gqP3gzc4hP4rajQI7Qof8PTn0wwHgSr6QCpNUg2y0bsTDXGKng+vKB22Er+5YOZAux36rJv
 MwQuUm1bTqCGDOL/3ULfjnv+51PAfnErreCpgZ4xfCXnQLhjqF
X-Gm-Gg: AfdE7clrv5q3MNlo3FYZS3nvnWnKh9tPt1OyQHr1XLqSuSIj6xLZV1/CARcrZgYShmc
 G2kOKC0YUi2zowUZLqPwyduivCBcE0ZgfTHxZ7YpQ7VOHpEMr+E1L0Eby3AlSje1eTo2vR6IuNA
 MInb+aswLXQV4WM2x2VDSfoPDrjvreS+FeFkaHNZ+6SupobgUxSPCmEM3oIcy15Fx38WUSItUNg
 lMzVttvE4ZK/bIr4x09YDBYhVuAQe92XLBM28Vj8Och6dfkkvBPkhF5VFK9JEHYE721Ow5NUY2P
 TmfFniAcudyr7ooyQjnhko5F6RCPKn5yGR/eY8hhGUNnAkLoB+tqMfmU3EyODKSo04TKbkrF4T+
 OCF8fHThOlWBqSp49yaFLrjlbkQsgIgXA4uh3+oOceIP0AiqRvWoIEhV/5hS+UcmMqvQzk0dB/M
 SJ3l8WRPkXG41tqijmlchxAoQUczBuTCPBtzFtdv4=
X-Received: by 2002:a05:600c:8b33:b0:493:b4a3:5ab0 with SMTP id
 5b1f17b1804b1-493e10165b4mr18878825e9.13.1783415447904; 
 Tue, 07 Jul 2026 02:10:47 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f32660sm41004665e9.2.2026.07.07.02.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:10:47 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 0/6] target/riscv: Support the true Zicclsm extension
Date: Tue,  7 Jul 2026 17:10:33 +0800
Message-ID: <20260707091039.2574638-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frank Chang <frank.chang@sifive.com>

Support the true Zicclsm extension so that we can trap misaligned accesses
when Zicclsm is disabled.

To enable/disable Zicclsm, simply set zicclsm=[true|false], e.g.:
  -cpu rv64,zicclsm=[true|false]

QEMU will raise a misaligned load/store exception when executing misaligned
load/store instructions if Zicclsm is disabled.

Changelog:
  v4:
    * Align ROM reset vector data at 8-byte aligned offsets.
  v3:
    * Enable Zicclsm for the compatible CPUs.
    * Rebase to the latest riscv-to-apply.next.
  v2:
    * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
    * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
      vector load/store whole register instructions.

Frank Chang (6):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Enable Zicclsm for the compatible CPUs
  hw/riscv: sifive_u: Align ROM reset vector data
  target/riscv: Update Zicclsm ISA string and expose it as a CPU
    property

 hw/riscv/sifive_u.c                     | 11 +++--
 target/riscv/cpu.c                      |  9 +++-
 target/riscv/cpu_cfg_fields.h.inc       |  2 +
 target/riscv/insn_trans/trans_rvi.c.inc |  6 +++
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
 target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
 6 files changed, 87 insertions(+), 24 deletions(-)

--
2.43.0


