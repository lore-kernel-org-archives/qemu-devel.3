Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F6D1CA01
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t850y-0007we-Nx; Mon, 04 Nov 2024 16:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t850w-0007w6-Hx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t850u-00011J-Qt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43193678216so41073095e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730757211; x=1731362011;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeHKxz4SCr4FLt1UY4Xd40xGZa8n9dG3guDv0GCCUpY=;
 b=XacK+/OX3KaIRTXOcEDHrlcRDnlhniYAi2U+imH5UFKkPo00rLMcozFw2a95nSbACR
 Jhxv15lsIuHc1v41YFpSaHrSJWoJh29LV/giD8ZlTI7X8DjpD4zkwV3UPHDPCuX2e9Vm
 xgvtChy7SQg/e1A27YBxwOjRxpWW4Or9wByhLX3CMcNsmbIRItXdY/Ysfgr4AJbYYmsC
 7iBb/cn+uWdGwzMhDZ7r1oULswkvyTnZQdhDGVaTuYYBa4w2CkmTOnS28YbrspUhYxRz
 AiNJZkQCiQPpfSq9dD0Siovac6fmvF0QNc3TzAN4sRe5eSl1+rjuHZ+Mh4aKYQ6SHR0Y
 6ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730757211; x=1731362011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeHKxz4SCr4FLt1UY4Xd40xGZa8n9dG3guDv0GCCUpY=;
 b=VKwTIEs0oHvwnBpuDt0RQnTM0QAHbu4uKYfSmgw3X3JkIga1qmPVGkOgLL2kQIQmfK
 95oaMwAq7th7CmFOOT97Mrq9ocAknMQv8Hxii7Dy1k3NuwZRdcndBa1KQZ9nf49sDyhW
 eA+eET/D6v99p1l13ZEOgn9IscgCPbTyOtDswDPJ+toCqmLHAcp3FN3dOqHAhluNwczX
 7X3K7XSQr2sZJirPozQNp2a3LVR2HJdkQ5g3AgPyx9iRQlzLxMM2fuhSo9CNFYDPecjB
 dB24aXaKahIlzj2r2ucuE7cRrfzY+ATB6xZaeY8ttNXvZty2dPhHfQQpWaB2qFvvidiB
 Km0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Y1QCrb+9HgvH1VYFMjFyr7pTNBPwhNRdqlj79ukBk2e0oSxStF/h4U/9UVQVKvOREi15wvv9FyY7@nongnu.org
X-Gm-Message-State: AOJu0Yx3+UYGopRsu/lPW5gDATuuYyrHUpamATOERhMTXlxOhsx0b1Ab
 M4ChDZZcZkEcxexTs9oPsP8e0O0Sw+GaZRzmvpqP1uuMDMajAbLlyg3R0RGE/OA=
X-Google-Smtp-Source: AGHT+IEDAB4JiWUfOOLrAOH3vnBiXDdHQRpqO6/W6ZnbzylQR9wQ5CSu/0HddtrbcxglZw5mPLyLGA==
X-Received: by 2002:a05:600c:154d:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-4319ac9d21amr301220465e9.13.1730757211404; 
 Mon, 04 Nov 2024 13:53:31 -0800 (PST)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:8a3a:7719:aa26:21cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a6da1sm1537595e9.0.2024.11.04.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:53:31 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com
Subject: [PATCH v3 1/6] target/riscv: Remove obsolete sfence.vm instruction
Date: Mon,  4 Nov 2024 21:51:05 +0000
Message-Id: <20241104-b4-ctr_upstream_v3-v3-1-32fd3c48205f@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
References: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32f.google.com
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
index c45b8fa1d80279f79f70be0531dd88b28208c206..66353a66786a1e2482dc248b7a4c480b17884808 100644
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
index bc5263a4e0f1f1853f2152e11ae2a60c31c4f39c..4eccdddeaaf0c242cf3b2c268bae3230126dbc7c 100644
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


