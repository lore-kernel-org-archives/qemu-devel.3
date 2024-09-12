Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896A7EE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPk-0001KD-7l; Thu, 12 Sep 2024 01:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPZ-00011y-QC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:39 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPY-00030O-6k
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7179069d029so371785b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119030; x=1726723830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P23SXrWlF898SusDBmeH7ZJkQYTtyW1PAq+jVBP+6cU=;
 b=eTORKXZk21wK6wRkSLaAOlDvr5BfeTazNDclnTZqY11rZHFRiFwJQqMqY9LaUqDd7F
 DOoL9h0siMmX0o6Z/2mn/WEzljHrbV0sVhW32i7A+KTD3gvOb/RkAMYT6D8MLrD77dm2
 5mPTvdCEWTFqK/s950F32WGm0myJupf077RODLGrKfaqJMxOVpMBbMxbjwg8Bham+3av
 0n9lpeebYkIpgSOIy+66Gs6v5YOaZ4SmPIK/zRyKkFezn95yVB7LOnKVT16b4NSTT2Nt
 m23ZK3wxGitPknca49s6IFsmZGADbd+LZjbbhNPD2m/1lNyBnqJXHqcUY+LBGUbadJAV
 2nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119030; x=1726723830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P23SXrWlF898SusDBmeH7ZJkQYTtyW1PAq+jVBP+6cU=;
 b=idV4QntpfqabiC+fHzWm4QU3h+P4fJF9pp17v53RlEFdVVt32z+SAOfiWJcHpAs2VU
 hh73T+aWdv4NOpnyif658P1WbmfnjvKAI4XV3/lh+VlCgT5AbH3NxzWZWRwy8EpB7AKd
 z1nTnEoc6ajnT/hMEIgmJF/t+u/zp4/4++SIgD4l9b08ZcR/7WvVRAsttpmLxKtkcg3F
 YMrU7e0gp0vjXHMd/xfs6i2aWHPnCgnZeHtxrdpyd1Owm2EWqr1JqSDCIGV37CwZFqfP
 8vjsml8Jdd6TJHI5JRDXyMCumewTzHzsBKceJh2PYIwEkdOlQ0yzLPDSzbm9IE0l8Iv0
 BYYg==
X-Gm-Message-State: AOJu0Yw+TZJf0g1QlKleg2PzWX1Uf3IKoHRUD5U5lJCbV3K579hvgoC0
 5gUJASrCYDMGbmGQWe+k7Jkq91MSYlfz5Z0B/nJoy/oGWgtFli19QfzM6Q==
X-Google-Smtp-Source: AGHT+IGDY4FooubpsitL5EW+9MbOGfJNpy7zsaFPrmseVDMARQIzNHh6yr2KF7737B0peJmncRvDbg==
X-Received: by 2002:a05:6a00:2381:b0:70d:2ac8:c838 with SMTP id
 d2e1a72fcca58-7192605877cmr2747316b3a.4.1726119030446; 
 Wed, 11 Sep 2024 22:30:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:30 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Maria Klauchek <m.klauchek@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/47] target/riscv/cpu.c: Add 'fcsr' register to QEMU log as a
 part of F extension
Date: Thu, 12 Sep 2024 15:29:15 +1000
Message-ID: <20240912052953.2552501-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

From: Maria Klauchek <m.klauchek@syntacore.com>

FCSR is a part of F extension. Print it to log if FPU option is enabled.

Signed-off-by: Maria Klauchek <m.klauchek@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240902103433.18424-1-m.klauchek@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fc3f75e826..d215681905 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -844,6 +844,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
     if (flags & CPU_DUMP_FPU) {
+        target_ulong val = 0;
+        RISCVException res = riscv_csrrw_debug(env, CSR_FCSR, &val, 0, 0);
+        if (res == RISCV_EXCP_NONE) {
+            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                    csr_ops[CSR_FCSR].name, val);
+        }
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s %016" PRIx64,
                          riscv_fpr_regnames[i], env->fpr[i]);
-- 
2.46.0


