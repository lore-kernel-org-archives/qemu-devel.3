Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77623CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWx0G-0001PI-9C; Tue, 09 Jun 2026 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWx06-0001NI-Ez
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWx03-0004K5-Jb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so19434565e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781013614; x=1781618414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oXXuTiD5DdKEmPN02nna8Eq1chJAQm4tErgo+1RAZg=;
 b=i6GtFXNEGkOO9wREhfj8NEG5EuhOP3aw/3FbWShl4UUHvayyOmMKhoXDIFR4/hET5s
 u6NoWQHx+t5dWDu7xkU4o6xudDbIcgigEXi65b43+F1VTZEWzLoVUA6F8xkddu977bQA
 TCjTALxEHRHTm/L8nh8zvpCcc+g6Uk+4Zvb5QeIJw/gWnnPztymEy9rNrCiNP6XVGu0u
 qSIqgnlNpXdJgjyCNYocprFVbzIO/ejcI+MwtdRrf+47zyPzx+AuDF+m6qe1deXnZXJ4
 FmD8JXrUirup0SF9laRfmb131n/cBdHbpJe4sn6ZWjIKiUETaPpFMBZn5GTNeQE/wHop
 D4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013614; x=1781618414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1oXXuTiD5DdKEmPN02nna8Eq1chJAQm4tErgo+1RAZg=;
 b=dstbZPjS/qzT8mILWvBc/LEA8oHFcBCVFIqRfvZe7k1ZvrFmgRjTRnb1E0lVkXMtOR
 RgCNYpGK2q3pJzoLxGbp2+YzkU49Klo0ZloPcoluBcxDPrSQxTOkvrvnmuOVyLRjcKme
 Ysd/12dEANX7piMs2L/I5Ef2zfSfxJmj6qYQ4lfgpuWIgbv/8cQ8+elGC6bLDTpqUrNN
 eHtDve3vQo+cKU6m00EW3CdgwPFrTHg+NqVooiJIYd2+k0oSfLYRq6EzfYR4j+skgDbQ
 Kw5XIjpyzqZlQ2mXYB48Ta28X7FDkMos10VBMYYl5wz0NfYZ5e75fHOd2EBmSZdkSLoY
 ZWSg==
X-Gm-Message-State: AOJu0YyKQpvG1PUe9GkrkIcNKwpQ9DyR62INOs4kxAP/+9PdRpVDF4dH
 4Gch+oaZ46tv6qWKnd0D7+vuqo4tL+EhVQEo588BFS0i/L17RncUrD8/XxbBy+eEaD0=
X-Gm-Gg: Acq92OH6q32/jMHpdP5lXDtG5+MotwZYUP9ye8meUlDn2CYVlR6S97292D7Qhw7CWf6
 YjN4Ks0+lxbOlIjD8f5XboAA70YagI4Dt1OkSiQ75yk0EbRVHmrj4DOldifGDBk3T5UURNzeUOL
 w1BNUwSL6102fcAOB5P4mj+VqWNOqkNUn4mdLJw4fQgbsw9IvwId8TJZAKAE5XrYS3G0lsrivCS
 8qQ2LVf3lOVlL++TmgZVbaKZDYhycgcLuewadEw6QpmUXPfk8qgogJJ+MOtFjECWDiU57onVm7i
 CDSoj6tOBvTN40zKeGdRsXMYK/2sWmHkZOoJX5/I047RN4uhe/xW8b9cdD5r4wfGWmWa5xxKEuL
 CbTYTzyohCTQUzmiPytlHXyRM4yn0tMBiy86RjmFsoMjnV51TSoPJ9smovRHqqzWO0gNUS/nIPh
 2GDYzeq7eOMQAarpCSP/yJniwtQcBJncndbg==
X-Received: by 2002:a05:600c:190b:b0:490:9804:afdc with SMTP id
 5b1f17b1804b1-490c25ff35dmr352633735e9.23.1781013613566; 
 Tue, 09 Jun 2026 07:00:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3cc140sm576722315e9.9.2026.06.09.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:00:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBF115FC69;
 Tue, 09 Jun 2026 15:00:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/5] target/arm: trigger timer recalc on SCR:ECVEN change
Date: Tue,  9 Jun 2026 15:00:06 +0100
Message-ID: <20260609140008.3206970-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140008.3206970-1-alex.bennee@linaro.org>
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Toggling the ECVEN state affects the offset calculated in
gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
change.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5c640853060..22f5117ee54 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -37,6 +37,9 @@
 #include "qemu/plugin.h"
 
 static void switch_mode(CPUARMState *env, int mode);
+#ifndef CONFIG_USER_ONLY
+static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
+#endif
 
 int compare_u64(const void *a, const void *b)
 {
@@ -821,6 +824,12 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     changed = env->cp15.scr_el3 ^ value;
     env->cp15.scr_el3 = value;
 
+#ifndef CONFIG_USER_ONLY
+    if (changed & SCR_ECVEN) {
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+    }
+#endif
+
     /*
      * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
      * we must invalidate all TLBs below EL3.
-- 
2.47.3


