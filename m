Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1713EEE271
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotdK-0005rA-Hi; Thu, 12 Sep 2024 19:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdH-0005c6-1I
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdF-0008Cj-GY
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so1175296b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185228; x=1726790028;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7nGUkC8AoqQkvdlZ/4VsRGMOV3aEFYCGC3UA04clbY=;
 b=IIt3uC6ifhgIRSZctlsje96rxW7rrPQzHTrl+Ff7++bOC8axZSG9oIpN8q4zY3AoTc
 imusBUDP2lDXKxXUfZyDRFqYt73h0WTKLXzBSU+dDE6oQhhdz3JQW6eSiRQaE+kDfxh3
 NKICLoBBkzv4hzAaekR4RsQOZldh8cjxlihaKO1sn9Dqas+hdyv/SQk5gOW8ZhoX4U4S
 qj3+zZ4jtg+q01lkuqyZCWJMC5ZeQIRgJktufKGw5aZoZHkss7aOzwt8WOiU8Gk/lJ+h
 e7dxyP8iCxKDICrv9BmlrM/aSQOP4pxxAvjjjbbExQ1zuOl7VSMGJAzinvLMZUG34Gl4
 wjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185228; x=1726790028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7nGUkC8AoqQkvdlZ/4VsRGMOV3aEFYCGC3UA04clbY=;
 b=bgrO1POav+0IthuYX3HUoyUBpkxgHKJ/FsPDzBPrNGJN2qFUQEEEo1gvHHlWDeHnfy
 iv32oAzsXCnChzrXCsKYX4fgAKrjOmnKJWGQnagTIHCDLfA2/qscFGybEfPhTSJ0D9EL
 vtu17QE5xxVQv/AEWUlCkmI8yu1EJD90ymagNMKGfxLtfQITHjN2HsjlnNXVXoihXO1E
 YiLWul4T8vgP+hwPdQngW5ngZHE3Acgr1JkacwNN82e5XzCe8YCHVWMEYr6ExxbIu5RS
 rte4rysRiIxBViJepmAQxSkilQINH5ztJfHGNrP46yFADLV7NCHU/9wdWS9tFqln1V2D
 S4kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn9dSj3yrZIo1gOocSyTYVWHE3dFWS382BsBKOStLiiyJarA/pqvYl71JDWMuj+O4eUmDlGtI2IuM5@nongnu.org
X-Gm-Message-State: AOJu0Yyk4v840W+kXhMNr3aC+6VqVT+ZRDqL3J4Kwjx+JDTB9loOpcLj
 uPrrMZ8j2h7wW/IB8QkH6royeOTGN+gIHPJrzvX4y2JahZXk0TOqGHVpw93+VBs=
X-Google-Smtp-Source: AGHT+IExiWNfKNLjn0iPglMO27St8rleP2T2e4jGVxAiasXFgViDBbyK80qHBEkWgtNQRizXshX0IQ==
X-Received: by 2002:a05:6a00:1248:b0:70c:f1fa:d7bf with SMTP id
 d2e1a72fcca58-71926065246mr6561368b3a.4.1726185228106; 
 Thu, 12 Sep 2024 16:53:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 17/20] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Thu, 12 Sep 2024 16:53:17 -0700
Message-ID: <20240912235320.3768582-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42a.google.com
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..bf893d1c2e 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  # c.sspush x1 carving out of zcmops
+  sspush          011 0  00001  00000 01 &r2_s rs2=1 rs1=0
+  # c.sspopchk x5 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 &r2 rs1=5 rd=0
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.45.0


