Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607BDC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegZq-00064a-W9; Tue, 30 Jun 2026 18:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXu-0003KZ-Ut
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXm-0003yI-FZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDkDV2959586
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PU2nAJTGYp6CGHXCfxh2HO5DrIysP1r8Qcr5JVkdKOY=; b=S/90EKuSHhMWD2NH
 z5SGwKOAUnbbQm9et2IXJKoJAIxD1Hz2EsRzDswfMX32q75IstPQkPXEtAnL4g2+
 K8KqhHc2kA3y/gvs/xEf/QCciUfvVqo4DTRVHngGZCKWyuzO8vb8smB+F50Nz2hW
 w58OjEVlWmIGvjDNCPDUJ1K/R8bH6h2AMWOCPHamt2rkvKZ9I3GDSWqWYLPdUFcM
 33FAU9yHUez02LAA1Ybc5ZcwlWrXVi3w4DT6k8C3lLY50uK6H0u0izKVqWgFeEH+
 28/3i7qThZcLBNjyYpEKzwNTv5+GgHTQ6ZLqDptlhChYI7Qi8f1syPsSjnl8MfqM
 bI/sqQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jkt8y3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:51 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-48952d1c293so58343b6e.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856970; x=1783461770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PU2nAJTGYp6CGHXCfxh2HO5DrIysP1r8Qcr5JVkdKOY=;
 b=iPA9JJ3vOgUsj9ZGTHv5DzHy/It9G0TKoRyVulzFTl+yef1R5yWbJkp8ThcYObTn5B
 6vmA9FcdtrtKZcrJTzsPemCLfEQnmj63sm0aEm1IzISmp8zMRXOE+iuSSzEw+pdFMveH
 v3eYv9GcnI1e7g5yiEYEYzy3rzyMA2JBP/cUjOvzm2wcysEWw69mAn7gU2/W0WqYVMpn
 fuaoENLDeDJULLg+UGwxBjav4AhxbFcwVsfzFZw5AIPFVstLA6abjQpBugUD06NfMMDC
 d+R9tHrs3dAeXjIlmc+5RhQjyt52dmQ+N6LHZQ1aCGPVHC2RuI3xyJBW7tlCJfFclacQ
 dovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856970; x=1783461770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PU2nAJTGYp6CGHXCfxh2HO5DrIysP1r8Qcr5JVkdKOY=;
 b=fdRXeJpntg0P87ItXOC8orFjD0KkppF0VqZURPbI1kQCKXFWRivjOZrTlW4jRfqY/l
 KNI0ZFBHzfJ00iDS3q5yT6SobXsh2LCMc1zNNv3VM0jNGdN1jVep2MonqtgotaUp7IsF
 n9oPifLvnEAbaL72lfrUM7o1lw+Op09+Di7GKiJs1W4mq+LI05VcCiBJxJkxnB2gN9iX
 tr3qwXUt6oNBw0N3rJedEHe/PBMXVbT/zd6GonJgpy8bz4vA2Ctucb1HdMgjzYamSg0M
 2ZB9UlEWFFFYxgjC7VpzvzfD8nLb3MCeNxn9fhaR6N2PBWFTiWzdyZO4N5k/C2K6dGet
 2MBg==
X-Gm-Message-State: AOJu0YyyEb7QplDIBum9uWnVqqHFRyoW0AZFxa8BNa8MpMaoI1j3O7qU
 icN1k3TgIaYvyXWpluvbV8rbyrX5kn6pfCV5M1Vziv0q/s/cB0O72Mr7KpvmCqrsgmjCkB1diJA
 0rDKh6ltLZxJ66rdQPPSxq3Mqohic9R8SHDvTNgU2mz4IhZudr7yaNzF4Y4ZVZfVYHA==
