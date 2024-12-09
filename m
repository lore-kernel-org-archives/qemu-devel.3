Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B2DE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkV8-0006Dl-Vj; Mon, 09 Dec 2024 15:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV4-0006CQ-WD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:03 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV2-0003Cb-Up
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:02 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa69251292dso222900666b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776619; x=1734381419;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bli328WsnAA7e6BAnLZlQPV2xXXE4Q5muDDz6zeVzNM=;
 b=e6oeiZpu0b+UIZK1QOuPmuI2msBB1BuTwvXFfHhiw8CVH7Tnbc2211XO7RkVhIw6ik
 OXRai7b4PdnVJ6c/1cKKc8wSqkSZL+YDPu83cybp/qbn+4DQBc8tEkGnYcm6HjkyNh4k
 VF4CesNILgEVk63FIW3SDj9ef6LIdchq/WdJZRn7VNemDmmhtX5RuCFaNq0TRKyge7nM
 XqVdPobYKbUR4i+xdZcTF7zJbgSfaKFFOckagEX7PMbKMDZQcdSTA8ngcMSRl2DJFV7l
 gNLPspyDpm6Dj7G2XI4tFXGxbwGeE3b1vrlKp657TcM/Cg7PkU/2m0LrfA9lX3ImfgBY
 AfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776619; x=1734381419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bli328WsnAA7e6BAnLZlQPV2xXXE4Q5muDDz6zeVzNM=;
 b=v78k9F8CRSZukGVKRjA2yG4HP5vsQVsQEJRLBtwGdBGUywhSpz+XhqrDGYomg+ZlC8
 SKKsXLrsClS2/oJUzVd0KRfuIHaiHYEyuCT5HHSg1F12d20+mDbffbpei5Q+MbSFS76D
 TsAQyE9xI8QtIqYSRfH8NEmTetYjDKXZDGNickEXzvRvxny4hBtU3KTmJmvp5MMseY1V
 zFkXLYAaiGknqUN5/RVBv2vfhe1hgHC5P+b3KGbvjylK/AHVsBIXm/Ugp75XOUFvsSvB
 9mKSysUobNBiQqMgk045FqeYPekI/2+Zpv4jY8Nr3ZyxqxKhksecuhmuzGMraP4WBiyb
 S4Kw==
X-Gm-Message-State: AOJu0Yw0YY2DVuPER/EupqVuktiIu2phdamAf+2HOytHbu4538P8zrfj
 ahefzSGmIlltPyY19hXYNx9BpV+1vEfT7CNxxtDMW8QUn9h5DjjA7Pr/PT0drHwow1TfiL/Ri+Z
 jPw==
X-Gm-Gg: ASbGnctrsUP9TBPStg54GOzF2PZBMmL9rEoiJ/vUkFbzmJIFAA0bfzrmEkCmnus0Xq4
 3MftocTNxsozeexScRIVpsYBo1NJO+uoL+M4aWrlXusitp19fXjy88y7IIgTLMW5KT82a/Aglvk
 Neg1wHqzsqyb3xMUKjwwZkFAkGyF0b4siqDwiHYHqMG/dIfkAwce89gZDrwYUIUOvfy5bywc482
 Iv1MgB2Hckj/lIc5eicj8yY9EKTG50sojHNjpT16b7TMcnlw8BbuRWvd8Uc0BnSDEoirmZJjp9k
 KEw/9DSDMWANI5ylOUWTweOWSuVllw==
X-Google-Smtp-Source: AGHT+IHAgIfV0CH2ESB7U0RihyDwcsE4KwhWx9RoRlyJl0MzLDwtmoS5iSRTNbAC864Z/Y6LGGs1Cg==
X-Received: by 2002:a17:906:18aa:b0:aa6:80ed:e9af with SMTP id
 a640c23a62f3a-aa680edeb9cmr609832566b.25.1733776618468; 
 Mon, 09 Dec 2024 12:36:58 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:36:58 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 01/11] hvf: Add facility for initialisation code prior to
 first vCPU run
Date: Mon,  9 Dec 2024 21:36:19 +0100
Message-Id: <20241209203629.74436-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62a;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Some VM state required for fully configuring vCPUs is only available
after all devices have been through their init phase. This extra
function, called just before each vCPU makes its first VM entry,
allows us to perform such architecture-specific initialisation.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 accel/hvf/hvf-accel-ops.c | 5 +++++
 include/sysemu/hvf_int.h  | 1 +
 target/arm/hvf/hvf.c      | 4 ++++
 target/i386/hvf/hvf.c     | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d60874d3e6..c17a9a10de 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -442,6 +442,11 @@ static void *hvf_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    if (!cpu_can_run(cpu)) {
+        qemu_wait_io_event(cpu);
+    }
+    hvf_vcpu_before_first_run(cpu);
+
     do {
         if (cpu_can_run(cpu)) {
             r = hvf_vcpu_exec(cpu);
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 42ae18433f..2775bd82d7 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -67,6 +67,7 @@ const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
+void hvf_vcpu_before_first_run(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 int hvf_vcpu_exec(CPUState *);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ca7ea92774..0b334c268e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1061,6 +1061,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+void hvf_vcpu_before_first_run(CPUState *cpu)
+{
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     cpus_kick_thread(cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c5d025d557..3b6ee79fb2 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -338,6 +338,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+void hvf_vcpu_before_first_run(CPUState *cpu)
+{
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.39.3 (Apple Git-146)


