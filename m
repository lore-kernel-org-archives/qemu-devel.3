Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0561EC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hZ-0008N3-Hk; Wed, 02 Jul 2025 15:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2h8-0007AV-5C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:41 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2h6-0003YT-9H
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so4496537f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482830; x=1752087630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVv77+T3+ACMfJtq+FwRrQOYxT41VnoDNDgY/IfZvIE=;
 b=JBT+1dAL6Hta2zQGK2fWUcDfhn1fQ3Lvq0YLEg7diu6wL5yu1voJXN0Hu5URv+g0Tk
 J1nFyjEcSxBeySEk9wdr47vwYgUHEmXpRuKctlXmOZOrCe+m4Iu86Ach0KGSYHrhfNIc
 IFHqitlF/Z7KgQn0Xo5UJWFsVqXrIOZuZ7lFkFHLd5AOtqHiR6D2kXZplhg0a4oT4yiI
 +kd1zYTgomIhCO3tCcRa5xYiCDrJBz2Xq7rJbsFqD5svtQk6IasM7c0AhTJ3WQEIo6mU
 EsY+kLzsfCbn89nhoBZh2neDzdcyZPE811GQiAcXN14nL9fU/6hkM3KZqGXrxcxniEz2
 xvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482830; x=1752087630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVv77+T3+ACMfJtq+FwRrQOYxT41VnoDNDgY/IfZvIE=;
 b=uXIFLqknbZVoe3ReTEGdgjK7fJ0eMPq06uo4kamF5E7G2opJJ7au9z45/vYw56lucs
 ypuc7NdPH4CIH8ADQpu97wuAiSR0LAJjNeLdQ2ddNOe6BedkceKoUfGfynX9uDU4bBkh
 HVIcApb315tOaw6DhmHhI+qi13WnxFkMqQOIK3KuleiwLMyFoFKIYaLTgSuuWVZKlpl9
 CzyjXJGicjzE6fk61Y53z87Yamm+Wbxjo0ypcgPcutJ9llvVlhvf4pELlGM1sua3Amx/
 +KwnircJEOiU5XZnUK5UZrzsnYaMWXAwQtGYw844F5X1GQV5i+OHsFnK8m3ZNDnhtmGp
 BxQA==
X-Gm-Message-State: AOJu0YyLV77Xyfd2FDmJeX08mbmJOLwaDj/nUkT5UuMGCGRSYuRIHgEx
 w6e4syIfbeTddopTgzbCM1T8M3I/j3Frb3ms+w7QOHahqF0ZjFOUwknKN3AfAcTdC26YUZ+C9pr
 8Vq75
X-Gm-Gg: ASbGncv2QD2V7u3GWjXdjXCkcAuSk7l64DHKg8FovuHsYfDs676uCSvWOaSUEgZFJAo
 UNlu862lTwRIXNPDyh5aDBVN3urOkad7x2Zh6di4h5+jkQ74K8zskpYf0ApCvZ8+nr50KufpqsF
 qcAIoGSN20jLXrJ7yofKo3e06zDEaehBBT715lVtZEjVqyh6DO36W1Kzycw9wacML3vdTRcMM2k
 tFTWpfGJjv0wM/9thIvempxtAj81OHwl2bNC5edrUcHYwthsitNq8zlcNnjhmdCpGSifWGt4/CP
 4kYJoRaukt8KajRC5QCnANqW+RbF0C+yXtXE2XAyfpStDMJEcQE/fH/o4m7gtRJSWsBI8QT00+n
 l0Ks+152QOK+zJ9jEgqPC/BNXypb0AW1Mv37l
X-Google-Smtp-Source: AGHT+IGma+r82gDRg/4iKpw8G/6qQzJjoyC2DBUU4JDIyKs5+ddWQBn5Jf3e8VyjUhK4em0OWNP+cg==
X-Received: by 2002:a05:6000:188e:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3b32b145797mr291997f8f.7.1751482830055; 
 Wed, 02 Jul 2025 12:00:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa8fasm16625000f8f.28.2025.07.02.12.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 61/65] accel/tcg: Factor tcg_vcpu_init() out for re-use
Date: Wed,  2 Jul 2025 20:53:23 +0200
Message-ID: <20250702185332.43650-62-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 ++
 accel/tcg/tcg-accel-ops-mttcg.c | 4 +++-
 accel/tcg/tcg-accel-ops-rr.c    | 4 +++-
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 3f8eccb7a7f..a95d97fca29 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -20,4 +20,6 @@ int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
+int tcg_vcpu_init(CPUState *cpu);
+
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 96ce065eb59..4de506a80ca 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -79,8 +79,10 @@ void *mttcg_cpu_thread_routine(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
+
+    tcg_vcpu_init(cpu);
+
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index fc33a13e4e8..9578bc639cb 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -192,7 +192,9 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
+
+    tcg_vcpu_init(cpu);
+
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 780e9debbc4..6823f31d8ad 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -77,6 +77,13 @@ void tcg_vcpu_thread_precreate(CPUState *cpu)
     tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
 }
 
+int tcg_vcpu_init(CPUState *cpu)
+{
+    cpu->neg.can_do_io = true;
+
+    return 0;
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