X-Gm-Gg: AfdE7cl6OkfXo2qR/OqGhEqbBX+4Uee+0EvYnYqsEwWns2Nvu6sDgrZ65RyADHnvt8w
 Yd67io6YS2A0sqIOG9g1e0NUk+tItHKk1zWzQxRdt53qvoWu3x2rZevAZ0obB10cr2RVbXHrNEG
 2ZglOGwXBgNw5Jdfjnh1mgMkBPcDNhcQ2u2Uz5Nj9S+EczItXMScEp2F+cXBSz+Nz6UZjH+Vkkw
 DUIj1Om8cY5fwQ1LQM0Oc0OsQAPW20+DCx7wERvBR7YysHeK15CqD7P2JVTjLsRKCuzx3wld0rh
 dSchQJyzFXbIukoQn3I172CiJaOnuIZTnOMynhhMhWrJUnUloSFow6daUFxznj8A9IfL6dltT4X
 27lHjkhHlDVkSsUuH9euP0bVG4tCmd2qN2Kto8zzCJAthUYgbp6LiNeVUvPXhXJQewz+K
X-Received: by 2002:a05:6808:4fcd:b0:495:fd95:5fa9 with SMTP id
 5614622812f47-495fd956143mr1605809b6e.33.1782856970448; 
 Tue, 30 Jun 2026 15:02:50 -0700 (PDT)
X-Received: by 2002:a05:6808:4fcd:b0:495:fd95:5fa9 with SMTP id
 5614622812f47-495fd956143mr1605788b6e.33.1782856969959; 
 Tue, 30 Jun 2026 15:02:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475643cd64bsm11901398f8f.14.2026.06.30.15.02.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 14/33] accel: Move supports_guest_debug() declaration to
 AccelClass
Date: Wed,  1 Jul 2026 00:00:41 +0200
Message-ID: <20260630220100.1289-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX+iru4sEw/s26
 7gw97iNMuOUDqDG88f/JYjdSmpTclINQwYMhXTKv49GNHy8Lqajk2E0mcxRnzz+3xV0f3xfpcH1
 vIunTjNpY7niavV2a/Opcpwmw3qfgYk=
X-Proofpoint-GUID: kRaf-C9bOhJm4npmLeBw3NQz0QHH3_YY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX3OoF+hZJkeZM
 lErf+9VIgUimFHtNS+fvFUOZVGamTJT6Plrpir3/1S3X+gt09131DiTLSJgSj6CtX/UEuGRR8Wg
 l94jqkn68/hOMd6D4f2tMXq6IoaAkdU+P120BTPGMfr5GYuSEP+yHBFvPD8xhwQXtolkPewBLUe
 p6OsS7tiSKVEguKAxcCo37BQ11YWHMQpnM7nc9vB7E5KwnkVGhX00wzy9IdE6mLDGSOyjUQnjtp
 i52GjeWkuM9j7a4NSKtajKyL5WUN5JlSZHxwgwtFWdskbaKqBWX1+9u2sr83BBifjsVXKbg6AjH
 ECsJ3dPgbSzmZ9RZq1ybHSwDhzI8vQzhDrEtbFYi5wcoa+fQ5yemZoClS8JovS/WYRakhXz8lzV
 HMrydTRgmfH5oKyMmw0UL/fdM64Cx7TSUNyMp46K8ULwiOizTUBOQlAOGFf1y1gkwbID+/G1gdU
 fYpY4tyWRgwRZQJXrng==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a443d0b cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=d9gndd0ExkgcL6hwJkoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kRaf-C9bOhJm4npmLeBw3NQz0QHH3_YY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

