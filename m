Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658A2CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn81-0005PO-Rt; Wed, 03 Sep 2025 09:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7o-0005I4-3P
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:02:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7m-0000XG-A7
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:02:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24cb39fbd90so199185ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756904523; x=1757509323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7yO8ADA0pol4cy8ipnt6jQ+4uDi0a2eWjgPSJWFAag=;
 b=W5dWaqwDzxLLEm8YFZUgX18zgumHcVzfB4UNa6kADQGdX7/byX3paik4yJCUajF8y3
 7vw/EhyLoe79ZZM5cFn/f+c5/jNy2y27gadA+jglULlaf9YK3+BjmJT5p7FlcTxgim6R
 06n39OvQmKuYUiwGEfmF0KLSu17JrCE6id4fzwsOjObcruSSsuO1uQs/hJLfEdmhQnur
 Pn76JF7SJLlSz8h6f105MNyksZ1MWCfW8omRh6lFVuWuuoHu0MwNOha4aJu0vA/SF2HW
 3tClMUCrC028iobjojQhIfsntj3LLkSgGxTCVszIF+GqKVQhzISKEvm4WSHCUH7499oA
 rSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904523; x=1757509323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7yO8ADA0pol4cy8ipnt6jQ+4uDi0a2eWjgPSJWFAag=;
 b=rJJpJ98jlYyyl3LHveeHU1llog6NVGbpBvXhU+C1oEaAkh+1K5+8oJfFA2ndBrbEyh
 vqyrB/XV3KKBQTkySgALoW9tjsYmgmmEUED9uTXTxlU5EEI6IW94/cMUTkcsn0Lr8pHz
 NY39cYE9G1HvsBy+YqFV5hls8g7fXHI1T2c3CtJvp5D3Vncqh6DRA14H0PvzVkehgoin
 HSJThZ4AbqNcNiRki7icdl9K6DTQKWU5K+xEy283TzrIpMYNZh+qDF9MUXQoIYgVt3a7
 WXXTO/qKp52W0v8cnqtU7IjGkFgG16G/b/1cNxMd9Rqt6X7yQ3SA8Uq+eKNNw79AxCrU
 qYAw==
X-Gm-Message-State: AOJu0YwDSs0S9jSUjwaNhhe44UUUFefhFsHjBP92AM/j86uc3bAhSN/Y
 N/h2cpRsklo+7L4xluLIL2nw5PRb2IQCh+8c2bz82QSPZGV9Gtgyu0/QRRykdAqxao5qVrE8nCa
 Bam4ymkVDaP3jV5Te6m1ddY47X9BkzwwhpQWLCnUbR9ikP5/aLtduZn2Psd5ILWKRuOBi0cGAUw
 MBNeLYcthpHU6k8iBI9rTkwrbGDXl7lMTN1YNIZGGEjg==
X-Gm-Gg: ASbGncvfZOkm5pHFGNJzFdY+p4BCbgvWOusMQZbdI8JcC0QWAU0C9BJeGwkFvlggdmN
 KmB2Z1WPPVqqseeF1mow2KZZEwqB0rOThaOaUFE958GvlLYvQk6Y3HgDlf+pO6/8/z62NOlP8Vc
 ZTUC75m47KVr3QEshzv+yqgHZY1IYRKsxOB7fBInCUzX8Od5sJbvMUKIUMWoNIoUjJOG9N8usds
 DminET9qVQgHS5BfMuYW/jgjyjiPQE2jJvaGymTjw/PA5eDplVlTpUCdf7RDKA2/04teFszf2AJ
 EkIpcVB5fdOwc5bpssQCNUnux4rGhJNbuZE3wM2UFUo8N/N8c02PWIfO9utCR9Uw2VrHWZDvWTI
 OoGon1g2/E8ZTwVDq6XzYmhKRQXP05O6Qj50JweEGzYlIvm4y2FqB9tt+rI8cb9jhQhk=
X-Google-Smtp-Source: AGHT+IGgfRSMell+/W3XLFCDDR80gZvnWvEbUrMOkY74hJ14lx4kYrnVxKGZ0YBfuAwyGNt9sJIxwQ==
X-Received: by 2002:a17:902:ef52:b0:248:8d0a:b4c4 with SMTP id
 d9443c01a7336-24944b523d9mr205320645ad.47.1756904521068; 
 Wed, 03 Sep 2025 06:02:01 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-329e23858ecsm5472278a91.14.2025.09.03.06.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 06:02:00 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v2 3/3] target/riscv: Expose Zvqdotq extension as a cpu
 property
Date: Wed,  3 Sep 2025 21:01:25 +0800
Message-ID: <20250903130125.1701363-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903130125.1701363-1-max.chou@sifive.com>
References: <20250903130125.1701363-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 95edd02e68..ed486113ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1373,6 +1373,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvqdotq", ext_zvqdotq, false),
 
     { },
 };
-- 
2.39.3


