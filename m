Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14208CEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK06n-0003Fv-9H; Fri, 14 Nov 2025 15:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK04J-0000Rr-5f
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:06:58 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK04H-0005Bq-NT
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:06:50 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so1735034f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150808; x=1763755608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMDbgyBSsHgV3ZURAPo979wxtIvTEY+Ozps1vZGgi5k=;
 b=pdYH1Bn7inbCm52AOutcuz/auUDPFocAFh4uvwAsI1Lj2Eg9iNNoLbyk2dilcgnq5m
 hqcmRc6dztFFFzM51LrP23Lzt36ZxgYQ++nq2poiyL1+4PwUdSLlJkP8xRnFgWm0fIXg
 DaPYChs86UEaQWhCA1bdsyWT/3K5o5LCGNZ7x+fBxvTdb2IaUJtra31j8bHOweU6iGwZ
 3NpTLTpLvX6/mqLfu/s+wCa55WQEsBCCjsNLeKQ3RdfleFBbtBMReCIItuxLIG7xuBA6
 5pno9SmMOtV8/VnZD33s/4joXBcImGkMAx3drlpBtEsDth8pQT/M8sewF/A7g+5Ilvgw
 sJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150808; x=1763755608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EMDbgyBSsHgV3ZURAPo979wxtIvTEY+Ozps1vZGgi5k=;
 b=kwkVx5nhAZ+71S6DOr8TV1yW7ECpoGSMdPVeB+GTDCnprQWFDXfdOnOaRi0i1O3ran
 aTGM7TktULfsX0w2uKdTCpWhzh2/Cu0RXR43TWduuIAVMOAMiW5vOKoLPP2ONVLNsuXM
 x8yOhRqV+rR3R4MxLfCRtKompv4AnjI2mwWtvm8n0JtCkYybSNBdiemphNiD4QBCvqhf
 7ehdLgVrNuEEUwGnAt7hecmTIEA7lf+7rfR1nnYsIFkoS2T04izViPWOm5s2LRm/IB/i
 Y52TultURvfntzc3Tun6n46JfmwFRwTwLSo6goS+lGZwIzuFUJu0IK6n1sN6rReWJy+k
 Q2/g==
X-Gm-Message-State: AOJu0YzifuhJo6rNAKEe5zl/mNx4VHc8lJOhtT3IWZkgTU1Oj4I0EWOm
 Po5L+M2JvwXe1GWvATjxvwiX+wHyT35wthaSVrfbWA30nCmjrO1kkKKB0OImd+DgKrSwSmx3c6Q
 j1WzfNRQYPQ==
X-Gm-Gg: ASbGnct4z7A7Am9NqOPYL/4nRgp9BFtSXdyVQ1BX7I4fnFR/Lpelf+qyLXpurMKy+kM
 hrq4fmGU6CSokTljQuQ5s0kPk9FNSexNeaySANKwSsqsQIylI2ZEiFjfjgaI3yYPq0p8o5M+/Q2
 VdQbH/wV6HO3pVQck+X7FOaLuSp5Uh4wriU5++5WUaMI0dpGojX/IHKq3qHcQA+F8aQVUh/+a1j
 2VdOoNTLBL2eQiO+4uDVtl2x5PMojwSzNzwtWARjxEsfvgHUq9hclnyODyHF7VhRGWGm4qLJVj8
 Q3I91LWXGCmgd7ZLdMRDRknXF2xoDIOVpK8zs+vIKlju06+e9MTQFQ7diChHg4hNJ02wVIKOZWe
 vcRa0Y2hGdvyFuHKPbx5nlMP0oBOpNhi8i35tcZZyXHQxcplR0ZJBYtZkxPLL2QyyN/EFHsB0Tz
 Coj85JRlElj17sGAWyWw+LaEaiIkNm1XzRUe7KZI4QsEd5ZzhzZ9UXzIH/P4m4
X-Google-Smtp-Source: AGHT+IHS7g7OD0VGWRaPeDTts+2fdDLuiqqYlvhhxmKtYkLi+mDY0kY2scPx9f4jxsOmgMHwJRvm5w==
X-Received: by 2002:a5d:5f42:0:b0:42b:3e19:b650 with SMTP id
 ffacd0b85a97d-42b59338fefmr4213598f8f.17.1763150807952; 
 Fri, 14 Nov 2025 12:06:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17cbfsm11654266f8f.35.2025.11.14.12.06.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:06:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 19/19] target/arm: Only allow disabling NEON when using TCG
Date: Fri, 14 Nov 2025 21:04:21 +0100
Message-ID: <20251114200422.4280-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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


