Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741F2C2A062
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 23:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcXhU-0001Ow-N8; Sun, 04 Jan 2026 18:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcXhT-0001M3-56
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 18:39:55 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcXhR-0002pg-NS
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 18:39:54 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3ec41466a30so1137724fac.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1767569991; x=1768174791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7i2m5T+6xuXP7Qyit+n3WnMwzj7d22AwYMaI9ka+vnc=;
 b=A72EbgFbfnVYoIbXdsM74/X8O0z/Rd1XljKLzF/UR/g1dC6bFgM4aQaYNJ6WRLBjl8
 vKvEmHpfitfloPDNxZ0G9j2Fe8tZ+lsndBwHz+BTALOGF8T8fVLz4RKFJJhgOY/7d89H
 b2EkVqK982RgyEKEsSKuz2dYAAJ83Q/qvs6WJeFnNATYUbm+imC4aXHkK4JX1iTtWFvs
 jW5jw4tG46Kpihf8V8ZMdPtJ79xgfj4IKJNoqowVBMfgs0XOd6vGyRqdgnVbWsJZAYGd
 A+1jXd94h9HV+r14ssT1j28BPhdEGrJlOjz4ytteOeVb/6dY/hbGgX6DFWRRfcnfS/pW
 EJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767569991; x=1768174791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i2m5T+6xuXP7Qyit+n3WnMwzj7d22AwYMaI9ka+vnc=;
 b=AMLFW/EUm/xe5m8eJdhFIYFMW+JFdJEmxzB9eaPYCY/KjPwRGbX4jiVPTK2xYv4ms2
 MYcX/0W+7JyfQg9801hTylspZOC0gXFWCcn8LGrbLz/rWZHOcKm7l0z7cxnZgRg/ocun
 FplC+hGjeYvqJhShue48L/gu3l6MQ+jWXQh73pWQTm39Br4nnjTk+5r/bnos+IArNBGc
 p9lh3Kmn+tOL6kwWnc+AoWeIj/5TwYZ0VrevrfCpVmt0UOfvouatrAeCCTlprEKh/T3p
 rbryevxVp4kAVhzGS3/cTxmpS1ds3f7wqOZV2S3oSKX8Z/+GfPTzRCGZbE816f/Xt1DJ
 cJ9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKZFVJa5l+rsFqo+JPPU63cxpfXC2Kl0z3ayErJvGx7EIvq/a5Mjc0k5hLirGnevK2XBkYhVyox6lB@nongnu.org
X-Gm-Message-State: AOJu0YyGTHwN++LINc/+2Bi7TlLeSdKOj8OMsZT9Dp0/KNriG53YzQH5
 eIpTPAm99RwTiUepxja9Gc+lcdwi939dntWivZ+IJnmt2fv7b0T1eVDy1vbZ4Yabzzw=
X-Gm-Gg: AY/fxX6swBIZ6cfyNhQcJaAEL0aC+MQf7V5Lc4taLmf10Xb8gImfDDbhDPYr1MswCSk
 viUlbYC1AVDHkvOsG1EW3ch2xCFZPbDegLeNen4l1YhEUeYawq4vMrdfhfSgKU+dBxzzkgfnrM7
 W0glLmm4zhUNMXK0MDh3IEXCMBPG4ulqPh6q13Q9bIqMt4RKtHTrfgMhIq9mnHJLUc0lRWDTr2S
 hTZr9+4DMC4Vtctv2xsffNbs5FpxWd9vMhTJ5/YyPDUG3jThAGbWPTQXuMp+NA03iBQht97InDv
 J2+Z5FQpsmbO3to7fTH5m5Jy34o1oIwJ99UH1YFDkfCWioDk8tXX5kBvpgukSU6LcyhDjIl8BWq
 lOi0fys2Hwa31gBwwgcxGpeRFCraaBtTa0TZFZq735PO3HM+NXAu5VC0hiN3OPJcwUuuUG8WQZU
 xRtJWCLumKBcrfLI8vYXVk7ZyIQMOa6rFNy0dEH/eED1fM
X-Google-Smtp-Source: AGHT+IFcnzRDo45M6CiAWEeMWeaZPvT9RsGm/R7wELBOtb31Mj11BYsD5tpzv0I2QvJn8wZTsI2RkQ==
X-Received: by 2002:a05:6870:b3d3:b0:3f6:1e6:d0dc with SMTP id
 586e51a60fabf-3ff49c61ed8mr3450218fac.16.1767569991481; 
 Sun, 04 Jan 2026 15:39:51 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaabbf2c4sm29602676fac.19.2026.01.04.15.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 15:39:49 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: rvv: Allow fractional LMUL on vector SHA
 instructions
Date: Sun,  4 Jan 2026 23:37:24 +0000
Message-Id: <20260104233724.192886-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x33.google.com
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

Vector SHA instructions incorrectly raise an illegal instruction exception
when LMUL < 1. The ISA only states that LMUL*VLEN >= EGW:

  For element-group instructions, LMUL*VLEN must always be at least as
  large as EGW, otherwise an illegal-instruction exception is raised, even
  if vl=0.

There is already a check for this:

  MAXSZ(s) >= egw_bytes

so just remove the check for a fractional LMUL.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvvk.c.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 27bf3f0b68..32255d3aa0 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -426,8 +426,7 @@ static bool vsha_check(DisasContext *s, arg_rmrr *a)
            vsha_check_sew(s) &&
            MAXSZ(s) >= egw_bytes &&
            !is_overlapped(a->rd, mult, a->rs1, mult) &&
-           !is_overlapped(a->rd, mult, a->rs2, mult) &&
-           s->lmul >= 0;
+           !is_overlapped(a->rd, mult, a->rs2, mult);
 }
 
 GEN_VV_UNMASKED_TRANS(vsha2ms_vv, vsha_check, ZVKNH_EGS)
-- 
2.34.1


