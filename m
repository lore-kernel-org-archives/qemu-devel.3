Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE95DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDPS-0003vk-Vb; Thu, 21 May 2026 20:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO5-0002YN-12
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO1-0004B4-FL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b458ca2296so48485345ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408303; x=1780013103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMMqLaKrCoP1vDhVq3vdZXjM2VTYqU1Msqxk/7vrSmo=;
 b=d3XPh9psDEPSioIcAuNkB2mMXTHY4mr46mFORPgi9JPX1/H5w37P4dg+A8H13zxPRg
 hXGBVxH4nxBbzybwHfK+lboIIqx1XiPnaYcuMQSJ5RUVxW4N/tqk0BveUUgnhYQybx9o
 d13pYzV2eptoB+RnyAQ5khETkO/FUbY406WcOo5XgxXZ4fkUaQb6L5rXz1XhTsxqluE4
 HtEtXwpsi/7+B5KA3npPq08lCWNPiMTOQNLDG230s1tqwLefP822Lx9j8X6Pi/KEK8o6
 9qhRs4VogEMNQnvSXWzTp15JIZvKFyijIPqFb8/yylz5braSsqzPoSV5WoooskeMIIbn
 T1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408303; x=1780013103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMMqLaKrCoP1vDhVq3vdZXjM2VTYqU1Msqxk/7vrSmo=;
 b=XLMyPsmDiNb47v8W8BOQ3bhTd8iA6wMVVrpVUFyihAmXd6+nPeWutK8R9GE4lUaEvS
 qam0EZlDFCHYp7pZAgvq+uGlPJMBt0d3sSP6zX8F0haM3NLe6jVK7gEXKRfvLI8HXZvK
 5fQdH510wyYxBmnpUDHLGlWfcVG7JvMbVCJ8uIhyulo+jRsHtq5bWLEWvoS2FSJjPBxp
 5J+SquLa+fXBtkdDv5wh84jQmtHm5uQC4po36JzMAy+r2rPl99XXYjIqztdbBW7zbsTy
 ugZr2lFfHRAisafAvAdgInv/wZvmDeOTs46Rvo4gjh37Fu18ZesLssyVGuici4fWR4WC
 avFA==
X-Gm-Message-State: AOJu0YzMaJaYp7tIhdx6eYE6CRH4kjbfHrPoMeQQ9MkKYmeCyJ62FE5i
 N8p2+45jVPUY26I17Nl5OKCi/cOHetBZ9qb/dMTNs84gWe5rnoELw/R0pebfve6D
X-Gm-Gg: Acq92OG9m2Ta+f7IBKUSEfkpJPVX2zDRgrNaVvIk5kUnGlZbjCyiUNOzJQ1kcgdr8Qk
 fxt3OLefxbvpDkyN6g9HlArvLbMSZzjyuVgfrWfOWnfXp3GRjxJkEYh4RhJ9jd9+i6/5a0dRFFb
 RQjd2O6JbsTbcz7SfLYceNGlba1h12ahqzBbLnCj6NwGr9zhCobzotIkMhmgI5pUPTSoAHvjk4i
 lA2AVi+QJm2S+LxcSmR3TzeFWH8udqnqkEY8E6TS0OeQfog/5JrPxpSKvj9ix3s93z9cBHYSmgW
 TyybmpENh5Googy+sxiVhKU2E+HrLLxLmYXwqwXR50aOZtEx98B8zTREhBmjlCLkoSkfuitMBei
 NbRDPLhZ5TQW5ntPVx4QKGjhcgmPGysGHUeBoYf3Eqv+PkVerrMR3OKdatFv/i2lbcgcc6j/F1Z
 xphP6TQephbuehvNs/b6So0o4Osj8nJBo5v0sPLlEtAQ==
X-Received: by 2002:a17:902:d50c:b0:2bd:105c:91cb with SMTP id
 d9443c01a7336-2beb059e13fmr11581135ad.15.1779408303288; 
 Thu, 21 May 2026 17:05:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/48] target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
Date: Fri, 22 May 2026 10:03:03 +1000
Message-ID: <20260522000324.23255-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Noticed when realizing that 'svadu' was too far apart from 'svade'.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8a3b3ef4a..0a56dc61bc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -222,6 +222,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
@@ -235,6 +236,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
@@ -246,8 +248,6 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
-    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
-    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
-- 
2.53.0


