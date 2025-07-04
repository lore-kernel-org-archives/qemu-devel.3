Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11875C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLr-00023O-Qo; Fri, 04 Jul 2025 07:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLp-0001z6-9Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLk-0002wg-6r
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-235e1d710d8so11775705ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627579; x=1752232379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIB6W+/i6ZPM8armFh2cEM7Exu8V9Bmkl+w0LJdjQRw=;
 b=UIFeu5Ha1Ejm2lE4e2SxxrYMvGR8ZENJYDJnjxl2Qa5v8EBWfVpHRFmHMUB3abfMQS
 usUQ291YFm8wPt5YPcmqjGqM+ShXl7T4sYHQLbdEfCFZ1rrHOed7v6UFgixyR9ayg6Bx
 yX4s1Cj+xI36Rn/qeOwkhkhEEvV7Njz1w4kw9IxXqQ+y8PfQogE6MHk6EFW1U0Dotfz1
 2mW5HLm0al/sPUTbxJWM0qTRV768+caVPLuHIOpB+TPJYgm7y8NR6Lyg1IydpA1wkjRY
 lhr9wUcLjxhXeLriy8QW8hsWLRzAhut4YMlPt1HOPH16SwAimqL1KTthdJfKgQsIFDRJ
 eZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627579; x=1752232379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIB6W+/i6ZPM8armFh2cEM7Exu8V9Bmkl+w0LJdjQRw=;
 b=jNP+X31zn5VryJ7blIsQZIuj78QxIv6Wvomx7FvrCGYcwpCLdfm0ckGoLyouMUfmma
 3QcdfeAcdy5w/mWDp1EFLtBN7+RM78qfqlVjr0jZVHZXf1Dy5jP9otWUKhMLH8e3l36R
 q/UkLfBWtu5BTEJ2VvB8ev2QpyZs1kXdRkKQYAYmkrYhjQ8xoSjNfu3cAYdYBp2MFBPR
 VhT8jk5bsFmBPoQvQRbbAxXEqXsCTFwttUiDjYxXbGuvWlLPelDXxwYYCWZBqRndrfP0
 nuXsPFB8PUR+tSf9OJ4tPDY/wamz9NVq7+21JMueX6n184o6I6Fs4+mDPnRIrgdaqjIq
 2/yg==
X-Gm-Message-State: AOJu0YykJVswVSscbYXEFFyk5TJE2MfHPYTc9syn3V7DfYGa9g/2JxYK
 TuJTMypYEEXQpzme3MdynBNoo5glPSw9B3G4/WKxWSGwg2t09QbjX4zdUo9VPA==
X-Gm-Gg: ASbGncuBmVi9+vzcltS8zio8uFy3rpBauaDWNhRS0y9APeQhC3M8lZUHz7208U4B4Oy
 NuvfkDK6maibLI70ZjT6KcomVzRFsDezvlAgeaCBZZ6T5F7GYIxb6/tbrEKaYSJ7mPsavjdR9+n
 bXzqLvdpvaMoViskdLvEoGVkeEsTJtHWu+FiinPpPAo8g9djuxvoBI00gUWr2/Yaogc6Ll+ltyw
 l6USMCGnQ8YsNgDprhmdRDX58hsskhHasDaIxDFDnGW021hx2vM9HohJ9PhO/gPTWa2dRNJRP9/
 TKkcsUqqS3jCjaxYnUCdJFXC7xtzCkuip+yydCYveT+Ur304TE1KEi1paK575LWLeFODRbtErWy
 W5r+CKOs5LC6bC2aVnzdkjEjAUbJp2v5Ti96qlDnCZ0VgKMgliBYQljcIw77/C8PV/Ok=
X-Google-Smtp-Source: AGHT+IFQSWjP5dxtJBDqBfIF2GlpZHhPvHFJAu4De18job89aDFPZu89f8Stl9lDHRWiGiX6WiJHqg==
X-Received: by 2002:a17:902:cccb:b0:234:a992:96d8 with SMTP id
 d9443c01a7336-23c86074854mr40665575ad.19.1751627578576; 
 Fri, 04 Jul 2025 04:12:58 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 09/40] target/riscv: Extend PMP region up to 64
