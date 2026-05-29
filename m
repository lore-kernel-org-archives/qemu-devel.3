Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4007DCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3DP-0004Nd-Dv; Fri, 29 May 2026 15:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3DJ-00040O-QK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3DF-00049D-PB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-490686877a1so43289955e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084184; x=1780688984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zgZBm14Uyju02XQkgmWQYMN4Aqeyrq3QWm64d0lF2pg=;
 b=cY/uO65xZBVYT+YVORaX5Deaa0m0mLlDIWiwFPYGca0y+WIfb3hY7heO5ABuJayIwg
 +YdoiasgwuDcW/2M2viddj087pwcmd1UCUfaS6/d9ielwajAfiNYsNrIWZlm/C+0imXU
 uzmxVoJ2EDmuftjfn3K55ESL6UbyNDPmjNz/krJnKQDz+yTyG3RjTWhUcApEmqFyqfcn
 AVpb6hLHP9CUkL6Sa4b3BH2PsndTF5NITriu/5FCCUJTHIYKomwDgzPcMYq9Urk13VcZ
 UuYGLQto3C4C++oTxx6/mLDavBGKWf0Gshp+3U/C2eKX4dZQkmypr1wZAUtHTR6iV+DR
 j7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084184; x=1780688984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgZBm14Uyju02XQkgmWQYMN4Aqeyrq3QWm64d0lF2pg=;
 b=DaC3Vbj8u1TqOfslbRL6rqMftgWK6oWfXRRtaH+t3VqMJdJOkniv1wvvk4XQzXv5Iv
 3h7W1Svv7lIx9BsEnFq87QcAEERHYZ0fMCeVrAKqeRm4o9/Fx2fuRIzjhBK4LKG+2vH8
 DZKXC9gBfXDD6lRvVZo+ysxyH4b+7fMAKINvgR9N8zDbNh1MNCBOyqK71/H74YY1+ujq
 UbiFnia8vNoL/M4m7ruG64/ZwSVKnweKr2dQs0hgU4dsDnaZwMb6dhYj1OsLcJEWeQ7p
 qaKQDPkz/hhG4BuFha+hrbODphOXAbqomuSMnHaT6LlSju0eCjBzk9ZZg5qHeOJc6NGs
 CjVw==
X-Gm-Message-State: AOJu0YwEkU12DM/nmVpu6GmGN9PLYEPEc9eVeEHMEKfJ5MBdABK+gQt1
 TIjLNAsa5vAk+VN1XViTp+lJl2knBz9ZpJC6lR93Of59LZ75rNgZ6Ak7LW4ZJAwaA0yoZd77paw
 VKcMI3S9YsBj9
X-Gm-Gg: Acq92OHIL3FVL2slemFeybSikBLv6a6LIaUyg3w4gijXk/de5p0RRFRvpJ0nIJp+BUQ
 WBglDj6omKpRaAQBQmh38tHwK0kX9MqkYG5wem9fvYiwIM+pLSGrlWByu9nJpfhXDmGgijC1I+f
 XP/xE1mbjV+m/VU2mgIXAKFNJbrpvHqG4Srahrcx8zb8umtUj4sCyXtVmMDdRfX2IDsxUhBmu0b
 Ti6vXSrwHMEngW/2mjP0rcdKgTTz4tlXRiCYsi1di79lz2Bcb0RzihgLDCU8J0fs5RcTOUFn64f
 lEcQuAL2CH5RBOLzDYWp8nmdTq62purY0+AuDbPH3EB2s6ipgOKVgbspZ8qW5CvEHmBhEM1UxAJ
 kaEVeOcd8Sr2Yd+kx8SSyc++lFaibzt2+t6TOwVH1CnQptv2aOmiAlA01AJyJxB/WYZLfQJ3oOt
 c2wzPGTojWTUwQUtebgblANdC2MJKbxKEMHUf6+jDknixv/p5KOQUBmM99uhq7ygxo6g==
X-Received: by 2002:a05:600c:64c8:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-490a2a1f07cmr10902485e9.5.1780084183971; 
 Fri, 29 May 2026 12:49:43 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c103baesm20533745e9.17.2026.05.29.12.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:49:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/17] accel: Remove need for AccelCPUClass
Date: Fri, 29 May 2026 21:49:22 +0200
Message-ID: <20260529194940.97143-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Could get re-review: 4 & 5

Move cpu_init/realize hooks from AccelCPUClass to
AccelOpsClass. Specialize them for TCG in TCGCPUOps.

This drastically simplifies the need of per-binary QOM
types per accelerator per target (see also the nice
diff-stat).

Based-on: tag single-binary-20260528

Ignoring checkpatch.pl:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    accel/accel-target.c
    include/accel/accel-cpu-target.h
    include/accel/accel-cpu.h

