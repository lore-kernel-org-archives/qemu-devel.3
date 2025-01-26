Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E75C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyI-00053S-Fr; Sun, 26 Jan 2025 02:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyE-00052e-Tr
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:14 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyC-0004HH-Rc
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:14 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f2d7868ef0so769038eaf.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876131; x=1738480931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyip6VT/5yDNDFiXFMYcFQVmq0xmW59Cv/92qKvtykg=;
 b=F63TYtGo0P0KQc9sJ9gequ2vCTx+4MJtm1nI9jbfofkJ+RGvjedTnrGm4ExWRL69k2
 8gO7JvyRE6BMMf6Z3QnQuPsHjshD8LaS/VqxP2kdvF5JAQBtqW9ptRliuP3BuFFsxcoj
 PIiMycxmpTUDfdluVqu6AJdxRjXZ4nvlq8d7QgjziAbIwJm9Bqo9iE6y/9M8QnmC/vOr
 XZ4VSkI9jHvOXXsyzMNnO0Xtgvj9dET1uCZi28s1RBLQMun20kMDYtSRooRvuaijcVCc
 tvTaiwwlORLROucwS1pRZqS1ZzoC0jAcFuPGSxzE2+O7lX3gyC17adIMU5pciQBbob/Y
 DCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876131; x=1738480931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyip6VT/5yDNDFiXFMYcFQVmq0xmW59Cv/92qKvtykg=;
 b=ZsLFjTb827epHSx1iTDOB2PxHqZF9LYNaIm6xzdHe3i/v4guMujRvYaok4lA5BnuCY
 kdcf4T1zoSun45lxAZxE856ogePC1wSejSuhODrXQVuLDorlju5bOIMIg3PfmAjkGaoM
 Ys25wMHa97oY1yJgucjyh2Xb0hJr2CjQ81LdYLJ2xAJopuNe4ijkGRUQrnW7uqZ++LW5
 +1ofF8QYYUxzkbIMKmNDQScoxH39HTkw2DlsxIt90gwJyRY3JrSQWWKLdqaMvTJiCvNT
 u8XyIbOdwE/v5AgCkC4FcBkziiNGsT9U9h6nDeAsrE1VqEbPJJvbKwxnFThb+WpquEIH
 RTWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgB4HYY3wveYcgGRNvIJKnNocSFfXgn4IbyBQGVKX85pB5d2mEBzVIbcJqmIsU97frf70lr9alPIzC@nongnu.org
X-Gm-Message-State: AOJu0YxUjKplADIv0C5NaTtufoHLybyJBJWI8qQ0fQZhEhVVjx92enSf
 VGqwSluN23tbnjhgor+pZCoqNtXZ6hMYZ+WulILf4a0CsT/POl+GF5bKxuLN1u4=
X-Gm-Gg: ASbGncvWMnMPmhXt81m0srZ+tCNC5WauXPQ1DPeYObpEu7FPuF0+rslZtIatEqD8AMn
 q2sJTmQAjkMvnOSqskRDDn6D0EmzO/q96xUMutEGyh3pT+sXawH5Lio32VzNWpjHqsmInnrL6BV
 Pt0P+zr1WbYsMS4WEZwUF65oyJ/xKB9uz91iCSFD7DxeH46Zb104cMsEZuh5VveZ4OYtVVZsiwS
 3LbunKMgCilWAtfR+PSTfbsPDMCt+VvUoeMDzDXAMBnPtZeZ4m/CU0iJVFVRGHeyDsLDk8AhRHe
 Nq2v/sbtAGYg9Qo4sQ1moc+N7ZPbkW/SXyoLFEk=
X-Google-Smtp-Source: AGHT+IEIn9dU+TAcctC/re24Wl5VO747uEs5QGj7Pl5CBn4eHmWHjoJeL+FOfLMn+Iovi06xP9Fk/Q==
X-Received: by 2002:a05:6870:af46:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-2b1c09125b9mr20339679fac.7.1737876131397; 
 Sat, 25 Jan 2025 23:22:11 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:11 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 02/12] target/riscv: handle vrgather mask and source overlap
Date: Sun, 26 Jan 2025 07:20:46 +0000
Message-Id: <20250126072056.4004912-3-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=antonb@tenstorrent.com; helo=mail-oo1-xc35.google.com
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 20b1cb127b..c66cd95bdb 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3453,7 +3453,9 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
            require_align(a->rs1, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
            (a->rd != a->rs2 && a->rd != a->rs1) &&
-           require_vm(a->vm, a->rd);
+           require_vm(a->vm, a->rd) &&
+           require_vm(a->vm, a->rs1) &&
+           require_vm(a->vm, a->rs2);
 }
 
 static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
@@ -3470,7 +3472,9 @@ static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
                           a->rs1, 1 << MAX(emul, 0)) &&
            !is_overlapped(a->rd, 1 << MAX(s->lmul, 0),
                           a->rs2, 1 << MAX(s->lmul, 0)) &&
-           require_vm(a->vm, a->rd);
+           require_vm(a->vm, a->rd) &&
+           require_vm(a->vm, a->rs1) &&
+           require_vm(a->vm, a->rs2);
 }
 
 GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
@@ -3483,7 +3487,8 @@ static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
            require_align(a->rd, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
            (a->rd != a->rs2) &&
-           require_vm(a->vm, a->rd);
+           require_vm(a->vm, a->rd) &&
+           require_vm(a->vm, a->rs2);
 }
 
 /* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
-- 
2.34.1


