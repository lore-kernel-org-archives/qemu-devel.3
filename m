Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E50C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyL-00055w-SZ; Sun, 26 Jan 2025 02:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyG-00053M-3h
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:16 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyD-0004HT-Nr
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:15 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2b2b6019a74so466806fac.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876132; x=1738480932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf7peyd2COR5J9ebNbp/+78Wow2GJZZgdhDpPr51VFU=;
 b=bWVklSvRA5FnUsWmvosg+ZrbdFIIFmJ+B9Ej59AuyjbgjaUbDCcNBRS8HyNtWHMR/y
 TzMPc8FAJZoMmR/ZFUJOkm8O+vnncB27ZTpiKRtHmN6fHAwLyOVMt25c1ZRNLyjqrUnl
 c8gHOuMXbFonLHqFeuVqLc8dVW3DfgmklwP54VKJiBGxZ/nCQBejlQba+YdR8aMFRL68
 8Q6azmXF/Zkgi9Y6ZxHc/HC9D1N9voLYDr7bW35jHA6xaN+G2ybDW1RjN9kBqyc2FO4t
 +91NjM7wzG65tdM2RMtjSGvlb8q2+M5pm0i4ih00/SvkCJ7+JuOf6SMhQ1wtsgP9UelX
 aXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876132; x=1738480932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uf7peyd2COR5J9ebNbp/+78Wow2GJZZgdhDpPr51VFU=;
 b=uHrj1x5SAxS4fm7LeO09Hioc9RIFjpHz9LN7WI17yZ7T1GHCK9IFmbHKUElbzLWVg0
 8DbBSB06lYbbsbJeBPnXEmKLguht/BFirTc7fUmJpV8X+2dVJNmCMUhSJAYVEVW4rUg1
 DtcvFETxvHe+prJON52ikCSg3TP+QjSuWfkg3iHqSzDsCdN4Hgf5+g4yG95t5ISJ+W6X
 VXTQFWXYtuYgHpRFMwSDGfIZpO81iuyj7HQYA1bhNdD5K10K8CC7R4dVoROWT01U1l6c
 za3RcB80PFlSvGqf+4XbSdWIJ2MvMtT24MEuUAqE647CYMHbFnYtfF7H9IWC6yTj0Mlk
 fZYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiRWR1BCHNGc5BunMSeSciotGzri6IcOLlydZbwyfqWzsZ6aDSiNkOsK+CY5w61WFFZZaiMJizpHgR@nongnu.org
X-Gm-Message-State: AOJu0Yy91ef2kljaFr2DzDxchQboE47HfsVbpbhovPDB42rS9U8eLm+k
 DZ3AHt5zHv5yf0VEwoDRvzduyoQBNyGiI4pVuQtMaIhcDg81FYkQ21YhiFa6vKg=
X-Gm-Gg: ASbGncsKo8aFTeMRPjbG/wOHWclG8TDUAabspp4Hz5gIV2J8spn7fftGjMFVjhDhdeK
 mA3+RfFpn/kx0vFNlQVQ8CyXiMDPTcWom5eIVQCNyvjmPlaBLjvADI07FbhGk5aD8Ud6mv04oas
 2VHLBeurAJVNEclwcZ+VWJyrE/f58WBiOrpj/VYvaSpujegHZT5+G9h+2lVBqKfyncJRd6+HS0H
 P+pfWtD65O3tfYXtYK5ISBaR6YTpL49IlaQgOFoDevyYun/6c7O18rKZfMdlTbSP1J9wQ2lj+PP
 C8KShxs+DFnaT3HaKDhI5G2P4XpOW5Tbn1JB3Pg=
X-Google-Smtp-Source: AGHT+IHz9BQAGsOhwiE5/ojcR1/Velq2Jz6MobNVEDu6abEIjTPxNI2otT2ranyeUJXFo+UoAmN69w==
X-Received: by 2002:a05:6871:d087:b0:29e:787f:b294 with SMTP id
 586e51a60fabf-2b1c0c86c2cmr20391792fac.38.1737876132313; 
 Sat, 25 Jan 2025 23:22:12 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.11
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
Subject: [PATCH 03/12] target/riscv: handle vadd.vx form mask and source
 overlap
Date: Sun, 26 Jan 2025 07:20:47 +0000
Message-Id: <20250126072056.4004912-4-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x30.google.com
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
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index c66cd95bdb..bc2780497e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -382,6 +382,7 @@ static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
 static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 {
     return require_vm(vm, vd) &&
+           require_vm(vm, vs) &&
            require_align(vd, s->lmul) &&
            require_align(vs, s->lmul);
 }
-- 
2.34.1


