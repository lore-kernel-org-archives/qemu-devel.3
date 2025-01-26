Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F18EC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyX-0005D3-KY; Sun, 26 Jan 2025 02:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyN-00056x-KM
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:25 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyK-0004Lh-RV
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:22 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ebbec36900so2074947b6e.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876139; x=1738480939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syG75RGOgTx5HelHgSXbA5JdmQr+MnA04/L5PwImB2c=;
 b=F3BgYyB4Dpm6bbmRZFbG8KkYpNkJk+BqFIwWuR7XsT9mBbmKtnwNBsZYieYY5rKX5V
 MUxIBqRAvx5yibJxBg27zy/uTjWRS8AEGze72zPeDvKLQDJUC3kj7+XMu0nlvi7u3/lD
 DdadIYLUqZymytK9NfLMh6AwjCMES15xGrogPFNhVVZefFJHRf1pnj60KIlxRSAbRwqd
 6UovBHLQ+ec77AH2wc7XN5HRZcMqOjn9Xgmo8lna+pUEiFCpdCfRt7TQu8CSCrIMuwCb
 gL+bnpf+xA0a1NtvKzVkm1yiS1B1wEKFixoeJW3vfZgFqk1MsSxa/gLJXmqyCmkIxxB7
 jKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876139; x=1738480939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syG75RGOgTx5HelHgSXbA5JdmQr+MnA04/L5PwImB2c=;
 b=Vs6Xua4c6uBHQSXCKt8wQ1mDdNzjEbTEPSksR8j7KP8BhMNvJm4dI0LWq9S+Iozmhc
 yAV+xQvuW154bR15qBnXavJoWbwGyCCxRyA+2uP/UZ935tlOqEZIXimenIY1iEqbs3a/
 bG2cRK0cYNX7CeP528Dwe6qI9CXmnTctR8HGVtE/JqS45TOSE0avnPRBeD9kOtc9tSMw
 70xgfpqL8MT7jyze3MKp2gdUFd2oVKI+ogtlZrEBJJJvRMzx62kWO2DcnpRG/n/Z+1/E
 ufYY1BRBM9DbbSpuCN3utJRhrfj42lOjNUqGbnly+PHBDbqxY5UVGUbsGDbGfOEoLdae
 rO6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpInen5aP4rqOnYd0lB/6P/wxWCxnGXitFfLZEJAu1a3okGr5+4gFzQpmdFx/+HQKaRa2ijoXBFQSU@nongnu.org
X-Gm-Message-State: AOJu0YzOvjSZ8pMcwW+ZRDfruLXYV2azjGh0BdNWmu98EKFtEvPg2319
 Q8PDYqRHdrnT6vHYkaGKDFMq4EYysL56XfT1twN8GTdQUCRnRgttJVFY3CMREgA=
X-Gm-Gg: ASbGncs/5nSNFpeIoF02lnvlkT77wqulEb8cnD6hAKRfY8EENTQG7sYI3vhOT3gQEpi
 uM6omJTbRjDG4tPLwNq1s5IHDawP8Qm7t1TJR6MdXtatboerZPaksTL7zEp1LaHkTRZCLX7WHod
 a+3X7KDF63m+A+TJcP9OK06WEA6tukOXWfVFnOh4FTFLp8RIcNTEqHk9p8C1YZBe0Zk3E6Pl3gV
 GKtdYxUfNVosfLNxk+7Mhf85qsSdbh4qdPj/fNC2FDjMi+3ZZobkDJEaeWkgIp6Xbq8LKN/aUjl
 btKQ7QYGONeGfo4cLnycauynTDGxwn4J/q1Hppi0Pot+al/v0w==
X-Google-Smtp-Source: AGHT+IEvFjjt3Biv6lexHmdsgnDgIbtAfLY+IE2fqpn0uGZuav8odDy0o2FhhqaH61OfWqCgb8Qkbg==
X-Received: by 2002:a05:6871:7a84:b0:29e:6394:fd4a with SMTP id
 586e51a60fabf-2b1c08446cemr21835940fac.2.1737876139474; 
 Sat, 25 Jan 2025 23:22:19 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:19 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 11/12] target/riscv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
Date: Sun, 26 Jan 2025 07:20:55 +0000
Message-Id: <20250126072056.4004912-12-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=antonb@tenstorrent.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 312d8b1b81..2741f8bd8e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2410,10 +2410,10 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 }
 
 /* OPFVF with WIDEN */
-#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
+#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
 {                                                                \
-    if (opfvf_widen_check(s, a)) {                               \
+    if (CHECK(s, a)) {                                           \
         uint32_t data = 0;                                       \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
@@ -2429,8 +2429,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
     return false;                                                \
 }
 
-GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
 
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
@@ -2512,7 +2512,7 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 
 /* Vector Widening Floating-Point Multiply */
 GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
 
 /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
 GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
@@ -2537,10 +2537,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.34.1


