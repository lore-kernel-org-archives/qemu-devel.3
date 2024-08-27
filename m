Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4FC5473F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TV-0004Ik-4l; Tue, 27 Aug 2024 19:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TC-00035G-FV
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TA-0000sd-SG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-202508cb8ebso41267005ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800763; x=1725405563;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGGmvWw0RY1iWRrruhF6H784nJTg3545+D6bTLHJ0CM=;
 b=R+B8PPk5vS44DYMhHUw1Br30BOZwvxtrog/4nDVcQuGoS/t+oZUI/TFZvdZvkjeR0t
 x9LQigZDs4wNv5SMchBtSKK+7ZjI8hExoUL3USDXdnWDa5XukGYNynR6JiaY7adgPprK
 YdhkbPTQ2ShD0Bzc/wiUWWRMOCL8eb1voq5Dy1qO3OfBzrcCCfke73feLiBW4VZRPTTG
 Mcyc1HE2DJbTJ7EEyeNZoeuy7GYveG5gFNUtzHSHNk2D1c8CvB+zPIaQu+CFRsW3kknb
 cnhrBy8BwRbFM6pPaGj1VsAGztHVfDHsQOqm49JLX0JLl3549nozYz8YdpgmuGujviIX
 Gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800763; x=1725405563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGGmvWw0RY1iWRrruhF6H784nJTg3545+D6bTLHJ0CM=;
 b=IGzWPIeN4CbIrhM6vgiK5LmFsv1Q1h0tJNx8zAQc7htQ9XzY8abJUmpz7rtxbbJVqL
 sjslsDB4p/aXLArrEltwsisSTZjt33a9BKN8esTEpvJWdmLPwsSK50g+Og0S2phTjc0B
 n6XHjpISkG04CFuVQml93K6nPBY+qC+/eoDb/94uW8a/W3nIPJWCtpgziDQ2Qp6Rk7Pq
 pYGO/0vBbMQJiOI6yp6qhVyt9LnJft7wuGtwoMtqkcUy7u1itjrp0z+oqechXUIgk0iJ
 5/BvzhtY8CzWsv2v7CnEMS2OSkWvfc1YA/EcsQaahEYEfy7IOcPWUUzoLtXvxVLLaIib
 NbcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHncJyHuvDttOQkPNUA3xE4Wmai+wmtcx3YoMUxjUzZY6FnE2FxqPZbPHfoPNPowbAvwtg6nrdqJpG@nongnu.org
X-Gm-Message-State: AOJu0YzvZHpeP+0erpCl1b++JyRzy8ZKm88o1ISeA+pb6uPfUX8bw9Dc
 yf6Ojoq82kf7jEqf+9Up4I8j6VuJbhZmcsJUN6/5IZyfMNsFSjG7TF2SVYcaQkI=
X-Google-Smtp-Source: AGHT+IHfX2UEhSLbQ+A+InwOt04wzuJXJKfegKZlrVewVNzS8PQTnKt7bmecIv9OnJCOQw/LlClwMg==
X-Received: by 2002:a17:903:2302:b0:203:8b7c:c8eb with SMTP id
 d9443c01a7336-204f9c87c1amr4792345ad.63.1724800762932; 
 Tue, 27 Aug 2024 16:19:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v10 10/21] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Tue, 27 Aug 2024 16:18:54 -0700
Message-ID: <20240827231906.553327-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2d031e3e74..8e1f05e5b1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1476,6 +1476,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.44.0


