Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF62D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifh-0004ae-Of; Thu, 08 Jan 2026 00:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdife-0004Xd-R1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifd-0005xr-63
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:54 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so26868095ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850492; x=1768455292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B/4oj2GsZJcXpd++hq5CTy6xeZctYxVL7BQLCGdqiBo=;
 b=IkBUakBtwY7cpt8WPKC2jOVysiAOppZIeylXQxPL0m9JfGfa1re3jL3CuamTAVwn04
 HHoDHmTcLUYMkhjCwdLvl3Q3GlLz+TSPlVjCO/86N8tZtdn13L9H4FYnPvQS8OgfIsFf
 lp/yckwfNMPJjUKB5M9HoudUh2z7TxYnK03B5lubKyCvJ08Nh4EK7xBF/DGpmy6O1UC7
 LbWCVpGhkZZhsE3rlIIFPhUhiHSPXq2QPAt0uhMfrCB9Fby/LiKqS0NR5cyIzbfbSSBW
 QLfGL9TBcSAR0DMwwtIK7VXRVtf7Z/SXEc8r2b/sqNmH3eoWWG6nAKcJgXejLL5Ph6be
 Pg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850492; x=1768455292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B/4oj2GsZJcXpd++hq5CTy6xeZctYxVL7BQLCGdqiBo=;
 b=DrxUzg9iiN92FiQlnI5+Pm44Rv9lSdGr3bYpdwTB0oM6I/MGOecUOLPf4+Gz5XTDob
 XrQ3xZn4J1WWsH3vR6a9jxndLXmAIx3JE0wORWp3dprHAmv/2wY4HIaaW6XXp7ssgENL
 8cdn0WW5KFLH865g6AOJEztcY1qtsxbqlaMJqeqUUJYhVenGW5VkXh1WNDj4elhNTaVZ
 2tebQcHSpHpijVEODnNNx4liuDCUMU5VMmsLpb5DgHfCjYE5k+yB6ALP5Yqw18OImOA3
 pG7PI2PLOKuekskNW6Px3TsyZv8ltOqp4nbDWk1ASnrGUxZrB1uSlBChUMCQvzwJUdya
 gOgw==
X-Gm-Message-State: AOJu0YyoQ5ga/m41XimEgsN3w3dF43r2iS7i5gNJNxyzVyPDrCVip3bQ
 eC527gvL/7GUbhmGu4RtDQosRCXYrJffKpeRUf9g0sQsjIzNDO8jZLLSgCdrn3hWpO6zv2TX5cs
 JOJb3a/s=
X-Gm-Gg: AY/fxX7wJ4IVV8dCMjMiCmFE79ygC1hs6huNJiNmSHgMg9O3M7FeFz8/tniIkalQmjV
 RMV2ykS0a79ySd857oZTKASwyG2Tdwhm3Oquei8mTECuoy97qJqXdFkIgG1UXeIlQzRdYcxrucx
 ZnzF/2j//V4wc5cHPXvsv1vTY5C7rLg2s7uB+EA4VDJ5CVGqECkzUNOzWMGCPRxQ7E+8KFFfHTQ
 lLwFFQzanAwqJqu6wt5Dk8nADvvXnVonfEaS776kbpP0IYyYxYZ/89TuN8kvapPxsy9JzwyoFRX
 8WulplFd+enaQSe/913N8G1fzG/Ffe1SNx7DykVMdNXBNb3S0x7h7E7oY6rctybxyEnFOeeJp3c
 ZZuf9DEKbeOcygTrNj8304tpV6WgbFRBmwIq/uLFkrnY8TGkuSmXSzWj42re1JEtFwUby5jHjG4
 V3iuBtRoTYX1qC5ARrBQ==
X-Google-Smtp-Source: AGHT+IFKz7b4+OBxN58CQKFUVRoI1Y8+YDzwiWmWwKhx/3FJSyG4wNNZ8DQPIFXHta1IbSgy0fX18Q==
X-Received: by 2002:a17:903:3508:b0:2a0:d629:903c with SMTP id
 d9443c01a7336-2a3ee4e8351mr48739175ad.30.1767850491666; 
 Wed, 07 Jan 2026 21:34:51 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/50] target/s390x: Drop CONFIG_ATOMIC64 tests
Date: Thu,  8 Jan 2026 16:30:12 +1100
Message-ID: <20260108053018.626690-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 9e5bd3ed07..cc0755c91f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1814,9 +1814,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
      */
     if (parallel) {
         uint32_t max = 2;
-#ifdef CONFIG_ATOMIC64
         max = 3;
-#endif
         if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
             (HAVE_ATOMIC128_RW ? 0 : sc > max)) {
             cpu_loop_exit_atomic(env_cpu(env), ra);
@@ -1855,12 +1853,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             uint64_t ov;
 
             if (parallel) {
-#ifdef CONFIG_ATOMIC64
                 ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);
-#else
-                /* Note that we asserted !parallel above.  */
-                g_assert_not_reached();
-#endif
             } else {
                 ov = cpu_ldq_mmu(env, a1, oi8, ra);
                 cpu_stq_mmu(env, a1, (ov == cv ? nv : ov), oi8, ra);
-- 
2.43.0


