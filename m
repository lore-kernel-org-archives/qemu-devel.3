Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B642C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 10:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSwlH-0005S5-DK; Sun, 14 Jul 2024 06:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSwkx-0005Qd-03
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 06:47:07 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSwku-0002EL-U3
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 06:47:02 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c9cc681ee4so1903256b6e.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720954019; x=1721558819;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TJ61kCrC/rs23cmc0FgYb0iNb708I3WzZcj94T88GYw=;
 b=OLlaUDLAUVa+yCcbtOvRsVY7uUfnVA0wFj0DUbdjUnthcxF3JiT4ldq3sH68PhQ6Uc
 X8zPrtJZtysvrgy5p4bKeOikIA8/0tDYSLy+BLcGVgI6cbtjNXgqoT2zpNBPMaQw/Aat
 hXvEIAn++QGlFht/UxXX6OwUhqPmMhoihT8obLd1wP4SnoU0HatFr/2F0JLUN93Dptep
 hqaysBbrqj2s09tlgEjBhqRlGdhcLYnSNUYOv3h7kc54x/twPtH34aLO4TPLq07kEYo9
 2wL9Wwi5fUfoaVq+CgmqVsJcEj1D7QZnLZ3iX4O+oCQQiXkqZtmquXLwdUFB04vreGHs
 vZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720954019; x=1721558819;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJ61kCrC/rs23cmc0FgYb0iNb708I3WzZcj94T88GYw=;
 b=A8LpfDhdOkiGZXHCW8PojQs50u3zFy9w2PhC1kpDn05WJEE+Vv+igoQsx1J7e+3HKf
 8yXJTchFPFQJDLjeihwnjMQC8fOhqgBAHqIHLSku3CKsB6PrN2clXWzH7Ku+d8k1EEBX
 AjQJOLgMSSvNK1xEr5cBzq7pjbkYlYqUsvhSnDCI967u2uiXzxKnjX9/orZW5JHiGxjh
 ZVnTuyLhuafiND27nI70B2A+IS5L6bJtvdq7q+x5PQym3PSGb+ZKc070MklzWQ6twQkk
 1+Hfayz/gUuzNFvQtSE2bOtM5VpEe6/qPrWuI7Nk6k4TyU9+7t4SjQZHe53eec8/bynN
 LLlw==
X-Gm-Message-State: AOJu0YyM9pUwcy3FXScvLwDVHdX/SIswLy48DA7D4gM/dq/PDU5vztWD
 44SmGSVK/q0mJpKiXgUhLbsYd+YCM21qbLvRcY0Z65Y1AO+uRD1gJAGbcok3pxg=
X-Google-Smtp-Source: AGHT+IEfk0845Dpb6BGhgdFwDNBnpvt7325QFpH6CuS6ZWTAwZYCClTJly2aQ58uMvf4X0ZxGWj+6g==
X-Received: by 2002:a05:6808:159e:b0:3d6:4eb3:3c54 with SMTP id
 5614622812f47-3d93bee94eemr20350834b6e.11.1720954019587; 
 Sun, 14 Jul 2024 03:46:59 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bb6fedesm21941075ad.15.2024.07.14.03.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 03:46:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 19:46:52 +0900
Subject: [PATCH] cpu: Free queued CPU work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-cpu-v1-1-19c2f8de2055@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJusk2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MT3eSCUt1kkxQjCwsj4ySTZCMloMqCotS0zAqwKdGxtbUA79O781U
 AAAA=
To: Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Running qemu-system-aarch64 -M virt -nographic and terminating it will
result in a LeakSanitizer error due to remaining queued CPU work so
free it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/core/cpu.h |  6 ++++++
 cpu-common.c          | 11 +++++++++++
 hw/core/cpu-common.c  |  1 +
 3 files changed, 18 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943f7..8e6466c1ddab 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1000,6 +1000,12 @@ void cpu_resume(CPUState *cpu);
  */
 void cpu_remove_sync(CPUState *cpu);
 
+/**
+ * free_queued_cpu_work() - free all items on CPU work queue
+ * @cpu: The CPU which work queue to free.
+ */
+void free_queued_cpu_work(CPUState *cpu);
+
 /**
  * process_queued_cpu_work() - process all items on CPU work queue
  * @cpu: The CPU which work queue to process.
diff --git a/cpu-common.c b/cpu-common.c
index ce78273af597..7ae136f98ca7 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -331,6 +331,17 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
+void free_queued_cpu_work(CPUState *cpu)
+{
+    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
+        struct qemu_work_item *wi = QSIMPLEQ_FIRST(&cpu->work_list);
+        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
+        if (wi->free) {
+            g_free(wi);
+        }
+    }
+}
+
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index b19e1fdacf22..d2e3e4570ab7 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -281,6 +281,7 @@ static void cpu_common_finalize(Object *obj)
         g_free(cpu->plugin_state);
     }
 #endif
+    free_queued_cpu_work(cpu);
     g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);

---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240714-cpu-c4d28823b4c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


