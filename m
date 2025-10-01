Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD5CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGu-0005yI-Pk; Tue, 30 Sep 2025 21:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lGB-0005Xp-8N
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFL-0008DN-Ks
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so4136493f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280579; x=1759885379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsPhyqsNOSQe1Rkbd7aGs1Z/OQwNtlVBiwoEPzFphoY=;
 b=MibP2eq1HI3/8IVCnbJ1vo0rbv6H7H+IvqSs5WWP25E3Cby6kd9olBx6A89tV3Vq/5
 Dp1hUVNRq1/jwpgLTHu69IM6Kh1efi7BHMzQfLhUVLQBO9e9aNIIF54GXy+6hOmFP66d
 FFmLlNM5vkgZUrd5TaqWA7a3IfRz2H8dlVa7o4SDMZmq1gvarYYRS1yFBTuD9pr49dQq
 fqzftFk4jdsDDy3ETNdVll09FgFqzl0+10w9RLBU8WSlonApD1X/Z3WnwkexxK+T4PIA
 p/O8tZbg8VjIA91z8o45zfBlG0mcW7zDeiLSpEBs5EWSBw/s6ETcGti+6Cri8RH47of3
 +B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280579; x=1759885379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsPhyqsNOSQe1Rkbd7aGs1Z/OQwNtlVBiwoEPzFphoY=;
 b=MfWvlw4H4Cvk5TV0ltopCjmuKehhv2aLncfNIaV8EuKqwjilwjSRkqyyItgKPtrFeA
 xs6soG9QwYX/Q1acd6wvDakHmzmk2Qv3G6Cise3piGtCu2xDuwoYT0jZCik30NVIsnZd
 7AXHR3QZpo7wt5k42sDSBaydBg/YstDANSQ+gjp/IsjqOlm7U350BQ5YJWjM0Gu6coRr
 cnEz3tkAnYP/tMuQj0nlZqaRxgxAX5ex0AUrWmC49imBzqbCkIUmmg+awJoYrdEgo2Te
 X8NGQeZ4Wk/sHxGBz6zsSEz7MNxgE91n7H1+4QjsFofOVjBmkRYejHGq8WnF1g435md3
 HH1g==
X-Gm-Message-State: AOJu0Yzz6my2CkllZO6Co91tdwcvnTfgTV+luTYidMcEpHmEAeLRJGZD
 qBhMzebErel/V81QxxOHJMRHHN3IlvWj6EzFZpx1y/da2tUQvLUD0nJPITgoxgqE1pbI6VJL+ya
 /CrgC7jCfhQ==
X-Gm-Gg: ASbGncsSOR9LVxZWL5PS13cYOb1aUVrnuez30Na5q0027hDyoPso0TuAK8cPn+ydl4g
 EfDDWId8/w+/3U3H1o4TJOHqKKU+yqE4AmEwPWjU2wTxiYJENE7Q+mW2ITV/Ys7dmqHNskZR9kb
 wXoxkXgt8ujFvDr9GwOJOG2kkvOOgsCMdbJPUKOUaWRqQrnUaIKSOHGcvOazw6aVP+LEycnMaGM
 OPYtQ/EErXr6sZ4XuJQ/W9sFy1HDz9Oy2nPHLAXBOVg8OL7G2GbD95qxLJfW9auyAdmSCsezmRh
 tvRfFL0AHelpp0ASZZOEpXZE9OzFLlZbjjSp9vSB+bLbFsD0jWC+7X9H/zb2LzWW/sLaD/ZH1d8
 1rasH62CBRnLNSEZU2xRnwNQ1XxKGFREnBs5NFLq6zaHiOBRF0wv6RyEkUddj/71p/BT6RnQFdW
 66/Ft6Y+judERhbBPIM0YJdOvNAKGMUs/MV2ObeLD07Lk=
X-Google-Smtp-Source: AGHT+IFtB5MGJPxZc7LFdAIJwiPBFhGpfES9vziFBKWvvIiG64aaUix3NmQGnEMTBXCcgGWjjjk8RA==
X-Received: by 2002:a05:6000:2284:b0:3ee:154e:504 with SMTP id
 ffacd0b85a97d-425577f1c60mr1102015f8f.19.1759280578924; 
 Tue, 30 Sep 2025 18:02:58 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:58 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 20/24] target/arm/kvm: Write vCPU's state back to KVM
 on cold-reset
Date: Wed,  1 Oct 2025 01:01:23 +0000
Message-Id: <20251001010127.3092631-21-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Previously, all `PSCI_CPU_{ON, OFF}` calls were handled directly by KVM.
However, with the introduction of this new vCPU hotplug-like feature, these
hypervisor calls are now trapped to QEMU for policy checks. This shift can lead
to inconsistent vCPU states between KVM and QEMU, particularly when the vCPU has
been recently administratively enabled and is transitioning from either unparked
state in QOM due to 'lazy realization' or even from 'powered-off' state.
Therefore, it is crucial to synchronize the vCPU state with KVM, especially in
the context of a cold reset of the QOM vCPU. The same applies when PSCI CPU_OFF
is being handled by Qemu, it must ensure that kVM vCPUs are powered-off as well.

To ensure this synchronization, mark the QOM vCPU as "dirty" to trigger a call
to `kvm_arch_put_registers()`. This guarantees that KVM’s `MP_STATE` is updated
accordingly, forcing synchronization of the `mp_state` between QEMU and KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/arm-powerctl.c | 1 +
 target/arm/kvm.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index ab4422b261..89074918a9 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -263,6 +263,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
 
     assert(bql_locked());
     target_cpu->power_state = PSCI_OFF;
+    target_cpu_state->vcpu_dirty = true;
     target_cpu_state->halted = 1;
     target_cpu_state->exception_index = EXCP_HLT;
 }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 98eb6db9ed..c4b68a0b17 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1026,6 +1026,7 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     int ret;
+    CPUState *cs = CPU(cpu);
 
     /* Re-init VCPU so that all registers are set to
      * their respective reset values.
@@ -1047,6 +1048,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
      * for the same reason we do so in kvm_arch_get_registers().
      */
     write_list_to_cpustate(cpu);
+
+    /*
+     * Ensure we call kvm_arch_put_registers(). The vCPU isn't marked dirty if
+     * it was parked in KVM and is now booting from a PSCI CPU_ON call.
+     */
+    cs->vcpu_dirty = true;
 }
 
 void kvm_arm_create_host_vcpu(ARMCPU *cpu)
-- 
2.34.1


