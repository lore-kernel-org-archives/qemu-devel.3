Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E23CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUf4-0007Bi-8w; Tue, 29 Sep 2026 06:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf1-00075z-7L
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:07 -0400
Received: from mail-ej2-x13.google.com ([2a00:1450:4864:34::13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUez-0008Ca-2q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:06 -0400
Received: by mail-ej2-x13.google.com with SMTP id
 a640c23a62f3a-c2dc50c6eccso302472066b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676123; x=1791280923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tg8Trm3rIcaOaRzuQ0W5qsFGZrHzGmF2Sk39CZZch28=;
 b=Dt433MIoAOj30UjcB4G5jh17RNIfwHGhNkz9x0/UyPCUKzUFEm4BAtGiHGirKkT4z8
 0PBCkGpNPcZh5OUPLvI6N0QsxTJWDgK6+K0A545J49EO6hTy7mFYatXgbUUPdUyg99W9
 A5xRZJpFcCIpIYfDj5XlGnBDvwmF1E5AhuaKg/aPZoV9gS9glrua2t6ZjlqqwZWkhl0b
 0bNqY9NQdbsquAuKC9OtxFYnSecRSt93YdcYXytlCqe4NZbwUdrgdMz4Ut+zdbsHAolM
 Rb+te5TRLscBYSHp8C8p8nddpkUMCAA+g7E5hT4T/6s7lyaPf8nGKxfG/RbaIFhfxxyu
 juCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676123; x=1791280923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tg8Trm3rIcaOaRzuQ0W5qsFGZrHzGmF2Sk39CZZch28=;
 b=JstzA7wHimap7oRCOotpZ/ArfxHKEvGxmshrh6Bq1SLs6yFPV8E92ixwDckDDEeYUA
 iBdALO6OoMiQacuZNzICHhxASSqzf/vz43etE6hqDkJeL9Kc+HYRWW2KBkcTYeSym1Sg
 tGF+00L7hB0hF7+HaC8BVN44QmWU93ByKcix/k9Sugx2W6COutV0VZi61nWPQQuW6fT3
 gpzFERI855BqI4IsRcbZeu1qyVji6F/VK5ixyTrV/00unlbB0f3oYmAyBeiyf/b1X+Yx
 EANXDNMIX4dMuQjYfmwGM2DuK/c+b1yvnvraNagxZtFAn1J2tf/NgA1/bioGIqyrWGBx
 4zjw==
X-Gm-Message-State: AFuF++l8s3xv6jHCwgL8YL7+LyHO0W6RRc5E+QucNT4mUOgjtYSiQhJO
 144+QR13aj4WTUXS/7A0hsJKsPll2ooXpwme/bcfysyFnr7Vppz6djwRH9VlCYHAvcwbYphAzU/
 C9PFo
X-Gm-Gg: AYBFou1fRKzkykm1JjhgzSbXz5exwkO/STUPfDnrMy75Qq7JCr/fFh+/xes8nVjlBhl
 FGYoxzay3TAfghNRBTu8rbr8Ow6/LTFViP8fhwbRIwiWjgOIB4kpa9J1iUSGV8bDi1QCrllNu9E
 Zpc7it6NgeVyMY46UTQDyc5TCx06uNsNtZ0ZJjU7hQ4T+gYDW/C1rpIECJSJ8eg0RWlgTgb7z5S
 JGs2ha99mRsY56LfkOdUvgiocAPpNWoeWSJhVrCKu3VGn/fwVBKqqEzPUeLdtPpFLSMzfgeaU83
 O+K/BwyNNruAGflkioIMwKVvomXfjoUUGGC+tGINNYA+lTqx4zyRGj0WzaZUzgqi/joC4MUyarU
 XK483iMAmsSNI0DfuNfPpBHGlJxjR0/mlTOGs0LP+1RuOilEKtq6IvK6oR9JS3gYIIyB4ui2dDZ
 TxxPYq9hfKskHSs/V1s32TPH0OwPja3nMclnIicpqtrSjRFAExD+CdQDqc/xGKSn8tg7TpPv7oQ
 fn79rVrwwyJfFjwhf8al/yfRw0GDadg3HmpswsvcXlC1t5FAyZ7BB3cUx4lMzmrO0gTxXl/YAA2
 /Ho=
X-Received: by 2002:a17:907:d10:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c2ac2310342mr1294853266b.1.1790676123433; 
 Tue, 29 Sep 2026 03:02:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/37] target/arm: Don't set ARM_FEATURE_VAPA for v7 PMSA
Date: Tue, 29 Sep 2026 11:01:13 +0100
Message-ID: <20260929100133.2598676-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::13;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej2-x13.google.com
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

The features VAPA (which gets you the ATS instructions and the PAR
register) and LPAE (which gets you a 64-bit PAR and the long-format
page table descriptors).  were originally defined in v7 as being
A-profile only.  For v8, the ATS insns and PAR are added to
R-profile; although there are no page table descriptors to be long or
short, the v8R PAR format is always long-descriptor style, so it
makes more sense to set ARM_FEATURE_LPAE than not (and matches how we
already return true from regime_using_lpae_format() for v8R PMSA).

Our "feature X implies feature Y" code was only taking account of
A-profile; adjust it so that for PMSA:
 * V8 implies V7VE, LPAE, V7, and VAPA (no change from currently)
 * V7 does not imply VAPA (new)

(v8R wants V7VE because this implies things like the existence of
ERET and the PMOVSSET insns.)

This will stop us incorrectly exposing the PAR and ATS insns for v7R
CPUs (and it will be a migration break on those CPUs, which is fine
as none of them are usable with versioned machine types).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-7-peter.maydell@linaro.org
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index be2316bec1c..10ac6c98318 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1507,7 +1507,11 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
         set_feature(env, ARM_FEATURE_V7);
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
-        set_feature(env, ARM_FEATURE_VAPA);
+        /* VAPA appears in v7A, but not in R profile until v8R */
+        if (arm_feature(env, ARM_FEATURE_V8) ||
+            !arm_feature(env, ARM_FEATURE_PMSA)) {
+            set_feature(env, ARM_FEATURE_VAPA);
+        }
         set_feature(env, ARM_FEATURE_THUMB2);
         set_feature(env, ARM_FEATURE_MPIDR);
         if (!arm_feature(env, ARM_FEATURE_M)) {
-- 
2.43.0


