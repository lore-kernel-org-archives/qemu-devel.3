Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C479C25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cnz-00066F-0q; Sun, 28 Apr 2024 18:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnx-00061i-O6
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnw-0005ZZ-1w
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:29 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso4652304a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342525; x=1714947325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RJjHdtnEQClT/5V8x7FhF0J3whe1EfuKPVVZmDDkK4=;
 b=nqaQx9c8dKopl/2s57gcVSfaY0ANk2drDnDypALID2sgAxalETfImiGpRnvq27Ma8Q
 Yap+nbKr/5lFa/jFf2CEEFDMVU0HZL2C68QByCJpps08tVhmtgebDQJY+clBdFDP/KEg
 rQLt100pGDt1ImHf3+zlGUFDQ+EIVThDKUNZ33HQwBVlV2/5iX+87RWUrTizXEr1Z51P
 BG/rVcMP78iU3Bg5V0h154VSSuL5vfHKq1pkXGQGosOtKGcPX5203yEmP1o5/KytQ++6
 l3yKKlYzSGt+8NxfVfsEQ4bofTIdHkif2D6CE9N7Aj8JGTIHQL1+sAQTaGwxGrsFcRs8
 FDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342525; x=1714947325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RJjHdtnEQClT/5V8x7FhF0J3whe1EfuKPVVZmDDkK4=;
 b=M/18YXuUU8LCg+yArJUBNY7J/ZeVUEyAxol7pJwki+n1gX6QgJsSEB6vgLkvoKaABo
 KLCIgNczmqc0uMYWxAfZcHLTgdaLti/Q4+fDVuPDxZOqaH6/sRdhCCIjmhaBC74QdZUN
 iihjjSY0hNEe1vKUz82xDoMq4DZ8OUHF5GZuF+2EkkE4fMCSybO/HG97TLRzNWp0/ssm
 VtSR04505+ANfCU99YrJSk4Qs2igG1F86J7srXt/+qsz5hAsMEMagfxY6+aqsoslZ+2t
 qe+/xUDVZc1FpXFWFpP8jCXl7n9XN2HLbwuuG0Y3LJrdVZJEqM1hrEHDt8bieApguzfm
 tRiw==
X-Gm-Message-State: AOJu0YyOGFGvtbulPI6RgsRVmjFC2ztPqYKtpyJKRZHytQgEqnoj13ta
 mlmnU5VLTQW0KvA4ZjahXKeYd+wKHUwZXTct9AwbADFicWQ9J68j/12llY7/mVjJYG1gKDGyWTx
 H
X-Google-Smtp-Source: AGHT+IH78rGkc/c0pgTkWMzYhfX3Pv4uqiYrou0YkKSfhtawmFsQ8IIiNWFh2MDpt1yHMHRyB2Yf8A==
X-Received: by 2002:a50:bb6f:0:b0:56d:b687:5a45 with SMTP id
 y102-20020a50bb6f000000b0056db6875a45mr6453066ede.1.1714342525576; 
 Sun, 28 Apr 2024 15:15:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a056402139100b00572047bf766sm8479321edv.51.2024.04.28.15.15.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/24] accel: Introduce AccelOpsClass::exit_vcpu_thread()
 handler
Date: Mon, 29 Apr 2024 00:14:32 +0200
Message-ID: <20240428221450.26460-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Introduce a per-accelerator handler that can be call
when a vCPU exits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/accel-ops.h | 1 +
 system/cpus.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
index ef91fc28bb..35dfb7e266 100644
--- a/include/sysemu/accel-ops.h
+++ b/include/sysemu/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
+    void (*exit_vcpu_thread)(CPUState *cpu);
 
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
diff --git a/system/cpus.c b/system/cpus.c
index e0530ad603..d0d585e8b9 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -425,6 +425,9 @@ void cpu_exit(CPUState *cpu)
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
     qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    if (cpus_accel->exit_vcpu_thread) {
+        cpus_accel->exit_vcpu_thread(cpu);
+    }
 }
 
 static void qemu_cpu_stop(CPUState *cpu, bool exit)
-- 
2.41.0


