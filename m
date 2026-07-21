Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3900BC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9T2-00021z-37; Tue, 21 Jul 2026 08:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wm9Sr-0001yl-UC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:49 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wm9Sq-0003nM-1D
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so3820926a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784636446; x=1785241246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDmKj9ojGbNAJQJDYvvRAPXarsrqhccfsavTta3uxqc=;
 b=FaYKmApYnYkN8Nh1n0DLfH8nOhjzZ08nZ5BXkJPcrHAlkcASnRZsDMRNt6uJKSwTKN
 xGLwQgXippZmblfQ2ib0fY2BtWexOq7jY611CCrN5yIMInVItj17BaZwly5N8DlG1Xss
 OklioTc8psiMJJCRD0p/LIW72hX7wC5YwtAmRy+z5rK5jTTWZKR1cDGJW/u8KiEr/3fk
 Zb2PgmG5ED+qwHiy25fxXHMqET111pWca7HZ/MnKqMJb53/GLD3Cj5xjmrZAmquYrj+c
 qtQrW3rlWH65BftAkXKX11Ff0I64XY+GG6Z6cC00YfDBJnwPBqCGsTnEdqTEoGb5OkOQ
 xlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636446; x=1785241246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDmKj9ojGbNAJQJDYvvRAPXarsrqhccfsavTta3uxqc=;
 b=QsoRotNonexJtZMCP5oSBPkfa7J6ChuW5yqalibMt/fc2HAikJGf115be13fgO+m9p
 x90QNYjCT7FiBv86HCLQqTxI0q6X+rI2FlCdxEFtTeupz7BzvW7j1RJJYa9xOYN/IOoR
 4B8SJXtaHwYS9EvQIqh1N7QeBh1X9wnsSPYGh/cNvedvId8G/uw2Yujvyu7QG06McEmu
 PHrvCUkxjxE/6ENuJQAa/05l9QXfWkEUN7qNBXv5YOOgUrEJO7QX/grPVUx43YtX4fXJ
 k/FSZ9IRM57TlV8Ro9ALd34OUTU7mtiqFv/koGUpD0cckpv3iS7tT1nkcXMpM9PTLHt9
 zLJg==
X-Gm-Message-State: AOJu0YyHxczTsrBaGbFKCCxP/paKVqr7TJ3YlHAQT1oS3zk7lAxlNPhC
 yXoJAhk86OZw5lMTx8hWGsKRnsyXIb8JT0X8W2/fL8t8dSTPviQE8T/EEI2n2JwMKvBXjC6QtRp
 nLPDPLFq6RksnJ0WRmInFS9pwQKRFxVlZFyJ1Fubfhsjd1L4L/KeWo6zGAEE3IVNmGQWsgPJSbj
 ey8r22WZfvVeHEeLoKe8GsySlwDUbcrnLGMl5CuR8=
X-Gm-Gg: AfdE7cnC65N2V5T065GELEX9wDyOGSAyL8KxrpjQVIC4/YI+OI6hrJJjLOzCZ81m7YB
 nmg5jO4oF5H1l39FRjYP/JEqnx37nz9E1BJvcjjwhvYc8iJfPJEsfX1lHS8Z1+pBh5qP7skW04y
 BZxBf1E7TbxpZRJfbEWPb6vmo9S4TQ8TjY/cU6w70S4Z1WiRz12VWpWOcMsYyBfqXRG3jhxCzHN
 kXTYLD+QwSwr4cXTov+qLuYm4GZn/qjhnPXKorzYq4p6BnPt1JICLBV3pPZYnJLdxhDJ5rkiq9P
 tqBjsytHiJiYD2PQ9Z6EBszxsaryx0bqtJgFrdVhrEtZHezXDXsJQIMSMSKLLw0vrAP8EdmCVWp
 rIPr0qFYX8NkWX0kxmBSFikISPfgaCKS5jrMf9waJEZ7Nj09nTROsCvHmRQzmkXGsYiMoRCWZG3
 YmNXD5OX/cjNeiI9kUpBLEx+lfHX+9wYO5JvxrjD6quCC16mbVlk0oAs4Wl2QaWogrMvauVdlqd
 fSCOGjkL2rSGbZa
X-Received: by 2002:a05:6a21:1519:b0:3c3:a168:edc3 with SMTP id
 adf61e73a8af0-3c3ad9717dfmr17121896637.38.1784636446435; 
 Tue, 21 Jul 2026 05:20:46 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb517aad95dsm5904568a12.7.2026.07.21.05.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:20:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/5] target/riscv: Add SiFive custom int8 matmul extension
 implied rules
Date: Tue, 21 Jul 2026 20:20:30 +0800
Message-ID: <20260721122034.1567146-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721122034.1567146-1-max.chou@sifive.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52d.google.com
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

Add SiFive custom int8 matmul extension implied rules to enable the
implied extensions of SiFive custom int8 matmul extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e643d7c7af..70baa054f9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2811,6 +2811,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
@@ -2832,6 +2850,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
     &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
     &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
+    &XSFVQMACCDOD_IMPLIED, &XSFVQMACCQOQ_IMPLIED,
     NULL
 };
 
-- 
2.55.0


