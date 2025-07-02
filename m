Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B5C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgJ-0008Hg-Kg; Wed, 02 Jul 2025 08:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfq-0007eR-VP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:52 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfa-0000zl-0H
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:50 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso1490575fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459671; x=1752064471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ob8WLFTF4cO6kk67VpmnTkWMaiDWY0sDvi0v1KaZQwQ=;
 b=PcEqZoBl67ZHxDYTmiczBp8AhYOufAgIz2rToPmCNPwqFpRqAuvYgtUiIelJMI3pP8
 5RwPnwN+h8Cw94V4qGMb3UrHgsMwyxL64VzQAVG4mXr5mOd4IFx/hqyz4a87okpuFql9
 Xf03N2FW03VdgmEwUxXBiO3HQ0MP8Kxr0hy8gJJIXo3U1GQkVWHWZKGKW2CxQ+Y/+MVT
 viQPJPxG8rp3RNbByujeBMLxKt6QTMKPa2gN2smVfI/pUpc/yZ7AcTIEwsn7l7+mi8Ru
 CuOhw30ivBWxdd45nqZQXQd8uPj7uhUFviMxa1H3xFY2UryxIBot0SOSlaHLslke2mFr
 wYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459671; x=1752064471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ob8WLFTF4cO6kk67VpmnTkWMaiDWY0sDvi0v1KaZQwQ=;
 b=CxmZ2amvLLCGVlKlCOLl3ZP9tvedyDyZpckK6JJxLGPx+FnWQ71AKuwYNvEmFa0Qcg
 /WLh08EZGx1+HzfTzOC8ZIcC3YgpmRv9mhEYdde6rWdVB8qNCpzAzU/wcgGdv55Fco1+
 Bcu/4sj1zVe9P8l9ExrlS7+MSbnMDKJK8mLt7Jp+qy7RVn10JPHoVA4FwdaO1yYKUyff
 ppgIjN25qTLlXPHd9yvO/1/UUswtgES4MPOIpctXrffPQFfixUlpkYwSLZuCBjCjOxfI
 eOEV8q20fXYi63Msa/8bH0VmIc/lEW4JWax9xu71BYf4sXDJxLci3GOt5eHvS5bOmCYg
 h+6Q==
X-Gm-Message-State: AOJu0Yx0Q5tCzCSs6h+dbdy4LCQF2qzEbzbLQe4NnJ1UG+2OZzdoaSyr
 XAdEg8wAuu2ipSvCrdIn3wx5Ia285ow+Fsbwot0a+l+MPARK6z7tJmkKLxeqDqGqK2u+nGCc+QJ
 7OjU/io8=
X-Gm-Gg: ASbGnctvLXwpTOrJV/Jr399O5lcuaZXU6srpHrGCA9sKPQtmetjjHPj+Ie2KXqtbyVB
 UW1NRqN6ppJCeNlLPP8bMN3ZESLxNuFZxz0Pl/9Z0cHaLlmsYHd2yjABRa2Y3aeUUANQ86V+RJ2
 T4dommbVITTzWKj7tcbE9XF4QeODjecfnLyHO288EYQiX31HYT2igdwHEmIRk0M5spG4g71gsYK
 264hCsEpaSZwc9Iki3M6lG9JMSdWxPOabfqY6HwdRVVtyZK61XicAQDNr+/ogQIgU3bykPUgTQ4
 hbAdUfAjjsVxo0hh3n0PhBwFvS/YQR3l5eAbhM7Lo0nuKmL0OM1Co2I8YDmRd8lPmMoCGfevEkl
 Gdas8
X-Google-Smtp-Source: AGHT+IFQu6Fz9LllyJZ7BYtfdI8zowx5uc30beM+tRG0JkRjZk0WaT8Evp5windnEdTFkLITkCkGyg==
X-Received: by 2002:a05:6870:328a:b0:2e9:9b1d:d11e with SMTP id
 586e51a60fabf-2f5e86ab791mr1987870fac.38.1751459670928; 
 Wed, 02 Jul 2025 05:34:30 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 14/97] target/arm: Introduce ARMCPU.sme_max_vq
Date: Wed,  2 Jul 2025 06:32:47 -0600
Message-ID: <20250702123410.761208-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2f2c131613..b5c4fa1e80 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1118,6 +1118,7 @@ struct ArchCPU {
 
     /* Used to set the maximum vector length the cpu will support.  */
     uint32_t sve_max_vq;
+    uint32_t sme_max_vq;
 
 #ifdef CONFIG_USER_ONLY
     /* Used to set the default vector length at process start. */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c5c289eadf..8400c7b567 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -343,6 +343,7 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
     }
 
     cpu->sme_vq.map = vq_map;
+    cpu->sme_max_vq = 32 - clz32(vq_map);
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
-- 
2.43.0


