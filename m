Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3393ACF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQeo-0007SI-2b; Thu, 03 Oct 2024 14:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeO-0007Ft-1u
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:11 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeG-00052x-W3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:05 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e082bf1c7fso993746a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980438; x=1728585238;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suiGAQRfyMh8K1b9uLibp1VRaeCHB9aUrAtUyQNMeEg=;
 b=zrLfwGKXi+nNj+Bo3S33T5c3mrUAX+V3B7ju9taGPq3H0TsnC5O/CyHFyzLzMOb89M
 5VYrSRm47ISZkG+fiV1wckI48371/nD2JreI7ggXE+EH/b8IChT36EZZSzF36ETGv7Hh
 ijyfjCiZFWGiWoN7HbTjkHcJD7aYLd5F0OlPg/hU5SsSPoPBRCzkjwRjItloGyg/lt1/
 qaPVmTALRPKDLBx7XDFlCg9vQ5okKvrxl4WLN6/iNVPHSaAZyBPeUvLBPFQkHwi+cwZd
 snwZazOu4PXPTRZDBUcdHRYfH1OAAOO1etc2Hs3Ze9MMw4yfCjhqFM+vugW970DU1cIG
 nD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980438; x=1728585238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suiGAQRfyMh8K1b9uLibp1VRaeCHB9aUrAtUyQNMeEg=;
 b=Ss5RFkATdBZEzsljfp1GL16UczKFncon5/K+fJO/XnBsuaRI2HkZrcKAkmM7p0SLfF
 H9DFgHrAfk7ZE56SfbMqmQHYTyWlODmTdk6q8PmpEz+N35BI3A+m4ks/dnHqe8Sd8DCf
 GHG+zMom9H8fuk4mduFhTYJq/Fx+JIDJ0EK0VmMJUQfBnYiSKTqZEk0+TjhC8JvoVxr0
 IXP5RoKczp83/sLtTgrGMqVro3ayVgcxIyhgkq1tNi88TB2qeoXDy023kPQZxD88SJFX
 bDdqZeqp0pFQMQBQOCT466lSizO3uVusk9Z1/FTqgn56amtSKXOubUyq4XdAt257sZXn
 +vmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi8x3iOwlp8shZMs9X4+fID6c63OIw0phqyTQnFkz0smxKDXHndYH+zVCwVmgEiw3l68x2qLLSdb6D@nongnu.org
X-Gm-Message-State: AOJu0YzDbeIBZ6lknXrvMTd5Jn6fowT7adShrCxKwVs/+herIpzYydsI
 R2QmIx1wjrdIvY2wSBrc/gRMBOWU8a2MEkWreMeCNDJF6jfO6NaNUUr1EVMHaGY=
X-Google-Smtp-Source: AGHT+IGu6xa6xK2N0k9ZkJnnMIgCKP/MwQyL6iUOi/wkwbe5gApewvrZ3r6kPyDDRw3D89yXMlfV5A==
X-Received: by 2002:a17:90a:e60e:b0:2d3:c976:dd80 with SMTP id
 98e67ed59e1d1-2e1e63c0000mr15147a91.39.1727980438448; 
 Thu, 03 Oct 2024 11:33:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:33:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 09/21] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Thu,  3 Oct 2024 11:33:30 -0700
Message-ID: <20241003183342.679249-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 05f727222e..135559fc95 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1469,6 +1469,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.45.0


