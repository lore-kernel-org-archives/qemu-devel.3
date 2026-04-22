Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7A2F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4i-0005yq-Hv; Wed, 22 Apr 2026 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4e-0005wr-CJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4c-0005T5-Q3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso60858675e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862377; x=1777467177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMEvstJVHgigEudV5H559dC48ky9GaKFB5z4g04o+Y4=;
 b=nfTCAJXHBB07zPe5kNdFBJgkDpSYx09+12VC9s7H7yhGxzOJoRtUHPVWE9E5j4msfW
 +g8vN3Fm6Xt6T+tatZ9IerwMQ5Vl4Y0cb6mBJSYmFQqCTO6LmgQjAFJHqbEF1FAdi1zb
 sa+TDJGyWOULOcGQX5Ej02NgH2UnjYx4gjShsMJHEb8qwEkP7beOSVmSjmnereIAmDh7
 Eb8gXQ0qVHp17FO6KAAWFS1tUlcyfJ8O5MrTlpXk2d+wUkwO/h/ObIqLRUVn467Uw4Ja
 znsThmpQQRurGSeowCcWDiIissZbOpSHYkx/FO+7FVFnTZO4Ewr78Ppwy6xn8s0pjHQm
 mKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862377; x=1777467177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OMEvstJVHgigEudV5H559dC48ky9GaKFB5z4g04o+Y4=;
 b=H98cu/YuwHtMiGsFMrCZiKXCwe7utCnnV0fwkU6rAdUtsLd1vfkANm3Nczc6eunAaT
 wbKWIGJq6UNHkbjvNx7Z+pv+xIj/XTJWwuh2icgU02XJpO0utnnQKAUeGS4lY9QCixfA
 9jGvBcXpkA6ttAwvTBpbDEEDr1THogY02L4plFqPuT9W3dPubQKrqf86fCEFNDX1tF5L
 VCCo9NoSNtXoScrv007o7o0Ci7O9c65zAUn9H0lgTA3LCaV0q7DZeOgYJtrVerLdQXG8
 b7gF6woxQok4ejZh3r9uyipd9Bt0DohmBOXODj8fjf/RgnVfEhCeJi+yDjCayVn9OVPi
 mqNw==
X-Gm-Message-State: AOJu0YxPoOHjm9RuE3F4E1wYStM1NmBlZLhKD1Z/bx970EOic6Q4LvmU
 +69JqKl0V3s+8Fkfe/CtiIcBOGyJxxEDAPzAAyMeZj2ClBqG633Z5VaCN+4DKfSOGws=
X-Gm-Gg: AeBDievPNk58eZ/09pp5v+ZPC0w3YHNEJt05IdH3jEWA25tob58+rSXAl0YSJobeccn
 VfVVBRfVlVgkDyazy1lKubOibItI6BTSx8BQw25RntggkN68H2EsWXdkHqw1UYqOU3hucoCY7Gv
 Z1jqS2iC1nVJwpyTzM3G61NhZHVz9AQAPtke4waV3zocgHvkauLWnX/dKEDWMBBTZXyldlJhU4j
 tCoGaHtN/Ig30/ryvuRvOkt6eQoOS4TloJUdTrOWUSqNvLKRHbDjmmY2VfzVb2gkxxupYT0FpDv
 ZdjqlfdLM5JvFhD00gUCOtSJUPbUzUE1CbAZXpQTomY4duinuajRzYW9ypb40ZvOU0PndOVsdOO
 h7xYjUAqv7J6GkANJdRvxEz5o2mVXpVIezWFGMyNtJqdWRbuw+6RCw9UXODsaUiA7xqdkbLmjME
 isfnT9Ezf4R2CwsG5vxhDksw3WbKolnQMIYw==
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr79775915e9.19.1776862377319; 
 Wed, 22 Apr 2026 05:52:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc17f642sm409465985e9.5.2026.04.22.05.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A537460ED5;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 09/32] target/arm: migrate Granule Protection traps to
 registerfields
Date: Wed, 22 Apr 2026 13:52:26 +0100
Message-ID: <20260422125250.1303100-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 6fcf0ac7572..bc65106c61a 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -462,12 +462,36 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
     return res;
 }
 
+/*
+ * ISS encoding for a Granule Protection Check exception
+ *
+ * These are only reported to EL3
+ */
+FIELD(GPC_ISS, xFSC, 0, 6)
+FIELD(GPC_ISS, WnR, 6, 1) /* Write not Read */
+FIELD(GPC_ISS, S1PTW, 7, 1)
+FIELD(GPC_ISS, CM, 8, 1)
+FIELD(GPC_ISS, VNCR, 13, 1)
+FIELD(GPC_ISS, GPCSC, 14, 6)
+FIELD(GPC_ISS, InD, 20, 1) /* Instruction not Data access */
+FIELD(GPC_ISS, S2PTW, 21, 1)
+
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
                                int cm, int s1ptw, int wnr, int fsc)
 {
-    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
-        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
-        | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_GPC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GPC_ISS, S2PTW, s2ptw);
+    res = FIELD_DP32(res, GPC_ISS, InD, ind);
+    res = FIELD_DP32(res, GPC_ISS, GPCSC, gpcsc);
+    res = FIELD_DP32(res, GPC_ISS, VNCR, vncr);
+    res = FIELD_DP32(res, GPC_ISS, CM, cm);
+    res = FIELD_DP32(res, GPC_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, GPC_ISS, WnR, wnr);
+    res = FIELD_DP32(res, GPC_ISS, xFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
-- 
2.47.3


