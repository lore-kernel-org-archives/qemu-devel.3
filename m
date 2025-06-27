Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF47C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV90s-0003Ed-Fe; Fri, 27 Jun 2025 09:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV90W-00033Y-Dn
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:20:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV90U-0003MT-9y
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:20:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2088498b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751030440; x=1751635240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HGmWSO3+djq6ALIkR5O7IVHUJC5hIN3/GWTRKD/WcM=;
 b=hMzyIMmUB74icEA8V72B4NdCfdFbEEVC1ympZvGQfXn5e6JfcrUKxBlG1Z1Q7aAqOh
 JKmz8lF7IfJapVZ12xHiyAQ+r5/Fitk7EPXONlgZYAW/LU6CzauaRalW3Q7gpzqYO3rZ
 5AVK+Hs6WyDeoAHkxA0IjOSy/xmS38BBPd3KyK+seQ1T/er2D3Ne0EzfbveMI+pBcCdE
 NCmQeV0iy2o1s/gcwDxmVG0eKGYF0iZTyImr+1hWvVJzy+8MRS/qSCQw+ecIF9WDOWmJ
 3/7tuRgeStp8UWsknKwdZvlvvO/SlQGaqjY9OojDbYI9MW6Jgw5wF6Ald33WVJjkgRkz
 dHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751030440; x=1751635240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HGmWSO3+djq6ALIkR5O7IVHUJC5hIN3/GWTRKD/WcM=;
 b=wonEXYJYn9AinwAEarHHklets1Q7RsOkJSeVrFChN9utIFHshFMMVAzaYu9m3JGcHA
 bN1ae4MDAvyJZAADqBzLEM9zoclRXJem28GwuKDlBJkZ8QFRt1i8KszPDdXJ1iRnSKAC
 Td8Q6BoDILjpOmpD0T6VGHnVkBmI4u2zmu2rhNZHOLxuKzZm8iaYbmpcDJbz6crl4QZ7
 m0ZJ4RNl4MdExG3s4anfwoodBecYzobJ9q1oW0bR2NwdZcZVrsFS18QvtwRcGpEvFpiR
 H9Cccrx5EytSxjXfaYDDXyLAXKczmInguDcBcTB1c7HyX9boM5sMGe1Z0ovpsn9mL+Pz
 6Dow==
X-Gm-Message-State: AOJu0YwxARFv8ptwx4N3VY4Cri/iUh11yjbS2KruDl+u4wzFo3PyYEvT
 iYQu8yx+zKMkfQ6T6owQ2yDq4FShpG9nLvUrQwNxN8h/Ejlf270gj5zg/SAQReRuz3PaeGlOE4H
 6txahYMdBDyeFUlcgXUWCxCv7emIOrAljX+4tCSxsGmsHS2T82BtApT6b7v08MMP4WG1eupGdrg
 waiUHnQQ3BgYezKY3vBnsX6WCEKUWrdExKQiPo/V3uYw==
X-Gm-Gg: ASbGncs0v/dWkMUfYaPMra1sxDpYTH/BtkpYgTTfQGWLkxHP0ytciwJtKeZI7DQwydM
 Jq/V5rjrkmDMrDonOjf0YwfnZB1pas/XBlplPA8D2wm6K+16npUsSvYdUsw+dp4909OgWvAAnTu
 PG/fCTl/M6kDuVdcDgnxjGv+eJg2znMMnyrkBdKHqMNz+C5DfezPPaMgxxsuPGZAPrzdEWmXj+f
 DKXCAjpS3sB4ZU91itzaOXV5pHyGmDuFLQFHRrzSSmnf0Mknnw0iRV9hy5G/YGFk7WU97E8ay6d
 jrUC8+l+L4TK5VGwQelGw8AAnqlSyBn0lGunS2BPMpku+fxn9rNCZgaLRLHo55kGOK4sucJkqPM
 Igzqb5v1U6cUcGqWotA3T3/vCWgJtZeE=
X-Google-Smtp-Source: AGHT+IFgAIMomK1cdNjvexq56+cSfCwtvfo40mVFXSpruVP2F5tnQu5VXJOg3WC7uis2tvlTtN1/Qw==
X-Received: by 2002:a05:6a00:1992:b0:748:fb2c:6b95 with SMTP id
 d2e1a72fcca58-74af6f2e8c1mr4607892b3a.18.1751030439947; 
 Fri, 27 Jun 2025 06:20:39 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5573e71sm2393162b3a.98.2025.06.27.06.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:20:39 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 2/3] target/riscv: rvv: Apply vext_check_input_eew to
 vector reduction instructions
Date: Fri, 27 Jun 2025 21:20:21 +0800
Message-ID: <20250627132022.439315-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627132022.439315-1-max.chou@sifive.com>
References: <20250627132022.439315-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Anton Blanchard <antonb@tenstorrent.com>

Handle the overlap of source registers with different EEWs.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index ec34d0d8c47..ac6f1d04c6d 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3293,6 +3293,7 @@ static bool reduction_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
            vext_check_reduction(s, a->rs2);
 }
 
@@ -3309,7 +3310,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_check(s, a) && (s->sew < MO_64) &&
-           ((s->sew + 1) <= (s->cfg_ptr->elen >> 4));
+           ((s->sew + 1) <= (s->cfg_ptr->elen >> 4)) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew + 1, a->vm);
 }
 
 GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
-- 
2.43.0


