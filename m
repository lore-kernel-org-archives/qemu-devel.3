Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBDC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U4u-0003bG-F2; Mon, 28 Apr 2025 15:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U4r-0003ac-ED
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U4p-0007Lg-SN
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227a8cdd241so71922565ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745868218; x=1746473018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1/pH75J2ESZ3iYPkpvn3hHXRSZ0chs2dEX/b6rX2kE=;
 b=csfY9g0S/BeqcABWgPDj6oKOpayqw91K9EUZmYEntmiCewp2EiyoqkgRk+Sw80QDNz
 GKEogqRSY+Ixdu6ryz8u9SRFpQU06HRytsYdhxDpo3dnavqwqLqwwskPoUu0OCq2LmDP
 QMrN0BRkEqj9dU0BM+usvYI+pVIc0fKkpqS9My397kpV8ixp3g8bhc4B6XpVrZgm7lQp
 pmWqJnXaFNoO2lBwz8NIongvzNR6tNdEO/pVSXgN4mjWHQTSRqNtbSUKYfFKXWRV1Ee1
 /LN8rBZ5upFMLTVDBXneEOqYIX/poVJ38RNuyScoYjbqDE4JKDMefZQqOYGm8NtIB6Pp
 0Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868218; x=1746473018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1/pH75J2ESZ3iYPkpvn3hHXRSZ0chs2dEX/b6rX2kE=;
 b=ZymjcNR+Y06l1a+lj6bQw6kqW/wSWHHZdarMbGV4wrOgoesSAMTldUNPEAoPEBgDXi
 wrcvU022B7s3a2F63hceP10WUoRmCp/0yqkincj0peecH7lO57X9QNSwUOieqHK/HRD7
 gdJNs98Vi77dH3XUaaKMPkli5B+CbiML9PBPB+sO+ma7M2hapVpnVZ7bKDNl4Z02r7HA
 dMCkDvotyFpqtaTSGiQ2b42S3YqFvmPW2YxMqmSGpkJBjJs2rAhq9a+nRVE/iReBC9M+
 QcruGfK5BnAZ9W3JQcyvQK9rmHogT3j97kof03j+rCpAW9S+oh258Nxe0UkLkRlLOOIs
 AL+A==
X-Gm-Message-State: AOJu0YzA3mFcBL/GTnetR6+TvibpPFXCmNgAKhB28UIsg4JSOBns1m4X
 0sKWCrdJZVGkJzeMXKPKi7tfvtkuzKwz7+jnFTv3dAQt2264h9spUBEFjfy2Z+UOxoCkXpm3010
 8nxM=
X-Gm-Gg: ASbGncsWTf38B80xSQ0vDqYUt35C+lBKnXr3lte0BaKfUqgP9LDKEr/Dt/SAv3WtLfp
 qrmXMTeG9clC4VCIBnzaqx5MHWJuUrAWGs52MAh5xi54bH61JbGP2vLizWfUqqzvgZk99kr30SS
 gcDFJBJ8SI9xhMJoFOP8wAGrCZXiT/XBhcKaO363LKX3PG/wUV9j7x0iAckUTCM2FbNXn5f+hHB
 VMOx/9tZVTboD8ep2jDVzSylesvBmLksbJuWBcf2wEpvMNkZ5M7X2kR+8LEYp2QmxY9ZsxQC4dD
 v4q8/XnaNHhHcSh88ueRyjuhsqJ/hthCKNZ191ZRKA2G
X-Google-Smtp-Source: AGHT+IGQ5uaMjDM+16axjbLvKduJnO2eraC/lCrrvq1x5/JwJi2ecPt66l/e3YE9f1FtNdLALw+EXA==
X-Received: by 2002:a17:902:f60d:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22de6f7f842mr4167515ad.4.1745868218320; 
 Mon, 28 Apr 2025 12:23:38 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4db99d3sm87300565ad.53.2025.04.28.12.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:23:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 2/9] target/riscv/kvm: fix leak in
 kvm_riscv_init_multiext_cfg()
Date: Mon, 28 Apr 2025 16:23:16 -0300
Message-ID: <20250428192323.84992-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428192323.84992-1-dbarboza@ventanamicro.com>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

'reglist' is being g-malloc'ed but never freed.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index accad4c28e..6ba122f360 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1119,10 +1119,10 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 
 static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
+    g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
     struct kvm_one_reg reg;
     struct kvm_reg_list rl_struct;
-    struct kvm_reg_list *reglist;
     uint64_t val, reg_id, *reg_search;
     int i, ret;
 
-- 
2.49.0