Date: Fri,  4 Jul 2025 21:11:36 +1000
Message-ID: <20250704111207.591994-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jay Chang <jay.chang@sifive.com>

According to the RISC-V Privileged Specification (version >1.12),
RV32 supports 16 CSRs (pmpcfg0–pmpcfg15) to configure 64 PMP regions
(pmpaddr0–pmpaddr63).

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250522081236.4050-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  60 +++++++++++++++++++
 target/riscv/csr.c      | 124 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c617..e6b3e28386 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -372,6 +372,18 @@
 #define CSR_PMPCFG1         0x3a1
 #define CSR_PMPCFG2         0x3a2
 #define CSR_PMPCFG3         0x3a3
+#define CSR_PMPCFG4         0x3a4
+#define CSR_PMPCFG5         0x3a5
+#define CSR_PMPCFG6         0x3a6
+#define CSR_PMPCFG7         0x3a7
+#define CSR_PMPCFG8         0x3a8
+#define CSR_PMPCFG9         0x3a9
+#define CSR_PMPCFG10        0x3aa
+#define CSR_PMPCFG11        0x3ab
+#define CSR_PMPCFG12        0x3ac
+#define CSR_PMPCFG13        0x3ad
+#define CSR_PMPCFG14        0x3ae
+#define CSR_PMPCFG15        0x3af
 #define CSR_PMPADDR0        0x3b0
 #define CSR_PMPADDR1        0x3b1
 #define CSR_PMPADDR2        0x3b2
@@ -388,6 +400,54 @@
 #define CSR_PMPADDR13       0x3bd
 #define CSR_PMPADDR14       0x3be
 #define CSR_PMPADDR15       0x3bf
