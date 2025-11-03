Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCEACCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFres-0004nX-Qg; Mon, 03 Nov 2025 05:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFren-0004f9-N1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:19:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrea-0003qx-Eo
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:19:25 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so2740162f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165141; x=1762769941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMDbgyBSsHgV3ZURAPo979wxtIvTEY+Ozps1vZGgi5k=;
 b=H0/Px8frem0o4y6a6g1rr6jkWB1TSSotFn3s7HP4NEUpEZINy9mMtdWkCzxKvH5AjU
 7N2Vj+H2/uNbD1OyNw4z1JyB2LS8pHYSaGw2WVPCbhT7kNnprjU3RnhC5esdzui6qZpk
 R5D/d8m8MW8+124xg5QbCWOKk+Tb093Xu+Ao4O28Z/YF04ooQzvkfQJnvKTXShAoXF/E
 ha1i07pam377H3y/8HbKIEQYtyY0Ed9HTNYpnhkZVWdgB7tyuKmRNfl4FWJ4dnv6HsOs
 F28+rDHJRLiEbVI6rANmW9VWNED8fYbETJRb5KlfNsQuAv72QhV5krrTcioPEqbKL6Pm
 /mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165141; x=1762769941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMDbgyBSsHgV3ZURAPo979wxtIvTEY+Ozps1vZGgi5k=;
 b=s77nQwsUZK8MhJnjvyBwmtGLsmrD6TALvPLDv7KmlkU6tUgzANAWlyXWiWJV45zBL0
 DJCSh4J02e4mdbFOAntcR70nYkwLAvaM9AVq1MhEBUoI08iFDTSgl4vcbiMrrM30H75V
 Vs9kdJk35wyVmNNGlUoL58EKre0wFyKISdi5Gv9nrdZWokuURMYhc1T7mLq2O29S7al1
 cjIO3Mgzx/EjC4UsxpNf7QuCgo7+ey8z6RLYa2VlxITkF9ZEALkgSHBfUpRwSZwJTqt1
 v9gfKgczHy4LvxhguoLbvFoiRdCanj6mb5O7F1pjeFKhy8CWRx53fX76Bkps/T7paVwT
 6cjw==
X-Gm-Message-State: AOJu0YwoKbxQvMjgON/d7yLe0Ci2d6TV0p1p1685Gj9iVfw3yZyLT1lT
 bd9WjRnw28avLbxEAbRNUZ8EsWCbEhW6qzO+/RVvLlPBYp535tRQuO9F6hASJF5mGpGTDhBrKUU
 dOIStpz1jplQA
X-Gm-Gg: ASbGncsRi9TA1i8zS1tGxSKTK/d+WPNH3iNp95Sj+7LZOqsQ513jqoLPNFEoBbyzVhA
 GztLhm4q8WIOILaQ+vpWllaedYEDjruXH2mG7WuVJgbEgQE8aedJmuA+Xb6501qy3M4t+tObqyw
 KbmPGmzKFkdQ3pr86B3PJHS1/q/DlVP46z8MgOsHo0yEVTIBtu/kcv6XrU/60VUgpnJb4xJd7h2
 SCb95Ax86hVTK8QGegrBHJ7D4gf9R0agJN0sdXv0aKzNvDgNUy7lk3rWBTIJsThM1gdul6uDgOm
 u+NWOKpmvN+/n43iUctYa6N6+E564l/nLRsNm4Trkhv3vhKS/Otorm48AfLCyvYoefrVP8ETkj2
 zzszRFi+pFKQeXd0EkmlIFW9DBDwKycDha82S3nKtVMJCG7D93ZN+owCuEEJzrCkDMSc0Q2Vbmm
 A/kWs1c+0U6IDg0foE5A/zw7VNy3hL0fW1zwwyigMuRyUAw3axJNFd0b/teH/2dAAG/zwbQg==
X-Google-Smtp-Source: AGHT+IEew+fkDxf880QsPHk6Gp7xa8f918tG9GQSwtIJ3D3IHUIJU2SAnjV9AL7n+01tFicGY8Zjmw==
X-Received: by 2002:a05:6000:2306:b0:427:652:b7ff with SMTP id
 ffacd0b85a97d-429bd6ade1fmr10263405f8f.60.1762165140879; 
 Mon, 03 Nov 2025 02:19:00 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c416a0e5sm18885013f8f.15.2025.11.03.02.18.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:19:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 19/23] target/arm: Only allow disabling NEON when using TCG
Date: Mon,  3 Nov 2025 11:10:28 +0100
Message-ID: <20251103101034.59039-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b392374df98..eaf76532eca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1460,7 +1460,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon = true;
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || qtest_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
         }
     }
-- 
2.51.0


