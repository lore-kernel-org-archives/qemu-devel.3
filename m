Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E702FE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJA7p-0006ZY-PD; Thu, 05 Dec 2024 06:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJA7o-0006ZB-3q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:34:28 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJA7m-0001TA-J2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:34:27 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so680716f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733398465; x=1734003265;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FnTMiXuPkhQQ6QNckrBef68BYhMTfBUPg6gnsrR5Ck=;
 b=L2HFl6PwGZmo91SCH+RHMVYMJL6F17EX+q+VBpxKXmXyweZSt3IEx9NrPcJwYAKEDN
 JK6REujFqKmEHLcqmoPBk1m0pIApfQmsNR/uOwhUvA+zagAilHWZa+PCmw43VHRF7cMf
 v8lhZ0dBbuGUurcALb17x3LZw9Q1I0R0UmVRTKVFPx0JapevfCP1NMqPH4DkQetSmSW/
 aLiT5CW7FMMu8SMbAdmWTkWiLgka1Gtfo8syD8ADWze8SbXy/kfPWtBEiQ98iw+4SZwJ
 wc0797bbG7fDXK4G6h7Anp/S5uPmfpAnGF7w7+mWXNejgL/WhOLzIco7GBRKiT8Wbs6i
 +okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733398465; x=1734003265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FnTMiXuPkhQQ6QNckrBef68BYhMTfBUPg6gnsrR5Ck=;
 b=oSXthDnXAjxpdmaPKkZ5GoWFIMjAT3GivW+gi7d4rwXOiir+n9jYPd+HF/49XMMBPK
 G7VDVzMfan4YN3YL4sSTJvQtBqH8hIeF5GgdwgO2FwWxtshaNfKRmpEozkgPxxRuO99E
 hRFd7GnGPuWgqDSJmaMSOP8LLPQx5CE533xHM/cQKQZCKEhUuRPpYHVgWx5dxCow1wi6
 h5N0SaX9QNmJfWti4Z85tyZBH9FtJnQ5glMJK5IkKPDTEdPdS/Hrxyb+wO9WgivZL76o
 0ZEisGqU/sBNK4gyoRmGizB3L7j6fFCd+E2OGs6/C1ZJCFNlsoTO/+WsB18EuqfmYtAU
 CkCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWssN99d6aNIlmrfmbD+u/7Tczi810QCcaaUZDH46I9OEWowV0WFPcGh3e7/J+T+u9BKI3FaNxAcVd+@nongnu.org
X-Gm-Message-State: AOJu0YwJgJdWjmcoldC0yMBJ/JrDrCQso9RIqN0ScPoHnvkPKWDtsBbA
 iaZBf6qqKQJ+AOkKcxiI1b8/HanJaBjgw8iwQa7mto+S/Pd3brTC2sWsC2vxIrU=
X-Gm-Gg: ASbGncstqJoRgux5QsvSYQ8c0WzgUeUe7AEVhF0gKAoAYLLOsFPiPPAtUB1NfPMBYZW
 nKSwQ5HU/7iTJnoC+MUqgWYcgIqaiVkmCISwCWTgmJ1VIfM9ghNRuFzbMeSOgA9sCISn700WFai
 8LgKdkOSWAbdN0BNFN06ibCXoIyb/GmVuUYs4UkueUL0QcYjg1c3UacuwZPNImvolk5cVVOSpEW
 FY98dZQBvAdIlTWPbzlasF6sJlP/tWfKZv7LSmPcJLek5Li7dqrqa5rQCYXauLTP6ce2Lh0Pmx2
 97BAZg==
X-Google-Smtp-Source: AGHT+IHhW42ef9dqjc/ad53gxie6Z9NaHEhWaARZS90RelX/giJQBqMV/migrrdj2lCvSM2+isrAoQ==
X-Received: by 2002:a5d:6d89:0:b0:385:e3cc:267c with SMTP id
 ffacd0b85a97d-385fd436ae4mr6937142f8f.56.1733398464834; 
 Thu, 05 Dec 2024 03:34:24 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm57943255e9.17.2024.12.05.03.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:34:24 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org
Subject: [PATCH v5 1/7] target/riscv: Remove obsolete sfence.vm instruction
Date: Thu,  5 Dec 2024 16:34:06 +0500
Message-Id: <20241205-b4-ctr_upstream_v3-v5-1-60b993aa567d@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e9139ec1b9cfdb2dc5029dd28430933a2b4e1442..a2b4c0ddd47ad9464b4b180fb19e6a3b64dbe4e5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -119,7 +119,6 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
-sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index ecd3b8b2c9e6c698f63c9bd3b3e5758426fcfe63..0bdfa9a0ed3313223ce9032fb24484c3887cddf9 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -127,8 +127,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 #endif
     return false;
 }
-
-static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
-{
-    return false;
-}

-- 
2.34.1


