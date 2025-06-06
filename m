Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C668C61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBO-0004cT-Tj; Fri, 06 Jun 2025 12:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBO-0004cJ-3n
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBL-000391-P2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cd6b511cso16138525e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228278; x=1749833078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7VQXQKp4F78pUbtbCAb+X5WWO3G+XUjvRGKunsuffg=;
 b=hC6/cauASZE1iB0zRzypvoNtfFWAkmm0QkKmKNsO0/T3uoIiz0l4bRT+TRlx6WywKv
 G4LpFY+0GMtVkJtciY+iZ+tXWvHS+sxIhH44ghF4vugCS7DKCMVaNORluWvO+Mf99sr8
 QIKXxjL5KgWZAEavuc8b5dn1SBXaIMZUSUqWHqZVzEcvdGOk8yUifCXW3jQDz9GHucCU
 OK40UkxcvSlqNQ7kj8gNSym/KLflg++Gd/nLjhi3/GGevEkXcp/8w3pLJ1amBqgDDzFN
 X3w7NM0zuGcHXyZ9I5BfcJWJRulvNWEzK0k80Pp0FlBFloxHbnONr3WeuwbGdGqQslbw
 B4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228278; x=1749833078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7VQXQKp4F78pUbtbCAb+X5WWO3G+XUjvRGKunsuffg=;
 b=g/X7ci88PfZ2R4s6x0JOggctN3xLuD26ZAEk2covRZtjZSijYk2RV+fEs8yH2/dC9L
 xvwvj/M0fAzKPo5sgwE8XUe0y9Ubk54YHjUrr71eoA29PMHqijqqudghQ2JHCTxlRNY5
 SUH6o83JszGk+hfN0EDmtgjm2hGE31YtlV9yKBb/CJWR5Rl3E+33jUkVznPtW57WpNyj
 Kfz3OJgi3ffJbHz/7CJIjzn1f+nbCX8NJj481DXcpBoxQALJNRPnoK4R86AUuce6yUDV
 BWgH4fcIWA74y/rblPzAy/iLA4MBNRULBS+j0Jb1yzKEy1/aNs6iBttEbLRtIuEnf2Ms
 acNA==
X-Gm-Message-State: AOJu0YzQ7knnzYCfTCzKvVnHA6N5DzpGNDagU45dwEyTanT97F9It2Az
 2rD2zEzyon+87+WBHpJJzqOh5e9VbF64opYUmy3/sNhY9ABeNea6jtfQI2qNkfPyHmLbd2siq+q
 yaZ76AGWszQ==
X-Gm-Gg: ASbGnctui19xVV1Fm4nYwYS+8wZoBq03VslROimJHzLcvXH1c0N6/5wZ4iiCs1Pm7dN
 OyJbq2jsdXgjByB3wh/oUgiWNk1xrAOVC+23AVHviWpoMmhchdfu4IXLAIOJ2Q8j4dPBFo2wQjv
 WZQsq2j9dwTQxe4LlCQDb2mxKFYvEKRRwo0za53rXZt8gGGC0ZxHEls+aCpewDqTSmrq4KyMzG1
 0NiVJhMIUty3qtMlNK1RAcSh75Kq0X1ajkk3A7gwOAQq0aQBe1xgqWrVezX2Vckw4ZTxrwYstwY
 kCdA5xNTYx7gYxZ2OreylXOJB5hwbt8QjzV90kwy6EBMUbqr8XK3CF7JB/CBunF2snm68MjOOph
 w1uLK01FWE1bazTlyHAicbWXdwvBVNLiYQTpch2L0IupBCqEI
X-Google-Smtp-Source: AGHT+IHUQV8A62vXFrim/3fZWlx3zxw6UsOwkpoAasWmFFQbJEqzGebFv67y2r8KSoUz2mdKc74E4w==
X-Received: by 2002:a05:600c:4712:b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-45201417ff5mr48369655e9.4.1749228277642; 
 Fri, 06 Jun 2025 09:44:37 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229ddf6sm2352584f8f.2.2025.06.06.09.44.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:44:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 02/19] system/cpus: Only kick running vCPUs
Date: Fri,  6 Jun 2025 18:44:01 +0200
Message-ID: <20250606164418.98655-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

As an optimization, avoid kicking stopped vCPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/cpus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..4835e5ced48 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -494,6 +494,11 @@ void cpus_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
+
+    if (!cpu_can_run(cpu)) {
+        return;
+    }
+
     if (cpus_accel->kick_vcpu_thread) {
         cpus_accel->kick_vcpu_thread(cpu);
     } else { /* default */
-- 
2.49.0


