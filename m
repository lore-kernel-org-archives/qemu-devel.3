Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D172DCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Df-0004xD-5C; Fri, 29 May 2026 15:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3DY-0004oA-OJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3DW-0004HT-AG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso86351175e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084200; x=1780689000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn1TfSGGJHYXoT5p86UQzNNg6yKLfh8iH6VFrIwRfTU=;
 b=EI4L2/6sAulMJ+uM39T4knyYDbRcNtG57hwYRCWwiIYi9Rf2j4LdqDNN+HhO9/5+0z
 rPClJWgFQAKqut6w4EQ9SRd0PhItD2r0Jx/zkgh3iCX0qKA3r4+UXVNJ3VPR83Ge1CpG
 YOqKxMlXgzMFy99QmG/78dcDdfSEUq0y58PPGP4yijeAv9+FbNB6gyGGgPGqd1bGzaCz
 ncg7pS4ybga4TmtbVI5wMfNUArgJ51c0YprybixXTPOI1ehwTa9bwG0lNuPwDoEyLp9z
 64zbuBGtntRLcBVG8DbQQLyiwgIinJe6E5s0bdmjiF9pJ078j3CGewAV8XTVnKrzUsHg
 p4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084200; x=1780689000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vn1TfSGGJHYXoT5p86UQzNNg6yKLfh8iH6VFrIwRfTU=;
 b=RnU8GOszUL1fTn5j9lUPGnQoSVOmdWlckbUUJcNoCJ2u5M2r3CvhJxpRWsO6+gmZ2r
 I9oGKcueNX5zTHYavzM9a2IF4WvmmpCygoHy/lDEfdhKJWT+bziMIVFwaJ981W1l98Fj
 lX88ASHblfHte/dj6UFQu6Me0ouFWkgOjRy8ZOAWjW28um+fH+l6+X87YwCfi6S6N+ps
 JWvrNdVeMid1KpbQC+M0kmknOuKOU9zr2TCSrrCFZG9ntQ6JkZa2YLG/DzQTMgLPx2K4
 HDg4FpfgGOXjRJ1GOJp6jvQV00WPmt1t75AupBB77VuoC13PGI8B41AGxqg5PNWxpjIR
 UiVQ==
X-Gm-Message-State: AOJu0YxvZx3V8nLP9iikHag87zgzUe43aj+nSSEoD11oxySUGWwHWRCI
 uhSocL25TMbHVZCfImc0FG95rkWq4h95rvetha3fY6Yfeb0L1hipU4w1OHzCogq3EkMKLI8471G
 oVlHhmpD5Xg==
X-Gm-Gg: Acq92OEfi94QrZmLbRw49wFpUs0XwHBTTzYXQwwy8rz6h3YShd6XkJ0SwF6UuBjJKGn
 OX7bTeT/14IJ2r3IWzGABx9GGznlhZmMUSKch8kLeS5WRZrpdwVGaQE7TgrZqfpLi76fd2KypB9
 dpG7g6v2iHkY7yqFokv8pZXPd88x7m+ee1g3CJs2hAUc6V95EnVhXrju2dT8b6/wus501wnRJZt
 T08BqNq2HphRYV3iZanK3MoQDkr2xhLug8FeDxdzKDhFISSrp1how3EhLsk2WYdHBGKmnjZUNmp
 60tYuLnuStQowMjr0uGRU1F11AspygAOBqtYPV/L5Zyzj80w3gFheEIzFJ1D8rFT3HF/ocAJm/i
 Kjl2HVx90xflzoan3Ea3tnSmCCN+1kei7B8sMbE1U8e+Wl/psUHj5bJ8N4lYE7h50t3eQUFDTcE
 cQNH7VmBn9VN+ZsHY2huBI8Qcg+zLMkjhCHrqsSHejVRP2HE4HOpR0OGtWPtTa7Jx/DQ==
X-Received: by 2002:a05:600c:314e:b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490a2968488mr16252265e9.25.1780084200053; 
 Fri, 29 May 2026 12:50:00 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef357635fsm5573661f8f.33.2026.05.29.12.49.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:49:59 -0700 (PDT)
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
Subject: [PATCH v2 02/17] accel: Remove AccelCPUClass::cpu_class_init()
Date: Fri, 29 May 2026 21:49:24 +0200
Message-ID: <20260529194940.97143-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Last implementation were removed in commits f50d0f335a6 and
a522b04bb9c ("Remove AccelCPUClass::cpu_class_init need").
Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu.h |  1 -
 accel/accel-common.c      | 33 ---------------------------------
 2 files changed, 34 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..88c0815e2d8 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -15,7 +15,6 @@
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-    void (*cpu_class_init)(CPUClass *cc);
     void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 62590a7d9a6..ebc103053dc 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -32,42 +32,9 @@ const char *current_accel_name(void)
     return ac->name;
 }
 
-static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
-{
-    CPUClass *cc = CPU_CLASS(klass);
-    AccelCPUClass *accel_cpu = opaque;
-
-    cc->accel_cpu = accel_cpu;
-    if (accel_cpu->cpu_class_init) {
-        accel_cpu->cpu_class_init(cc);
-    }
-}
-
-/* initialize the arch-specific accel CpuClass interfaces */
-static void accel_init_cpu_interfaces(AccelClass *ac)
-{
-    const char *ac_name; /* AccelClass name */
-    char *acc_name;      /* AccelCPUClass name */
-    ObjectClass *acc;    /* AccelCPUClass */
-    const char *cpu_resolving_type = target_cpu_type();
-
-    ac_name = object_class_get_name(OBJECT_CLASS(ac));
-    g_assert(ac_name != NULL);
-
-    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
-    acc = object_class_by_name(acc_name);
-    g_free(acc_name);
-
-    if (acc) {
-        object_class_foreach(accel_init_cpu_int_aux,
-                             cpu_resolving_type, false, acc);
-    }
-}
-
 void accel_init_interfaces(AccelClass *ac)
 {
     accel_init_ops_interfaces(ac);
-    accel_init_cpu_interfaces(ac);
 }
 
 void accel_cpu_instance_init(CPUState *cpu)
-- 
2.53.0


