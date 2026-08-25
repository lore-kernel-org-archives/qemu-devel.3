Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE73C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDD-0003nF-9B; Tue, 25 Aug 2026 18:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCo-0003Bf-31
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCm-0001IJ-3N
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2caed617615so3846745ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695274; x=1788300074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=flXrUG20aPexgqGmyi5LqrRx9IuZht6hYiik7BZP4Bg=;
 b=pDlfux8HJJbSo6EuiEQlpxOj2Lt3pqWfyfVWicwUhvp9dZ81VdnME9MHeaQdVC6Rqm
 SPmlFcJoB99Aa4/sEuvRfC5ZhnCVIYph68HekIZfmyBbE/GtwHfYVfD0SBj9O1F1tDk3
 4QW7vw6HyCKAsbxkG67nveGVjkjV9oxRb2ZewoVtqzw8M91k/MEC07oTc/9YI7DO5v0S
 PBcFsHBQgQNu/4W3wazxeaT1oZozOiZCQskAkQM+zj9PyAKN60TlfUksy24nKCe7Nhr/
 gAGpCALysYH0WgF41EBRdBlMylOinFWRBnwqd4tHdTF5OQ9yU55KZDwvCB0+s7Inf4nM
 tR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695274; x=1788300074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=flXrUG20aPexgqGmyi5LqrRx9IuZht6hYiik7BZP4Bg=;
 b=IpLNA49ydKuAJzFpYwqR6Yh7PkR4CHqhkhGwl8y9YtCc5IPWI8WeaVq5C1FF4WPB0J
 H/wqmKCqq4zJlnayc7Ai9T3008M6ZOjnYn/AHlsJJSQc9BKvPaN0PG6Gf2NNk0jEblGa
 VBkdoZWxqvLpAsgXDrUXJdM6z1BFkDfIsU/kQYFpCQIMPA5p4y+7dl9n3Eocmk/UV8qH
 FZpkJciolmKKxfyxs4npcA9btISizpb8zIOFTEoA10BhG0P+ng60OsofSCYl0daMbOPm
 m0vEfPw3gSGEHExeUDBoip+/IytgK9ZpmaVdfJggQDlM/zJs6bKaLLVOtSorgDF3xxRX
 gzrg==
X-Gm-Message-State: AFuF++l0n67DhP0fj2Ox3MnCj3Zm20jJGeHhRCB+UIzBzYyH1uqFNWv5
 2W68avUOZqy1CuByMt+mZNGohhVJntyV3lY1A6KikBiBidOTBT7ouFrZnj3ldVzJP5E=
X-Gm-Gg: AR+sD13dHCfcmFqF+BjXg1Hd4I/lr490bAWGtaE+b8WEwik9fMvZSF/WInvlnFQR4zS
 i/kqtL8AkKXvCsPOINLwJFXTFu+dwEf7kVKAhl1uuGFC2lB12H4q9QCYc/nCgv031uTtLJrH93+
 HYDd1iNQpWGjf0EDzHPyPXooFCyr1BDCmeQ5F20X+UBr5kzEqGo8dWEHGY/xMew/MaFzopxDsDb
 vDW2rubLAlic47x0zsWJdN29GY8TE62+vyrCrP1J1WRkolKSPyLAVr8szJFxu1rWtJcD4xavSlF
 StsTEvk338BS0ZYJNF/b7lW3deh+9YqwbOmuTh0+3JqXKVEt8WzIZVPqY3vJNU+yu5vFMZuSKTQ
 ir4KyPbe9pBrQJVRaGVRHWXe5MXkjw5w55UpzCZiLol1bO86aWsZbEQcSYcHW5dMubUzrHzHhey
 3ykJVvO7V8jnLKVlmK0Hd+105yQ2TEycHCsY1ntFpMhOXQFm1lR/wtR0X7ghUOXnprBA7p50/qz
 yil1xyt90qUHLdROrA7n+KA9A==
X-Received: by 2002:a17:90b:2f8d:b0:396:4dfb:5890 with SMTP id
 98e67ed59e1d1-3966d144197mr4659218a91.2.1787695274276; 
 Tue, 25 Aug 2026 15:01:14 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:13 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 05/24] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Tue, 25 Aug 2026 16:00:42 -0600
Message-ID: <20260825220101.3443954-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x634.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0c853d17413e..33ac9528c45f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2166,7 +2166,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2269,6 +2269,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2351,7 +2364,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2454,6 +2467,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.43.0


