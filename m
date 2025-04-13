Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0572CC3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 17:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u413A-0003NK-A5; Sun, 13 Apr 2025 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4136-0003N3-U3; Sun, 13 Apr 2025 13:23:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4135-0008Du-Bi; Sun, 13 Apr 2025 13:23:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so3118044b3a.0; 
 Sun, 13 Apr 2025 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744564993; x=1745169793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kPMxH0QQXwTJUC3Nj+M+GWZ2jkGJq/16ZS5q3x5nM0=;
 b=DpN1tKBItgMcAL0u0oYP1wQbiTCbXVgjOc2D51kbPooWra5fiPWrnfntJ+VJoGkcrr
 YSqsAHy2pU/9mE69o8F+Dj6sSXGtYVGtXcJlQMTNWorzArOlzFVUScOY2ij7lGlqjcY4
 N6uoRXLOXVYBLsm97xfjcjrFnvkRaevPi5AUH25JfmA+QXG+jkhUowxy3FflFVMmNE3S
 LEV/0dQTWKSBmpMfVGZFIW7v76na2CeY7pyAhZiXemDGDmyctNegsARud4cEyUbnaUAy
 RHxx3FU1zliGkk7Qo2tZn5kvtvgE21npSNO+tTEQH0mQbXCJwp30Qin0tmTSdpGwKXBj
 q/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744564993; x=1745169793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kPMxH0QQXwTJUC3Nj+M+GWZ2jkGJq/16ZS5q3x5nM0=;
 b=Mhy6IWxJ0Obr/AhBchpy2TlKEvmjeYbgZBRF1jKPK6tW8Gvmcs6VpWTVphcEnCV5R6
 XZEY+Li5ZI8QA39LfdP+Bg7BJMS9uZjq5JnVjc797Y4mb7d5KH1ERK6TQRBfGtHGnatB
 gCvNNHE9aDpKIaqd/5VofG+KI4DGxQ5O5eN6V59CsE2OiZQoITMkvmVU1JF1+m9VCd8Q
 rWPdMusbWEN/3QGCk8PA+ajfamCZKnRX98i7K82ml5E0ZrFtTYsEddOy70VvJbxu6dOd
 ufdh1iek8OgoSSKul2OUr9n+6ROB4H7QgHovsUzReriQAscHOaxU/8N/y5ahLYBHEALC
 ThjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWbPLhf8vvdaitxkemAP0AkTMQwMdRqi7DmOT/6yLTeLKHBA1NRplooYhOb+UuqDTuO8ly6MM6Wfvppc0=@nongnu.org
X-Gm-Message-State: AOJu0YziP5MpImqTZDHa5KGDi6Lfq7W8H0ZtEltiL5sl4fAXHKNHADLt
 MpIchGt5HFWrgYjWXgeCu3c5Q5XR9k9PVBxJ4N9im/YytK/KebOZHbT+gQ==
X-Gm-Gg: ASbGncuHYPcauXtVC27mU2PZxloNfXONwyfiCGyeEL1TFvAjsqDcyxjoa3SY/mNZV2e
 gUmAvhdDGpgUs62FYvGwIODK9d0G6zc1ZheMEj4KjgflEsZ+ArhX2kKujHH/piusJSpKOm8uaNA
 UUrGCQIeXdBw2OsSaMXa3ZkeMGBtDVapOANWFGj28aOgVjje4yqOORJJ1cuGGxZZ89uG9VLQB9X
 0t19On4L9805p/w70YTWcgqRmFlKxnRKJhZPvyjU5Hdl0QPCbCjsWJWSXQ3ig9bjqG4MbT9dYwx
 2dH8wCOxwN4UZSbCxD3rzvBorbE9V7McqTlVNyQr
X-Google-Smtp-Source: AGHT+IEepxDfhKSuML9S/BGqQS72Jiq7fXGEF32QDgsiYGUS52+bmdCmI5scUoyByVS1X2ntHPemOA==
X-Received: by 2002:a05:6a00:a03:b0:730:9946:5973 with SMTP id
 d2e1a72fcca58-73bd1190df4mr10778444b3a.5.1744564993181; 
 Sun, 13 Apr 2025 10:23:13 -0700 (PDT)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e4adsm5381989b3a.142.2025.04.13.10.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 10:23:12 -0700 (PDT)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: ziqiaokong@gmail.com, qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org
Subject: [PATCH 1/1] target/riscv: fix endless translation loop on big endian
 systems
Date: Mon, 14 Apr 2025 01:22:42 +0800
Message-Id: <20250413172242.3430944-2-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250413172242.3430944-1-ziqiaokong@gmail.com>
References: <20250413172242.3430944-1-ziqiaokong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On big endian systems, pte and updated_pte holds big endian host data
while pte_pa points to little endiaon target data. This means the branch
at cpu_helper.c:1669 will never be satisfied and thus causes an endless
translation loop.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c4391d96b..578927ec9c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) == MXL_RV32) {
-                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
             } else {
-                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
             }
             if (old_pte != pte) {
                 goto restart;
-- 
2.34.1


