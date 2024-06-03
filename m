Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B84C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hD-0004px-TV; Mon, 03 Jun 2024 07:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5h7-0004YH-H5
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gz-0006Fk-8x
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f62217f806so35449695ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413452; x=1718018252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPVDknq2+BTuhMMVK1D5LD3yvwRgzrMP0W6CSFXWWAk=;
 b=WqXr1P0zfAmXf/LlZhR8LhtpJHsLpj53jf8hdgdeC2JMlWlcchUgJ29xRDa75piqkN
 /tCFn+QaffL5Dln+ar5zXBei2tFFFCnxQ9d3sNi1U6ZAY6T41NNicscjY3n/XAS96iGZ
 qOmTd7Lqi5RYrJQFTsH6d1ed3xLchmuzBIkle5HmSYXOOUknPy8H2LyP2A4sMCfH1gcd
 60JdOxrydJz5MLr+56j1Ae+1R6fdexkykPN4owIv68wHpfO+TbkvPegHYfn3tCG75elm
 8sejGFyoyqVjETSeiA8LYHBGZPXQXDKH1CWE40SC5XhHUOS/yXoeNByIAeBgLLk8GVPs
 klmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413452; x=1718018252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPVDknq2+BTuhMMVK1D5LD3yvwRgzrMP0W6CSFXWWAk=;
 b=Tu/f4CHp/XcVvWrtqwz6pe8q2qyVGKcnz4foebpk3hlXzmSr8KVJGscGg6BXRTsHeb
 5h0Xa8PpY66fltPtsNTji6AkmBTnL8gt6U2hMtx3ORtO1QlC3c4tswiekMAHpgdWRegq
 dI2sSI2dDMVGhpq1o9iwMsgVaEuoqP39HYunwp2YyqXVB6cJAr5weVyBNlgyLCRrcWJt
 p2+T1XG9o/8mMOrUcp32fsXjd3uPCHK1gmFYG5MRYWoAPvPr3zLC8Lf2useexAOyVQ0L
 jKGRPXjQc3s697EEJsW9vY6705ihHi5sFg524KuJR8fM3n2XwrZmxcPzCgq0Br5kXT0S
 khiQ==
X-Gm-Message-State: AOJu0YzLhBXUqpNTJgN2PHOM2NVOHMQ3hK7iKuSXIFQSqMrQeMoR6B07
 GEAwlnbskPxD/oQC8DmJVpSjxHzAZF8XwbD2TLyD8opQ5tkmOiy6umBN9A==
X-Google-Smtp-Source: AGHT+IEDZ/jq8I4QpITLMalpleF8gtBHxBeTLH8NVRIKf9KkSDavmPhbot2Eh3/NLRUL6Mfxz2O1IQ==
X-Received: by 2002:a17:902:e5cb:b0:1f6:6cd5:d003 with SMTP id
 d9443c01a7336-1f66cd5d823mr48930605ad.37.1717413451700; 
 Mon, 03 Jun 2024 04:17:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 12/27] target/riscv: Relax vector register check in RISCV
 gdbstub
Date: Mon,  3 Jun 2024 21:16:28 +1000
Message-ID: <20240603111643.258712-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jason Chien <jason.chien@sifive.com>

In current implementation, the gdbstub allows reading vector registers
only if V extension is supported. However, all vector extensions and
vector crypto extensions have the vector registers and they all depend
on Zve32x. The gdbstub should check for Zve32x instead.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20240328022343.6871-4-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index be7a02cd90..d0cc5762c2 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -338,7 +338,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  gdb_find_static_feature("riscv-32bit-fpu.xml"),
                                  0);
     }
-    if (env->misa_ext & RVV) {
+    if (cpu->cfg.ext_zve32x) {
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
                                  riscv_gdb_set_vector,
                                  ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
-- 
2.45.1


