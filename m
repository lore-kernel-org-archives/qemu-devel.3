Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778CDD59D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFI-0005B3-FY; Mon, 25 Nov 2024 14:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFF-00058N-6q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:41 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF8-0004pX-4Q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:40 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so2872679f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564772; x=1733169572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NexLDu9BoTuLD1ACg75BFq2LpMIPfdBrbSTr833QRX8=;
 b=cFWcANs9YwBOXZ58AiNJerJjajQ5GWidvxPMsiXsyTlNbN4mnmUz8jUz0eRpBcFm8/
 scJNirajSjjNxQiHGZUnATxPx8hLW+jCJKy4QRoKW/t9J1qhgyYT86wbuy7zxmR+R7ML
 I907u615g9gVakgdGACPcYlD3XHTCJ7SwKsptw7SOUlwKRkLdmLlM/Q7jQfWNNlEbFXb
 rQZx2eIFZurKiRpE7+XsBI7EVtaohsEJBQiaewbfIV4AqTqU8aNt35NP+NwuPEss7dGC
 2h0AcFU0JjITAE5dXqiaKbIRmOgDf9iP64VPOLE/lL0rYahk2dAhUYt0hD/rCo+jEmpn
 LT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564772; x=1733169572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NexLDu9BoTuLD1ACg75BFq2LpMIPfdBrbSTr833QRX8=;
 b=AZZjmfdB/63SmxRciqXE66AhhjXnjrdyiDOAhDQ8wz1mkb0nuMiwe+AfBfAF4KqOo8
 B+774YndYCkq2Sac06poxV9nh4YtXSyBrwiuzkE5kHL7AMkYniZUnUvRgK4/Ne1+kFPn
 S6QtMpOLk9JLTgYb2l7Hh1d4dZ0VUbP2yQ3r8u38VxQnHB/Xm23NKHKx9Koz3jcgnmmV
 CBQV6Zr+W+RKEOIUAFpiOmwJigvHztCjzdhr4pnGn1Wabg5Lj7qgJz2kj7sXneBfQlCW
 OBTUC+WjZvkweN8C6joc2dpffxOGod8vLs5rjGFx+22c+fi4BAZS3ECG1qikj+tCus7A
 cZXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPSy2xEByVW7hxSu9qqU2LcnYi5kq5euINcBY7EuNbPsnPkES+iZarwUfKu7kzNOkzofQ/Eofi8Jpl@nongnu.org
X-Gm-Message-State: AOJu0Yz5XtJE3Kkegd5AnyFjYaK2vqwDmdsu3LcdbTjEnghRi78Bo10Z
 QBgnTZL2/wDHG5nCFDP+WxZTQDPrC/bvs40J6PCnsLvJoI0L/U0ZBsjFuzjuVzA=
X-Gm-Gg: ASbGncthXKt8c8hv8EdBgFMOS1np3O7EAcXOHF1XhG+AepfTEyOpcnL+CT5s55rNwgf
 5dHKatDSJ9U2ygVyfE4e1CKWMn+Lj8qp2pMdIxdE27zGRiY0uxLi1ep+6mNtwkspCX51YlrDwff
 42tCDcb+iOWZaIP1d1H7YwnYQihgaRex7USZvjo8qSVdYqLOyI957SXzPT0OZH0qLcBykLYcG4r
 l/zvFXyN120sH18s8vGYA+l+Oh5XF143uDTwr47U7UAE5Ml2N7yKYO/7bhTQ3a2368m
X-Google-Smtp-Source: AGHT+IFCPZLjADcW8fIg/RWkYEbvN1XaUQSM0f35LENvp2ikPkmmonU9r3fcgb+nDIAWPkH3+0dnyQ==
X-Received: by 2002:a05:6000:4813:b0:382:134d:65e0 with SMTP id
 ffacd0b85a97d-38260be5f63mr13089017f8f.56.1732564772667; 
 Mon, 25 Nov 2024 11:59:32 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:32 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 14/26] target/arm/cpu: Inform about reading confidential
 CPU registers
Date: Mon, 25 Nov 2024 19:56:13 +0000
Message-ID: <20241125195626.856992-16-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
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

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b95..7f6569e87e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1232,6 +1232,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (cpu->kvm_rme) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.47.0


