Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8330DC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLr-0005tK-6m; Thu, 01 May 2025 02:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLO-0005IO-1L
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLI-0007QQ-Nu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so707555b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080658; x=1746685458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIdah7DauyVJu2UfcXO7gW3KsF259Fcu0NGf/SnDj/4=;
 b=I/wJTUU0QwZi9/+JK1KfTnjn6pp/30bDU4K3YVur7hLY4Ypu/UEcbln9WBGkkT+nWv
 EDN1u6j7FNks8CXXXdwcXdTw/85Bn0CxC6jJcJwDKkidue4TiBUZdd6rGYlsPLvzAvlo
 47zfguQuGFFeg6wbfHfX5ucor1w5VSS7xK2hj+EQhxomZERRVbn8dMrzjrTtPXK1nTbn
 RWLZxk1/uif+K6IWAh26n2EycuXYp4iC0Uqq77zpa38eoV93BhAe9BEUtqrRnWwCgMbP
 EeGqgep21z5XJaAd54MXl5DZQiZcO4wx6WYrG9ymLSFWwPAkd8mHdE+ZDjWmr90uBYsz
 AxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080658; x=1746685458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIdah7DauyVJu2UfcXO7gW3KsF259Fcu0NGf/SnDj/4=;
 b=WkoPdewA6jqqbG38ADly38OVu7eYA0/IxDBV0cpgQEA4uuBbk16lTAobAoAEW1T9eF
 TZShGVExEsnSPHIs3kktZg6EXJcEZtfvByuuPA+ObHdmu2xQgRp9CiaahrKgDckNKAAc
 AXudZQMmLFZMvxaEAwguGKWFQeLIKe+DLQV+1FrfbHDfV8tgG3rW3bzlVk4DpLWI7rrb
 ZNn3sAgAaOQgC5WMj2ZjCjs47ira5hNVgq7JeJxlM9iyJ+8rncuAUbbI5HncrZD7NU91
 MCkQLrRK3PS0efALFMAcx/IIMD/Av+069EsgUtG7KF7fiJVom1oFK+exgDg25oDsYKWU
 VPJQ==
X-Gm-Message-State: AOJu0YziRTYRmkakZWQdjaICV90UlWjB28HagFjz6+Bp5D8SGlElZQ4Q
 hwWUrX353nfATAMI0ChcR9fwMuVhRACpIPm9ZB7+qfWapZgaxAujbfrH/M7owJGigaVab7yvonM
 4
X-Gm-Gg: ASbGnctZf7YfIXyzJzHhHD75O48QRk3Reg5fE5KHluX6evlR0AwJRSbJQGxExfFUi5F
 66QfsK+ZWNZsUSF4l0yK2TUAMW7ze30O2mgVxaEmaEW0dhvgdABOZgGA5lf+0246d2zFnV5vpy+
 1doypFwetqqS4rp4dI6CyYEIMEo3ZCCvaP+Qkmfv0IM5Rn6zyRALpEnpq/DTLOOLKr5+S495gRu
 qSHmFOAMmGgxHBAzHvl2E/u2CKanJzNhAWjVHpGCGCOoNqb/j18dgxYpcy2RNJI3hthUgnBskSn
 X/WN0VtL7qq/K2xh7WskZqILXEoTSxkh/x0gNp9f
X-Google-Smtp-Source: AGHT+IHttOmkTpBafkysIVaoZUp91eACZx3aaBB5iL46qJwlCVUoqafWxeTAwZ79dnw/ta9yzjKOpw==
X-Received: by 2002:a05:6a00:2181:b0:736:4cde:5c0e with SMTP id
 d2e1a72fcca58-7403a77e9e2mr8027903b3a.10.1746080658189; 
 Wed, 30 Apr 2025 23:24:18 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 30/33] target/arm/ptw: remove TARGET_AARCH64 from
 arm_casq_ptw
Date: Wed, 30 Apr 2025 23:23:41 -0700
Message-ID: <20250501062344.2526061-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 424d1b54275..f428c9b9267 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,14 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#ifndef CONFIG_TCG
+    /* non-TCG guests only use debug-mode. */
+    g_assert_not_reached();
+#endif
+
+    /* AArch32 does not have FEAT_HADFS */
+    g_assert(arm_feature(env, ARM_FEATURE_AARCH64));
+
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -851,10 +858,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         cur_val = le64_to_cpu(cur_val);
     }
     return cur_val;
-#else
-    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
-    g_assert_not_reached();
-#endif
 }
 
 static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
-- 
2.47.2


