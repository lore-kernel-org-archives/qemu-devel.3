Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776E2CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofQ-0004Pv-3x; Thu, 29 Aug 2024 19:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofM-0004ER-KR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:35:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofJ-0003E4-5Q
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:35:00 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d41b082ab8so923345a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974496; x=1725579296;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cUqXMdRltulPpZ8kSqOomp97N4/g9EkAE49D3ogDzs=;
 b=rohHYY4q/PMg3sSOmylLy+68xg9ZLOPaEbO8ZDF38l59DehWzK0fgaOApOHra7GUiK
 NHnLfRSrMfAkddZToX+3716HxUkcXgDIayr8rdzHruqQwk2glk7KJq1TaUc9unPUmn/3
 u/3bRsryLy9dYUkHAqHfPZ4SRBEBozPvpSNvK/5aoBgBmMDyYSkEfAJSd/qJGZ2izCpb
 YLKRth8b6k4nmq6wbbA+X/M8MyO9OH8ZhVTgUA0thoFY4ct9+H0E5l6OnzLgMEfDo9l3
 43G8m8rXhGNzkaeKZHZT6I6O2/Y0VVGmo8jGdgzxZB/iZSusSnYpsQq7KuZ8kh+O3VUU
 mDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974496; x=1725579296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cUqXMdRltulPpZ8kSqOomp97N4/g9EkAE49D3ogDzs=;
 b=oczUKY9tFtkp3RzuwsxQAlwZMgQyraTFpM5IkLjcSOEOymIyneVdw1nBNbjNtGoOyl
 hBQ3d6P/qK4P17NgAiGLYYB0G47f3b4S+U+jQwLwp49raBoSU3H8AYf4/6ZeI2KOPrad
 Na6tV6JNCevpxzA6GqZPoPmcCjiXGmohDcKAAEDE1E4pB1VDfm9mlvE9Jsh+SQA3N64Y
 KEMZjCbdLh51l/vrUhW2Bt5pNm7mJUwRoXuwMCvx22PRCkT5kcXG8WV4nzEC8Mb/yWY3
 sjcHbjaaarUhHbMar5b1B/hAZnEsMwUgHSAaKL7DGmlK4cUF/3Ft+goYX0yJ/dPKm7uL
 0z0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfiFUmo1l232z/rvphpjVpLVBmjm9K5LZc1KqthMKaaQaZstm1XOHvh8rsR67DR9c2TL7uCHKeGYCE@nongnu.org
X-Gm-Message-State: AOJu0YwnaEfiLFjBopmTS3Lc1VrZxBPGG3Hh0TC4q+o1mIVKUaFjN+mX
 DJNZW7Vn2W8FdJ5gcyJTrfGb6ybe8TMTUft6cIpAGuWQbwCz1SOcRI+xd4hjENE=
X-Google-Smtp-Source: AGHT+IG/81XX7KdKF0rgAA74hg6IEqxeMr5FgDelm+F7lPrwoka2wnH9B8cgB/WmiGKG1d5nm5Bn0Q==
X-Received: by 2002:a17:90b:1e4d:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2d85617e3fbmr4497947a91.9.1724974495593; 
 Thu, 29 Aug 2024 16:34:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:55 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 20/20] target/riscv: Expose zicfiss extension as a cpu
 property
Date: Thu, 29 Aug 2024 16:34:24 -0700
Message-ID: <20240829233425.1005029-21-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1030.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c5ebcefeb5..2592465e24 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1485,6 +1485,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.44.0


