Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE5C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyT-0005C2-RR; Sun, 26 Jan 2025 02:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyL-000566-UW
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:21 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyK-0004LJ-0C
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:21 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb7ca55c3bso2099106b6e.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876138; x=1738480938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5j+CC1ttOcPU9/MzZw7a97b5WwSaQqX+GDCoxcWiCQA=;
 b=fWFO7uFRF1sI1W+YZl7uGTek5PzGKOd0ZGeAmFUpmjznPZeXRra725Kg6N+QiL6Lm/
 NPLBCdYqq0WkgQ4Rzat2Q035Y277elp5OTz6fijiI/I+GJs6NKu0ZJYVvY3qzV90fMBr
 34+4hTYMgFNQHdA5Kxudfqi9a26N7Ep26gKMMRg35MXebm5tQo5IlKd27tUe9/q9XFY0
 Cg4UzxxNoG63paTS50MINS5kXHdeCYYduaPrfA4YehCmiYR2aiNv8xJSFKkVTcbDwdQV
 8vBcrSOX7utImxHbt8MTmlXhsWKCZ6qzLeilMDAmtQ4fr7/YnyJXxEA3nbzRPwZrPT/3
 tx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876138; x=1738480938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5j+CC1ttOcPU9/MzZw7a97b5WwSaQqX+GDCoxcWiCQA=;
 b=J1ItuxBN7GdzmpWASc+SbEXjNcuTSNDFQ11nDdfGbzLQCeo+F62pV2J///Dfyew6JV
 l2BKjlNf6LL1xjJhX037L3fOiM0AME0iC1p3QhP3kwsqsI4uiyhaFc3vr0Ad9Vt6jjaj
 GUF2UpklzHZP5YbEOFrvllO16lZUYos3GskVVBsnEb26fqOPApXqN2sEIXS6uf/D0jdV
 0I/cE/C+29OGcClLRAZ/mEt0Oy4yH8iyMieBcu7VrTjaf0jZx8LmQJl+RirCP0aGXrT6
 Rfuu7lmEdgIB3SY4uZkvU6wzlGQu0Yi++ORT0/ZBTDU4YitCn5Xjy/58AZ1dxBV7f1a4
 yzGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUiyGkgExYYszxgC43oSv+rWxv0befdPJNlVmnDo/3FiVVFkneJN0MbEHX09Tfw8amGBw8n4O7YU8q@nongnu.org
X-Gm-Message-State: AOJu0YwccufhTWEtAeJ+1bY/SHFoUuhVOTJVVN+dRYoAhjNQBJLgJw11
 ciIBu24FabLpoaQ7GPztxAaMdjiHUIoCbzu1K4/0pVf48uZFtqCRJs/NeDBNtL0=
X-Gm-Gg: ASbGncvwd89QvWXuTS6p64PAjw79jitGHjVR4GKfo7P6dM7g0UcGDeb2Xhlanl6pcwQ
 2HuvesJmAuA2qu9fAtYWetiRXDrcjiekfESW4OFPj6seJcLM5KcnoS071rJ22glKYZAAqu5/A3Y
 AvZeOGmqFyEArpQeCnyrykpUIXD9RcAjkC1XjPs42UU79+aBuoBIBR0xZSG+40hiTxt/gGWtlL9
 Wr4jfoYCXSyUA0aNMsMskiL2rMz6wzaKBuAGyMAJ3chRpr3ajO1dLmNsMGnM8byk1LqMt9Ir09g
 JaaCBw5c++xOAPdIeUIWkUWq2jikiE/NQ90OiU8RlvFGZCqCGw==
X-Google-Smtp-Source: AGHT+IGsl2uYaAhbvUL2RhNcfmTrrocQbDZzF/NO/AEBWo04ilyBMYUqQlX9hsEJ4vIz/k7Oip5tpw==
X-Received: by 2002:a05:6870:e2d0:b0:29e:3eff:dea with SMTP id
 586e51a60fabf-2b1c084f0bfmr21003237fac.8.1737876138641; 
 Sat, 25 Jan 2025 23:22:18 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:18 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 10/12] target/riscv: handle vwadd.wv form vs1 and vs2 overlap
Date: Sun, 26 Jan 2025 07:20:54 +0000
Message-Id: <20250126072056.4004912-11-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=antonb@tenstorrent.com; helo=mail-oi1-x234.google.com
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

for 2*SEW = 2*SEW op SEW instructions vs2 and vs1 cannot overlap
because it would mean a register is read with two different SEW
settings.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2309d9abd0..312d8b1b81 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -549,7 +549,8 @@ static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs1, vm) &&
            require_vm(vm, vs2) &&
-           require_align(vs2, s->lmul + 1);
+           require_align(vs2, s->lmul + 1) &&
+           !is_overlapped(vs2, 1 << MAX(s->lmul+1, 0), vs1, 1 << MAX(s->lmul, 0));
 }
 
 static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
-- 
2.34.1