AccelOpsClass is for methods dealing with vCPUs.
When only dealing with AccelState, AccelClass is sufficient.

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Restrict kvm_supports_guest_debug() scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-cpus.h          |  1 -
 gdbstub/internals.h           |  1 -
 include/accel/accel-cpu-ops.h |  1 -
 include/accel/accel-ops.h     |  1 +
 include/qemu/accel.h          |  2 ++
 include/system/hvf_int.h      |  2 +-
 include/system/whpx-all.h     |  4 +---
 accel/accel-common.c          | 12 ++++++++++++
 accel/hvf/hvf-accel-ops.c     |  1 -
 accel/hvf/hvf-all.c           |  1 +
 accel/kvm/kvm-accel-ops.c     |  1 -
 accel/kvm/kvm-all.c           |  3 ++-
 accel/tcg/tcg-accel-ops.c     |  6 ------
 accel/tcg/tcg-all.c           |  6 ++++++
 accel/whpx/whpx-accel-ops.c   |  7 -------
 accel/whpx/whpx-common.c      |  1 +
 gdbstub/system.c              | 12 ++----------
 gdbstub/user.c                |  6 ------
 target/arm/hvf/hvf.c          |  2 +-
 target/arm/whpx/whpx-all.c    |  2 +-
 target/i386/hvf/hvf.c         |  2 +-
 target/i386/whpx/whpx-all.c   |  2 +-
 22 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 688511151c8..3185659562d 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -16,7 +16,6 @@ void kvm_destroy_vcpu(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
-bool kvm_supports_guest_debug(void);
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 void kvm_remove_all_breakpoints(CPUState *cpu);
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index dbd6d11eb8c..dbae07d2577 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -217,7 +217,6 @@ void gdb_syscall_handling(const char *syscall_packet);
  * Break/Watch point support - there is an implementation for system
  * and user mode.
  */
-bool gdb_supports_guest_debug(void);
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len);
 int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len);
 void gdb_breakpoint_remove_all(CPUState *cs);
diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea0..b23a0606c7e 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -84,7 +84,6 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    bool (*supports_guest_debug)(void);
     int (*update_guest_debug)(CPUState *cpu);
     int (*insert_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
     int (*remove_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 07241f799a8..e961f37cd61 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -37,6 +37,7 @@ struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
+    bool (*supports_guest_debug)(AccelState *as);
     void (*get_gdbstub_config)(AccelState *as, int *supported_sstep_flags,
                                bool *can_reverse);
 
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index e740939908a..c520feaa38d 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -73,6 +73,8 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
  */
 void accel_cpu_common_unrealize(CPUState *cpu);
 
+bool accel_supports_guest_debug(void);
+
 /**
  * accel_get_gdbstub_config:
  * @supported_sstep_flags: pointer to store the single step modes in
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 58fb865ebae..ca0d4034e0f 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -107,7 +107,7 @@ int hvf_update_guest_debug(CPUState *cpu);
 /*
  * Return whether the guest supports debugging.
  */
-bool hvf_arch_supports_guest_debug(void);
+bool hvf_arch_supports_guest_debug(AccelState *as);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 4022571ffff..1b4389c052c 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -9,6 +9,7 @@ int whpx_vcpu_run(CPUState *cpu);
 void whpx_get_registers(CPUState *cpu, WHPXStateLevel level);
 void whpx_set_registers(CPUState *cpu, WHPXStateLevel level);
 int whpx_accel_init(AccelState *as, MachineState *ms);
+bool whpx_arch_supports_guest_debug(AccelState *as);
 void whpx_cpu_instance_init(CPUState *cs);
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
 void whpx_apply_breakpoints(
@@ -22,7 +23,4 @@ void whpx_translate_cpu_breakpoints(
 void whpx_arch_destroy_vcpu(CPUState *cpu);
 void whpx_arch_accel_class_init(ObjectClass *oc);
 
-/* called by whpx-accel-ops */
-bool whpx_arch_supports_guest_debug(void);
-
 #endif
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 41f98937426..db27f96c916 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -113,6 +113,18 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     }
 }
 
+bool accel_supports_guest_debug(void)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    if (acc->supports_guest_debug) {
+        return acc->supports_guest_debug(accel);
+    }
+    return false;
+}
+
+
 void accel_get_gdbstub_config(int *supported_sstep_flags, bool *can_reverse)
 {
     AccelState *accel = current_accel();
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index dd2b45b7cb5..ecc0cd1b558 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -369,7 +369,6 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
-    ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 
     ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 49014de26d1..8ca6d9f5d32 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -280,6 +280,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
+    ac->supports_guest_debug = hvf_arch_supports_guest_debug;
     ac->get_gdbstub_config = hvf_gdbstub_config;
     hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index d7967bc922f..45330327909 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -105,7 +105,6 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
-    ops->supports_guest_debug = kvm_supports_guest_debug;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->insert_breakpoint = kvm_insert_breakpoint;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0019a092d69..1231c010fce 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3833,7 +3833,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return data.err;
 }
 
-bool kvm_supports_guest_debug(void)
+static bool kvm_supports_guest_debug(AccelState *as)
 {
     /* probed during kvm_init() */
     return kvm_has_guest_debug;
@@ -4303,6 +4303,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->rebuild_guest = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
+    ac->supports_guest_debug = kvm_supports_guest_debug;
     ac->get_gdbstub_config = kvm_gdbstub_config;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index c179cd4adeb..927af6c1db0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -109,11 +109,6 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static bool tcg_supports_guest_debug(void)
-{
-    return true;
-}
-
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
 static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
@@ -221,7 +216,6 @@ static void tcg_accel_ops_init(AccelClass *ac)
     }
 
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
-    ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 2d2aab80d17..19d776faf27 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -242,6 +242,11 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
+static bool tcg_supports_guest_debug(AccelState *as)
+{
+    return true;
+}
+
 static void tcg_gdbstub_config(AccelState *as, int *supported_sstep_flags,
                                bool *can_reverse)
 {
@@ -268,6 +273,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
+    ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->get_gdbstub_config = tcg_gdbstub_config;
 
     object_class_property_add_str(oc, "thread",
diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index b8f41544cbe..f38bd850ce3 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -82,12 +82,6 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
     return !whpx_irqchip_in_kernel();
 }
 
-static bool whpx_supports_guest_debug(void)
-{
-    return whpx_arch_supports_guest_debug();
-}
-
-
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -96,7 +90,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
-    ops->supports_guest_debug = whpx_supports_guest_debug;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..db1d9d43744 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -527,6 +527,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = whpx_accel_init;
     ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
+    ac->supports_guest_debug = whpx_arch_supports_guest_debug;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, whpx_set_kernel_irqchip,
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 1421645c6e5..414aef431ec 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/accel.h"
 #include "qemu/cutils.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
@@ -343,7 +344,7 @@ bool gdbserver_start(const char *device, Error **errp)
         return false;
     }
 
-    if (!gdb_supports_guest_debug()) {
+    if (!accel_supports_guest_debug()) {
         error_setg(errp, "gdbstub: current accelerator doesn't "
                    "support guest debugging");
         return false;
@@ -622,15 +623,6 @@ int gdb_signal_to_target(int sig)
  * Break/Watch point helpers
  */
 
-bool gdb_supports_guest_debug(void)
-{
-    const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->supports_guest_debug) {
-        return ops->supports_guest_debug();
-    }
-    return false;
-}
-
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 2cc851691f7..299388b9f71 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -790,12 +790,6 @@ unsigned int gdb_get_max_cpus(void)
  * Break/Watch point helpers
  */
 
-bool gdb_supports_guest_debug(void)
-{
-    /* user-mode == TCG == supported */
-    return true;
-}
-
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     CPUState *cpu;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b902c68829..f76bd7bf55d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2901,7 +2901,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps(cpu);
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return true;
 }
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..ec65e332f9c 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -295,7 +295,7 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
-bool whpx_arch_supports_guest_debug(void) 
+bool whpx_arch_supports_guest_debug(AccelState *as)
 {
     return false;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2d1a943b96c..bb8a070903c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1067,7 +1067,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return false;
 }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..95705522e04 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1853,7 +1853,7 @@ void whpx_apply_breakpoints(
     }
 }
 
-bool whpx_arch_supports_guest_debug(void) 
+bool whpx_arch_supports_guest_debug(AccelState *as)
 {
     return true;
 }
-- 
2.53.0


