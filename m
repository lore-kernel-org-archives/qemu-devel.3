Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB73D18138
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Pg1-0002VZ-6F; Mon, 14 Oct 2024 14:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfo-0002PW-RX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfn-0005EH-8D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c693b68f5so45654635ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728930002; x=1729534802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UlgVHkwKGTt/HliWn6Zk+mUDRsjI7gErGu7jFQYYQY=;
 b=DgH4HJ5BUXSQcjX/7DeJzpta2f/M3RnihYBsOGV6A7f4Mbma/ywTm5afPIET+RcoNG
 iRWHCO8tdU+TFeU9cAEHr9sIM4p004vUFZJca0WAf4pvl/BSv5E/FQW0/6QYwfOLVU+G
 EpXWbIHsu6O5gpFBaPIkWDCKfoVNKcVIFlrrd0mummQiTJ1cONAHgmOanmoCOh8Qam6k
 bkpHC0ur6D1glNw+nEfuKi5e/GsBsPZQ4tsalhcH8BfNTjIeMbfbQm9GfSL+ZqSnjfR2
 l5qZ1LTWQFU0bloC7t74DcNzHSVt9ngaq0PTXeKxA1gVaTEACVv8d1h/js9obEIgQXgp
 pF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930002; x=1729534802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UlgVHkwKGTt/HliWn6Zk+mUDRsjI7gErGu7jFQYYQY=;
 b=k9Z3cPK1/IuXu7GSwIQ/viEN774apBYUtWBpfb4KPBQAE4Bm2LF4S1+QDQeRAWVuZc
 Kd94xu9LwnXdAGx9jPDURKYbDsJm05rlC3BGGIvblsqew4jkd1NKZAcByJaup8FrylMs
 vDqlwJJjsJl9S5mK6wGd2hkChh+WVi3UMaVA9Y7B0W6WtTGb6SGiV3i4Nt+RkU2TOgEl
 RyEpSOe2X+pZBIHErzPqGwKkI7u9PRxDofpFB5DdfrxWiSjOJIMXP05BsM3ZAboQ9Iar
 HQvu+PCNgV/8BdXqsn+2IiHbCSuvimPMwrT5Bmt/pTBm5K/g2/m8Ha0mHORIbjY8H8OE
 dLZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcuItMkHt0vmIE2RgHE1Q1bI+viy/mQNYHohkkYUSnqpA+cjk6hcHvR9fIfArOOIFE9zD9NWvdUTEW@nongnu.org
X-Gm-Message-State: AOJu0Yw+sgu5C1vXSk4QqOhUNUsVCnfp5ATfRtATbcxca3KLyfYsRh9k
 zyr1h8C6CzGGejhICdaXDY/DyFN9uVAiQOMuNRD9hGJuYhW1REQj9pP3D9EucXw=
X-Google-Smtp-Source: AGHT+IEEAVy0LChr/RhbRy065DoZ8Mvp5l8GFYQkXfXaBpDRK6zHsn+bNg42CZjMRVQ5pRzyAwYVdg==
X-Received: by 2002:a17:902:ce91:b0:20c:b274:34d0 with SMTP id
 d9443c01a7336-20cb274398fmr143293105ad.46.1728930001970; 
 Mon, 14 Oct 2024 11:20:01 -0700 (PDT)
Received: from fchang-1826.. (1-169-245-242.dynamic-ip.hinet.net.
 [1.169.245.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c375d0csm68964525ad.304.2024.10.14.11.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:20:01 -0700 (PDT)
From: frank.chang@sifive.com
To: 
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 1/5] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Tue, 15 Oct 2024 02:19:44 +0800
Message-Id: <20241014181948.1974405-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014181948.1974405-1-frank.chang@sifive.com>
References: <20241014181948.1974405-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x636.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 355afedfd3..092744360e 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -126,6 +126,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.34.1


