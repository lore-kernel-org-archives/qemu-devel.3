Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993ECC52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtKq-0005n0-Db; Tue, 13 Aug 2024 11:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKc-0004u2-F7
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKY-0004dz-5w
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-36bb2047bf4so3681325f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723562459; x=1724167259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9YuTGRjD2i97kf8nmOQNNKGq72EmNNRMMhomIVoZje0=;
 b=DZjI3yd0LTJm0K6+xVO1J+RCdtD6vM9uAVUB4LUpiMQ5TrePntQHn3D/KBbo84OQEU
 wZTtjE6ul5xvMPZNz1Dq/EjdZIMsuQhxGXrSqMIGYdpH7GT1Xcc9d3LDqQ51E5pl5S7m
 O7ExB2bURLIjV8Lqe5oXxWExgeKSzpu5Mn96ZhxXu+T+PbENd04SY2tub4JUd9URstH9
 Y55gWM6FJh0h3fS2MCZFIyi5qioxD42YWaT+SMiZ5HMGhncCmIverpaXRYpwt03oMTeS
 TKZKMY7GmcxW2uNlTFv4453iYN2HLAxzcFqjf+EeFQLTYjJBPjYVQN2UMD/FRFMJw11I
 mRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723562459; x=1724167259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YuTGRjD2i97kf8nmOQNNKGq72EmNNRMMhomIVoZje0=;
 b=nOitTTCURH1lahtxBmTfVKTjwC/8ZoBn4vaPa1IuZRbKO9PFwXR0nmwqhVPXh1GoNt
 z3uC8HX5+Mg0iFvXmNT3SmPch46M+kBX7Vw44garAN/Zx41Bi16lLEACJ9VAxYXIl9aN
 tA+sJRF2j6ybAyJ/g/mVSzl449nTU5sLR6/Ugzmhw/eSAzBNAt8+1uQyNobjTZXaDnIu
 Ck4GVRWFC0MLz8MQB/mY5oEjnUEQLvzCjrR6wPSvVfXCvZ+J7/eSTI1NuCchxWzZhsR8
 g5Dg81lOvU0FilkumEwBafRtlSbKq0JlFLUf/zJBfXl/CmYr8++ULIUzosx9u3PaiAi+
 Fm1g==
X-Gm-Message-State: AOJu0YxYr0jDl+NSQoK85eYToSshhJ0Owd4xutpZX7/R8XsWHy8npcqh
 ZAHhC1TWH31WIpvoo2vh7enxPU5Xou1Jk9lfT9Be1BlpCTBZClchBxLpnhOKS8hLDq8T9jpTUL4
 G
X-Google-Smtp-Source: AGHT+IHrDgyFBoYtiVKdkenB3u/tzAfWxVSsi7oxeOYuR4saahY9pX62DJZv6sd2vN2XlAFDZzruFg==
X-Received: by 2002:a05:6000:1083:b0:367:8a3b:2098 with SMTP id
 ffacd0b85a97d-3716ccd8312mr2058297f8f.3.1723562458708; 
 Tue, 13 Aug 2024 08:20:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee676sm10654792f8f.49.2024.08.13.08.20.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 08:20:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] target/arm: Update translation regime comment for new
 features
Date: Tue, 13 Aug 2024 16:20:53 +0100
Message-Id: <20240813152054.2445099-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813152054.2445099-1-peter.maydell@linaro.org>
References: <20240813152054.2445099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We have a long comment describing the Arm architectural translation
regimes and how we map them to QEMU MMU indexes.  This comment has
got a bit out of date:

 * FEAT_SEL2 allows Secure EL2 and corresponding new regimes
 * FEAT_RME introduces Realm state and its translation regimes
 * We now model the Cortex-R52 so that is no longer a hypothetical
 * We separated Secure Stage 2 and NonSecure Stage 2 MMU indexes
 * We have an MMU index per physical address spacea

Add the missing pieces so that the list of architectural translation
regimes matches the Arm ARM, and the list and count of QEMU MMU
indexes in the comment matches the enum.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240809160430.1144805-2-peter.maydell@linaro.org
---
 target/arm/cpu.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a12859fc533..216774f5d3a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2772,8 +2772,14 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  + NonSecure EL1 & 0 stage 2
  *  + NonSecure EL2
  *  + NonSecure EL2 & 0   (ARMv8.1-VHE)
- *  + Secure EL1 & 0
- *  + Secure EL3
+ *  + Secure EL1 & 0 stage 1
+ *  + Secure EL1 & 0 stage 2 (FEAT_SEL2)
+ *  + Secure EL2 (FEAT_SEL2)
+ *  + Secure EL2 & 0 (FEAT_SEL2)
+ *  + Realm EL1 & 0 stage 1 (FEAT_RME)
+ *  + Realm EL1 & 0 stage 2 (FEAT_RME)
+ *  + Realm EL2 (FEAT_RME)
+ *  + EL3
  * If EL3 is 32-bit:
  *  + NonSecure PL1 & 0 stage 1
  *  + NonSecure PL1 & 0 stage 2
@@ -2805,10 +2811,12 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *     table over and over.
  *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
  *     Never (PAN) bit within PSTATE.
- *  7. we fold together the secure and non-secure regimes for A-profile,
+ *  7. we fold together most secure and non-secure regimes for A-profile,
  *     because there are no banked system registers for aarch64, so the
  *     process of switching between secure and non-secure is
  *     already heavyweight.
+ *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
+ *     because both are in use simultaneously for Secure EL2.
  *
  * This gives us the following list of cases:
  *
@@ -2820,14 +2828,15 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  * EL2 EL2&0 +PAN
  * EL2 (aka NS PL2)
  * EL3 (aka S PL1)
- * Physical (NS & S)
- * Stage2 (NS & S)
+ * Stage2 Secure
+ * Stage2 NonSecure
+ * plus one TLB per Physical address space: S, NS, Realm, Root
  *
- * for a total of 12 different mmu_idx.
+ * for a total of 14 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
- * EL2 if we ever model a Cortex-R52).
+ * EL2 for cores like the Cortex-R52).
  *
  * M profile CPUs are rather different as they do not have a true MMU.
  * They have the following different MMU indexes:
-- 
2.34.1