+#define CSR_PMPADDR16       0x3c0
+#define CSR_PMPADDR17       0x3c1
+#define CSR_PMPADDR18       0x3c2
+#define CSR_PMPADDR19       0x3c3
+#define CSR_PMPADDR20       0x3c4
+#define CSR_PMPADDR21       0x3c5
+#define CSR_PMPADDR22       0x3c6
+#define CSR_PMPADDR23       0x3c7
+#define CSR_PMPADDR24       0x3c8
+#define CSR_PMPADDR25       0x3c9
+#define CSR_PMPADDR26       0x3ca
+#define CSR_PMPADDR27       0x3cb
+#define CSR_PMPADDR28       0x3cc
+#define CSR_PMPADDR29       0x3cd
+#define CSR_PMPADDR30       0x3ce
+#define CSR_PMPADDR31       0x3cf
+#define CSR_PMPADDR32       0x3d0
+#define CSR_PMPADDR33       0x3d1
+#define CSR_PMPADDR34       0x3d2
+#define CSR_PMPADDR35       0x3d3
+#define CSR_PMPADDR36       0x3d4
+#define CSR_PMPADDR37       0x3d5
+#define CSR_PMPADDR38       0x3d6
+#define CSR_PMPADDR39       0x3d7
+#define CSR_PMPADDR40       0x3d8
+#define CSR_PMPADDR41       0x3d9
+#define CSR_PMPADDR42       0x3da
+#define CSR_PMPADDR43       0x3db
+#define CSR_PMPADDR44       0x3dc
+#define CSR_PMPADDR45       0x3dd
+#define CSR_PMPADDR46       0x3de
+#define CSR_PMPADDR47       0x3df
+#define CSR_PMPADDR48       0x3e0
+#define CSR_PMPADDR49       0x3e1
+#define CSR_PMPADDR50       0x3e2
+#define CSR_PMPADDR51       0x3e3
+#define CSR_PMPADDR52       0x3e4
+#define CSR_PMPADDR53       0x3e5
+#define CSR_PMPADDR54       0x3e6
+#define CSR_PMPADDR55       0x3e7
+#define CSR_PMPADDR56       0x3e8
+#define CSR_PMPADDR57       0x3e9
+#define CSR_PMPADDR58       0x3ea
+#define CSR_PMPADDR59       0x3eb
+#define CSR_PMPADDR60       0x3ec
+#define CSR_PMPADDR61       0x3ed
+#define CSR_PMPADDR62       0x3ee
+#define CSR_PMPADDR63       0x3ef
 
 /* RNMI */
 #define CSR_MNSCRATCH       0x740
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1151ebb6ad..d6cd441133 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -6164,6 +6164,30 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG2]    = { "pmpcfg2",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG3]    = { "pmpcfg3",   pmp, read_pmpcfg,  write_pmpcfg  },
+    [CSR_PMPCFG4]    = { "pmpcfg4",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG5]    = { "pmpcfg5",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG6]    = { "pmpcfg6",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG7]    = { "pmpcfg7",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG8]    = { "pmpcfg8",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG9]    = { "pmpcfg9",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG10]   = { "pmpcfg10",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG11]   = { "pmpcfg11",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG12]   = { "pmpcfg12",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG13]   = { "pmpcfg13",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG14]   = { "pmpcfg14",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG15]   = { "pmpcfg15",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
     [CSR_PMPADDR0]   = { "pmpaddr0",  pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR1]   = { "pmpaddr1",  pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR2]   = { "pmpaddr2",  pmp, read_pmpaddr, write_pmpaddr },
@@ -6178,8 +6202,104 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPADDR11]  = { "pmpaddr11", pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR12]  = { "pmpaddr12", pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR13]  = { "pmpaddr13", pmp, read_pmpaddr, write_pmpaddr },
-    [CSR_PMPADDR14] =  { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr },
-    [CSR_PMPADDR15] =  { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
+    [CSR_PMPADDR14]  = { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr },
+    [CSR_PMPADDR15]  = { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
+    [CSR_PMPADDR16]  = { "pmpaddr16", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR17]  = { "pmpaddr17", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR18]  = { "pmpaddr18", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR19]  = { "pmpaddr19", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR20]  = { "pmpaddr20", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR21]  = { "pmpaddr21", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR22]  = { "pmpaddr22", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR23]  = { "pmpaddr23", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR24]  = { "pmpaddr24", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR25]  = { "pmpaddr25", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR26]  = { "pmpaddr26", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR27]  = { "pmpaddr27", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR28]  = { "pmpaddr28", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR29]  = { "pmpaddr29", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR30]  = { "pmpaddr30", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR31]  = { "pmpaddr31", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR32]  = { "pmpaddr32", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR33]  = { "pmpaddr33", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR34]  = { "pmpaddr34", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR35]  = { "pmpaddr35", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR36]  = { "pmpaddr36", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR37]  = { "pmpaddr37", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR38]  = { "pmpaddr38", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR39]  = { "pmpaddr39", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR40]  = { "pmpaddr40", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR41]  = { "pmpaddr41", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR42]  = { "pmpaddr42", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR43]  = { "pmpaddr43", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR44]  = { "pmpaddr44", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR45]  = { "pmpaddr45", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR46]  = { "pmpaddr46", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR47]  = { "pmpaddr47", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR48]  = { "pmpaddr48", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR49]  = { "pmpaddr49", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR50]  = { "pmpaddr50", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR51]  = { "pmpaddr51", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR52]  = { "pmpaddr52", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR53]  = { "pmpaddr53", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR54]  = { "pmpaddr54", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR55]  = { "pmpaddr55", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR56]  = { "pmpaddr56", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR57]  = { "pmpaddr57", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR58]  = { "pmpaddr58", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR59]  = { "pmpaddr59", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR60]  = { "pmpaddr60", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR61]  = { "pmpaddr61", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR62]  = { "pmpaddr62", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR63]  = { "pmpaddr63", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
 
     /* Debug CSRs */
     [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
-- 
2.50.0


