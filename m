Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D7CC56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws18J-0006mp-9q; Thu, 06 Aug 2026 12:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18F-0006kc-7u
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18D-0000Id-Pk
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso23476135ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786034384; x=1786639184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkXaE1LdHjxR5+SLCaE45VZ8+LEX5aQ8OT/h3czPRdQ=;
 b=Dk0219ORsXC3x5e9ZVgx2K2UTAg2aQyiXAj58ZEub/ifZ7kCTvpHlBmP6rbWJwH3xp
 OfMFnZHIE6NVvDkWPKyw0YbqXUvb5rM5K6n0rOCV8OngSW0xMvyET9o2jd63ccOa8Y9+
 zFqiwVUqWalxu8nlYLxS6c5ApckarXNgVLsTOIEw4kUXpQJhsquFV/0kcIpOIteMuNIs
 kmgM6lV4RIzNFRE6z26RrG4qp2MXmxQH324vcSdbiMYNU4dv4C/FSvV9qdjWMSpscB2L
 xVPMP7JzSSTZ53doVKuMLIe/NApq5+tKYSx30JGa6riMt+8uK2cFdkmggPkHARWZWFDY
 ezRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034384; x=1786639184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EkXaE1LdHjxR5+SLCaE45VZ8+LEX5aQ8OT/h3czPRdQ=;
 b=spQSawp8//67SLn8nJ4u9xFt3IkGkr7iXzUEJmIIhbj11EJ7HmZJp2OdZjOp1i2kM9
 N2Odr6drMHkjx1GlEhtImN1rSinEHh2JClbBtbKUDyIkyMtj+fx6jx9fOr3DVlnvuQfR
 GvSFlFJAsVWVfMX3DjkGF/I40+fPRIjPGrZQ5Dly06mK+K6OnZnUqyp2PJ7wTsvz9jOI
 UY+M4kzKHxRYkx1WWw7uZx5pmamYwgetTxaEn3jrUo2UXSmT1AKYOujzlV3IHrnSG0rQ
 E1Oo7NiodUYTX01hfZ73jZ4mQnS65LuG2G70RPWSzgJJPMRJhrSKHzZ1nToCeUMmChlE
 3DSg==
X-Gm-Message-State: AOJu0YwYM6hC4pR9OO66VevTZ5QDXa+wDk0Gl00uMh+Yhp5mpx3VflyA
 790FooDiCrOMC0foAa1H99EqHyncpYrmS0/ODwDX4AfopD32n8f/UY/5n7O6b+JvZVFif7cehoz
 qHP6+
X-Gm-Gg: AR+sD10AG9HSte25kbDJLvq2vbd8oOnr6uOb0BdtxoTjD6MYN5eeO0le08Fv1U1EK20
 ZhwDsW3RHNbVjtFoCUV/i3KJT459C0/xuMY0O8iyGil2zBZuWiXeiWxDatE0bHHWvXvxPkjaHJb
 ntwWvl3JPQbfHFkBolkUKoW5J8uGrYtvQOYcqXUxrahinOspOWjPYEunby3ZVjZSVY5Yfso3701
 cgKq14IWRd5I9c7SdEcjyuZg+5ppIF6aIVnItIBt2lXhig4TsJTYCyMopBgMvitvtJNEM7+I9QT
 AsKc0G3o1Wwi6QkwE6+PJ981yTlJNY/p6S3ZgHyvKV3cAn7nDUJ7nydyrXyVV3ugJYSLug+Pq/p
 B8e6bphndfZMCB2m/frH4Bsb6PyMJ71R2LQRxOkPQn5IFTyzoEw0U6c0PKkVwQIcwIYJWSjXRQT
 Ovzcxo9mIXgBYHeb+ytD4Q43VfUJPBMoVQYBw54c5uCk55GIlhM21oj1ooctv2s8DRC80VPyY0j
 xaI9qZMVJdFlqm5xac1
X-Received: by 2002:a17:903:90b:b0:2ca:ce92:6e44 with SMTP id
 d9443c01a7336-2d0ca7b0926mr202890265ad.8.1786034384336; 
 Thu, 06 Aug 2026 09:39:44 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4ec8c7sm34280735ad.80.2026.08.06.09.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:39:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/7] target/arm: Sink aarch64_aa32_a57_init into
 aarch64_max_tcg_initfn
Date: Thu,  6 Aug 2026 09:39:36 -0700
Message-ID: <20260806163939.328201-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
References: <20260806163939.328201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-max.c   | 3 +--
 target/arm/tcg/cpu64.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index bdacfb21d3..cfcc46eb9d 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -203,9 +203,8 @@ static void cpu_max_initfn(Object *obj)
 
     assert(tcg_enabled() || qtest_enabled());
 
-    aarch64_aa32_a57_init(cpu, aarch64_enabled);
-
     if (!aarch64_enabled) {
+        aarch64_aa32_a57_init(cpu, false);
         aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
         /*
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8a3ebf6321..2c0b7c1be4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    aarch64_aa32_a57_init(cpu, true);
+
     SET_IDREG(isar, CLIDR, 0x8200123);
     /* 64KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
-- 
2.43.0


