Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF5AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzjAg-000586-3m; Wed, 24 Apr 2024 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzjAV-00052m-BG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:24:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzjAT-0006Wq-U4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:24:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ecff9df447so355354b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713990276; x=1714595076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QderLQFNnEEbgwL1oCKkwQI5umxVetU0de2TmLTVPbw=;
 b=GCmtKrkqoJtUUClhhlS/5ZCw73zsaE59bRfhaYHiIzlJL39sNcuoQLxKgSpmTttZTH
 flodMe2vaY15MgJk/MYYLuhGlR8fXiEecpo7380H1uUIXZPfTqg8jvRhpwgHMZBUka6T
 W+lXAVKjtx0MNrdoFuqm7mNCDrXsMpZuhQNq7YYzpMJ9ieQ+NOBdBUdreNWqkfPLL/eh
 jnMpLdfqLYCntUwL63AT6B+l4qtKYvc6NY1ePpFEYtzUytUXBcn8HBfTYMOtT0VAMquO
 BiBpbQy1vT+51xmFhcJ9pRfZN7wIM02+ZMMtkuN5zGfw4XBPU5bLTfM6M/U8ZfIbs104
 N2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713990276; x=1714595076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QderLQFNnEEbgwL1oCKkwQI5umxVetU0de2TmLTVPbw=;
 b=OIOJtce8A8PfzPWTpmff3pbnQIl1A4NAGxqtei4dTPJSyRKiIGyydE/QfAq6rb+VR5
 ao24a5le3DWkiezqVsw+ukwTF1D3AujaYEJ5hXnkPa12R/oBa0tWrrwuhn0f8Y3DRK5E
 LUaZr5reUxOvRSQItmG4UdZHiFgt7re63dxrpiFkq+ntHKkfzdKg1876CRcxxV7N8UWc
 Y4qq71D1zgTXZI4X4vfggs6Ze40olshB6xtsF1MHfO/8+K4q22vMCVchOcG1bpc5uJey
 lRsump5Ae7LkKDFb6DCmPs7oLz+xceSOemXUOBTF3YklQXr8skN4Y+ax9rC3YS+T3+5d
 c24A==
X-Gm-Message-State: AOJu0YzAvSNytzwKtGl7GeelCA0OuTAf6fNBIK+wiZY6NiMOA+2KCYny
 7/OWTfUT6y0VQLrgjEX0AXm+5IlYrb+OKvLP0QCWbc4UJIkvSialog1BrVH2kLknFeNDjGKDgri
 Z
X-Google-Smtp-Source: AGHT+IEi7E7s0dSSKIGTF8Tk09FtgjHEsSImrbEyBJHjXPOn3ooykqGAWGpSs0/JnTgGed2faWCPhw==
X-Received: by 2002:a05:6a00:2ea3:b0:6f3:1be8:ab68 with SMTP id
 fd35-20020a056a002ea300b006f31be8ab68mr4864206pfb.32.1713990276207; 
 Wed, 24 Apr 2024 13:24:36 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 fm8-20020a056a002f8800b006ed059cdf02sm11862015pfb.116.2024.04.24.13.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 13:24:35 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 mjt@tls.msk.ru, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/2] target/riscv/kvm: remove sneaky strerrorname_np()
 instance
Date: Wed, 24 Apr 2024 17:24:24 -0300
Message-ID: <20240424202425.534338-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424202425.534338-1-dbarboza@ventanamicro.com>
References: <20240424202425.534338-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit d424db2354 excluded some strerrorname_np() instances because they
break musl libc builds. Another instance happened to slip by via commit
d4ff3da8f4.

Remove it before it causes trouble again.

Fixes: d4ff3da8f4 (target/riscv/kvm: initialize 'vlenb' via get-reg-list)
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/kvm/kvm-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..ee69ea9785 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1054,8 +1054,8 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 
         ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
-            error_report("Unable to read vlenb register, error code: %s",
-                         strerrorname_np(errno));
+            error_report("Unable to read vlenb register, error code: %d",
+                         errno);
             exit(EXIT_FAILURE);
         }
 
-- 
2.44.0


