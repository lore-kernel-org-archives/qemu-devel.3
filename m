Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E6C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkCm-0003yD-DP; Sun, 27 Sep 2026 04:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCk-0003xG-G7
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:50 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCj-0004fg-1f
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:50 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so774890a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790497548; x=1791102348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pX81RubxJXGeHk2Ek4qy67Lkkg8XYA6a/IolSvKf1EQ=;
 b=dctgNohIOYbdA4nYoPN3yFwxBwERyQIJMGAKHxm8SsiyMrhVjaPTIDiqqpOTqbf2pb
 NLufa9eKDCQGBO79x9XJPjrpLBQK4UUrptn+Bfnk2Ut3Q38KhFjFzDFhekCcUCtOaauX
 k1xzSmxM9gYEyUBnYQnGgn30hRO/G+glt1y675PAX4Lr/bEmuWhW4iuHYvXrqdYHdUzO
 VnItUjoaEQ9h9Fgki+PMP7iCx0g17eWJdy7siWHw8ShygeWEP2y11CnfdqsPYjXHDp4H
 VCU+kGng3YiRnx57eT+Y0/oAALM2GKvH1hr76ztbZ21bubKAkyjwu44XYQOesga0BdYh
 AzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497548; x=1791102348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pX81RubxJXGeHk2Ek4qy67Lkkg8XYA6a/IolSvKf1EQ=;
 b=c77pZNcEHsY2Tw/QsFTLqioayyQitWA7nRr7pjsr+kxO6VcsFTIKjBQHj4LnOsArSD
 sefpS4nfdiiZoNqrgn58vdDi2xEMk5FwQQfGuMga5FcykEathyRnEX2BMGpHs6FKk3CE
 X82yb1uaxmt28MOLh1so8ySJStKUK3+BzrEYkyTLRagtCohvXu26UK8q448QIpPJuyUk
 4x5P2v62mpU1Tk/iW1VDCPXd6LBAwUyUWNP1pTMtGYChOBouEJ0U4JSLt+4aRjXDVIC7
 waW6V+PSch6j5RJH+GAmEKhMB9bUnDIFw4C+iR2Aq+wVlnA6MnoOuLRpuMK74iI9ZXRU
 bKPQ==
X-Gm-Message-State: AFq9FYK/4tSC2W8AmxaZdK/5bakyHlpmqJGGRn96+TUyDfMDbAKVfN8Q
 gKgkJ0aFxvhD0b/EJe6DSo965cYo8avFkNJhSz20pFe1e5Nfbf7WYa1QQIMeNudP7dxlyqwwF4h
 v0b73CUKQjhFMmyrl9FRvxYl5nsaZROtOMaywcoLBiVObXLb0uAgKtceIj9hf9Y/4RDCOdnuoXB
 wWJxbPzCOWm346zqfO2borFSRFi6Q3l7xWfp6/aZevjQ==
X-Gm-Gg: AYBFou0WLAbs5MZSRKqQ40yIlRHvrZKp5ntzzhlaaDc822/gzkrRTvZiDDHChEovNyw
 we+vNkxljBrO/Hl5i38IP8nMVIAsT6/ZUZyHE8eQaZF4f6Au4M3EqdiknBeIaSQ7O6iRfZrWA5T
 yiCgRGLBRgnt2hzkCfrMJQYhA/7kc23N3KN4pp+gmYikuO1vw/DGPgPo1OfCf3bbgpLm8vHjqU0
 Uxi1oVG1v7z3B6VYB3m6OiQqmLGEI4inl0i+P9Djy/2YCZpRtOh3n0VgBgeSmGg5pI85sUYn6on
 rb9c45890FFbEGQB8QBBL/S44/FOvYF3l5w4OP/vFRU7Ru1MtMQ70faT6v0EghTJgpb3bUtY6W7
 Psrq8XzK+LChvwslPIQXtn0nbhcb7n34eGyCaXvv8O7LUkBFYxTI19dUW0j3Y14m/p4tLXSwHxL
 FMb+fO6hTRoschQdpjbAf51N4fCg8+29xg0XZ6Aw8nwt5NErGX5BulZIalDceU45MeBVeaL8g9p
 0rEehyfPFpWMk/kNBVVP6sh36GH9O5uqOgq8p/R6Y2Cx7Tjjx6U61wefyhmogkR+6gu0N4gWg==
X-Received: by 2002:a17:90b:2748:b0:3a0:7dea:6dd4 with SMTP id
 98e67ed59e1d1-3a098570051mr8166539a91.7.1790497547621; 
 Sun, 27 Sep 2026 01:25:47 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9357f64sm14498871a91.3.2026.09.27.01.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:25:47 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Date: Sun, 27 Sep 2026 16:25:31 +0800
Message-ID: <20260927082534.3228237-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927082534.3228237-1-max.chou@sifive.com>
References: <20260927082534.3228237-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 90fa1d714c7..714697c66cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2906,6 +2906,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
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
@@ -2957,6 +2975,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &SMCTR_IMPLIED,
     &SSCTR_IMPLIED,
     &SSSTATEEN_IMPLIED,
+    &XSFVQMACCDOD_IMPLIED,
+    &XSFVQMACCQOQ_IMPLIED,
     NULL
 };
 
-- 
2.43.0


