Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC7C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEGi-0005yN-Tn; Mon, 30 Jun 2025 09:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGh-0005xi-A0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:09:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGe-0003x8-Ja
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:09:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45310223677so14501155e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751288990; x=1751893790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBFvK7DiFhA2sEsL5eyFByettabJhzHGLaBLOapmzQs=;
 b=n4cBs5ohpWJzlEzQtMcTHI8k+0hrGuEId0ti/LRLkBxxmelrEORRraV8TaYoNGg2bP
 KS/4IrdZcCDOoC2N6voC1TTR+HjzBrSLayQkqfBbwrfGOCAUTzXb1prai2LzxsD9+qZb
 S5eHjrB+hea+Os+ly66GIjfmIcy8c9seM+bWzGUfonG+oSznYLvgbtaInf9wLPjx5ZGx
 QKKiYbnHUbWNgFA03GcPVxwWsoT6jBcarUPMgBkzWUR2D69ZNsJhIL3zfXV28mQ2e/C5
 BVkTiC2OEAhPek/y4sjjVfM91ocl2nO6tGJW2tNdCMWi0e4XjFsGVmKN+H3Z2c9rx7E6
 4f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751288990; x=1751893790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBFvK7DiFhA2sEsL5eyFByettabJhzHGLaBLOapmzQs=;
 b=BPLSSEradgxxId7RxgEKKLeuzyHaOvxtBrEWWldWx/B/LT+qndQ7jk5bFb77gQmWaJ
 2Gc1QKU/CKrxUG/egYRiP9cZS8ZgeEkS9c8QryLna38rHT744tWrW36aiFBfV0NFieAv
 ztJZqsykICTm2KYIYb2CYeEzBJwgFWLr5nok7oJBsXGu2/dTJRAAQIVifEC1h3NEU6Jm
 tBuKgjGOKIxgEqaUB5U+vN36F5Du7ewDSTzGTx9yY80xGav4VcB83r21UtvnX3J5hj+b
 ybTBJB+oEUktqMkdatyFNwR4u5Y1wLTgfRFEmleGfXtbSk4x1IILD81KwAozWJtvV2Jd
 qHsg==
X-Gm-Message-State: AOJu0Yx68rbRIuIM9Z8FILlpo7Uf5DGdUDpp0zc4dgmFAZ+iUDPS118s
 4ROigfXqitR9aroBom/Au1Yj4g1DNy6cP610qOzR9YyGlo4KNSsgH84BXqSlF1UL6f2uDnn7Q5C
 rV4JJ
X-Gm-Gg: ASbGncvMDCBw0UZJto9374uSCw7+q6u3RSsd+Qd0xDHJGsSgbTopyJXQHSCEtL2ne++
 UuSDhHuEDO9b3Ssow9eN6RQ3+ZdcdB/ifoyP9u2QnaNNKzm80/r+epbV1WOANJGRN3mpq60xUz3
 c7bZZct3tb0GFF+ajS17h4+sXUNhm9aElUKB08mqoN7FXh6vkF26NAbDrc05SzojCaBwXYvT4/p
 NdwlC0lAfFQORss4D2YP85KBJ0gnLW23euJpDTMY+LWL8IhQdURR9ujx8ffCKMSTY7y/eauF62C
 9SmngOv6VWs9iEPHUirSph1NZ5ikPSChWRPhp4hOX47c96tnW10oWpPPVoC4P588He2XfMemWmm
 JjHfIQbKtfrQRvRI3vYnIlQxomKBu3MlfTT5GDNo8woJrtTk=
X-Google-Smtp-Source: AGHT+IG5Ui0WZJV6aSilq/6/XRjwd5qwQLFqiHm+pw7RRWcHIEBBTfmNOBhvCo2f3RV+CzUCypmSfQ==
X-Received: by 2002:a05:600c:1c8b:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-45391431c04mr119049435e9.5.1751288990446; 
 Mon, 30 Jun 2025 06:09:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8e1sm10247814f8f.88.2025.06.30.06.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:09:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] target/arm: Only allow disabling NEON when using TCG
Date: Mon, 30 Jun 2025 15:09:33 +0200
Message-ID: <20250630130937.3487-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130937.3487-1-philmd@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Only allow disabling NEON when using TCG.

This avoids confusing user experience:

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab5fbd9b40b..b6a8ba83a46 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1810,7 +1810,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon = true;
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || qtest_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
         }
     }
-- 
2.49.0


