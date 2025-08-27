Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AD8CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jL-00042l-LS; Tue, 26 Aug 2025 21:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hb-0001M1-Bl
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hR-0000CC-Vl
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77053017462so2570445b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257100; x=1756861900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0SOJUj38Cm9fmgkJjIjX/37+2seZZfp+KIwKY3yN64=;
 b=dEYHFAovoENHh3pcnJcpmgwkKgpyv9l5L29SCIYvfe2dkpf+IhG4Y/TX099Lp6LTPZ
 Ge89DgwwBuvXG2V4N4ip7jbW33l/GNYrDwkA0iaCs01/aS1vfSUToD3RnZbzhLJ5B5r0
 wA1NaR5IDVP84et1U/6nDZv+u5pavs4IYwHa9VlHaz3lao1Qye/J77088ACJ9N9yPK/I
 O1W/yMfWRdnKavSlXf35KEWqY5hbc7x8w7Zy771BwwUv29TGSO+P4d4/9vmAlBfZvlN5
 XLUyay74JEPsgxNi/YsoioIRRaRjufdG2I/IcmTL97IXT2WEf82Jcr9EQ+HzX2JE4jxM
 3crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257100; x=1756861900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0SOJUj38Cm9fmgkJjIjX/37+2seZZfp+KIwKY3yN64=;
 b=Bl9YOfDIokOwDA46YeuPULiGK7pplfE4QzGHGAm66En6T9Bqt9QTzsleAoGwc1msxC
 NKCA/xEOSArbnyUQiMl/yYQjvLlI+5+VIJZ4lWCPZzymRpOCyYo0Jo+A/nXOY2I/I/FA
 AwnDscKSNL3BAmUG1AUjUtEyNnAVBl3HzFWWzn6ZZXNc+U6G1Af1Vvw4vOuaVdqGXnup
 zlXrEG7erZrcCPChJWyp9+ne0a5pW3I4hqPi3fa7MsI5XLFlNxQUDA7KoNvJEvJpEZLj
 L9V4zykcaAFVXC9VTm4Ur4pLrJRZwe02OY70KdTi8E7s1mf2uQWJm71/hOmGBGo5poIK
 RYSQ==
X-Gm-Message-State: AOJu0YyKD+lEZZR3Ym7KoEyIhSR2t2QNFsKEkFQk5JoWUK1/mZl8pkyK
 ms8WuKQoG7p1f4lLGS9r+b4vBkZEw0qlwU3ZK8bHTi61Dzs0RyiOYFBlgFN9QhWlrotqSF7QNat
 zZuFwZQQ=
X-Gm-Gg: ASbGncs2bPhJqgzobilfux9UDbpcHPM3fWwJcoC73uXRGZSGK0/WUh8aobdtSN1Tx7t
 dBXL7WQm1UubhOsP2ZkVJH3XvynPuGisgCsCgXFZaU9jnl7s3Tsv21YGbiNKiqGLfsXpJeoyIvf
 +VzH9ciYHQWwjoxDPqp7FFCiQLgAbMgtYBKj7eFoZmI4MzsLRaaDWfHTJuEHbSJLUv3ZIRlnAck
 VTvmWq5XuCLZkP6ABKc68J0bf3J8JTTHcboXk1BxqjQYMG5XgQt1EnVgKOYSsZHYo6LBLYIZWBl
 upuQhQ/cDQCGUFCRFXnLMD+k8AxtJXAJcmdVgrMJCCbZrkdL5HRC9+/4RPqzb22mS4GJ+AKPFmd
 dRiUI8Uge8hh8a9rx3Qe7UUa7XYHM47D+FDtD
X-Google-Smtp-Source: AGHT+IEguu268E/bLNIFrGQE3A0kNMMNWLSwhR7II1EAMwXpC4yq+UDO8pOSB+99KDwMsnybCClzTg==
X-Received: by 2002:a05:6a00:400d:b0:770:3b56:7939 with SMTP id
 d2e1a72fcca58-7703b568016mr18884173b3a.2.1756257099742; 
 Tue, 26 Aug 2025 18:11:39 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 49/61] target/arm: Add syn_aa64_sysreg128trap
Date: Wed, 27 Aug 2025 11:04:40 +1000
Message-ID: <20250827010453.4059782-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

System register access with MRRS/MSRR use a different
exception class.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index c48d3b8587..c65678e820 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -45,6 +45,7 @@ enum arm_exception_class {
     EC_AA32_SVC               = 0x11,
     EC_AA32_HVC               = 0x12,
     EC_AA32_SMC               = 0x13,
+    EC_SYSTEMREGISTER128TRAP  = 0x14,
     EC_AA64_SVC               = 0x15,
     EC_AA64_HVC               = 0x16,
     EC_AA64_SMC               = 0x17,
@@ -169,6 +170,15 @@ static inline uint32_t syn_aa64_sysregtrap(int op0, int op1, int op2,
         | (crm << 1) | isread;
 }
 
+static inline uint32_t syn_aa64_sysreg128trap(int op0, int op1, int op2,
+                                              int crn, int crm, int rt,
+                                              int isread)
+{
+    return (EC_SYSTEMREGISTER128TRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL
+        | (op0 << 20) | (op2 << 17) | (op1 << 14) | (crn << 10) | (rt << 5)
+        | (crm << 1) | isread;
+}
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
-- 
2.43.0


