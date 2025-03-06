Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ECCC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq50I-0000lv-Ig; Thu, 06 Mar 2025 01:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq50G-0000js-9l
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:46:44 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq50E-0006hy-4d
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:46:43 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224171d6826so1420865ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741243600; x=1741848400;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Be/GHZSOLbcX266/6hC+i01oZ+3WzvyKnxve3aa29ec=;
 b=0nJcGlwtnO/IQCFgUa1c+sHD1GE+BiHgyRwnKs4NDfflU5k7HwhmN+/oY7f4sqdUP1
 OO+6vAJZH4oojF3mZwzo71Iut36uTTaxFqbLrFswLJpFF2oDzbEBSjjxYFY0+JF8gvaM
 kPIb0iBS4W57k18iBBCsZ7ZkE5IMIaZ5/wwX7DLhF0A/vpdvHd31qUelh3PilfDW61Xv
 CAXOQTPJq09hJ4RsRocPWsR/a18GHoBQa65wYLP27MU7+O/FeEBa+FU9Nka8F3LuLFsa
 BsHBmSN6r8Nw3ySCg3AgjMLlfBA4Pzkg7rqe6cVKqP9ucV58l4p/nm/83ux+30X4vdEW
 o1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243600; x=1741848400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Be/GHZSOLbcX266/6hC+i01oZ+3WzvyKnxve3aa29ec=;
 b=T2tMKUJS1bdwIJTEpsoffmikOZVEGqTEpnCny+oeeD7R9zEo544F3TylRQICoeslmL
 X1iGMRPIpGOv7xQsJqLUuuWCO/gXh6STif8rFwT19Ofr9N9Q7/NbOWjaUoT9asLcXddF
 K29XJ2nYzSipkPJRn9HMX3ANnrgasDCM0fw6gvoCetUetG5S81nWqh/7qe88XrHoZg4s
 3dRvOTSBz3VbILLim3OxzNTUnLCbmBWLDk06/Aj27XBkDnJsJdrQT0EAFe+2n8bPNeTJ
 jP+fAeZwaeRrZGZK1g+hu0cLkPMo/lU5fQC5pY7NY1rU5Oq8bsH7Zms3pKs8J8bxuIgY
 GUsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMo1ih1xFamw/A6WoZ6ZZ7lEhrww3FWOiERMUVfplz7lLbdtxiFQWqZX7iY1hcgEpJj/xtX2JWDHsd@nongnu.org
X-Gm-Message-State: AOJu0YwCb1NqTLq3SmhhdZXC6J+f7MjfMx4FWInwpNJkXKEAgEbpdOsW
 8YcTuPJ4qn5genS8fPOn2CamBZosAbK8PTEQo8iBtPqoZf9VTCzxkkrez3rhZsTfel4sJg0prci
 U
X-Gm-Gg: ASbGncscHX+nfPDB47gd77uHVpulRBfK1ePtdTDc8MgqHLXYZmUSvjeqS7moW4gjol0
 aaIRjXjkM5XTrMraI0R7iveZ0byKTyECBl24C6Ok+74uCu40de+uCaDvA1le2gKphpiXN2KpNx4
 oLw7Zct2+QJSISsjMvdIhWE71iCdtjz2G6eXCTkNnRnvKBBd5nzN0sUKapBFpz7npPg9eguriPE
 76cbrVdjrx3D67VDCSptb0oVf9mgwyo/Nzdn9OVERM/JGTaao7Qf34ZjysVp3KkDAPRvba3gCQ8
 3KQTdUUzQ66N7YU/yoirkZbdALc9HpaSjq98VbIROA7heLRH5/fuyuI=
X-Google-Smtp-Source: AGHT+IG8dDeseyVbj2bax72SCNmsI2gXQCC4mc2IixV9ZlxknM5FQAaSSYaZYVT99TVEsPX3Jtoqqw==
X-Received: by 2002:a17:902:e750:b0:216:4064:53ad with SMTP id
 d9443c01a7336-223f1d45cfamr108163425ad.48.1741243600279; 
 Wed, 05 Mar 2025 22:46:40 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a80edfsm4828185ad.150.2025.03.05.22.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:46:39 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Adam Zabrocki <azabrocki@nvidia.com>
Subject: [PATCH v2 1/2] target/riscv: fix access permission checks for CSR_SSP
Date: Wed,  5 Mar 2025 22:46:35 -0800
Message-Id: <20250306064636.452396-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x632.google.com
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
rather rules clearly specified in section "22.2.1. Shadow Stack Pointer
(ssp) CSR access contr" in the priv spec.

Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls
for zicfiss". Thanks to Adam Zabrocki for bringing this to attention.

Reported-by: Adam Zabrocki <azabrocki@nvidia.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


