Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905ACCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbf-0004g6-6W; Mon, 22 Sep 2025 14:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbU-0004dP-IM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbQ-00043e-Hi
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77f318e12a6so995977b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566970; x=1759171770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNYeSBUI+ChSA2MN6MhEMZp6PedkQrBC3yc/qlTcbfM=;
 b=C8zULNPnBYfQ7fET+ThH/lTdOTQ+1N6qbtIvyCYs6dwUUlwV4brp0cxbLy7Xmb0bv1
 XhvcTAF8nabJIA8BV7JYeL8+zZByFnkAMVX/LAkhSc9MjWJci9x6TMyKTGJO2F3NYijd
 kxKXkJ0thitERLW9OoDLb45VAxOZZI0ge43pTL2oAUY+iIiHU0ttHsRsueBhiFCNXn40
 31olUERn6lObtMU9ERYjFCBAoHu5cGjBAgC8kwllq1AetcqBmypGwAe/B1nSS+nEhpUW
 NWWt272JQdqBteVcWjtOI8KkRNp/2PgKxLvHrxBKA6KPQV6QqYcjH+ucicTpwR2//YJz
 NUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566970; x=1759171770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNYeSBUI+ChSA2MN6MhEMZp6PedkQrBC3yc/qlTcbfM=;
 b=CHnqhaKLkKoEOYjrDHyzJpuCafTNwRF0x7D/A/YwoCwB1QBALevr+CeQczNHHOR7zO
 cA7gA/vXwfmhUWPJKgdT7LbvN+4/MqQFChvKapAnZrq6h+0jWRa7KAnOIT8YriZl2hDm
 DNCbWe+B8ZuqQyTLalu9HLfLUVjKESvWmFDW23b0xPKIB8dbS6jBmX87LgSGVADVc8u4
 Tent9b58GaFRbQTwWxydWdDlSQN91MXJt79hXLvnNfInZKXmgoeLB80oSscRGJTsVBYH
 EeI6U8tPbmHpzCB2xcs6Th714SoSRQUREwi/k8ZqiNoYWdac4ZN7K6P/oAAnodAuB3+t
 R8Rg==
X-Gm-Message-State: AOJu0Yz2zRc5v3tZKO2N+yq9mT/5UUjE4Urgwl006fNF+1hV2M1b8QTZ
 JAkWbyIG87uEq2EG61C4Ciz35zPN0GBp2lweK4xHSqdYkn6P2OnT0pQKORmrCPgk2tD7ucjFfD/
 oMji0
X-Gm-Gg: ASbGnct5obWfcu1msYoWiR23s3F/KVVxiA+NchG0MhKUJqVoDeHdPA9/usTe5NdTvLo
 Fr7VfE1BRjdtrJY57Nun/QQ4+jJs8TYhJbDTHXDPTRNsVILnXbjqqXppATUg8kWFYSXrO4lEMrV
 W3YeSLOS+pNxIanGPyjbyswp5T/Q9f+YhymzUr7asHxux8zrT1RrpD11H1FYCJw8jH9iE+NCEe4
 dBOREOvotPF0WxImxQ3+EzD0WfBMd9HFXb5xQkvxOQAcLVmb3K+G9zIiu9MIemO6m3Vucn34cLO
 OUaJXJB8FrjKRMPikJvx9Pz7BdhX0gkv3t3T2Y/7z/PACwg8kq7LHYAMz2T8GZn14Z5ZmnrMyEg
 yt3K9dT2Dx5rgUjVgSiRZ3FKAPAzn
X-Google-Smtp-Source: AGHT+IH+EoRSG+hmD/8rJwDIR/miQuHIJVEbjBkhqUdph9DB9fZK/YU5WLlm12KB+AVO9Ij5lPx9PQ==
X-Received: by 2002:a05:6a00:1ad4:b0:77f:324a:6037 with SMTP id
 d2e1a72fcca58-77f324a7a52mr5595642b3a.7.1758566969337; 
 Mon, 22 Sep 2025 11:49:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 02/76] target/arm: Enable TCR2_ELx.PIE
Date: Mon, 22 Sep 2025 11:48:10 -0700
Message-ID: <20250922184924.2754205-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c60da6013d..5c3805eaff 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5891,8 +5891,12 @@ static CPAccessResult tcr2_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -5900,8 +5904,12 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
-- 
2.43.0


