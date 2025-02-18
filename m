Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF4C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 02:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkDlK-00048D-VO; Mon, 17 Feb 2025 21:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tkDlD-00045o-Qw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:55:01 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tkDl8-0000Uy-UI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:54:58 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220d28c215eso69925495ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739847292; x=1740452092;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jMUW/GnUYvHdgMBPniAILJ6d8IoxDISMulVgOjY7AJs=;
 b=2cNRhxML4+5/kBihZKinNo2+/u8MRWnltw7H6eQYRX5AiTrTW3nzwCDBJO59FJG5e6
 DI2uO9Q6ohg0aKzwdH8L7H3hnrF23yhkdI0PI0CCwmxvVktt4AjllTSZRhl5QPHw6lZx
 dl5tbqQ//uI86vMBYxMC2Y/4ltAknakioGmQCIt4j2bS/L52VBmVQTqa1ZZNjYIaHFmk
 zDUjsTHo6AOVGyDuedVLif3E0nbIlbWUNR0gxkKMrHIA6P1Y/A5inEZwNQJj10R0Mbcv
 +q9lYFktJ0vY5QbOYWRHF2uiHbatqLG2brjognhg/nCQDnUFSSzr2LdqvG189xO/UznU
 GplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739847292; x=1740452092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMUW/GnUYvHdgMBPniAILJ6d8IoxDISMulVgOjY7AJs=;
 b=dWQd8adv3Xn5o2NISntQPIZNEFeA9iWNkoDiA71M6DJ+tBrqu4Jts65uMsHxSY7+nq
 r8l0yT16iHUhXZZUPPePtXhifyxRlIOneZkXPQSaZN+poTe4ME2FRQS7glLvZnat5dcK
 xmu/7rSyC9zlQm0HzVppLwRrgVLWUAiaKd5vorroeAOiFJwfGqc3k6K46pw81Im9qTbI
 AkWT7snk3G/bpyrlpMVSm5/P+70QDSdvmJsEVqhO7Ek0fDTX0lPv+nifsjqugrjM0L/7
 g/Lvt3AOhrIMOKqVPrU4yxli/yjEpeR7YY976MehvUjJyFtmrggemJlmhdmCDOTr9MqW
 d70w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhERkYfUWUX966wYjMf5OSMR4ApbBotljR90HF7JqAItkaBmjkSB1mFqbFrSfHv+NLIiKIVJA56VPK@nongnu.org
X-Gm-Message-State: AOJu0Ywq1aBccDS/aMaEmXiOzELX2kgJBr7h1tpUzZW4U1TucsZhSuwl
 436/zgsXLtWo81whwauiqZyZXs0GoJ7LKGpHdeWWfB18YBgUzo9FMIzbcBvNbP0=
X-Gm-Gg: ASbGncsGWb2gGtcFYLXk8UVgFoxB4lTwmbFDqOj8udSIOak10tW/0Pj1NKXchUZDdbf
 HcmnRQzC+CioTJvd2j488ZBIP4vssSV87EDKs34kcPRg1vxPtfC5Vx4n6n7iU8bXk2VFM17u3Jf
 Nl0ioJNpxP2OHLLrpVpW16kpsKzDSo/IWGdWDU8jMfxGMvnhBSPW8bb5riWQ/eO1f15crzx5zv5
 54O03x0vGNmszkrj7YF5fDFkfQdF0K1OlYGuUhlwZA2B2AEhEG5goyRmsSvP1MuSn0cm4fMvJtJ
 7aug/T9/rP5q1TL5Ay1+gqykzg==
X-Google-Smtp-Source: AGHT+IHcTqgc4/lvSBqE2D6EQZhGZRrp93z7bvsvT3PjZbtKYZAv/aJrdATgWP36QjF8aIHEJJqcqA==
X-Received: by 2002:a17:902:d58b:b0:216:2426:767f with SMTP id
 d9443c01a7336-221040cec77mr201836485ad.49.1739847292053; 
 Mon, 17 Feb 2025 18:54:52 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d473sm78293595ad.166.2025.02.17.18.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 18:54:51 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Adam Zabrocki <azabrocki@nvidia.com>
Subject: [PATCH 1/2] target/riscv: fix access permission checks for CSR_SSP
Date: Mon, 17 Feb 2025 18:54:45 -0800
Message-Id: <20250218025446.2452254-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit:8205bc1 ("target/riscv: introduce ssp and enabling controls for
zicfiss") introduced CSR_SSP but it mis-interpreted the spec on access
to CSR_SSP in M-mode. Gated to CSR_SSP is not gated via `xSSE`. But
rather rules clearly specified in section "2.2.4. Shadow Stack Pointer"
of `zicfiss` specification. Thanks to Adam Zabrocki for bringing this
to attention.

Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls
for zicfiss"

Reported-by: Adam Zabrocki <azabrocki@nvidia.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f07..75c661d2a1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -191,6 +191,11 @@ static RISCVException cfi_ss(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    /* If ext implemented, M-mode always have access to SSP CSR */
+    if (env->priv == PRV_M) {
+        return RISCV_EXCP_NONE;
+    }
+
     /* if bcfi not active for current env, access to csr is illegal */
     if (!cpu_get_bcfien(env)) {
 #if !defined(CONFIG_USER_ONLY)
-- 
2.34.1


