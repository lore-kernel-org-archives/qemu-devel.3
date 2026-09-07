Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E7C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzp-0006E8-VB; Mon, 07 Sep 2026 09:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yzd-0006A6-8y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzZ-00051N-TT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so11417865e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786152; x=1789390952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFia9cX6lxhGTb677k1n/vSwEH8f4LK/rrumre5hJP0=;
 b=zBWohaFgvheQkSa0Ltt74nsJUGMylTAcJrScKUtFgdshMH/VTAzwjjkeNEKM+ZcFXI
 wJ1nHc9Xxkwzvl3Xb6EapALiS+x+bJ88BlfVNLMv/S7ygZhZU/8urbtThxUOD5Lwst0H
 MI2wmpLu25VaNTLk58Xni5aoXlA95MsGK7VUo1CZV/LHl30CwqCjgc+klLafnb47dIFX
 UxzNwWVjqWypS7SmTFJukXfO1dVoi4s5iRCn/qSX66oWAR03bkzQ7+JIxSblM2Uml2ge
 jcHiXUR+QBXkr7Aybb5zmQ1dq0XLDYY6xrx9h2Coj58o0xhgwpdBrgSojJDbmPlKkAAH
 uhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786152; x=1789390952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xFia9cX6lxhGTb677k1n/vSwEH8f4LK/rrumre5hJP0=;
 b=GS6DdGfsugptZNXNEVNQwb2eF0kQ4kQRPpqgCr+VZDIds6cXn77z46Nde9XNLyvBTy
 SLNUNYKd3UkHyXElEuNTPeEt0zPCkAz7RgNy744RYe+Svn4s+qGMXIfh21JHPCTg3uJS
 fghYh+WGl22z7DSUtSLFVodL1JmrZkli7b5zCP86At/lE2Pl+5MCioqlWrk2CFmhK51o
 9jbMGRt1FP3riJ29RNsZhmObwF260UCxE43jz74V68iAzA3NOEa/YZQ/OK13U6Zjif+Z
 eB8UBTcdonc7s1BTqWtZCfZj1QgRAFV2Wj/Pjw3VBfB5MzhAnLSGk/6E42IXZjugrgkp
 P91w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoDCLmOYRN57bRtUUmRZjeZW6B2vu2dlim2JQrtUBm+u+zuX2QRxKOXxd2FlMSIStzUQjvjr9JH3kb@nongnu.org
X-Gm-Message-State: AFuF++nwXKLIvRKQWo8oxtpT8mX7x1idoi1XoZJbhulkjJuSOtpm06kz
 vC6uvQYnSbZ1a3uGA1L33ngoEvfKzmLdAPBxVk9ys4zagPempoDJffPFIsNyAA6/wRIpjMgSr2b
 UjAsCzFY=
X-Gm-Gg: AYBFou37os6oaSeMTyFhrlW3pdgPryKdzRxEfZOMYtw4wFoVnJukOK6AY9JN82NllGh
 Bk461ZVjk70cAsYqDToz0NQVFFEAUonxKYRaFE6Focwr4fVtBvJ43q/shmuj+l18QI/K1zsCTV6
 VvfssmGfLHaas2de10FEJhSmAKkvSwaAvzi/u9MvHfNUJBrSQSn2lfV5TwQPFVmuAKMzeecJkym
 3BR1QR+MrunM8DJBCugYXURfbDuuuZI3x0CQ2RD1lsoG2zCS4LH1H41zJmWE+nQEJU7Xv2nWuAj
 cgrEogkoKnL3cIt73vw6s1z76sCaTOUx7oBdKINj78RfwcUp6wE67umOB+cUT496gUFLktEUJO5
 BxuKgS1chM1up+bxPSqb68AUuv9O50Iu4SAy6NKSkUPTByqn9c6X+NJf4Nu/t37F2763cAyNfkO
 urlRWc0Pu8HaH6bzWwUrpgwFlg05Si58scTeLdzfmM9cdEncS7L4N7hsinbbDbx2h3o4XYjtatn
 MgVDHn16pJ+v7BsEfup/NLRNPoIxhP+roramcV3krOQqxmRAHBvhinYn6pCAerdjsPUAA==
X-Received: by 2002:a05:600c:c494:b0:49d:286:83d5 with SMTP id
 5b1f17b1804b1-49d028683f3mr147312255e9.13.1788786152341; 
 Mon, 07 Sep 2026 06:02:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 6/8] target/arm: Don't set ARM_FEATURE_VAPA for v7 PMSA
Date: Mon,  7 Sep 2026 14:02:21 +0100
Message-ID: <20260907130223.3148989-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..0432888ae34 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1501,7 +1501,11 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
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


