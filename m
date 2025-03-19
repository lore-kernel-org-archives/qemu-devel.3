Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C3C36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoOv-00081K-CU; Wed, 19 Mar 2025 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOg-0007zp-Gr
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOe-0004PA-OW
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2241053582dso29945645ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371407; x=1742976207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rknrmfA7CmFKA8NZIq2TcdDuCQaG1etacbJiGQO7Y4w=;
 b=IcF+yDQBetWU18Kk9Hf1dv7HgfZX50Itk66rdjms29h3kGjJ8o6PBzutJkDf41pqQw
 AirLxTfoR/LLeoRo4nMtkJSQGfmJC2eM9FAFy3UDJkWCBpXBEXw5V4BOG3YKydcAVjGu
 MTs65iX8eNLDtU+dlFAQ7sfw1WzlLYP5EiLrSlhaPkrAKdpuRlUyMM7vvh/TVpHz0YXY
 nPWHCqRJfxalsD+STL1Z3eRsx9FvPBzymq2WhGSjfhsa98+fOUsx9s93nSq/dLAdD0fV
 EgvuBOrAkFYiE2gwJxnCMbDlp3/H3NGDd/CCxn8ajHNtxoyDkjWQbDXgP/si3hZPsl6z
 Bfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371407; x=1742976207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rknrmfA7CmFKA8NZIq2TcdDuCQaG1etacbJiGQO7Y4w=;
 b=Bs8OENIWMQfW3ay7D2WJKhe3pEzZBwKl70iZEAXEpgUTOJ0/Rmyr+K++YC2Wzp69/Y
 RytVFQ6rK9xQqzmN9ofeRRLsnb+LvrtDud0JJ0tbU5U0zS98gwLJLlp9CjgJWEZ32m3Z
 39KHnm3yqznTWdr+kz32WT3wriuHDK7P/dCFlBnfSLaFGToI8JQTdmY1mk8/yxgCzjeA
 QSvJVatiRWHjrA534VimEW/jgnefqQ6cJ4HewkW5fcJj2mBUEa0Nj2IYe3s5JQbSzptR
 Bldcn+X6UN4aHRFX8R4w6vj4StOuz8FOKKMu5tDKC2SmS6ZZRXNeQvdH9WNxk+czmYz1
 n3lg==
X-Gm-Message-State: AOJu0Yy7S5T39O5vj3qtv9lPVmk6hUns1nDmFAwIOla3N42PzO94rCSC
 +CPjZqJYq5sbn6plOdDQUCOveBwQU0N3BlhA2xGnUEtFGdA0csFXGm0cKQ==
X-Gm-Gg: ASbGncvb5u4rfAoMKjdviRfn4uuUrwH1sqDO6tywZzLw1RQCLSVy9NVphNDVkbVg1yC
 7lvvD0727zWRB8dUiwSEA3R6bPJJ6MsqsmkYUIj9fhP0sNgjPBm2IBXYM5+9LC0Bg2fcfufpEFE
 BV4NePWEmveeqfMRPJBSL5Z7P3tO5GUAdkdpOpfYrsU0bVR9CCTHFsr5fU9/v9vctnxjcFYdMz+
 EAZr1Nv09GdueNWjvHirc2D8oqkQaILTd1Zq7dsl2K05SdHqwxj4BhgStjxgOyQtj9AFZAOc0OG
 w3XgjkqkM5r89eUC1RvKayTG0LDQ0B3wrWOjL0pgpGx5NfZshBqSurYy7I41Xd69gsHcwDUzQtb
 oVPuH+fC0sfCN3ic0M6p7VdEX/im2XeMBIiFSWx2fByX2Ntv2VzIB3c/TgL4=
X-Google-Smtp-Source: AGHT+IGgYO4dctU62JIu13COw8OVTjcOhwwZfRYQDpNNPTAW5FyoMxYyOTTpREIIM57LGfh3sEemyw==
X-Received: by 2002:a17:902:c949:b0:224:2667:8115 with SMTP id
 d9443c01a7336-22649a8108fmr29640925ad.48.1742371406762; 
 Wed, 19 Mar 2025 01:03:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Adam Zabrocki <azabrocki@nvidia.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/10] target/riscv: fix access permission checks for CSR_SSP
Date: Wed, 19 Mar 2025 18:03:01 +1000
Message-ID: <20250319080308.609520-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

Commit:8205bc1 ("target/riscv: introduce ssp and enabling controls for
zicfiss") introduced CSR_SSP but it mis-interpreted the spec on access
to CSR_SSP in M-mode. Gated to CSR_SSP is not gated via `xSSE`. But
rather rules clearly specified in section "22.2.1. Shadow Stack Pointer
(ssp) CSR access contr" in the priv spec.

Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls
for zicfiss". Thanks to Adam Zabrocki for bringing this to attention.

Reported-by: Adam Zabrocki <azabrocki@nvidia.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250306064636.452396-1-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 49566d3c08..8225e9bb4b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -192,6 +192,11 @@ static RISCVException cfi_ss(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    /* If ext implemented, M-mode always have access to SSP CSR */
+    if (env->priv == PRV_M) {
+        return RISCV_EXCP_NONE;
+    }
+
     /* if bcfi not active for current env, access to csr is illegal */
     if (!cpu_get_bcfien(env)) {
 #if !defined(CONFIG_USER_ONLY)
-- 
2.48.1


