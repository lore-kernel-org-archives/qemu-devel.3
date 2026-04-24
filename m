Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E0FE5202
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDle-0005MS-4R; Fri, 24 Apr 2026 06:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlZ-0005Lm-5U
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlX-0006Om-LB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so48262875ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777026486; x=1777631286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D8FA3Q/H/Wx57j06mptn+XAoLZytcH6CenJXHrZ1k6Q=;
 b=cnHnRhFbPdFVSzANdOiNRijAt5OOnJe/Bpdb6ga6IC/8ivZfci9wCBk9K8birzjJy2
 E77CFevnLuRrJDgSeWUcoL3/wr/y1jDIhu5PLb4N0QtuLlk3CByd71zEOwdugxmxgi0p
 PCVDkMOHLqDLuDw5ny03iNIxLQ0m5+X6wNDjZbB2rWwUI2d/FZtlAfxj8sauIh+IC9ZS
 pkMK9r1ORbr80InLVRE54xiSbKlBYpdoLPwrYZYkylI5Ozt6RMMYShz5Ee+CoX20pxSs
 HSnhauBdGaObkpA8dE4WQdY+EgpO8Uws+Hgg06hJpZ6MUCiBSIpZxu9NUO/6NQEuThkq
 xAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026486; x=1777631286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8FA3Q/H/Wx57j06mptn+XAoLZytcH6CenJXHrZ1k6Q=;
 b=Z+vAOyO7dt3b5u0qTQPiOEqxzMtOYZeaO6m8qub4DdLzV6s/EyhzMfAqtu22PqHyuq
 AVsfSCD5ddoTxrIntwRiHeo6RzYqov5WP1GQw1awwxUQJ6Px091Ox7LCyeYYgFI0T67k
 EQdBENekjNxU7xL1CO+OpP0AEAY+AxkdmyJJr/oFtMOYnEVpQRdh38IZII7pIh6BPvBk
 CpHKP7v8w21R+iHXIq/iq5SAzg16qqOfrqQGBj4ANYSjceGdywz2hZzQMGLP+NKqQV3Q
 +SKV45J0SG891j4slEr1lgBPOjKS4buuR2LzZ0Y74bBRa49HOJ1D733OtGXieQjc+j2a
 TVKg==
X-Gm-Message-State: AOJu0YxuhurAKthQS9S8i1QTYERMGovnMg4UbF13FMuRbdA9Bra8n9f9
 1GAIA1UEY66UDbL4EBxYMBD5jWm0V8j/iZQ95I1SrLkTB/X/IRWRqTot0rw4qQ0JUYTBZj6hk5o
 63es5iYa7KWZNtMMWygxF1ThTzsl0ajx7WuOicJtJAGT7cQmEyZqI7+GkVL6bhstujbvRR3MBgE
 zWTLGb2pAFaRjlVgZRMcWizi6tyt+ktYCB7J2Stm7mkLPzhS0J
X-Gm-Gg: AeBDievvDBYywmW5xdWZO23ZtlslUI/DXECobFNW7I39DNgS/mh2dXLLmayDidAahHv
 a7jagwuNq4fJP54SYw8qDQ/tKMFz8I3Uwj8kzwbEROMqr+M693TrfZU4fbDJnLKswnauqwLVmC5
 iR2o86O0NFWxd2zvNf3cPfcyp4YRYFS4p5m7kyWL6LwpMZPKQoYi2yER5s6oKemOmeGVe9Sh7Vr
 0Y+pfCPi6fvzIZ8jqjw5tztK8DfswC6sfq+TFfLlVRqBmTccpFcqCDOYlu5mMrUkMI7AV83ECdH
 7HjojBeNYLtDQT29/on5xG/8ItUN9LjCvnGYWm1iN0u23VXtwlsAS5U0NFg7TSNX0YJcJZWNuYQ
 CUV+FJw8wp8mNaxPNU5SnzVtZdQsbMGPjeGhZWTP2StBy+QWLeEZ957gNi7b64Kg2E5MLfBWyhE
 TvqtNcNzjSqPG+QjR0p0dvyZ+TAcer3KqZkVysDA1Z5QXHfDfuUd7Lbp3BfbR2eqzGPJmXsNA=
X-Received: by 2002:a17:902:7249:b0:2ae:b9cd:d2ce with SMTP id
 d9443c01a7336-2b5f9f63300mr251253995ad.27.1777026485712; 
 Fri, 24 Apr 2026 03:28:05 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0c17esm218889585ad.41.2026.04.24.03.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:28:05 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 0/4] Support the true Zicclsm extension
Date: Fri, 24 Apr 2026 18:27:56 +0800
Message-ID: <20260424102800.24022-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
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
when the extension is disabled.

Zicclsm is set to true by default to be backwards compatible with the old
RISC-V QEMU design.

To disable Zicclsm, simply set zicclsm=false, e.g.:
  -cpu rv64,zicclsm=false

QEMU will raise a misaligned load/store exception when executing misaligned
load/store instructions.

Frank Chang (4):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Expose Zicclsm extension as a CPU property

 target/riscv/cpu.c                      |  4 +-
 target/riscv/cpu_cfg_fields.h.inc       |  2 +
 target/riscv/insn_trans/trans_rvi.c.inc |  6 ++
 target/riscv/insn_trans/trans_rvv.c.inc |  3 +-
 target/riscv/vector_helper.c            | 82 ++++++++++++++++++++-----
 5 files changed, 80 insertions(+), 17 deletions(-)

--
2.43.0


