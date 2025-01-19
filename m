Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2532C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtc-0007Ut-Pt; Sat, 18 Jan 2025 20:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtZ-0007CT-F1
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:33 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtX-0003Mp-Rg
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:33 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2eec9b3a1bbso4612416a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249270; x=1737854070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiCiuex1q65Nj+NVM0JcI+vl/Sk/GzVsTBtOgxIPymM=;
 b=F1zCn7eMFrOxU1cfc7GhWT3+1DdqKCEDzyKfyalKkVQ8W1PYXJWVJvGnGdRW9Jxpg/
 e5Co67dGY8jGEq8qAle32L/JV6qyBbFd5Ma9o13794SvA1FnPJe2xbvFIlFGMMW3Lfr7
 /snHkdKxAPZSkk7GU+LWKqR3bkaIY46bOIs81lYEqsfSLSMuQ5PoNrpzB+yTHP1BSfOQ
 32Bsl7cSt8nbLfB1fTYptuRShWIv9dVmKDMkS3bAHuTgejVn88ehqvOToJqBgW6qkH4k
 /AAwMCPcKxu+AQikuWM6U/4Mt1VKZz4V0jYIWx9RpVzdl6I7BvJTgnNPkjV3ln3ldT9z
 5U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249270; x=1737854070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiCiuex1q65Nj+NVM0JcI+vl/Sk/GzVsTBtOgxIPymM=;
 b=M50k7Lt0LQZJNvD06Jc7aAAlQvcgtm0Caz1ycxpSEt3Sl0js6KE7BUvsZReYtiJAjE
 CACzDyReVwIobYcHjr4QDJfzDJvIwHa0R5jo7q3Uu80T5aWr5RkcNdd2CLaw1ZYtRvuP
 GIs1RR4ei+5lX9H/mpmBljuUKG6WYECnHZcrony4jL7akWTLJvGCyjxe/wStlV5Zv36V
 rcBDqL7HNyp/I+Sj9QldMqe+xsYQ/a37wxcKLwKUbW5B0OLoQQB3FxCucKhNpobfO/Pq
 s5LjZTUhSEOLoQB4of3u1/C5oUTrBHFOwKt+6AaetIuBxwbhlgso2R5bDfOyMoH7Tr/A
 LAMQ==
X-Gm-Message-State: AOJu0YzwHNuwSARqSKkBltBEF4skrwEaDPDgPlNprkmWPlUYmolGIvOP
 H23TQxk24SnYBw1pQ4Pw3oLBajyUqjcZGIphVnipHdRWTwc0rUWutnbnqAH0
X-Gm-Gg: ASbGncs5Rs4aQp7NrkQvAr0sNpQtBQSABmzKAF/ga4Uzph6ReYrBn2E9E4Sarg3xzBz
 WWLMu60gFqxzGM2oEy6S+eTiAKGwWE3rhI0gtz9jQ94akD6sJ6nWGfv630cMZl4UJJfaddS/rca
 mzU9glrIzsYqge7Sz2RHPH0puhsILhb2OkiyU8WNbE71EH9zcn2YbbIs1mJYJHViElmHnZE80rx
 eym5yTlnapTl38bc21PPVGErXuu9otU0mw6zuJO2bM84aiXkIgHjvcPl7CQRSDZEm38IIF+TN0D
 Jx/ZbiIkJze5n21YEdkElg16kFGzGtJB9yhL0teuvIC0uFK120bMK82IYsAuplsC7/BO/rKSNA=
 =
X-Google-Smtp-Source: AGHT+IGbMAUx+6V+wqSGZP22RkU6Ld/+off/NMKd7U/A6ePZ52zqVEaZ8pq/+Du/TgAyR90G9CIiVw==
X-Received: by 2002:a17:90b:2d88:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f782c61bddmr11130156a91.3.1737249270115; 
 Sat, 18 Jan 2025 17:14:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 32/50] target/riscv: Add properties for counter delegation
 ISA extensions
Date: Sun, 19 Jan 2025 11:12:07 +1000
Message-ID: <20250119011225.11452-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Atish Patra <atishp@rivosinc.com>

This adds the properties for counter delegation ISA extensions
(Smcdeleg/Ssccfg). Definitions of new registers and and implementation
will come in the next set of patches.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-5-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 2 ++
 target/riscv/cpu.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 4fe2144ec7..561f5119b6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,8 @@ struct RISCVCPUConfig {
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f5772ae5b..da40f68715 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -191,6 +191,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
@@ -199,6 +200,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
-- 
2.48.1


