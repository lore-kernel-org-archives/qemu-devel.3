Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C22C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnafN-0004h8-V1; Fri, 22 Mar 2024 04:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafM-0004fJ-6G
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafK-00012Y-MV
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dfff641d10so12230625ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097657; x=1711702457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSFo3fIToAxpMkyPRv8jExYnTdr2jvQxba3OkQ37IQ0=;
 b=YY7VDde5wrf1rJZ9hGDIqoqb/84e5admDpIWkdicTlLS+MbCx7mg7bzrQJNqI7Sqbe
 zRKLhDmX+PBRYS/OrtR+HKE1ExfeYw+YQoRcAwCx7n+8SaZkEySwDdWORPTje4yu/DI1
 lsCTQxDE3+RK5ud+m6lnGsCDc5ezwgEuEIyOeJ6KEt6PtTg+spxmsqdKMGq0LuecnddH
 TDueOXYJ0CcdFF+1hwPQMV2nZt4eehgbsTsMOulQIG9gMmS7mFR1NFvN/yLAqVYpabvY
 i3BUjKkr9axoF9S1wosbSIWMbRHLsE8sJ4ps/d6i5FkBpyavAghRlfs3etydKfCLGY4T
 AElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097657; x=1711702457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSFo3fIToAxpMkyPRv8jExYnTdr2jvQxba3OkQ37IQ0=;
 b=Z1ES4rGe64paqMko/VwgB3RuyY3yRZAaGThHUa5R/CjZJQnc1cFnxOXljl68ngvIMD
 EF5/HqVo0i3ZzMPH/bYFsUBfyRK4+1U+knzPoZTb4v99DtVwwgZdaldBpGiv+vCaE9ki
 yoRk+j+lvYjQ4OIpx+xnjr+hUrlphUHGz46bjk1cXzdOmsMOqno89W058N2QFYJZLrdP
 jp0eSdtV4QJZCq/yixayUV4XRdMyMuNLAAWQMZQJ81jA9yhHV76blX6yp2C79jKvHPPs
 urkh0pa31GO3m/s/PLgCV0+rwwOhNVomjRp/XWYgEI2hfLM46heVPC7EXJgee7GbbF15
 wYEA==
X-Gm-Message-State: AOJu0YymYSAwp0xNqK1fsR3SHOOXgyQPFuaj6eLoLbbQ2CuczHmsVssQ
 JAWShFdtx48xcza/gw2Y5g8tVA1qYvbpLVhoA+bTsszKL5Yl7gkduSAaXGTzRzx62Q==
X-Google-Smtp-Source: AGHT+IGaRQNrh8prHyItgTFsN50K1NZ4FsYvWQaiRTBFjhjxiIpzzeVj0AYqYr7f4zRlHPBlcwGaBw==
X-Received: by 2002:a17:903:2a86:b0:1de:ee01:56d7 with SMTP id
 lv6-20020a1709032a8600b001deee0156d7mr1915632plb.51.1711097656797; 
 Fri, 22 Mar 2024 01:54:16 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:54:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Irina Ryapolova <irina.ryapolova@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 14/15] target/riscv: Fix mode in riscv_tlb_fill
Date: Fri, 22 Mar 2024 18:53:18 +1000
Message-ID: <20240322085319.1758843-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
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

From: Irina Ryapolova <irina.ryapolova@syntacore.com>

Need to convert mmu_idx to privilege mode for PMP function.

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
Fixes: b297129ae1 ("target/riscv: propagate PMP permission to TLB page")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ce7322011d..fc090d729a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1315,7 +1315,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
     int ret = TRANSLATE_FAIL;
-    int mode = mmu_idx;
+    int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
     target_ulong tlb_size = TARGET_PAGE_SIZE;
 
-- 
2.44.0