$ git backport-diff since v1:

  [----] : patches are identical
  [####] : number of functional differences between upstream/downstream patch
  [down] : patch is downstream-only
  The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

  001/      17:[----] [--] 'target/loongarch: Remove unused 'accel/accel-cpu-target.h' header'
  002/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_class_init()'
  003/      17:[----] [--] 'accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()'
  004/      17:[----] [--] 'accel/hvf: Remove need for AccelCPUClass::cpu_realize'
  005/      17:[----] [--] 'accel/kvm: Remove need for AccelCPUClass::cpu_realize'
  006/      17:[----] [--] 'accel: Introduce AccelOpsClass::cpu_instance_init handler'
  007/      17:[----] [--] 'accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  008/      17:[0002] [FC] 'accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  009/      17:[0002] [FC] 'accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  010/      17:[0016] [FC] 'accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  011/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init'
  012/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_instance_init()'
  013/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize'
  014/      17:[----] [--] 'accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize'
  015/      17:[----] [--] 'accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize'
  016/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_target_realize()'
  017/      17:[----] [--] 'accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h''

  diff --git a/include/system/kvm.h b/include/system/kvm.h
  index 2c31fa6019e..a249f076763 100644
  --- a/include/system/kvm.h
  +++ b/include/system/kvm.h
  @@ -225,0 +226,3 @@ void kvm_irqchip_change_notify(void);
  +void kvm_arch_cpu_instance_init(CPUState *cpu);
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
  +
  @@ -367,3 +369,0 @@ int kvm_arch_destroy_vcpu(CPUState *cpu);
  -void kvm_arch_cpu_instance_init(CPUState *cpu);
  -bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
  -
  diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
  index 113a23f2384..edad3c1acea 100644
  --- a/accel/kvm/kvm-accel-ops.c
  +++ b/accel/kvm/kvm-accel-ops.c
  @@ -101 +101 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
  -    ops->cpu_target_realize = kvm_arch_cpu_realize;
  +    ops->cpu_realize = kvm_arch_cpu_realize;
  diff --git a/target/arm/kvm.c b/target/arm/kvm.c
  index 7d194ea112b..0f1a98b430f 100644
  --- a/target/arm/kvm.c
  +++ b/target/arm/kvm.c
  @@ -1785,0 +1786,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
  +{
  +    return true;
  +}
  +
  diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
  index 5d74ca6fd56..536bcecd7d2 100644
  --- a/target/i386/hvf/hvf-cpu.c
  +++ b/target/i386/hvf/hvf-cpu.c
  @@ -58 +58 @@ static void hvf_cpu_xsave_init(void)
  -void hvf_arch_cpu_instance_init(CPUState *cpu)
  +void hvf_arch_cpu_instance_init(CPUState *cs)
  diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
  index 10ab7b2a4dc..2973e28122a 100644
  --- a/target/i386/nvmm/nvmm-all.c
  +++ b/target/i386/nvmm/nvmm-all.c
  @@ -1214 +1214 @@ static const TypeInfo nvmm_accel_type = {
  -void nvmm_arch_cpu_instance_init(CPUState *cpu)
  +void nvmm_arch_cpu_instance_init(CPUState *cs)
  diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
  index 9d844c4905a..167fdd515be 100644
  --- a/target/loongarch/kvm/kvm.c
  +++ b/target/loongarch/kvm/kvm.c
  @@ -1497,0 +1498,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
  +
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
  +{
  +    return true;
  +}
  diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
  index 013f5e852e1..894962d509f 100644
  --- a/target/ppc/kvm.c
  +++ b/target/ppc/kvm.c
  @@ -2354,0 +2355,4 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
  index 2e4f435c537..46730e72a92 100644
  --- a/target/s390x/kvm/kvm.c
  +++ b/target/s390x/kvm/kvm.c
  @@ -2613,0 +2614,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
  +
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
  +{
  +    return true;
  +}

Philippe Mathieu-Daudé (17):
  target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
  accel: Remove AccelCPUClass::cpu_class_init()
  accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
  accel/hvf: Remove need for AccelCPUClass::cpu_realize
  accel/kvm: Remove need for AccelCPUClass::cpu_realize
  accel: Introduce AccelOpsClass::cpu_instance_init handler
  accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
  accel: Remove AccelCPUClass::cpu_instance_init()
  accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
  accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
  accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
  accel: Remove AccelCPUClass::cpu_target_realize()
  accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'

 accel/tcg/tcg-accel-ops.h         |  1 +
 include/accel/accel-cpu-ops.h     |  3 +-
 include/accel/accel-cpu-target.h  | 31 --------------
 include/accel/accel-cpu.h         | 23 -----------
 include/accel/tcg/cpu-ops.h       |  2 +
 include/system/hvf_int.h          |  1 +
 include/system/kvm.h              |  3 ++
 target/i386/nvmm/nvmm-accel-ops.h |  2 +
 accel/accel-common.c              | 68 ++++---------------------------
 accel/hvf/hvf-accel-ops.c         |  3 +-
 accel/kvm/kvm-accel-ops.c         |  2 +
 accel/tcg/cpu-exec.c              | 15 ++++++-
 accel/tcg/tcg-accel-ops.c         |  1 +
 accel/whpx/whpx-accel-ops.c       |  2 +
 accel/whpx/whpx-common.c          | 17 --------
 target/arm/hvf/hvf.c              |  4 ++
 target/arm/kvm.c                  |  9 ++++
 target/arm/whpx/whpx-all.c        |  1 -
 target/i386/hvf/hvf-cpu.c         | 25 ++----------
 target/i386/hvf/hvf.c             |  5 ---
 target/i386/kvm/kvm-cpu.c         | 25 +-----------
 target/i386/nvmm/nvmm-accel-ops.c |  2 +
 target/i386/nvmm/nvmm-all.c       | 19 +--------
 target/i386/tcg/tcg-cpu.c         | 28 ++-----------
 target/i386/whpx/whpx-all.c       |  1 -
 target/loongarch/kvm/kvm.c        |  9 ++++
 target/loongarch/tcg/tcg_cpu.c    |  1 -
 target/ppc/kvm.c                  | 27 +++---------
 target/riscv/kvm/kvm-cpu.c        | 33 +--------------
 target/riscv/tcg/tcg-cpu.c        | 28 +++----------
 target/s390x/kvm/kvm.c            |  9 ++++
 31 files changed, 95 insertions(+), 305 deletions(-)
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/accel/accel-cpu.h

-- 
2.53.0


