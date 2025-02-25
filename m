Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886DDC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwRJ-0001t1-Vw; Tue, 25 Feb 2025 10:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmwRG-0001sK-22
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:01:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmwRE-0003Bb-Ct
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:01:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso37868815e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 07:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740495693; x=1741100493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ARpHgUZMwp8raT8BG/xC2iQyd8jk567fSMLDtTYJSPM=;
 b=T6iCDnD+VTBc8uvEiAXyky3Lq7sUUJRCT9GYx7k1nXwK0CO1Tl+fO11ORm0QbNNWn6
 9b8hljobQ083mBRZM1/cWxNGk4vMdO9tJuzt0Zyef3ZmOvN6kTwgWtFe1JlKiKX/VoeR
 /CAsooUA8iqpZ88m/7vtflDNy6JBTmnEZjQNa0i05Yq14pi0rxxHI9E6YmbNx/+HqRyY
 fKXd6YK98Cf22VLVEMTFt+dbvGDlxrPifQrrhfT1FBQiXmumbyHipRvBUf8DW8l265xp
 ciq7kVZAYlVpCruC7hdIBAJ1c1JHd+14Gqj6+mRlHqJ2pEA2wxqNpdYrnK3aisIiEQSg
 yYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740495693; x=1741100493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ARpHgUZMwp8raT8BG/xC2iQyd8jk567fSMLDtTYJSPM=;
 b=O8Ti0Pr2AHk4jpa2dayiaxn7QCf1a76mMo2rpOe9KHaVARK5M2J5fkDXwKD10cJvtB
 ozyUdA3u33/BkZ3pMLc4Inj/PlezsVuH/yTyEsUikXRLA5wyLR57UC+FCT7q9DsRECvM
 26Hg1S1sMPr+yMrv3IWViEHPWsccUAsSGsX+0QLrHdfKvuVijBmOR48t9b7EWHD2xYVI
 T0dGeT6sTTrj0lce12kzzMwDb2DgsA20qvzcskeIFrLf+jJCderaEvaTAKqk8paOwu9X
 VlbpMDIiuxS+yJDAtNPXf2IUoy0jSbqxXpnutKJOqnx0sn/5KG0D5ldWRznbc9R51Aem
 TV1A==
X-Gm-Message-State: AOJu0YzDghF/np92DKNQ38zH7N91jCvqcpcMicp+lID/mnAS3D9TK/pu
 Os0hzpFpdmnOgCMM43fEXpvaBljSiMj9uR0sFSPNlWeYfyT5st80ZHu+DKN0Kcc=
X-Gm-Gg: ASbGncsg/Epn8jWEVDftjR72AJ+fvuYrZ1mUsgdKA4oet4Hhi/l93xXyDH6VDGw4SVP
 A+qHLomQ0Zr5S0Aof3D/QqYqNoZeczN9Odp/9dw17ebzAo8n6HD0A3nlQ9n9t5gWXownmy+JzHk
 F+WE72Vj/lxV1mGZLwmHtlveEfzvDF6c8KHQkBQYkxTQrweg5HTSbPFibG1H4i25aM1XIEvcnfC
 atFfzsJE3tk9rlPiDWA1fIU87SKFmjC8VGl/Hluymlw3lJWdMa9V5NcVfDJHUrUt7XBqZkrAKj8
 Pk6TFoUIsdF32+yjhr7MIwiR4c2F
X-Google-Smtp-Source: AGHT+IHKXegON4JjfANi5MN5dzNLMwFrlZcTCiJrRMyQH+SrHSh4s+zA2IFJhUQKHEXqSK7bEbyPwQ==
X-Received: by 2002:a05:600c:3ba0:b0:439:9946:af72 with SMTP id
 5b1f17b1804b1-43ab07ab30emr41052365e9.3.1740495693354; 
 Tue, 25 Feb 2025 07:01:33 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab14caa5esm30988945e9.0.2025.02.25.07.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 07:01:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B4AB5F7DC;
 Tue, 25 Feb 2025 15:01:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [RFC PATCH] target/ppc: drop ppc_tlb_invalidate_all from cpu_rest
Date: Tue, 25 Feb 2025 15:01:24 +0000
Message-Id: <20250225150124.3497568-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The vCPU parent already triggers a tb_flush so this is un-needed:

  #0  tlb_flush_other_cpu (cpu=0x555556df8630) at ../../accel/tcg/cputlb.c:419
  #1  0x0000555555ee38c9 in tcg_cpu_reset_hold (cpu=0x555556df8630) at ../../accel/tcg/tcg-accel-ops.c:88
  #2  0x0000555555bc29e5 in cpu_exec_reset_hold (cpu=0x555556df8630) at ../../system/cpus.c:208
  #3  0x00005555558932c3 in cpu_common_reset_hold (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/cpu-common.c:139
  #4  0x0000555555d480b1 in ppc_cpu_reset_hold (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../target/ppc/cpu_init.c:7200
  #5  0x0000555555ef28f0 in resettable_phase_hold (obj=0x555556df8630, opaque=0x0, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:162
  #6  0x0000555555ef24f4 in resettable_assert_reset (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:58
  #7  0x0000555555ef244c in resettable_reset (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:45
  #8  0x0000555555eef525 in device_cold_reset (dev=0x555556df8630) at ../../hw/core/qdev.c:239
  #9  0x00005555558931ab in cpu_reset (cpu=0x555556df8630) at ../../hw/core/cpu-common.c:114
  #10 0x0000555555d1ec6b in ppce500_cpu_reset (opaque=0x555556df8630) at ../../hw/ppc/e500.c:785
  #11 0x000055555595c410 in legacy_reset_hold (obj=0x555556e6bbc0, type=RESET_TYPE_COLD) at ../../hw/core/reset.c:76
  #12 0x0000555555ef28f0 in resettable_phase_hold (obj=0x555556e6bbc0, opaque=0x0, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:162

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu_init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 062a6e85fb..f987b75c4f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7242,9 +7242,6 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     if (tcg_enabled()) {
         cpu_breakpoint_remove_all(cs, BP_CPU);
         cpu_watchpoint_remove_all(cs, BP_CPU);
-        if (env->mmu_model != POWERPC_MMU_REAL) {
-            ppc_tlb_invalidate_all(env);
-        }
         pmu_mmcr01a_updated(env);
     }
 
-- 
2.39.5


