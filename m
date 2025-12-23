Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F18EE6F082
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXzaa-0005eV-J7; Tue, 23 Dec 2025 05:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vXzaX-0005e3-7R
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 05:25:57 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vXzaV-0001Or-Q5
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 05:25:56 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so3857583a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1766485554; x=1767090354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDCxx6NDtAwpvWyiilDOnh/wGCIkqTuPNgAK4XZWLvA=;
 b=DDUhmA4bkVjrVF6knRGRMQ20Abbf3Mw0begmeRD1SE/vKeDjcDUkOBq4KDBmrk7TWe
 Tf87vtC5sbTymT/7yb076nPhmSLWnGXVCmnmdkz2NV4cFHg94I/eZfpgP2hXPod/MA+e
 qGTpZJgZmBz9LLAtI+5mxM8Kjdh/AHOe8RwyzF4jO/GREyHpN/0tblYtA0vwH2zawq8t
 H0xvEmYCYsjTmqEiHM+iEo4jdOjc0zqzJvO8vI7aH2SSN7ZpGnBMHO49kbLh3aKnN6gD
 XpbC31B7D4tlRhtPHiX/x/igI2/3w8crBR/+BWZAD389uYwR3A5Th7nbrvCuM/ADNtwg
 1KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766485554; x=1767090354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDCxx6NDtAwpvWyiilDOnh/wGCIkqTuPNgAK4XZWLvA=;
 b=arIioRu6Qelg8wML8uC24LesqLFkHGhtXki4la2ZZO8S4iIh3+h9rcAV63b4aK0Y+h
 8HMrP1sXnbXD8R0j6CwuSic04HSR7Sy4n4DiFK8KuJZV6qbA92iznAMyOGNKwX+nisqL
 gnKDrCeeFmBAnquGFB3m2KkxpGfAvJ/LoCbmH+C9QUdoVh4v9f+ENhxh6/LBf9opt3c+
 I5dfT1FQQflgB5AeUcqIas3ouS40RO6hi7+OJayK0M/3aIq3PKYTm3ftVC9kWO0Ip9Jg
 CDBumFwKb1Q6h0EUAEFZHcPUY5/VIKUV/9f9w7YZ1hSfWgRf1FVsKnkn2ExMEI1gDVNd
 A28w==
X-Gm-Message-State: AOJu0YxkKtTJRTPLTIcAczHYJoMVeOrWh/+fukAWmqImSP/7ONgeGnT/
 hIjKmDgxB2ANuRlIxflZnpC3Tqt9xHelMbfpbQh9GENjZwvqYdTkLwvRNHzxOnJMVplePpjp8Vc
 10hJgY3O2mstFjNy4eUMtOUfPwl1dOSOiHeyRCticduin6nXB1YbtxChJlDIMufwfUZTOB+hif3
 kM2nWlqucCjan+JVjvVaCRNkXPRu9e/bwVHte/wm5l8N8=
X-Gm-Gg: AY/fxX60Hsj9VtVhCWOQu3MtK7RXBw2oydJlCqiXtfAKzRwa/blnUAgoNkN8rShDyHJ
 5iUDrvzn2N8GFd0C+Uojo7VqX5IIBNpyLZXawcSfHgDvtJwm2ceSM6INbb9L/IXTmV1oZM+EvrR
 0DpYOZz9lXU166KpTO90X/euJxWkE1DZZIcn/w28GacBrAQMEQnDQDNFEGoKscqz4GhkgAU0xeB
 3e0RCqOEGeG/vGm9dcAUocABD74zdTQDf2+GT8TnYXVP74pqGW/Z6HN2c+jocK7GeMTnDQh7uk1
 N7N1GbCaK032ZsdkWSODyB6M5D6sDEwSNHk+4uyEwX3YIEL2mAzuMRU9MCBDk32W3b+f8j8P4M5
 7m6B3CCpN172HiWj06n2vQqx8LPQOurUG1VnEyMGljI7s9p7h2d0mpp1qg9oBXamTnIkL2VDjsr
 vfRsILJChOU3KI3m3oxGSeEhqwzUJOBPM+hNL7/uOffObmEQLo1Q==
X-Google-Smtp-Source: AGHT+IE6oUrMIYO/whVjpays1JmUG7g7sluWk76HAMGB5UwKdClbUMlLiW9s34JlyCsadOI54917xA==
X-Received: by 2002:a17:90b:548c:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34e921e8a0fmr10036038a91.32.1766485553571; 
 Tue, 23 Dec 2025 02:25:53 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7bc69728sm12092834a12.19.2025.12.23.02.25.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Dec 2025 02:25:53 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] target/riscv: Align pmp size to pmp-granularity
Date: Tue, 23 Dec 2025 18:25:47 +0800
Message-ID: <20251223102547.13337-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102d.google.com
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

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it automatically aligned
to the PMP granularity.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/pmp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..01b337f529 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             uint8_t a_field = pmp_get_a_field(val);
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
-             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
+             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
              */
             if ((riscv_cpu_cfg(env)->pmp_granularity >
                 MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
-                    return false;
+                    val |= PMP_AMATCH;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
@@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_NAPOT:
+        /* Align to pmp_granularity */
+        if (g >= 2) {
+            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
+        }
+
         pmp_decode_napot(this_addr, &sa, &ea);
         break;
 
-- 
2.48.1


